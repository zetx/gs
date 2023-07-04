#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\ComputeShaders\LocalContrastCS.fx"
#line 51
namespace LocalContrast
{
texture BackBuffer : COLOR;
texture LocalTiles {Width =  1024; Height =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).y; Format = R32f;};
texture Histogram {Width =  1024; Height = 1; Format = R32f;};
texture HistogramLUT {Width =  1024; Height =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).y; Format = R32f;};
texture RegionVariancesH {Width =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).y; Height = 1; Format = RGBA32f;};
texture RegionVariances {Width =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).y; Height = 1; Format = RGBA32f;};
#line 60
sampler sBackBuffer {Texture = BackBuffer;};
sampler sLocalTiles {Texture = LocalTiles;};
sampler sHistogram {Texture = Histogram;};
sampler sHistogramLUT {Texture = HistogramLUT;};
sampler sRegionVariancesH {Texture = RegionVariancesH;};
sampler sRegionVariances {Texture = RegionVariances;};
#line 67
storage wLocalTiles {Texture = LocalTiles;};
storage wHistogram {Texture = Histogram;};
storage wHistogramLUT {Texture = HistogramLUT;};
storage wRegionVariancesH {Texture = RegionVariancesH;};
storage wRegionVariances {Texture = RegionVariances;};
#line 73
static const float GAUSSIAN[9] = {0.063327,	0.093095,	0.122589,	0.144599,	0.152781,	0.144599,	0.122589,	0.093095,	0.063327};
#line 80
uniform float GlobalStrength<
ui_type = "slider";
ui_label = "Strength";
ui_min = 0; ui_max = 1;
> = 0.75;
#line 86
uniform float Minimum<
ui_type = "slider";
ui_label = "Minimum";
ui_category = "Thresholds";
ui_min = 0; ui_max = 1;
> = 0;
#line 93
uniform float DarkThreshold<
ui_type = "slider";
ui_label = "Dark Threshold";
ui_category = "Thresholds";
ui_min = 0; ui_max = 1;
> = 0.333;
#line 100
uniform float LightThreshold<
ui_type = "slider";
ui_label = "LightThreshold";
ui_category = "Thresholds";
ui_min = 0; ui_max = 1;
> = 0.667;
#line 107
uniform float Maximum<
ui_type = "slider";
ui_label = "Maximum";
ui_category = "Thresholds";
ui_min = 0; ui_max = 1;
> = 1;
#line 114
uniform float DarkPeak<
ui_type = "slider";
ui_label = "Dark Blending Curve";
ui_category = "Dark Settings";
ui_min = 0; ui_max = 1;
> = 0.075;
#line 121
uniform float DarkMax<
ui_type = "slider";
ui_label = "Dark Maximum Blending";
ui_category = "Dark Settings";
ui_min = 0; ui_max = 1;
> = 0.15;
#line 128
uniform float MidPeak<
ui_type = "slider";
ui_label = "Mid Blending Curve";
ui_category = "Mid Settings";
ui_min = 0; ui_max = 1;
> = 0.5;
#line 135
uniform float MidMax<
ui_type = "slider";
ui_label = "Mid Maximum Blending";
ui_category = "Mid Settings";
ui_min = 0; ui_max = 1;
> = 0.4;
#line 142
uniform float LightPeak<
ui_type = "slider";
ui_label = "Light Blending Curve";
ui_category = "Light Settings";
ui_min = 0; ui_max = 1;
> = 0.7;
#line 149
uniform float LightMax<
ui_type = "slider";
ui_label = "Light Maximum Blending";
ui_category = "Light Settings";
ui_min = 0; ui_max = 1;
> = 0.3;
#line 157
groupshared uint HistogramBins[ 1024];
void HistogramTilesCS(uint3 id : SV_DispatchThreadID, uint3 gid : SV_GroupID, uint3 gtid : SV_GroupThreadID)
{
uint threadIndex = gtid.x + gtid.y *  uint2(32, 32).x;
uint groupIndex = gid.x + gid.y *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
#line 163
[unroll]
while(threadIndex <  1024)
{
HistogramBins[threadIndex] = 0;
threadIndex +=  uint2(32, 32).x *  uint2(32, 32).y;
}
barrier();
#line 171
uint localValue[ ( uint2(3, 3).x *  uint2(3, 3).y)];
[unroll]
for(int i = 0; i <  uint2(3, 3).x; i++)
{
[unroll]
for(int j = 0; j <  uint2(3, 3).y; j++)
{
float2 coord = (gid.xy *  uint2(3, 3) *  uint2(32, 32) + (gtid.xy *  uint2(3, 3) + float2(i, j)) * 3) *  1;
coord -= float2( uint2(32, 32) *  uint2(3, 3)) * 1.5;
uint arrayIndex = i +  uint2(3, 3).x * j;
if(any(coord >= uint2(1024, 768)) || any(coord < 0))
{
localValue[arrayIndex] =  1024;
}
else
{
localValue[arrayIndex] = uint(round(dot(tex2Dfetch(sBackBuffer, float2(coord)).rgb, float3(0.299, 0.587, 0.114)) * ( 1024 - 1)));
}
}
}
#line 193
[unroll]
for(int i = 0; i <  ( uint2(3, 3).x *  uint2(3, 3).y); i++)
{
if(localValue[i] <  1024)
{
atomicAdd(HistogramBins[localValue[i]], 1);
}
}
barrier();
threadIndex = gtid.x + gtid.y *  uint2(32, 32).x;
[unroll]
while(threadIndex <  1024)
{
tex2Dstore(wLocalTiles, int2(threadIndex, groupIndex), float4(HistogramBins[threadIndex], 1, 1, 1));
threadIndex +=  uint2(32, 32).x *  uint2(32, 32).y;
}
}
#line 211
groupshared float prefixSums[ 1024 * 2];
groupshared float valuePrefixSums[ 1024 * 2];
groupshared float3 regionSums;
groupshared float3 regionMeans;
groupshared uint3 regionVariances;
#line 217
void ContrastLUTCS(uint3 id : SV_DispatchThreadID)
{
float localBin = tex2Dfetch(sLocalTiles, id.xy).r;
float localPrefixSum = localBin;
float luma = (float(id.x) / float( 1024 - 1));
float localValuePrefixSum = localBin * luma;
prefixSums[id.x] = localPrefixSum;
valuePrefixSums[id.x] = localValuePrefixSum;
barrier();
#line 227
uint2 prefixSumOffset = uint2(0,  1024);
#line 229
bool enabled = true;
#line 231
[unroll]
for(int i = 0; i < log2( 1024 - 1) + 1; i++)
{
int access = id.x - exp2(i);
if(access >= 0)
{
localPrefixSum += prefixSums[access + prefixSumOffset.x];
localValuePrefixSum += valuePrefixSums[access + prefixSumOffset.x];
prefixSums[id.x + prefixSumOffset.y] = localPrefixSum;
valuePrefixSums[id.x + prefixSumOffset.y] = localValuePrefixSum;
}
else if (enabled)
{
prefixSums[id.x + prefixSumOffset.y] = localPrefixSum;
valuePrefixSums[id.x + prefixSumOffset.y] = localValuePrefixSum;
enabled = false;
}
#line 249
prefixSumOffset.xy = prefixSumOffset.yx;
barrier();
}
#line 253
float3 localRegionSums;
float3 localRegionMeans;
uint darkThresholdUint = DarkThreshold * ( 1024 - 1);
uint lightThresholdUint = LightThreshold * ( 1024 - 1);
#line 258
if(id.x == 0)
{
localRegionSums.x = prefixSums[darkThresholdUint + prefixSumOffset.x];
localRegionSums.y = prefixSums[lightThresholdUint + prefixSumOffset.x];
localRegionSums.z = prefixSums[ 1024 - 1 + prefixSumOffset.x];
#line 264
localRegionMeans.x = valuePrefixSums[darkThresholdUint + prefixSumOffset.x];
localRegionMeans.y = valuePrefixSums[lightThresholdUint + prefixSumOffset.x];
localRegionMeans.z = valuePrefixSums[ 1024 - 1 + prefixSumOffset.x];
localRegionMeans /= localRegionSums;
regionMeans = localRegionMeans;
#line 270
localRegionSums.z -= localRegionSums.y;
localRegionSums.y -= localRegionSums.x;
regionSums = localRegionSums;
regionVariances = 0;
}
barrier();
#line 277
localRegionSums = regionSums;
localRegionMeans = regionMeans;
float lutValue;
#line 281
if(id.x <= darkThresholdUint)
{
if(localRegionSums.x == 0)
{
lutValue = (float(id.x) / float( 1024 - 1));
}
else
{
float offset = Minimum;
float multiplier = float(DarkThreshold - Minimum);
lutValue = saturate((localPrefixSum / localRegionSums.x) * multiplier) + offset;
}
uint varianceComponent = uint(float(abs(luma - localRegionMeans.x)) * float(localBin * ( 1024)));
atomicAdd(regionVariances[0], varianceComponent);
}
else if(id.x <= lightThresholdUint)
{
if(localRegionSums.y == 0)
{
lutValue = (float(id.x) / float( 1024 - 1));
}
else
{
float offset = DarkThreshold;
float multiplier = float(LightThreshold - DarkThreshold);
localPrefixSum -= localRegionSums.x;
lutValue = saturate(((localPrefixSum) / localRegionSums.y) * multiplier) + offset;
}
uint varianceComponent = uint(float(abs(luma - localRegionMeans.y)) * float(localBin * ( 1024)));
atomicAdd(regionVariances[1], varianceComponent);
}
else
{
if(localRegionSums.z == 0)
{
lutValue = (float(id.x) / float( 1024 - 1));
}
else
{
float offset = LightThreshold;
float multiplier = float(LightThreshold - DarkThreshold);
localPrefixSum -= localRegionSums.x + localRegionSums.y;
lutValue = saturate(((localPrefixSum) / localRegionSums.z) * multiplier) + offset;
}
uint varianceComponent = uint(float(abs(luma - localRegionMeans.z)) * float(localBin * ( 1024)));
atomicAdd(regionVariances[2], varianceComponent);
}
barrier();
#line 330
if(id.x == 0)
{
float3 localRegionVariances = float3(regionVariances) / (( 1024) * float3(max(localRegionSums, 0.001)));
#line 334
tex2Dstore(wRegionVariances, int2(id.y, 0), float4(localRegionVariances.xyz, 1));
}
#line 337
tex2Dstore(wHistogramLUT, id.xy, lutValue);
}
#line 341
void PostProcessVS(in uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD)
{
texcoord.x = (id == 2) ? 2.0 : 0.0;
texcoord.y = (id == 1) ? 2.0 : 0.0;
position = float4(texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 348
float WeightingCurve(float peak, float variance, float maximumBlending)
{
float output;
if(variance <= peak)
{
return lerp(0, maximumBlending, abs(variance) / peak);
}
else
{
return lerp(maximumBlending, 0, abs(variance - peak) / (1 - peak));
}
}
#line 361
void LUTInterpolation(uint2 coord, float yOld, out float yNew, out float3 variances)
{
uint2 blockSize = uint2(( uint2(32, 32).x *  uint2(3, 3).x), ( uint2(32, 32).y *  uint2(3, 3).y));
uint2 groupCoord = coord / blockSize;
int2 position = (coord % blockSize) - float2(blockSize / 2);
float2 positionCoord = float2(abs(position)) / float2(blockSize);
float2 weights = smoothstep(0, 1, positionCoord);
uint group = groupCoord.x + groupCoord.y *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
int2 groupCoordW;
float samples[4];
float3 varianceSamples[4];
samples[0] = tex2Dfetch(sHistogramLUT, float2(yOld *  1024, group)).x;
varianceSamples[0] = tex2Dfetch(sRegionVariances, float2(group, 0)).xyz;
int2 groupCoordTemp = groupCoord;
if(position.x < 0)
{
groupCoordTemp.x -= 1;
groupCoordTemp = clamp(groupCoordTemp, 0,  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))));
groupCoordW = groupCoordTemp;
group = groupCoord.x + groupCoord.y *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
samples[1] = tex2Dfetch(sHistogramLUT, float2(yOld *  1024, group)).x;
varianceSamples[1] = tex2Dfetch(sRegionVariances, float2(group, 0)).xyz;
}
else
{
groupCoordTemp.x += 1;
groupCoordTemp = clamp(groupCoordTemp, 0,  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))));
groupCoordW = groupCoordTemp;
group = groupCoordTemp.x + groupCoordTemp.y *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
samples[1] = tex2Dfetch(sHistogramLUT, float2(yOld *  1024, group)).x;
varianceSamples[1] = tex2Dfetch(sRegionVariances, float2(group, 0)).xyz;
}
#line 394
if(position.y < 0)
{
groupCoordTemp.y -= 1;
groupCoordTemp = clamp(groupCoordTemp, 0,  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))));
groupCoordW.y = groupCoordTemp.y;
group = groupCoordTemp.x + groupCoordTemp.y *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
samples[2] = tex2Dfetch(sHistogramLUT, float2(yOld *  1024, group)).x;
varianceSamples[2] = tex2Dfetch(sRegionVariances, float2(group, 0)).xyz ;
}
else
{
groupCoordTemp.y += 1;
groupCoordTemp = clamp(groupCoordTemp, 0,  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))));
groupCoordW.y = groupCoordTemp.y;
group = groupCoordTemp.x + groupCoordTemp.y *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
samples[2] = tex2Dfetch(sHistogramLUT, float2(yOld *  1024, group)).x;
varianceSamples[2] = tex2Dfetch(sRegionVariances, float2(group, 0)).xyz;
}
#line 413
group = groupCoordW.x + groupCoordW.y *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
samples[3] = tex2Dfetch(sHistogramLUT, float2(yOld *  1024, group)).x;
varianceSamples[3] = tex2Dfetch(sRegionVariances, float2(group, 0)).xyz;
#line 417
yNew = lerp(lerp(samples[0], samples[1], weights.x), lerp(samples[2], samples[3], weights.x), weights.y);
variances = lerp(lerp(varianceSamples[0], varianceSamples[1], weights.x), lerp(varianceSamples[2], varianceSamples[3], weights.x), weights.y);
}
#line 421
void GaussianVarianceHPS(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float4 GaussianVariance : SV_Target0)
{
GaussianVariance = 0;
uint textureHeight =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).y;
uint2 coord = texcoord * float2(1, textureHeight);
uint2 group = uint2(coord.x / ( uint2(32, 32).x *  uint2(3, 3).x), (coord.y / ( uint2(32, 32).y *  uint2(3, 3).y)));
[unroll]
for(int i = -4; i <= 4; i++)
{
int2 sampleCoord = uint2(coord.x, coord.y + i);
sampleCoord.y = clamp(sampleCoord.y, 0, textureHeight - 1);
sampleCoord.xy = sampleCoord.yx;
GaussianVariance.xyz += GAUSSIAN[i + 4] * tex2Dfetch(sRegionVariances, sampleCoord).xyz;
}
GaussianVariance.w = 1;
}
#line 438
void GaussianVarianceVPS(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float4 GaussianVariance : SV_Target0)
{
GaussianVariance = 0;
uint textureHeight =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).y;
uint2 coord = texcoord * float2(1, textureHeight);
uint2 group = uint2(coord.x / ( uint2(32, 32).x *  uint2(3, 3).x), (coord.y / ( uint2(32, 32).y *  uint2(3, 3).y)));
int2 clampingValues;
clampingValues.x = coord.y %  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
clampingValues.y = textureHeight - ( uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x - clampingValues.x) - 1;
[unroll]
for(int i = -4; i <= 4; i++)
{
int2 sampleCoord = uint2(coord.x, coord.y + i *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x);
sampleCoord.y = clamp(sampleCoord.y, clampingValues.x, clampingValues.y);
sampleCoord.xy = sampleCoord.yx;
GaussianVariance.xyz += GAUSSIAN[i + 4] * tex2Dfetch(sRegionVariancesH, sampleCoord).xyz;
}
GaussianVariance.w = 1;
}
#line 459
void OutputPS(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float3 color : SV_Target0)
{
color = tex2D(sBackBuffer, texcoord).rgb;
uint2 coord = texcoord * float2(1024, 768);
float yOld = dot(color, float3(0.299, 0.587, 0.114));
uint group = coord.x / ( uint2(32, 32).x *  uint2(3, 3).x) + (coord.y / ( uint2(32, 32).y *  uint2(3, 3).y)) *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
float3 variances;
float yNew;
LUTInterpolation(coord,  yOld, yNew, variances);
float alpha;
#line 471
if(yOld <= DarkThreshold)
{
alpha = WeightingCurve(DarkPeak, variances.x, DarkMax);
#line 475
}
else if(yOld <= LightThreshold)
{
alpha = WeightingCurve(MidPeak, variances.y, MidMax);
#line 480
}
else
{
alpha = WeightingCurve(LightPeak, variances.z, LightMax);
#line 485
}
float y = lerp(yOld, yNew, (alpha * GlobalStrength));
#line 488
float cb = -0.168736 * color.r - 0.331264 * color.g + 0.500000 * color.b;
float cr = +0.500000 * color.r - 0.418688 * color.g - 0.081312 * color.b;
#line 491
color = float3(
y + 1.402 * cr,
y - 0.344136 * cb - 0.714136 * cr,
y + 1.772 * cb);
#line 496
}
#line 498
technique LocalContrastCS<ui_tooltip = "A histogram based contrast stretching shader that locally adjusts the contrast of the image\n"
"based on the contents of small regions of the image.\n\n"
"May cause square shaped artifacting \n\n"
"Part of the Insane Shaders repository";>
{
pass
{
ComputeShader = HistogramTilesCS< uint2(32, 32).x,  uint2(32, 32).y>;
DispatchSizeX =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x;
DispatchSizeY =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).y;
}
#line 510
pass
{
ComputeShader = ContrastLUTCS<( 1024), 1>;
DispatchSizeX = 1;
DispatchSizeY =  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).x *  uint2( (int(1024 +  uint2(3, 3).x *  uint2(32, 32).x *  1 - 1) / int( uint2(3, 3).x *  uint2(32, 32).x *  1)),  (int(768 +  uint2(3, 3).y *  uint2(32, 32).y *  1 - 1) / int( uint2(3, 3).y *  uint2(32, 32).y *  1))).y;
}
#line 517
pass
{
VertexShader = PostProcessVS;
PixelShader = GaussianVarianceHPS;
RenderTarget = RegionVariancesH;
}
#line 524
pass
{
VertexShader = PostProcessVS;
PixelShader = GaussianVarianceVPS;
RenderTarget = RegionVariances;
}
#line 531
pass
{
VertexShader = PostProcessVS;
PixelShader = OutputPS;
}
}
}

