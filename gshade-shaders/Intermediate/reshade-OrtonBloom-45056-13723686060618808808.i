#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\OrtonBloom.fx"
#line 6
uniform bool GammaCorrectionEnable <
ui_label = "Enable Gamma Correction";
toggle = true;
> = true;
uniform float BlurMulti <
ui_label = "Blur Multiplier";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Blur strength";
> = 1.0;
uniform int BlackPoint <
ui_type = "slider";
ui_min = 0; ui_max = 255;
ui_tooltip = "The new black point for blur texture. Everything darker than this becomes completely black.";
> = 60;
uniform int WhitePoint <
ui_type = "slider";
ui_min = 0; ui_max = 255;
ui_tooltip = "The new white point for blur texture. Everything brighter than this becomes completely white.";
> = 150;
uniform float MidTonesShift <
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "Adjust midtones for blur texture.";
> = -0.84;
uniform float BlendStrength <
ui_label = "Blend Strength";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.0;
ui_tooltip = "Opacity of blur texture. Keep this value low, or image will get REALLY blown out.";
> = 0.07;
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
#line 38 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\OrtonBloom.fx"
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
#line 41 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\OrtonBloom.fx"
#line 44
texture OrtonGaussianBlurTex { Width = 5360 / (1 +  1	); Height = 1440 / (1 +  1	); Format = RGBA8; };
sampler OrtonGaussianBlurSampler { Texture = OrtonGaussianBlurTex; };
#line 47
texture OrtonGaussianBlurTex2 { Width = 5360 / (1 +  1	); Height = 1440 / (1 +  1	); Format = RGBA8; };
sampler OrtonGaussianBlurSampler2 { Texture = OrtonGaussianBlurTex2; };
#line 50
float CalcLuma(float3 color)
{
if (GammaCorrectionEnable)
return pow(abs((color.r*2 + color.b + color.g*3) / 6), 1/2.2);
#line 55
return (color.r*2 + color.b + color.g*3) / 6;
}
#line 58
float3 GaussianBlur1(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : SV_Target
{
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
const float blurPower = CalcLuma(color);
#line 63
const float offset[18] = { 0.0, 1.4953705027, 3.4891992113, 5.4830312105, 7.4768683759, 9.4707125766, 11.4645656736, 13.4584295168, 15.4523059431, 17.4461967743, 19.4661974725, 21.4627427973, 23.4592916956, 25.455844494, 27.4524015179, 29.4489630909, 31.445529535, 33.4421011704 };
const float weight[18] = { 0.033245, 0.0659162217, 0.0636705814, 0.0598194658, 0.0546642566, 0.0485871646, 0.0420045997, 0.0353207015, 0.0288880982, 0.0229808311, 0.0177815511, 0.013382297, 0.0097960001, 0.0069746748, 0.0048301008, 0.0032534598, 0.0021315311, 0.0013582974 };
#line 66
color *= weight[0];
#line 68
[loop]
for(int i = 1; i < 18; ++i)
{
color += tex2D(ReShade::BackBuffer, texcoord + float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * blurPower * BlurMulti).rgb * weight[i];
color += tex2D(ReShade::BackBuffer, texcoord - float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * blurPower * BlurMulti).rgb * weight[i];
}
#line 75
return saturate(color);
}
#line 78
float3 GaussianBlur2(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : SV_Target
{
float3 color = tex2D(OrtonGaussianBlurSampler, texcoord).rgb;
const float blurPower = CalcLuma(color);
#line 83
const float offset[18] = { 0.0, 1.4953705027, 3.4891992113, 5.4830312105, 7.4768683759, 9.4707125766, 11.4645656736, 13.4584295168, 15.4523059431, 17.4461967743, 19.4661974725, 21.4627427973, 23.4592916956, 25.455844494, 27.4524015179, 29.4489630909, 31.445529535, 33.4421011704 };
const float weight[18] = { 0.033245, 0.0659162217, 0.0636705814, 0.0598194658, 0.0546642566, 0.0485871646, 0.0420045997, 0.0353207015, 0.0288880982, 0.0229808311, 0.0177815511, 0.013382297, 0.0097960001, 0.0069746748, 0.0048301008, 0.0032534598, 0.0021315311, 0.0013582974 };
#line 86
color *= weight[0];
#line 88
[loop]
for(int i = 1; i < 18; ++i)
{
color += tex2D(OrtonGaussianBlurSampler, texcoord + float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * blurPower * BlurMulti).rgb * weight[i];
color += tex2D(OrtonGaussianBlurSampler, texcoord - float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * blurPower * BlurMulti).rgb * weight[i];
}
#line 95
return saturate(color);
}
#line 98
float3 LevelsAndBlend(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float black_point_float = BlackPoint / 255.0;
#line 102
float white_point_float;
if (WhitePoint == BlackPoint) 
white_point_float = 255.0 / 0.00025;
else
white_point_float = 255.0 / (WhitePoint - BlackPoint);
#line 108
float mid_point_float = (white_point_float + black_point_float) / 2.0 + MidTonesShift;
if (mid_point_float > white_point_float)
mid_point_float = white_point_float;
else if (mid_point_float < black_point_float)
mid_point_float = black_point_float;
#line 114
const float3 original = tex2D(ReShade::BackBuffer, texcoord).rgb;
const float3 color = (tex2D(OrtonGaussianBlurSampler2, texcoord).rgb * white_point_float - (black_point_float * white_point_float)) * mid_point_float;
#line 118
const float3 outcolor = saturate(max(0.0, max(original, lerp(original, (1 - (1 - saturate(color)) * (1 - saturate(color))), BlendStrength))));
return outcolor + TriDither(outcolor, texcoord, 8);
#line 123
}
#line 125
technique OrtonBloom
{
pass GaussianBlur1
{
VertexShader = PostProcessVS;
PixelShader = GaussianBlur1;
RenderTarget = OrtonGaussianBlurTex;
}
pass GaussianBlur2
{
VertexShader = PostProcessVS;
PixelShader = GaussianBlur2;
RenderTarget = OrtonGaussianBlurTex2;
}
pass LevelsAndBlend
{
VertexShader = PostProcessVS;
PixelShader = LevelsAndBlend;
}
}

