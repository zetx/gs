#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\UnrealLens.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersCommon.fxh"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersMath.fxh"
#line 3
namespace FXShaders
{
#line 68
static const float Pi = 3.14159;
#line 73
static const float DegreesToRadians = Pi / 180.0;
#line 78
static const float RadiansToDegrees = 180.0 / Pi;
#line 87
float2 GetOffsetByAngleDistance(float2 pos, float angle, float distance)
{
float2 cosSin;
sincos(angle, cosSin.y, cosSin.x);
#line 92
return mad(distance, cosSin, pos);
}
#line 102
float2 GetDirectionFromAngleMagnitude(float angle, float magnitude)
{
return GetOffsetByAngleDistance(0.0, angle, magnitude);
}
#line 114
float2 ClampMagnitude(float2 v, float2 minMax) {
if (v.x == 0.0 && v.y == 0.0)
{
return 0.0;
}
else
{
const float mag = length(v);
if (mag < minMax.x)
return 0.0;
else
return (v / mag) * min(mag, minMax.y);
}
}
#line 136
float2 RotatePoint(float2 uv, float angle, float2 pivot)
{
float2 sc;
sincos(DegreesToRadians * angle, sc.x, sc.y);
#line 141
uv -= pivot;
uv = uv.x * sc.yx + float2(-uv.y, uv.y) * sc;
uv += pivot;
#line 145
return uv;
}
#line 148
}
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersCommon.fxh"
#line 11
namespace FXShaders
{
#line 18
static const float FloatEpsilon = 0.001;
#line 125
float2 GetResolution()
{
return float2(5360, 1440);
}
#line 133
float2 GetPixelSize()
{
return float2((1.0 / 5360), (1.0 / 1440));
}
#line 141
float GetAspectRatio()
{
return 5360 * (1.0 / 1440);
}
#line 149
float4 GetScreenParams()
{
return float4(GetResolution(), GetPixelSize());
}
#line 165
float2 ScaleCoord(float2 uv, float2 scale, float2 pivot)
{
return (uv - pivot) * scale + pivot;
}
#line 178
float2 ScaleCoord(float2 uv, float2 scale)
{
return ScaleCoord(uv, scale, 0.5);
}
#line 188
float GetLumaGamma(float3 color)
{
return dot(color, float3(0.299, 0.587, 0.114));
}
#line 199
float GetLumaLinear(float3 color)
{
return dot(color, float3(0.2126, 0.7152, 0.0722));
}
#line 212
float3 checkered_pattern(float2 uv, float size, float color_a, float color_b)
{
const float cSize = 32.0;
const float3 cColorA = pow(0.15, 2.2);
const float3 cColorB = pow(0.5, 2.2);
#line 218
uv *= GetResolution();
uv %= cSize;
#line 221
const float half_size = cSize * 0.5;
const float checkered = step(uv.x, half_size) == step(uv.y, half_size);
return (cColorA * checkered) + (cColorB * (1.0 - checkered));
}
#line 232
float3 checkered_pattern(float2 uv)
{
const float Size = 32.0;
const float ColorA = pow(0.15, 2.2);
const float ColorB = pow(0.5, 2.2);
#line 238
return checkered_pattern(uv, Size, ColorA, ColorB);
}
#line 251
float3 ApplySaturation(float3 color, float amount)
{
const float gray = GetLumaLinear(color);
return gray + (color - gray) * amount;
}
#line 262
float GetRandom(float2 uv)
{
#line 267
const float A = 23.2345;
const float B = 84.1234;
const float C = 56758.9482;
#line 271
return frac(sin(dot(uv, float2(A, B))) * C);
}
#line 281
void ScreenVS(
uint id : SV_VERTEXID,
out float4 pos : SV_POSITION,
out float2 uv : TEXCOORD)
{
if (id == 2)
uv.x = 2.0;
else
uv.x = 0.0;
#line 291
if (id == 1)
uv.y = 2.0;
else
uv.y = 0.0;
#line 296
pos = float4(uv * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 307
float2 CorrectAspectRatio(float2 uv, float a, float b)
{
if (a > b)
{
#line 313
return ScaleCoord(uv, float2(1.0 / a, 1.0));
}
else
{
#line 319
return ScaleCoord(uv, float2(1.0, 1.0 / b));
}
}
#line 323
} 
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\UnrealLens.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersConvolution.fxh"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersMath.fxh"
#line 3 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersConvolution.fxh"
#line 5
namespace FXShaders
{
#line 18
float NormalDistribution(float x, float u, float o)
{
o *= o;
#line 22
const float b = ((x - u) * (x - u)) / 2.0 * o;
#line 24
return (1.0 / sqrt(2.0 * Pi * o)) * exp(-(b));
}
#line 35
float Gaussian1D(float x, float o)
{
o *= o;
const float b = (x * x) / (2.0 * o);
return  (1.0 / sqrt(2.0 * Pi * o)) * exp(-b);
}
#line 51
float Gaussian1DFast(float x, float o)
{
#line 55
return exp(-(x * x) / (2.0 * o * o));
}
#line 66
float Gaussian2D(float2 i, float o)
{
o *= o;
const float b = (i.x * i.x + i.y * i.y) / (2.0 * o);
return (1.0 / (2.0 * Pi * o)) * exp(-b);
}
#line 86
float4 GaussianBlur1D(
sampler sp,
float2 uv,
float2 dir,
float sigma,
int samples)
{
const float halfSamples = (samples - 1) * 0.5;
#line 95
float4 color = 0.0;
float accum = 0.0;
#line 98
uv -= halfSamples * dir;
#line 100
[unroll]
for (int i = 0; i < samples; ++i)
{
float weight = Gaussian1DFast(i - halfSamples, sigma);
#line 105
color += tex2D(sp, uv) * weight;
accum += weight;
#line 108
uv += dir;
}
#line 111
return color / accum;
}
#line 127
float4 GaussianBlur2D(
sampler sp,
float2 uv,
float2 scale,
float sigma,
int2 samples)
{
const float2 halfSamples = samples * 0.5;
#line 136
float4 color = 0.0;
float accum = 0.0;
#line 139
uv -= halfSamples * scale;
#line 141
[unroll]
for (int x = 0; x < samples.x; ++x)
{
float initX = uv.x;
#line 146
[unroll]
for (int y = 0; y < samples.y; ++y)
{
float2 pos = float2(x, y);
float weight = Gaussian2D(abs(pos - halfSamples), sigma);
#line 152
color += tex2D(sp, uv) * weight;
accum += weight;
#line 155
uv.x += scale.x;
}
#line 158
uv.x = initX;
uv.y += scale.y;
}
#line 162
return color / accum;
}
#line 165
float4 LinearBlur1D(sampler sp, float2 uv, float2 dir, int samples)
{
const float halfSamples = (samples - 1) * 0.5;
uv -= halfSamples * dir;
#line 170
float4 color = 0.0;
#line 172
[unroll]
for (int i = 0; i < samples; ++i)
{
color += tex2D(sp, uv);
uv += dir;
}
#line 179
return color / samples;
}
#line 182
float4 MaxBlur1D(sampler sp, float2 uv, float2 dir, int samples)
{
const float halfSamples = (samples - 1) * 0.5;
uv -= halfSamples * dir;
#line 187
float4 color = 0.0;
#line 189
[unroll]
for (int i = 0; i < samples; ++i)
{
color = max(color, tex2D(sp, uv));
uv += dir;
}
#line 196
return color;
}
#line 199
float4 SharpBlur1D(sampler sp, float2 uv, float2 dir, int samples, float sharpness)
{
static const float halfSamples = (samples - 1) * 0.5;
static const float weight = 1.0 / samples;
#line 204
uv -= halfSamples * dir;
#line 206
float4 color = 0.0;
#line 208
[unroll]
for (int i = 0; i < samples; ++i)
{
float4 pixel = tex2D(sp, uv);
color = lerp(color + pixel * weight, max(color, pixel), sharpness);
uv += dir;
}
#line 216
return color;
}
#line 219
} 
#line 2 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\UnrealLens.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersMath.fxh"
#line 3 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\UnrealLens.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersTonemap.fxh"
#line 11
namespace FXShaders { namespace Tonemap
{
#line 14
namespace Type
{
static const int Reinhard = 0;
static const int Uncharted2Filmic = 1;
static const int BakingLabACES = 2;
static const int NarkowiczACES = 3;
static const int Unreal3 = 4;
static const int Lottes = 5;
}
#line 24
namespace Reinhard
{
#line 31
float3 Apply(float3 color)
{
return color / (1.0 + color);
}
#line 41
float3 Inverse(float3 color)
{
return -(color / min(color - 1.0, -0.1));
}
#line 55
float3 InverseOld(float3 color, float w)
{
return color / max(1.0 - color, w);
}
#line 69
float3 InverseOldLum(float3 color, float w)
{
const float lum = max(color.r, max(color.g, color.b));
return color * (lum / max(1.0 - lum, w));
}
}
#line 76
namespace Uncharted2Filmic
{
#line 79
static const float A = 0.15;
#line 82
static const float B = 0.50;
#line 85
static const float C = 0.10;
#line 88
static const float D = 0.20;
#line 91
static const float E = 0.02;
#line 94
static const float F = 0.30;
#line 96
float3 Apply(float3 color)
{
return (
(color * (A * color + C * B) + D * E) /
(color * (A * color + B) + D * F)
) - E / F;
}
#line 104
float3 Inverse(float3 color)
{
return abs(
((B * C * F - B * E - B * F * color) -
sqrt(
pow(abs(-B * C * F + B * E + B * F * color), 2.0) -
4.0 * D * (F * F) * color * (A * E + A * F * color - A * F))) /
(2.0 * A * (E + F * color - F)));
}
}
#line 115
namespace BakingLabACES
{
#line 118
static const float3x3 ACESInputMat = float3x3
(
0.59719, 0.35458, 0.04823,
0.07600, 0.90834, 0.01566,
0.02840, 0.13383, 0.83777
);
#line 126
static const float3x3 ACESOutputMat = float3x3
(
1.60475, -0.53108, -0.07367,
-0.10208,  1.10813, -0.00605,
-0.00327, -0.07276,  1.07602
);
#line 133
float3 RRTAndODTFit(float3 v)
{
return (v * (v + 0.0245786f) - 0.000090537f) / (v * (0.983729f * v + 0.4329510f) + 0.238081f);
}
#line 138
float3 ACESFitted(float3 color)
{
color = mul(ACESInputMat, color);
#line 143
color = RRTAndODTFit(color);
#line 145
color = mul(ACESOutputMat, color);
#line 148
color = saturate(color);
#line 150
return color;
}
#line 153
static const float A = 0.0245786;
static const float B = 0.000090537;
static const float C = 0.983729;
static const float D = 0.4329510;
static const float E = 0.238081;
#line 159
float3 Apply(float3 color)
{
return saturate(
(color * (color + A) - B) /
(color * (C * color + D) + E));
}
#line 166
float3 Inverse(float3 color)
{
return abs(
((A - D * color) -
sqrt(
pow(abs(D * color - A), 2.0) -
4.0 * (C * color - 1.0) * (B + E * color))) /
(2.0 * (C * color - 1.0)));
}
}
#line 177
namespace Lottes
{
float3 Apply(float3 color)
{
return color * rcp(max(color.r, max(color.g, color.b)) + 1.0);
}
#line 184
float3 Inverse(float3 color)
{
return color * rcp(max(1.0 - max(color.r, max(color.g, color.b)), 0.1));
}
}
#line 190
namespace NarkowiczACES
{
static const float A = 2.51;
static const float B = 0.03;
static const float C = 2.43;
static const float D = 0.59;
static const float E = 0.14;
#line 198
float3 Apply(float3 color)
{
return saturate(
(color * (A * color + B)) / (color * (C * color + D) + E));
}
#line 204
float3 Inverse(float3 color)
{
return
((D * color - B) +
sqrt(
4.0 * A * E * color + B * B -
2.0 * B * D * color -
4.0 * C * E * color * color +
D * D * color * color)) /
(2.0 * (A - C * color));
}
}
#line 217
namespace Unreal3
{
float3 Apply(float3 color)
{
return color / (color + 0.155) * 1.019;
}
#line 224
float3 Inverse(float3 color)
{
return (color * -0.155) / (max(color, 0.01) - 1.019);
}
}
#line 230
float3 Apply(int type, float3 color)
{
switch (type)
{
default:
case Type::Reinhard:
return Reinhard::Apply(color);
case Type::Uncharted2Filmic:
return Uncharted2Filmic::Apply(color);
case Type::BakingLabACES:
return BakingLabACES::Apply(color);
case Type::NarkowiczACES:
return NarkowiczACES::Apply(color);
case Type::Unreal3:
return Unreal3::Apply(color);
case Type::Lottes:
return Lottes::Apply(color);
}
}
#line 250
float3 Inverse(int type, float3 color)
{
switch (type)
{
default:
case Type::Reinhard:
return Reinhard::Inverse(color);
case Type::Uncharted2Filmic:
return Uncharted2Filmic::Inverse(color);
case Type::BakingLabACES:
return BakingLabACES::Inverse(color);
case Type::NarkowiczACES:
return NarkowiczACES::Inverse(color);
case Type::Unreal3:
return Unreal3::Inverse(color);
case Type::Lottes:
return Lottes::Inverse(color);
}
}
#line 270
}} 
#line 4 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\UnrealLens.fx"
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
#line 7 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\UnrealLens.fx"
#line 18
namespace FXShaders { namespace UnrealLens
{
#line 21
static const int BlurSamples =  9;
static const int Downscale =  4;
static const float BaseFlareDownscale = 4.0;
#line 25
  uniform int _WipWarn < ui_text = "This effect is currently a work in progress and as such some " "aspects may change in the future and some features may still be " "missing or incomplete.\n"; ui_label = " "; ui_type = "radio"; >;
#line 27
uniform float Brightness
<
ui_category = "Appearance";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.1;
#line 35
uniform float Saturation
<
ui_category = "Appearance";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.7;
#line 43
uniform float Threshold
<
ui_category = "Appearance";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.7;
#line 51
uniform float EdgesMasking
<
ui_category = "Appearance";
ui_label = "Edges Masking";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.3;
#line 60
uniform int Tonemapper
<
ui_category = "Appearance";
ui_type = "combo";
ui_items =  "Reinhard\0" "Uncharted 2 Filmic\0" "BakingLab ACES\0"  "Narkowicz ACES\0" "Unreal3\0" "Lottes\0";
> = Tonemap::Type::BakingLabACES;
#line 67
uniform float BokehAngle
<
ui_category = "Bokeh Blur";
ui_label = "Angle";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 15.0 / 60.0;
#line 76
uniform float BokehSize
<
ui_category = "Bokeh Blur";
ui_label = "Size";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 1.0;
#line 85
uniform float BokehDefinition
<
ui_category = "Bokeh Blur";
ui_label = "Definition";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.2;
#line 102
 uniform float4 Tint1 < ui_category = "Flares"; ui_label = "Tint " "1"; ui_type = "color"; > = float4(1.0, 1.0, 1.0, 1.0);
 uniform float4 Tint2 < ui_category = "Flares"; ui_label = "Tint " "2"; ui_type = "color"; > = float4(1.0, 1.0, 1.0, 1.0);
 uniform float4 Tint3 < ui_category = "Flares"; ui_label = "Tint " "3"; ui_type = "color"; > = float4(1.0, 1.0, 1.0, 1.0);
 uniform float4 Tint4 < ui_category = "Flares"; ui_label = "Tint " "4"; ui_type = "color"; > = float4(1.0, 1.0, 1.0, 1.0);
 uniform float4 Tint5 < ui_category = "Flares"; ui_label = "Tint " "5"; ui_type = "color"; > = float4(1.0, 1.0, 1.0, 1.0);
 uniform float4 Tint6 < ui_category = "Flares"; ui_label = "Tint " "6"; ui_type = "color"; > = float4(1.0, 1.0, 1.0, 0.0);
 uniform float4 Tint7 < ui_category = "Flares"; ui_label = "Tint " "7"; ui_type = "color"; > = float4(1.0, 1.0, 1.0, 0.0);
#line 122
 uniform float Scale1 < ui_category = "Flares"; ui_label = "Scale " "1"; ui_type = "slider"; ui_min = -1.0; ui_max = 1.0; > = 0.6;
 uniform float Scale2 < ui_category = "Flares"; ui_label = "Scale " "2"; ui_type = "slider"; ui_min = -1.0; ui_max = 1.0; > = 0.2;
 uniform float Scale3 < ui_category = "Flares"; ui_label = "Scale " "3"; ui_type = "slider"; ui_min = -1.0; ui_max = 1.0; > = 0.1;
 uniform float Scale4 < ui_category = "Flares"; ui_label = "Scale " "4"; ui_type = "slider"; ui_min = -1.0; ui_max = 1.0; > = 0.05;
 uniform float Scale5 < ui_category = "Flares"; ui_label = "Scale " "5"; ui_type = "slider"; ui_min = -1.0; ui_max = 1.0; > = -1.0;
 uniform float Scale6 < ui_category = "Flares"; ui_label = "Scale " "6"; ui_type = "slider"; ui_min = -1.0; ui_max = 1.0; > = -1.0;
 uniform float Scale7 < ui_category = "Flares"; ui_label = "Scale " "7"; ui_type = "slider"; ui_min = -1.0; ui_max = 1.0; > = -1.0;
#line 132
uniform bool ShowLens
<
ui_category = "Debug";
ui_category_closed = true;
ui_label = "Show Lens Flare Texture";
> = false;
#line 139
texture BackBufferTex : COLOR;
#line 141
sampler BackBuffer
{
Texture = BackBufferTex;
SRGBTexture = true;
AddressU = BORDER;
AddressV = BORDER;
};
#line 149
texture LensATex
{
Width = 5360 / Downscale;
Height = 1440 / Downscale;
Format = RGBA16F;
};
#line 156
sampler LensA
{
Texture = LensATex;
AddressU = BORDER;
AddressV = BORDER;
};
#line 163
texture LensBTex
{
Width = 5360 / Downscale;
Height = 1440 / Downscale;
Format = RGBA16F;
};
#line 170
sampler LensB
{
Texture = LensBTex;
AddressU = BORDER;
AddressV = BORDER;
};
#line 177
float3 MaskEdges(float3 color, float2 uv)
{
float mask = 1.0 - distance(uv, 0.5);
mask = saturate(lerp(1.0, mask, EdgesMasking * 3.0));
color.rgb *= mask;
#line 183
return color;
}
#line 186
float4 PreparePS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
uv = ScaleCoord(1.0 - uv, BaseFlareDownscale);
float4 color = tex2D(BackBuffer, uv);
color.rgb = Tonemap::Inverse(Tonemapper, color.rgb);
#line 192
color.rgb = MaskEdges(color.rgb, uv);
color.rgb = ApplySaturation(color.rgb, Saturation);
color.rgb *= color.rgb >= Tonemap::Inverse(Tonemapper, Threshold).x;
color.rgb *= Brightness * 0.1;
#line 197
return color;
}
#line 212
 float4 HexBlur1PS( float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET { float2 dir = float2(BokehSize * Downscale, 0); dir = RotatePoint(dir, BokehAngle * 60 + 30 + 30, 0); dir *= GetPixelSize(); return SharpBlur1D(LensB, uv, dir, BlurSamples, BokehDefinition); }
 float4 HexBlur2PS( float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET { float2 dir = float2(BokehSize * Downscale, 0); dir = RotatePoint(dir, BokehAngle * 60 - 30 + 30, 0); dir *= GetPixelSize(); return SharpBlur1D(LensA, uv, dir, BlurSamples, BokehDefinition); }
 float4 HexBlur3PS( float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET { float2 dir = float2(BokehSize * Downscale, 0); dir = RotatePoint(dir, BokehAngle * 60 - 90 + 30, 0); dir *= GetPixelSize(); return SharpBlur1D(LensB, uv, dir, BlurSamples, BokehDefinition); }
#line 218
float4 BlendPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
float4 color = tex2D(BackBuffer, uv);
color.rgb = Tonemap::Inverse(Tonemapper, color.rgb);
#line 227
float4 lens =
 (tex2D(LensA, ScaleCoord(uv, Scale1 * BaseFlareDownscale)) * float4(Tint1.rgb * Tint1.a, 1.0)) +
 (tex2D(LensA, ScaleCoord(uv, Scale2 * BaseFlareDownscale)) * float4(Tint2.rgb * Tint2.a, 1.0)) +
 (tex2D(LensA, ScaleCoord(uv, Scale3 * BaseFlareDownscale)) * float4(Tint3.rgb * Tint3.a, 1.0)) +
 (tex2D(LensA, ScaleCoord(uv, Scale4 * BaseFlareDownscale)) * float4(Tint4.rgb * Tint4.a, 1.0)) +
 (tex2D(LensA, ScaleCoord(uv, Scale5 * BaseFlareDownscale)) * float4(Tint5.rgb * Tint5.a, 1.0)) +
 (tex2D(LensA, ScaleCoord(uv, Scale6 * BaseFlareDownscale)) * float4(Tint6.rgb * Tint6.a, 1.0)) +
 (tex2D(LensA, ScaleCoord(uv, Scale7 * BaseFlareDownscale)) * float4(Tint7.rgb * Tint7.a, 1.0));
lens /= 7;
#line 239
color.rgb = ShowLens
? lens.rgb
: color.rgb + lens.rgb;
#line 243
color.rgb = Tonemap::Apply(Tonemapper, color.rgb);
#line 246
return float4(color.rgb + TriDither(color.rgb, uv, 8), color.a);
#line 250
}
#line 252
technique UnrealLens
{
pass Prepare
{
VertexShader = ScreenVS;
PixelShader = PreparePS;
RenderTarget = LensBTex;
}
pass HexBlur1
{
VertexShader = ScreenVS;
PixelShader = HexBlur1PS;
RenderTarget = LensATex;
}
pass HexBlur2
{
VertexShader = ScreenVS;
PixelShader = HexBlur2PS;
RenderTarget = LensBTex;
}
pass HexBlur3
{
VertexShader = ScreenVS;
PixelShader = HexBlur3PS;
RenderTarget = LensATex;
}
pass Blend
{
VertexShader = ScreenVS;
PixelShader = BlendPS;
SRGBWriteEnable = true;
}
}
#line 286
}} 

