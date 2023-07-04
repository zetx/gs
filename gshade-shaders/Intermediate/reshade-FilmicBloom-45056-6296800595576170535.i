#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicBloom.fx"
#line 23
uniform float BlurRadius <
ui_type = "slider";
ui_label = "Blur radius";
ui_min = 0.0; ui_max = 32.0; ui_step = 0.2;
> = 6.0;
#line 29
uniform int BlurSamples <
ui_type = "slider";
ui_label = "Blur samples";
ui_min = 2; ui_max = 32;
> = 6;
#line 43
float get_weight(float progress)
{
float bottom = min(progress, 0.5);
float top = max(progress, 0.5);
return 2.0 *(bottom*bottom +top +top -top*top) -1.5;
}
#line 50
float get_2D_weight(float2 position)
{ return get_weight( min(length(position), 1.0) ); }
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1281 * (1.0 / 721); }
float2 GetPixelSize() { return float2((1.0 / 1281), (1.0 / 721)); }
float2 GetScreenSize() { return float2(1281, 721); }
#line 60
texture BackBufferTex : COLOR;
texture DepthBufferTex : DEPTH;
#line 63
sampler BackBuffer { Texture = BackBufferTex; };
sampler DepthBuffer { Texture = DepthBufferTex; };
#line 67
float GetLinearizedDepth(float2 texcoord)
{
#line 72
texcoord.x /=  1;
texcoord.y /=  1;
#line 77
texcoord.x -=  0 / 2.000000001;
#line 82
texcoord.y +=  0 / 2.000000001;
#line 84
float depth = tex2Dlod(DepthBuffer, float4(texcoord, 0, 0)).x *  1;
#line 93
const float N = 1.0;
depth /= 1000.0 - depth * (1000.0 - N);
#line 96
return depth;
}
}
#line 101
void PostProcessVS(in uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD)
{
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
#line 108
if (id == 1)
texcoord.y = 2.0;
else
texcoord.y = 0.0;
#line 113
position = float4(texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 58 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicBloom.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\TriDither.fxh"
#line 31
uniform float DitherTimer < source = "timer"; >;
#line 34
float rand21(float2 uv)
{
const float2 noise = frac(sin(dot(uv, float2(12.9898, 78.233) * 2.0)) * 43758.5453);
return (noise.x + noise.y) * 0.5;
}
#line 40
float rand11(float x)
{
return frac(x * 0.024390243);
}
#line 45
float permute(float x)
{
return ((34.0 * x + 1.0) * x) % 289.0;
}
#line 50
float3 TriDither(float3 color, float2 uv, int bits)
{
const float bitstep = exp2(bits) - 1.0;
#line 54
const float3 m = float3(uv, rand21(uv + (DitherTimer * 0.001))) + 1.0;
float h = permute(permute(permute(m.x) + m.y) + m.z);
#line 57
float3 noise1, noise2;
noise1.x = rand11(h);
h = permute(h);
#line 61
noise2.x = rand11(h);
h = permute(h);
#line 64
noise1.y = rand11(h);
h = permute(h);
#line 67
noise2.y = rand11(h);
h = permute(h);
#line 70
noise1.z = rand11(h);
h = permute(h);
#line 73
noise2.z = rand11(h);
#line 75
return lerp(noise1 - 0.5, noise1 - noise2, min(saturate( (((color.xyz) - (0.0)) / ((0.5 / bitstep) - (0.0)))), saturate( (((color.xyz) - (1.0)) / (((bitstep - 0.5) / bitstep) - (1.0)))))) * (1.0 / bitstep);
}
#line 61 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicBloom.fx"
#line 64
void FilmicBloomPS(float4 vpos : SV_Position, float2 tex_coord : TEXCOORD, out float3 softened : SV_Target)
{
softened = 0.0;
#line 68
float total_weight = 0.0;
#line 70
for(int y=0; y<BlurSamples; y++)
for(int x=0; x<BlurSamples; x++)
{
float2 current_position = float2(x,y)/BlurSamples;
#line 75
float current_weight = get_2D_weight(1.0-current_position);
#line 77
float2 current_offset =  float2((1.0 / 1281), (1.0 / 721))*BlurRadius*current_position*(1.0-current_weight);
#line 79
total_weight += current_weight;
#line 81
softened += (
tex2Dlod(ReShade::BackBuffer, float4(tex_coord+current_offset, 0.0, 0.0) ).rgb+
tex2Dlod(ReShade::BackBuffer, float4(tex_coord-current_offset, 0.0, 0.0) ).rgb+
tex2Dlod(ReShade::BackBuffer, float4(tex_coord+float2(current_offset.x, -current_offset.y), 0.0, 0.0) ).rgb+
tex2Dlod(ReShade::BackBuffer, float4(tex_coord-float2(current_offset.x, -current_offset.y), 0.0, 0.0) ).rgb
) *current_weight;
}
softened /= total_weight*4.0;
#line 91
softened += TriDither(softened, tex_coord, 8);
#line 93
}
#line 99
technique FilmicBloom
<
ui_label = "Filmic Bloom";
ui_tooltip = "Simulates organic look of film to digital content";
>
{
pass
{
VertexShader = PostProcessVS;
PixelShader = FilmicBloomPS;
}
}

