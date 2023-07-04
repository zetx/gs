#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Unsharp.fx"
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
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Unsharp.fx"
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
#line 2 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Unsharp.fx"
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
#line 3 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Unsharp.fx"
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
#line 6 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Unsharp.fx"
#line 13
namespace FXShaders
{
#line 16
static const int BlurSamples =  21;
#line 18
uniform float Amount
<
ui_category = "Appearance";
ui_label = "Amount";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 1.0;
#line 27
uniform float BlurScale
<
ui_category = "Appearance";
ui_label = "Blur Scale";
ui_type = "slider";
ui_min = 0.01;
ui_max = 1.0;
> = 1.0;
#line 36
texture ColorTex : COLOR;
#line 38
sampler ColorSRGB
{
Texture = ColorTex;
#line 42
};
#line 44
sampler ColorLinear
{
Texture = ColorTex;
};
#line 49
texture OriginalTex
{
Width = 5360;
Height = 1440;
#line 57
};
#line 59
sampler Original
{
Texture = OriginalTex;
MinFilter = POINT;
MagFilter = POINT;
MipFilter = POINT;
};
#line 67
float4 Blur(sampler tex, float2 uv, float2 dir)
{
float4 color = GaussianBlur1D(
tex,
uv,
dir * GetPixelSize() * 3.0,
sqrt(BlurSamples) * BlurScale,
BlurSamples
);
#line 78
return color + abs(GetRandom(uv) - 0.5) * FloatEpsilon * 25.0;
}
#line 81
float4 CopyOriginalPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
return tex2D(ColorSRGB, uv);
}
#line 94
 float4 Blur0PS( float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET { return Blur(ColorSRGB, uv, float2(1.0, 0.0)); };
#line 96
 float4 Blur1PS( float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET { return Blur(ColorLinear, uv, float2(0.0, 4.0)); };
#line 98
 float4 Blur2PS( float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET { return Blur(ColorLinear, uv, float2(4.0, 0.0)); };
#line 100
 float4 Blur3PS( float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET { return Blur(ColorLinear, uv, float2(0.0, 1.0)); };
#line 102
float4 BlendPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
#line 105
float4 color = tex2D(Original, uv);
#line 107
color.rgb = BlendOverlay(color.rgb, GetLumaGamma(1.0 - tex2D(ColorLinear, uv).rgb) * 0.75, Amount);
#line 109
return float4(color.rgb + TriDither(color.rgb, uv, 8), color.a);
#line 115
}
#line 117
technique Unsharp
{
pass CopyOriginal
{
VertexShader = ScreenVS;
PixelShader = CopyOriginalPS;
RenderTarget = OriginalTex;
}
pass Blur0
{
VertexShader = ScreenVS;
PixelShader = Blur0PS;
}
pass Blur1
{
VertexShader = ScreenVS;
PixelShader = Blur1PS;
}
pass Blur2
{
VertexShader = ScreenVS;
PixelShader = Blur2PS;
}
pass Blur3
{
VertexShader = ScreenVS;
PixelShader = Blur3PS;
}
pass Blend
{
VertexShader = ScreenVS;
PixelShader = BlendPS;
#line 150
}
}
#line 153
}

