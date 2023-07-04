#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RimLight.fx"
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
#line 14 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RimLight.fx"
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
#line 17 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RimLight.fx"
#line 25
uniform float3 Color <
ui_label = "Rim Light Color";
ui_tooltip = "Adjust rim light tint";
ui_type = "color";
> = float3(1, 1, 1);
#line 31
uniform bool Debug <
ui_label = "Display Normal Map Pass";
ui_tooltip = "Surface vector angle color map";
ui_category = "Debug Tools";
ui_category_closed = true;
> = false;
#line 38
uniform bool CustomFarPlane <
ui_label = "Custom Far Plane";
ui_tooltip = "Enable custom far plane display outside debug view";
ui_category = "Debug Tools";
> = true;
#line 44
uniform float FarPlane <
ui_label = "Depth Far Plane Preview";
ui_tooltip = "Adjust this option for proper normal map display\n"
"and change preprocessor definitions, so that\n"
"RESHADE_DEPTH_LINEARIZATION_FAR_PLANE = Your_Value";
ui_type = "slider";
ui_min = 0; ui_max = 1000; ui_step = 1;
ui_category = "Debug Tools";
> = 1000.0;
#line 60
float Overlay(float Layer)
{
const float MinLayer = min(Layer, 0.5);
const float MaxLayer = max(Layer, 0.5);
return 2 * (MinLayer * MinLayer + 2 * MaxLayer - MaxLayer * MaxLayer) - 1.5;
}
#line 68
float GetDepth(float2 TexCoord)
{
float depth;
if(Debug || CustomFarPlane)
{
#line 77
depth = tex2Dlod(ReShade::DepthBuffer, float4(TexCoord, 0, 0)).x;
#line 87
depth /= FarPlane - depth * (FarPlane - 1.0);
}
else
{
depth = ReShade::GetLinearizedDepth(TexCoord);
}
return depth;
}
#line 97
float3 NormalVector(float2 TexCoord)
{
const float3 offset = float3( float2((1.0 / 3440), (1.0 / 1440)).xy, 0.0);
const float2 posCenter = TexCoord.xy;
const float2 posNorth = posCenter - offset.zy;
const float2 posEast = posCenter + offset.xz;
#line 104
const float3 vertCenter = float3(posCenter - 0.5, 1) * GetDepth(posCenter);
const float3 vertNorth = float3(posNorth - 0.5, 1) * GetDepth(posNorth);
const float3 vertEast = float3(posEast - 0.5, 1) * GetDepth(posEast);
#line 108
return normalize(cross(vertCenter - vertNorth, vertCenter - vertEast)) * 0.5 + 0.5;
}
#line 116
void RimLightPS(in float4 position : SV_Position, in float2 TexCoord : TEXCOORD, out float3 color : SV_Target)
{
const float3 NormalPass = NormalVector(TexCoord);
#line 120
if(Debug) color = NormalPass;
else
{
color = cross(NormalPass, float3(0.5, 0.5, 1.0));
const float rim = max(max(color.x, color.y), color.z);
color = tex2D(ReShade::BackBuffer, TexCoord).rgb;
color += Color * Overlay(rim);
}
#line 130
color.rgb += TriDither(color.rgb, TexCoord, 8);
#line 132
}
#line 139
technique RimLight < ui_label = "Rim Light"; >
{
pass
{
VertexShader = PostProcessVS;
PixelShader = RimLightPS;
}
}

