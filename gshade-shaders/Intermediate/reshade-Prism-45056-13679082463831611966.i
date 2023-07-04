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
float GetAspectRatio() { return 1280 * (1.0 / 720); }
float2 GetPixelSize() { return float2((1.0 / 1280), (1.0 / 720)); }
float2 GetScreenSize() { return float2(1280, 720); }
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
#line 54 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Prism.fx"
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
RadialCoord.x *=  (1280 * (1.0 / 720));
#line 97
const float Mask = pow(2.0 * length(RadialCoord) * rsqrt( (1280 * (1.0 / 720)) *  (1280 * (1.0 / 720)) + 1.0), Curve);
#line 99
const float OffsetBase = Mask * Aberration * (1.0 / 720) * 2.0;
#line 102
if(abs(OffsetBase) < (1.0 / 720))
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
Position.x /=  (1280 * (1.0 / 720));
#line 116
Position += 0.5;
#line 119
BluredImage += Spectrum(Progress) * tex2Dlod(SamplerColor, float4(Position, 0.0, 0.0)).rgb;
}
BluredImage *= 2.0 * Sample;
}
#line 125
BluredImage += TriDither(BluredImage, texcoord, 8);
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

