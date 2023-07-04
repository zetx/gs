#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Technicolor.fx"
#line 8
uniform float Power <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
> = 4.0;
uniform float3 RGBNegativeAmount <
ui_type = "color";
> = float3(0.88, 0.88, 0.88);
#line 16
uniform float Strength <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Adjust the strength of the effect.";
> = 0.4;
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
#line 22 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Technicolor.fx"
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
#line 25 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Technicolor.fx"
#line 28
float3 TechnicolorPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 cyanfilter = float3(0.0, 1.30, 1.0);
const float3 magentafilter = float3(1.0, 0.0, 1.05);
const float3 yellowfilter = float3(1.6, 1.6, 0.05);
const float2 redorangefilter = float2(1.05, 0.620); 
const float2 greenfilter = float2(0.30, 1.0);       
const float2 magentafilter2 = magentafilter.rb;     
#line 37
const float3 tcol = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 39
const float2 negative_mul_r = tcol.rg * (1.0 / (RGBNegativeAmount.r * Power));
const float2 negative_mul_g = tcol.rg * (1.0 / (RGBNegativeAmount.g * Power));
const float2 negative_mul_b = tcol.rb * (1.0 / (RGBNegativeAmount.b * Power));
const float3 output_r = dot(redorangefilter, negative_mul_r).xxx + cyanfilter;
const float3 output_g = dot(greenfilter, negative_mul_g).xxx + magentafilter;
const float3 output_b = dot(magentafilter2, negative_mul_b).xxx + yellowfilter;
#line 47
const float3 outcolor = lerp(tcol, output_r * output_g * output_b, Strength);
return outcolor + TriDither(outcolor, texcoord, 8);
#line 52
}
#line 54
technique Technicolor
{
pass
{
VertexShader = PostProcessVS;
PixelShader = TechnicolorPass;
}
}

