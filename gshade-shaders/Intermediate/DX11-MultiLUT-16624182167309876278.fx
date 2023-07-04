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
#line 117
ui_items = "Neutral\0Darklite (Realism, Day, Outdoors)\0Shadownite (Realism, Night, Indoors)\0Ambient Memories (Bright, Warm)\0Faded Memories (Desaturated, Dark)\0Pastel Memories (Cartoony, Colorful, Bright)\0Nostalgic \ Radiance (Bright, Colorful, Studio, Lights)\0";
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
texture texMultiLUT < source =   "FFXIVLUTAtlas.png" ; > { Width =  32 *  32; Height =  32 *   17; Format = RGBA8; };
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

