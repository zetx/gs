#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Levels.fx"
#line 22
uniform int BlackPoint <
ui_type = "slider";
ui_min = 0; ui_max = 255;
ui_label = "Black Point";
ui_tooltip = "The black point is the new black - literally. Everything darker than this will become completely black.";
> = 16;
#line 29
uniform int WhitePoint <
ui_type = "slider";
ui_min = 0; ui_max = 255;
ui_label = "White Point";
ui_tooltip = "The new white point. Everything brighter than this becomes completely white";
> = 235;
#line 36
uniform bool HighlightClipping <
ui_label = "Highlight clipping pixels";
ui_tooltip = "Colors between the two points will stretched, which increases contrast, but details above and below the points are lost (this is called clipping).\n"
"This setting marks the pixels that clip.\n"
"Red: Some detail is lost in the highlights\n"
"Yellow: All detail is lost in the highlights\n"
"Blue: Some detail is lost in the shadows\n"
"Cyan: All detail is lost in the shadows.";
> = false;
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
#line 46 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Levels.fx"
#line 52
float3 LevelsPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float black_point_float = BlackPoint / 255.0;
#line 56
float white_point_float;
#line 58
if (WhitePoint == BlackPoint)
white_point_float = (255.0 / 0.00025);
else
white_point_float = 255.0 / (WhitePoint - BlackPoint);
#line 63
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
color = color * white_point_float - (black_point_float *  white_point_float);
#line 66
if (HighlightClipping)
{
float3 clipped_colors;
#line 71
if (any(color > saturate(color)))
clipped_colors = float3(1.0, 0.0, 0.0);
else
clipped_colors = color;
#line 77
if (all(color > saturate(color)))
clipped_colors = float3(1.0, 1.0, 0.0);
#line 81
if (any(color < saturate(color)))
clipped_colors = float3(0.0, 0.0, 1.0);
#line 85
if (all(color < saturate(color)))
clipped_colors = float3(0.0, 1.0, 1.0);
#line 88
color = clipped_colors;
}
#line 94
return color;
#line 96
}
#line 98
technique Levels
{
pass
{
VertexShader = PostProcessVS;
PixelShader = LevelsPass;
}
}

