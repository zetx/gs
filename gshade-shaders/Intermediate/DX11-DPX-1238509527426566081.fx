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
float GetAspectRatio() { return 3440 * (1.0 / 1440); }
float2 GetPixelSize() { return float2((1.0 / 3440), (1.0 / 1440)); }
float2 GetScreenSize() { return float2(3440, 1440); }
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
#line 76
return lerp(input, c0, Strength);
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

