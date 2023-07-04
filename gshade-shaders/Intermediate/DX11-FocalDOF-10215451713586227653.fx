#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FocalDOF.fx"
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
#line 3 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FocalDOF.fx"
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
#line 6 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FocalDOF.fx"
#line 21
uniform float DofScale
<
ui_type = "slider";
ui_label = "Scale";
ui_tooltip =
"If this is empty, nag @luluco250 in the ReShade Discord channel.\n"
"\nDefault: 3.0";
ui_category = "Appearance";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.001;
> = 3.0;
#line 34
uniform float FocusTime
<
ui_type = "slider";
ui_label = "Time";
ui_tooltip =
"If this is empty, nag @luluco250 in the ReShade Discord channel.\n"
"\nDefault: 350.0";
ui_category = "Focus";
ui_min = 0.0;
ui_max = 2000.0;
ui_step = 10.0;
> = 350.0;
#line 47
uniform float2 FocusPoint
<
ui_type = "slider";
ui_label = "Point";
ui_tooltip =
"If this is empty, nag @luluco250 in the ReShade Discord channel.\n"
"\nDefault: 0.5 0.5";
ui_category = "Focus";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = float2(0.5, 0.5);
#line 60
uniform float FrameTime <source = "frametime";>;
#line 78
texture FocalDOF_Focus { Format = R32F; };
sampler Focus { Texture = FocalDOF_Focus; };
#line 81
texture FocalDOF_LastFocus { Format = R32F; };
sampler LastFocus { Texture = FocalDOF_LastFocus; };
#line 88
void GetFocusVS(
uint id : SV_VERTEXID,
out float4 p : SV_POSITION,
out float2 uv : TEXCOORD0,
out float focus : TEXCOORD1)
{
PostProcessVS(id, p, uv);
#line 99
focus = 0.0;
#line 101
}
#line 103
void ReadFocusVS(
uint id : SV_VERTEXID,
out float4 p : SV_POSITION,
out float2 uv : TEXCOORD0,
out float focus : TEXCOORD1)
{
PostProcessVS(id, p, uv);
#line 114
focus = 0.0;
#line 116
}
#line 118
float4 GetFocusPS(
float4 p : SV_POSITION,
float2 uv : TEXCOORD0,
float focus : TEXCOORD1) : SV_TARGET
{
#line 124
return saturate(lerp(tex2Dfetch(LastFocus, float2(0, 0), 0).x, ReShade::GetLinearizedDepth(FocusPoint), FrameTime / FocusTime));
#line 128
}
#line 130
float4 SaveFocusPS(
float4 p : SV_POSITION,
float2 uv : TEXCOORD0,
float focus : TEXCOORD1) : SV_TARGET
{
#line 136
return tex2Dfetch(Focus, float2(0, 0), 0).x;
#line 140
}
#line 142
float4 MainPS(
float4 p : SV_POSITION,
float2 uv : TEXCOORD0,
float focus : TEXCOORD1) : SV_TARGET
{
#line 150
static const float2 offsets[] =
{
float2(0.0, 1.0),
float2(0.75, 0.75),
float2(1.0, 0.0),
float2(0.75, -0.75),
float2(0.0, -1.0),
float2(-0.75, -0.75),
float2(-1.0, 0.0),
float2(-0.75, 0.75)
};
#line 162
float4 color =  exp(tex2D( ReShade::BackBuffer, uv + ReShade:: GetPixelSize() * 0.0 * (abs(ReShade::GetLinearizedDepth(uv) - focus) * DofScale)));
#line 164
[unroll]
for (int i = 0; i < 8; ++i)
color +=  exp(tex2D( ReShade::BackBuffer, uv + ReShade:: GetPixelSize() * offsets[i] * (abs(ReShade::GetLinearizedDepth(uv) - focus) * DofScale)));
color /= 9;
#line 172
color = log(color);
return float4(color.rgb + TriDither(color.rgb, uv, 8), color.a);
#line 177
}
#line 183
technique FocalDOF
{
pass GetFocus
{
VertexShader = GetFocusVS;
PixelShader = GetFocusPS;
RenderTarget = FocalDOF_Focus;
}
pass SaveFocus
{
VertexShader = ReadFocusVS;
PixelShader = SaveFocusPS;
RenderTarget = FocalDOF_LastFocus;
}
pass Main
{
VertexShader = ReadFocusVS;
PixelShader = MainPS;
#line 205
}
}

