#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FakeMotionBlur.fx"
#line 31
uniform float mbRecall <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Motion blur intensity";
> = 0.40;
uniform float mbSoftness <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
ui_tooltip = "Blur strength of consequential streaks";
> = 1.00;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1798 * (1.0 / 997); }
float2 GetPixelSize() { return float2((1.0 / 1798), (1.0 / 997)); }
float2 GetScreenSize() { return float2(1798, 997); }
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
#line 42 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FakeMotionBlur.fx"
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
#line 45 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FakeMotionBlur.fx"
#line 48
texture2D currTex { Width = 1798; Height = 997; Format = RGBA8; };
texture2D prevSingleTex { Width = 1798; Height = 997; Format = RGBA8; };
texture2D prevTex { Width = 1798; Height = 997; Format = RGBA8; };
#line 52
sampler2D currColor { Texture = currTex; };
sampler2D prevSingleColor { Texture = prevSingleTex; };
sampler2D prevColor { Texture = prevTex; };
#line 56
void PS_Combine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{
const float4 curr = tex2D(currColor, texcoord);
const float4 prevSingle = tex2D(prevSingleColor, texcoord);
float4 prev = tex2D(prevColor, texcoord);
#line 62
const float3 diff3 = abs(prevSingle.rgb - curr.rgb) * 2.0f;
const float diff = min(diff3.r + diff3.g + diff3.b, mbRecall);
#line 65
const float weight[11] = { 0.082607, 0.040484, 0.038138, 0.034521, 0.030025, 0.025094, 0.020253, 0.015553, 0.011533, 0.008218, 0.005627 };
prev *= weight[0];
#line 68
const float pixelBlur = (mbSoftness * 13 * (diff)) * ((1.0 / 1798));
const float pixelBlur2 = (mbSoftness * 11 * (diff)) * ((1.0 / 997));
#line 71
[unroll]
for (int z = 1; z < 11; z++)
{
prev += tex2D(prevColor, texcoord + float2(z * pixelBlur, 0.0f)) * weight[z];
prev += tex2D(prevColor, texcoord - float2(z * pixelBlur, 0.0f)) * weight[z];
prev += tex2D(prevColor, texcoord + float2(0.0f, z * pixelBlur2)) * weight[z];
prev += tex2D(prevColor, texcoord - float2(0.0f, z * pixelBlur2)) * weight[z];
}
#line 80
color = lerp(curr, prev, diff + 0.1);
#line 83
color.rgb += TriDither(color.rgb, texcoord, 8);
#line 85
}
#line 87
void PS_CopyFrame(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{
color = tex2D(ReShade::BackBuffer, texcoord);
}
void PS_CopyPreviousFrame(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 prevSingle : SV_Target0, out float4 prev : SV_Target1)
{
prevSingle = tex2D(currColor, texcoord);
prev = tex2D(ReShade::BackBuffer, texcoord);
}
#line 97
technique MotionBlur
{
pass CopyFrame
{
VertexShader = PostProcessVS;
PixelShader = PS_CopyFrame;
RenderTarget = currTex;
}
#line 106
pass Combine
{
VertexShader = PostProcessVS;
PixelShader = PS_Combine;
}
#line 112
pass PrevColor
{
VertexShader = PostProcessVS;
PixelShader = PS_CopyPreviousFrame;
RenderTarget0 = prevSingleTex;
RenderTarget1 = prevTex;
}
}

