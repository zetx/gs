#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HDR.fx"
#line 11
uniform float HDRPower <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Power";
> = 1.30;
uniform float radius1 <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Radius 1";
> = 0.793;
uniform float radius2 <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Radius 2";
ui_tooltip = "Raising this seems to make the effect stronger and also brighter.";
> = 0.87;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1024 * (1.0 / 768); }
float2 GetPixelSize() { return float2((1.0 / 1024), (1.0 / 768)); }
float2 GetScreenSize() { return float2(1024, 768); }
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
#line 28 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HDR.fx"
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
#line 31 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HDR.fx"
#line 34
float3 HDRPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 38
float3 bloom_sum1 = tex2D(ReShade::BackBuffer, texcoord + float2(1.5, -1.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2(-1.5, -1.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2( 1.5,  1.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2(-1.5,  1.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2( 0.0, -2.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2( 0.0,  2.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2(-2.5,  0.0) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2( 2.5,  0.0) * radius1).rgb;
#line 47
bloom_sum1 *= 0.005;
#line 49
float3 bloom_sum2 = tex2D(ReShade::BackBuffer, texcoord + float2(1.5, -1.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2(-1.5, -1.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2( 1.5,  1.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2(-1.5,  1.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2( 0.0, -2.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2( 0.0,  2.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2(-2.5,  0.0) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2( 2.5,  0.0) * radius2).rgb;
#line 58
bloom_sum2 *= 0.010;
#line 60
const float dist = radius2 - radius1;
const float3 HDR = (color + (bloom_sum2 - bloom_sum1)) * dist;
const float3 blend = HDR + color;
#line 66
const float3 outcolor = saturate(pow(abs(blend), HDRPower) + HDR);
return outcolor + TriDither(outcolor, texcoord, 8);
#line 71
}
#line 73
technique HDR
{
pass
{
VertexShader = PostProcessVS;
PixelShader = HDRPass;
}
}

