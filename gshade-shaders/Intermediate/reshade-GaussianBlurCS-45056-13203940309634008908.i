#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\ComputeShaders\GaussianBlurCS.fx"
#line 53
texture BackBuffer : COLOR;
texture PlaceHolder {Width = 792; Height = 710; Format = RGB10A2;};
texture Convolution {Width = 792; Height = 710; Format = RGB10A2;};
#line 57
sampler sBackBuffer {Texture = BackBuffer;};
sampler sPlaceHolder {Texture = PlaceHolder;};
sampler sConvolution {Texture = Convolution;};
#line 61
storage wPlaceHolder {Texture = PlaceHolder;};
storage wConvolution {Texture = Convolution;};
#line 64
uniform float Strength<
ui_type = "slider";
ui_label = "Strength";
ui_tooltip = "Use negative strength values to apply an unsharp mask to the image.";
ui_category = "General";
ui_min = -1; ui_max = 1;
ui_step = 0.001;
> = 1;
#line 79
static const float KERNEL[ ( 33 / 2) + 1] = {0.001924, 0.002957, 0.004419, 0.006424, 0.009084, 0.012493, 0.016713, 0.021747, 0.027524, 0.033882, 0.04057,
0.04725, 0.053526, 0.058978, 0.063209, 0.065892, 0.066812};
#line 93
uint ArrayIndex(const uint2 accessCoord, const uint2 arrayDimensions)
{
return (arrayDimensions.x * accessCoord.y) + accessCoord.x;
}
#line 99
uint Float3ToUint(float3 fValue)
{
fValue = saturate(fValue);
uint uValue = 0;
uValue = uint(fValue[0] * 1023);
uValue = uint(fValue[1] * 1023) | (uValue << 10);
uValue = uint(fValue[2] * 1023) | (uValue << 10);
return uValue;
}
#line 109
float3 UintToFloat3(uint uValue)
{
float3 fValue;
fValue[0] = float(uValue >> 20) / 1023;
fValue[1] = float((uValue & 0x000FFC00) >> 10) / 1023;
fValue[2] = float((uValue & 0x000003FF)) / 1023;
return fValue;
}
#line 118
groupshared uint samples[ int2( 32 *  4 + ( ( 33 / 2) * 2),  2).x* int2( 32 *  4 + ( ( 33 / 2) * 2),  2).y];
#line 122
void KernelIteration(uint iteration, float3 currentSamples[ 4], inout float3 kernelOutput[ 4])
{
[unroll]
for(int i = 0; i <  4; i++)
{
kernelOutput[i] += KERNEL[iteration] * currentSamples[i];
}
}
#line 132
void UpdateCurrentSamples(int2 indexCoords, inout float3 currentSamples[ 4])
{
[unroll]
for(int i = 0; i <  4 - 1; i++)
{
currentSamples[i] = currentSamples[i + 1];
}
currentSamples[ 4 - 1] = UintToFloat3(samples[ArrayIndex(indexCoords,  int2( 32 *  4 + ( ( 33 / 2) * 2),  2))]);
}
#line 142
void HorizontalPassCS(uint3 gid : SV_GroupID, uint3 gtid : SV_GroupThreadID)
{
float3 kernelOutput[ 4];
float3 currentSamples[ 4];
int2 indexCoords;
indexCoords.x = (gtid.x *  4);
indexCoords.y = gtid.y;
int2 sampleOffset = indexCoords;
sampleOffset.x -=  ( 33 / 2) -  4;
int2 groupCoord = int2(gid.x *  4 *  32, gid.y *  2);
#line 153
[unroll]
for(int i = 0; i <  4; i++)
{
uint arrayIndex = ArrayIndex(int2(indexCoords.x + i, indexCoords.y),  int2( 32 *  4 + ( ( 33 / 2) * 2),  2));
int2 sampleCoord = sampleOffset + groupCoord;
sampleCoord.x += i;
sampleCoord = clamp(sampleCoord, 0, float2(792, 710));
currentSamples[i] = tex2Dfetch(sBackBuffer, sampleCoord).rgb;
samples[arrayIndex] = Float3ToUint(currentSamples[i]);
}
#line 164
indexCoords.x =  4 *  32 + gtid.x;
#line 168
[unroll]
while(indexCoords.x <  int2( 32 *  4 + ( ( 33 / 2) * 2),  2).x)
{
sampleOffset.x = indexCoords.x -  ( 33 / 2) +  4;
int2 sampleCoord = sampleOffset + groupCoord;
sampleCoord = clamp(sampleCoord, 0, float2(792, 710));
uint arrayIndex = ArrayIndex(indexCoords,  int2( 32 *  4 + ( ( 33 / 2) * 2),  2));
samples[arrayIndex] = Float3ToUint(tex2Dfetch(sBackBuffer, sampleCoord).rgb);
indexCoords.x +=  32;
}
#line 179
barrier();
#line 182
indexCoords.x = (gtid.x *  4);
#line 185
[unroll]
for(int i = 0; i <=  ( 33 / 2); i++)
{
KernelIteration(i, currentSamples, kernelOutput);
UpdateCurrentSamples(indexCoords, currentSamples);
indexCoords.x++;
}
#line 194
[unroll]
for(int i =  ( 33 / 2) - 1; i >= 0; i--)
{
KernelIteration(i, currentSamples, kernelOutput);
UpdateCurrentSamples(indexCoords, currentSamples);
indexCoords.x++;
}
indexCoords.x = (gtid.x *  4);
int2 coord = indexCoords + groupCoord;
#line 205
[unroll]
for(int i = 0; i <  4; i++)
{
tex2Dstore(wPlaceHolder, coord, float4(kernelOutput[i], 1));
coord.x++;
}
}
#line 213
void VerticalPassCS(uint3 gid : SV_GroupID, uint3 gtid : SV_GroupThreadID)
{
float3 kernelOutput[ 4];
float3 currentSamples[ 4];
int2 indexCoords;
indexCoords.x = (gtid.x *  4);
indexCoords.y = gtid.y;
int2 sampleOffset = indexCoords;
sampleOffset.x -=  ( 33 / 2) -  4;
int2 groupCoord = int2(gid.x *  4 *  32, gid.y *  2);
#line 225
[unroll]
for(int i = 0; i <  4; i++)
{
uint arrayIndex = ArrayIndex(int2(indexCoords.x + i, indexCoords.y),  int2( 32 *  4 + ( ( 33 / 2) * 2),  2));
int2 sampleCoord = sampleOffset + groupCoord;
sampleCoord.x += i;
sampleCoord = clamp(sampleCoord, 0, float2(710, 792));
currentSamples[i] = tex2Dfetch(sPlaceHolder, sampleCoord.yx).rgb;
samples[arrayIndex] = Float3ToUint(currentSamples[i]);
}
#line 236
indexCoords.x =  4 *  32 + gtid.x;
#line 240
[unroll]
while(indexCoords.x <  int2( 32 *  4 + ( ( 33 / 2) * 2),  2).x)
{
sampleOffset.x = indexCoords.x -  ( 33 / 2) +  4;
int2 sampleCoord = sampleOffset + groupCoord;
sampleCoord = clamp(sampleCoord, 0, float2(710, 792));
uint arrayIndex = ArrayIndex(indexCoords,  int2( 32 *  4 + ( ( 33 / 2) * 2),  2));
samples[arrayIndex] = Float3ToUint(tex2Dfetch(sPlaceHolder, sampleCoord.yx).rgb);
indexCoords.x +=  32;
}
#line 251
barrier();
#line 254
indexCoords.x = (gtid.x *  4);
#line 257
[unroll]
for(int i = 0; i <=  ( 33 / 2); i++)
{
KernelIteration(i, currentSamples, kernelOutput);
UpdateCurrentSamples(indexCoords, currentSamples);
indexCoords.x++;
}
#line 266
[unroll]
for(int i =  ( 33 / 2) - 1; i >= 0; i--)
{
KernelIteration(i, currentSamples, kernelOutput);
UpdateCurrentSamples(indexCoords, currentSamples);
indexCoords.x++;
}
#line 274
indexCoords.x = (gtid.x *  4);
int2 coord = indexCoords + groupCoord;
#line 277
[unroll]
for(int i = 0; i <  4; i++)
{
tex2Dstore(wConvolution, coord.yx, float4(kernelOutput[i], 1));
coord.x++;
}
}
#line 286
void PostProcessVS(in uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD)
{
texcoord.x = (id == 2) ? 2.0 : 0.0;
texcoord.y = (id == 1) ? 2.0 : 0.0;
position = float4(texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 293
void OutputPS(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float4 color : SV_Target0)
{
color = tex2D(sConvolution, texcoord);
if(Strength < 1)
{
color = lerp(tex2D(sBackBuffer, texcoord), color, Strength);
#line 300
}
}
#line 303
technique GaussianBlurCS < ui_tooltip = "Use negative strength values to apply an unsharp mask to the image. \n\n"
"The following are your options for the CS_GAUSSIAN_BLUR_SIZE definition: \n"
"0 corresponds to a kernel size of 23\n"
"1 corresponds to a kernel size of 33\n"
"2 corresponds to a kernel size of 65\n";>
{
pass
{
ComputeShader = HorizontalPassCS< 32,  2>;
DispatchSizeX =  (int(792 +  32 *  4 - 1) / int( 32 *  4));
DispatchSizeY =  (int(710 +  2 - 1) / int( 2));
}
pass
{
ComputeShader = VerticalPassCS< 32,  2>;
DispatchSizeX =  (int(710 +  32 *  4 - 1) / int( 32 *  4));
DispatchSizeY =  (int(792 +  2 - 1) / int( 2));
}
pass
{
VertexShader = PostProcessVS;
PixelShader = OutputPS;
}
}

