#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 792 * (1.0 / 710); }
float2 GetPixelSize() { return float2((1.0 / 792), (1.0 / 710)); }
float2 GetScreenSize() { return float2(792, 710); }
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
#line 3 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorLab.fxh"
#line 13
namespace FXShaders { namespace ColorLab
{
#line 16
static const float Gamma = 2.2;
static const float GammaInv = 1.0 / Gamma;
#line 19
static const float L_k = 903.3;
static const float L_e = 0.008856;
#line 22
static const float WhitePoint = 1.0;
#line 24
static const float3x3 RGBToXYZ_sRGB = float3x3(
0.4124564, 0.3575761, 0.1804375,
0.2126729, 0.7151522, 0.0721750,
0.0193339, 0.1191920, 0.9503041);
#line 29
static const float3x3 XYZToRGB_sRGB = float3x3(
3.2404542, -1.5371385, -0.4985314,
-0.9692660,  1.8760108,  0.0415560,
0.0556434, -0.2040259,  1.0572252);
#line 34
float3 gamma_to_linear(float3 c, float g)
{
return pow(abs(c), g);
}
#line 39
float3 gamma_to_linear(float3 c)
{
return gamma_to_linear(c, Gamma);
}
#line 44
float3 linear_to_gamma(float3 c, float g)
{
return pow(abs(c), rcp(g));
}
#line 49
float3 linear_to_gamma(float3 c)
{
return pow(abs(c), GammaInv);
}
#line 54
float3 srgb_to_linear(float3 c)
{
return (c < 0.04045)
? c / 12.92
: pow(abs((c + 0.055) / 1.055), 2.4);
}
#line 61
float3 linear_to_srgb(float3 c)
{
return (c < 0.0031308)
? 12.92 * c
: 1.055 * pow(abs(c), rcp(2.4)) - 0.055;
}
#line 68
float3 l_to_linear(float3 c)
{
return (c < 0.08)
? (100 * c) / L_k
: pow(abs((c + 0.16) / 1.16), 3.0);
}
#line 75
float3 linear_to_l(float3 c)
{
return (c < L_e)
? (c * L_k) / 100.0
: 1.16 * pow(abs(c), rcp(3.0)) - 0.16;
}
#line 82
float3 rgb_to_xyz(float3 c)
{
return mul(RGBToXYZ_sRGB, c);
}
#line 87
float3 xyz_to_rgb(float3 c)
{
return mul(XYZToRGB_sRGB, c);
}
#line 92
float3 xyz_to_lab(float3 c, float w)
{
c /= w;
#line 96
c = (c > L_e)
? pow(abs(c), rcp(3.0))
: (L_k * c + 16.0) / 116.0;
#line 100
float3 lab;
lab.x = 116.0 * c.y - 16.0;
lab.y = 500.0 * (c.x - c.y);
lab.z = 200.0 * (c.y - c.z);
#line 105
return lab;
}
#line 108
float3 xyz_to_lab(float3 c)
{
return xyz_to_lab(c, WhitePoint);
}
#line 113
float3 lab_to_xyz(float3 lab, float w)
{
float3 c;
c.y = (lab.x + 16.0) / 116.0;
c.x = lab.y / 500.0 + c.y;
c.z = c.y - lab.z / 200.0;
#line 120
float f3 = c.x * c.x * c.x;
if (f3 > L_e)
c.x = f3;
else
c.x = (116.0 * c.x - 16.0) / L_k;
#line 126
if (lab.x > L_k * L_e)
c.y = pow(abs((lab.x + 16.0) / 116.0), 3.0);
else
c.y = lab.x / L_k;
#line 131
f3 = c.z * c.z * c.z;
if (f3 > L_e)
c.z = f3;
else
c.z = (116.0 * c.z - 16.0) / L_k;
#line 137
c *= w;
return c;
}
#line 141
float3 lab_to_xyz(float3 lab)
{
return lab_to_xyz(lab, WhitePoint);
}
#line 146
float3 rgb_to_lab(float3 c, float w)
{
return xyz_to_lab(rgb_to_xyz(c), w);
}
#line 151
float3 rgb_to_lab(float3 c)
{
return rgb_to_lab(c, WhitePoint);
}
#line 156
float3 lab_to_rgb(float3 c, float w)
{
return xyz_to_rgb(lab_to_xyz(c, w));
}
#line 161
float3 lab_to_rgb(float3 c)
{
return lab_to_rgb(c, WhitePoint);
}
#line 166
}}
#line 4 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersBlending.fxh"
#line 3
namespace FXShaders
{
#line 14
float3 BlendScreen(float3 a, float3 b, float w)
{
return 1.0 - (1.0 - a) * (1.0 - b * w);
}
#line 27
float3 BlendOverlay(float3 a, float3 b, float w)
{
float3 color;
if (a.x < 0.5 || a.y < 0.5 || a.z < 0.5)
color = 2.0 * a * b;
else
color = 1.0 - 2.0 * (1.0 - a) * (1.0 - b);
#line 35
return lerp(a, color, w);
}
#line 46
float3 BlendSoftLight(float3 a, float3 b, float w)
{
return lerp(a, (1.0 - 2.0 * b) * (a * a) + 2.0 * b * a, w);
}
#line 59
float3 BlendHardLight(float3 a, float3 b, float w)
{
float3 color;
if (a.x > 0.5 || a.y > 0.5 || a.z > 0.5)
color = 2.0 * a * b;
else
color = 1.0 - 2.0 * (1.0 - a) * (1.0 - b);
#line 67
return lerp(a, color, w);
}
#line 70
}
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
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
return float2(792, 710);
}
#line 133
float2 GetPixelSize()
{
return float2((1.0 / 792), (1.0 / 710));
}
#line 141
float GetAspectRatio()
{
return 792 * (1.0 / 710);
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
#line 6 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
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
#line 7 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersDithering.fxh"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersCommon.fxh"
#line 3 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FXShadersDithering.fxh"
#line 5
namespace FXShaders { namespace Dithering
{
#line 8
namespace Ordered16
{
static const int Width = 4;
#line 12
static const int Pattern[Width * Width] =
{
0, 8, 2, 10,
12, 4, 14, 6,
3, 11, 1, 9,
15, 7, 13, 5
};
#line 20
float3 Apply(float3 color, float2 uv, float amount)
{
const int2 pos = (uv * GetResolution()) % Width;
#line 24
return color * (1.0 + ((Pattern[pos.x * Width + pos.y] / (Width * Width)) * 2.0 - 1.0) * amount);
}
}
#line 28
}} 
#line 8 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
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
#line 12 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NeoBloom.fx"
#line 88
namespace FXShaders
{
#line 93
struct BlendPassParams
{
float4 p : SV_POSITION;
float2 uv : TEXCOORD0;
#line 99
float2 lens_uv : TEXCOORD1;
#line 101
};
#line 108
static const int BloomCount = 5;
static const float4 BloomLevels[] =
{
float4(0.0, 0.5, 0.5, 1),
float4(0.5, 0.0, 0.25, 2),
float4(0.75, 0.875, 0.125, 3),
float4(0.875, 0.0, 0.0625, 5),
float4(0.0, 0.0, 0.03, 7)
#line 117
};
static const int MaxBloomLevel = BloomCount - 1;
#line 120
static const int BlurSamples =  27;
#line 122
static const float2 PixelScale = 1.0;
#line 124
static const float2 DirtResolution = float2(
 1280,
 720);
static const float2 DirtPixelSize = 1.0 / DirtResolution;
static const float DirtAspectRatio = DirtResolution.x * DirtPixelSize.y;
static const float DirtAspectRatioInv = 1.0 / DirtAspectRatio;
#line 131
static const int DebugOption_None = 0;
static const int DebugOption_OnlyBloom = 1;
static const int DebugOptions_TextureAtlas = 2;
static const int DebugOption_Adaptation = 3;
#line 137
static const int DebugOption_DepthRange = 4;
#line 142
static const int AdaptMode_FinalImage = 0;
static const int AdaptMode_OnlyBloom = 1;
#line 145
static const int BloomBlendMode_Mix = 0;
static const int BloomBlendMode_Addition = 1;
static const int BloomBlendMode_Screen = 2;
#line 363
uniform int _Help < ui_text =
"NeoBloom has many options and may be difficult to setup or may look "
"bad at first, but it's designed to be very flexible to adapt to many "
"different cases.\n"
"Make sure to take a look at the preprocessor definitions at the "
"bottom!\n"
"For more specific descriptions, move the mouse cursor over the name "
"of the option you need help with.\n"
"\n"
"Here's a general description of the features:\n"
"\n"
"  Bloom:\n"
"    Basic options for controlling the look of bloom itself.\n"
"\n"
"  Adaptation:\n"
"    Used to dynamically increase or reduce the image brightness "
"depending on the scene, giving an HDR look.\n"
"    Looking at a bright object, like a lamp, would cause the image to "
"darken; lookinng at a dark spot, like a cave, would cause the "
"image to brighten.\n"
"\n"
"  Blending:\n"
"    Used to control how the different bloom textures are blended, "
"each representing a different level-of-detail.\n"
"    Can be used to simulate an old mid-2000s bloom, ambient light "
"etc.\n"
"\n"
"  Ghosting:\n"
"    Smoothens the bloom between frames, causing a \"motion blur\" or "
"\"trails\" effect.\n"
"\n"
"  Depth:\n"
"    Used to increase or decrease the brightness of parts of the image "
"depending on depth.\n"
"    Can be used for effects like brightening the sky.\n"
"    An optional anti-flicker feature is available to help with games "
"with depth flickering problems, which can cause bloom to flicker as "
"well with the depth feature enabled.\n"
"\n"
"  HDR:\n"
"    Options for controlling the high dynamic range simulation.\n"
"    Useful for simulating a more foggy bloom, like an old soap opera, "
"a high-contrast sunny look etc.\n"
"\n"
"  Blur:\n"
"    Options for controlling the blurring effect used to generate the "
"bloom textures.\n"
"    Mostly can be left untouched.\n"
"\n"
"  Debug:\n"
"    Enables testing options, like viewing the bloom texture alone, "
"before mixing with the image.\n"
#line 207
; ui_category = "Help"; ui_category_closed = true; ui_label = " "; ui_type = "radio"; >;
#line 209
uniform float uIntensity <
ui_label = "Intensity";
ui_tooltip =
"Determines how much bloom is added to the image. For HDR games you'd "
"generally want to keep this low-ish, otherwise everything might look "
"too bright.\n"
"\nDefault: 1.0";
ui_category = "Bloom";
ui_type = "slider";
ui_min = 0.0;
ui_max = 3.0;
ui_step = 0.001;
> = 1.0;
#line 223
uniform float uSaturation <
ui_label = "Saturation";
ui_tooltip =
"Saturation of the bloom texture.\n"
"\nDefault: 1.0";
ui_category = "Bloom";
ui_type = "slider";
ui_min = 0.0;
ui_max = 3.0;
> = 1.0;
#line 234
uniform float3 ColorFilter
<
ui_label = "Color Filter";
ui_tooltip =
"Color multiplied to the bloom, filtering it.\n"
"Set to full white (255, 255, 255) to disable it.\n"
"\nDefault: 255 255 255";
ui_category = "Bloom";
ui_type = "color";
> = float3(1.0, 1.0, 1.0);
#line 245
uniform int BloomBlendMode
<
ui_label = "Blend Mode";
ui_tooltip =
"Determines the formula used to blend bloom with the scene color.\n"
"Certain blend modes may not play well with other options.\n"
"As a fallback, addition always works.\n"
"\nDefault: Mix";
ui_category = "Bloom";
ui_type = "combo";
ui_items = "Mix\0Addition\0Screen\0";
> = 1;
#line 260
uniform float uLensDirtAmount <
ui_text =
"Set NEO_BLOOM_DIRT to 0 to disable this feature to reduce resource "
"usage.";
ui_label = "Amount";
ui_tooltip =
"Determines how much lens dirt is added to the bloom texture.\n"
"\nDefault: 0.0";
ui_category = "Lens Dirt";
ui_type = "slider";
ui_min = 0.0;
ui_max = 3.0;
> = 0.0;
#line 280
uniform int AdaptMode
<
ui_text =
"Set NEO_BLOOM_ADAPT to 0 to disable this feature to reduce resource "
"usage.";
ui_label = "Mode";
ui_tooltip =
"Select different modes of how adaptation is applied.\n"
"  Final Image:\n"
"    Apply adaptation to the image after it was mixed with bloom.\n"
"  Bloom Only:\n"
"    Apply adaptation only to bloom, before mixing with the image.\n"
"\nDefault: Final Image";
ui_category = "Adaptation";
ui_type = "combo";
ui_items = "Final Image\0Bloom Only\0";
> = 0;
#line 298
uniform float uAdaptAmount <
ui_label = "Amount";
ui_tooltip =
"How much adaptation affects the image brightness.\n"
"\bDefault: 1.0";
ui_category = "Adaptation";
ui_type = "slider";
ui_min = 0.0;
ui_max = 2.0;
> = 1.0;
#line 309
uniform float uAdaptSensitivity <
ui_label = "Sensitivity";
ui_tooltip =
"How sensitive is the adaptation towards bright spots?\n"
"\nDefault: 1.0";
ui_category = "Adaptation";
ui_type = "slider";
ui_min = 0.0;
ui_max = 2.0;
> = 1.0;
#line 320
uniform float uAdaptExposure <
ui_label = "Exposure";
ui_tooltip =
"Determines the general brightness that the effect should adapt "
"towards.\n"
"This is measured in f-numbers, thus 0 is the base exposure, <0 will "
"be darker and >0 brighter.\n"
"\nDefault: 0.0";
ui_category = "Adaptation";
ui_type = "slider";
ui_min = -3.0;
ui_max = 3.0;
> = 0.0;
#line 334
uniform bool uAdaptUseLimits <
ui_label = "Use Limits";
ui_tooltip =
"Should the adaptation be limited to the minimum and maximum values "
"specified below?\n"
"\nDefault: On";
ui_category = "Adaptation";
> = true;
#line 343
uniform float2 uAdaptLimits <
ui_label = "Limits";
ui_tooltip =
"The minimum and maximum values that adaptation can achieve.\n"
"Increasing the minimum value will lessen how bright the image can "
"become in dark scenes.\n"
"Decreasing the maximum value will lessen how dark the image can "
"become in bright scenes.\n"
"\nDefault: 0.0 1.0";
ui_category = "Adaptation";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = float2(0.0, 1.0);
#line 359
uniform float uAdaptTime <
ui_label = "Time";
ui_tooltip =
"The time it takes for the effect to adapt.\n"
"\nDefault: 1.0";
ui_category = "Adaptation";
ui_type = "slider";
ui_min = 0.02;
ui_max = 3.0;
> = 1.0;
#line 370
uniform float uAdaptPrecision <
ui_label = "Precision";
ui_tooltip =
"How precise adaptation will be towards the center of the image.\n"
"This means that 0.0 will yield an adaptation of the overall image "
"brightness, while higher values will focus more and more towards the "
"center pixels.\n"
"\nDefault: 0.0";
ui_category = "Adaptation";
ui_type = "slider";
ui_min = 0.0;
ui_max =  11;
ui_step = 1.0;
> = 0.0;
#line 385
uniform int uAdaptFormula <
ui_label = "Formula";
ui_tooltip =
"Which formula to use when extracting brightness information from "
"color.\n"
"\nDefault: Luma (Linear)";
ui_category = "Adaptation";
ui_type = "combo";
ui_items = "Average\0Luminance\0Luma (Gamma)\0Luma (Linear)";
> = 3;
#line 400
uniform float uMean <
ui_label = "Mean";
ui_tooltip =
"Acts as a bias between all the bloom textures/sizes. What this means "
"is that lower values will yield more detail bloom, while the opposite "
"will yield big highlights.\n"
"The more variance is specified, the less effective this setting is, "
"so if you want to have very fine detail bloom reduce both "
"parameters.\n"
"\nDefault: 0.0";
ui_category = "Blending";
ui_type = "slider";
ui_min = 0.0;
ui_max = BloomCount;
#line 415
> = 0.0;
#line 417
uniform float uVariance <
ui_label = "Variance";
ui_tooltip =
"Determines the 'variety'/'contrast' in bloom textures/sizes. This "
"means a low variance will yield more of the bloom size specified by "
"the mean; that is to say that having a low variance and mean will "
"yield more fine-detail bloom.\n"
"A high variance will diminish the effect of the mean, since it'll "
"cause all the bloom textures to blend more equally.\n"
"A low variance and high mean would yield an effect similar to "
"an 'ambient light', with big blooms of light, but few details.\n"
"\nDefault: 1.0";
ui_category = "Blending";
ui_type = "slider";
ui_min = 1.0;
ui_max = BloomCount;
#line 434
> = BloomCount;
#line 440
uniform float uGhostingAmount <
ui_text =
"Set NEO_BLOOM_GHOSTING to 0 if you don't use this feature to reduce "
"resource usage.";
ui_label = "Amount";
ui_tooltip =
"Amount of ghosting applied.\n"
"\nDefault: 0.0";
ui_category = "Ghosting";
ui_type = "slider";
ui_min = 0.0;
ui_max = 0.999;
> = 0.0;
#line 458
uniform float3 DepthMultiplier
<
ui_text =
"Set NEO_BLOOM_DEPTH to 0 if you don't use this feature to reduce "
"resource usage.";
ui_label = "Multiplier";
ui_tooltip =
"Defines the multipliers that will be applied to each range in depth.\n"
" - The first value defines the multiplier for near depth.\n"
" - The second value defines the multiplier for middle depth.\n"
" - The third value defines the multiplier for far depth.\n"
"\nDefault: 1.0 1.0 1.0";
ui_category = "Depth";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
ui_step = 0.01;
> = float3(1.0, 1.0, 1.0);
#line 477
uniform float2 DepthRange
<
ui_label = "Range";
ui_tooltip =
"Defines the depth range for thee depth multiplier.\n"
" - The first value defines the start of the middle depth."
" - The second value defines the end of the middle depth and the start "
"of the far depth."
"\nDefault: 0.0 1.0";
ui_category = "Depth";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = float2(0.0, 1.0);
#line 493
uniform float DepthSmoothness
<
ui_label = "Smoothness";
ui_tooltip =
"Amount of smoothness in the transition between depth ranges.\n"
"\nDefault: 1.0";
ui_category = "Depth";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 1.0;
#line 527
uniform float uMaxBrightness <
ui_label  = "Max Brightness";
ui_tooltip =
"tl;dr: HDR contrast.\n"
"\nDetermines the maximum brightness a pixel can achieve from being "
"'reverse-tonemapped', that is to say, when the effect attempts to "
"extract HDR information from the image.\n"
"In practice, the difference between a value of 100 and one of 1000 "
"would be in how bright/bloomy/big a white pixel could become, like "
"the sun or the headlights of a car.\n"
"Lower values can also work for making a more 'balanced' bloom, where "
"there are less harsh highlights and the entire scene is equally "
"foggy, like an old TV show or with dirty lenses.\n"
"\nDefault: 100.0";
ui_category = "HDR";
ui_type = "slider";
ui_min = 1.0;
ui_max = 1000.0;
ui_step = 1.0;
> = 100.0;
#line 548
uniform bool uNormalizeBrightness <
ui_label = "Normalize Brightness";
ui_tooltip =
"Whether to normalize the bloom brightness when blending with the "
"image.\n"
"Without it, the bloom may have very harsh bright spots.\n"
"\nDefault: On";
ui_category = "HDR";
> = true;
#line 558
uniform bool MagicMode
<
ui_label = "Magic Mode";
ui_tooltip =
"When enabled, simulates the look of MagicBloom.\n"
"This is an experimental option and may be inconsistent with other "
"parameters.\n"
"\nDefault: Off";
ui_category = "HDR";
> = false;
#line 571
uniform float uSigma <
ui_label = "Sigma";
ui_tooltip =
"Amount of blurriness. Values too high will break the blur.\n"
"Recommended values are between 2 and 4.\n"
"\nDefault: 2.0";
ui_category = "Blur";
ui_type = "slider";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.01;
> = 4.0;
#line 584
uniform float uPadding <
ui_label = "Padding";
ui_tooltip =
"Specifies additional padding around the bloom textures in the "
"internal texture atlas, which is used during the blurring process.\n"
"The reason for this is to reduce the loss of bloom brightness around "
"the screen edges, due to the way the blurring works.\n"
"\n"
"If desired, it can be set to zero to purposefully reduce the "
"amount of bloom around the edges.\n"
"It may be necessary to increase this parameter when increasing the "
"blur sigma, samples and/or bloom down scale.\n"
"\n"
"Due to the way it works, it's recommended to keep the value as low "
"as necessary, since it'll cause the blurring process to work in a "
"\"lower\" resolution.\n"
"\n"
"If you're still confused about this parameter, try viewing the "
"texture atlas with debug mode and watch what happens when it is "
"increased.\n"
"\nDefault: 0.1";
ui_category = "Blur";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
ui_step = 0.001;
> = 0.1;
#line 682
uniform float FrameTime <source = "frametime";>;
#line 690
sampler BackBuffer
{
Texture = ReShade::BackBufferTex;
SRGBTexture = true;
};
#line 696
texture NeoBloom_DownSample <pooled="true";>
{
Width =  1024;
Height =  1024;
Format = RGBA16F;
MipLevels =  11;
};
sampler DownSample
{
Texture = NeoBloom_DownSample;
};
#line 708
texture NeoBloom_AtlasA <pooled="true";>
{
Width = 792 /  2;
Height = 710 /  2;
Format = RGBA16F;
};
sampler AtlasA
{
Texture = NeoBloom_AtlasA;
AddressU = BORDER;
AddressV = BORDER;
};
#line 721
texture NeoBloom_AtlasB <pooled="true";>
{
Width = 792 /  2;
Height = 710 /  2;
Format = RGBA16F;
};
sampler AtlasB
{
Texture = NeoBloom_AtlasB;
AddressU = BORDER;
AddressV = BORDER;
};
#line 736
texture NeoBloom_Adapt <pooled="true";>
{
Format = R16F;
};
sampler Adapt
{
Texture = NeoBloom_Adapt;
MinFilter = POINT;
MagFilter = POINT;
MipFilter = POINT;
};
#line 748
texture NeoBloom_LastAdapt
{
Format = R16F;
};
sampler LastAdapt
{
Texture = NeoBloom_LastAdapt;
MinFilter = POINT;
MagFilter = POINT;
MipFilter = POINT;
};
#line 764
texture NeoBloom_LensDirt
<
source =  "SharedBloom_Dirt.png";
>
{
Width =  1280;
Height =  720;
};
sampler LensDirt
{
Texture = NeoBloom_LensDirt;
};
#line 781
texture NeoBloom_Last
{
Width = 792 /  ( 2 / 4.0);
Height = 710 /  ( 2 / 4.0);
#line 789
Format = R8;
#line 791
};
sampler Last
{
Texture = NeoBloom_Last;
};
#line 799
texture NeoBloom_Depth
{
Width = 792;
Height = 710;
Format = R8;
};
sampler Depth
{
Texture = NeoBloom_Depth;
};
#line 818
float3 blend_bloom(float3 color, float3 bloom)
{
float w;
if (uNormalizeBrightness)
w = uIntensity / uMaxBrightness;
else
w = uIntensity;
#line 826
switch (BloomBlendMode)
{
default:
return 0.0;
case BloomBlendMode_Mix:
return lerp(color, bloom, log2(w + 1.0));
case BloomBlendMode_Addition:
return color + bloom * w * 3.0;
case BloomBlendMode_Screen:
return BlendScreen(color, bloom, w);
}
}
#line 839
float3 inv_tonemap_bloom(float3 color)
{
if (MagicMode)
return pow(abs(color), uMaxBrightness * 0.01);
#line 844
return Tonemap::Reinhard::InverseOldLum(color, 1.0 / uMaxBrightness);
}
#line 847
float3 inv_tonemap(float3 color)
{
if (MagicMode)
return color;
#line 852
return Tonemap::Reinhard::InverseOld(color, 1.0 / uMaxBrightness);
}
#line 855
float3 tonemap(float3 color)
{
if (MagicMode)
return color;
#line 860
return Tonemap::Reinhard::Apply(color);
}
#line 886
float4 DownSamplePS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
float4 color = tex2D(BackBuffer, uv);
color.rgb = saturate(ApplySaturation(color.rgb, uSaturation));
color.rgb *= ColorFilter;
color.rgb = inv_tonemap_bloom(color.rgb);
#line 897
const float3 depth = ReShade::GetLinearizedDepth(uv);
#line 900
const float is_near = smoothstep(
depth.x - DepthSmoothness.x,
depth.x + DepthSmoothness.x,
DepthRange.x);
#line 905
const float is_far = smoothstep(
DepthRange.y - DepthSmoothness.x,
DepthRange.y + DepthSmoothness.x, depth.x);
#line 909
const float is_middle = (1.0 - is_near) * (1.0 - is_far);
#line 911
color.rgb *= lerp(1.0, DepthMultiplier.x, is_near);
color.rgb *= lerp(1.0, DepthMultiplier.y, is_middle);
color.rgb *= lerp(1.0, DepthMultiplier.z, is_far);
#line 916
return color;
}
#line 919
float4 SplitPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
float4 color = 0.0;
#line 923
[unroll]
for (int i = 0; i < BloomCount; ++i)
{
float4 rect = BloomLevels[i];
float2 rect_uv = ScaleCoord(uv - rect.xy, 1.0 / rect.z, 0.0);
float inbounds =
step(0.0, rect_uv.x) * step(rect_uv.x, 1.0) *
step(0.0, rect_uv.y) * step(rect_uv.y, 1.0);
#line 932
rect_uv = ScaleCoord(rect_uv, 1.0 + uPadding * (i + 1), 0.5);
#line 934
float4 pixel = tex2Dlod(DownSample, float4(rect_uv, 0, rect.w));
pixel.rgb *= inbounds;
pixel.a = inbounds;
#line 938
color += pixel;
}
#line 941
return color;
}
#line 944
float4 BlurXPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
return GaussianBlur1D(AtlasA, uv, PixelScale * float2((1.0 / 792), 0.0) *  2, uSigma, BlurSamples);
}
#line 949
float4 BlurYPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
return GaussianBlur1D(AtlasB, uv, PixelScale * float2(0.0, (1.0 / 710)) *  2, uSigma, BlurSamples);
}
#line 956
float4 CalcAdaptPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
float3 color = tex2Dlod(
DownSample,
float4(0.5, 0.5, 0.0,  11 - uAdaptPrecision)
).rgb;
color = tonemap(color);
#line 964
float gs;
switch (uAdaptFormula)
{
case 0:
gs = dot(color, 0.333);
break;
case 1:
gs = max(color.r, max(color.g, color.b));
break;
case 2:
gs = GetLumaGamma(color);
break;
case 3:
gs = GetLumaLinear(color);
break;
}
#line 981
gs *= uAdaptSensitivity;
#line 983
if (uAdaptUseLimits)
gs = clamp(gs, uAdaptLimits.x, uAdaptLimits.y);
gs = lerp(tex2D(LastAdapt, 0.0).r, gs, saturate((FrameTime * 0.001) / max(uAdaptTime, 0.001)));
#line 987
return float4(gs, 0.0, 0.0, 1.0);
}
#line 990
float4 SaveAdaptPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
return tex2D(Adapt, 0.0);
}
#line 997
float4 JoinBloomsPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
float4 bloom = 0.0;
float accum = 0.0;
#line 1002
[unroll]
for (int i = 0; i < BloomCount; ++i)
{
float4 rect = BloomLevels[i];
float2 rect_uv = ScaleCoord(uv, 1.0 / (1.0 + uPadding * (i + 1)), 0.5);
rect_uv = ScaleCoord(rect_uv + rect.xy / rect.z, rect.z, 0.0);
#line 1009
float weight = NormalDistribution(i, uMean, uVariance);
bloom += tex2D(AtlasA, rect_uv) * weight;
accum += weight;
}
bloom /= accum;
#line 1016
bloom.rgb = lerp(bloom.rgb, tex2D(Last, uv).rgb, uGhostingAmount);
#line 1019
return bloom;
}
#line 1024
float4 SaveLastBloomPS(
float4 p : SV_POSITION,
float2 uv : TEXCOORD
) : SV_TARGET
{
float4 color = float4(0.0, 0.0, 0.0, 1.0);
#line 1036
color.rgb = tex2D(AtlasB, uv).rgb;
#line 1039
return color;
}
#line 1048
BlendPassParams BlendVS(uint id : SV_VERTEXID)
{
BlendPassParams p;
#line 1052
PostProcessVS(id, p.p, p.uv);
#line 1055
float ar = 792 * (1.0 / 710);
float ar_inv = 710 * (1.0 / 792);
float is_horizontal = step(ar, DirtAspectRatio);
float ratio = lerp(
DirtAspectRatio * ar_inv,
ar * DirtAspectRatioInv,
is_horizontal);
#line 1063
p.lens_uv = ScaleCoord(p.uv, float2(1.0, ratio), 0.5);
#line 1066
return p;
}
#line 1069
float4 BlendPS(BlendPassParams p) : SV_TARGET
{
float2 uv = p.uv;
#line 1073
float4 color = tex2D(BackBuffer, uv);
color.rgb = inv_tonemap(color.rgb);
#line 1077
float4 bloom = tex2D(AtlasB, uv);
#line 1090
bloom.rgb = mad(tex2D(LensDirt, p.lens_uv).rgb, bloom.rgb * uLensDirtAmount, bloom.rgb);
#line 1165
const float exposure = lerp(1.0, exp(uAdaptExposure) / max(tex2D(Adapt, 0.0).r, 0.001), uAdaptAmount);
#line 1167
if (MagicMode)
{
bloom.rgb = Tonemap::Uncharted2Filmic::Apply(
bloom.rgb * exposure * 0.1);
}
#line 1173
switch (AdaptMode)
{
case AdaptMode_FinalImage:
color = blend_bloom(color.rgb, bloom.rgb);
color.rgb *= exposure;
break;
case AdaptMode_OnlyBloom:
bloom.rgb *= exposure;
color = blend_bloom(color.rgb, bloom.rgb);
break;
}
#line 1191
if (!MagicMode)
color.rgb = tonemap(color.rgb);
#line 1195
return float4(color.rgb + TriDither(color.rgb, p.uv, 8), color.a);
#line 1199
}
#line 1205
technique NeoBloom
{
#line 1216
pass DownSample
{
VertexShader = PostProcessVS;
PixelShader = DownSamplePS;
RenderTarget = NeoBloom_DownSample;
}
pass Split
{
VertexShader = PostProcessVS;
PixelShader = SplitPS;
RenderTarget = NeoBloom_AtlasA;
}
pass BlurX
{
VertexShader = PostProcessVS;
PixelShader = BlurXPS;
RenderTarget = NeoBloom_AtlasB;
}
pass BlurY
{
VertexShader = PostProcessVS;
PixelShader = BlurYPS;
RenderTarget = NeoBloom_AtlasA;
}
#line 1242
pass CalcAdapt
{
VertexShader = PostProcessVS;
PixelShader = CalcAdaptPS;
RenderTarget = NeoBloom_Adapt;
}
pass SaveAdapt
{
VertexShader = PostProcessVS;
PixelShader = SaveAdaptPS;
RenderTarget = NeoBloom_LastAdapt;
}
#line 1257
pass JoinBlooms
{
VertexShader = PostProcessVS;
PixelShader = JoinBloomsPS;
RenderTarget = NeoBloom_AtlasB;
}
pass SaveLastBloom
{
VertexShader = PostProcessVS;
PixelShader = SaveLastBloomPS;
RenderTarget = NeoBloom_Last;
}
#line 1271
pass Blend
{
VertexShader = BlendVS;
PixelShader = BlendPS;
SRGBWriteEnable = true;
}
}
#line 1281
}

