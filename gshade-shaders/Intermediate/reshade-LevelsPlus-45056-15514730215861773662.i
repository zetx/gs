#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LevelsPlus.fx"
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
#line 68 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LevelsPlus.fx"
#line 74
static const float PI = 3.141592653589793238462643383279f;
#line 80
uniform bool EnableLevels <
ui_tooltip = "Enable or Disable Levels for TV <> PC or custome color range";
> = true;
#line 84
uniform float3 InputBlackPoint <
ui_type = "color";
ui_tooltip = "The black point is the new black - literally.\n0 Everything darker than this will become completely black.";
> = float3(16/255.0f, 18/255.0f, 20/255.0f);
#line 89
uniform float3 InputWhitePoint <
ui_type = "color";
ui_tooltip = "The new white point.\n0 Everything brighter than this becomes completely white";
> = float3(233/255.0f, 222/255.0f, 211/255.0f);
#line 94
uniform float3 InputGamma <
ui_type = "slider";
ui_min = 0.01f; ui_max = 10.00f; step = 0.01f;
ui_label = "RGB Gamma";
ui_tooltip = "Adjust midtones for Red, Green and Blue.";
> = float3(1.00f,1.00f,1.00f);
#line 101
uniform float3 OutputBlackPoint <
ui_type = "color";
ui_tooltip = "The black point is the new black - literally.\n0 Everything darker than this will become completely black.";
> = float3(0/255.0f, 0/255.0f, 0/255.0f);
#line 106
uniform float3 OutputWhitePoint <
ui_type = "color";
ui_tooltip = "The new white point.\n0 Everything brighter than this becomes completely white";
> = float3(255/255.0f, 255/255.0f, 255/255.0f);
#line 127
uniform float3 ColorRangeShift <
ui_type = "color";
ui_tooltip = "Some games like Watch Dogs 2 has color range 16-235 downshifted to 0-219,\n0 so this option was added to upshift color range before expanding it.\n0 RGB value entered here will be just added to default color value.\n0 Negative values impossible at the moment in game, but can be added,\n0 in shader if downshifting needed.\n0 0 disables shifting.";
> = float3(0/255.0f, 0/255.0f, 0/255.0f);
#line 132
uniform int ColorRangeShiftSwitch <
ui_type = "slider";
ui_min = -1; ui_max = 1;
ui_tooltip = "Workaround for lack of negative color values in Reshade UI:\n0 -1 to downshift,\n0 1 to upshift,\n0 0 to disable";
> = 0;
#line 156
uniform bool HighlightClipping <
ui_tooltip = "Colors between the two points will stretched, which increases contrast, but details above and below the points are lost (this is called clipping).\n0 Highlight the pixels that clip.\n0 Red = Some details are lost in the highlights,\n0 Yellow = All details are lost in the highlights,\n0 Blue = Some details are lost in the shadows,\n0 Cyan = All details are lost in the shadows.";
> = false;
#line 163
uniform bool enableACESFilmRec2020old <
ui_tooltip = "Enable or Disable OLD ACES for improved contrast and luminance";
> = false;
#line 167
uniform bool enableACESFilmRec2020 <
ui_tooltip = "Enable or Disable ACES for improved contrast and luminance";
> = false;
#line 172
uniform bool enableACESFitted <
ui_tooltip = "Enable or Disable ALT ACES for improved contrast and luminance";
> = false;
#line 176
uniform int3 ACESLuminancePercentage <
ui_type = "slider";
ui_min = 0; ui_max = 200; step = 1;
ui_tooltip = "Percentage of ACES Luminance.\n0 Can be used to avoid some color clipping.";
> = int3(100,100,100);
#line 184
float3 ACESFilmRec2020old( float3 color )
{
const float Slope = 15.8f;
const float Toe = 2.12f;
const float Shoulder = 1.2f;
const float BlackClip = 5.92f;
const float WhiteClip = 1.9f;
color = color * ACESLuminancePercentage * 0.005f; 
return ( color * ( Slope * color + Toe ) ) / ( color * ( Shoulder * color + BlackClip ) + WhiteClip );
}
#line 195
float3 ACESFilmRec2020( float3 color )
{
const float Slope = 0.98;
const float Toe = 0.3;
const float Shoulder = 0.22;
const float BlackClip = 0;
const float WhiteClip = 0.025;
color = color * ACESLuminancePercentage * 0.005f; 
return ( color * ( Slope * color + Toe ) ) / ( color * ( Shoulder * color + BlackClip ) + WhiteClip );
}
#line 220
static const float3x3 ACESInputMat = float3x3
(
0.59719, 0.35458, 0.04823,
0.07600, 0.90834, 0.01566,
0.02840, 0.13383, 0.83777
);
#line 228
static const float3x3 ACESOutputMat = float3x3
(
1.60475, -0.53108, -0.07367,
-0.10208,  1.10813, -0.00605,
-0.00327, -0.07276,  1.07602
);
#line 235
float3 RRTAndODTFit(float3 v)
{
const float3 a = v * (v + 0.0245786f) - 0.000090537f;
const float3 b = v * (0.983729f * v + 0.4329510f) + 0.238081f;
return a / b;
}
#line 242
float3 ACESFitted(float3 color)
{
color = mul(ACESInputMat, color);
#line 247
color = RRTAndODTFit(color);
#line 249
color = mul(ACESOutputMat, color);
#line 252
return saturate(color);
}
#line 295
float3 InputLevels(float3 color, float3 inputwhitepoint, float3 inputblackpoint)
{
return color = (color - inputblackpoint)/(inputwhitepoint - inputblackpoint);
#line 299
}
#line 302
float3  Outputlevels(float3 color, float3 outputwhitepoint, float3 outputblackpoint)
{
return color * (outputwhitepoint - outputblackpoint) + outputblackpoint;
}
#line 308
float  InputLevel(float color, float inputwhitepoint, float inputblackpoint)
{
return (color - inputblackpoint)/(inputwhitepoint - inputblackpoint);
}
#line 314
float  Outputlevel(float color, float outputwhitepoint, float outputblackpoint)
{
return color * (outputwhitepoint - outputblackpoint) + outputblackpoint;
}
#line 322
float3 LevelsPlusPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 InputColor = tex2D(ReShade::BackBuffer, texcoord).rgb;
float3 OutputColor = InputColor;
#line 388
if (EnableLevels == true)
{
OutputColor = pow(abs(((InputColor + (ColorRangeShift * ColorRangeShiftSwitch)) - InputBlackPoint)/(InputWhitePoint - InputBlackPoint)) , InputGamma) * (OutputWhitePoint - OutputBlackPoint) + OutputBlackPoint;
} else {
OutputColor = InputColor;
}
#line 395
if (enableACESFilmRec2020old == true)
{
OutputColor = ACESFilmRec2020old(OutputColor);
}
#line 400
if (enableACESFilmRec2020 == true)
{
OutputColor = ACESFilmRec2020(OutputColor);
}
#line 405
if (enableACESFitted == true)
{
OutputColor = ACESFitted(OutputColor);
}
#line 410
if (HighlightClipping == true)
{
float3 ClippedColor;
#line 415
if (any(OutputColor > saturate(OutputColor)))
ClippedColor = float3(1.0, 1.0, 0.0);
else
ClippedColor = OutputColor;
#line 421
if (all(OutputColor > saturate(OutputColor)))
ClippedColor = float3(1.0, 0.0, 0.0);
#line 425
if (any(OutputColor < saturate(OutputColor)))
ClippedColor = float3(0.0, 1.0, 1.0);
#line 429
if (all(OutputColor < saturate(OutputColor)))
ClippedColor = float3(0.0, 0.0, 1.0);
#line 432
OutputColor = ClippedColor;
}
#line 439
return OutputColor;
#line 441
}
#line 443
technique LevelsPlus
{
pass
{
VertexShader = PostProcessVS;
PixelShader = LevelsPlusPass;
}
}

