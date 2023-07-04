#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicGrade.fx"
#line 16
uniform int Coefficients <
ui_tooltip = "For digital video signal (HDMI, DVI, Display Port) use BT.709,\n"
"for analog (like VGA, S-Video) use BT.601";
ui_label = "YUV coefficients";
ui_type = "combo";
ui_items = "BT.709 - digital\0BT.601 - analog\0";
> = 0;
#line 24
uniform float2 LightControl <
ui_label = "Shadow-Lights";
ui_tooltip = "Luma low - highs";
ui_type = "slider";
ui_step = 0.002;
ui_min = -1.0; ui_max = 1.0;
> = float2(0.0, 0.0);
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
#line 37 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicGrade.fx"
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
#line 40 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicGrade.fx"
#line 44
static const float3x3 ToYUV709 =
float3x3(
float3(0.2126, 0.7152, 0.0722),
float3(-0.09991, -0.33609, 0.436),
float3(0.615, -0.55861, -0.05639)
);
#line 51
static const float3x3 ToYUV601 =
float3x3(
float3(0.299, 0.587, 0.114),
float3(-0.14713, -0.28886, 0.436),
float3(0.615, -0.51499, -0.10001)
);
#line 58
static const float3x3 ToRGB709 =
float3x3(
float3(1, 0, 1.28033),
float3(1, -0.21482, -0.38059),
float3(1, 2.12798, 0)
);
#line 65
static const float3x3 ToRGB601 =
float3x3(
float3(1, 0, 1.13983),
float3(1, -0.39465, -0.58060),
float3(1, 2.03211, 0)
);
static const float2 MaxUV = float2(0.492, 0.877);
#line 74
float Overlay(float LayerAB)
{
const float MinAB = min(LayerAB, 0.5);
const float MaxAB = max(LayerAB, 0.5);
return 2 * (MinAB * MinAB + MaxAB + MaxAB - MaxAB * MaxAB) - 1.5;
}
#line 82
float SuperGrade(float2 Controls, float Input)
{
#line 85
float2 Grade = Overlay(Input);
Grade.x = min(Grade.x, 0.5);
Grade.y = max(Grade.y, 0.5) - 0.5;
Grade.x = lerp(min(Input, 0.5), Grade.x, -Controls.x);
Grade.y = lerp(max(0.5, Input) - 0.5, Grade.y * (0.5 - Grade.y), -Controls.y);
#line 91
return Grade.x + Grade.y;
}
#line 95
void FilmicGradePS(float4 vois : SV_Position, float2 texcoord : TexCoord, out float3 Display : SV_Target)
{
if ( Coefficients==1 )
{
#line 100
Display = mul(ToYUV709, tex2D(ReShade::BackBuffer, texcoord).rgb);
#line 102
Display.x = SuperGrade(LightControl, Display.x);
#line 104
Display = mul(ToRGB709, Display);
}
else
{
#line 109
Display = mul(ToYUV601, tex2D(ReShade::BackBuffer, texcoord).rgb);
#line 111
Display.x = SuperGrade(LightControl, Display.x);
#line 113
Display = mul(ToRGB601, Display);
}
#line 117
Display += TriDither(Display, texcoord, 8);
#line 119
}
#line 126
technique FilmicGrade < ui_label = "Filmic Grade"; >
{
pass
{
VertexShader = PostProcessVS;
PixelShader = FilmicGradePS;
}
}

