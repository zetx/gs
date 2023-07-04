#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SmartDeNoise.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1799 * (1.0 / 995); }
float2 GetPixelSize() { return float2((1.0 / 1799), (1.0 / 995)); }
float2 GetScreenSize() { return float2(1799, 995); }
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
#line 27 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SmartDeNoise.fx"
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
#line 30 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SmartDeNoise.fx"
#line 33
uniform float uSigma <
ui_label = "Standard Deviation Sigma Radius";
ui_tooltip = "Standard Deviation Sigma Radius * K Factor Sigma Coefficient = Radius of the circular kernel.";
ui_type = "slider";
ui_min = 0.001;
ui_max = 8.0;
ui_step = 0.001;
> = 1.25;
uniform float uThreshold <
ui_label = "Edge Sharpening Threshold";
ui_type = "slider";
ui_min = 0.001;
ui_max = 0.25;
ui_step = 0.001;
> = 0.05;
uniform float uKSigma <
ui_label = "K Factor Sigma Coefficient";
ui_tooltip = "Standard Deviation Sigma Radius * K Factor Sigma Coefficient = Radius of the circular kernel.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 3.0;
ui_step = 0.001;
> = 1.5;
#line 69
void PS_SmartDeNoise (in float4 pos : SV_Position, float2 uv : TEXCOORD, out float4 color : SV_Target)
{
const float radius = round(uKSigma * uSigma);
const float radQ = radius * radius;
#line 74
const float invSigmaQx2 = .5 / (uSigma * uSigma);      
const float invSigmaQx2PI =  0.31830988618379067153776752674503 * invSigmaQx2;    
#line 77
const float invThresholdSqx2 = .5 / (uThreshold * uThreshold);     
const float invThresholdSqrt2PI =  0.39894228040143267793994605993439   / uThreshold;   
#line 80
const float4 centrPx = tex2D(ReShade::BackBuffer, uv);
#line 82
float zBuff = 0.0;
float4 aBuff = float4(0.0, 0.0, 0.0, 0.0);
const float2 size = ReShade::GetScreenSize();
#line 86
float2 d;
for (d.x =- radius; d.x <= radius; d.x++) {
float pt = sqrt(radQ - d.x * d.x);       
for (d.y =- pt; d.y <= pt; d.y++) {
float4 walkPx =  tex2Dlod(ReShade::BackBuffer, float4(uv + d / size, 0.0, 0.0));
float4 dC = walkPx - centrPx;
float deltaFactor = exp(-dot(dC, dC) * invThresholdSqx2) * invThresholdSqrt2PI * (exp(-dot(d , d) * invSigmaQx2) * invSigmaQx2PI);
#line 94
zBuff += deltaFactor;
aBuff += deltaFactor * walkPx;
}
}
color = aBuff / zBuff;
#line 101
color.rgb += TriDither(color.rgb, uv, 8);
#line 103
}
#line 173
technique SmartDeNoise {
pass
{
VertexShader = PostProcessVS;
PixelShader  = PS_SmartDeNoise;
}
}

