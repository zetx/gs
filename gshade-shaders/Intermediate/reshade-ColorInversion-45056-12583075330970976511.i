#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorInversion.fx"
#line 32
uniform int nInversionSelector <
ui_type = "combo";
ui_items = "All\0Red\0Green\0Blue\0Red & Green\0Red & Blue\0Green & Blue\0None\0";
ui_label = "The color(s) to invert.";
> = 0;
#line 38
uniform float nInversionRed <
ui_type = "slider";
ui_label = "Red";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 1.0;
#line 46
uniform float nInversionGreen <
ui_type = "slider";
ui_label = "Green";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 1.0;
#line 54
uniform float nInversionBlue <
ui_type = "slider";
ui_label = "Blue";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 1.0;
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
#line 62 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorInversion.fx"
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
#line 65 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorInversion.fx"
#line 68
float3 SV_ColorInversion(float4 pos : SV_Position, float2 col : TEXCOORD) : SV_TARGET
{
float3 inversion = tex2D(ReShade::BackBuffer, col).rgb;
#line 72
inversion.r = inversion.r * nInversionRed;
inversion.g = inversion.g * nInversionGreen;
inversion.b = inversion.b * nInversionBlue;
#line 76
if (nInversionSelector == 0)
{
inversion.r = 1.0f - inversion.r;
inversion.g = 1.0f - inversion.g;
inversion.b = 1.0f - inversion.b;
}
else if (nInversionSelector == 1)
{
inversion.r = 1.0f - inversion.r;
}
else if (nInversionSelector == 2)
{
inversion.g = 1.0f - inversion.g;
}
else if (nInversionSelector == 3)
{
inversion.b = 1.0f - inversion.b;
}
else if (nInversionSelector == 4)
{
inversion.r = 1.0f - inversion.r;
inversion.g = 1.0f - inversion.g;
}
else if (nInversionSelector == 5)
{
inversion.r = 1.0f - inversion.r;
inversion.b = 1.0f - inversion.b;
}
else if (nInversionSelector == 6)
{
inversion.g = 1.0f - inversion.g;
inversion.b = 1.0f - inversion.b;
}
#line 111
return inversion + TriDither(inversion, col, 8);
#line 115
}
#line 117
technique ColorInversion
{
pass
{
VertexShader = PostProcessVS;
PixelShader = SV_ColorInversion;
}
}

