#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MC_Tonemap.fx"
#line 25
uniform float Contrast <
ui_type = "slider";
ui_min = 1.0; ui_max = 16.0; ui_step = 0.01;
ui_tooltip = "Increases contrast in the middle of the visible brightness range at the expense of shadows and highlights.";
ui_label = "Contrast";
> = 1.0;
#line 32
uniform float Compression <
ui_type = "slider";
ui_min = 0.001; ui_max = 16.0; ui_step = 0.01;
ui_tooltip = "Compress highlights";
ui_label = "Compression";
> = 0.00001;
#line 39
uniform float BlackLevel <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0; ui_step = 0.0025;
ui_tooltip = "Subtract this value from final result to compensate for monitor's diffuse reflection";
ui_label = "Black Level";
> = 0.0;
#line 46
uniform bool DeGamma <
ui_label = "DeGamma";
ui_tooltip = "Assume that colors are stored in gamma space";
> = false;
#line 51
uniform float Exposure <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0; ui_step = 0.025;
ui_tooltip = "Exposure";
ui_label = "Exposure";
> = 1.0;
#line 58
uniform float SaturationLuma <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0; ui_step = 0.1;
ui_tooltip = "Saturation (luma)";
ui_label = "Use compression based on luma instead of per-color (increases saturation, gives cartoony look)";
> = 0.0;
#line 65
uniform float Saturation <
ui_type = "slider";
ui_min = 0.0; ui_max = 4.0; ui_step = 0.1;
ui_tooltip = "Saturation";
> = 1.0;
#line 71
uniform int LumaCoefs <
ui_type = "combo";
ui_label = "Luma coefficients for saturation calculation";
ui_items = "Equal (0.33,0.33,0.33)\0Rod cell (0.0,0.59,0.41)\0sRGB (0.2126, 0.7152, 0.0722)\0";
> = 2;
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
#line 77 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MC_Tonemap.fx"
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
#line 80 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MC_Tonemap.fx"
#line 83
float3 MadCakeToneMapPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 luma;
switch(LumaCoefs)
{
case 0:
luma = float3(0.33, 0.33, 0.33);
break;
case 1:
luma = float3(0.0, 0.59, 0.41);
break;
default:
luma = float3(0.2126, 0.7152, 0.0722);
break;
}
#line 99
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 101
if (DeGamma)
{
color.rgb = pow(max(color.rgb, 0.0), 0.45454545);
}
#line 106
color = color * Exposure;
#line 108
const float r = 1.0 / Compression;
const float a_mid = pow(0.5, Contrast - (Contrast - 1.0) * 0.5);
const float r_fix = - (a_mid * r) / (-1.0 + a_mid - r + 2 * a_mid * r);
#line 112
color.rgb = max(color.rgb, 0); 
float4 color2 = float4(color.rgb, dot(color.rgb, luma));
color.r = pow(color.r, Contrast - (Contrast - 1.0) * color.r) * (r_fix + 1.0) / (color.r + r_fix);
color.g = pow(color.g, Contrast - (Contrast - 1.0) * color.g) * (r_fix + 1.0) / (color.g + r_fix);
color.b = pow(color.b, Contrast - (Contrast - 1.0) * color.b) * (r_fix + 1.0) / (color.b + r_fix);
color2.rgb = pow(color2.rgb, Contrast - (Contrast - 1.0) * color2.w) * (r_fix + 1.0) / (color2.w + r_fix);
#line 119
color += (color2.rgb - color) * SaturationLuma;
color += (dot(color, luma) - color) * (1.0 - Saturation);
#line 122
color.rgb = color.rgb - BlackLevel;
if (DeGamma)
{
color.rgb = pow(max(color.rgb, 0.0), 2.2);
}
#line 129
return color + TriDither(color, texcoord, 8);
#line 133
}
#line 135
technique MC_ToneMap
{
pass
{
VertexShader = PostProcessVS;
PixelShader = MadCakeToneMapPass;
}
}

