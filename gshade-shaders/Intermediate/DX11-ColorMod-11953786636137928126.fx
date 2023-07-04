#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorMod.fx"
#line 7
uniform float ColormodChroma <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Saturation";
ui_tooltip = "Amount of saturation";
> = 0.780;
#line 14
uniform float ColormodGammaR <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Gamma for Red";
ui_tooltip = "Gamma for Red";
> = 1.0;
uniform float ColormodGammaG <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Gamma for Green";
ui_tooltip = "Gamma for Green";
> = 1.0;
uniform float ColormodGammaB <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Gamma for Blue";
ui_tooltip = "Gamma for Blue";
> = 1.0;
#line 33
uniform float ColormodContrastR <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Contrast for Red";
ui_tooltip = "Contrast for Red";
> = 0.50;
uniform float ColormodContrastG <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Contrast for Green";
ui_tooltip = "Contrast for Green";
> = 0.50;
uniform float ColormodContrastB <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Contrast for Blue";
ui_tooltip = "Contrast for Blue";
> = 0.50;
#line 52
uniform float ColormodBrightnessR <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Brightness for Red";
ui_tooltip = "Brightness for Red";
> = -0.08;
uniform float ColormodBrightnessG <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Brightness for Green";
ui_tooltip = "Brightness for Green";
> = -0.08;
uniform float ColormodBrightnessB <
ui_type = "slider";
ui_min = -1.0; ui_max = 2.0;
ui_label = "Brightness for Blue";
ui_tooltip = "Brightness for Blue";
> = -0.08;
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
#line 76 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorMod.fx"
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
#line 79 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorMod.fx"
#line 82
float3 ColorModPass(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 86
color.xyz = (color.xyz - dot(color.xyz, 0.333)) * ColormodChroma + dot(color.xyz, 0.333);
color.xyz = saturate(color.xyz);
color.x = (pow(color.x, ColormodGammaR) - 0.5) * ColormodContrastR + 0.5 + ColormodBrightnessR;
color.y = (pow(color.y, ColormodGammaG) - 0.5) * ColormodContrastG + 0.5 + ColormodBrightnessB;
color.z = (pow(color.z, ColormodGammaB) - 0.5) * ColormodContrastB + 0.5 + ColormodBrightnessB;
#line 92
return color + TriDither(color, texcoord, 8);
#line 96
}
#line 99
technique ColorMod
{
pass
{
VertexShader = PostProcessVS;
PixelShader = ColorModPass;
}
}

