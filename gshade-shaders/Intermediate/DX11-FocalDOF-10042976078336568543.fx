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
#line 175
return log(color);
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

