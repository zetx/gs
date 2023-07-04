#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MultiTonePoster.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1309 * (1.0 / 762); }
float2 GetPixelSize() { return float2((1.0 / 1309), (1.0 / 762)); }
float2 GetScreenSize() { return float2(1309, 762); }
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
#line 6 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MultiTonePoster.fx"
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MultiTonePoster.fx"
#line 15
uniform float4 Color1 <
ui_type = "color";
ui_label = "Color 1";
> = float4(0.0, 0.05, 0.17, 1.0);
uniform int Pattern12 <
ui_type = "combo";
ui_label = "Pattern Type";
ui_items =  "Linear\0Vertical Stripes\0Horizontal Stripes\0Squares\0";
> = 3;
uniform int Width12 <
ui_type = "slider";
ui_label = "Width";
ui_min = 1; ui_max = 10;
ui_step = 1;
> = 1;
uniform float4 Color2 <
ui_type = "color";
ui_label = "Color 2";
> = float4(0.20, 0.16, 0.25, 1.0);
uniform int Pattern23 <
ui_type = "combo";
ui_label = "Pattern Type";
ui_items =  "Linear\0Vertical Stripes\0Horizontal Stripes\0Squares\0";
> = 3;
uniform int Width23 <
ui_type = "slider";
ui_label = "Width";
ui_min = 1; ui_max = 10;
ui_step = 1;
> = 1;
uniform float4 Color3 <
ui_type = "color";
ui_label = "Color 3";
> = float4(1.0, 0.16, 0.10, 1.0);
uniform int Pattern34 <
ui_type = "combo";
ui_label = "Pattern Type";
ui_items =  "Linear\0Vertical Stripes\0Horizontal Stripes\0Squares\0";
> = 2;
uniform int Width34 <
ui_type = "slider";
ui_label = "Width";
ui_min = 1; ui_max = 10;
ui_step = 1;
> = 1;
uniform float4 Color4 <
ui_type = "color";
ui_label = "Color 4";
> = float4(1.0, 1.0, 1.0, 1.0);
uniform float fUIStrength <
ui_type = "slider";
ui_label = "Effect Strength";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.01;
> = 1.0;
#line 71
float3 MultiTonePoster_PS(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target {
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
float luma = dot(color, float3(0.2126, 0.7151, 0.0721));
static const int numColors = 7;
float4 colors[numColors];
#line 77
float stripeFactor[12] = {
0.5,
step(vpos.x % (Width12*2), Width12),
step(vpos.y % (Width12*2), Width12),
0.0,
#line 83
0.5,
step(vpos.x % (Width23*2), Width23),
step(vpos.y % (Width23*2), Width23),
0.0,
#line 88
0.5,
step(vpos.x % (Width34*2), Width34),
step(vpos.y % (Width34*2), Width34),
0.0
};
#line 94
stripeFactor[3] = step(stripeFactor[1] + stripeFactor[2], 0.0);
stripeFactor[7] = step(stripeFactor[5] + stripeFactor[6], 0.0);
stripeFactor[11] = step(stripeFactor[9] + stripeFactor[10], 0.0);
#line 98
colors = {
Color1,
0.0.rrrr,
Color2,
0.0.rrrr,
Color3,
0.0.rrrr,
Color4
};
#line 108
colors[1] = lerp(colors[0], colors[2], stripeFactor[Pattern12]);
colors[3] = lerp(colors[2], colors[4], stripeFactor[Pattern23 + 4]);
colors[5] = lerp(colors[4], colors[6], stripeFactor[Pattern34 + 8]);
#line 112
colors[0] = lerp(color, colors[0].rgb, colors[0].w);
colors[1] = lerp(color, colors[1].rgb, (colors[0].w + colors[2].w) / 2.0);
colors[2] = lerp(color, colors[2].rgb, colors[2].w);
colors[3] = lerp(color, colors[3].rgb, (colors[2].w + colors[4].w) / 2.0);
colors[4] = lerp(color, colors[4].rgb, colors[4].w);
colors[5] = lerp(color, colors[5].rgb, (colors[4].w + colors[6].w) / 2.0);
colors[6] = lerp(color, colors[6].rgb, colors[6].w);
#line 121
const float3 outcolor = lerp(color, colors[(int)floor(luma * numColors)].rgb, fUIStrength);
return outcolor + TriDither(outcolor, texcoord, 8);
#line 126
}
#line 128
technique MultiTonePoster {
pass {
VertexShader = PostProcessVS;
PixelShader = MultiTonePoster_PS;
#line 133
}
}
