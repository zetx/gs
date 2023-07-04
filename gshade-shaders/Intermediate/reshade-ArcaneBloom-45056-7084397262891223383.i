#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ArcaneBloom.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ArcaneBloom.fxh"
#line 23
namespace ArcaneBloom {
#line 34
namespace _ {
#line 42
 texture2D tArcaneBloom_Bloom0 { Width  = 5360 / 2; Height = 1440 / 2; Format = RGBA16F; };
 texture2D tArcaneBloom_Bloom1 { Width  = 5360 / 4; Height = 1440 / 4; Format = RGBA16F; };
 texture2D tArcaneBloom_Bloom2 { Width  = 5360 / 8; Height = 1440 / 8; Format = RGBA16F; };
 texture2D tArcaneBloom_Bloom3 { Width  = 5360 / 16; Height = 1440 / 16; Format = RGBA16F; };
 texture2D tArcaneBloom_Bloom4 { Width  = 5360 / 32; Height = 1440 / 32; Format = RGBA16F; };
#line 52
texture2D tArcaneBloom_Adapt {
Format = R32F;
};
#line 56
}
#line 63
 sampler2D sBloom0 { Texture = _::tArcaneBloom_Bloom0; };
 sampler2D sBloom1 { Texture = _::tArcaneBloom_Bloom1; };
 sampler2D sBloom2 { Texture = _::tArcaneBloom_Bloom2; };
 sampler2D sBloom3 { Texture = _::tArcaneBloom_Bloom3; };
 sampler2D sBloom4 { Texture = _::tArcaneBloom_Bloom4; };
#line 73
sampler2D sAdapt {
Texture   = _::tArcaneBloom_Adapt;
MinFilter = POINT;
MagFilter = POINT;
MipFilter = POINT;
AddressU  = CLAMP;
AddressV  = CLAMP;
AddressW  = CLAMP;
};
#line 88
static const float cPI = 3.1415926535897932384626433832795;
#line 94
float3 inv_reinhard(float3 color, float inv_max) {
return (color / max(1.0 - color, inv_max));
}
#line 98
float3 inv_reinhard_lum(float3 color, float inv_max) {
const float lum = max(color.r, max(color.g, color.b));
return color * (lum / max(1.0 - lum, inv_max));
}
#line 103
float3 reinhard(float3 color) {
return color / (1.0 + color);
}
#line 107
float3 box_blur(sampler2D sp, float2 uv, float2 ps) {
return (tex2D(sp, uv - ps * 0.5).rgb +
tex2D(sp, uv + ps * 0.5).rgb +
tex2D(sp, uv + float2(-ps.x, ps.y) * 0.5).rgb +
tex2D(sp, uv + float2( ps.x,-ps.y) * 0.5).rgb) * 0.25;
}
#line 116
static const int cGaussianSamples = 13;
float get_weight(int i) {
static const float weights[cGaussianSamples] = {
0.017997,
0.033159,
0.054670,
0.080657,
0.106483,
0.125794,
0.132981,
0.125794,
0.106483,
0.080657,
0.054670,
0.033159,
0.017997
};
return weights[i];
}
#line 136
float3 gaussian_blur(sampler2D sp, float2 uv, float2 dir) {
float3 color = 0.0;
uv -= dir * floor(cGaussianSamples * 0.5);
#line 140
[unroll]
for (int i = 0; i < cGaussianSamples; ++i) {
color += tex2D(sp, uv).rgb * get_weight(i);
uv += dir;
}
#line 146
return color;
}
#line 149
float get_luma_linear(float3 c) {
return dot(c, float3(0.2126, 0.7152, 0.0722));
}
#line 153
float normal_distribution(float x, float mean, float variance) {
const float sigma = variance * variance;
const float a = 1.0 / sqrt(2.0 * cPI * sigma);
float b = x - mean;
b *= b;
b /= 2.0 * sigma;
#line 160
return a * exp(-b);
}
}
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ArcaneBloom.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ArcaneBloom.fx"
#line 11
namespace ArcaneBloom { namespace _ {
#line 132
static const float AspectRatio = 5360 * (1.0 / 1440);
static const float2 PixelSize = float2((1.0 / 5360), (1.0 / 1440));
static const float2 ScreenSize = float2(5360, 1440);
#line 142
uniform float uBloomIntensity <
ui_label = "Intensity";
ui_category = "Bloom";
ui_tooltip = "Default: 1.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 100.0;
ui_step = 0.01;
> = 1.0;
#line 196
uniform float uAdapt_Intensity <
ui_label   = "Intensity";
ui_category = "Adaptation";
ui_tooltip = "Default: 1.0";
ui_type    = "slider";
ui_min     = 0.0;
ui_max     = 1.0;
ui_step    = 0.001;
> = 1.0;
#line 206
uniform float uAdapt_Time <
ui_label   = "Time to Adapt (Seconds)";
ui_category = "Adaptation";
ui_tooltip = "Default: 100.0";
ui_type    = "slider";
ui_min     = 0.01;
ui_max     = 10.0;
ui_step    = 0.01;
> = 1.0;
#line 216
uniform float uAdapt_Sensitivity <
ui_label   = "Sensitivity";
ui_category = "Adaptation";
ui_tooltip = "Default: 1.0";
ui_type    = "slider";
ui_min     = 0.0;
ui_max     = 3.0;
ui_step    = 0.001;
> = 1.0;
#line 226
uniform float uAdapt_Precision <
ui_label   = "Precision";
ui_category = "Adaptation";
ui_tooltip = "Default: 0.0";
ui_type    = "slider";
ui_min     = 0.0;
ui_max     = 11.0;
ui_step    = 0.01;
> = 0.0;
#line 236
uniform bool uAdapt_DoLimits <
ui_label   = "Use Limits";
ui_category = "Adaptation";
ui_tooltip = "Default: On";
> = true;
#line 242
uniform float2 uAdapt_Limits <
ui_label   = "Limits (Min/Max)";
ui_category = "Adaptation";
ui_tooltip = "Default: (0.0, 1.0)";
ui_type    = "slider";
ui_min     = 0.0;
ui_max     = 1.0;
ui_step    = 0.001;
> = float2(0.0, 1.0);
#line 276
uniform float uExposure <
ui_label   = "Exposure";
ui_category = "Miscellaneous";
ui_tooltip = "Default: 1.0";
ui_type    = "slider";
ui_min     = 0.001;
ui_max     = 3.0;
ui_step    = 0.001;
> = 1.0;
#line 286
uniform float uMaxBrightness <
ui_label   = "Max Brightness";
ui_category = "Miscellaneous";
ui_tooltip = "Default: 100.0";
ui_type    = "slider";
ui_min     = 1.0;
ui_max     = 100.0;
ui_step    = 0.1;
> = 100.0;
#line 298
uniform float uWhitePoint <
ui_label = "White Point";
ui_category = "Miscellaneous";
ui_tooltip = "Default: 1.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
ui_step = 0.01;
> = 1.0;
#line 348
uniform float uTime <source = "timer";>;
uniform float uFrameTime <source = "frametime";>;
#line 355
texture2D tArcaneBloom_BackBuffer : COLOR;
sampler2D sBackBuffer {
Texture     = tArcaneBloom_BackBuffer;
#line 359
SRGBTexture = true;
#line 361
};
#line 363
 texture2D tArcaneBloom_Bloom0Alt { Width  = 5360 / 2; Height = 1440 / 2; Format = RGBA16F; }; sampler2D sBloom0Alt { Texture = tArcaneBloom_Bloom0Alt; };
 texture2D tArcaneBloom_Bloom1Alt { Width  = 5360 / 4; Height = 1440 / 4; Format = RGBA16F; }; sampler2D sBloom1Alt { Texture = tArcaneBloom_Bloom1Alt; };
 texture2D tArcaneBloom_Bloom2Alt { Width  = 5360 / 8; Height = 1440 / 8; Format = RGBA16F; }; sampler2D sBloom2Alt { Texture = tArcaneBloom_Bloom2Alt; };
 texture2D tArcaneBloom_Bloom3Alt { Width  = 5360 / 16; Height = 1440 / 16; Format = RGBA16F; }; sampler2D sBloom3Alt { Texture = tArcaneBloom_Bloom3Alt; };
 texture2D tArcaneBloom_Bloom4Alt { Width  = 5360 / 32; Height = 1440 / 32; Format = RGBA16F; }; sampler2D sBloom4Alt { Texture = tArcaneBloom_Bloom4Alt; };
#line 372
texture2D tArcaneBloom_Small {
Width     = 1024;
Height    = 1024;
Format    = R32F;
MipLevels = 11;
};
sampler2D sSmall {
Texture = tArcaneBloom_Small;
};
#line 382
texture2D tArcaneBloom_LastAdapt {
Format = R32F;
};
sampler2D sLastAdapt {
Texture   = tArcaneBloom_LastAdapt;
MinFilter = POINT;
MagFilter = POINT;
MipFilter = POINT;
AddressU  = CLAMP;
AddressV  = CLAMP;
AddressW  = CLAMP;
};
#line 429
float get_bloom_weight(int i) {
#line 433
static const float weights[6] = {
9.0 / 9.0,
6.0 / 9.0,
3.0 / 9.0,
2.0 / 9.0,
6.0 / 9.0,
9.0 / 9.0
};
#line 442
return weights[i];
#line 447
}
#line 449
float3 blend_overlay(float3 a, float3 b, float w) {
const float3 c = lerp(
2.0 * a * b,
1.0 - 2.0 * (1.0 - a) * (1.0 - b),
step(0.5, a)
);
return lerp(a, c, w);
}
#line 473
void VS_PostProcess(
uint id : SV_VERTEXID,
out float4 position : SV_POSITION,
out float2 uv : TEXCOORD
) {
if (id == 2)
uv.x = 2.0;
else
uv.x = 0.0;
if (id == 1)
uv.y = 2.0;
else
uv.y = 0.0;
position = float4(
uv * float2(2.0, -2.0) + float2(-1.0, 1.0),
0.0,
1.0
);
}
#line 493
 float4 PS_GetHDR( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET {
float3 color = tex2D(sBackBuffer, uv).rgb;
#line 509
color = clamp(color, 0.0, 32767.0);
#line 519
color = inv_reinhard_lum(color, 1.0 / uMaxBrightness);
return float4(color, 1.0);
}
#line 533
 float4 PS_GetSmall( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET {
const float3 color = tex2D(sBloom0Alt, uv).rgb;
return float4(get_luma_linear(color), 0.0, 0.0, 1.0);
}
#line 538
 float4 PS_GetAdapt( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET {
float adapt = tex2Dlod(sSmall, float4(uv, 0, 11 - uAdapt_Precision)).x;
adapt *= uAdapt_Sensitivity;
#line 542
if (uAdapt_DoLimits)
adapt = clamp(adapt, uAdapt_Limits.x, uAdapt_Limits.y);
#line 545
float last = tex2D(sLastAdapt, 0).x;
adapt = lerp(last, adapt, (uFrameTime * 0.001) / uAdapt_Time);
#line 548
return float4(adapt, 0.0, 0.0, 1.0);
}
#line 551
 float4 PS_SaveAdapt( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET {
return tex2D(sAdapt, 0);
}
#line 557
  float4 PS_DownSample_Bloom0Alt( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { return float4(box_blur(sBloom0Alt, uv, PixelSize * 2 * 2.0), 1.0); }
  float4 PS_BlurX_Bloom0( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2((1.0 / 5360) * 2 * 0.5, 0.0); return float4(gaussian_blur(sBloom0, uv, dir), 1.0); }  float4 PS_BlurY_Bloom0Alt( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2(0.0, (1.0 / 1440) * 2 * 0.5); return float4(gaussian_blur(sBloom0Alt, uv, dir), 1.0); }
#line 560
  float4 PS_DownSample_Bloom0( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { return float4(box_blur(sBloom0, uv, PixelSize * 4 * 2.0), 1.0); }
  float4 PS_BlurX_Bloom1( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2((1.0 / 5360) * 4 * 1.0, 0.0); return float4(gaussian_blur(sBloom1, uv, dir), 1.0); }  float4 PS_BlurY_Bloom1Alt( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2(0.0, (1.0 / 1440) * 4 * 1.0); return float4(gaussian_blur(sBloom1Alt, uv, dir), 1.0); }
#line 563
  float4 PS_DownSample_Bloom1( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { return float4(box_blur(sBloom1, uv, PixelSize * 8 * 2.0), 1.0); }
  float4 PS_BlurX_Bloom2( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2((1.0 / 5360) * 8 * 1.0, 0.0); return float4(gaussian_blur(sBloom2, uv, dir), 1.0); }  float4 PS_BlurY_Bloom2Alt( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2(0.0, (1.0 / 1440) * 8 * 1.0); return float4(gaussian_blur(sBloom2Alt, uv, dir), 1.0); }
#line 566
  float4 PS_DownSample_Bloom2( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { return float4(box_blur(sBloom2, uv, PixelSize * 16 * 2.0), 1.0); }
  float4 PS_BlurX_Bloom3( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2((1.0 / 5360) * 16 * 2.0, 0.0); return float4(gaussian_blur(sBloom3, uv, dir), 1.0); }  float4 PS_BlurY_Bloom3Alt( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2(0.0, (1.0 / 1440) * 16 * 2.0); return float4(gaussian_blur(sBloom3Alt, uv, dir), 1.0); }
#line 569
  float4 PS_DownSample_Bloom3( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { return float4(box_blur(sBloom3, uv, PixelSize * 32 * 2.0), 1.0); }
  float4 PS_BlurX_Bloom4( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2((1.0 / 5360) * 32 * 3.0, 0.0); return float4(gaussian_blur(sBloom4, uv, dir), 1.0); }  float4 PS_BlurY_Bloom4Alt( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET { const float2 dir = float2(0.0, (1.0 / 1440) * 32 * 3.0); return float4(gaussian_blur(sBloom4Alt, uv, dir), 1.0); }
#line 575
 float4 PS_Blend( float4 position : SV_POSITION, float2 uv       : TEXCOORD ) : SV_TARGET {
float3 color = tex2D(sBackBuffer, uv).rgb;
color = inv_reinhard(color, 1.0 / uMaxBrightness);
#line 579
float3 bloom =
tex2D(sBloom0, uv).rgb * get_bloom_weight(0) +
tex2D(sBloom1, uv).rgb * get_bloom_weight(1) +
tex2D(sBloom2, uv).rgb * get_bloom_weight(2) +
tex2D(sBloom3, uv).rgb * get_bloom_weight(3) +
tex2D(sBloom4, uv).rgb * get_bloom_weight(4);
#line 591
bloom *= uBloomIntensity / uMaxBrightness;
#line 605
color += bloom;
#line 611
const float adapt = tex2D(sAdapt, 0).x;
const float exposure = uExposure / max(adapt, 0.001);
#line 614
color *= lerp(1.0, exposure, uAdapt_Intensity);
#line 617
const float white = uWhitePoint * lerp(1.0, exposure, uAdapt_Intensity);
#line 630
color = reinhard(color);
#line 633
color /= reinhard(white);
#line 641
return float4(color + TriDither(color.rgb, uv, 8), 1.0);
#line 645
}
#line 651
technique ArcaneBloom {
 pass GetHDR { VertexShader = VS_PostProcess; PixelShader  = PS_GetHDR; RenderTarget = tArcaneBloom_Bloom0Alt; }
#line 655
 pass GetSmall { VertexShader = VS_PostProcess; PixelShader  = PS_GetSmall; RenderTarget = tArcaneBloom_Small; }
 pass GetAdapt { VertexShader = VS_PostProcess; PixelShader  = PS_GetAdapt; RenderTarget = tArcaneBloom_Adapt; }
 pass SaveAdapt { VertexShader = VS_PostProcess; PixelShader  = PS_SaveAdapt; RenderTarget = tArcaneBloom_LastAdapt; }
#line 660
  pass DownSample_Bloom0Alt { VertexShader = VS_PostProcess; PixelShader  = PS_DownSample_Bloom0Alt; RenderTarget = tArcaneBloom_Bloom0; }
  pass BlurX_Bloom0 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom0; RenderTarget = tArcaneBloom_Bloom0Alt; }  pass BlurY_Bloom0Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom0Alt; RenderTarget = tArcaneBloom_Bloom0; }  pass BlurX_Bloom0 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom0; RenderTarget = tArcaneBloom_Bloom0Alt; }  pass BlurY_Bloom0Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom0Alt; RenderTarget = tArcaneBloom_Bloom0; }
#line 663
  pass DownSample_Bloom0 { VertexShader = VS_PostProcess; PixelShader  = PS_DownSample_Bloom0; RenderTarget = tArcaneBloom_Bloom1; }
  pass BlurX_Bloom1 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom1; RenderTarget = tArcaneBloom_Bloom1Alt; }  pass BlurY_Bloom1Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom1Alt; RenderTarget = tArcaneBloom_Bloom1; }  pass BlurX_Bloom1 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom1; RenderTarget = tArcaneBloom_Bloom1Alt; }  pass BlurY_Bloom1Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom1Alt; RenderTarget = tArcaneBloom_Bloom1; }
#line 666
  pass DownSample_Bloom1 { VertexShader = VS_PostProcess; PixelShader  = PS_DownSample_Bloom1; RenderTarget = tArcaneBloom_Bloom2; }
  pass BlurX_Bloom2 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom2; RenderTarget = tArcaneBloom_Bloom2Alt; }  pass BlurY_Bloom2Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom2Alt; RenderTarget = tArcaneBloom_Bloom2; }  pass BlurX_Bloom2 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom2; RenderTarget = tArcaneBloom_Bloom2Alt; }  pass BlurY_Bloom2Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom2Alt; RenderTarget = tArcaneBloom_Bloom2; }
#line 669
  pass DownSample_Bloom2 { VertexShader = VS_PostProcess; PixelShader  = PS_DownSample_Bloom2; RenderTarget = tArcaneBloom_Bloom3; }
  pass BlurX_Bloom3 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom3; RenderTarget = tArcaneBloom_Bloom3Alt; }  pass BlurY_Bloom3Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom3Alt; RenderTarget = tArcaneBloom_Bloom3; }  pass BlurX_Bloom3 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom3; RenderTarget = tArcaneBloom_Bloom3Alt; }  pass BlurY_Bloom3Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom3Alt; RenderTarget = tArcaneBloom_Bloom3; }
#line 672
  pass DownSample_Bloom3 { VertexShader = VS_PostProcess; PixelShader  = PS_DownSample_Bloom3; RenderTarget = tArcaneBloom_Bloom4; }
  pass BlurX_Bloom4 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom4; RenderTarget = tArcaneBloom_Bloom4Alt; }  pass BlurY_Bloom4Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom4Alt; RenderTarget = tArcaneBloom_Bloom4; }  pass BlurX_Bloom4 { VertexShader = VS_PostProcess; PixelShader  = PS_BlurX_Bloom4; RenderTarget = tArcaneBloom_Bloom4Alt; }  pass BlurY_Bloom4Alt { VertexShader = VS_PostProcess; PixelShader  = PS_BlurY_Bloom4Alt; RenderTarget = tArcaneBloom_Bloom4; }
#line 678
pass Blend {
VertexShader = VS_PostProcess;
PixelShader = PS_Blend;
#line 682
SRGBWriteEnable = true;
#line 684
}
#line 695
}
#line 697
}}

