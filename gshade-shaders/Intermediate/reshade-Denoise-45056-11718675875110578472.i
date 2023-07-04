#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Denoise.fx"
#line 97
uniform float NoiseLevel <
ui_type = "slider";
ui_min = 0.01; ui_max = 1.00;
ui_label = "Noise Level";
ui_tooltip = "Approximate level of noise in the image.";
> = 0.15;
#line 104
uniform float LerpCoefficeint <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.00;
ui_label = "Lerp Coefficient";
ui_tooltip = "Amount of blending between the original and the processed image.";
> = 0.8;
#line 111
uniform float WeightThreshold <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Weight Threshold";
> = 0.03;
#line 117
uniform float CounterThreshold <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Counter Threshold";
> = 0.05;
#line 123
uniform float GaussianSigma <
ui_type = "slider";
ui_min = 1.0; ui_max = 100.0;
ui_label = "Gaussian Sigma";
ui_tooltip = "Controls the additional amount of gaussian blur on the image.";
> = 50.0;
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
#line 144 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Denoise.fx"
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
#line 147 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Denoise.fx"
#line 150
float3 PS_Denoise_KNN(float4 vpos : SV_POSITION, float2 texcoord : TEXCOORD) : SV_TARGET {
const float3 orig = tex2D(ReShade::BackBuffer, texcoord).rgb;
float3 texIJ;
float weight;
float3 result = 0.0;
float counter = 0.0;
float sum = 0.0;
#line 158
float iWindowArea = 2.0 *  3	 + 1.0;
iWindowArea *= iWindowArea;
#line 161
for (int i = - 3	; i <=  3	; i++) {
for (int j = - 3	; j <=  3	; j++) {
texIJ = tex2Dlod(ReShade::BackBuffer, float4(texcoord +  float2((1.0 / 1309), (1.0 / 762)) * float2(i, j), 0.0, 0.0)).rgb;
weight = dot(orig - texIJ, orig - texIJ);
#line 166
weight = exp(-(weight * rcp(NoiseLevel) + (i * i + j * j) * rcp(GaussianSigma)));
counter += weight > WeightThreshold;
#line 169
sum += weight;
#line 171
result.rgb += texIJ * weight;
}
}
#line 175
result /= sum;
#line 177
if (counter > (CounterThreshold * iWindowArea)) {
#line 179
result = lerp(result, orig, 1.0 - LerpCoefficeint);
return result + TriDither(result, texcoord, 8);
#line 184
}
else {
#line 187
result = lerp(result, orig, LerpCoefficeint);
return result + TriDither(result, texcoord, 8);
#line 192
}
}
#line 195
float3 PS_Denoise_NLM(float4 vpos : SV_POSITION, float2 texcoord : TEXCOORD) : SV_TARGET {
float3 result = 0.0;
float3 texIJb;
float3 texIJc;
float counter = 0.0;
float weight;
float sum = 0.0;
#line 203
float invBlockArea = 2.0 *  2	 + 1.0;
invBlockArea = rcp(invBlockArea * invBlockArea);
#line 206
for (int i = - 3	; i <=  3	; i++) {
for (int j = - 3	; j <=  3	; j++) {
#line 209
weight = 0.0;
#line 211
for (int n = - 2	; n <=  2	; n++) {
for (int m = - 2	; m <=  2	; m++) {
texIJb = tex2Dlod(ReShade::BackBuffer, float4(texcoord +  float2((1.0 / 1309), (1.0 / 762)) * float2(i + n, j + m), 0.0, 0.0)).rgb;
texIJc = tex2Dlod(ReShade::BackBuffer, float4(texcoord +  float2((1.0 / 1309), (1.0 / 762)) * float2(    n,     m), 0.0, 0.0)).rgb;
weight = dot(texIJb - texIJc, texIJb - texIJc) + weight;
}
}
texIJc = tex2Dlod(ReShade::BackBuffer, float4(texcoord +  float2((1.0 / 1309), (1.0 / 762)) * float2(i, j), 0.0, 0.0)).rgb;
#line 220
weight *= invBlockArea;
weight = exp(-(weight * rcp(NoiseLevel) + (i * i + j * j) * rcp(GaussianSigma)));
#line 223
counter += weight > WeightThreshold;
#line 225
sum += weight;
#line 227
result += texIJc * weight;
}
}
#line 231
float iWindowArea = 2.0 *  3	 + 1.0;
iWindowArea *= iWindowArea;
#line 234
result /= sum;
#line 236
if (counter > (CounterThreshold * iWindowArea)) {
#line 238
result = lerp(result, tex2D(ReShade::BackBuffer, texcoord).rgb, 1.0 - LerpCoefficeint);
return result + TriDither(result, texcoord, 8);
#line 243
}
else {
#line 246
result = lerp(result, tex2D(ReShade::BackBuffer, texcoord).rgb, LerpCoefficeint);
return result + TriDither(result, texcoord, 8);
#line 251
}
}
#line 254
technique KNearestNeighbors
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_Denoise_KNN;
}
}
#line 263
technique NonLocalMeans
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_Denoise_NLM;
}
}

