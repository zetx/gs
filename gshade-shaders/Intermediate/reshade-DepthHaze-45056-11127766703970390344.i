#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DepthHaze.fx"
#line 15
uniform float EffectStrength <
ui_type = "slider";
ui_min = 0.0; ui_max=1.0;
ui_tooltip = "The strength of the effect. Range from 0.0, which means no effect, till 1.0 which means pixels are 100% blurred based on depth.";
> = 0.9;
uniform float3 FogColor <
ui_type= "color";
ui_tooltip = "Color of the fog, in (red , green, blue)";
> = float3(0.8,0.8,0.8);
uniform float FogStart <
ui_type = "slider";
ui_min = 0.0; ui_max=1.0;
ui_tooltip = "Start of the fog. 0.0 is at the camera, 1.0 is at the horizon, 0.5 is halfway towards the horizon. Before this point no fog will appear.";
> = 0.2;
uniform float FogFactor <
ui_type = "slider";
ui_min = 0.0; ui_max=1.0;
ui_tooltip = "The amount of fog added to the scene. 0.0 is no fog, 1.0 is the strongest fog possible.";
> = 0.2;
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
#line 35 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DepthHaze.fx"
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
#line 38 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DepthHaze.fx"
#line 44
texture   Otis_FragmentBuffer1 	{ Width = 1500; Height = 1004; Format = RGBA8;};
texture   Otis_FragmentBuffer2 	< pooled = true; > { Width = 1500; Height = 1004; Format = RGBA8;};
#line 50
sampler2D Otis_SamplerFragmentBuffer2 { Texture = Otis_FragmentBuffer2; };
sampler2D Otis_SamplerFragmentBuffer1 {	Texture = Otis_FragmentBuffer1; };
#line 56
float CalculateWeight(float distanceFromSource, float sourceDepth, float neighborDepth)
{
return (1.0 - abs(sourceDepth - neighborDepth)) * (1/distanceFromSource) * neighborDepth;
}
#line 61
void PS_Otis_DEH_BlockBlurHorizontal(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD, out float4 outFragment : SV_Target0)
{
float4 color = tex2D(ReShade::BackBuffer, texcoord);
const float colorDepth = ReShade::GetLinearizedDepth(texcoord).r;
float n = 1.0f;
#line 67
[loop]
for(float i = 1; i < 5; ++i)
{
float2 sourceCoords = texcoord + float2(i *  float2((1.0 / 1500), (1.0 / 1004)).x, 0.0);
float weight = CalculateWeight(i, colorDepth, ReShade::GetLinearizedDepth(sourceCoords).r);
color += (tex2D(ReShade::BackBuffer, sourceCoords) * weight);
n+=weight;
#line 75
sourceCoords = texcoord - float2(i *  float2((1.0 / 1500), (1.0 / 1004)).x, 0.0);
weight = CalculateWeight(i, colorDepth, ReShade::GetLinearizedDepth(sourceCoords).r);
color += (tex2D(ReShade::BackBuffer, sourceCoords) * weight);
n+=weight;
}
outFragment = color/n;
}
#line 83
void PS_Otis_DEH_BlockBlurVertical(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD, out float4 outFragment : SV_Target0)
{
float4 color = tex2D(Otis_SamplerFragmentBuffer1, texcoord);
const float colorDepth = ReShade::GetLinearizedDepth(texcoord).r;
float n=1.0f;
#line 89
[loop]
for(float j = 1; j < 5; ++j)
{
float2 sourceCoords = texcoord + float2(0.0, j *  float2((1.0 / 1500), (1.0 / 1004)).y);
float weight = CalculateWeight(j, colorDepth, ReShade::GetLinearizedDepth(sourceCoords).r);
color += (tex2D(Otis_SamplerFragmentBuffer1, sourceCoords) * weight);
n+=weight;
#line 97
sourceCoords = texcoord - float2(0.0, j *  float2((1.0 / 1500), (1.0 / 1004)).y);
weight = CalculateWeight(j, colorDepth, ReShade::GetLinearizedDepth(sourceCoords).r);
color += (tex2D(Otis_SamplerFragmentBuffer1, sourceCoords) * weight);
n+=weight;
}
outFragment = color/n;
}
#line 105
void PS_Otis_DEH_BlendBlurWithNormalBuffer(float4 vpos: SV_Position, float2 texcoord: TEXCOORD, out float4 fragment: SV_Target0)
{
const float depth = ReShade::GetLinearizedDepth(texcoord).r;
const float4 blendedFragment = lerp(tex2D(ReShade::BackBuffer, texcoord), tex2D(Otis_SamplerFragmentBuffer2, texcoord), clamp(depth  * EffectStrength, 0.0, 1.0));
float yFactor;
if (texcoord.y > 0.5)
yFactor = clamp(1-((texcoord.y-0.5)*2.0), 0, 1);
else
yFactor = clamp(texcoord.y * 2.0, 0, 1);
fragment = lerp(blendedFragment, float4(FogColor, blendedFragment.r), clamp((depth-FogStart) * yFactor * FogFactor, 0.0, 1.0));
#line 117
fragment.rgb += TriDither(fragment.rgb, texcoord, 8);
#line 119
}
#line 121
technique DepthHaze
{
#line 125
pass Otis_DEH_Pass0
{
VertexShader = PostProcessVS;
PixelShader = PS_Otis_DEH_BlockBlurHorizontal;
RenderTarget = Otis_FragmentBuffer1;
}
#line 132
pass Otis_DEH_Pass1
{
VertexShader = PostProcessVS;
PixelShader = PS_Otis_DEH_BlockBlurVertical;
RenderTarget = Otis_FragmentBuffer2;
}
#line 139
pass Otis_DEH_Pass2
{
VertexShader = PostProcessVS;
PixelShader = PS_Otis_DEH_BlendBlurWithNormalBuffer;
}
}

