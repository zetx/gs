#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicSharpen.fx"
#line 16
uniform float Strength <
ui_label = "Strength";
ui_type = "slider";
ui_min = 0.0; ui_max = 100.0; ui_step = 0.01;
> = 60.0;
#line 22
uniform float Offset <
ui_label = "Radius";
ui_tooltip = "High-pass cross offset in pixels";
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0; ui_step = 0.001;
> = 0.1;
#line 29
uniform float Clamp <
ui_label = "Clamping";
ui_type = "slider";
ui_min = 0.5; ui_max = 1.0; ui_step = 0.001;
> = 0.65;
#line 35
uniform bool UseMask <
ui_label = "Sharpen only center";
ui_tooltip = "Sharpen only in center of the image";
> = false;
#line 40
uniform int Coefficient <
ui_tooltip = "For digital video signal use BT.709, for analog (like VGA) use BT.601";
ui_label = "YUV coefficients";
ui_type = "radio";
ui_items = "BT.709 - digital\0BT.601 - analog\0";
ui_category = "Additional settings";
ui_category_closed = true;
> = 0;
#line 49
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
float GetAspectRatio() { return 1024 * (1.0 / 768); }
float2 GetPixelSize() { return float2((1.0 / 1024), (1.0 / 768)); }
float2 GetScreenSize() { return float2(1024, 768); }
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
#line 62 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicSharpen.fx"
#line 65
sampler BackBuffer
{
Texture = ReShade::BackBufferTex;
AddressU = MIRROR;
AddressV = MIRROR;
#line 71
SRGBTexture = true;
#line 73
};
#line 80
static const float3 Luma709 = float3(0.2126, 0.7152, 0.0722);
#line 82
static const float3 Luma601 = float3(0.299, 0.587, 0.114);
#line 85
float Overlay(float LayerA, float LayerB)
{
const float MinA = min(LayerA, 0.5);
const float MinB = min(LayerB, 0.5);
const float MaxA = max(LayerA, 0.5);
const float MaxB = max(LayerB, 0.5);
return 2.0*((MinA*MinB+MaxA)+(MaxB-MaxA*MaxB))-1.5;
}
#line 95
float Overlay(float LayerAB)
{
const float MinAB = min(LayerAB, 0.5);
const float MaxAB = max(LayerAB, 0.5);
return 2.0*((MinAB*MinAB+MaxAB)+(MaxAB-MaxAB*MaxAB))-1.5;
}
#line 103
float gamma(float grad) { return pow(abs(grad), 2.2); }
#line 110
float3 FilmicSharpenPS(float4 pos : SV_Position, float2 UvCoord : TEXCOORD) : SV_Target
{
#line 113
const float3 Source = tex2D(BackBuffer, UvCoord).rgb;
#line 116
float Mask;
if (UseMask)
{
#line 120
Mask = 1.0-length(UvCoord*2.0-1.0);
Mask = Overlay(Mask)*Strength;
#line 123
if (Mask <= 0) return Source;
}
else Mask = Strength;
#line 128
const float2 Pixel =  float2((1.0 / 1024), (1.0 / 768))*Offset;
#line 131
const float2 NorSouWesEst[4] = {
float2(UvCoord.x, UvCoord.y+Pixel.y),
float2(UvCoord.x, UvCoord.y-Pixel.y),
float2(UvCoord.x+Pixel.x, UvCoord.y),
float2(UvCoord.x-Pixel.x, UvCoord.y)
};
#line 139
float3 LumaCoefficient;
if (bool(Coefficient))
LumaCoefficient = Luma601;
else
LumaCoefficient = Luma709;
#line 146
float HighPass = 0.0;
[unroll]
for(int i=0; i<4; i++)
HighPass += dot(tex2D(BackBuffer, NorSouWesEst[i]).rgb, LumaCoefficient);
#line 151
HighPass = 0.5-0.5*(HighPass*0.25-dot(Source, LumaCoefficient));
#line 154
HighPass = lerp(0.5, HighPass, Mask);
#line 157
if (Clamp != 1.0)
HighPass = clamp(HighPass, 1.0-Clamp, Clamp);
#line 160
if (Preview)
return gamma(HighPass);
else
return float3(
Overlay(Source.r, HighPass),
Overlay(Source.g, HighPass),
Overlay(Source.b, HighPass)
);
}
#line 175
technique FilmicSharpen < ui_label = "Filmic Sharpen"; >
{
pass
{
VertexShader = PostProcessVS;
PixelShader = FilmicSharpenPS;
SRGBWriteEnable = true;
}
}

