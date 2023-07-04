#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicAnamorphSharpen.fx"
#line 17
uniform float Strength <
ui_label = "Strength";
ui_category = "Settings";
ui_type = "slider";
ui_min = 0.0; ui_max = 100.0; ui_step = 0.01;
> = 60.0;
#line 24
uniform float Offset <
ui_label = "Radius";
ui_type = "slider";
ui_tooltip = "High-pass cross offset in pixels";
ui_category = "Settings";
ui_min = 0.0; ui_max = 2.0; ui_step = 0.01;
> = 0.1;
#line 33
uniform float Clamp <
ui_label = "Clamping";
ui_category = "Settings";
ui_type = "slider";
ui_min = 0.5; ui_max = 1.0; ui_step = 0.001;
> = 0.65;
#line 40
uniform bool UseMask <
ui_label = "Sharpen only center";
ui_category = "Settings";
ui_tooltip = "Sharpen only in center of the image";
> = false;
#line 46
uniform bool DepthMask <
ui_label = "Enable depth rim masking";
ui_tooltip = "Depth high-pass mask switch";
ui_category = "Depth mask";
ui_category_closed = true;
> = true;
#line 53
uniform int DepthMaskContrast <
ui_label = "Edges mask strength";
ui_tooltip = "Depth high-pass mask amount";
ui_category = "Depth mask";
ui_type = "slider";
ui_min = 0; ui_max = 2000; ui_step = 1;
> = 128;
#line 61
uniform int Coefficient <
ui_tooltip = "For digital video signal use BT.709, for analog (like VGA) use BT.601";
ui_label = "YUV coefficients";
ui_type = "radio";
ui_items = "BT.709 - digital\0BT.601 - analog\0";
ui_category = "Additional settings";
ui_category_closed = true;
> = 0;
#line 70
uniform bool Preview <
ui_label = "Preview sharpen layer";
ui_tooltip = "Preview sharpen layer and mask for adjustment.\n"
"If you don't see red strokes,\n"
"try changing Preprocessor Definitions in the Settings tab.";
ui_category = "Debug View";
ui_category_closed = true;
> = false;
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
#line 83 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicAnamorphSharpen.fx"
#line 86
sampler BackBuffer
{
Texture = ReShade::BackBufferTex;
AddressU = MIRROR;
AddressV = MIRROR;
#line 92
SRGBTexture = true;
#line 94
};
#line 101
static const float3 Luma709 = float3(0.2126, 0.7152, 0.0722);
#line 103
static const float3 Luma601 = float3(0.299, 0.587, 0.114);
#line 106
float Overlay(float LayerA, float LayerB)
{
const float MinA = min(LayerA, 0.5);
const float MinB = min(LayerB, 0.5);
const float MaxA = max(LayerA, 0.5);
const float MaxB = max(LayerB, 0.5);
return 2.0 * (MinA * MinB + MaxA + MaxB - MaxA * MaxB) - 1.5;
}
#line 116
float Overlay(float LayerAB)
{
const float MinAB = min(LayerAB, 0.5);
const float MaxAB = max(LayerAB, 0.5);
return 2.0 * (MinAB * MinAB + MaxAB + MaxAB - MaxAB * MaxAB) - 1.5;
}
#line 124
float gamma(float grad) { return pow(abs(grad), 2.2); }
float3 gamma(float3 grad) { return pow(abs(grad), 2.2); }
#line 132
float3 FilmicAnamorphSharpenPS(float4 pos : SV_Position, float2 UvCoord : TEXCOORD) : SV_Target
{
#line 135
float3 Source = tex2D(BackBuffer, UvCoord).rgb;
#line 138
float Mask;
if (UseMask)
{
#line 142
Mask = 1.0-length(UvCoord*2.0-1.0);
Mask = Overlay(Mask) * Strength;
#line 145
if (Mask <= 0) return Source;
}
else Mask = Strength;
#line 150
float2 Pixel =  float2((1.0 / 1281), (1.0 / 721));
#line 152
float3 LumaCoefficient;
if (bool(Coefficient))
LumaCoefficient = Luma601;
else
LumaCoefficient = Luma709;
#line 158
if (DepthMask)
{
#line 167
const float2 PixelOffset = Pixel * Offset;
const float2 DepthPixel = PixelOffset + Pixel;
Pixel = PixelOffset;
#line 172
const float SourceDepth = ReShade::GetLinearizedDepth(UvCoord);
#line 174
const float2 NorSouWesEst[4] = {
float2(UvCoord.x, UvCoord.y + Pixel.y),
float2(UvCoord.x, UvCoord.y - Pixel.y),
float2(UvCoord.x + Pixel.x, UvCoord.y),
float2(UvCoord.x - Pixel.x, UvCoord.y)
};
#line 181
const float2 DepthNorSouWesEst[4] = {
float2(UvCoord.x, UvCoord.y + DepthPixel.y),
float2(UvCoord.x, UvCoord.y - DepthPixel.y),
float2(UvCoord.x + DepthPixel.x, UvCoord.y),
float2(UvCoord.x - DepthPixel.x, UvCoord.y)
};
#line 190
float HighPassColor = 0.0, DepthMask = 0.0;
#line 192
[unroll]for(int s = 0; s < 4; s++)
{
HighPassColor += dot(tex2D(BackBuffer, NorSouWesEst[s]).rgb, LumaCoefficient);
DepthMask += ReShade::GetLinearizedDepth(NorSouWesEst[s])
+ ReShade::GetLinearizedDepth(DepthNorSouWesEst[s]);
}
#line 199
HighPassColor = 0.5 - 0.5 * (HighPassColor * 0.25 - dot(Source, LumaCoefficient));
#line 201
DepthMask = 1.0 - DepthMask * 0.125 + SourceDepth;
DepthMask = min(1.0, DepthMask) + 1.0 - max(1.0, DepthMask);
DepthMask = saturate(DepthMaskContrast * DepthMask + 1.0 - DepthMaskContrast);
#line 206
HighPassColor = lerp(0.5, HighPassColor, Mask * DepthMask);
#line 220
if (Clamp != 1.0)
HighPassColor = clamp(HighPassColor, 1.0 - Clamp, Clamp);
#line 223
const float3 Sharpen = float3(
Overlay(Source.r, HighPassColor),
Overlay(Source.g, HighPassColor),
Overlay(Source.b, HighPassColor)
);
#line 229
if(Preview) 
{
const float PreviewChannel = lerp(HighPassColor, HighPassColor * DepthMask, 0.5);
return gamma(float3(
1.0 - DepthMask * (1.0 - HighPassColor),
PreviewChannel,
PreviewChannel
));
}
#line 239
return Sharpen;
}
else
{
Pixel *= Offset;
#line 245
const float2 NorSouWesEst[4] = {
float2(UvCoord.x, UvCoord.y + Pixel.y),
float2(UvCoord.x, UvCoord.y - Pixel.y),
float2(UvCoord.x + Pixel.x, UvCoord.y),
float2(UvCoord.x - Pixel.x, UvCoord.y)
};
#line 253
float HighPassColor = 0.0;
[unroll]
for(int s = 0; s < 4; s++)
HighPassColor += dot(tex2D(BackBuffer, NorSouWesEst[s]).rgb, LumaCoefficient);
#line 261
HighPassColor = 0.5 - 0.5 * (HighPassColor * 0.25 - dot(Source, LumaCoefficient));
#line 264
HighPassColor = lerp(0.5, HighPassColor, Mask);
#line 278
if (Clamp != 1.0)
HighPassColor = clamp( HighPassColor, 1.0 - Clamp, Clamp );
#line 282
if (Preview)
return gamma(HighPassColor);
else
return float3(
Overlay(Source.r, HighPassColor),
Overlay(Source.g, HighPassColor),
Overlay(Source.b, HighPassColor)
);
}
}
#line 298
technique FilmicAnamorphSharpen < ui_label = "Filmic Anamorphic Sharpen"; >
{
pass
{
VertexShader = PostProcessVS;
PixelShader = FilmicAnamorphSharpenPS;
SRGBWriteEnable = true;
}
}

