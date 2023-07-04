#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Vignette.fx"
#line 10
uniform int Type <
ui_type = "combo";
ui_items = "Original\0New\0TV style\0Untitled 1\0Untitled 2\0Untitled 3\0Untitled 4\0";
> = 0;
uniform float Ratio <
ui_type = "slider";
ui_min = 0.15; ui_max = 6.0;
ui_tooltip = "Sets a width to height ratio. 1.00 (1/1) is perfectly round, while 1.60 (16/10) is 60 % wider than it's high.";
> = 1.0;
uniform float Radius <
ui_type = "slider";
ui_min = -1.0; ui_max = 3.0;
ui_tooltip = "lower values = stronger radial effect from center";
> = 2.0;
uniform float Amount <
ui_type = "slider";
ui_min = -2.0; ui_max = 1.0;
ui_tooltip = "Strength of black. -2.00 = Max Black, 1.00 = Max White.";
> = -1.0;
uniform int Slope <
ui_type = "slider";
ui_min = 2; ui_max = 16;
ui_tooltip = "How far away from the center the change should start to really grow strong (odd numbers cause a larger fps drop than even numbers).";
> = 2;
uniform float2 Center <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Center of effect for 'Original' vignette type. 'New' and 'TV style' do not obey this setting.";
> = float2(0.5, 0.5);
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1500 * (1.0 / 1004); }
float2 GetPixelSize() { return float2((1.0 / 1500), (1.0 / 1004)); }
float2 GetScreenSize() { return float2(1500, 1004); }
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
#line 40 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Vignette.fx"
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
#line 42 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Vignette.fx"
#line 45
float4 VignettePass(float4 vpos : SV_Position, float2 tex : TexCoord) : SV_Target
{
float4 color = tex2D(ReShade::BackBuffer, tex);
#line 49
if (Type == 0)
{
#line 52
float2 distance_xy = tex - Center;
#line 55
distance_xy *= float2(((1.0 / 1004) / (1.0 / 1500)), Ratio);
#line 58
distance_xy /= Radius;
const float distance = dot(distance_xy, distance_xy);
#line 62
color.rgb *= (1.0 + pow(distance, Slope * 0.5) * Amount); 
}
#line 65
if (Type == 1) 
{
tex = -tex * tex + tex;
color.rgb = saturate((((1.0 / 1004) / (1.0 / 1500))*((1.0 / 1004) / (1.0 / 1500)) * Ratio * tex.x + tex.y) * 4.0) * color.rgb;
}
#line 71
if (Type == 2) 
{
tex = -tex * tex + tex;
color.rgb = saturate(tex.x * tex.y * 100.0) * color.rgb;
}
#line 77
if (Type == 3)
{
tex = abs(tex - 0.5);
float tc = dot(float4(-tex.x, -tex.x, tex.x, tex.y), float4(tex.y, tex.y, 1.0, 1.0)); 
#line 82
tc = saturate(tc - 0.495);
color.rgb *= (pow((1.0 - tc * 200), 4) + 0.25); 
}
#line 86
if (Type == 4)
{
tex = abs(tex - 0.5);
float tc = dot(float4(-tex.x, -tex.x, tex.x, tex.y), float4(tex.y, tex.y, 1.0, 1.0)); 
#line 91
tc = saturate(tc - 0.495) - 0.0002;
color.rgb *= (pow((1.0 - tc * 200), 4) + 0.0); 
}
#line 95
if (Type == 5) 
{
tex = abs(tex - 0.5);
float tc = tex.x * (-2.0 * tex.y + 1.0) + tex.y; 
#line 100
tc = saturate(tc - 0.495);
color.rgb *= (pow((-tc * 200 + 1.0), 4) + 0.25); 
#line 103
}
#line 105
if (Type == 6) 
{
#line 108
const float tex_xy = dot(float4(tex, tex), float4(-tex, 1.0, 1.0)); 
color.rgb = saturate(tex_xy * 4.0) * color.rgb;
}
#line 112
return color += TriDither(color.rgb, tex, 8);
#line 116
}
#line 118
technique Vignette
{
pass
{
VertexShader = PostProcessVS;
PixelShader = VignettePass;
}
}

