#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\dh_undither.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Reshade.fxh"
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
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\dh_undither.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DH.fxh"
#line 21
namespace DH
{
#line 25
float RGBCVtoHUE(in float3 RGB, in float C, in float V) {
float3 Delta = (V - RGB) / C;
Delta.rgb -= Delta.brg;
Delta.rgb += float3(2, 4, 6);
Delta.brg = step(V, RGB) * Delta.brg;
return max(Delta.r, max(Delta.g, Delta.b)) / 6;
}
#line 33
float3 RGBtoHSL(in float3 RGB) {
float3 HSL = 0;
const float U = -min(RGB.r, min(RGB.g, RGB.b));
const float V = max(RGB.r, max(RGB.g, RGB.b));
HSL.z = ((V - U) * 0.5);
const float C = V + U;
if (C != 0)
{
HSL.x = RGBCVtoHUE(RGB, C, V);
HSL.y = C / (1 - abs(2 * HSL.z - 1));
}
return HSL;
}
#line 47
float3 HUEtoRGB(in float H)
{
return saturate(float3(abs(H * 6 - 3) - 1, 2 - abs(H * 6 - 2), 2 - abs(H * 6 - 4)));
}
#line 52
float3 HSLtoRGB(in float3 HSL)
{
return (HUEtoRGB(HSL.x) - 0.5) * ((1 - abs(2 * HSL.z - 1)) * HSL.y) + HSL.z;
}
#line 60
float distance2(float2 p1, float2 p2) {
const float2 diff = p1 - p2;
return dot(diff, diff);
}
#line 65
float distance2(float3 p1, float3 p2) {
const float3 diff = p1 - p2;
return dot(diff, diff);
}
#line 72
float2 getPixelSize() {
return 1.0 /  int2( 792,  710);
}
#line 76
float3 getWorldPosition(float2 coords, float depth, int3 bufferSize) {
return float3((coords - 0.5) * depth, depth) * bufferSize;
}
#line 80
float3 getWorldPosition(float3 coords, int3 bufferSize) {
return getWorldPosition(coords.xy, coords.z, bufferSize);
}
#line 84
float3 getWorldPosition(float2 coords, float depth) {
return getWorldPosition(coords, depth, int3(792, 710, 1000.0));
}
#line 88
float3 getWorldPosition(float3 coords) {
return getWorldPosition(coords.xy, coords.z, int3(792, 710, 1000.0));
}
#line 92
float3 getWorldPosition(float2 coords, int3 bufferSize) {
return getWorldPosition(coords,  ReShade::GetLinearizedDepth(coords), bufferSize);
}
#line 96
float3 getWorldPosition(float2 coords) {
return getWorldPosition( ReShade::GetLinearizedDepth(coords),  ReShade::GetLinearizedDepth(coords));
}
#line 100
float2 getScreenPosition(float3 wp,int3 bufferSize) {
float3 result = wp / bufferSize;
result /= result.z;
return result.xy + 0.5;
}
#line 107
float3 computeNormal(float2 coords, int3 samplerSize)
{
const float3 offset = float3(ReShade:: GetPixelSize().xy, 0.0) / 10;
#line 111
const float3 posCenter = getWorldPosition(coords,samplerSize);
const float3 posNorth  = getWorldPosition(coords - offset.zy,samplerSize);
const float3 posEast   = getWorldPosition(coords + offset.xz,samplerSize);
return float3((coords - 0.5) / 6.0, 0.5) + normalize(cross(posCenter - posNorth, posCenter - posEast));
}
#line 117
void saveNormal(out float4 outNormal,float3 normal) {
outNormal = float4(normal / 2.0 + 0.5, 1.0);
}
#line 121
float3 loadNormal(sampler s, float2 coords) {
return (tex2Dlod(s, float4(coords, 0.0, 0.0)).xyz - 0.5) * 2.0;
}
}
#line 2 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\dh_undither.fx"
#line 4
namespace DH {
#line 8
uniform int iPS <
ui_label = "Pixel size";
ui_type = "slider";
ui_min = 1;
ui_max = 4;
ui_step = 1;
> = 1;
#line 16
uniform int iRadius <
ui_label = "Radius";
ui_type = "slider";
ui_min = 1;
ui_max = 10;
ui_step = 1;
> = 3;
#line 24
uniform bool bKeepHue <
ui_label = "Keep source hue";
> = false;
#line 28
uniform float fHueMaxDistance <
ui_label = "Hue Max Distance";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.01;
> = 0.2;
#line 36
uniform float fSatMaxDistance <
ui_label = "Sat Max Distance";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.01;
> = 0.35;
#line 44
uniform float fLumMaxDistance <
ui_label = "Lum Max Distance";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.01;
> = 0.20;
#line 58
float hueDistance(float3 hsl1, float3 hsl2) {
float minH;
float maxH;
if(hsl1.x == hsl2.x) {
return 0;
}
if(hsl1.x < hsl2.x) {
minH = hsl1.x;
maxH = hsl2.x;
}
else {
minH = hsl1.x;
maxH = hsl2.x;
}
#line 73
return 2 * min(maxH - minH, 1 + minH - maxH);
}
#line 79
void PS_undither(in float4 position : SV_Position, in float2 coords : TEXCOORD, out float4 outPixel : SV_Target)
{
const float3 hsl = RGBtoHSL( tex2Dlod(ReShade::BackBuffer, float4(coords, 0, 0)).rgb);
#line 83
const float maxDist = iRadius * iRadius;
const float2 pixelSize = getPixelSize() * iPS;
#line 86
const float2 minCoords = saturate(coords - iRadius * pixelSize);
const float2 maxCoords = saturate(coords + iRadius * pixelSize);
#line 89
float2 currentCoords;
#line 91
float3 sumRgb;
float sumWeight;
#line 94
for(currentCoords.x = minCoords.x; currentCoords.x <= maxCoords.x; currentCoords.x += pixelSize.x) {
for(currentCoords.y = minCoords.y; currentCoords.y <= maxCoords.y; currentCoords.y += pixelSize.y) {
int2 delta = (currentCoords - coords) / pixelSize;
float posDist = dot(delta, delta);
#line 99
if(posDist > maxDist) {
continue;
}
#line 104
float3 currentRgb =  tex2Dlod(ReShade::BackBuffer, float4(currentCoords, 0, 0)).xyz;
float3 currentHsl = RGBtoHSL(currentRgb);
#line 107
float satDist = abs(hsl.y - currentHsl.y);
if(satDist > fSatMaxDistance) {
continue;
}
#line 112
float lumDist = abs(hsl.z - currentHsl.z);
if(lumDist > fLumMaxDistance) {
continue;
}
#line 117
float hueDist = hueDistance(hsl, currentHsl);
if(hueDist > fHueMaxDistance) {
continue;
}
#line 122
float weight = (1 - hueDist) + (1 - satDist) + (1 - lumDist) + (1 + maxDist - posDist) / (maxDist + 1);
sumWeight += weight;
sumRgb += weight * currentRgb;
}
}
#line 128
float3 resultRgb = sumRgb / sumWeight;
if(bKeepHue) {
float3 resultHsl = RGBtoHSL(resultRgb);
resultHsl.x = hsl.x;
resultRgb = HSLtoRGB(resultHsl);
}
outPixel = float4(resultRgb, 1.0);
}
#line 140
technique DH_undither <
>
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_undither;
}
#line 149
}
}
