#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Spotlight2.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1799 * (1.0 / 998); }
float2 GetPixelSize() { return float2((1.0 / 1799), (1.0 / 998)); }
float2 GetScreenSize() { return float2(1799, 998); }
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Spotlight2.fx"
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
#line 12 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Spotlight2.fx"
#line 15
uniform float u2XCenter <
ui_label = "X Position";
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "X coordinate of beam center. Axes start from upper left screen corner.";
> = 0;
#line 22
uniform float u2YCenter <
ui_label = "Y Position";
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "Y coordinate of beam center. Axes start from upper left screen corner.";
> = 0;
#line 29
uniform float u2Brightness <
ui_label = "Brightness";
ui_tooltip =
"Spotlight halo brightness.\n"
"\nDefault: 10.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 100.0;
ui_step = 0.01;
> = 10.0;
#line 40
uniform float u2Size <
ui_label = "Size";
ui_tooltip =
"Spotlight halo size in pixels.\n"
"\nDefault: 420.0";
ui_type = "slider";
ui_min = 10.0;
ui_max = 1000.0;
ui_step = 1.0;
> = 420.0;
#line 51
uniform float3 u2Color <
ui_label = "Color";
ui_tooltip =
"Spotlight halo color.\n"
"\nDefault: R:255 G:230 B:200";
ui_type = "color";
> = float3(255, 230, 200) / 255.0;
#line 59
uniform float u2Distance <
ui_label = "Distance";
ui_tooltip =
"The distance that the spotlight can illuminate.\n"
"Only works if the game has depth buffer access.\n"
"\nDefault: 0.1";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.1;
#line 71
uniform bool u2BlendFix <
ui_label = "Toggle Blend Fix";
ui_tooltip = "Enable to use the original blending mode.";
> = 0;
#line 76
uniform bool u2ToggleTexture <
ui_label = "Toggle Texture";
ui_tooltip = "Enable or disable the spotlight texture.";
> = 1;
#line 81
uniform bool u2ToggleDepth <
ui_label = "Toggle Depth";
ui_tooltip = "Enable or disable depth.";
> = 1;
#line 86
sampler2D s2Color {
Texture = ReShade::BackBufferTex;
SRGBTexture = true;
MinFilter = POINT;
MagFilter = POINT;
};
#line 95
float4 PS_2Spotlight(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET {
const float2 res =  float2(1799, 998);
const float2 uCenter = uv - float2(u2XCenter, -u2YCenter);
float2 coord = res * uCenter;
#line 100
float halo = distance(coord, res * 0.5);
float spotlight = u2Size - min(halo, u2Size);
spotlight /= u2Size;
#line 106
if (u2ToggleTexture == 0)
{
float defects = sin(spotlight * 30.0) * 0.5 + 0.5;
defects = lerp(defects, 1.0, spotlight * 2.0);
#line 111
static const float contrast = 0.125;
#line 113
defects = 0.5 * (1.0 - contrast) + defects * contrast;
spotlight *= defects * 4.0;
}
else
{
spotlight *= 2.0;
}
#line 121
if (u2ToggleDepth == 1)
{
float depth = 1.0 - ReShade::GetLinearizedDepth(uv);
depth = pow(abs(depth), 1.0 / u2Distance);
spotlight *= depth;
}
#line 128
float3 colored_spotlight = spotlight * u2Color;
colored_spotlight *= colored_spotlight * colored_spotlight;
#line 131
float3 result = 1.0 + colored_spotlight * u2Brightness;
#line 133
float3 color = tex2D(s2Color, uv).rgb;
color *= result;
#line 136
if (!u2BlendFix)
#line 138
color = max(color, (result - 1.0) * 0.001);
#line 141
return float4(color + TriDither(color, uv, 8), 1.0);
#line 145
}
#line 147
technique Spotlight2 {
pass {
VertexShader = PostProcessVS;
PixelShader = PS_2Spotlight;
SRGBWriteEnable = true;
}
}

