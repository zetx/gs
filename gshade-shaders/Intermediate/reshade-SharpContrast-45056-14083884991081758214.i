#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\ComputeShaders\SharpContrast.fx"
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
#line 15 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\ComputeShaders\SharpContrast.fx"
#line 89
static const float PI = 3.1415926536;
static const float GAUSSIAN_WEIGHTS[5] = {0.095766,	0.303053,	0.20236,	0.303053,	0.095766};
static const float GAUSSIAN_OFFSETS[5] = {-3.2979345488, -1.40919905099, 0, 1.40919905099, 3.2979345488};
#line 94
namespace SharpContrast
{
texture BackBuffer : COLOR;
texture Luma<pooled = true;>{Width = 3440; Height = 1440; Format = R8;};
texture Temp<pooled = true;>{Width = 3440; Height = 1440; Format = R8;};
#line 101
sampler sBackBuffer{Texture = BackBuffer;};
sampler sLuma {Texture = Luma;};
sampler sTemp {Texture = Temp;};
#line 105
storage wLuma {Texture = Luma;};
storage wTemp {Texture = Temp;};
#line 108
uniform float SharpenStrength<
ui_type = "slider";
ui_label = "Strength";
ui_tooltip = "Strength of the sharpen.";
ui_min = 0; ui_max = 1;
ui_step = 0.001;
> = 0.667;
#line 116
uniform float EdgeBias<
ui_type = "slider";
ui_label = "Edge Contrast";
ui_tooltip = "Changes how much contrast and coarseness there is near edges.";
ui_min = 0; ui_max = 1;
ui_step = 0.001;
> = 1;
#line 124
uniform float EdgeFloor<
ui_type = "slider";
ui_label = "Edge Floor";
ui_tooltip = "Amount of sharpening allowed on edges.";
ui_min = 0; ui_max = 1;
ui_step = 0.001;
> = 0;
#line 132
uniform bool GammaCorrect<
ui_label = "Use Linear Color Gamut";
ui_tooltip = "Changes whether the sharpen is applied on a linear\n"
"or standard color gamut.";
> = true;
#line 138
uniform bool EnableDepth<
ui_category = "Depth Settings";
ui_label = "Enable Depth Settings";
ui_tooltip = "This setting must be enabled to be able to adjust the Depth Curve \n"
"or enable the Mask Sky option.";
> = false;
#line 145
uniform float DepthCurve<
ui_type = "slider";
ui_label = "Depth Curve";
ui_category = "Depth Settings";
ui_tooltip = "Adjusts how the sharpen fades with depth, lower values mean a shorter fadeout distance.";
ui_min = 0; ui_max = 1;
ui_step = 0.001;
> = 1;
#line 154
uniform bool MaskSky<
ui_category = "Depth Settings";
ui_label = "Mask Sky";
ui_tooltip = "This setting prevents the sky from having the sharpen applied.";
> = true;
#line 161
uniform int Debug<
ui_type = "combo";
ui_items = "None\0Masking\0Sharpen\0";
ui_label = "Debug View";
ui_category = "Debug";
ui_tooltip = "Masking: Shows the regions where the sharpen is having its application limited.\n"
"Sharpen: Shows the sharpen that's being applied to the image.";
> = 0;
#line 170
void LumaCS(uint3 id : SV_DispatchThreadID)
{
float4 r = tex2DgatherR(sBackBuffer, (float2(id.xy * 2) + 0.5)/float2(3440, 1440));
float4 g = tex2DgatherG(sBackBuffer, (float2(id.xy * 2) + 0.5)/float2(3440, 1440));
float4 b = tex2DgatherB(sBackBuffer, (float2(id.xy * 2) + 0.5)/float2(3440, 1440));
#line 176
float4 luma;
luma.x = dot(float3(r.x, g.x, b.x), float3(0.299, 0.587, 0.114));
luma.y = dot(float3(r.y, g.y, b.y), float3(0.299, 0.587, 0.114));
luma.z = dot(float3(r.z, g.z, b.z), float3(0.299, 0.587, 0.114));
luma.w = dot(float3(r.w, g.w, b.w), float3(0.299, 0.587, 0.114));
#line 182
tex2Dstore(wLuma, id.xy * 2 + int2(0, 1), luma.xyzw);
tex2Dstore(wLuma, id.xy * 2 + int2(1, 1), luma.yyyy);
tex2Dstore(wLuma, id.xy * 2 + int2(1, 0), luma.zzzz);
tex2Dstore(wLuma, id.xy * 2 + int2(0, 0), luma.wwww);
}
#line 188
groupshared float samples[ ( (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).x *  (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).y)];
groupshared uint throwAway;
void KuwaharaSharpCS(uint3 id : SV_DispatchThreadID, uint3 tid : SV_GroupThreadID)
{
uint2 cornerCoord = (id.xy - tid.xy) *  uint2(1, 1);
#line 194
float sharpnessMultiplier = max(1023 * pow(( 2 * EdgeBias / 3) + 0.333333, 4), 1e-10);
[unroll]
for(int j = tid.y * 2; j <  (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).y; j +=  uint2(8, 8).y * 2)
{
[unroll]
for(int i = tid.x * 2; i <  (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).x; i +=  uint2(8, 8).x * 2)
{
float2 sampleCoord = (cornerCoord) + int2(i, j) - ( 7 / 2).xx;
#line 203
sampleCoord += 0.5;
sampleCoord = (sampleCoord < 0) ? abs(sampleCoord) :
(sampleCoord > float2(3440, 1440)) ? float2(3440, 1440) - (sampleCoord - float2(3440, 1440)) : sampleCoord;
#line 207
sampleCoord /= float2(3440, 1440);
#line 209
float4 r = tex2DgatherR(sLuma, sampleCoord);
#line 212
if(GammaCorrect)
{
r *= r;
}
#line 217
r *= sharpnessMultiplier;
#line 220
int arrayIndex =  uint((i) + (j) * ( (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).x));
#line 222
samples[arrayIndex +  (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).x] = r.x;
samples[arrayIndex +  (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).x + 1] = r.y;
samples[arrayIndex + 1] = r.z;
samples[arrayIndex] = r.w;
}
}
barrier();
#line 230
[unroll]
for(int k = 0; k <  ( uint2(1, 1).x *  uint2(1, 1).y); k++)
{
float sum[ 7];
float squaredSum[ 7];
float sampleCount[ 7];
float maximum = 0;
float minimum = sharpnessMultiplier;
float center;
uint2 coord = tid.xy *  uint2(1, 1);
coord.x += k %  uint2(1, 1).x;
coord.y += k /  uint2(1, 1).y;
#line 244
[unroll]
for(int i = -( 7/2); i <= ( 7/2); i++)
{
[unroll]
for(int j = -( 7/2); j <= ( 7/2); j++)
{
[flatten]
if(all(int2(i, j) == 0))
{
uint arrayIndex =  uint((coord.x + ( 7/2)) + (coord.y + ( 7/2)) * ( (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).x));
float luma = samples[arrayIndex];
center = luma * rcp(sharpnessMultiplier);
maximum = max(maximum, luma);
minimum = min(minimum, luma);
[unroll]
for(int i = 0; i <  7; i++)
{
sum[i] += luma;
squaredSum[i] += luma * luma;
sampleCount[i]++;
}
}
else
{
float angle = atan2(float(j), float(i)) + PI;
uint sector = float((angle *  7) / (PI * 2)) %  7;
uint arrayIndex =  uint((i + coord.x + ( 7/2)) + (j + coord.y + ( 7/2)) * ( (( uint2(8, 8) *  uint2(1, 1)) + ( 7 / 2).xx * 2).x));
float luma = samples[arrayIndex];
float centerDistance = length(float2(i, j));
maximum = max(maximum, luma * rcp((centerDistance)));
minimum = min(minimum, luma * (centerDistance));
sum[sector] += luma;
squaredSum[sector] += luma * luma;
sampleCount[sector]++;
}
}
}
float edgeMultiplier = (max((1-(maximum - minimum) * rcp(maximum)), 1e-5));
edgeMultiplier = edgeMultiplier * (1 - EdgeFloor) + EdgeFloor;
#line 284
float weightedSum = 0;
float weightSum = 0;
uint count = 0;
[unroll]
for(int i = 0; i <  7; i++)
{
float sumSquared = sum[i] * sum[i];
float mean = sum[i] / sampleCount[i];
float variance = (squaredSum[i] - ((sumSquared) / sampleCount[i]));
variance /= sampleCount[i];
#line 295
float weight = max( variance, 1e-5);
weight *= weight;
weight *= weight;
weight = rcp(1 + weight);
#line 300
weightedSum += mean * weight;
weightSum += weight;
}
#line 304
float kuwahara = ((weightedSum) / weightSum) / sharpnessMultiplier;
#line 307
if(Debug == 1) kuwahara = edgeMultiplier;
else kuwahara = center + (center - kuwahara) * SharpenStrength * edgeMultiplier * 1.5;
if(GammaCorrect) kuwahara = sqrt(kuwahara);
tex2Dstore(wTemp, cornerCoord + coord, kuwahara);
}
}
#line 314
void OutputPS(float4 vpos : SV_POSITION, float2 texcoord : TEXCOORD, out float4 output : SV_TARGET0)
{
float y = tex2D(sTemp, texcoord).x;
float3 color = tex2D(sBackBuffer, texcoord).rgb;
float cb = dot(color, float3(-0.168736, -0.331264, 0.5));
float cr = dot(color, float3(0.5, -0.418688, -0.081312));
float luma = dot(color, float3(0.299, 0.587, 0.114));
#line 323
output.r = dot(float2(y, cr), float2(1, 1.402));
output.g = dot(float3(y, cb, cr), float3(1, -0.344135, -0.714136));
output.b = dot(float2(y, cb), float2(1, 1.772));
output.a = 1;
#line 328
float depthCurve = 1;
if(EnableDepth)
{
float depth = ReShade::GetLinearizedDepth(texcoord);
depthCurve = lerp(0, 1, 1/max(exp(depth * (1 - DepthCurve) * 3), 0.0001));
if(MaskSky && depth > 0.999) depthCurve = 0;
output = lerp(color.rgbr, output, depthCurve);
}
#line 337
if(Debug == 1) output = y * depthCurve;
else if(Debug == 2)
{
output = (color.xyzx - output) + 0.5;
}
#line 343
}
#line 345
technique SharpContrast< ui_tooltip =     "SharpContrast is a sharpen that takes into acount a wider screen area,\n"
"than most sharpen shaders, while also attempting to avoid crossing contrast boundries, \n"
"giving it a unique look.\n\n"
"Part of Insane Shaders\n"
"By: Lord of Lunacy\n\n"
"SHARP_CONTRAST_SIZE: Changes the size of the filter being used.\n"
"\t\t Set lower for more performance.\n"
"SHARP_CONTRAST_FASTER_COMPILE: Set to 0 for a slight performance increase,\n"
"\t\t at the expense of a longer compile time.";
>
{
pass
{
ComputeShader = LumaCS<8, 8>;
DispatchSizeX =  uint(((3440) + (16) - 1) / (16));
DispatchSizeY =  uint(((1440) + (16) - 1) / (16));
}
pass
{
ComputeShader = KuwaharaSharpCS< uint2(8, 8).x,  uint2(8, 8).y>;
DispatchSizeX =  uint(((3440) + (( uint2(1, 1).x *  uint2(8, 8).x)) - 1) / (( uint2(1, 1).x *  uint2(8, 8).x)));
DispatchSizeY =  uint(((1440) + (( uint2(1, 1).y *  uint2(8, 8).y)) - 1) / (( uint2(1, 1).y *  uint2(8, 8).y)));
}
#line 369
pass
{
VertexShader = PostProcessVS;
PixelShader = OutputPS;
}
}
}

