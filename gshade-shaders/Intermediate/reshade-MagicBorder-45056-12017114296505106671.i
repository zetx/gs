#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MagicBorder.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
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
#line 34 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MagicBorder.fx"
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
#line 37 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MagicBorder.fx"
#line 40
namespace MagicBorder
{
#line 44
uniform float LeftTopCornerDepth <
ui_label = "Depth of window left top corner";
ui_type = "slider";
ui_min = 0.00; ui_max = 300.00;
ui_step = 0.01;
ui_tooltip = "The depth the left top corner of the window is placed in the scene.\n0.0 is at the camera, 1000.0 is at the horizon";
> = 1.0;
#line 52
uniform float RightTopCornerDepth <
ui_label = "Depth of window right top corner";
ui_type = "slider";
ui_min = 0.00; ui_max = 300.00;
ui_step = 0.01;
ui_tooltip = "The depth the right top corner of the window is placed in the scene.\n0.0 is at the camera, 1000.0 is at the horizon";
> = 1.0;
#line 60
uniform float RightBottomCornerDepth <
ui_label = "Depth of window right bottom corner";
ui_type = "slider";
ui_min = 0.00; ui_max = 300.00;
ui_step = 0.01;
ui_tooltip = "The depth the right bottom corner of the window is placed in the scene.\n0.0 is at the camera, 1000.0 is at the horizon";
> = 1.0;
#line 68
uniform float LeftBottomCornerDepth <
ui_label = "Depth of window left bottom corner";
ui_type = "slider";
ui_min = 0.00; ui_max = 300.00;
ui_step = 0.01;
ui_tooltip = "The depth the left bottom corner of the window is placed in the scene.\n0.0 is at the camera, 1000.0 is at the horizon";
> = 1.0;
#line 76
uniform bool ShowDepths <
ui_label = "Show corner depths";
ui_tooltip = "If enabled it will show the depths of each corner. White is far away, black is close to the camera.";
> = false;
#line 81
uniform float2 PictureFrameLeftTop <
ui_label = "Picture frame left top coord";
ui_type = "drag";
ui_tooltip = "The left top coordinate of the picture frame";
> = float2(0.1, 0.1);
#line 87
uniform float2 PictureFrameRightTop <
ui_label = "Picture frame right top coord";
ui_type = "drag";
ui_tooltip = "The right top coordinate of the picture frame";
> = float2(0.9, 0.1);
#line 93
uniform float2 PictureFrameRightBottom <
ui_label = "Picture frame right bottom coord";
ui_type = "drag";
ui_tooltip = "The right bottom coordinate of the picture frame";
> = float2(0.9, 0.9);
#line 99
uniform float2 PictureFrameLeftBottom <
ui_label = "Picture frame left bottom coord";
ui_type = "drag";
ui_tooltip = "The left bottom coordinate of the picture frame";
> = float2(0.1, 0.9);
#line 105
uniform float4 BorderColor <
ui_label = "Border color";
ui_type= "color";
ui_tooltip = "The color of the border. Use the alpha value for blending. ";
> = float4(1.0, 1.0, 1.0, 1.0);
#line 111
uniform float4 PictureFrameColor <
ui_label = "Picture frame color";
ui_type= "color";
ui_tooltip = "The color of the area within the border. Use the alpha value for blending. ";
> = float4(0.7, 0.7, 0.7, 1.0);
#line 118
struct VSBORDERINFO
{
float4 vpos : SV_Position;
float2 Texcoord : TEXCOORD0;
float2 LeftTop : TEXCOORD1;
float2 RightTop : TEXCOORD2;
float2 RightBottom : TEXCOORD3;
float2 LeftBottom : TEXCOORD4;
};
#line 129
float CalculateDepthOfFrameAtCoord(VSBORDERINFO info)
{
#line 132
const float2 coord = info.Texcoord;
#line 135
float distanceToCorner = 1-distance(float2(0, 0), coord);
float2 average = float2((LeftTopCornerDepth/1000.0) * distanceToCorner, distanceToCorner);
#line 138
distanceToCorner = 1-distance(float2(1, 0), coord);
average.x += ((RightTopCornerDepth/1000.0) * distanceToCorner);
average.y += distanceToCorner;
#line 142
distanceToCorner = 1-distance(float2(1, 1), coord);
average.x += ((RightBottomCornerDepth/1000.0) * distanceToCorner);
average.y += distanceToCorner;
#line 146
distanceToCorner = 1-distance(float2(0, 1), coord);
average.x += ((LeftBottomCornerDepth/1000.0) * distanceToCorner);
average.y += distanceToCorner;
#line 150
return saturate(average.x/average.y);
}
#line 158
bool IsCoordInPictureArea(VSBORDERINFO info)
{
bool isInPictureArea = false;
#line 162
float2 vertices[4];
vertices[0] = info.LeftTop;
vertices[1] = info.RightTop;
vertices[2] = info.RightBottom;
vertices[3] = info.LeftBottom;
#line 170
int next = 0;
for (int current=0; current<4; current++)
{
#line 174
next = current+1;
if (next == 4) next = 0;
#line 178
float2 vc = vertices[current];    
float2 vn = vertices[next];       
#line 182
if (((vc.y >= info.Texcoord.y && vn.y < info.Texcoord.y) || (vc.y < info.Texcoord.y && vn.y >= info.Texcoord.y)) &&
(info.Texcoord.x < (vn.x-vc.x)*(info.Texcoord.y-vc.y) / (vn.y-vc.y)+vc.x))
{
isInPictureArea = !isInPictureArea;
}
}
#line 189
return isInPictureArea;
}
#line 199
VSBORDERINFO VS_CalculateBorderInfo(in uint id : SV_VertexID)
{
VSBORDERINFO borderInfo;
#line 203
borderInfo.Texcoord.x = (id == 2) ? 2.0 : 0.0;
borderInfo.Texcoord.y = (id == 1) ? 2.0 : 0.0;
borderInfo.vpos = float4(borderInfo.Texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
#line 207
borderInfo.LeftTop = PictureFrameLeftTop;
borderInfo.RightTop = PictureFrameRightTop;
borderInfo.LeftBottom = PictureFrameLeftBottom;
borderInfo.RightBottom = PictureFrameRightBottom;
return borderInfo;
}
#line 220
void PS_DrawBorder(VSBORDERINFO borderInfo, out float4 fragment : SV_Target0)
{
const float4 originalFragment = tex2D(ReShade::BackBuffer, borderInfo.Texcoord);
const float depthFragment = ReShade::GetLinearizedDepth(borderInfo.Texcoord);
#line 226
const bool isInPictureArea = IsCoordInPictureArea(borderInfo);
float depthOfFrameAtCoord = CalculateDepthOfFrameAtCoord(borderInfo);
fragment = isInPictureArea ? PictureFrameColor : BorderColor;
fragment = depthFragment > depthOfFrameAtCoord ? lerp(originalFragment, fragment, fragment.a) : originalFragment;
fragment = ShowDepths ? float4(depthOfFrameAtCoord, depthOfFrameAtCoord, depthOfFrameAtCoord, 1.0) : fragment;
#line 232
fragment.rgb += TriDither(fragment.rgb, borderInfo.Texcoord, 8);
#line 234
}
#line 242
technique MagicBorder
< ui_tooltip = "Magic Border "
 "v1.0.1"
"\n===========================================\n\n"
"Magic Border is an easy way to create a border in a shot and have part of your\n"
"shot in front of the border, like it jumps out of the frame.\n\n"
"Magic Border was written by Frans 'Otis_Inf' Bouma and is part of OtisFX\n"
"https://fransbouma.com | https://github.com/FransBouma/OtisFX"; >
{
pass DrawBorder { VertexShader = VS_CalculateBorderInfo; PixelShader = PS_DrawBorder;}
}
}
