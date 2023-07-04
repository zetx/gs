#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CRT_Lottes.fx"
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CRT_Lottes.fx"
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
#line 12 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CRT_Lottes.fx"
#line 60
uniform float2 f2Warp <
ui_label = "Scanline Warp";
ui_type  = "slider";
ui_min   = 0.0;
ui_max   = 64.0;
ui_step  = 0.01;
> = float2(48.0, 24.0);
#line 68
uniform float fThin <
ui_label = "Scanline Thinness";
ui_type  = "slider";
ui_min   = 0.5;
ui_max   = 1.0;
ui_step  = 0.001;
> = 0.7;
#line 76
uniform float fBlur <
ui_label = "Horizontal Scan Blur";
ui_type  = "slider";
ui_min   = 1.0;
ui_max   = 3.0;
ui_step  = 0.001;
> = 2.5;
#line 84
uniform float fMask <
ui_label = "Shadow Mask";
ui_type  = "slider";
ui_min   = 0.25;
ui_max   = 1.0;
ui_step  = 0.001;
> = 0.5;
#line 113
uniform float fDownscale <
ui_label = "Resolution Downscale";
ui_type  = "slider";
ui_min   = 1.0;
ui_max   = 256.0;
ui_step  = 0.25;
> = 2.0;
#line 149
sampler2D sBackBuffer_Scale {
Texture     = ReShade::BackBufferTex;
SRGBTexture = true;
#line 153
MinFilter   = LINEAR;
#line 157
MagFilter   = POINT;
};
#line 161
sampler2D sBackBuffer_CRT {
Texture     = ReShade::BackBufferTex;
SRGBTexture = true;
MinFilter   = LINEAR;
MagFilter   = LINEAR;
};
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CRT_Lottes.fxh"
#line 126
float CrtsMax3F1(float a, float b, float c)
{
return max(a, max(b, c));
}
#line 137
float4 CrtsTone(
float contrast,
float saturation,
float thin,
float mask){
#line 150
mask = 0.5 + mask * 0.5;
#line 153
float4 ret;
const float midOut = 0.18 / ((1.5 - thin) * (0.5 * mask + 0.5));
const float pMidIn = pow(0.18, contrast);
ret.x = contrast;
ret.y = ((-pMidIn) + midOut) / ((1.0 - pMidIn) * midOut);
ret.z = ((-pMidIn) * midOut + pMidIn) / (midOut * (-pMidIn) + midOut);
ret.w = contrast + saturation;
return ret;}
#line 190
float3 CrtsMask(float2 pos, float dark){
#line 204
float3 m = float3(1.0, 1.0, 1.0);
const float x = frac(pos.x * (1.0 / 3.0));
if(x < (1.0 / 3.0))
m.r = dark;
else if(x < (2.0 / 3.0))
m.g = dark;
else
m.b = dark;
return m;
#line 231
}
#line 266
float3 CrtsFilter(
#line 269
float2 ipos,
#line 272
float2 inputSizeDivOutputSize,
#line 275
float2 halfInputSize,
#line 278
float2 rcpInputSize,
#line 281
float2 rcpOutputSize,
#line 284
float2 twoDivOutputSize,
#line 287
float inputHeight,
#line 294
float2 warp,
#line 301
float thin,
#line 308
float blur,
#line 315
float mask,
#line 318
float4 tone
#line 320
){
#line 336
float2 pos;
#line 339
pos = ipos * twoDivOutputSize - float2(1.0, 1.0);
#line 341
pos *= float2(
1.0 + (pos.y * pos.y) * warp.x,
1.0 + (pos.x * pos.x) * warp.y);
#line 345
float vin = 1.0 - (
(1.0 -  saturate(pos.x * pos.x)) * (1.0 -  saturate(pos.y * pos.y)));
vin =  saturate((-vin) * inputHeight + inputHeight);
#line 349
pos = pos * halfInputSize + halfInputSize;
#line 355
float y0 = floor(pos.y - 0.5) + 0.5;
#line 371
const float x0 = floor(pos.x - 1.5) + 0.5;
#line 373
float2 p = float2(x0 * rcpInputSize.x, y0 * rcpInputSize.y);
#line 375
const float3 colA0 =  tex2D(sBackBuffer_CRT, p).rgb;
p.x += rcpInputSize.x;
float3 colA1 =  tex2D(sBackBuffer_CRT, p).rgb;
p.x += rcpInputSize.x;
float3 colA2 =  tex2D(sBackBuffer_CRT, p).rgb;
p.x += rcpInputSize.x;
float3 colA3 =  tex2D(sBackBuffer_CRT, p).rgb;
p.y += rcpInputSize.y;
float3 colB3 =  tex2D(sBackBuffer_CRT, p).rgb;
p.x -= rcpInputSize.x;
float3 colB2 =  tex2D(sBackBuffer_CRT, p).rgb;
p.x -= rcpInputSize.x;
float3 colB1 =  tex2D(sBackBuffer_CRT, p).rgb;
p.x -= rcpInputSize.x;
const float3 colB0 =  tex2D(sBackBuffer_CRT, p).rgb;
#line 395
const float off = pos.y - y0;
float scanA = cos(min(0.5,  off * thin     ) * 6.28318530717958) * 0.5 + 0.5;
float scanB = cos(min(0.5, (-off) * thin + thin) * 6.28318530717958) * 0.5 + 0.5;
#line 409
const float off0 = pos.x - x0;
const float off1 = off0 - 1.0;
const float off2 = off0 - 2.0;
const float off3 = off0 - 3.0;
const float pix0 = exp2(blur * off0 * off0);
const float pix1 = exp2(blur * off1 * off1);
const float pix2 = exp2(blur * off2 * off2);
const float pix3 = exp2(blur * off3 * off3);
float pixT =  (1.0 / (pix0 + pix1 + pix2 + pix3));
#line 420
pixT *= vin;
#line 422
scanA *= pixT;
scanB *= pixT;
#line 425
float3 color =
(colA0 * pix0 + colA1 * pix1 + colA2 * pix2 + colA3 * pix3) * scanA +
(colB0 * pix0 + colB1 * pix1 + colB2 * pix2 + colB3 * pix3) * scanB;
#line 431
color *= CrtsMask(ipos, mask);
#line 436
float peak = max(1.0 / (256.0 * 65536.0),
CrtsMax3F1(color.r, color.g, color.b));
#line 439
float3 ratio = color *  (1.0 / (peak));
#line 442
peak = pow(peak, tone.x);
#line 444
peak = peak *  (1.0 / (peak * tone.y + tone.z));
#line 447
ratio = pow(ratio, float3(tone.w, tone.w, tone.w));
#line 450
return ratio * peak;
#line 455
}
#line 170 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CRT_Lottes.fx"
#line 175
float2 scale_uv(float2 uv, float2 scale, float2 center) {
return (uv - center) * scale + center;
}
#line 179
float2 scale_uv(float2 uv, float2 scale) {
return scale_uv(uv, scale, 0.5);
}
#line 187
void PS_Downscale(
float4 position  : SV_POSITION,
float2 uv        : TEXCOORD,
out float4 color : SV_TARGET
) {
color = tex2D(sBackBuffer_Scale, scale_uv(uv,  fDownscale));
}
#line 195
void PS_Upscale(
float4 position  : SV_POSITION,
float2 uv        : TEXCOORD,
out float4 color : SV_TARGET
) {
color = tex2D(sBackBuffer_Scale, scale_uv(uv, 1.0 /  fDownscale));
}
#line 204
void PS_CRT_Lottes(
float4 position  : SV_POSITION,
float2 uv        : TEXCOORD,
out float4 color : SV_TARGET
) {
color.a = 1.0;
color.rgb = CrtsFilter(
uv * ReShade:: GetScreenSize(),
 (ReShade:: GetScreenSize() / fDownscale) * ReShade:: GetPixelSize(),
 (ReShade:: GetScreenSize() / fDownscale) * 0.5,
1.0 /  (ReShade:: GetScreenSize() / fDownscale),
ReShade:: GetPixelSize(),
ReShade:: GetPixelSize() * 2.0,
 (float(1440) / fDownscale),
1.0 / f2Warp,
fThin,
-fBlur,
fMask,
CrtsTone(1.0, 0.0, fThin, fMask)
);
#line 225
color.rgb += TriDither(color.rgb, uv, 8);
#line 227
}
#line 231
technique CRT_Lottes {
#line 233
pass Downscale {
VertexShader    = PostProcessVS;
PixelShader     = PS_Downscale;
SRGBWriteEnable = true;
}
pass Upscale {
VertexShader    = PostProcessVS;
PixelShader     = PS_Upscale;
SRGBWriteEnable = true;
}
#line 244
pass CRT_Lottes {
VertexShader    = PostProcessVS;
PixelShader     = PS_CRT_Lottes;
SRGBWriteEnable = true;
}
}

