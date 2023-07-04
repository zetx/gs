#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\GAUSSIAN.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1799 * (1.0 / 998); }
float2 GetPixelSize() { return float2((1.0 / 1799), (1.0 / 998)); }
float2 GetScreenSize() { return float2(1799, 998); }
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\GAUSSIAN.fx"
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
#line 12 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\GAUSSIAN.fx"
#line 40
uniform int gGaussEffect <
ui_label = "Gauss Effect";
ui_type = "combo";
ui_items="Off\0Blur\0Unsharpmask (expensive)\0Bloom\0Sketchy\0Effects Image Only\0";
> = 1;
#line 46
uniform float gGaussStrength <
ui_label = "Gauss Strength";
ui_tooltip = "Amount of effect blended into the final image.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.3;
#line 55
uniform bool gAddBloom <
ui_label = "Add Bloom";
> = 0;
#line 63
uniform float gBloomStrength <
ui_label = "Bloom Strength";
ui_tooltip = "Amount of Bloom added to the final image.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.33;
#line 72
uniform float gBloomIntensity <
ui_label = "Bloom Intensity";
ui_tooltip = "Makes bright spots brighter. Also affects Blur and Unsharpmask.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 6.0;
ui_step = 0.001;
> = 3.0;
#line 81
uniform int gGaussBloomWarmth <
ui_label = "Bloom Warmth";
ui_tooltip = "Choose a tonemapping algorithm fitting your personal taste.";
ui_type = "combo";
ui_items="Neutral\0Warm\0Hazy/Foggy\0";
> = 0;
#line 88
uniform int gN_PASSES <
ui_label = "Number of Gaussian Passes";
ui_tooltip = "When gGaussQuality = 0, N_PASSES must be set to 3, 4, or 5.\nWhen using gGaussQuality = 1, N_PASSES must be set to 3,4,5,6,7,8, or 9.\nStill fine tuning this. Changing the number of passes can affect brightness.";
ui_type = "slider";
ui_min = 3;
ui_max = 9;
ui_step = 1;
> = 5;
#line 97
uniform float gBloomHW <
ui_label = "Horizontal Bloom Width";
ui_tooltip = "Higher numbers = wider bloom.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 10.0;
ui_step = 0.001;
> = 1.0;
#line 106
uniform float gBloomVW <
ui_label = "Vertical Bloom Width";
ui_tooltip = "Higher numbers = wider bloom.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 10.0;
ui_step = 0.001;
> = 1.0;
#line 115
uniform float gBloomSW <
ui_label = "Bloom Slant";
ui_tooltip = "Higher numbers = wider bloom.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 10.0;
ui_step = 0.001;
> = 2.0;
#line 131
texture origframeTex2D
{
Width = 1799;
Height = 998;
Format = R8G8B8A8;
};
#line 138
sampler origframeSampler
{
Texture = origframeTex2D;
AddressU  = Clamp; AddressV = Clamp;
MipFilter = None; MinFilter = Linear; MagFilter = Linear;
SRGBTexture = false;
};
#line 146
float4 BrightPassFilterPS(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
#line 149
float4 color = tex2D(ReShade::BackBuffer, texcoord);
color = float4(color.rgb * pow (abs (max (color.r, max (color.g, color.b))), 2.0), 2.0f)*gBloomIntensity;
return float4(color.rgb + TriDither(color.rgb, texcoord, 8), color.a);
#line 156
}
#line 158
float4 HGaussianBlurPS(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
#line 161
const float sampleOffsets[5] = { 0.0, 1.4347826, 3.3478260, 5.2608695, 7.1739130 };
const float sampleWeights[5] = { 0.16818994, 0.27276957, 0.11690125, 0.024067905, 0.0021112196 };
#line 168
float4 color = tex2D(ReShade::BackBuffer, texcoord) * sampleWeights[0];
for(int i = 1; i < gN_PASSES; ++i) {
color += tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(sampleOffsets[i]*gBloomHW *  float2((1.0 / 1799),(1.0 / 998)).x, 0.0), 0.0, 0.0)) * sampleWeights[i];
color += tex2Dlod(ReShade::BackBuffer, float4(texcoord - float2(sampleOffsets[i]*gBloomHW *  float2((1.0 / 1799),(1.0 / 998)).x, 0.0), 0.0, 0.0)) * sampleWeights[i];
}
#line 174
return float4(color.rgb + TriDither(color.rgb, texcoord, 8), color.a);
#line 178
}
#line 180
float4 VGaussianBlurPS(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
#line 183
const float sampleOffsets[5] = { 0.0, 1.4347826, 3.3478260, 5.2608695, 7.1739130 };
const float sampleWeights[5] = { 0.16818994, 0.27276957, 0.11690125, 0.024067905, 0.0021112196 };
#line 190
float4 color = tex2D(ReShade::BackBuffer, texcoord) * sampleWeights[0];
for(int i = 1; i < gN_PASSES; ++i) {
color += tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(0.0, sampleOffsets[i]*gBloomVW *  float2((1.0 / 1799),(1.0 / 998)).y), 0.0, 0.0)) * sampleWeights[i];
color += tex2Dlod(ReShade::BackBuffer, float4(texcoord - float2(0.0, sampleOffsets[i]*gBloomVW *  float2((1.0 / 1799),(1.0 / 998)).y), 0.0, 0.0)) * sampleWeights[i];
}
#line 196
return float4(color.rgb + TriDither(color.rgb, texcoord, 8), color.a);
#line 200
}
#line 202
float4 SGaussianBlurPS(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
#line 205
const float sampleOffsets[5] = { 0.0, 1.4347826, 3.3478260, 5.2608695, 7.1739130 };
const float sampleWeights[5] = { 0.16818994, 0.27276957, 0.11690125, 0.024067905, 0.0021112196 };
#line 212
float4 color = tex2D(ReShade::BackBuffer, texcoord) * sampleWeights[0];
for(int i = 1; i < gN_PASSES; ++i) {
color += tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(sampleOffsets[i]*gBloomSW *  float2((1.0 / 1799),(1.0 / 998)).x, sampleOffsets[i] *  float2((1.0 / 1799),(1.0 / 998)).y), 0.0, 0.0)) * sampleWeights[i];
color += tex2Dlod(ReShade::BackBuffer, float4(texcoord - float2(sampleOffsets[i]*gBloomSW *  float2((1.0 / 1799),(1.0 / 998)).x, sampleOffsets[i] *  float2((1.0 / 1799),(1.0 / 998)).y), 0.0, 0.0)) * sampleWeights[i];
color += tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-sampleOffsets[i]*gBloomSW *  float2((1.0 / 1799),(1.0 / 998)).x, sampleOffsets[i] *  float2((1.0 / 1799),(1.0 / 998)).y), 0.0, 0.0)) * sampleWeights[i];
color += tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(sampleOffsets[i]*gBloomSW *  float2((1.0 / 1799),(1.0 / 998)).x, -sampleOffsets[i] *  float2((1.0 / 1799),(1.0 / 998)).y), 0.0, 0.0)) * sampleWeights[i];
}
#line 220
color *= 0.50;
return float4(color.rgb + TriDither(color.rgb, texcoord, 8), color.a);
#line 225
}
#line 227
float4 CombinePS(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
#line 233
float4 orig = tex2D(origframeSampler, texcoord);
const float4 blur = tex2D(ReShade::BackBuffer, texcoord);
float3 sharp;
if (gGaussEffect == 0)
orig = orig;
else if (gGaussEffect == 1)
{
#line 241
orig = lerp(orig, blur, gGaussStrength);
}
else if (gGaussEffect == 2)
{
#line 246
sharp = orig.rgb - blur.rgb;
float sharp_luma = dot(sharp,  (            float3(0.2126, 0.7152, 0.0722)       * gGaussStrength + 0.2));
sharp_luma = clamp(sharp_luma, -        0.035,         0.035);
orig = orig + sharp_luma;
}
else if (gGaussEffect == 3)
{
#line 254
if (gGaussBloomWarmth == 0)
orig = lerp(orig, blur *4, gGaussStrength);
#line 257
else if (gGaussBloomWarmth == 1)
orig = lerp(orig, max(orig *1.8 + (blur *5) - 1.0, 0.0), gGaussStrength);       
else
orig = lerp(orig, (1.0 - ((1.0 - orig) * (1.0 - blur *1.0))), gGaussStrength);  
}
else if (gGaussEffect == 4)
{
#line 265
sharp = orig.rgb - blur.rgb;
orig = float4(1.0, 1.0, 1.0, 0.0) - min(orig, dot(sharp,  (            float3(0.2126, 0.7152, 0.0722)       * gGaussStrength + 0.2))) *3;
#line 268
}
else
orig = blur;
#line 272
if (gAddBloom == 1)
{
if (gGaussBloomWarmth == 0)
{
orig += lerp(orig, blur *4, gBloomStrength);
orig = orig * 0.5;
}
else if (gGaussBloomWarmth == 1)
{
orig += lerp(orig, max(orig *1.8 + (blur *5) - 1.0, 0.0), gBloomStrength);
orig = orig * 0.5;
}
else
{
orig += lerp(orig, (1.0 - ((1.0 - orig) * (1.0 - blur *1.0))), gBloomStrength);
orig = orig * 0.5;
}
}
else
orig = orig;
#line 299
return float4(orig.rgb + TriDither(orig.rgb, texcoord, 8), orig.a);
#line 303
}
#line 305
float4 PassThrough(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
return tex2D(ReShade::BackBuffer, texcoord);
}
#line 310
technique GAUSSSIAN
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PassThrough;
RenderTarget = origframeTex2D;
}
#line 320
pass P0
{
VertexShader = PostProcessVS;
PixelShader = BrightPassFilterPS;
}
#line 328
pass P1
{
VertexShader = PostProcessVS;
PixelShader = HGaussianBlurPS;
}
#line 336
pass P2
{
VertexShader = PostProcessVS;
PixelShader = VGaussianBlurPS;
}
#line 344
pass P3
{
VertexShader = PostProcessVS;
PixelShader = SGaussianBlurPS;
}
#line 351
pass P5
{
VertexShader = PostProcessVS;
PixelShader = CombinePS;
}
}
