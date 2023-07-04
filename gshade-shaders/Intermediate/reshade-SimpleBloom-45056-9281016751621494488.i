#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SimpleBloom.fx"
#line 16
uniform float BlurMultiplier <
ui_type = "slider";
ui_label = "Radius";
ui_min = 1; ui_max = 16; ui_step = 0.01;
> = 1.23;
#line 22
uniform float2 Blend <
ui_type = "slider";
ui_min = 0; ui_max = 1; ui_step = 0.001;
> = float2(0.0, 0.8);
#line 27
uniform bool Debug <
> = false;
#line 31
texture SimpleBloomTarget
{
#line 34
Width = 1281 * 0.25;
Height = 721 * 0.25;
Format = RGBA8;
};
#line 47
sampler SimpleBloomSampler { Texture = SimpleBloomTarget; };
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1281 * (1.0 / 721); }
float2 GetPixelSize() { return float2((1.0 / 1281), (1.0 / 721)); }
float2 GetScreenSize() { return float2(1281, 721); }
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
#line 53 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SimpleBloom.fx"
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
#line 56 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SimpleBloom.fx"
#line 59
void BloomHorizontalPass(float4 vpos : SV_Position, float2 UvCoord : TEXCOORD,
out float3 Target : SV_Target)
{
const float Weight[11] =
{
0.082607,
0.080977,
0.076276,
0.069041,
0.060049,
0.050187,
0.040306,
0.031105,
0.023066,
0.016436,
0.011254
};
#line 77
Target.rgb = tex2D(ReShade::BackBuffer, UvCoord).rgb;
const float UvOffset =  float2((1.0 / 1281), (1.0 / 721)).x * BlurMultiplier;
Target.rgb *= Weight[0];
for (int i = 1; i < 11; i++)
{
float SampleOffset = i * UvOffset;
Target.rgb +=
max(
Target.rgb,
max(
tex2Dlod(ReShade::BackBuffer, float4(UvCoord.xy + float2(SampleOffset, 0), 0, 0)).rgb
, tex2Dlod(ReShade::BackBuffer, float4(UvCoord.xy - float2(SampleOffset, 0), 0, 0)).rgb
)
) * Weight[i];
}
}
#line 94
void SimpleBloomPS(float4 vpos : SV_Position, float2 UvCoord : TEXCOORD,
out float3 Image : SV_Target)
{
const float Weight[11] =
{
0.082607,
0.080977,
0.076276,
0.069041,
0.060049,
0.050187,
0.040306,
0.031105,
0.023066,
0.016436,
0.011254
};
#line 112
float3 Target = tex2D(SimpleBloomSampler, UvCoord).rgb;
#line 114
const float UvOffset =  float2((1.0 / 1281), (1.0 / 721)).y * BlurMultiplier;
Target.rgb *= Weight[0];
for (int i = 1; i < 11; i++)
{
float SampleOffset = i * UvOffset;
Target.rgb +=
max(
Target.rgb,
max(
tex2Dlod(SimpleBloomSampler, float4(UvCoord.xy + float2(0, SampleOffset), 0, 0)).rgb
, tex2Dlod(SimpleBloomSampler, float4(UvCoord.xy - float2(0, SampleOffset), 0, 0)).rgb
)
) * Weight[i];
}
#line 129
Image = tex2D(ReShade::BackBuffer, UvCoord).rgb;
#line 132
Target = max(Target - Image, Blend.x) - Blend.x;
Target /= 1 - min(0.999, Blend.x);
#line 136
Target *= Blend.y;
#line 138
Image = 1 - (1 - Image) * (1 - Target); 
#line 140
if (Debug)
Image = Target;
#line 144
Image += TriDither(Image, UvCoord, 8);
#line 146
}
#line 152
technique SimpleBloom < ui_label = "Simple Bloom"; >
{
pass
{
VertexShader = PostProcessVS;
PixelShader = BloomHorizontalPass;
RenderTarget = SimpleBloomTarget;
}
pass
{
VertexShader = PostProcessVS;
PixelShader = SimpleBloomPS;
}
}

