#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicPass.fx"
#line 8
uniform float Strength <
ui_type = "slider";
ui_min = 0.05; ui_max = 1.5;
ui_toolip = "Strength of the color curve altering";
> = 0.85;
#line 14
uniform float Fade <
ui_type = "slider";
ui_min = 0.0; ui_max = 0.6;
ui_tooltip = "Decreases contrast to imitate faded image";
> = 0.4;
uniform float Contrast <
ui_type = "slider";
ui_min = 0.5; ui_max = 2.0;
> = 1.0;
uniform float Linearization <
ui_type = "slider";
ui_min = 0.5; ui_max = 2.0;
> = 0.5;
uniform float Bleach <
ui_type = "slider";
ui_min = -0.5; ui_max = 1.0;
ui_tooltip = "More bleach means more contrasted and less colorful image";
> = 0.0;
uniform float Saturation <
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
> = -0.15;
#line 37
uniform float RedCurve <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
> = 1.0;
uniform float GreenCurve <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
> = 1.0;
uniform float BlueCurve <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
> = 1.0;
uniform float BaseCurve <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
> = 1.5;
#line 54
uniform float BaseGamma <
ui_type = "slider";
ui_min = 0.7; ui_max = 2.0;
ui_tooltip = "Gamma Curve";
> = 1.0;
uniform float EffectGamma <
ui_type = "slider";
ui_min = 0.0001; ui_max = 2.0;
> = 0.65;
uniform float EffectGammaR <
ui_type = "slider";
ui_min = 0.0001; ui_max = 2.0;
> = 1.0;
uniform float EffectGammaG <
ui_type = "slider";
ui_min = 0.0001; ui_max = 2.0;
> = 1.0;
uniform float EffectGammaB <
ui_type = "slider";
ui_min = 0.0001; ui_max = 2.0;
> = 1.0;
#line 76
uniform float3 LumCoeff <
> = float3(0.212656, 0.715158, 0.072186);
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1024 * (1.0 / 768); }
float2 GetPixelSize() { return float2((1.0 / 1024), (1.0 / 768)); }
float2 GetScreenSize() { return float2(1024, 768); }
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
#line 79 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicPass.fx"
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
#line 82 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmicPass.fx"
#line 85
float3 FilmPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 B = lerp(0.01, pow(saturate(tex2D(ReShade::BackBuffer, texcoord).rgb), Linearization), Contrast);
#line 89
float3 D = dot(B.rgb, LumCoeff);
#line 91
B = pow(abs(B), 1.0 / BaseGamma);
#line 93
const float y = 1.0 / (1.0 + exp(RedCurve / 2.0));
const float z = 1.0 / (1.0 + exp(GreenCurve / 2.0));
const float w = 1.0 / (1.0 + exp(BlueCurve / 2.0));
const float v = 1.0 / (1.0 + exp(BaseCurve / 2.0));
#line 98
float3 C = B;
#line 100
D.r = (1.0 / (1.0 + exp(-RedCurve * (D.r - 0.5))) - y) / (1.0 - 2.0 * y);
D.g = (1.0 / (1.0 + exp(-GreenCurve * (D.g - 0.5))) - z) / (1.0 - 2.0 * z);
D.b = (1.0 / (1.0 + exp(-BlueCurve * (D.b - 0.5))) - w) / (1.0 - 2.0 * w);
#line 104
D = pow(abs(D), 1.0 / EffectGamma);
#line 106
D = lerp(D, 1.0 - D, Bleach);
#line 108
D.r = pow(abs(D.r), 1.0 / EffectGammaR);
D.g = pow(abs(D.g), 1.0 / EffectGammaG);
D.b = pow(abs(D.b), 1.0 / EffectGammaB);
#line 112
if (D.r < 0.5)
C.r = (2.0 * D.r - 1.0) * (B.r - B.r * B.r) + B.r;
else
C.r = (2.0 * D.r - 1.0) * (sqrt(B.r) - B.r) + B.r;
#line 117
if (D.g < 0.5)
C.g = (2.0 * D.g - 1.0) * (B.g - B.g * B.g) + B.g;
else
C.g = (2.0 * D.g - 1.0) * (sqrt(B.g) - B.g) + B.g;
#line 122
if (D.b < 0.5)
C.b = (2.0 * D.b - 1.0) * (B.b - B.b * B.b) + B.b;
else
C.b = (2.0 * D.b - 1.0) * (sqrt(B.b) - B.b) + B.b;
#line 127
float3 F = (1.0 / (1.0 + exp(-BaseCurve * (lerp(B, C, Strength) - 0.5))) - v) / (1.0 - 2.0 * v);
#line 129
const float3 iF = F;
#line 131
F.r = (iF.r * (1.0 - Saturation) + iF.g * (0.0 + Saturation) + iF.b * Saturation);
F.g = (iF.r * Saturation + iF.g * ((1.0 - Fade) - Saturation) + iF.b * (Fade + Saturation));
F.b = (iF.r * Saturation + iF.g * (Fade + Saturation) + iF.b * ((1.0 - Fade) - Saturation));
#line 135
const float N = dot(F.rgb, LumCoeff);
#line 137
float3 Cn;
if (N < 0.5)
Cn = (2.0 * N - 1.0) * (F - F * F) + F;
else
Cn = (2.0 * N - 1.0) * (sqrt(F) - F) + F;
#line 144
Cn = lerp(B, pow(max(Cn,0), 1.0 / Linearization), Strength);
return Cn + TriDither(Cn, texcoord, 8);
#line 149
}
#line 151
technique FilmicPass
{
pass
{
VertexShader = PostProcessVS;
PixelShader = FilmPass;
}
}

