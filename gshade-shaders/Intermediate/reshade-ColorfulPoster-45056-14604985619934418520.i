#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorfulPoster.fx"
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
#line 38 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorfulPoster.fx"
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
#line 41 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorfulPoster.fx"
#line 53
uniform float iUILumaLevels <
ui_type = "slider";
ui_category =  "Posterization";
ui_label = "Luma Posterize Levels";
ui_min = 1.0; ui_max = 20.0;
> = 16.0;
#line 60
uniform int iUIStepType <
ui_type = "combo";
ui_category =  "Posterization";
ui_label = "Curve Type";
ui_items = "Linear\0Smoothstep\0Logistic\0Sigmoid\0";
> = 2;
#line 67
uniform float fUIStepContinuity <
ui_type = "slider";
ui_category =  "Posterization";
ui_label = "Continuity";
ui_tooltip = "Broken up <-> Connected";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.01;
> = 1.0;
#line 76
uniform float fUISlope <
ui_type = "slider";
ui_category =  "Posterization";
ui_label = "Slope Logistic Curve";
ui_min = 0.0; ui_max = 40.0;
ui_step = 0.1;
> = 13.0;
#line 84
uniform bool iUIDebugOverlayPosterizeLevels <
ui_category =  "Posterization";
ui_label = "Show Posterization as Curve (Magenta)";
> = 0;
#line 91
uniform float fUITint <
ui_type = "slider";
ui_category =  "Color";
ui_label = "Tint Strength";
ui_min = 0.0; ui_max = 1.0;
> = 1.0;
#line 100
uniform float fUIStrength <
ui_type = "slider";
ui_category =  "Effect";
ui_label = "Strength";
ui_min = 0.0; ui_max = 1.0;
> = 1.0;
#line 113
float Posterize(float x, int numLevels, float continuity, float slope, int type) {
const float stepheight = 1.0 / numLevels;
const float stepnum = floor(x * numLevels);
const float frc = frac(x * numLevels);
const float step1 = floor(frc) * stepheight;
float step2;
#line 120
if(type == 1)
step2 = smoothstep(0.0, 1.0, frc) * stepheight;
else if(type == 2)
step2 = (1.0 / (1.0 + exp(-slope*(frc - 0.5)))) * stepheight;
else if(type == 3)
{
if (frc < 0.5)
step2 = (pow(frc, slope) * pow(2.0, slope) * 0.5) * stepheight;
else
step2 = (1.0 - pow(1.0 - frc, slope) * pow(2.0, slope) * 0.5) * stepheight;
}
else
step2 = frc * stepheight;
#line 134
return lerp(step1, step2, continuity) + stepheight * stepnum;
}
#line 137
float4 RGBtoCMYK(float3 color) {
const float K = 1.0 - max(color.r, max(color.g, color.b));
const float3 CMY = (1.0 - color - K) / (1.0 - K);
return float4(CMY, K);
}
#line 143
float3 CMYKtoRGB(float4 cmyk) {
return (1.0.xxx - cmyk.xyz) * (1.0 - cmyk.w);
}
#line 147
float3 DrawDebugCurve(float3 background, float2 texcoord, float value, float3 color, float curveDiv) {
const float p = exp(-(1440/curveDiv) * length(texcoord - float2(texcoord.x, 1.0 - value)));
return lerp(background, color, saturate(p));
}
#line 155
float3 ColorfulPoster_PS(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target {
static const float3 LumaCoeff = float3(0.2126, 0.7151, 0.0721);
#line 160
const float3 backbuffer = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 165
const float luma = dot(backbuffer, LumaCoeff);
const float3 chroma = backbuffer - luma;
const float3 lumaPoster = Posterize(luma, iUILumaLevels, fUIStepContinuity, fUISlope, iUIStepType).rrr;
#line 172
float3 mask, image, colorLayer;
#line 175
float4 backbufferCMYK = RGBtoCMYK(backbuffer);
backbufferCMYK.xyz += float3(0.2, -0.1, -0.2);
backbufferCMYK.w = 0.0;
#line 180
const mask = CMYKtoRGB(saturate(backbufferCMYK));
#line 183
const image = chroma + lumaPoster;
#line 186
colorLayer = lerp(2*image*mask, 1.0 - 2.0 * (1.0 - image) * (1.0 - mask), step(0.5, luma.r));
colorLayer = lerp(image, colorLayer, fUITint);
#line 192
float3 result = lerp(backbuffer, colorLayer, fUIStrength);
#line 194
if(iUIDebugOverlayPosterizeLevels == 1) {
const float value = Posterize(texcoord.x, iUILumaLevels, fUIStepContinuity, fUISlope, iUIStepType);
result = DrawDebugCurve(result, texcoord, value, float3(1.0, 0.0, 1.0), 1.0);
}
#line 203
return result + TriDither(result, texcoord, 8);
#line 207
}
#line 209
technique ColorfulPoster
{
pass {
VertexShader = PostProcessVS;
PixelShader = ColorfulPoster_PS;
}
}

