#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MagicBloom.fx"
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
#line 66 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MagicBloom.fx"
#line 98
static const int iBlurSamples = 4;
static const int iAdaptResolution =  256;
#line 103
static const float sigma = float(iBlurSamples) / 2.0;
static const float double_pi = 6.283185307179586476925286766559;
static const int lowest_mip =  (((iAdaptResolution) & 0xAAAAAAAA) != 0) | ((((iAdaptResolution) & 0xFFFF0000) != 0) << 4) | ((((iAdaptResolution) & 0xFF00FF00) != 0) << 3) | ((((iAdaptResolution) & 0xF0F0F0F0) != 0) << 2) | ((((iAdaptResolution) & 0xCCCCCCCC) != 0) << 1) + 1;
static const float3 luma_value = float3(0.2126, 0.7152, 0.0722);
#line 110
uniform float fBloom_Intensity <
ui_label = "Bloom Intensity";
ui_tooltip = "Amount of bloom applied to the image.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
ui_step = 0.001;
> = 1.0;
#line 119
uniform float fBloom_Threshold <
ui_label = "Bloom Threshold";
ui_tooltip =
"Thresholds (limits) dark pixels from being accounted for bloom.\n"
"Essentially, it increases the contrast in bloom and blackens darker pixels.\n"
"At 1.0 all pixels are used in bloom.\n"
"This value is not normalized, it is exponential, therefore changes in lower values are more noticeable than at higher values.";
ui_type = "slider";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.1;
> = 2.0;
#line 133
uniform float fDirt_Intensity <
ui_label = "Dirt Intensity";
ui_tooltip =
"Amount of lens dirt applied to bloom.\n"
"Uses a texture called \"MagicBloom_Dirt.png\" from your textures directory(ies).";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.0;
#line 146
uniform float fSaturation <
ui_label = "Saturation";
ui_tooltip =
"Determines the amount of saturation added or removed from the bloom.";
ui_type = "slider";
ui_min = -1.0;
ui_max = 3.0;
ui_step = 0.001;
> = 0.0;
#line 158
uniform float fExposure <
ui_label = "Exposure";
ui_tooltip =
"The target exposure that bloom adapts to.\n"
"It is recommended to just leave it at 0.5, unless you wish for a brighter (1.0) or darker (0.0) image.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.5;
#line 169
uniform float fAdapt_Speed <
ui_label = "Adaptation Speed";
ui_tooltip =
"How quick bloom adapts to changes in the image brightness.\n"
"At 1.0, changes are instantaneous.\n"
"It is recommended to use low values, between 0.01 and 0.1.\n"
"0.1 will provide a quick but natural adaptation.\n"
"0.01 will provide a slow form of adaptation.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 1.0;
ui_step = 0.001;
> = 0.1;
#line 183
uniform float fAdapt_Sensitivity <
ui_label = "Adapt Sensitivity";
ui_tooltip =
"How sensitive adaptation is towards brightness.\n"
"At higher values bloom can get darkened at the slightest amount of brightness.\n"
"At lower values bloom will require a lot of image brightness before it's fully darkened."
"1.0 will not modify the amount of brightness that is accounted for adaptation.\n"
"0.5 is a good value, but may miss certain bright spots.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 3.0;
ui_step = 0.001;
> = 1.0;
#line 197
uniform float2 f2Adapt_Clip <
ui_label = "Adaptation Min/Max";
ui_tooltip =
"Determines the minimum and maximum values that adaptation can determine to ajust bloom.\n"
"Reducing the maximum would cause bloom to be brighter (as it is less adapted).\n"
"Increasing the minimum would cause bloom to be darker (as it is more adapted).\n"
"Keep the maximum above or equal to the minium and vice-versa.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = float2(0.0, 1.0);
#line 210
uniform int iAdapt_Precision <
ui_label = "Adaptation Precision";
ui_tooltip =
"Determins how accurately bloom adapts to the center of image.\n"
"At 0 the adaptation is calculated from the average of the whole image.\n"
"At the highest value (which may vary) adaptation focuses solely on the center pixel(s) of the screen.\n"
"Values closer to 0 are recommended.";
ui_type = "slider";
ui_min = 0;
ui_max = lowest_mip;
ui_step = 0.1;
> = lowest_mip * 0.3;
#line 223
uniform bool bAdapt_IgnoreOccludedByUI <
ui_label = "Ignore Trigger Area if Occluded by UI (FFXIV)";
ui_bind = "MAGICBLOOM_UIOCCLUSION";
> = 0;
#line 241
uniform uint iDebug <
ui_label = "Debug Options";
ui_tooltip = "Contains debugging options like displaying the bloom texture.";
ui_type = "combo";
ui_items = "None\0Display Bloom Texture\0";
> = 0;
#line 250
texture tMagicBloom_1 < pooled = true; > { Width = 3440 / 2; Height = 1440 / 2; Format = RGBA16F; };
texture tMagicBloom_2 < pooled = true; > { Width = 3440 / 4; Height = 1440 / 4; Format = RGBA16F; };
texture tMagicBloom_3 < pooled = true; > { Width = 3440 / 8; Height = 1440 / 8; Format = RGBA16F; };
texture tMagicBloom_4 < pooled = true; > { Width = 3440 / 16; Height = 1440 / 16; Format = RGBA16F; };
texture tMagicBloom_5 < pooled = true; > { Width = 3440 / 32; Height = 1440 / 32; Format = RGBA16F; };
texture tMagicBloom_6 < pooled = true; > { Width = 3440 / 64; Height = 1440 / 64; Format = RGBA16F; };
texture tMagicBloom_7 < pooled = true; > { Width = 3440 / 128; Height = 1440 / 128; Format = RGBA16F; };
texture tMagicBloom_8 < pooled = true; > { Width = 3440 / 256; Height = 1440 / 256; Format = RGBA16F; };
#line 259
texture tMagicBloom_Small { Width = iAdaptResolution; Height = iAdaptResolution; Format = R32F; MipLevels = lowest_mip; };
texture tMagicBloom_Adapt { Format = R32F; };
texture tMagicBloom_LastAdapt { Format = R32F; };
#line 264
texture tMagicBloom_Dirt <source="MagicBloom_Dirt.png";> { Width = 3440; Height = 1440; };
#line 269
sampler sMagicBloom_1 { Texture = tMagicBloom_1; };
sampler sMagicBloom_2 { Texture = tMagicBloom_2; };
sampler sMagicBloom_3 { Texture = tMagicBloom_3; };
sampler sMagicBloom_4 { Texture = tMagicBloom_4; };
sampler sMagicBloom_5 { Texture = tMagicBloom_5; };
sampler sMagicBloom_6 { Texture = tMagicBloom_6; };
sampler sMagicBloom_7 { Texture = tMagicBloom_7; };
sampler sMagicBloom_8 { Texture = tMagicBloom_8; };
#line 278
sampler sMagicBloom_Small { Texture = tMagicBloom_Small; };
sampler sMagicBloom_Adapt { Texture = tMagicBloom_Adapt; MinFilter = POINT; MagFilter = POINT; };
sampler sMagicBloom_LastAdapt { Texture = tMagicBloom_LastAdapt; MinFilter = POINT; MagFilter = POINT; };
#line 283
sampler sMagicBloom_Dirt { Texture = tMagicBloom_Dirt; };
#line 299
float3 blur(sampler sp, float2 uv, float scale) {
float2 ps =  float2((1.0 / 3440), (1.0 / 1440)) * scale;
#line 303
static const float kernel[9] = {
0.0269955, 0.0647588, 0.120985, 0.176033, 0.199471, 0.176033, 0.120985, 0.0647588, 0.0269955
};
static const float accum = 1.02352;
#line 311
float gaussian_weight = 0.0;
float3 col = 0.0;
#line 314
for (int x = -iBlurSamples; x <= iBlurSamples; ++x) {
for (int y = -iBlurSamples; y <= iBlurSamples; ++y) {
#line 317
gaussian_weight = kernel[x + iBlurSamples] * kernel[y + iBlurSamples];
#line 322
col += tex2D(sp, uv + ps * float2(x, y)).rgb * gaussian_weight;
}
}
#line 327
return col * accum;
#line 331
}
#line 338
float3 tonemap(float3 col, float exposure) {
static const float A = 0.15; 
static const float B = 0.50; 
static const float C = 0.10; 
static const float D = 0.20; 
static const float E = 0.02; 
static const float F = 0.30; 
static const float W = 11.2; 
#line 347
col *= exposure;
#line 349
col = ((col * (A * col + C * B) + D * E) / (col * (A * col + B) + D * F)) - E / F;
static const float white = 1.0 / (((W * (A * W + C * B) + D * E) / (W * (A * W + B) + D * F)) - E / F);
col *= white;
return col;
}
#line 355
float3 blend_screen(float3 a, float3 b) {
return 1.0 - (1.0 - a) * (1.0 - b);
}
#line 378
float4 PS_Blur1(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
float3 col = blur(ReShade::BackBuffer, uv, 2.0);
col = pow(abs(col), fBloom_Threshold);
col *= fBloom_Intensity;
#line 383
col = lerp(col, dot(col, luma_value), fSaturation);
#line 385
return float4(col, 1.0);
}
#line 388
float4 PS_Blur2(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return float4(blur(sMagicBloom_1, uv, 4.0), 1.0);
}
#line 392
float4 PS_Blur3(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return float4(blur(sMagicBloom_2, uv, 8.0), 1.0);
}
#line 396
float4 PS_Blur4(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return float4(blur(sMagicBloom_3, uv, 8.0), 1.0);
}
#line 400
float4 PS_Blur5(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return float4(blur(sMagicBloom_4, uv, 16.0), 1.0);
}
#line 404
float4 PS_Blur6(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return float4(blur(sMagicBloom_5, uv, 32.0), 1.0);
}
#line 408
float4 PS_Blur7(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return float4(blur(sMagicBloom_6, uv, 64.0), 1.0);
}
#line 412
float4 PS_Blur8(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return float4(blur(sMagicBloom_7, uv, 128.0), 1.0);
}
#line 417
float4 PS_Blend(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
float3 col = tex2D(ReShade::BackBuffer, uv).rgb;
float3 bloom = tex2D(sMagicBloom_1, uv).rgb
+ tex2D(sMagicBloom_2, uv).rgb
+ tex2D(sMagicBloom_3, uv).rgb
+ tex2D(sMagicBloom_4, uv).rgb
+ tex2D(sMagicBloom_5, uv).rgb
+ tex2D(sMagicBloom_6, uv).rgb
+ tex2D(sMagicBloom_7, uv).rgb
+ tex2D(sMagicBloom_8, uv).rgb;
#line 428
static const float bloom_accum = 1.0 / 8.0;
bloom *= bloom_accum;
#line 432
float exposure = fExposure / max(tex2D(sMagicBloom_Adapt, 0.0).x, 0.00001);
bloom = tonemap(bloom, exposure);
#line 440
float3 dirt = tex2D(sMagicBloom_Dirt, uv).rgb;
dirt *= fDirt_Intensity;
bloom = blend_screen(bloom, dirt * bloom);
#line 445
col = blend_screen(col, bloom);
#line 448
if (iDebug == 1)
col = bloom;
#line 454
return float4(col, 1.0);
#line 456
}
#line 467
float PS_GetSmall(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return dot(tex2D(ReShade::BackBuffer, uv).rgb, luma_value);
}
#line 471
float PS_GetAdapt(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
float curr = tex2Dlod(sMagicBloom_Small, float4(0.5, 0.5, 0, lowest_mip - iAdapt_Precision)).x;
curr *= fAdapt_Sensitivity;
curr = clamp(curr, f2Adapt_Clip.x, f2Adapt_Clip.y);
const float last = tex2D(sMagicBloom_LastAdapt, 0.0).x;
#line 487
return lerp(last, curr, fAdapt_Speed);
}
#line 490
float PS_SaveAdapt(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return tex2D(sMagicBloom_Adapt, 0.0).x;
}
#line 495
technique MagicBloom {
pass Blur1 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur1;
RenderTarget = tMagicBloom_1;
}
pass Blur2 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur2;
RenderTarget = tMagicBloom_2;
}
pass Blur3 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur3;
RenderTarget = tMagicBloom_3;
}
pass Blur4 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur4;
RenderTarget = tMagicBloom_4;
}
pass Blur5 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur5;
RenderTarget = tMagicBloom_5;
}
pass Blur6 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur6;
RenderTarget = tMagicBloom_6;
}
pass Blur7 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur7;
RenderTarget = tMagicBloom_7;
}
pass Blur8 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur8;
RenderTarget = tMagicBloom_8;
}
pass Blend {
VertexShader = PostProcessVS;
PixelShader = PS_Blend;
}
#line 541
pass GetSmall {
VertexShader = PostProcessVS;
PixelShader = PS_GetSmall;
RenderTarget = tMagicBloom_Small;
}
pass GetAdapt {
VertexShader = PostProcessVS;
PixelShader = PS_GetAdapt;
RenderTarget = tMagicBloom_Adapt;
}
pass SaveAdapt {
VertexShader = PostProcessVS;
PixelShader = PS_SaveAdapt;
RenderTarget = tMagicBloom_LastAdapt;
}
#line 557
}

