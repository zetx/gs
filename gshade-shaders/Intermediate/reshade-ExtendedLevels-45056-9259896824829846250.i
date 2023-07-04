#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ExtendedLevels.fx"
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
#line 57 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ExtendedLevels.fx"
#line 63
static const float PI = 3.141592653589793238462643383279f;
#line 69
uniform bool EnableLevels <
ui_tooltip = "Enable or Disable Levels for TV <> PC or custome color range";
> = true;
#line 73
uniform float3 InputBlackPoint <
ui_type = "color";
ui_tooltip = "The black point is the new black - literally. Everything darker than this will become completely black.";
> = float3(16/255.0f, 18/255.0f, 20/255.0f);
#line 78
uniform float3 InputWhitePoint <
ui_type = "color";
ui_tooltip = "The new white point. Everything brighter than this becomes completely white";
> = float3(233/255.0f, 222/255.0f, 211/255.0f);
#line 83
uniform float3 InputGamma <
ui_type = "slider";
ui_min = 0.001f; ui_max = 10.00f; step = 0.001f;
ui_label = "RGB Gamma";
ui_tooltip = "Adjust midtones for Red, Green and Blue.";
> = float3(1.00f,1.00f,1.00f);
#line 90
uniform float3 OutputBlackPoint <
ui_type = "color";
ui_tooltip = "The black point is the new black - literally. Everything darker than this will become completely black.";
> = float3(0/255.0f, 0/255.0f, 0/255.0f);
#line 95
uniform float3 OutputWhitePoint <
ui_type = "color";
ui_tooltip = "The new white point. Everything brighter than this becomes completely white";
> = float3(255/255.0f, 255/255.0f, 255/255.0f);
#line 116
uniform float3 ColorRangeShift <
ui_type = "color";
ui_tooltip = "Some games like Watch Dogs 2 has color range 16-235 downshifted to 0-219, so this option was added to upshift color range before expanding it. RGB value entered here will be just added to default color value. Negative values impossible at the moment in game, but can be added, in shader if downshifting needed. 0 disables shifting.";
> = float3(0/255.0f, 0/255.0f, 0/255.0f);
#line 121
uniform int ColorRangeShiftSwitch <
ui_type = "slider";
ui_min = -1; ui_max = 1;
ui_tooltip = "Workaround for lack of negative color values in Reshade UI: -1 to downshift, 1 to upshift, 0 to disable";
> = 0;
#line 145
uniform bool ACEScurve <
ui_tooltip = "Enable or Disable ACES for improved contrast and luminance";
> = false;
#line 149
uniform int3 ACESLuminancePercentage <
ui_type = "slider";
ui_min = 75; ui_max = 175; step = 1;
ui_tooltip = "Percentage of ACES Luminance. Can be used to avoid some color clipping.";
> = int3(100,100,100);
#line 156
uniform bool HighlightClipping <
ui_tooltip = "Colors between the two points will stretched, which increases contrast, but details above and below the points are lost (this is called clipping).\n0 Highlight the pixels that clip. Red = Some details are lost in the highlights, Yellow = All details are lost in the highlights, Blue = Some details are lost in the shadows, Cyan = All details are lost in the shadows.";
> = false;
#line 164
float3 ACESFilmRec2020( float3 x )
{
x = x * ACESLuminancePercentage * 0.005f; 
return ( x * ( 15.8f * x + 2.12f ) ) / ( x * ( 1.2f * x + 5.92f ) + 1.9f );
}
#line 202
float3 InputLevels(float3 color, float3 inputwhitepoint, float3 inputblackpoint)
{
return color = (color - inputblackpoint)/(inputwhitepoint - inputblackpoint);
#line 206
}
#line 209
float3  Outputlevels(float3 color, float3 outputwhitepoint, float3 outputblackpoint)
{
return color * (outputwhitepoint - outputblackpoint) + outputblackpoint;
}
#line 215
float  InputLevel(float color, float inputwhitepoint, float inputblackpoint)
{
return (color - inputblackpoint)/(inputwhitepoint - inputblackpoint);
}
#line 221
float  Outputlevel(float color, float outputwhitepoint, float outputblackpoint)
{
return color * (outputwhitepoint - outputblackpoint) + outputblackpoint;
}
#line 229
float3 LevelsPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 InputColor = tex2D(ReShade::BackBuffer, texcoord).rgb;
float3 OutputColor = InputColor;
#line 283
if (EnableLevels == true)
{
OutputColor = pow(abs(((InputColor + (ColorRangeShift * ColorRangeShiftSwitch)) - InputBlackPoint)/(InputWhitePoint - InputBlackPoint)), InputGamma) * (OutputWhitePoint - OutputBlackPoint) + OutputBlackPoint;
} else {
OutputColor = InputColor;
}
#line 290
if (ACEScurve == true)
{
OutputColor = ACESFilmRec2020(OutputColor);
}
#line 295
if (HighlightClipping == true)
{
float3 ClippedColor;
#line 300
if (any(OutputColor > saturate(OutputColor)))
ClippedColor = float3(1.0, 1.0, 0.0);
else
ClippedColor = OutputColor;
#line 306
if (any(OutputColor > saturate(OutputColor)))
ClippedColor = float3(1.0, 0.0, 0.0);
else
ClippedColor = OutputColor;
#line 312
if (any(OutputColor < saturate(OutputColor)))
ClippedColor = float3(0.0, 1.0, 1.0);
else
ClippedColor = OutputColor;
#line 318
if (any(OutputColor < saturate(OutputColor)))
ClippedColor = float3(0.0, 0.0, 1.0);
else
ClippedColor = OutputColor;
#line 323
OutputColor = ClippedColor;
}
#line 329
return OutputColor;
#line 331
}
#line 333
technique ExtendedLevels
{
pass
{
VertexShader = PostProcessVS;
PixelShader = LevelsPass;
}
}

