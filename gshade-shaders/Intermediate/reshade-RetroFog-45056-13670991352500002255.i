#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RetroFog.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1024 * (1.0 / 768); }
float2 GetPixelSize() { return float2((1.0 / 1024), (1.0 / 768)); }
float2 GetScreenSize() { return float2(1024, 768); }
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
#line 26 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RetroFog.fx"
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
#line 29 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RetroFog.fx"
#line 42
uniform float fOpacity <
ui_label = "Opacity";
ui_type  = "slider";
ui_min   = 0.0;
ui_max   = 1.0;
ui_step  = 0.001;
> = 1.0;
#line 50
uniform float3 f3Color <
ui_label   = "Fog Color";
ui_tooltip = "Unused if automatic color is enabled.";
ui_type    = "color";
> = float3(0.0, 0.0, 0.0);
#line 56
uniform bool bDithering <
ui_label = "Dithering";
ui_tooltip = "Enable a retro dithering pattern, making the fog pixelated like in old games such as Doom.";
> = false;
#line 61
uniform float fQuantize <
ui_label   = "Quantize";
ui_tooltip = "Use to simulate lack of colors: 8.0 for 8bits, 16.0 for 16bits etc.\n"
"Set to 0.0 to disable quantization.\n"
"Only enabled if dithering is enabled as well.";
ui_type    = "slider";
ui_min     = 0.0;
ui_max     = 255.0;
ui_step    = 1.0;
> = 255.0;
#line 72
uniform float2 f2Curve <
ui_label   = "Fog Curve";
ui_tooltip = "Controls the contrast of fog using start/end values for determining the range.";
ui_type    = "slider";
ui_min     = 0.0;
ui_max     = 1.0;
ui_step    = 0.001;
> = float2(0.0, 1.0);
#line 81
uniform float fStart <
ui_label   = "Fog Start";
ui_tooltip = "Distance at which the fog center is away from the camera.";
ui_type    = "slider";
ui_min     = 0.0;
ui_max     = 1.0;
ui_step    = 0.001;
> = 0.0;
#line 90
uniform bool bCurved <
ui_label = "Curved";
ui_tooltip = "If enabled the fog will curve around the start position, otherwise it'll be completely linear and ignore side distance.";
> = true;
#line 97
sampler2D sRetroFog_BackBuffer {
Texture = ReShade::BackBufferTex;
SRGBTexture = true;
};
#line 104
float get_fog(float2 uv) {
float depth = ReShade::GetLinearizedDepth(uv);
#line 107
if (bCurved) {
depth = distance(
float2( ((uv.x - 0.5) * depth * 2.0 + 0.5), depth),
float2(0.5, fStart - 0.45)
);
} else {
depth = distance(depth, fStart - 0.45);
}
#line 116
return smoothstep(f2Curve.x, f2Curve.y, depth);
}
#line 120
int get_bayer(int2 i) {
static const int bayer[8 * 8] = {
0, 48, 12, 60,  3, 51, 15, 63,
32, 16, 44, 28, 35, 19, 47, 31,
8, 56,  4, 52, 11, 59,  7, 55,
40, 24, 36, 20, 43, 27, 39, 23,
2, 50, 14, 62,  1, 49, 13, 61,
34, 18, 46, 30, 33, 17, 45, 29,
10, 58,  6, 54,  9, 57,  5, 53,
42, 26, 38, 22, 41, 25, 37, 21
};
return bayer[i.x + 8 * i.y];
}
#line 135
float dither(float x, float2 uv) {
x *= fOpacity;
#line 138
if (fQuantize > 0.0)
x = round(x * fQuantize) / fQuantize;
#line 141
const float2 index = float2(uv *  float2(1024, 768)) % 8;
float limit;
if (index.x < 8)
limit = float(get_bayer(index) + 1) / 64.0;
else
limit = 0.0;
#line 148
if (x < limit)
return 0.0;
else
return 1.0;
}
#line 154
float3 get_scene_color(float2 uv) {
static const int point_count = 8;
static const float2 points[point_count] = {
float2(0.0, 0.0),
float2(0.0, 0.5),
float2(0.0, 1.0),
float2(0.5, 0.0),
#line 162
float2(0.5, 1.0),
float2(1.0, 0.0),
float2(1.0, 0.5),
float2(1.0, 1.0)
};
#line 168
float3 color =  tex2Dlod(sRetroFog_BackBuffer, float4(points[0], 0.0, 0.0)).rgb;
[loop]
for (int i = 1; i < point_count; ++i)
color +=  tex2Dlod(sRetroFog_BackBuffer, float4(points[i], 0.0, 0.0)).rgb;
#line 173
return color / point_count;
}
#line 178
void PS_RetroFog(
float4 position  : SV_POSITION,
float2 uv        : TEXCOORD,
out float4 color : SV_TARGET
) {
color = tex2D(sRetroFog_BackBuffer, uv);
float fog = get_fog(uv);
#line 186
if (bDithering)
fog = dither(fog, uv);
else
fog *= fOpacity;
#line 191
const float3 fog_color = f3Color;
#line 193
color.rgb = lerp(color.rgb, fog_color, fog);
#line 195
color.rgb += TriDither(color.rgb, uv, 8);
#line 197
}
#line 201
technique RetroFog {
pass {
VertexShader = PostProcessVS;
PixelShader  = PS_RetroFog;
SRGBWriteEnable = true;
}
}

