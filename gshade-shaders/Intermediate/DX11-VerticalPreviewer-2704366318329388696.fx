#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VerticalPreviewer.fx"
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
#line 23 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VerticalPreviewer.fx"
#line 30
uniform int cLayerVPre_Angle <
ui_type = "combo";
ui_label = "Vertical Preview";
ui_tooltip = "-90 Degrees - Rotate Left.\n"
" 90 Degrees - Rotate Right.   \n";
ui_items =
"-90 Degree\0"
"  0 Degree\0"
" 90 Degree\0"
"180 Degree\0"
"Disable Vertical Preview\0";
> = 2;
#line 43
uniform float cLayerVPre_Scale <
ui_type = "slider";
ui_label = "Scale";
ui_tooltip = "0.75 will vertically fit \n"
"in 16:9(FHD) ratio.        ";
ui_min = 0.50; ui_max = 1.00;
ui_step = 0.001;
> = 0.750;
#line 52
uniform float cLayerVPre_PosX <
ui_type = "slider";
ui_label = "Position X";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.500;
#line 59
uniform float cLayerVPre_PosY <
ui_type = "slider";
ui_label = "Position Y";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.500;
#line 66
uniform int cLayerVPre_Composition <
ui_type = "combo";
ui_spacing = 1;
ui_label = "Composition Line";
ui_tooltip = " By positioning subjects/objects\n"
"     in the center of square\n    "
"           or                   \n"
"aligning to lines or cross point,\n"
" your screen may more balanced.";
ui_items =
"OFF\0"
"Center Lines\0"
"Thirds\0"
"Fourth\0"
"Fifths\0"
"Golden Ratio\0"
"Silver Ratio\0"
"Diagonals One\0"
"Diagonals Two\0"
"Golden Section Grid\0"
"OneHalf Section Grid\0"
"Harmonic Armature\0"
"Railman Ratio\0";
> = 2;
#line 91
uniform float4 UIGridColor <
ui_type = "color";
ui_label = "Grid Color";
> = float4(1.0, 1.0, 1.0, 0.5);
#line 96
uniform float UIGridLineWidth <
ui_type = "slider";
ui_label = "Grid Line Width";
ui_min = 0.0; ui_max = 5.0;
ui_steps = 0.01;
> = 2.0;
#line 103
uniform float cLayer_Blend_BGFill <
ui_type = "slider";
ui_spacing = 1;
ui_label = "Background FIll";
ui_tooltip = "-0.5 is filled with black,\n"
"+0.5 is white.               ";
ui_min = -0.5; ui_max = 0.5;
ui_step = 0.001;
> = 0.00;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 117 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VerticalPreviewer.fx"
#line 119
texture texVoid <
source = "UIMask.png";
> {
Width = 3440;
Height = 1440;
Format = RGBA8;
};
texture texDraw { Width = 3440; Height = 1440; };
texture texVPreOut { Width = 3440; Height = 1440; };
#line 129
sampler samplerVoid { Texture = texVoid; };
sampler samplerDraw { Texture = texDraw; };
sampler samplerVPreOut { Texture = texVPreOut; };
#line 133
struct sctpoint {
float3 color;
float2 coord;
float2 offset;
};
#line 139
sctpoint NewPoint(float3 color, float2 offset, float2 coord) {
sctpoint p;
p.color = color;
p.offset = offset;
p.coord = coord;
return p;
}
#line 147
float3 DrawPoint(float3 texcolor, sctpoint p, float2 texCoord) {
float2 pixelsize =  float2((1.0 / 3440), (1.0 / 1440)) * p.offset;
#line 150
if(p.coord.x == -1 || p.coord.y == -1)
return texcolor;
#line 153
if(texCoord.x <= p.coord.x + pixelsize.x &&
texCoord.x >= p.coord.x - pixelsize.x &&
texCoord.y <= p.coord.y + pixelsize.y &&
texCoord.y >= p.coord.y - pixelsize.y)
return p.color;
return texcolor;
}
#line 161
float3 DrawCenterLines(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 164
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(0.5, texCoord.y));
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 0.5));
#line 167
result = DrawPoint(background, lineV1, texCoord);
result = DrawPoint(result, lineH1, texCoord);
#line 170
return result;
}
#line 173
float3 DrawThirds(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 176
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 / 3.0, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(2.0 / 3.0, texCoord.y));
#line 179
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 / 3.0));
sctpoint lineH2 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 2.0 / 3.0));
#line 182
result = DrawPoint(background, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineH1, texCoord);
result = DrawPoint(result, lineH2, texCoord);
#line 187
return result;
}
#line 190
float3 DrawFourth(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 193
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 / 4.0, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(2.0 / 4.0, texCoord.y));
sctpoint lineV3 = NewPoint(gridColor, lineWidth, float2(3.0 / 4.0, texCoord.y));
#line 197
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 / 4.0));
sctpoint lineH2 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 2.0 / 4.0));
sctpoint lineH3 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 3.0 / 4.0));
#line 201
result = DrawPoint(background, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineV3, texCoord);
result = DrawPoint(result, lineH1, texCoord);
result = DrawPoint(result, lineH2, texCoord);
result = DrawPoint(result, lineH3, texCoord);
#line 208
return result;
}
#line 211
float3 DrawFifths(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 214
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 / 5.0, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(2.0 / 5.0, texCoord.y));
sctpoint lineV3 = NewPoint(gridColor, lineWidth, float2(3.0 / 5.0, texCoord.y));
sctpoint lineV4 = NewPoint(gridColor, lineWidth, float2(4.0 / 5.0, texCoord.y));
#line 219
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 / 5.0));
sctpoint lineH2 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 2.0 / 5.0));
sctpoint lineH3 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 3.0 / 5.0));
sctpoint lineH4 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 4.0 / 5.0));
#line 224
result = DrawPoint(background, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineV3, texCoord);
result = DrawPoint(result, lineV4, texCoord);
result = DrawPoint(result, lineH1, texCoord);
result = DrawPoint(result, lineH2, texCoord);
result = DrawPoint(result, lineH3, texCoord);
result = DrawPoint(result, lineH4, texCoord);
#line 233
return result;
}
#line 236
float3 DrawGoldenRatio(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 239
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 /  1.6180339887, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(1.0 - 1.0 /  1.6180339887, texCoord.y));
#line 242
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 /  1.6180339887));
sctpoint lineH2 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 - 1.0 /  1.6180339887));
#line 245
result = DrawPoint(background, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineH1, texCoord);
result = DrawPoint(result, lineH2, texCoord);
#line 250
return result;
}
#line 253
float3 DrawSilverRatio(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 256
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 /  1.4142135623, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(1.0 - 1.0 /  1.4142135623, texCoord.y));
#line 259
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 /  1.4142135623));
sctpoint lineH2 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 - 1.0 /  1.4142135623));
#line 262
result = DrawPoint(background, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineH1, texCoord);
result = DrawPoint(result, lineH2, texCoord);
#line 267
return result;
}
#line 270
float3 DrawDiagonalsOne(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 273
sctpoint line1 = NewPoint(gridColor, lineWidth + 1.0, float2(texCoord.x, texCoord.x));
sctpoint line2 = NewPoint(gridColor, lineWidth + 1.0, float2(texCoord.x, 1.0 - texCoord.x));
#line 276
result = DrawPoint(background, line1, texCoord);
result = DrawPoint(result, line2, texCoord);
#line 279
return result;
}
#line 282
float3 DrawDiagonalsTwo(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 285
float slope = 1.50;
#line 287
sctpoint line1 = NewPoint(gridColor, lineWidth + 1.0, float2(texCoord.x, texCoord.x * slope));
sctpoint line2 = NewPoint(gridColor, lineWidth + 1.0, float2(texCoord.x, 1.0 - texCoord.x * slope));
sctpoint line3 = NewPoint(gridColor, lineWidth + 1.0, float2(texCoord.x, (1.0 - texCoord.x) * slope));
sctpoint line4 = NewPoint(gridColor, lineWidth + 1.0, float2(texCoord.x, texCoord.x * slope + 1.0 - slope));
#line 292
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 / 3.0, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(2.0 / 3.0, texCoord.y));
#line 295
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 / 3.0));
sctpoint lineH2 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 2.0 / 3.0));
#line 298
result = DrawPoint(background, line1, texCoord);
result = DrawPoint(result, line2, texCoord);
result = DrawPoint(result, line3, texCoord);
result = DrawPoint(result, line4, texCoord);
result = DrawPoint(result, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineH1, texCoord);
result = DrawPoint(result, lineH2, texCoord);
#line 307
return result;
}
#line 310
float3 DrawGoldenSection(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 313
sctpoint line1 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, texCoord.x));
sctpoint line2 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x,1.0 - texCoord.x));
#line 316
float slope = pow( 1.6180339887, 2);
#line 318
sctpoint line3 = NewPoint(gridColor, lineWidth + 2.0, float2(texCoord.x, texCoord.x * slope));
sctpoint line4 = NewPoint(gridColor, lineWidth + 2.0, float2(texCoord.x, 1.0 - texCoord.x * slope));
#line 321
sctpoint line5 = NewPoint(gridColor, lineWidth + 2.0, float2(texCoord.x, (1.0 - texCoord.x) * slope));
sctpoint line6 = NewPoint(gridColor, lineWidth + 2.0, float2(texCoord.x, texCoord.x * slope + 1.0 - slope));
#line 324
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 /  1.6180339887, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(1.0 - 1.0 /  1.6180339887, texCoord.y));
#line 327
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 /  1.6180339887));
sctpoint lineH2 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 - 1.0 /  1.6180339887));
#line 330
result = DrawPoint(background, line1, texCoord);
result = DrawPoint(result, line2, texCoord);
result = DrawPoint(result, line3, texCoord);
result = DrawPoint(result, line4, texCoord);
result = DrawPoint(result, line5, texCoord);
result = DrawPoint(result, line6, texCoord);
result = DrawPoint(result, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineH1, texCoord);
result = DrawPoint(result, lineH2, texCoord);
#line 341
return result;
}
#line 344
float3 DrawOneHalfRectangle(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 347
sctpoint line1 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, texCoord.x));
sctpoint line2 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, 1.0 - texCoord.x));
#line 350
float slope = pow(1.5, 2);
#line 352
sctpoint line3 = NewPoint(gridColor, lineWidth + 2.0, float2(texCoord.x, texCoord.x * slope));
sctpoint line4 = NewPoint(gridColor, lineWidth + 2.0, float2(texCoord.x, 1.0 - texCoord.x * slope));
#line 355
sctpoint line5 = NewPoint(gridColor, lineWidth + 2.0, float2(texCoord.x, (1.0 - texCoord.x) * slope));
sctpoint line6 = NewPoint(gridColor, lineWidth + 2.0, float2(texCoord.x, texCoord.x * slope + 1.0 - slope));
#line 358
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 / 1.8, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(1.0 - 1.0 / 1.8, texCoord.y));
#line 361
sctpoint lineH1 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 / 1.8));
sctpoint lineH2 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 - 1.0 /1.8));
#line 364
result = DrawPoint(background, line1, texCoord);
result = DrawPoint(result, line2, texCoord);
result = DrawPoint(result, line3, texCoord);
result = DrawPoint(result, line4, texCoord);
result = DrawPoint(result, line5, texCoord);
result = DrawPoint(result, line6, texCoord);
result = DrawPoint(result, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineH1, texCoord);
result = DrawPoint(result, lineH2, texCoord);
#line 375
return result;
}
#line 378
float3 DrawHarmonicArmature(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 381
sctpoint line1 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, texCoord.x));
sctpoint line2 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x,1.0 - texCoord.x));
#line 384
float slope1 = 0.5;
#line 386
sctpoint line3 = NewPoint(gridColor, lineWidth, float2(texCoord.x, texCoord.x * slope1));
sctpoint line4 = NewPoint(gridColor, lineWidth, float2(texCoord.x, 1.0 - texCoord.x * slope1));
#line 389
sctpoint line5 = NewPoint(gridColor, lineWidth, float2(texCoord.x, (1.0 - texCoord.x) * slope1));
sctpoint line6 = NewPoint(gridColor, lineWidth, float2(texCoord.x, texCoord.x * slope1 + 1.0 - slope1));
#line 392
float slope2 = 1.5;
#line 394
sctpoint line7 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, texCoord.x * slope2));
sctpoint line8 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, 1.0 - texCoord.x * slope2));
#line 397
sctpoint line9 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, (1.0 - texCoord.x) * slope2));
sctpoint line10 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, texCoord.x * slope2 + 1.0 - slope2));
#line 400
result = DrawPoint(background, line1, texCoord);
result = DrawPoint(result, line2, texCoord);
result = DrawPoint(result, line3, texCoord);
result = DrawPoint(result, line4, texCoord);
result = DrawPoint(result, line5, texCoord);
result = DrawPoint(result, line6, texCoord);
result = DrawPoint(result, line7, texCoord);
result = DrawPoint(result, line8, texCoord);
result = DrawPoint(result, line9, texCoord);
result = DrawPoint(result, line10, texCoord);
#line 411
return result;
}
#line 414
float3 DrawRailmanRatio(float3 background, float3 gridColor, float lineWidth, float2 texCoord) {
float3 result;
#line 417
sctpoint line1 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, texCoord.x));
sctpoint line2 = NewPoint(gridColor, lineWidth + 0.6, float2(texCoord.x, 1.0 - texCoord.x));
#line 420
sctpoint lineV1 = NewPoint(gridColor, lineWidth, float2(1.0 / 4.0, texCoord.y));
sctpoint lineV2 = NewPoint(gridColor, lineWidth, float2(2.0 / 4.0, texCoord.y));
sctpoint lineV3 = NewPoint(gridColor, lineWidth, float2(3.0 / 4.0, texCoord.y));
#line 424
result = DrawPoint(background, line1, texCoord);
result = DrawPoint(result, line2, texCoord);
result = DrawPoint(result, lineV1, texCoord);
result = DrawPoint(result, lineV2, texCoord);
result = DrawPoint(result, lineV3, texCoord);
#line 430
return result;
}
#line 433
void PS_DrawLine(in float4 pos : SV_Position, float2 texCoord : TEXCOORD, out float4 passColor : SV_Target) {
const float4 backColor = tex2D(ReShade::BackBuffer, texCoord);
switch(cLayerVPre_Composition)
{
default:
passColor = float4(backColor.rgb, backColor.a);
break;
case 1:
const float3 VPreCenter = DrawCenterLines(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreCenter.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 2:
const float3 VPreThirds = DrawThirds(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreThirds.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 3:
const float3 VPreFourth = DrawFourth(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreFourth.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 4:
const float3 VPreFifths = DrawFifths(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreFifths.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 5:
const float3 VPreGolden = DrawGoldenRatio(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreGolden.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 6:
const float3 VPreSilver = DrawSilverRatio(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreSilver.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 7:
const float3 VPreDiagonalsOne = DrawDiagonalsOne(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreDiagonalsOne.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 8:
const float3 VPreDiagonalsTwo = DrawDiagonalsTwo(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreDiagonalsTwo.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 9:
const float3 VPreGoldenSection = DrawGoldenSection(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreGoldenSection.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 10:
const float3 VPreOneHalfRectangle = DrawOneHalfRectangle(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreOneHalfRectangle.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 11:
const float3 VPreHarmonicArmature = DrawHarmonicArmature(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreHarmonicArmature.rgb, UIGridColor.w).rgb, backColor.a);
break;
case 12:
const float3 VPreRailman = DrawRailmanRatio(backColor.rgb, UIGridColor.rgb, UIGridLineWidth, texCoord);
passColor = float4(lerp(backColor.rgb, VPreRailman.rgb, UIGridColor.w).rgb, backColor.a);
break;
}
}
#line 491
float3 bri(float3 backColor, float x)
{
#line 494
const float3 c = 1.0f - ( 1.0f - backColor.rgb ) * ( 1.0f - backColor.rgb );
if (x < 0.0f) {
x = x * 0.5f;
}
return saturate( lerp( backColor.rgb, c.rgb, x ));
}
#line 501
void PS_VPreOut(in float4 pos : SV_Position, float2 texCoord : TEXCOORD, out float4 passColor : SV_Target) {
const float3 pivot = float3(0.5, 0.5, 0.0);
const float3 mulUV = float3(texCoord.x, texCoord.y, 1);
const float2 ScaleSize = (float2(3440, 1440) * cLayerVPre_Scale /  float2(3440, 1440));
const float AspectX = 1.0 - 3440 * (1.0 / 1440);
const float AspectY = 1.0 - 1440 * (1.0 / 3440);
const float ScaleX =  ScaleSize.x * AspectX * cLayerVPre_Scale;
const float ScaleY =  ScaleSize.y * AspectY * cLayerVPre_Scale;
#line 510
float Rotate = 0;
switch(cLayerVPre_Angle)
{
case 0:
Rotate = -90.0 * (3.1415926 / 180.0);
break;
case 1:
Rotate = 0;
break;
case 2:
Rotate = 90.0 * (3.1415926 / 180.0);
break;
case 3:
Rotate = 180 * (3.1415926 / 180.0);
break;
case 4:
Rotate = 0;
break;
}
#line 530
const float3x3 positionMatrix = float3x3 (
1, 0, 0,
0, 1, 0,
-cLayerVPre_PosX, -cLayerVPre_PosY, 1
);
#line 537
const float3x3 scaleMatrix = float3x3 (
1/ScaleX, 0, 0,
0,  1/ScaleY, 0,
0, 0, 1
);
#line 543
const float3x3 rotateMatrix = float3x3 (
(cos (Rotate) * AspectX), (sin(Rotate) * AspectX), 0,
(-sin(Rotate) * AspectY), (cos(Rotate) * AspectY), 0,
0, 0, 1
);
#line 549
float3 SumUV = mul (mul (mul (mulUV, positionMatrix), rotateMatrix), scaleMatrix);
float4 backColor = tex2D(samplerDraw, texCoord);
switch (cLayerVPre_Angle) {
default:
const float4 Void = tex2D(samplerVoid, SumUV.rg + pivot.rg) * all(SumUV + pivot == saturate(SumUV + pivot));
const float4 VPreOut = tex2D(samplerDraw, SumUV.rg + pivot.rg) * all(SumUV + pivot == saturate(SumUV + pivot));
const float FillValue = cLayer_Blend_BGFill + 0.5;
if (cLayer_Blend_BGFill != 0.0f) {
backColor.rgb = lerp(2 * backColor.rgb * FillValue, 1.0 - 2 * (1.0 - backColor.rgb) * (1.0 - FillValue), step(0.5, FillValue));
}
passColor = VPreOut + lerp(backColor, Void, Void.a);
break;
case 4:
passColor = backColor;
break;
}
}
#line 571
technique Vertical_Previewer < ui_label = "Vertical Previewer and Composition";
ui_tooltip = "+++　Vertical Previewer and Composition +++\n"
"***バーチカル プレビュワー アンド コンポジション***\n\n"
"By showing preview on the screen to protect\n"
"your neck while taking vertical screenshot.\n\n"
"      Can be use as composition guide\n"
"   or a small preview window overlooking\n"
"     whole screen with your preference.\n\n"
"     Recommend adding to your hotkeys\n"
" by right click from here for easy access."; >
{
pass pass0
{
VertexShader = PostProcessVS;
PixelShader = PS_DrawLine;
RenderTarget = texDraw;
}
pass pass1
{
VertexShader = PostProcessVS;
PixelShader = PS_VPreOut;
}
#line 594
}

