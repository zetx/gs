#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Sketch.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1309 * (1.0 / 762); }
float2 GetPixelSize() { return float2((1.0 / 1309), (1.0 / 762)); }
float2 GetScreenSize() { return float2(1309, 762); }
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
#line 14 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Sketch.fx"
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
#line 17 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Sketch.fx"
#line 48
static const int SmoothingSamples =  5;
static const float SmoothingSamplesInv = 1.0 / SmoothingSamples;
static const float SmoothingSamplesHalf = SmoothingSamples / 2;
#line 52
static const float2 ZeroOne = float2(0.0, 1.0);
#line 73
sampler SRGBBackBuffer
{
Texture = ReShade::BackBufferTex;
SRGBTexture = true;
};
#line 100
uniform float4 PatternColor
<
ui_type = "color";
ui_label = "Pattern Color";
ui_tooltip = "Default: 255 255 255 16";
> = float4(255, 255, 255, 16) / 255;
#line 107
uniform float2 PatternRange
<
ui_type = "slider";
ui_label = "Pattern Range";
ui_tooltip = "Default: 0.0 0.5";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.01;
> = float2(0.0, 0.5);
#line 117
uniform float OutlineThreshold
<
ui_type = "slider";
ui_label = "Outline Threshold";
ui_tooltip = "Default: 0.01";
ui_min = 0.001;
ui_max = 0.1;
ui_step = 0.001;
> = 0.01;
#line 127
uniform float Posterization
<
ui_type = "slider";
ui_tooltip = "Default: 5";
ui_min = 1;
ui_max = 255;
ui_step = 1;
> = 5;
#line 138
uniform float SmoothingScale
<
ui_type = "slider";
ui_label = "Smoothing Scale";
ui_tooltip = "Default: 1.0";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.01;
> = 1.0;
#line 166
float get_depth(float2 uv)
{
return ReShade::GetLinearizedDepth(uv);
}
#line 171
float3 get_normals(float2 uv)
{
const float3 ps = float3(ReShade:: GetPixelSize(), 0.0);
#line 175
float3 normals;
normals.x = get_depth(uv - ps.xz) - get_depth(uv + ps.xz);
normals.y = get_depth(uv + ps.zy) - get_depth(uv - ps.zy);
normals.z = get_depth(uv);
#line 180
normals.xy = abs(normals.xy) * 0.5 * ReShade:: GetScreenSize();
normals = normalize(normals);
#line 183
return normals;
}
#line 186
float get_outline(float2 uv)
{
return step(OutlineThreshold, dot(get_normals(uv), float3(0.0, 0.0, 1.0)));
}
#line 191
float get_pattern(float2 uv)
{
#line 201
float x = uv.x + uv.y;
x = abs(x);
x %= 0.0125;
x /= 0.0125;
x = abs((x - 0.5) * 2.0);
x = step(0.5, x);
#line 208
return x;
#line 210
}
#line 212
float3 test_palette(float3 color, float2 uv)
{
const float2 bw = float2(1.0, 0.0);
uv.y = 1.0 - uv.y;
uv.y *= 20.0;
#line 218
return (uv.y < 0.333)
? uv.x * bw.xyy
: (uv.y < 0.666)
? uv.x * bw.yxy
: (uv.y < 1.0)
? uv.x * bw.yyx
: color;
}
#line 227
float3 cel_shade(float3 color, out float gray)
{
gray = dot(color, 0.333);
color -= gray;
#line 232
gray *= Posterization;
gray = round(gray);
gray /= Posterization;
#line 236
color += gray;
return color;
}
#line 242
float3 blur_old(sampler s, float2 uv, float2 dir)
{
dir *= SmoothingScale;
#line 246
uv -= SmoothingSamplesHalf * dir;
float3 color = tex2D(s, uv).rgb;
#line 249
[unroll]
for (int i = 1; i < SmoothingSamples; ++i)
{
uv += dir;
color += tex2D(s, uv).rgb;
}
#line 256
color *= SmoothingSamplesInv;
return color;
}
#line 260
float3 blur_depth_threshold(sampler s, float2 uv, float2 dir)
{
dir *= SmoothingScale;
#line 264
float depth = get_depth(uv);
#line 266
uv -= SmoothingSamplesHalf * dir;
float4 color = 0.0;
#line 269
[unroll]
for (int i = 0; i < SmoothingSamples; ++i)
{
float z = get_depth(uv);
if (abs(z - depth) < 0.001)
color += float4(tex2D(s, uv).rgb, 1.0);
#line 276
uv += dir;
}
#line 279
color.rgb /= color.a;
return color.rgb;
}
#line 283
float3 blur(sampler s, float2 uv, float2 dir)
{
dir *= SmoothingScale;
#line 287
const float3 center = tex2D(s, uv).rgb;
#line 289
uv -= SmoothingSamplesHalf * dir;
float4 color = 0.0;
#line 292
[unroll]
for (int i = 0; i < SmoothingSamples; ++i)
{
float3 pixel = tex2D(s, uv).rgb;
float delta = dot(1.0 - abs(pixel - center), 0.333);
#line 298
if (delta > 0.9		)
color += float4(pixel, 1.0);
}
#line 302
color.rgb /= color.a;
return color.rgb;
}
#line 314
float4 BlurXPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
#line 317
const float3 outcolor = blur(SRGBBackBuffer, uv, float2((1.0 / 1309), 0.0));
return float4(outcolor + TriDither(outcolor, uv, 8), 1.0);
#line 322
}
#line 324
float4 BlurYPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
return float4(blur(ReShade::BackBuffer, uv, float2(0.0, (1.0 / 762))), 1.0);
}
#line 331
void MainVS(
uint id : SV_VERTEXID,
out float4 p : SV_POSITION,
out float2 uv : TEXCOORD0,
out float2 pattern_uv : TEXCOORD1)
{
PostProcessVS(id, p, uv);
#line 339
pattern_uv = uv;
pattern_uv.x *= ReShade:: GetAspectRatio();
}
#line 343
float4 MainPS(
float4 p : SV_POSITION,
float2 uv : TEXCOORD0,
float2 pattern_uv : TEXCOORD1) : SV_TARGET
{
float4 color = tex2D(ReShade::BackBuffer, uv);
#line 361
float gray;
color.rgb = cel_shade(color.rgb, gray);
#line 364
float pattern = get_pattern(pattern_uv);
pattern *= 1.0 - smoothstep(PatternRange.x, PatternRange.y, gray);
pattern *= (1.0 - gray) * PatternColor.a;
color.rgb = lerp(color.rgb, PatternColor.rgb, pattern);
#line 369
float outline = get_outline(uv);
color.rgb *= outline;
#line 373
return float4(color.rgb + TriDither(color.rgb, uv, 8), color.a);
#line 377
}
#line 383
technique Sketch
{
#line 386
pass BlurX
{
VertexShader = PostProcessVS;
PixelShader = BlurXPS;
}
pass BlurY
{
VertexShader = PostProcessVS;
PixelShader = BlurYPS;
SRGBWriteEnable = true;
}
#line 398
pass Main
{
VertexShader = MainVS;
PixelShader = MainPS;
}
}

