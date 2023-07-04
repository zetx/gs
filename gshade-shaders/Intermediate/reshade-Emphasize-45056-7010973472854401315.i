#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Emphasize.fx"
#line 10
uniform float FocusDepth <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "Manual focus depth of the point which has the focus. Range from 0.0, which means camera is the focus plane, till 1.0 which means the horizon is focus plane.";
> = 0.026;
uniform float FocusRangeDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The depth of the range around the manual focus depth which should be emphasized. Outside this range, de-emphasizing takes place";
> = 0.001;
uniform float FocusEdgeDepth <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_tooltip = "The depth of the edge of the focus range. Range from 0.00, which means no depth, so at the edge of the focus range, the effect kicks in at full force,\ntill 1.00, which means the effect is smoothly applied over the range focusRangeEdge-horizon.";
ui_step = 0.001;
> = 0.050;
uniform bool Spherical <
ui_tooltip = "Enables Emphasize in a sphere around the focus-point instead of a 2D plane";
> = false;
uniform int Sphere_FieldOfView <
ui_type = "slider";
ui_min = 1; ui_max = 180;
ui_tooltip = "Specifies the estimated Field of View you are currently playing with. Range from 1, which means 1 Degree, till 180 which means 180 Degree (half the scene).\nNormal games tend to use values between 60 and 90.";
> = 75;
uniform float Sphere_FocusHorizontal <
ui_type = "slider";
ui_min = 0; ui_max = 1;
ui_tooltip = "Specifies the location of the focuspoint on the horizontal axis. Range from 0, which means left screen border, till 1 which means right screen border.";
> = 0.5;
uniform float Sphere_FocusVertical <
ui_type = "slider";
ui_min = 0; ui_max = 1;
ui_tooltip = "Specifies the location of the focuspoint on the vertical axis. Range from 0, which means upper screen border, till 1 which means bottom screen border.";
> = 0.5;
uniform float3 BlendColor <
ui_type = "color";
ui_tooltip = "Specifies the blend color to blend with the greyscale. in (Red, Green, Blue). Use dark colors to darken further away objects";
> = float3(0.0, 0.0, 0.0);
uniform float BlendFactor <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Specifies the factor BlendColor is blended. Range from 0.0, which means full greyscale, till 1.0 which means full blend of the BlendColor";
> = 0.0;
uniform float EffectFactor <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Specifies the factor the desaturation is applied. Range from 0.0, which means the effect is off (normal image), till 1.0 which means the desaturated parts are\nfull greyscale (or color blending if that's enabled)";
> = 0.9;
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
#line 61 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Emphasize.fx"
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
#line 64 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Emphasize.fx"
#line 71
float CalculateDepthDiffCoC(float2 texcoord : TEXCOORD)
{
const float scenedepth = ReShade::GetLinearizedDepth(texcoord);
const float scenefocus =  FocusDepth;
const float desaturateFullRange = FocusRangeDepth+FocusEdgeDepth;
float depthdiff;
#line 78
if(Spherical == true)
{
texcoord.x = (texcoord.x-Sphere_FocusHorizontal)*3440;
texcoord.y = (texcoord.y-Sphere_FocusVertical)*1440;
const float degreePerPixel = Sphere_FieldOfView*(1.0 / 3440);
const float fovDifference = sqrt((texcoord.x*texcoord.x)+(texcoord.y*texcoord.y))*degreePerPixel;
depthdiff = sqrt((scenedepth*scenedepth)+(scenefocus*scenefocus)-(2*scenedepth*scenefocus*cos(fovDifference*(2* 3.1415927/360))));
}
else
{
depthdiff = abs(scenedepth-scenefocus);
}
#line 91
if (depthdiff > desaturateFullRange)
return saturate(1.0);
else
return saturate(smoothstep(0, desaturateFullRange, depthdiff));
}
#line 97
void PS_Otis_EMZ_Desaturate(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 outFragment : SV_Target)
{
const float depthDiffCoC = CalculateDepthDiffCoC(texcoord.xy);
const float4 colFragment = tex2D(ReShade::BackBuffer, texcoord);
const float greyscaleAverage = (colFragment.x + colFragment.y + colFragment.z) / 3.0;
float4 desColor = float4(greyscaleAverage, greyscaleAverage, greyscaleAverage, depthDiffCoC);
desColor = lerp(desColor, float4(BlendColor, depthDiffCoC), BlendFactor);
outFragment = lerp(colFragment, desColor, saturate(depthDiffCoC * EffectFactor));
#line 107
outFragment.rgb += TriDither(outFragment.rgb, texcoord, 8);
#line 109
}
#line 111
technique Emphasize
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_Otis_EMZ_Desaturate;
}
}

