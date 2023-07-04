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
#line 176
uniform int fLUT_MultiLUTSelector2 <
ui_category = "Pass 2";
ui_type = "combo";
ui_items = "GShade [Angelite-Compatible]\0ReShade 4\0ReShade 3\0Johto\0Espresso Glow\0Faeshade/Dark Veil/HQ Shade/MoogleShade\0ninjafada Gameplay\0seri14\0Yomi\0Neneko\0Yaes\0Ipsusu\0Nightingale\0";
ui_label = "The MultiLUT file to use.";
ui_tooltip = "The MultiLUT table to use on Pass 2.";
ui_bind = "MultiLUTTexture2_Source";
> = 1;
#line 191
uniform int fLUT_LutSelector2 <
ui_category = "Pass 2";
ui_type = "combo";
#line 195
ui_items = "Color0\0Color1\0Color2\0Color3\0Color4\0Color5\0Color6\0Color7\0Color8\0Sepia\0Color10\0Color11\0Cross process\0Azure Red Dual Tone\0Sepia\0\B&W mid constrast\0\B&W high contrast\0";
#line 221
ui_label = "LUT to use.";
ui_tooltip = "LUT to use for color transformation on Pass 2. ReShade 4's 'Neutral' doesn't do any color transformation.";
> = 0;
#line 225
uniform float fLUT_Intensity2 <
ui_category = "Pass 2";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Intensity";
ui_tooltip = "Overall intensity of the LUT effect.";
> = 1.00;
#line 233
uniform float fLUT_AmountChroma2 <
ui_category = "Pass 2";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Chroma Amount";
ui_tooltip = "Intensity of color/chroma change of the LUT.";
> = 1.00;
#line 241
uniform float fLUT_AmountLuma2 <
ui_category = "Pass 2";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Luma Amount";
ui_tooltip = "Intensity of luma change of the LUT.";
> = 1.00;
#line 250
uniform bool fLUT_MultiLUTPass3 <
ui_category = "Pass 3";
ui_label = "Enable Pass 3";
ui_bind = "MultiLUTTexture3";
> = 0;
#line 261
uniform int fLUT_MultiLUTSelector3 <
ui_category = "Pass 3";
ui_type = "combo";
ui_items = "GShade [Angelite-Compatible]\0ReShade 4\0ReShade 3\0Johto\0Espresso Glow\0Faeshade/Dark Veil/HQ Shade/MoogleShade\0ninjafada Gameplay\0seri14\0Yomi\0Neneko\0Yaes\0Ipsusu\0Nightingale\0";
ui_label = "The MultiLUT file to use.";
ui_tooltip = "The MultiLUT table to use on Pass 3.";
ui_bind = "MultiLUTTexture3_Source";
> = 1;
#line 276
uniform int fLUT_LutSelector3 <
ui_category = "Pass 3";
ui_type = "combo";
#line 280
ui_items = "Color0\0Color1\0Color2\0Color3\0Color4\0Color5\0Color6\0Color7\0Color8\0Sepia\0Color10\0Color11\0Cross process\0Azure Red Dual Tone\0Sepia\0\B&W mid constrast\0\B&W high contrast\0";
#line 306
ui_label = "LUT to use.";
ui_tooltip = "LUT to use for color transformation on Pass 3. ReShade 4's 'Neutral' doesn't do any color transformation.";
> = 0;
#line 310
uniform float fLUT_Intensity3 <
ui_category = "Pass 3";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Intensity";
ui_tooltip = "Overall intensity of the LUT effect.";
> = 1.00;
#line 318
uniform float fLUT_AmountChroma3 <
ui_category = "Pass 3";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Chroma Amount";
ui_tooltip = "Intensity of color/chroma change of the LUT.";
> = 1.00;
#line 326
uniform float fLUT_AmountLuma3 <
ui_category = "Pass 3";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT Luma Amount";
ui_tooltip = "Intensity of luma change of the LUT.";
> = 1.00;
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
#line 339 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MultiLUT.fx"
#line 459
texture texMultiLUT < source =   "MultiLut_GShade.png" ; > { Width =  32 *  32; Height =  32 *   17; Format = RGBA8; };
sampler SamplerMultiLUT { Texture = texMultiLUT; };
#line 463
texture texMultiLUT2 < source =   "MultiLut_GShade.png" ; > { Width =  32 *  32; Height =  32 *   17; Format = RGBA8; };
sampler SamplerMultiLUT2{ Texture = texMultiLUT2; };
#line 468
texture texMultiLUT3 < source =   "MultiLut_GShade.png" ; > { Width =  32 *  32; Height =  32 *   17; Format = RGBA8; };
sampler SamplerMultiLUT3{ Texture = texMultiLUT3; };
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
#line 489
float3 apply2(in const float3 color, in const int tex, in const float lut)
{
const float2 texelsize = 1.0 / float2( 32 *  32,  32);
float3 lutcoord = float3((color.xy *  32 - color.xy + 0.5) * texelsize, (color.z *  32 - color.z));
#line 494
const float lerpfact = frac(lutcoord.z);
lutcoord.x += (lutcoord.z - lerpfact) * texelsize.y;
lutcoord.y = lut /   17 + lutcoord.y /   17;
#line 498
return lerp(tex2D(SamplerMultiLUT2, lutcoord.xy).xyz, tex2D(SamplerMultiLUT2, float2(lutcoord.x + texelsize.y, lutcoord.y)).xyz, lerpfact);
}
#line 503
float3 apply3(in const float3 color, in const int tex, in const float lut)
{
const float2 texelsize = 1.0 / float2( 32 *  32,  32);
float3 lutcoord = float3((color.xy *  32 - color.xy + 0.5) * texelsize, (color.z *  32 - color.z));
#line 508
const float lerpfact = frac(lutcoord.z);
lutcoord.x += (lutcoord.z - lerpfact) * texelsize.y;
lutcoord.y = lut /   17 + lutcoord.y /   17;
#line 512
return lerp(tex2D(SamplerMultiLUT3, lutcoord.xy).xyz, tex2D(SamplerMultiLUT3, float2(lutcoord.x + texelsize.y, lutcoord.y)).xyz, lerpfact);
}
#line 516
void PS_MultiLUT_Apply(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float3 res : SV_Target)
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).xyz;
#line 527
float3 lutcolor = lerp(color, apply(color, fLUT_MultiLUTSelector, fLUT_LutSelector), fLUT_Intensity);
#line 530
res = lerp(normalize(color), normalize(lutcolor), fLUT_AmountChroma)
* lerp(   length(color),    length(lutcolor),   fLUT_AmountLuma);
#line 538
res = saturate(res);
lutcolor = lerp(res, apply2(res, fLUT_MultiLUTSelector2, fLUT_LutSelector2), fLUT_Intensity2);
#line 541
res = lerp(normalize(res), normalize(lutcolor), fLUT_AmountChroma2)
* lerp(   length(res),    length(lutcolor),   fLUT_AmountLuma2);
#line 550
res = saturate(res);
lutcolor = lerp(res, apply3(res, fLUT_MultiLUTSelector3, fLUT_LutSelector3), fLUT_Intensity3);
#line 553
res = lerp(normalize(res), normalize(lutcolor), fLUT_AmountChroma3)
* lerp(   length(res),    length(lutcolor),   fLUT_AmountLuma3);
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

