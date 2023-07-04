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
#line 62 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorInversion.fx"
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
#line 113
return inversion;
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

