#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HQ4X.fx"
#line 4
uniform float s <
ui_type = "slider";
ui_min = 0.1; ui_max = 10.0;
ui_label = "Strength";
ui_tooltip = "Strength of the effect";
> = 1.5;
uniform float mx <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Smoothing";
> = 1.0;
uniform float k <
ui_type = "slider";
ui_min = -2.0; ui_max = 0.0;
ui_label = "Weight Decrease Factor";
> = -1.10;
uniform float max_w <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Max Filter Weight";
> = 0.75;
uniform float min_w <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Min Filter Weight";
> = 0.03;
uniform float lum_add <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Effects Smoothing";
> = 0.33;
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
#line 36 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HQ4X.fx"
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
#line 39 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HQ4X.fx"
#line 42
float3 PS_HQ4X(float4 pos : SV_Position, float2 uv : TexCoord) : SV_Target
{
const float x = s * (1.0 / 1024);
const float y = s * (1.0 / 768);
#line 47
const float3 dt = 1.0 * float3(1.0, 1.0, 1.0);
#line 49
const float2 dg1 = float2( x, y);
const float2 dg2 = float2(-x, y);
#line 52
const float2 sd1 = dg1 * 0.5;
const float2 sd2 = dg2 * 0.5;
#line 55
const float2 ddx = float2(x, 0.0);
const float2 ddy = float2(0.0, y);
#line 58
float4 t1 = float4(uv - sd1, uv - ddy);
float4 t2 = float4(uv - sd2, uv + ddx);
float4 t3 = float4(uv + sd1, uv + ddy);
float4 t4 = float4(uv + sd2, uv - ddx);
float4 t5 = float4(uv - dg1, uv - dg2);
float4 t6 = float4(uv + dg1, uv + dg2);
#line 65
float3 c  = tex2D(ReShade::BackBuffer, uv).rgb;
#line 67
const float3 i1 = tex2D(ReShade::BackBuffer, t1.xy).rgb;
const float3 i2 = tex2D(ReShade::BackBuffer, t2.xy).rgb;
const float3 i3 = tex2D(ReShade::BackBuffer, t3.xy).rgb;
const float3 i4 = tex2D(ReShade::BackBuffer, t4.xy).rgb;
#line 72
const float3 o1 = tex2D(ReShade::BackBuffer, t5.xy).rgb;
const float3 o3 = tex2D(ReShade::BackBuffer, t6.xy).rgb;
const float3 o2 = tex2D(ReShade::BackBuffer, t5.zw).rgb;
const float3 o4 = tex2D(ReShade::BackBuffer, t6.zw).rgb;
#line 77
const float3 s1 = tex2D(ReShade::BackBuffer, t1.zw).rgb;
const float3 s2 = tex2D(ReShade::BackBuffer, t2.zw).rgb;
const float3 s3 = tex2D(ReShade::BackBuffer, t3.zw).rgb;
const float3 s4 = tex2D(ReShade::BackBuffer, t4.zw).rgb;
#line 82
const float ko1 = dot(abs(o1 - c), dt);
const float ko2 = dot(abs(o2 - c), dt);
const float ko3 = dot(abs(o3 - c), dt);
const float ko4 = dot(abs(o4 - c), dt);
#line 87
const float k1=min(dot(abs(i1 - i3), dt), max(ko1, ko3));
const float k2=min(dot(abs(i2 - i4), dt), max(ko2, ko4));
#line 90
float w1 = k2; if (ko3 < ko1) w1 *= ko3 / ko1;
float w2 = k1; if (ko4 < ko2) w2 *= ko4 / ko2;
float w3 = k2; if (ko1 < ko3) w3 *= ko1 / ko3;
float w4 = k1; if (ko2 < ko4) w4 *= ko2 / ko4;
#line 95
c = (w1 * o1 + w2 * o2 + w3 * o3 + w4 * o4 + 0.001 * c) / (w1 + w2 + w3 + w4 + 0.001);
w1 = k * dot(abs(i1 - c) + abs(i3 - c), dt) / (0.125 * dot(i1 + i3, dt) + lum_add);
w2 = k * dot(abs(i2 - c) + abs(i4 - c), dt) / (0.125 * dot(i2 + i4, dt) + lum_add);
w3 = k * dot(abs(s1 - c) + abs(s3 - c), dt) / (0.125 * dot(s1 + s3, dt) + lum_add);
w4 = k * dot(abs(s2 - c) + abs(s4 - c), dt) / (0.125 * dot(s2 + s4, dt) + lum_add);
#line 101
w1 = clamp(w1 + mx, min_w, max_w);
w2 = clamp(w2 + mx, min_w, max_w);
w3 = clamp(w3 + mx, min_w, max_w);
w4 = clamp(w4 + mx, min_w, max_w);
#line 107
const float3 outcolor = (
w1 * (i1 + i3) +
w2 * (i2 + i4) +
w3 * (s1 + s3) +
w4 * (s2 + s4) +
c) / (2.0 * (w1 + w2 + w3 + w4) + 1.0);
return outcolor + TriDither(outcolor, uv, 8);
#line 122
}
#line 124
technique HQ4X
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_HQ4X;
}
}

