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
float GetAspectRatio() { return 1798 * (1.0 / 997); }
float2 GetPixelSize() { return float2((1.0 / 1798), (1.0 / 997)); }
float2 GetScreenSize() { return float2(1798, 997); }
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
#line 54 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SunsetFilter.fx"
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
UvCoordAspect.y +=  (1798 * (1.0 / 997)) * 0.5 - 0.5;
UvCoordAspect.y /=  (1798 * (1.0 / 997));
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
#line 96
Image += TriDither(Image, UvCoord, 8);
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

