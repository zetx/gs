#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SSAO.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1281 * (1.0 / 721); }
float2 GetPixelSize() { return float2((1.0 / 1281), (1.0 / 721)); }
float2 GetScreenSize() { return float2(1281, 721); }
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
#line 23 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SSAO.fx"
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
#line 26 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SSAO.fx"
#line 42
uniform float AO_TEXSCALE <
ui_label = "Scale";
ui_category = "Global Parameters";
ui_tooltip = "Scale of AO resolution, 1.0 means fullscreen. Lower resolution means less pixels to process and more performance but also less quality.";
ui_type = "slider";
ui_min = 0.25;
ui_max = 1.0;
ui_step = 0.01;
> = 1.0;
#line 52
uniform float AO_SHARPNESS <
ui_label = "Sharpness";
ui_category = "Global Parameters";
ui_type = "slider";
ui_min = 0.05;
ui_max = 2.0;
ui_step = 0.01;
> = 0.70;
#line 61
uniform bool AO_SHARPNESS_DETECT <
ui_label = "Sharpness Detection";
ui_category = "Global Parameters";
ui_tooltip = "AO must not blur over object edges. Off : edge detection by depth (old) On : edge detection by normal (new). 2 is better but produces some black outlines.";
> = 1;
#line 67
uniform int AO_BLUR_STEPS <
ui_label = "Blur Steps";
ui_category = "Global Parameters";
ui_tooltip = "Offset count for AO smoothening. Higher means more smooth AO but also blurrier AO.";
ui_type = "slider";
ui_min = 5;
ui_max = 15;
ui_step = 1;
> = 11;
#line 77
uniform int AO_DEBUG <
ui_label = "Debug";
ui_type = "combo";
ui_items = "Debug Off\0Ambient Occlusion Debug\0Global Illumination Debug\0";
ui_category = "Global Parameters";
ui_tooltip = "AO must not blur over object edges. Off : edge detection by depth (old) On : edge detection by normal (new). 2 is better but produces some black outlines.";
> = 0;
#line 85
uniform bool AO_LUMINANCE_CONSIDERATION <
ui_label = "Luminance Consideration";
ui_category = "Global Parameters";
> = 1;
#line 90
uniform float AO_LUMINANCE_LOWER <
ui_label = "Luminance Lower";
ui_category = "Global Parameters";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.3;
#line 99
uniform float AO_LUMINANCE_UPPER <
ui_label = "Luminance Upper";
ui_category = "Global Parameters";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.6;
#line 108
uniform float AO_FADE_START <
ui_label = "Fade Start";
ui_category = "Global Parameters";
ui_tooltip = "Distance from camera where AO starts to fade out. 0.0 means camera itself, 1.0 means infinite distance.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.4;
#line 118
uniform float AO_FADE_END <
ui_label = "Fade End";
ui_category = "Global Parameters";
ui_tooltip = "Distance from camera where AO fades out completely. 0.0 means camera itself, 1.0 means infinite distance.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.6;
#line 128
uniform int iSSAOSamples <
ui_label = "SSAO Samples";
ui_category = "SSAO Settings";
ui_tooltip = "Amount of samples. Don't set too high or shader compilation time goes through the roof.";
ui_type = "slider";
ui_min = 16;
ui_max = 128;
ui_step = 8;
> = 16;
#line 138
uniform bool iSSAOSmartSampling <
ui_label = "SSAO Smart Sampling";
ui_category = "SSAO Settings";
> = 0;
#line 143
uniform float fSSAOSamplingRange <
ui_label = "SSAO Sampling Range";
ui_category = "SSAO Settings";
ui_tooltip = "SSAO sampling range. High range values might need more samples so raise both.";
ui_type = "slider";
ui_min = 10.0;
ui_max = 50.0;
ui_step = 0.1;
> = 50.0;
#line 153
uniform float fSSAODarkeningAmount <
ui_label = "SSAO Darkening Amount";
ui_category = "SSAO Settings";
ui_tooltip = "Amount of SSAO corner darkening.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 5.0;
ui_step = 0.001;
> = 1.5;
#line 163
uniform float fSSAOBrighteningAmount <
ui_label = "SSAO Brightening Amount";
ui_category = "SSAO Settings";
ui_tooltip = "Amount of SSAO edge brightening.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 5.0;
ui_step = 0.001;
> = 1.0;
#line 173
uniform int iRayAOSamples <
ui_label = "RayAO Samples";
ui_category = "Raymarch AO Settings";
ui_tooltip = "Amount of sample \"rays\" Higher means more accurate AO but also less performance.";
ui_type = "slider";
ui_min = 10;
ui_max = 78;
ui_step = 1;
> = 24;
#line 183
uniform float fRayAOSamplingRange <
ui_label = "RayAO Sampling Range";
ui_category = "Raymarch AO Settings";
ui_tooltip = "Range of AO sampling. Higher values ignore small geometry details and shadow more globally.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 0.025;
ui_step = 0.001;
> = 0.001;
#line 193
uniform float fRayAOMaxDepth <
ui_label = "RayAO Max Depth";
ui_category = "Raymarch AO Settings";
ui_tooltip = "Factor to avoid far objects to occlude close objects just because they are besides each other on screen.";
ui_type = "slider";
ui_min = 0.01;
ui_max = 0.02;
ui_step = 0.001;
> = 0.02;
#line 203
uniform float fRayAOMinDepth  <
ui_label = "RayAO Min Depth";
ui_category = "Raymarch AO Settings";
ui_tooltip = "Minimum depth difference cutoff to prevent (almost) flat surfaces to occlude themselves.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 0.02;
ui_step = 0.001;
> = 0.001;
#line 213
uniform float fRayAOPower  <
ui_label = "RayAO Power";
ui_category = "Raymarch AO Settings";
ui_tooltip = "Amount of darkening.";
ui_type = "slider";
ui_min = 0.2;
ui_max = 5.0;
ui_step = 0.001;
> = 2.0;
#line 223
uniform int iHBAOSamples <
ui_label = "HBAO Samples";
ui_category = "HBAO Settings";
ui_tooltip = "Amount of samples. Higher means more accurate AO but also less performance.";
ui_type = "slider";
ui_min = 7;
ui_max = 36;
ui_step = 1;
> = 9;
#line 233
uniform float fHBAOSamplingRange  <
ui_label = "HBAO Sampling Range";
ui_category = "HBAO Settings";
ui_tooltip = "Range of HBAO sampling. Higher values ignore small geometry details and shadow more globally.";
ui_type = "slider";
ui_min = 0.5;
ui_max = 5.0;
ui_step = 0.001;
> = 2.6;
#line 243
uniform float fHBAOAmount  <
ui_label = "HBAO Amount";
ui_category = "HBAO Settings";
ui_tooltip = "Amount of HBAO shadowing.";
ui_type = "slider";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.001;
> = 3.0;
#line 253
uniform float fHBAOClamp  <
ui_label = "HBAO Clamp";
ui_category = "HBAO Settings";
ui_tooltip = "Clamps HBAO power. 0.0 means full power, 1.0 means no HBAO.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.1;
#line 263
uniform float fHBAOAttenuation  <
ui_label = "HBAO Attenuation";
ui_category = "HBAO Settings";
ui_tooltip = "Affects the HBAO range, prevents shadowing of very far objects which are close in screen space.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 0.2;
ui_step = 0.001;
> = 0.02;
#line 273
uniform int iSSGISamples <
ui_label = "SSGI Samples";
ui_category = "SSGI Settings";
ui_tooltip = "Amount of SSGI sampling iterations, higher means better GI but less performance.";
ui_type = "slider";
ui_min = 5;
ui_max = 24;
ui_step = 1;
> = 9;
#line 283
uniform float fSSGISamplingRange <
ui_label = "SSGI Sampling Range";
ui_category = "SSGI Settings";
ui_tooltip = "Radius of SSGI sampling.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 80.0;
ui_step = 0.001;
> = 0.4;
#line 293
uniform float fSSGIIlluminationMult <
ui_label = "SSGI Illumination Multiplier";
ui_category = "SSGI Settings";
ui_tooltip = "Multiplier of SSGI illumination (color bouncing/reflection).";
ui_type = "slider";
ui_min = 1.0;
ui_max = 8.0;
ui_step = 0.001;
> = 4.5;
#line 303
uniform float fSSGIOcclusionMult <
ui_label = "SSGI Occlusion Multiplier";
ui_category = "SSGI Settings";
ui_tooltip = "Multiplier of SSGI occlusion.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
ui_step = 0.001;
> = 0.8;
#line 313
uniform float fSSGIModelThickness <
ui_label = "SSGI Model Thickness";
ui_category = "SSGI Settings";
ui_tooltip = "Amount of unit spaces the algorithm assumes the model's thickness. Lower if scene only contains small objects.";
ui_type = "slider";
ui_min = 0.5;
ui_max = 100.0;
ui_step = 0.001;
> = 10.0;
#line 323
uniform float fSSGISaturation <
ui_label = "SSGI Saturation";
ui_category = "SSGI Settings";
ui_tooltip = "Saturation of bounced/reflected colors.";
ui_type = "slider";
ui_min = 0.2;
ui_max = 2.0;
ui_step = 0.001;
> = 1.8;
#line 333
uniform float iSAOSamples <
ui_label = "SAO Samples";
ui_category = "SAO Settings";
ui_tooltip = "Amount of SAO Samples. Maximum of 96 is defined by formula.";
ui_type = "slider";
ui_min = 10.0;
ui_max = 96.0;
ui_step = 1.0;
> = 18.0;
#line 343
uniform float fSAOIntensity <
ui_label = "SAO Intensity";
ui_category = "SAO Settings";
ui_tooltip = "Linearly multiplies AO intensity.";
ui_type = "slider";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.001;
> = 6.0;
#line 353
uniform float fSAOClamp <
ui_label = "SAO Clamp";
ui_category = "SAO Settings";
ui_tooltip = "Higher values shift AO more into black. Useful for light gray AO caused by high SAO radius.";
ui_type = "slider";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.001;
> = 2.5;
#line 363
uniform float fSAORadius <
ui_label = "SAO Radius";
ui_category = "SAO Settings";
ui_tooltip = "SAO sampling radius. Higher values also lower AO intensity extremely because of Alchemy's extremely terrible falloff formula.";
ui_type = "slider";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.001;
> = 2.3;
#line 373
uniform float fSAOBias <
ui_label = "SAO Bias";
ui_category = "SAO Settings";
ui_tooltip = "Minimal surface angle for AO consideration. Useful to prevent self-occlusion of flat surfaces caused by floating point inaccuracies.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 0.5;
ui_step = 0.001;
> = 0.2;
#line 386
texture2D texSSAONoise < source = "mcnoise.png"; > {Width = 1281;Height = 721;Format = RGBA8;};
#line 388
texture texOcclusion1 { Width = 1281; Height = 721;  Format = RGBA16F;};
texture texOcclusion2 { Width = 1281; Height = 721;  Format = RGBA16F;};
#line 391
texture2D texHDR3 	{ Width = 1281; Height = 721; Format = RGBA8;};
#line 394
sampler2D SamplerSSAONoise
{
Texture = texSSAONoise;
MinFilter = LINEAR;
MagFilter = LINEAR;
MipFilter = LINEAR;
AddressU = Wrap;
AddressV = Wrap;
};
#line 404
sampler2D SamplerOcclusion1
{
Texture = texOcclusion1;
MinFilter = LINEAR;
MagFilter = LINEAR;
MipFilter = LINEAR;
AddressU = Clamp;
AddressV = Clamp;
};
#line 414
sampler2D SamplerOcclusion2
{
Texture = texOcclusion2;
MinFilter = LINEAR;
MagFilter = LINEAR;
MipFilter = LINEAR;
AddressU = Clamp;
AddressV = Clamp;
};
#line 424
sampler2D SamplerHDR3
{
Texture = texHDR3;
MinFilter = LINEAR;
MagFilter = LINEAR;
MipFilter = LINEAR;
AddressU = Clamp;
AddressV = Clamp;
};
#line 437
float3 GetNormalFromDepth(float fDepth, float2 vTexcoord) {
#line 439
const float2 offset1 = float2(0.0,0.001);
const float2 offset2 = float2(0.001,0.0);
#line 442
const float depth1 = ReShade::GetLinearizedDepth(vTexcoord + offset1).x;
const float depth2 = ReShade::GetLinearizedDepth(vTexcoord + offset2).x;
#line 445
const float3 p1 = float3(offset1, depth1 - fDepth);
const float3 p2 = float3(offset2, depth2 - fDepth);
#line 448
float3 normal = cross(p1, p2);
normal.z = -normal.z;
#line 451
return normalize(normal);
}
#line 454
float GetRandom(float2 co){
return frac(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}
#line 458
float3 GetRandomVector(float2 vTexCoord) {
return 2 * normalize(float3(GetRandom(vTexCoord - 0.5f),
GetRandom(vTexCoord + 0.5f),
GetRandom(vTexCoord))) - 1;
}
#line 467
void PS_AO_SSAO(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion1R : SV_Target0)
{
texcoord.xy /= AO_TEXSCALE;
if(texcoord.x > 1.0 || texcoord.y > 1.0) discard;
#line 473
const float fSceneDepthP 	= ReShade::GetLinearizedDepth(texcoord.xy).x;
#line 475
float blurkey;
if( AO_SHARPNESS_DETECT == 0)
blurkey = fSceneDepthP;
else
blurkey = dot(GetNormalFromDepth(fSceneDepthP, texcoord.xy).xyz,0.333)*0.1;
#line 481
if(fSceneDepthP > min(0.9999,AO_FADE_END)) Occlusion1R = float4(0.5,0.5,0.5,blurkey);
else {
float offsetScale = fSSAOSamplingRange/10000;
const float fSSAODepthClip = 10000000.0;
#line 486
const float3 vRotation = tex2Dlod(SamplerSSAONoise, float4(texcoord.xy, 0, 0)).rgb - 0.5f;
#line 488
float3x3 matRotate;
#line 490
const float hao = 1.0f / (1.0f + vRotation.z);
#line 492
matRotate._m00 =  hao * vRotation.y * vRotation.y + vRotation.z;
matRotate._m01 = -hao * vRotation.y * vRotation.x;
matRotate._m02 = -vRotation.x;
matRotate._m10 = -hao * vRotation.y * vRotation.x;
matRotate._m11 =  hao * vRotation.x * vRotation.x + vRotation.z;
matRotate._m12 = -vRotation.y;
matRotate._m20 =  vRotation.x;
matRotate._m21 =  vRotation.y;
matRotate._m22 =  vRotation.z;
#line 502
float fOffsetScaleStep = 1.0f + 2.4f / iSSAOSamples;
float fAccessibility = 0;
#line 505
float Sample_Scaled = iSSAOSamples;
#line 507
if(iSSAOSmartSampling == 1)
{
if(fSceneDepthP > 0.5) Sample_Scaled=max(8,round(Sample_Scaled*0.5));
if(fSceneDepthP > 0.8) Sample_Scaled=max(8,round(Sample_Scaled*0.5));
}
#line 513
const float fAtten = 5000.0/fSSAOSamplingRange/(1.0+fSceneDepthP*10.0);
#line 515
[loop]
for (int i = 0 ; i < (Sample_Scaled / 8) ; i++)
for (int x = -1 ; x <= 1 ; x += 2)
for (int y = -1 ; y <= 1 ; y += 2)
for (int z = -1 ; z <= 1 ; z += 2) {
#line 521
const float3 vOffset = normalize(float3(x, y, z)) * (offsetScale *= fOffsetScaleStep);
#line 523
const float3 vRotatedOffset = mul(vOffset, matRotate);
#line 526
float3 vSamplePos = float3(texcoord.xy, fSceneDepthP);
#line 529
vSamplePos += float3(vRotatedOffset.xy, vRotatedOffset.z * fSceneDepthP);
#line 532
float fSceneDepthS = ReShade::GetLinearizedDepth(vSamplePos.xy).x;
#line 535
if (fSceneDepthS >= fSSAODepthClip)
fAccessibility += 1.0f;
else {
#line 539
const float fDepthDist = abs(fSceneDepthP - fSceneDepthS);
const float fRangeIsInvalid = saturate(fDepthDist*fAtten);
fAccessibility += lerp(fSceneDepthS > vSamplePos.z, 0.5f, fRangeIsInvalid);
}
}
#line 546
fAccessibility = fAccessibility / Sample_Scaled;
#line 548
Occlusion1R = float4(fAccessibility.xxx,blurkey);
}
}
#line 552
void PS_AO_RayAO(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion1R : SV_Target0)
{
texcoord.xy /= AO_TEXSCALE;
if(texcoord.x > 1.0 || texcoord.y > 1.0) discard;
#line 557
const float3	avOffsets [78] =
{
float3(0.2196607,0.9032637,0.2254677),
float3(0.05916681,0.2201506,-0.1430302),
float3(-0.4152246,0.1320857,0.7036734),
float3(-0.3790807,0.1454145,0.100605),
float3(0.3149606,-0.1294581,0.7044517),
float3(-0.1108412,0.2162839,0.1336278),
float3(0.658012,-0.4395972,-0.2919373),
float3(0.5377914,0.3112189,0.426864),
float3(-0.2752537,0.07625949,-0.1273409),
float3(-0.1915639,-0.4973421,-0.3129629),
float3(-0.2634767,0.5277923,-0.1107446),
float3(0.8242752,0.02434147,0.06049098),
float3(0.06262707,-0.2128643,-0.03671562),
float3(-0.1795662,-0.3543862,0.07924347),
float3(0.06039629,0.24629,0.4501176),
float3(-0.7786345,-0.3814852,-0.2391262),
float3(0.2792919,0.2487278,-0.05185341),
float3(0.1841383,0.1696993,-0.8936281),
float3(-0.3479781,0.4725766,-0.719685),
float3(-0.1365018,-0.2513416,0.470937),
float3(0.1280388,-0.563242,0.3419276),
float3(-0.4800232,-0.1899473,0.2398808),
float3(0.6389147,0.1191014,-0.5271206),
float3(0.1932822,-0.3692099,-0.6060588),
float3(-0.3465451,-0.1654651,-0.6746758),
float3(0.2448421,-0.1610962,0.13289366),
float3(0.2448421,0.9032637,0.24254677),
float3(0.2196607,0.2201506,-0.18430302),
float3(0.05916681,0.1320857,0.70036734),
float3(-0.4152246,0.1454145,0.1800605),
float3(-0.3790807,-0.1294581,0.78044517),
float3(0.3149606,0.2162839,0.17336278),
float3(-0.1108412,-0.4395972,-0.269619373),
float3(0.658012,0.3112189,0.4267864),
float3(0.5377914,0.07625949,-0.12773409),
float3(-0.2752537,-0.4973421,-0.31629629),
float3(-0.1915639,0.5277923,-0.17107446),
float3(-0.2634767,0.02434147,0.086049098),
float3(0.8242752,-0.2128643,-0.083671562),
float3(0.06262707,-0.3543862,0.007924347),
float3(-0.1795662,0.24629,0.44501176),
float3(0.06039629,-0.3814852,-0.248391262),
float3(-0.7786345,0.2487278,-0.065185341),
float3(0.2792919,0.1696993,-0.84936281),
float3(0.1841383,0.4725766,-0.7419685),
float3(-0.3479781,-0.2513416,0.670937),
float3(-0.1365018,-0.563242,0.36419276),
float3(0.1280388,-0.1899473,0.23948808),
float3(-0.4800232,0.1191014,-0.5271206),
float3(0.6389147,-0.3692099,-0.5060588),
float3(0.1932822,-0.1654651,-0.62746758),
float3(-0.3465451,-0.1610962,0.4289366),
float3(0.2448421,-0.1610962,0.2254677),
float3(0.2196607,0.9032637,-0.1430302),
float3(0.05916681,0.2201506,0.7036734),
float3(-0.4152246,0.1320857,0.100605),
float3(-0.3790807,0.3454145,0.7044517),
float3(0.3149606,-0.4294581,0.1336278),
float3(-0.1108412,0.3162839,-0.2919373),
float3(0.658012,-0.2395972,0.426864),
float3(0.5377914,0.33112189,-0.1273409),
float3(-0.2752537,0.47625949,-0.3129629),
float3(-0.1915639,-0.3973421,-0.1107446),
float3(-0.2634767,0.2277923,0.06049098),
float3(0.8242752,-0.3434147,-0.03671562),
float3(0.06262707,-0.4128643,0.07924347),
float3(-0.1795662,-0.3543862,0.4501176),
float3(0.06039629,0.24629,-0.2391262),
float3(-0.7786345,-0.3814852,-0.05185341),
float3(0.2792919,0.4487278,-0.8936281),
float3(0.1841383,0.3696993,-0.719685),
float3(-0.3479781,0.2725766,0.470937),
float3(-0.1365018,-0.5513416,0.3419276),
float3(0.1280388,-0.163242,0.2398808),
float3(-0.4800232,-0.3899473,-0.5271206),
float3(0.6389147,0.3191014,-0.6060588),
float3(0.1932822,-0.1692099,-0.6746758),
float3(-0.3465451,-0.2654651,0.1289366)
};
#line 639
float2 vOutSum;
float3 vRandom, vReflRay, vViewNormal;
float fCurrDepth, fSampleDepth, fDepthDelta, fAO;
fCurrDepth  = ReShade::GetLinearizedDepth(texcoord.xy).x;
#line 644
float blurkey;
if( AO_SHARPNESS_DETECT == 0)
blurkey = fCurrDepth;
else
blurkey = dot(GetNormalFromDepth(fCurrDepth, texcoord.xy).xyz,0.333)*0.1;
#line 650
if(fCurrDepth>min(0.9999,AO_FADE_END)) Occlusion1R = float4(1.0,1.0,1.0,blurkey);
else {
vViewNormal = GetNormalFromDepth(fCurrDepth, texcoord.xy);
vRandom 	= GetRandomVector(texcoord);
fAO = 0;
for(int s = 0; s < iRayAOSamples; s++) {
vReflRay = reflect(avOffsets[s], vRandom);
#line 658
float fFlip = sign(dot(vViewNormal,vReflRay));
vReflRay   *= fFlip;
#line 661
const float sD = fCurrDepth - (vReflRay.z * fRayAOSamplingRange);
fSampleDepth = ReShade::GetLinearizedDepth(saturate(texcoord + (fRayAOSamplingRange * vReflRay.xy / fCurrDepth))).x;
fDepthDelta = saturate(sD - fSampleDepth);
#line 665
fDepthDelta *= 1-smoothstep(0,fRayAOMaxDepth,fDepthDelta);
#line 667
if ( fDepthDelta > fRayAOMinDepth && fDepthDelta < fRayAOMaxDepth)
fAO += pow(1 - fDepthDelta, 2.5);
}
vOutSum.x = saturate(1 - (fAO / (float)iRayAOSamples) + fRayAOSamplingRange);
Occlusion1R = float4(vOutSum.xxx,blurkey);
}
}
#line 676
float3 GetEyePosition(in float2 uv, in float eye_z) {
uv = (uv * float2(2.0, -2.0) - float2(1.0, -1.0));
const float3 pos = float3(uv *  	float2(tan(0.5f*radians( 		75)) / (float)(1.0 / 721) * (float)(1.0 / 1281), tan(0.5f*radians( 		75))) * eye_z, eye_z);
return pos;
}
#line 682
float2 GetRandom2_10(in float2 uv) {
const float noiseX = (frac(sin(dot(uv, float2(12.9898,78.233) * 2.0)) * 43758.5453));
const float noiseY = sqrt(1 - noiseX * noiseX);
return float2(noiseX, noiseY);
}
#line 688
void PS_AO_HBAO(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion1R : SV_Target0)
{
texcoord.xy /= AO_TEXSCALE;
if(texcoord.x > 1.0 || texcoord.y > 1.0) discard;
#line 693
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
#line 695
float blurkey;
if( AO_SHARPNESS_DETECT == 0)
blurkey = depth;
else
blurkey = dot(GetNormalFromDepth(depth, texcoord.xy).xyz,0.333)*0.1;
#line 701
if(depth > min(0.9999,AO_FADE_END)) Occlusion1R = float4(1.0,1.0,1.0,blurkey);
else {
const float2 sample_offset[8] =
{
float2(1, 0),
float2(0.7071f, 0.7071f),
float2(0, 1),
float2(-0.7071f, 0.7071f),
float2(-1, 0),
float2(-0.7071f, -0.7071f),
float2(0, -1),
float2(0.7071f, -0.7071f)
};
#line 715
const float3 pos = GetEyePosition(texcoord.xy, depth);
const float3 dx = ddx(pos);
const float3 dy = ddy(pos);
const float3 norm = normalize(cross(dx,dy));
#line 720
float sample_depth=0;
float3 sample_pos=0;
#line 723
float ao=0;
float s=0.0;
#line 726
const float2 rand_vec = GetRandom2_10(texcoord.xy);
const float2 sample_vec_divisor =  	float2(tan(0.5f*radians( 		75)) / (float)(1.0 / 721) * (float)(1.0 / 1281), tan(0.5f*radians( 		75)))*depth/(fHBAOSamplingRange*float2((1.0 / 1281), (1.0 / 721)));
const float2 sample_center = texcoord.xy;
#line 730
for (int i = 0; i < 8; i++)
{
float theta,temp_theta,temp_ao,curr_ao = 0;
float3 occlusion_vector = 0.0;
#line 735
float2 sample_vec = reflect(sample_offset[i], rand_vec);
sample_vec /= sample_vec_divisor;
const float2 sample_coords = (sample_vec*float2(1,(float)1281/(float)721))/iHBAOSamples;
#line 739
for (int k = 1; k <= iHBAOSamples; k++)
{
sample_depth = ReShade::GetLinearizedDepth(sample_center + sample_coords*(k-0.5*(float(i)%2))).x;
sample_pos = GetEyePosition(sample_center + sample_coords*(k-0.5*(float(i)%2)), sample_depth);
occlusion_vector = sample_pos - pos;
temp_theta = dot( norm, normalize(occlusion_vector) );
#line 746
if (temp_theta > theta)
{
theta = temp_theta;
temp_ao = 1-sqrt(1 - theta*theta );
ao += (1/ (1 + fHBAOAttenuation * pow(length(occlusion_vector)/fHBAOSamplingRange*5000,2)) )*(temp_ao-curr_ao);
curr_ao = temp_ao;
}
}
s += 1;
}
#line 757
ao /= max(0.00001,s);
ao = 1.0-ao*fHBAOAmount;
ao = clamp(ao,fHBAOClamp,1);
#line 761
Occlusion1R = float4(ao.xxx, blurkey);
}
#line 764
}
#line 766
float3 GetSAO_CSPosition(float2 S, float z)
{
#line 771
const float nearZ = 0.1; float farZ = 100.0; float vFOV = 68.0;
const float4x4 matProjection = float4x4(
1.0f / (          ((1.0 / 721)/(1.0 / 1281)) * tan(vFOV / 2.0f)),  0.0f,                     0.0f,                   0.0f,
0.0f,                                1.0f / tan(vFOV / 2.0f),  0.0f,                   0.0f,
0.0f,                                0.0f,                     farZ / (farZ - nearZ),         1.0f,
0.0f,                                0.0f,                     (farZ * nearZ) / (nearZ - farZ),  0.0f
);
#line 779
float4 projInfo;
projInfo.x = -2.0f / ((float)1281 * matProjection._11);
projInfo.y = -2.0f / ((float)721 * matProjection._22),
projInfo.z = ((1.0f - matProjection._13) / matProjection._11) + projInfo.x * 0.5f;
projInfo.w = ((1.0f + matProjection._23) / matProjection._22) + projInfo.y * 0.5f;
return float3(( (S.xy * float2(1281,721)) * projInfo.xy + projInfo.zw) * z, z);
}
#line 787
float2 GetSAO_TapLocation(int sampleNumber, float spinAngle, out float ssR)
{
#line 790
const uint ROTATIONS [98] = { 1, 1, 2, 3, 2, 5, 2, 3, 2,
3, 3, 5, 5, 3, 4, 7, 5, 5, 7,
9, 8, 5, 5, 7, 7, 7, 8, 5, 8,
11, 12, 7, 10, 13, 8, 11, 8, 7, 14,
11, 11, 13, 12, 13, 19, 17, 13, 11, 18,
19, 11, 11, 14, 17, 21, 15, 16, 17, 18,
13, 17, 11, 17, 19, 18, 25, 18, 19, 19,
29, 21, 19, 27, 31, 29, 21, 18, 17, 29,
31, 31, 23, 18, 25, 26, 25, 23, 19, 34,
19, 27, 21, 25, 39, 29, 17, 21, 27 };
#line 801
const int SAOSamples = iSAOSamples;
const uint NUM_SPIRAL_TURNS = ROTATIONS[SAOSamples-1];
#line 805
const float alpha = float(sampleNumber + 0.5) * (1.0 / iSAOSamples);
const float angle = alpha * (NUM_SPIRAL_TURNS * 6.28) + spinAngle;
#line 808
ssR = alpha;
float sin_v, cos_v;
sincos(angle, sin_v, cos_v);
return float2(cos_v, sin_v);
}
#line 814
float GetSAO_CurveDepth(float depth)
{
return 202.0 / (-99.0 * depth + 101.0);
}
#line 819
float3 GetSAO_Position(float2 ssPosition)
{
float3 Position;
Position.z = GetSAO_CurveDepth(ReShade::GetLinearizedDepth(ssPosition.xy).x);
Position = GetSAO_CSPosition(ssPosition, Position.z);
return Position;
}
#line 827
float3 GetSAO_OffsetPosition(float2 ssC, float2 unitOffset, float ssR)
{
const float2 ssP = ssR*unitOffset + ssC;
float3 P;
P.z = GetSAO_CurveDepth(ReShade::GetLinearizedDepth(ssP.xy).x);
P = GetSAO_CSPosition(ssP, P.z);
return P;
}
#line 836
float GetSAO_SampleAO(in float2 ssC, in float3 C, in float3 n_C, in float ssDiskRadius, in int tapIndex, in float randomPatternRotationAngle)
{
float ssR;
const float2 unitOffset = GetSAO_TapLocation(tapIndex, randomPatternRotationAngle, ssR);
ssR *= ssDiskRadius;
const float3 Q = GetSAO_OffsetPosition(ssC, unitOffset, ssR);
const float3 v = Q - C;
#line 844
const float vv = dot(v, v);
const float vn = dot(v, n_C);
#line 847
const float f = max(1.0 - vv * (1.0 / fSAORadius), 0.0);
return f * max((vn - fSAOBias) * rsqrt( vv), 0.0);
}
#line 851
void PS_AO_SAO(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion1R : SV_Target0)
{
texcoord.xy /= AO_TEXSCALE;
if(texcoord.x > 1.0 || texcoord.y > 1.0) discard;
#line 856
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
#line 858
float blurkey;
if( AO_SHARPNESS_DETECT == 0)
blurkey = depth;
else
blurkey = dot(GetNormalFromDepth(depth, texcoord.xy).xyz,0.333)*0.1;
#line 864
if(depth > min(0.9999,AO_FADE_END)) Occlusion1R = float4(1.0,1.0,1.0,blurkey);
else {
const float3 ssPosition = GetSAO_Position(texcoord.xy);
const float rotAngle = frac(sin(texcoord.xy.x + texcoord.xy.y * 543.31) *  493013.0) * 10.0;
#line 869
const float3 ssNormals = normalize(cross(normalize(ddy(ssPosition)), normalize(ddx(ssPosition))));
const float ssDiskRadius = fSAORadius / max(ssPosition.z,0.1f);
#line 872
float sum = 0.0;
#line 874
[loop]
for (int i = 0; i < iSAOSamples; ++i)
{
sum += GetSAO_SampleAO(texcoord.xy, ssPosition, ssNormals, ssDiskRadius, i, rotAngle);
}
#line 880
sum /= pow(fSAORadius,6.0);
#line 882
float A = pow(saturate(1.0 - sqrt(sum * (3.0 / iSAOSamples))), fSAOIntensity);
#line 884
A = (pow(A, 0.2) + 1.2 * A*A*A*A) / 2.2;
const float ao = lerp(1.0, A, fSAOClamp);
#line 887
Occlusion1R = float4(ao.xxx,blurkey);
}
}
#line 891
void PS_AO_AOBlurV(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion2R : SV_Target0)
{
#line 895
texcoord.xy *= AO_TEXSCALE;
float  sum,totalweight=0;
float4 base = tex2D(SamplerOcclusion1, texcoord.xy), temp=0;
#line 899
[loop]
for (int r = -AO_BLUR_STEPS; r <= AO_BLUR_STEPS; ++r)
{
const float2 axis = float2(0.0, 1.0);
temp = tex2Dlod(SamplerOcclusion1, float4(texcoord.xy + axis *  float2((1.0 / 1281), (1.0 / 721)) * r, 0.0, 0.0));
float weight = AO_BLUR_STEPS-abs(r);
weight *= saturate(1.0 - (1000.0 * AO_SHARPNESS) * abs(temp.w - base.w));
sum += temp.x * weight;
totalweight += weight;
}
#line 910
Occlusion2R = float4(sum / (totalweight+0.0001),0,0,base.w);
}
#line 913
void PS_AO_AOBlurH(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion1R : SV_Target0)
{
float  sum,totalweight=0;
float4 base = tex2D(SamplerOcclusion2, texcoord.xy), temp=0;
#line 918
[loop]
for (int r = -AO_BLUR_STEPS; r <= AO_BLUR_STEPS; ++r)
{
const float2 axis = float2(1.0, 0.0);
temp = tex2Dlod(SamplerOcclusion2, float4(texcoord.xy + axis *  float2((1.0 / 1281), (1.0 / 721)) * r, 0.0, 0.0));
float weight = AO_BLUR_STEPS-abs(r);
weight *= saturate(1.0 - (1000.0 * AO_SHARPNESS) * abs(temp.w - base.w));
sum += temp.x * weight;
totalweight += weight;
}
#line 929
Occlusion1R = float4(sum / (totalweight+0.0001),0,0,base.w);
}
#line 932
float4 PS_AO_AOCombine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
#line 935
float4 color = tex2D(SamplerHDR3, texcoord.xy);
float ao = tex2D(SamplerOcclusion1, texcoord.xy).x;
#line 938
if ( AO_DEBUG == 1)
{
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
ao = lerp(ao,1.0,smoothstep(AO_FADE_START,AO_FADE_END,depth));
return ao;
}
else
{
if(AO_LUMINANCE_CONSIDERATION == 1)
{
const float origlum = dot(color.xyz, 0.333);
const float aomult = smoothstep(AO_LUMINANCE_LOWER, AO_LUMINANCE_UPPER, origlum);
ao = lerp(ao, 1.0, aomult);
}
#line 953
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
ao = lerp(ao,1.0,smoothstep(AO_FADE_START,AO_FADE_END,depth));
#line 956
color.xyz *= ao;
#line 958
return float4(color.xyz + TriDither(color.xyz, texcoord, 8), color.a);
#line 962
}
}
#line 965
float4 PS_SSAO_AOCombine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
#line 968
float4 color = tex2D(SamplerHDR3, texcoord.xy);
float ao = tex2D(SamplerOcclusion1, texcoord.xy).x;
#line 971
ao -= 0.5;
if(ao < 0) ao *= fSSAODarkeningAmount;
if(ao > 0) ao *= fSSAOBrighteningAmount;
ao = 2 * saturate(ao+0.5);
#line 976
if( AO_DEBUG == 1)
{
ao *= 0.75;
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
ao = lerp(ao,1.0,smoothstep(AO_FADE_START,AO_FADE_END,depth));
return ao;
}
else
{
if(AO_LUMINANCE_CONSIDERATION == 1)
{
const float origlum = dot(color.xyz, 0.333);
const float aomult = smoothstep(AO_LUMINANCE_LOWER, AO_LUMINANCE_UPPER, origlum);
ao = lerp(ao, 1.0, aomult);
}
#line 992
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
ao = lerp(ao,1.0,smoothstep(AO_FADE_START,AO_FADE_END,depth));
#line 995
color.xyz *= ao;
#line 997
return float4(color.xyz + TriDither(color.xyz, texcoord, 8), color.a);
#line 1001
}
}
#line 1004
float4 PS_RayAO_AOCombine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
#line 1007
float4 color = tex2D(SamplerHDR3, texcoord.xy);
float ao = tex2D(SamplerOcclusion1, texcoord.xy).x;
#line 1010
ao = pow(abs(ao), fRayAOPower);
#line 1012
if( AO_DEBUG == 1)
{
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
ao = lerp(ao,1.0,smoothstep(AO_FADE_START,AO_FADE_END,depth));
return ao;
}
else
{
if(AO_LUMINANCE_CONSIDERATION == 1)
{
const float origlum = dot(color.xyz, 0.333);
const float aomult = smoothstep(AO_LUMINANCE_LOWER, AO_LUMINANCE_UPPER, origlum);
ao = lerp(ao, 1.0, aomult);
}
#line 1027
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
ao = lerp(ao,1.0,smoothstep(AO_FADE_START,AO_FADE_END,depth));
#line 1030
color.xyz *= ao;
#line 1032
return float4(color.xyz + TriDither(color.xyz, texcoord, 8), color.a);
#line 1036
}
}
#line 1039
void PS_AO_SSGI(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion1R : SV_Target0)
{
texcoord.xy /= AO_TEXSCALE;
if(texcoord.x > 1.0 || texcoord.y > 1.0) discard;
#line 1044
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
#line 1046
if(depth > 0.9999) Occlusion1R = float4(0.0,0.0,0.0,1.0);
else {
float giClamp = 0.0;
#line 1050
const float2 sample_offset[24] =
{
float2(-0.1376476f,  0.2842022f ),float2(-0.626618f ,  0.4594115f ),
float2(-0.8903138f, -0.05865424f),float2( 0.2871419f,  0.8511679f ),
float2(-0.1525251f, -0.3870117f ),float2( 0.6978705f, -0.2176773f ),
float2( 0.7343006f,  0.3774331f ),float2( 0.1408805f, -0.88915f   ),
float2(-0.6642616f, -0.543601f  ),float2(-0.324815f, -0.093939f   ),
float2(-0.1208579f , 0.9152063f ),float2(-0.4528152f, -0.9659424f ),
float2(-0.6059740f,  0.7719080f ),float2(-0.6886246f, -0.5380305f ),
float2( 0.5380307f, -0.2176773f ),float2( 0.7343006f,  0.9999345f ),
float2(-0.9976073f, -0.7969264f ),float2(-0.5775355f,  0.2842022f ),
float2(-0.626618f ,  0.9115176f ),float2(-0.29818942f, -0.0865424f),
float2( 0.9161239f,  0.8511679f ),float2(-0.1525251f, -0.07103951f ),
float2( 0.7022788f, -0.823825f ),float2(0.60250657f,  0.64525909f )
};
#line 1066
const float sample_radius[24] =
{
0.5162497,0.2443335,
0.1014819,0.1574599,
0.6538922,0.5637644,
0.6347278,0.2467654,
0.5642318,0.0035689,
0.6384532,0.3956547,
0.7049623,0.3482861,
0.7484038,0.2304858,
0.0043161,0.5423726,
0.5025704,0.4066662,
0.2654198,0.8865175,
0.9505567,0.9936577
};
#line 1082
const float3 pos = GetEyePosition(texcoord.xy, depth);
const float3 dx = ddx(pos);
const float3 dy = ddy(pos);
float3 norm = normalize(cross(dx, dy));
norm.y *= -1;
#line 1088
float sample_depth;
#line 1090
float4 gi = float4(0, 0, 0, 0);
float is = 0, as = 0;
#line 1093
const float rangeZ = 5000;
#line 1095
const float2 rand_vec = GetRandom2_10(texcoord.xy);
const float2 rand_vec2 = GetRandom2_10(-texcoord.xy);
const float2 sample_vec_divisor =  	float2(tan(0.5f*radians( 		75)) / (float)(1.0 / 721) * (float)(1.0 / 1281), tan(0.5f*radians( 		75))) * depth / (fSSGISamplingRange *  float2((1.0 / 1281), (1.0 / 721)).xy);
const float2 sample_center = texcoord.xy + norm.xy / sample_vec_divisor * float2(1,           ((1.0 / 721)/(1.0 / 1281)));
const float ii_sample_center_depth = depth * rangeZ + norm.z * fSSGISamplingRange * 20;
const float ao_sample_center_depth = depth * rangeZ + norm.z * fSSGISamplingRange * 5;
#line 1102
[fastopt]
for (int i = 0; i < iSSGISamples; i++) {
const float2 sample_vec = reflect(sample_offset[i], rand_vec) / sample_vec_divisor;
const float2 sample_coords = sample_center + sample_vec *  float2(1,           ((1.0 / 721)/(1.0 / 1281)));
const float  sample_depth = rangeZ * ReShade::GetLinearizedDepth(sample_coords.xy).x;
#line 1108
const float ii_curr_sample_radius = sample_radius[i] * fSSGISamplingRange * 20;
const float ao_curr_sample_radius = sample_radius[i] * fSSGISamplingRange * 5;
#line 1111
gi.a += clamp(0, ao_sample_center_depth + ao_curr_sample_radius - sample_depth, 2 * ao_curr_sample_radius);
gi.a -= clamp(0, ao_sample_center_depth + ao_curr_sample_radius - sample_depth - fSSGIModelThickness, 2 * ao_curr_sample_radius);
#line 1114
if ((sample_depth < ii_sample_center_depth + ii_curr_sample_radius) &&
(sample_depth > ii_sample_center_depth - ii_curr_sample_radius)) {
const float3 sample_pos = GetEyePosition(sample_coords, sample_depth);
const float3 unit_vector = normalize(pos - sample_pos);
gi.rgb += tex2Dlod(SamplerHDR3, float4(sample_coords,0,0)).rgb;
}
#line 1121
is += 1.0f;
as += 2.0f * ao_curr_sample_radius;
}
#line 1125
gi.rgb /= is * 5.0f;
gi.a   /= as;
#line 1128
gi.rgb = 0.0 + gi.rgb * fSSGIIlluminationMult;
gi.a   = 1.0 - gi.a   * fSSGIOcclusionMult;
#line 1131
gi.rgb = lerp(dot(gi.rgb, 0.333), gi.rgb, fSSGISaturation);
#line 1133
Occlusion1R = gi;
}
}
#line 1138
void PS_AO_GIBlurV(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion2R : SV_Target0)
{
texcoord.xy *= AO_TEXSCALE;
float4 sum=0;
float totalweight=0;
float4 base = tex2D(SamplerOcclusion1, texcoord.xy), temp = 0;
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
float blurkey;
if( AO_SHARPNESS_DETECT == 0)
blurkey = depth;
else
blurkey = dot(GetNormalFromDepth(depth, texcoord.xy).xyz,0.333)*0.1;
#line 1151
[loop]
for (int r = -AO_BLUR_STEPS; r <= AO_BLUR_STEPS; ++r)
{
const float2 axis = float2(0, 1);
temp = tex2Dlod(SamplerOcclusion1, float4(texcoord.xy + axis *  float2((1.0 / 1281), (1.0 / 721)) * r, 0.0, 0.0));
const float tempdepth = ReShade::GetLinearizedDepth(texcoord + axis *  float2((1.0 / 1281), (1.0 / 721)) * r).x;
float tempkey;
if( AO_SHARPNESS_DETECT == 0)
tempkey = tempdepth;
else
tempkey = dot(GetNormalFromDepth(tempdepth, texcoord.xy + axis *  float2((1.0 / 1281), (1.0 / 721)) * r).xyz,0.333)*0.1;
#line 1163
float weight = AO_BLUR_STEPS-abs(r);
weight *= saturate(1.0 - (1000.0 * AO_SHARPNESS) * abs(tempkey - blurkey));
sum += temp * weight;
totalweight += weight;
}
#line 1169
Occlusion2R = sum / (totalweight+0.0001);
}
#line 1172
void PS_AO_GIBlurH(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 Occlusion1R : SV_Target0)
{
float4 sum=0;
float totalweight=0;
float4 base = tex2D(SamplerOcclusion2, texcoord.xy), temp = 0;
#line 1178
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
float blurkey;
if( AO_SHARPNESS_DETECT == 0)
blurkey = depth;
else
blurkey = dot(GetNormalFromDepth(depth, texcoord.xy).xyz,0.333)*0.1;
#line 1185
[loop]
for (int r = -AO_BLUR_STEPS; r <= AO_BLUR_STEPS; ++r)
{
const float2 axis = float2(1, 0);
temp = tex2Dlod(SamplerOcclusion2, float4(texcoord.xy + axis *  float2((1.0 / 1281), (1.0 / 721)) * r, 0.0, 0.0));
const float tempdepth = ReShade::GetLinearizedDepth(texcoord + axis *  float2((1.0 / 1281), (1.0 / 721)) * r).x;
float tempkey;
if( AO_SHARPNESS_DETECT == 0)
tempkey = tempdepth;
else
tempkey = dot(GetNormalFromDepth(tempdepth, texcoord.xy + axis *  float2((1.0 / 1281), (1.0 / 721)) * r).xyz,0.333)*0.1;
#line 1197
float weight = AO_BLUR_STEPS-abs(r);
weight *= saturate(1.0 - (1000.0 * AO_SHARPNESS) * abs(tempkey - blurkey));
sum += temp * weight;
totalweight += weight;
}
#line 1203
Occlusion1R = sum / (totalweight+0.0001);
}
#line 1206
float4 PS_AO_GICombine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
#line 1209
float4 color = tex2D(SamplerHDR3, texcoord.xy);
float4 gi = tex2D(SamplerOcclusion1, texcoord.xy);
#line 1212
if( AO_DEBUG == 1)
return gi.wwww; 
else if ( AO_DEBUG == 2)
return gi.xyzz; 
else
{
if(AO_LUMINANCE_CONSIDERATION == 1)
{
const float origlum = dot(color.xyz, 0.333);
const float aomult = smoothstep(AO_LUMINANCE_LOWER, AO_LUMINANCE_UPPER, origlum);
gi.w = lerp(gi.w, 1.0, aomult);
gi.xyz = lerp(gi.xyz,0.0, aomult);
}
#line 1226
const float depth = ReShade::GetLinearizedDepth(texcoord.xy).x;
gi.xyz = lerp(gi.xyz,0.0,smoothstep(AO_FADE_START,AO_FADE_END,depth));
gi.w = lerp(gi.w,1.0,smoothstep(AO_FADE_START,AO_FADE_END,depth));
#line 1230
color.xyz = (color.xyz+gi.xyz)*gi.w;
#line 1232
return float4(color.xyz + TriDither(color.xyz, texcoord, 8), color.a);
#line 1236
}
}
#line 1239
void PS_Init(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 hdrT : SV_Target0)
{
hdrT = tex2D(ReShade::BackBuffer, texcoord.xy);
}
#line 1244
technique SSAO
{
pass Init_HDR1						
{							
VertexShader = PostProcessVS;			
PixelShader = PS_Init;
RenderTarget = texHDR3;
}
#line 1253
pass AO_SSAO
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_SSAO;
RenderTarget = texOcclusion1;
}
#line 1260
pass AO_AOBlurV
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurV;
RenderTarget = texOcclusion2;
}
#line 1267
pass AO_AOBlurH
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurH;
RenderTarget = texOcclusion1;
}
#line 1274
pass AO_AOCombine
{
VertexShader = PostProcessVS;
PixelShader = PS_SSAO_AOCombine;
}
}
#line 1282
technique RayAO
{
pass Init_HDR1						
{							
VertexShader = PostProcessVS;			
PixelShader = PS_Init;
RenderTarget = texHDR3;
}
#line 1291
pass AO_RayAO
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_RayAO;
RenderTarget = texOcclusion1;
}
#line 1298
pass AO_AOBlurV
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurV;
RenderTarget = texOcclusion2;
}
#line 1305
pass AO_AOBlurH
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurH;
RenderTarget = texOcclusion1;
}
#line 1312
pass AO_AOCombine
{
VertexShader = PostProcessVS;
PixelShader = PS_RayAO_AOCombine;
}
}
#line 1320
technique HBAO
{
pass Init_HDR1						
{							
VertexShader = PostProcessVS;			
PixelShader = PS_Init;
RenderTarget = texHDR3;
}
#line 1329
pass AO_HBAO
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_HBAO;
RenderTarget = texOcclusion1;
}
#line 1336
pass AO_AOBlurV
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurV;
RenderTarget = texOcclusion2;
}
#line 1343
pass AO_AOBlurH
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurH;
RenderTarget = texOcclusion1;
}
#line 1350
pass AO_AOCombine
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOCombine;
}
}
#line 1358
technique SSGI
{
pass Init_HDR1						
{							
VertexShader = PostProcessVS;			
PixelShader = PS_Init;
RenderTarget = texHDR3;
}
#line 1367
pass AO_AOBlurV
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurV;
RenderTarget = texOcclusion2;
}
#line 1374
pass AO_AOBlurH
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurH;
RenderTarget = texOcclusion1;
}
#line 1381
pass AO_AOCombine
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOCombine;
}
#line 1387
pass AO_SSGI
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_SSGI;
RenderTarget = texOcclusion1;
}
#line 1394
pass AO_GIBlurV
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_GIBlurV;
RenderTarget = texOcclusion2;
}
#line 1401
pass AO_GIBlurH
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_GIBlurH;
RenderTarget = texOcclusion1;
}
#line 1408
pass AO_GICombine
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_GICombine;
}
}
#line 1416
technique AO_SAO
{
pass Init_HDR1						
{							
VertexShader = PostProcessVS;			
PixelShader = PS_Init;
RenderTarget = texHDR3;
}
#line 1425
pass AO_HBAO
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_SAO;
RenderTarget = texOcclusion1;
}
pass AO_AOBlurV
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurV;
RenderTarget = texOcclusion2;
}
#line 1438
pass AO_AOBlurH
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOBlurH;
RenderTarget = texOcclusion1;
}
#line 1445
pass AO_AOCombine
{
VertexShader = PostProcessVS;
PixelShader = PS_AO_AOCombine;
}
}

