#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FlexibleCA.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1500 * (1.0 / 1004); }
float2 GetPixelSize() { return float2((1.0 / 1500), (1.0 / 1004)); }
float2 GetScreenSize() { return float2(1500, 1004); }
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
#line 6 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FlexibleCA.fx"
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
#line 113
return float4(color + TriDither(color, uv, 8), 1.0);
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

