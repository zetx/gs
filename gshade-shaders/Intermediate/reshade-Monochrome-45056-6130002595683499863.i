#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Monochrome.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1799 * (1.0 / 998); }
float2 GetPixelSize() { return float2((1.0 / 1799), (1.0 / 998)); }
float2 GetScreenSize() { return float2(1799, 998); }
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
#line 41 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Monochrome.fx"
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
#line 44 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Monochrome.fx"
#line 47
uniform int Monochrome_preset <
ui_type = "combo";
ui_label = "Preset";
ui_tooltip = "Choose a preset";
#line 52
ui_items = "Custom\0"
"Monitor or modern TV\0"
"Equal weight\0"
"Agfa 200X\0"
"Agfapan 25\0"
"Agfapan 100\0"
"Agfapan 400\0"
"Ilford Delta 100\0"
"Ilford Delta 400\0"
"Ilford Delta 400 Pro & 3200\0"
"Ilford FP4\0"
"Ilford HP5\0"
"Ilford Pan F\0"
"Ilford SFX\0"
"Ilford XP2 Super\0"
"Kodak Tmax 100\0"
"Kodak Tmax 400\0"
"Kodak Tri-X\0";
> = 0;
#line 72
uniform float3 Monochrome_conversion_values <
ui_type = "color";
ui_label = "Custom Conversion values";
> = float3(0.21, 0.72, 0.07);
#line 84
uniform float Monochrome_color_saturation <
ui_label = "Saturation";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.0;
#line 90
float3 MonochromePass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 94
float3 Coefficients = float3(0.21, 0.72, 0.07);
#line 96
const float3 Coefficients_array[18] =
{
Monochrome_conversion_values, 
float3(0.21, 0.72, 0.07), 
float3(0.3333333, 0.3333334, 0.3333333), 
float3(0.18, 0.41, 0.41), 
float3(0.25, 0.39, 0.36), 
float3(0.21, 0.40, 0.39), 
float3(0.20, 0.41, 0.39), 
float3(0.21, 0.42, 0.37), 
float3(0.22, 0.42, 0.36), 
float3(0.31, 0.36, 0.33), 
float3(0.28, 0.41, 0.31), 
float3(0.23, 0.37, 0.40), 
float3(0.33, 0.36, 0.31), 
float3(0.36, 0.31, 0.33), 
float3(0.21, 0.42, 0.37), 
float3(0.24, 0.37, 0.39), 
float3(0.27, 0.36, 0.37), 
float3(0.25, 0.35, 0.40) 
};
#line 118
Coefficients = Coefficients_array[Monochrome_preset];
#line 121
const float3 grey = dot(Coefficients, color);
#line 125
Coefficients = saturate(lerp(grey, color, Monochrome_color_saturation));
return Coefficients + TriDither(Coefficients, texcoord, 8);
#line 130
}
#line 132
technique Monochrome
{
pass
{
VertexShader = PostProcessVS;
PixelShader = MonochromePass;
}
}

