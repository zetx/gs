#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PandaFX.fx"
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
#line 16 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PandaFX.fx"
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
#line 19 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PandaFX.fx"
#line 26
uniform float Blend_Amount <
ui_label = "Blend Amount";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_tooltip = "Blend the effect with the original image.";
ui_category = "General Settings";
> = 1.0;
#line 35
uniform float Contrast_R <
ui_label = "Contrast (Red)";
ui_type = "slider";
ui_min = 0.00001;
ui_max = 20.0;
ui_tooltip = "Apply contrast to red.";
ui_category = "General Settings";
> = 2.2;
#line 44
uniform float Contrast_G <
ui_label = "Contrast (Green)";
ui_type = "slider";
ui_min = 0.00001;
ui_max = 20.0;
ui_tooltip = "Apply contrast to green.";
ui_category = "General Settings";
> = 2.0;
#line 53
uniform float Contrast_B <
ui_label = "Contrast (Blue)";
ui_type = "slider";
ui_min = 0.00001;
ui_max = 20.0;
ui_tooltip = "Apply contrast to blue.";
ui_category = "General Settings";
> = 2.0;
#line 62
uniform float Gamma_R <
ui_label = "Gamma (Red)";
ui_type = "slider";
ui_min = 0.02;
ui_max = 5.0;
ui_tooltip = "Apply Gamma to red.";
ui_category = "General Settings";
> = 1.0;
#line 71
uniform float Gamma_G <
ui_label = "Gamma (Green)";
ui_type = "slider";
ui_min = 0.02;
ui_max = 5.0;
ui_tooltip = "Apply Gamma to green.";
ui_category = "General Settings";
> = 1.0;
#line 80
uniform float Gamma_B <
ui_label = "Gamma (Blue)";
ui_type = "slider";
ui_min = 0.02;
ui_max = 5.0;
ui_tooltip = "Apply Gamma to blue.";
ui_category = "General Settings";
> = 1.0;
#line 89
uniform bool Enable_Diffusion <
ui_label = "Enable the lens diffusion effect";
ui_tooltip = "Enable a light diffusion that emulates the glare of a camera lens.";
ui_category = "Lens Diffusion";
ui_bind = "PANDAFX_ENABLE_DIFFUSION";
> = true;
#line 101
uniform bool Enable_Static_Dither <
ui_label = "Apply static dither";
ui_tooltip = "Dither the diffusion. Only applies a static dither image texture.";
ui_category = "Lens Diffusion";
ui_bind = "PANDAFX_ENABLE_STATIC_DITHER";
> = true;
#line 112
uniform float Diffusion_1_Amount <
ui_label = "Diffusion 1 Amount";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_tooltip = "Adjust the amount of the first diffusion layer.";
ui_category = "Lens Diffusion";
> = 0.5;
#line 121
uniform int Diffusion_1_Radius <
ui_label = "Diffusion 1 Radius";
ui_type = "slider";
ui_min = 5;
ui_max = 20;
ui_tooltip = "Set the radius of the first diffusion layer.";
ui_category = "Lens Diffusion";
ui_bind = "PANDAFX_DIFFUSION_1_RADIUS";
> = 8;
#line 135
uniform float Diffusion_1_Gamma <
ui_label = "Diffusion 1 Gamma";
ui_type = "slider";
ui_min = 0.02;
ui_max = 5.0;
ui_tooltip = "Apply Gamma to first diffusion layer.";
ui_category = "Lens Diffusion";
> = 2.2;
#line 144
uniform float Diffusion_1_Quality <
ui_label = "Diffusion 1 sampling quality";
#line 149
ui_tooltip = "Set the quality of the first diffusion layer. Number is the divider of how many times the texture size is divided in half. Lower number = higher quality, but more processing needed. (No need to adjust this.)";
ui_category = "Lens Diffusion";
> = 2;
#line 153
uniform float Diffusion_1_Desaturate <
ui_label = "Diffusion 1 desaturation";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_tooltip = "Adjust the saturation of the first diffusion layer.";
ui_category = "Lens Diffusion";
> = 0.0;
#line 162
uniform float Diffusion_2_Amount <
ui_label = "Diffusion 2 Amount";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_tooltip = "Adjust the amount of the second diffusion layer.";
ui_category = "Lens Diffusion";
> = 0.5;
#line 171
uniform int Diffusion_2_Radius <
ui_label = "Diffusion 2 Radius";
ui_type = "slider";
ui_min = 5;
ui_max = 20;
ui_tooltip = "Set the radius of the second diffusion layer.";
ui_category = "Lens Diffusion";
ui_bind = "PANDAFX_DIFFUSION_2_RADIUS";
> = 8;
#line 185
uniform float Diffusion_2_Gamma <
ui_label = "Diffusion 2 Gamma";
ui_type = "slider";
ui_min = 0.02;
ui_max = 5.0;
ui_tooltip = "Apply Gamma to second diffusion layer.";
ui_category = "Lens Diffusion";
> = 1.3;
#line 194
uniform float Diffusion_2_Quality <
ui_label = "Diffusion 2 sampling quality";
#line 199
ui_tooltip = "Set the quality of the second diffusion layer. Number is the divider of how many times the texture size is divided in half. Lower number = higher quality, but more processing needed. (No need to adjust this.)";
ui_category = "Lens Diffusion";
> = 16;
#line 203
uniform float Diffusion_2_Desaturate <
ui_label = "Diffusion 2 desaturation";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_tooltip = "Adjust the saturation of the second diffusion layer.";
ui_category = "Lens Diffusion";
> = 0.5;
#line 212
uniform float Diffusion_3_Amount <
ui_label = "Diffusion 3 Amount";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_tooltip = "Adjust the amount of the third diffusion layer.";
ui_category = "Lens Diffusion";
> = 0.5;
#line 221
uniform int Diffusion_3_Radius <
ui_label = "Diffusion 3 Radius";
ui_type = "slider";
ui_min = 5;
ui_max = 20;
ui_tooltip = "Set the radius of the third diffusion layer.";
ui_category = "Lens Diffusion";
ui_bind = "PANDAFX_DIFFUSION_3_RADIUS";
> = 8;
#line 235
uniform float Diffusion_3_Gamma <
ui_label = "Diffusion 3 Gamma";
ui_type = "slider";
ui_min = 0.02;
ui_max = 5.0;
ui_tooltip = "Apply Gamma to third diffusion layer.";
ui_category = "Lens Diffusion";
> = 1.0;
#line 244
uniform float Diffusion_3_Quality <
ui_label = "Diffusion 3 sampling quality";
#line 249
ui_tooltip = "Set the quality of the third diffusion layer. Number is the divider of how many times the texture size is divided in half. Lower number = higher quality, but more processing needed. (No need to adjust this.)";
ui_category = "Lens Diffusion";
> = 64;
#line 253
uniform float Diffusion_3_Desaturate <
ui_label = "Diffusion 3 desaturation";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_tooltip = "Adjust the saturation of the third diffusion layer.";
ui_category = "Lens Diffusion";
> = 0.75;
#line 263
uniform bool Enable_Bleach_Bypass <
ui_label = "Enable the 'Bleach Bypass' effect";
ui_tooltip = "Enable a cinematic contrast effect that emulates a bleach bypass on film. Used a lot in war movies and gives the image a grittier feel.";
ui_category = "Bleach Bypass";
ui_bind = "PANDAFX_ENABLE_BLEACH_BYPASS";
> = true;
#line 275
uniform float Bleach_Bypass_Amount <
ui_label = "Bleach Bypass Amount";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_tooltip = "Adjust the amount of the third diffusion layer.";
ui_category = "Bleach Bypass";
> = 0.5;
#line 285
uniform bool Enable_Dither <
ui_label = "Dither the final output";
ui_tooltip = "Dither the final result of the shader. Leave disabled to use GShade's TriDither implementation.";
ui_category = "Legacy Settings";
ui_bind = "PANDAFX_ENABLE_DITHER";
> = false;
#line 307
uniform float framecount < source = "framecount"; >;
#line 313
texture NoiseTex <source = "hd_noise.png"; > { Width = 1920; Height = 1080; Format = RGBA8; };
texture prePassLayer { Width = 792; Height = 710; Format = RGBA8; };
texture blurLayerHorizontal { Width = 792 / 2; Height = 710 / 2; Format = RGBA8; };
texture blurLayerVertical { Width = 792 / 2; Height = 710 / 2; Format = RGBA8; };
texture blurLayerHorizontalMedRes { Width = 792 / 16; Height = 710 / 16; Format = RGBA8; };
texture blurLayerVerticalMedRes { Width = 792 / 16; Height = 710 / 16; Format = RGBA8; };
texture blurLayerHorizontalLoRes { Width = 792 / 64; Height = 710 / 64; Format = RGBA8; };
texture blurLayerVerticalLoRes { Width = 792 / 64; Height = 710 / 64; Format = RGBA8; };
#line 324
sampler NoiseSampler { Texture = NoiseTex; };
sampler2D PFX_PrePassLayer { Texture = prePassLayer; };
#line 327
sampler2D PFX_blurHorizontalLayer {	Texture = blurLayerHorizontal; };
sampler2D PFX_blurVerticalLayer { Texture = blurLayerVertical; };
sampler2D PFX_blurHorizontalLayerMedRes { Texture = blurLayerHorizontalMedRes; };
sampler2D PFX_blurVerticalLayerMedRes {	Texture = blurLayerVerticalMedRes; };
sampler2D PFX_blurHorizontalLayerLoRes { Texture = blurLayerHorizontalLoRes; };
sampler2D PFX_blurVerticalLayerLoRes { Texture = blurLayerVerticalLoRes; };
#line 337
float AdjustableSigmoidCurve (float value, float amount) {
#line 339
float curve = 1.0;
#line 341
if (value < 0.5)
{
curve = pow(value, amount) * pow(2.0, amount) * 0.5;
}
#line 346
else
{
curve = 1.0 - pow(max(0.0, 1.0 - value), amount) * pow(2.0, amount) * 0.5;
}
#line 351
return curve;
}
#line 354
float Randomize (float2 coord) {
return clamp((frac(sin(dot(coord, float2(12.9898, 78.233))) * 43758.5453)), 0.0, 1.0);
}
#line 358
float SigmoidCurve (float value) {
const value = value * 2.0 - 1.0;
return -value * abs(value) * 0.5 + value + 0.5;
}
#line 363
float SoftLightBlend (float A, float B) {
#line 365
if (A > 0.5)
{
return (2 * A - 1) * (sqrt(B) - B) + B;
}
#line 370
else
{
return (2 * A - 1) * (B - (B * 2)) + B;
}
#line 375
return 0;
}
#line 378
float4 BlurH (sampler input, float2 uv, float radius, float sampling) {
#line 381
float2 coordinate = float2(0.0, 0.0);
float4 A = float4(0.0, 0.0, 0.0, 1.0);
float4 C = float4(0.0, 0.0, 0.0, 1.0);
float weight = 1.0;
const float width = 1.0 / 792 * sampling;
float divisor = 0.000001;
#line 388
for (float x = -radius; x <= radius; x++)
{
coordinate = uv + float2(x * width, 0.0);
coordinate = clamp(coordinate, 0.0, 1.0);
A = tex2Dlod(input, float4(coordinate, 0.0, 0.0));
weight = SigmoidCurve(1.0 - (abs(x) / radius));
C += A * weight;
divisor += weight;
}
#line 398
return C / divisor;
}
#line 401
float4 BlurV (sampler input, float2 uv, float radius, float sampling) {
#line 403
float2 coordinate = float2(0.0, 0.0);
float4 A = float4(0.0, 0.0, 0.0, 1.0);
float4 C = float4(0.0, 0.0, 0.0, 1.0);
float weight = 1.0;
const float height = 1.0 / 710 * sampling;
float divisor = 0.000001;
#line 410
for (float y = -radius; y <= radius; y++)
{
coordinate = uv + float2(0.0, y * height);
coordinate = clamp(coordinate, 0.0, 1.0);
A = tex2Dlod(input, float4(coordinate, 0.0, 0.0));
weight = SigmoidCurve(1.0 - (abs(y) / radius));
C += A * weight;
divisor += weight;
}
#line 420
return C / divisor;
}
#line 424
void PS_PrePass (float4 pos : SV_Position,
float2 uv : TEXCOORD,
out float4 result : SV_Target)
{
#line 429
float4 A = tex2D(ReShade::BackBuffer, uv);
A.r = pow(max(0.0, A.r), Gamma_R);
A.g = pow(max(0.0, A.g), Gamma_G);
A.b = pow(max(0.0, A.b), Gamma_B);
A.r = AdjustableSigmoidCurve(A.r, Contrast_R);
A.g = AdjustableSigmoidCurve(A.g, Contrast_G);
A.b = AdjustableSigmoidCurve(A.b, Contrast_B);
#line 439
A.g = A.g * 0.8 + A.b * 0.2;
#line 441
float red = A.r - A.g - A.b;
float green = A.g - A.r - A.b;
float blue = A.b - A.r - A.g;
#line 445
red = clamp(red, 0.0, 1.0);
green = clamp(green, 0.0, 1.0);
blue = clamp(blue, 0.0, 1.0);
#line 449
A = A * (1.0 - red * 0.6);
A = A * (1.0 - green * 0.8);
A = A * (1.0 - blue * 0.3);
#line 456
result = A;
}
#line 461
void PS_HorizontalPass (float4 pos : SV_Position,
float2 uv : TEXCOORD, out float4 result : SV_Target)
{
result = BlurH(PFX_PrePassLayer, uv, Diffusion_1_Radius, Diffusion_1_Quality);
#line 466
}
#line 468
void PS_VerticalPass (float4 pos : SV_Position,
float2 uv : TEXCOORD, out float4 result : SV_Target)
{
result = BlurV(PFX_blurHorizontalLayer, uv, Diffusion_1_Radius, Diffusion_1_Quality);
}
#line 474
void PS_HorizontalPassMedRes (float4 pos : SV_Position,
float2 uv : TEXCOORD, out float4 result : SV_Target)
{
result = BlurH(PFX_blurVerticalLayer, uv, Diffusion_2_Radius, Diffusion_2_Quality);
}
#line 480
void PS_VerticalPassMedRes (float4 pos : SV_Position,
float2 uv : TEXCOORD, out float4 result : SV_Target)
{
result = BlurV(PFX_blurHorizontalLayerMedRes, uv, Diffusion_2_Radius, Diffusion_2_Quality);
}
#line 486
void PS_HorizontalPassLoRes (float4 pos : SV_Position,
float2 uv : TEXCOORD, out float4 result : SV_Target)
{
result = BlurH(PFX_blurVerticalLayerMedRes, uv, Diffusion_3_Radius, Diffusion_3_Quality);
}
#line 492
void PS_VerticalPassLoRes (float4 pos : SV_Position,
float2 uv : TEXCOORD, out float4 result : SV_Target)
{
result = BlurV(PFX_blurHorizontalLayerLoRes, uv, Diffusion_3_Radius, Diffusion_3_Quality);
}
#line 502
float4 PandaComposition (float4 vpos : SV_Position,
float2 uv : TEXCOORD) : SV_Target
{
#line 508
float4 blurLayer;
float4 blurLayerMedRes;
float4 blurLayerLoRes;
#line 513
blurLayer = tex2D(PFX_blurVerticalLayer, uv);
blurLayerMedRes = tex2D(PFX_blurVerticalLayerMedRes, uv);
blurLayerLoRes = tex2D(PFX_blurVerticalLayerLoRes, uv);
#line 520
const float4 blurLayerGray = dot(0.3333, blurLayer.rgb);
blurLayer = lerp(blurLayer, blurLayerGray, Diffusion_2_Desaturate);
#line 523
const float4 blurLayerMedResGray = dot(0.3333, blurLayerMedRes.rgb);
blurLayerMedRes = lerp(blurLayerMedRes, blurLayerMedResGray, Diffusion_2_Desaturate);
#line 526
const float4 blurLayerLoResGray = dot(0.3333, blurLayerLoRes.rgb);
blurLayerLoRes = lerp(blurLayerLoRes, blurLayerLoResGray, Diffusion_3_Desaturate);
#line 538
blurLayer *= Diffusion_1_Amount;
blurLayerMedRes *= Diffusion_2_Amount;
blurLayerLoRes *= Diffusion_3_Amount;
#line 542
blurLayer = pow(max(0.0, blurLayer), Diffusion_1_Gamma);
blurLayerMedRes = pow(max(0.0, blurLayerMedRes), Diffusion_2_Gamma);
blurLayerLoRes = pow(max(0.0, blurLayerLoRes), Diffusion_3_Gamma);
#line 547
const float3 hd_noise = 1.0 - (tex2D(NoiseSampler, uv).rgb * 0.01);
blurLayer.rgb = 1.0 - hd_noise * (1.0 - blurLayer.rgb);
blurLayerMedRes.rgb = 1.0 - hd_noise * (1.0 - blurLayerMedRes.rgb);
blurLayerLoRes.rgb = 1.0 - hd_noise * (1.0 - blurLayerLoRes.rgb);
#line 557
float4 A = tex2D(PFX_PrePassLayer, uv);
const float4 O = tex2D(ReShade::BackBuffer, uv);
#line 563
blurLayer = clamp(blurLayer, 0.0, 1.0);
blurLayerMedRes = clamp(blurLayerMedRes, 0.0, 1.0);
blurLayerLoRes = clamp(blurLayerLoRes, 0.0, 1.0);
#line 567
A.rgb = 1.0 - (1.0 - blurLayer.rgb) * (1.0 - A.rgb);
A.rgb = 1.0 - (1.0 - blurLayerMedRes.rgb) * (1.0 - A.rgb);
A.rgb = 1.0 - (1.0 - blurLayerLoRes.rgb) * (1.0 - A.rgb);
#line 576
const float Ag = dot(float3(0.3333, 0.3333, 0.3333), A.rgb);
float4 B = A;
float4 C = 0;
#line 580
if (Ag > 0.5)
{
C = 1 - 2 * (1 - Ag) * (1 - B);
}
#line 585
else
{
C = 2 * Ag * B;
}
#line 590
C = pow(max(0.0, C), 0.6);
A = lerp(A, C, Bleach_Bypass_Amount);
#line 618
const float4 outcolor = lerp(O, A, Blend_Amount);
return float4(outcolor.rgb + TriDither(outcolor.rgb, uv, 8), outcolor.a);
#line 623
}
#line 628
technique PandaFX
{
pass PreProcess
{
VertexShader = PostProcessVS;
PixelShader = PS_PrePass;
RenderTarget = prePassLayer;
}
#line 638
pass HorizontalPass
{
VertexShader = PostProcessVS;
PixelShader = PS_HorizontalPass;
RenderTarget = blurLayerHorizontal;
}
#line 645
pass VerticalPass
{
VertexShader = PostProcessVS;
PixelShader = PS_VerticalPass;
RenderTarget = blurLayerVertical;
}
#line 652
pass HorizontalPassMedRes
{
VertexShader = PostProcessVS;
PixelShader = PS_HorizontalPassMedRes;
RenderTarget = blurLayerHorizontalMedRes;
}
#line 659
pass VerticalPassMedRes
{
VertexShader = PostProcessVS;
PixelShader = PS_VerticalPassMedRes;
RenderTarget = blurLayerVerticalMedRes;
}
#line 666
pass HorizontalPassLoRes
{
VertexShader = PostProcessVS;
PixelShader = PS_HorizontalPassLoRes;
RenderTarget = blurLayerHorizontalLoRes;
}
#line 673
pass VerticalPassLoRes
{
VertexShader = PostProcessVS;
PixelShader = PS_VerticalPassLoRes;
RenderTarget = blurLayerVerticalLoRes;
}
#line 681
pass CustomPass
{
VertexShader = PostProcessVS;
PixelShader = PandaComposition;
}
}
