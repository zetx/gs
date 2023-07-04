#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AspectRatioComposition.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 5360 * (1.0 / 1440); }
float2 GetPixelSize() { return float2((1.0 / 5360), (1.0 / 1440)); }
float2 GetScreenSize() { return float2(5360, 1440); }
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
#line 6 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AspectRatioComposition.fx"
#line 27
uniform int2 iUIAspectRatio <
ui_type = "slider";
ui_label = "Aspect Ratio";
ui_tooltip = "To control aspect ratio with a float\nadd 'ASPECT_RATIO_FLOAT' to preprocessor.\nOptional: 'ASPECT_RATIO_MAX=xyz'";
ui_min = 0; ui_max =  25;
> = int2(16, 9);
#line 35
uniform int iUIGridType <
ui_type = "combo";
ui_label = "Grid Type";
ui_items = "Off\0Fractions\0Golden Ratio\0";
> = 0;
#line 41
uniform int iUIGridFractions <
ui_type = "slider";
ui_label = "Fractions";
ui_tooltip = "Set 'Grid Type' to 'Fractions'";
ui_min = 1; ui_max = 5;
> = 3;
#line 48
uniform float4 UIGridColor <
ui_type = "color";
ui_label = "Grid Color";
> = float4(0.0, 0.0, 0.0, 1.0);
#line 57
float3 DrawGrid(float3 backbuffer, float3 gridColor, float aspectRatio, float fraction, float4 vpos)
{
float borderSize;
float fractionWidth;
#line 62
float3 retVal = backbuffer;
#line 64
if(aspectRatio <  (5360 * (1.0 / 1440)))
{
borderSize = (5360 - 1440 * aspectRatio) / 2.0;
fractionWidth = (5360 - 2 * borderSize) / fraction;
#line 69
if(vpos.x < borderSize || vpos.x > (5360 - borderSize))
retVal = gridColor;
#line 72
if((vpos.y % (1440 / fraction)) < 1)
retVal = gridColor;
#line 75
if(((vpos.x - borderSize) % fractionWidth) < 1)
retVal = gridColor;
}
else
{
borderSize = (1440 - 5360 / aspectRatio) / 2.0;
fractionWidth = (1440 - 2 * borderSize) / fraction;
#line 83
if(vpos.y < borderSize || vpos.y > (1440 - borderSize))
retVal = gridColor;
#line 86
if((vpos.x % (5360 / fraction)) < 1)
retVal = gridColor;
#line 89
if(((vpos.y - borderSize) % fractionWidth) < 1)
retVal = gridColor;
#line 92
}
#line 94
if(vpos.x <= 1 || vpos.x >= 5360-1 || vpos.y <= 1 || vpos.y >= 1440-1)
retVal = gridColor;
#line 97
return retVal;
}
#line 104
float3 AspectRatioComposition_PS(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
float3 retVal = color;
#line 109
float userAspectRatio;
#line 114
userAspectRatio = (float)iUIAspectRatio.x / (float)iUIAspectRatio.y;
#line 117
if(iUIGridType == 1)
retVal = DrawGrid(color, UIGridColor.rgb, userAspectRatio, iUIGridFractions, vpos);
else if(iUIGridType == 2)
{
retVal = DrawGrid(color, UIGridColor.rgb, userAspectRatio,  1.6180339887, vpos);
retVal = DrawGrid(retVal, UIGridColor.rgb, userAspectRatio,  1.6180339887, float4(5360, 1440, 0, 0) - vpos);
}
#line 125
return lerp(color, retVal, UIGridColor.w);
}
#line 128
technique AspectRatioComposition
{
pass
{
VertexShader = PostProcessVS;
PixelShader = AspectRatioComposition_PS;
}
}
