#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MultiLUT.fx"
#line 92
uniform int fLUT_MultiLUTSelector <
ui_category = "Pass 1";
ui_type = "combo";
ui_items = "GShade [Angelite-Compatible]\0ReShade 4\0ReShade 3\0Johto\0Espresso Glow\0Faeshade/Dark Veil/HQ Shade/MoogleShade\0ninjafada Gameplay\0seri14\0Yomi\0Neneko\0Yaes\0Ipsusu\0Nightingale\0";
ui_label = "The MultiLUT file to use.";
ui_tooltip = "Set this to whatever build your preset was made with!";
ui_bind = "MultiLUTTexture_Source";
> = 0;
#line 107
uniform int fLUT_LutSelector <
ui_category = "Pass 1";
ui_type = "combo";
#line 111
ui_items = "Color0\0Color1\0Color2\0Color3\0Color4\0Color5\0Color6\0Color7\0Color8\0Sepia\0Color10\0Color11\0Cross process\0Azure Red Dual Tone\0Sepia\0\B&W mid constrast\0\B&W high contrast\0";
#line 137
ui_label = "LUT to use.";
ui_tooltip = "LUT to use for color transformation. ReShade 4's 'Neutral' doesn't do any color transformation.";
> = 0;
#line 141
uniform float fLUT_Intensity <
ui_category = "Pass 1";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Intensity";
ui_tooltip = "Overall intensity of the LUT effect.";
> = 1.00;
#line 149
uniform float fLUT_AmountChroma <
ui_category = "Pass 1";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Chroma Amount";
ui_tooltip = "Intensity of color/chroma change of the LUT.";
> = 1.00;
#line 157
uniform float fLUT_AmountLuma <
ui_category = "Pass 1";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Luma Amount";
ui_tooltip = "Intensity of luma change of the LUT.";
> = 1.00;
#line 165
uniform bool fLUT_MultiLUTPass2 <
ui_category = "Pass 2";
ui_label = "Enable Pass 2";
ui_bind = "MultiLUTTexture2";
> = 0;
#line 250
uniform bool fLUT_MultiLUTPass3 <
ui_category = "Pass 3";
ui_label = "Enable Pass 3";
ui_bind = "MultiLUTTexture3";
> = 0;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 5360 * (1.0 / 1440); }
float2 GetPixelSize() { return float2((1.0 / 5360), (1.0 / 1440)); }
float2 GetScreenSize() { return float2(5360, 1440); }
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
#line 339 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MultiLUT.fx"
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
#line 342 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MultiLUT.fx"
#line 459
texture texMultiLUT < source =   "MultiLut_GShade.png" ; > { Width =  32 *  32; Height =  32 *   17; Format = RGBA8; };
sampler SamplerMultiLUT { Texture = texMultiLUT; };
#line 476
float3 apply(in const float3 color, in const int tex, in const float lut)
{
const float2 texelsize = 1.0 / float2( 32 *  32,  32);
float3 lutcoord = float3((color.xy *  32 - color.xy + 0.5) * texelsize, (color.z  *  32 - color.z));
#line 481
const float lerpfact = frac(lutcoord.z);
lutcoord.x += (lutcoord.z - lerpfact) * texelsize.y;
lutcoord.y = lut /   17 + lutcoord.y /   17;
#line 485
return lerp(tex2D(SamplerMultiLUT, lutcoord.xy).xyz, tex2D(SamplerMultiLUT, float2(lutcoord.x + texelsize.y, lutcoord.y)).xyz, lerpfact);
}
#line 516
void PS_MultiLUT_Apply(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float3 res : SV_Target)
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).xyz;
#line 525
const float3 lutcolor = lerp(color, apply(color, fLUT_MultiLUTSelector, fLUT_LutSelector), fLUT_Intensity);
#line 530
res = lerp(normalize(color), normalize(lutcolor), fLUT_AmountChroma)
* lerp(   length(color),    length(lutcolor),   fLUT_AmountLuma);
#line 558
res += TriDither(res, texcoord, 8);
#line 560
}
#line 566
technique MultiLUT
{
pass MultiLUT_Apply
{
VertexShader = PostProcessVS;
PixelShader = PS_MultiLUT_Apply;
}
}

