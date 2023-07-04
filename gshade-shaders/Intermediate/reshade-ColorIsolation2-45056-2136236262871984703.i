#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorIsolation2.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1798 * (1.0 / 997); }
float2 GetPixelSize() { return float2((1.0 / 1798), (1.0 / 997)); }
float2 GetScreenSize() { return float2(1798, 997); }
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
#line 40 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorIsolation2.fx"
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
#line 43 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorIsolation2.fx"
#line 49
uniform float fUITargetHueTwo <
ui_type = "slider";
ui_category =  "Setup";
ui_label = "Target Hue";
ui_tooltip = "Set the desired hue.\nEnable \"Show Debug Overlay\" for visualization.";
ui_min = 0.0; ui_max = 360.0; ui_step = 0.5;
> = 0.0;
#line 57
uniform int cUIWindowFunctionTwo <
ui_type = "combo";
ui_category =  "Setup";
ui_label = "Window Function";
ui_items = "Gauss\0Triangle\0";
> = 0;
#line 64
uniform float fUIOverlapTwo <
ui_type = "slider";
ui_category =  "Setup";
ui_label = "Hue Overlap";
ui_tooltip = "Changes the width of the curve\nto include less or more colors in relation\nto the target hue.\n";
ui_min = 0.001; ui_max = 2.0;
ui_step = 0.001;
> = 0.3;
#line 73
uniform float fUIWindowHeightTwo <
ui_type = "slider";
ui_category =  "Setup";
ui_label = "Curve Steepness";
ui_min = 0.0; ui_max = 10.0;
ui_step = 0.01;
> = 1.0;
#line 81
uniform int iUITypeTwo <
ui_type = "combo";
ui_category =  "Setup";
ui_label = "Isolate / Reject Hue";
ui_items = "Isolate\0Reject\0";
> = 0;
#line 88
uniform bool bUIShowDiffTwo <
ui_category =  "Debug";
ui_label = "Show Hue Difference";
> = false;
#line 93
uniform bool bUIShowDebugOverlayTwo <
ui_label = "Show Debug Overlay";
ui_category =  "Debug";
> = false;
#line 98
uniform float2 fUIOverlayPosTwo <
ui_type = "slider";
ui_category =  "Debug";
ui_label = "Overlay: Position";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.01;
> = float2(0.0, 0.0);
#line 106
uniform int2 iUIOverlaySizeTwo <
ui_type = "slider";
ui_category =  "Debug";
ui_label = "Overlay: Size";
ui_tooltip = "x: width\nz: height";
ui_min = 50; ui_max = 1798;
ui_step = 1;
> = int2(600, 100);
#line 115
uniform float fUIOverlayOpacityTwo <
ui_type = "slider";
ui_category =  "Debug";
ui_label = "Overlay Opacity";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.01;
> = 1.0;
#line 125
float3 RGBtoHSVTwo(float3 c) {
const float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
#line 128
float4 p;
if (c.g < c.b)
p = float4(c.bg, K.wz);
else
p = float4(c.gb, K.xy);
#line 134
float4 q;
if (c.r < p.x)
q = float4(p.xyw, c.r);
else
q = float4(c.r, p.yzx);
#line 140
const float d = q.x - min(q.w, q.y);
const float e = 1.0e-10;
return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
#line 145
float3 HSVtoRGBTwo(float3 c) {
const float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
const float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
}
#line 151
float MapTwo(float value, float2 span_old, float2 span_new) {
float span_old_diff;
if (abs(span_old.y - span_old.x) < 1e-6)
span_old_diff = 1e-6;
else
span_old_diff = span_old.y - span_old.x;
return lerp(span_new.x, span_new.y, (clamp(value, span_old.x, span_old.y)-span_old.x)/(span_old_diff));
}
#line 163
float CalculateValueTwo(float x, float height, float offset, float overlap) {
float retVal;
#line 167
if(cUIWindowFunctionTwo == 0) {
#line 169
overlap /= 5.0;
retVal = saturate( (height * exp(-((x-1.0 - offset) * (x-1.0 - offset)) / (2 * overlap * overlap))) +  (height * exp(-((x - offset) * (x - offset)) / (2 * overlap * overlap))) +  (height * exp(-((x+1.0 - offset) * (x+1.0 - offset)) / (2 * overlap * overlap))));
}
else {
retVal = saturate( saturate(height * ((2 / overlap) * ((overlap / 2) - abs(x-1.0 - offset)))) +  saturate(height * ((2 / overlap) * ((overlap / 2) - abs(x - offset)))) +  saturate(height * ((2 / overlap) * ((overlap / 2) - abs(x+1.0 - offset)))));
}
#line 176
if(iUITypeTwo == 1)
return 1.0 - retVal;
#line 179
return retVal;
}
#line 182
float3 DrawDebugOverlayTwo(float3 background, float3 param, float2 pos, int2 size, float opacity, int2 vpos, float2 texcoord) {
float x, y, value, luma;
float3 overlay, hsvStrip;
#line 186
const float2 overlayPos = pos * ( float2(1798, 997) - size);
#line 188
if(all(vpos.xy >= overlayPos) && all(vpos.xy < overlayPos + size))
{
x = MapTwo(texcoord.x, float2(overlayPos.x, overlayPos.x + size.x) / 1798, float2(0.0, 1.0));
y = MapTwo(texcoord.y, float2(overlayPos.y, overlayPos.y + size.y) / 997, float2(0.0, 1.0));
hsvStrip = HSVtoRGBTwo(float3(x, 1.0, 1.0));
luma = dot(hsvStrip, float3(0.2126, 0.7151, 0.0721));
value = CalculateValueTwo(x, param.z, param.x, 1.0 - param.y);
overlay = lerp(luma.rrr, hsvStrip, value);
overlay = lerp(overlay, 0.0.rrr, exp(-size.y * length(float2(x, 1.0 - y) - float2(x, value))));
background = lerp(background, overlay, opacity);
}
#line 200
return background;
}
#line 203
float3 ColorIsolationTwoPS(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target {
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
const float3 luma = dot(color, float3(0.2126, 0.7151, 0.0721)).rrr;
const float3 param = float3(fUITargetHueTwo / 360.0, fUIOverlapTwo, fUIWindowHeightTwo);
const float value = CalculateValueTwo(RGBtoHSVTwo(color).x, param.z, param.x, 1.0 - param.y);
float3 retVal = lerp(luma, color, value);
#line 210
if(bUIShowDiffTwo)
retVal = value.rrr;
#line 213
if(bUIShowDebugOverlayTwo)
{
retVal = DrawDebugOverlayTwo(retVal, param, fUIOverlayPosTwo, iUIOverlaySizeTwo, fUIOverlayOpacityTwo, vpos.xy, texcoord);
}
#line 219
return retVal + TriDither(retVal, texcoord, 8);
#line 223
}
#line 225
technique ColorIsolation2 {
pass {
VertexShader = PostProcessVS;
PixelShader = ColorIsolationTwoPS;
#line 230
}
}
