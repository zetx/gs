#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Prism.fx"
#line 20
uniform int Aberration <
ui_label = "Aberration scale in pixels";
ui_type = "slider";
ui_min = -48; ui_max = 48;
> = 6;
#line 26
uniform float Curve <
ui_label = "Aberration curve";
ui_type = "slider";
ui_min = 0.0; ui_max = 4.0; ui_step = 0.01;
> = 1.0;
#line 32
uniform bool Automatic <
ui_label = "Automatic sample count";
ui_tooltip = "Amount of samples will be adjusted automatically";
ui_category = "Performance";
ui_category_closed = true;
> = true;
#line 39
uniform int SampleCount <
ui_label = "Samples";
ui_tooltip = "Amount of samples (only even numbers are accepted, odd numbers will be clamped)";
ui_type = "slider";
ui_min = 6; ui_max = 32;
ui_category = "Performance";
> = 8;
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
#line 51 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Prism.fx"
#line 58
float3 Spectrum(float Hue)
{
float3 HueColor;
Hue *= 4.0;
HueColor.rg = Hue-float2(1.0, 2.0);
HueColor.rg = saturate(1.5-abs(HueColor.rg));
HueColor.r += saturate(Hue-3.5);
HueColor.b = 1.0-HueColor.r;
return HueColor;
}
#line 70
sampler SamplerColor
{
Texture = ReShade::BackBufferTex;
AddressU = MIRROR;
AddressV = MIRROR;
#line 76
SRGBTexture = true;
#line 78
};
#line 80
void ChromaticAberrationPS(float4 vois : SV_Position, float2 texcoord : TexCoord, out float3 BluredImage : SV_Target)
{
#line 83
float Samples;
if (Automatic)
Samples = clamp(2.0 * ceil(abs(Aberration) * 0.5) + 2.0, 6.0, 48.0); 
else
Samples = floor(SampleCount * 0.5) * 2.0; 
#line 90
const float Sample = 1.0 / Samples;
#line 93
float2 RadialCoord = texcoord - 0.5;
RadialCoord.x *=  (3440 * (1.0 / 1440));
#line 97
const float Mask = pow(2.0 * length(RadialCoord) * rsqrt( (3440 * (1.0 / 1440)) *  (3440 * (1.0 / 1440)) + 1.0), Curve);
#line 99
const float OffsetBase = Mask * Aberration * (1.0 / 1440) * 2.0;
#line 102
if(abs(OffsetBase) < (1.0 / 1440))
BluredImage = tex2D(SamplerColor, texcoord).rgb;
else
{
BluredImage = 0.0;
for (float P = 0.0; P < Samples; P++)
{
float Progress = P * Sample;
#line 112
float2 Position = RadialCoord / (OffsetBase * (Progress - 0.5) + 1.0);
#line 114
Position.x /=  (3440 * (1.0 / 1440));
#line 116
Position += 0.5;
#line 119
BluredImage += Spectrum(Progress) * tex2Dlod(SamplerColor, float4(Position, 0.0, 0.0)).rgb;
}
BluredImage *= 2.0 * Sample;
}
#line 127
}
#line 134
technique ChromaticAberration < ui_label = "Chromatic Aberration"; >
{
pass
{
VertexShader = PostProcessVS;
PixelShader = ChromaticAberrationPS;
SRGBWriteEnable = true;
}
}

