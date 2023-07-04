#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FlexibleCA.fx"
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
#line 3 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FlexibleCA.fx"
#line 13
uniform int Mode
<
ui_type = "combo";
ui_text =
"How to use:\n"
"\n"
"First, choose what kind of chromatic aberration you wish to use by "
"setting the Mode. Check it's description for details.\n"
"\n"
"Secondly, define the Ratio. This controls the chromatic aberration's "
"\"colors\".\n"
"\n"
"Finally, set how large the chromatic aberration will be by setting "
"the Multiplier.\n"
" ";
ui_tooltip =
"Mode defining how the chromatic aberration is created.\n"
"\n"
"  Translate:\n"
"    Move channels horizontally and vertically.\n"
"\n"
"  Scale:\n"
"    Zoom channels from the center.\n"
"\n"
"Default: Scale";
ui_items = "Translate\0Scale\0";
> = 1;
#line 41
uniform float3 Ratio
<
ui_type = "slider";
ui_tooltip =
"Ratio of how each channel is distorted.\n"
"The values control the red, green and blue channels respectively.\n"
"\n"
"Default: -1.0 0.0 1.0";
ui_min = -1.0;
ui_max = 1.0;
> = float3(-1.0, 0.0, 1.0);
#line 53
uniform float Multiplier
<
ui_type = "slider";
ui_tooltip =
"Multiplier of the ratio, defining how much distortion there is.\n"
"\n"
"Default: 1.0";
ui_min = 0.0;
ui_max = 6.0;
ui_step = 0.001;
> = 1.0;
#line 69
float2 scale_uv(float2 uv, float2 scale, float2 center)
{
return (uv - center) * scale + center;
}
#line 78
float4 MainPS(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET
{
const float2 ps = ReShade:: GetPixelSize();
#line 82
float2 uv_r = uv;
float2 uv_g = uv;
float2 uv_b = uv;
#line 86
float3 ratio;
#line 88
switch (Mode)
{
case 0: 
ratio = Ratio * Multiplier;
#line 93
uv_r += ps * ratio.r;
uv_g += ps * ratio.g;
uv_b += ps * ratio.b;
break;
case 1: 
ratio = Multiplier * length(ps) + 1.0;
ratio = lerp(ratio, 1.0 / ratio, Ratio * 0.5 + 0.5);
#line 101
uv_r = scale_uv(uv_r, ratio.r, 0.5);
uv_g = scale_uv(uv_g, ratio.g, 0.5);
uv_b = scale_uv(uv_b, ratio.b, 0.5);
break;
}
#line 107
const float3 color = float3(
tex2D(ReShade::BackBuffer, uv_r).r,
tex2D(ReShade::BackBuffer, uv_g).g,
tex2D(ReShade::BackBuffer, uv_b).b);
#line 115
return float4(color, 1.0);
#line 117
}
#line 123
technique FlexibleCA
{
pass
{
VertexShader = PostProcessVS;
PixelShader = MainPS;
}
}

