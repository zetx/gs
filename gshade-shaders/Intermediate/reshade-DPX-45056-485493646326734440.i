#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DPX.fx"
#line 6
uniform float3 RGB_Curve <
ui_type = "slider";
ui_min = 1.0; ui_max = 15.0;
ui_label = "RGB Curve";
> = float3(8.0, 8.0, 8.0);
uniform float3 RGB_C <
ui_type = "slider";
ui_min = 0.2; ui_max = 0.5;
ui_label = "RGB C";
> = float3(0.36, 0.36, 0.34);
#line 17
uniform float Contrast <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.1;
uniform float Saturation <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
> = 3.0;
uniform float Colorfulness <
ui_type = "slider";
ui_min = 0.1; ui_max = 2.5;
> = 2.5;
#line 30
uniform float Strength <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Adjust the strength of the effect.";
> = 0.20;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 5360 * (1.0 / 1440); }
float2 GetPixelSize() { return float2((1.0 / 5360), (1.0 / 1440)); }
float2 GetScreenSize() { return float2(5360, 1440); }
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
#line 36 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DPX.fx"
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
#line 39 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DPX.fx"
#line 42
static const float3x3 RGB = float3x3(
2.6714711726599600, -1.2672360578624100, -0.4109956021722270,
-1.0251070293466400,  1.9840911624108900,  0.0439502493584124,
0.0610009456429445, -0.2236707508128630,  1.1590210416706100
);
static const float3x3 XYZ = float3x3(
0.5003033835433160,  0.3380975732227390,  0.1645897795458570,
0.2579688942747580,  0.6761952591447060,  0.0658358459823868,
0.0234517888692628,  0.1126992737203000,  0.8668396731242010
);
#line 53
float3 DPXPass(float4 vois : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 input = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 57
float3 B = input;
B = B * (1.0 - Contrast) + (0.5 * Contrast);
const float3 Btemp = (1.0 / (1.0 + exp(RGB_Curve / 2.0)));
B = ((1.0 / (1.0 + exp(-RGB_Curve * (B - RGB_C)))) / (-2.0 * Btemp + 1.0)) + (-Btemp / (-2.0 * Btemp + 1.0));
#line 62
const float value = max(max(B.r, B.g), B.b);
float3 color = B / value;
color = pow(abs(color), 1.0 / Colorfulness);
#line 66
float3 c0 = color * value;
c0 = mul(XYZ, c0);
const float luma = dot(c0, float3(0.30, 0.59, 0.11));
c0 = (1.0 - Saturation) * luma + Saturation * c0;
c0 = mul(RGB, c0);
#line 73
c0 = lerp(input, c0, Strength);
return c0 + TriDither(c0, texcoord, 8);
#line 78
}
#line 80
technique DPX
{
pass
{
VertexShader = PostProcessVS;
PixelShader = DPXPass;
}
}

