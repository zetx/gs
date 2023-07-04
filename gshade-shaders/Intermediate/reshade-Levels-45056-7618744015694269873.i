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
#line 46 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Levels.fx"
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
#line 49 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Levels.fx"
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
#line 92
return color + TriDither(color, texcoord, 8);
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

