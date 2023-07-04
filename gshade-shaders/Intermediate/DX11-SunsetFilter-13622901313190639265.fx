#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SunsetFilter.fx"
#line 11
uniform float3 ColorA <
ui_label = "Colour (A)";
ui_type = "color";
ui_category = "Colors";
> = float3(1.0, 0.0, 0.0);
#line 17
uniform float3 ColorB <
ui_label = "Colour (B)";
ui_type = "color";
ui_category = "Colors";
> = float3(0.0, 0.0, 0.0);
#line 23
uniform bool Flip <
ui_label = "Color flip";
ui_category = "Colors";
> = false;
#line 28
uniform int Axis <
ui_label = "Angle";
ui_type = "slider";
ui_step = 1;
ui_min = -180; ui_max = 180;
ui_category = "Controls";
> = -7;
#line 36
uniform float Scale <
ui_label = "Gradient sharpness";
ui_type = "slider";
ui_min = 0.5; ui_max = 1.0; ui_step = 0.005;
ui_category = "Controls";
> = 1.0;
#line 43
uniform float Offset <
ui_label = "Position";
ui_type = "slider";
ui_step = 0.002;
ui_min = 0.0; ui_max = 0.5;
ui_category = "Controls";
> = 0.0;
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
#line 51 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SunsetFilter.fx"
#line 58
float Overlay(float Layer)
{
const float Min = min(Layer, 0.5);
const float Max = max(Layer, 0.5);
return 2 * (Min * Min + 2 * Max - Max * Max) - 1.5;
}
#line 66
float3 Screen(float3 LayerA, float3 LayerB)
{ return 1.0 - (1.0 - LayerA) * (1.0 - LayerB); }
#line 69
void SunsetFilterPS(float4 vpos : SV_Position, float2 UvCoord : TEXCOORD, out float3 Image : SV_Target)
{
#line 72
Image.rgb = tex2D(ReShade::BackBuffer, UvCoord).rgb;
#line 74
float2 UvCoordAspect = UvCoord;
UvCoordAspect.y +=  (3440 * (1.0 / 1440)) * 0.5 - 0.5;
UvCoordAspect.y /=  (3440 * (1.0 / 1440));
#line 78
UvCoordAspect = UvCoordAspect * 2 - 1;
UvCoordAspect *= Scale;
#line 82
const float Angle = radians(-Axis);
const float2 TiltVector = float2(sin(Angle), cos(Angle));
#line 86
float BlendMask = dot(TiltVector, UvCoordAspect) + Offset;
BlendMask = Overlay(BlendMask * 0.5 + 0.5); 
#line 90
if (Flip)
Image = Screen(Image.rgb, lerp(ColorA.rgb, ColorB.rgb, 1 - BlendMask));
else
Image = Screen(Image.rgb, lerp(ColorA.rgb, ColorB.rgb, BlendMask));
#line 98
}
#line 100
technique SunsetFilter
{
pass
{
VertexShader = PostProcessVS;
PixelShader = SunsetFilterPS;
}
}

