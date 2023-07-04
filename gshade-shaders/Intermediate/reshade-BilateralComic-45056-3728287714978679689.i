#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BilateralComic.fx"
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
#line 6 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BilateralComic.fx"
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BilateralComic.fx"
#line 12
texture BackBuffer : COLOR;
texture Luma <Pooled = true;> {Width = 1280; Height = 720; Format = R16f;};
texture Sobel <Pooled = true;> {Width = 1280; Height = 720; Format = R8;};
#line 16
sampler sBackBuffer {Texture = BackBuffer;};
sampler sLuma {Texture = Luma;};
sampler sSobel {Texture = Sobel;};
#line 20
uniform float Sigma0 <
ui_type = "slider";
ui_category = "Bilateral";
ui_label = "Spatial Blur Strength";
ui_min = 0; ui_max = 2;
> = 2;
#line 27
uniform float Sigma1 <
ui_type = "slider";
ui_category = "Bilateral";
ui_label = "Gradient Blur Strength";
ui_min = 0.001; ui_max = 10;
> = 10;
#line 34
uniform int Anisotropy<
ui_type = "radio";
ui_items = "None \0 Depth \0 Gradient\0";
ui_category = "Anisotropy";
> = 2;
#line 40
uniform float EdgeThreshold <
ui_type = "slider";
ui_category = "Edges";
ui_label = "Edge Threshold";
ui_min = 0; ui_max = 1.001;
> = 0.3;
#line 47
uniform float EdgeStrength <
ui_type = "slider";
ui_category = "Edges";
ui_label = "Edge Strength";
ui_min = 0; ui_max = 2;
> = 1.4;
#line 54
uniform bool QuantizeLuma <
ui_category = "Quantization";
ui_label = "Quantize Luma";
> = 1;
#line 59
uniform int LevelCount<
ui_type = "slider";
ui_category = "Quantization";
ui_label = "Quantization Depth";
ui_min = 1; ui_max = 255;
> = 48;
#line 66
uniform bool IgnoreSky<
ui_category = "Quantization";
ui_label = "Don't Quantize Sky";
> = 1;
#line 72
float3 BSplineBicubicFilter(sampler sTexture, float2 texcoord)
{
float2 textureSize = tex2Dsize(sTexture);
float2 coord = texcoord * textureSize;
float2 x = frac(coord);
coord = floor(coord) - 0.5;
float2 x2 = x * x;
float2 x3 = x2 * x;
#line 82
float2 w0 = x2 - 0.5 * (x3 + x);
float2 w1 = 1.5 * x3 - 2.5 * x2 + 1.0;
float2 w3 = 0.5 * (x3 - x2);
float2 w2 = 1.0 - w0 - w1 - w3;
#line 89
float2 s0 = w0 + w1;
float2 s1 = w2 + w3;
#line 92
float2 f0 = w1 / (w0 + w1);
float2 f1 = w3 / (w2 + w3);
#line 95
float2 t0 = coord - 1 + f0;
float2 t1 = coord + 1 + f1;
t0 /= textureSize;
t1 /= textureSize;
#line 101
return
(tex2D(sTexture, float2(t0.x, t0.y)).rgb * s0.x
+  tex2D(sTexture, float2(t1.x, t0.y)).rgb * s1.x) * s0.y
+ (tex2D(sTexture, float2(t0.x, t1.y)).rgb * s0.x
+  tex2D(sTexture, float2(t1.x, t1.y)).rgb * s1.x) * s1.y;
#line 107
}
#line 110
float3 NormalVector(float2 texcoord)
{
float3 offset = float3( float2((1.0 / 1280), (1.0 / 720)), 0.0);
float c;
float4 h;
float4 v;
if(Anisotropy == 1)
{
c = ReShade::GetLinearizedDepth(texcoord);
#line 120
if(c == 0)
{
return 1;
}
#line 125
h.x = ReShade::GetLinearizedDepth(texcoord - offset.xz);
h.y = ReShade::GetLinearizedDepth(texcoord + offset.xz);
h.z = ReShade::GetLinearizedDepth(texcoord - 2 * offset.xz);
h.w = ReShade::GetLinearizedDepth(texcoord + 2 * offset.xz);
#line 130
v.x = ReShade::GetLinearizedDepth(texcoord - offset.zy);
v.y = ReShade::GetLinearizedDepth(texcoord + offset.zy);
v.z = ReShade::GetLinearizedDepth(texcoord - 2 * offset.zy);
v.w = ReShade::GetLinearizedDepth(texcoord + 2 * offset.zy);
}
else if(Anisotropy == 2)
{
c = tex2Dlod(sLuma, float4(texcoord, 0, 0)).x;
#line 139
h.x = tex2Dlod(sLuma, float4(texcoord, 0, 0), int2(-1, 0)).x;
h.y = tex2Dlod(sLuma, float4(texcoord, 0, 0), int2(1, 0)).x;
h.z = tex2Dlod(sLuma, float4(texcoord, 0, 0), int2(-2, 0)).x;
h.w = tex2Dlod(sLuma, float4(texcoord, 0, 0), int2(2, 0)).x;
#line 144
v.x = tex2Dlod(sLuma, float4(texcoord, 0, 0), int2(0, -1)).x;
v.y = tex2Dlod(sLuma, float4(texcoord, 0, 0), int2(0, 1)).x;
v.z = tex2Dlod(sLuma, float4(texcoord, 0, 0), int2(0, -2)).x;
v.w = tex2Dlod(sLuma, float4(texcoord, 0, 0), int2(0, 2)).x;
}
#line 150
float2 he = abs(h.xy *h.zw * rcp(2 * h.zw - h.xy) - c);
float3 hDeriv;
#line 153
if(he.x > he.y)
{
float3 pos1 = float3(texcoord.xy - offset.xz, 1);
float3 pos2 = float3(texcoord.xy - 2 * offset.xz, 1);
hDeriv = pos1 * h.x - pos2 * h.z;
}
else
{
float3 pos1 = float3(texcoord.xy - offset.xz, 1);
float3 pos2 = float3(texcoord.xy - 2 * offset.xz, 1);
hDeriv = pos1 * h.x - pos2 * h.z;
}
#line 166
float2 ve = abs(v.xy *v.zw * rcp(2 * v.zw - v.xy) - c);
float3 vDeriv;
#line 169
if(ve.x > ve.y)
{
float3 pos1 = float3(texcoord.xy - offset.zy, 1);
float3 pos2 = float3(texcoord.xy - 2 * offset.zy, 1);
vDeriv = pos1 * v.x - pos2 * v.z;
}
else
{
float3 pos1 = float3(texcoord.xy - offset.zy, 1);
float3 pos2 = float3(texcoord.xy - 2 * offset.zy, 1);
vDeriv = pos1 * v.x - pos2 * v.z;
}
#line 182
return (normalize(min(cross(-vDeriv, hDeriv), 0.00001)) * 0.5 + 0.5);
}
#line 185
void LumaBicubicPS(float4 vpos : SV_POSITION, float2 texcoord : TEXCOORD, out float luma : SV_TARGET0)
{
if(Anisotropy == 2)
{
luma = dot(BSplineBicubicFilter(sBackBuffer, texcoord), float3(0.299, 0.587, 0.114));
}
else discard;
}
#line 195
void SobelFilterPS(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float edges : SV_Target0)
{
float2 sums;
float sobel[9] = {1, 2, 1, 0, 0, 0, -1, -2, -1};
[unroll]
for(int i = -1; i <= 1; i++)
{
[unroll]
for(int j = -1; j <= 1; j++)
{
int2 indexes = int2((i + 1) * 3 + (j + 1), (j + 1) * 3 + (i + 1));
float3 color = tex2D(sBackBuffer, texcoord, int2(i, j)).rgb;
float x = dot(color * sobel[indexes.x], float3(0.333, 0.333, 0.333));
float y = dot(color * sobel[indexes.y], float3(0.333, 0.333, 0.333));
sums += float2(x, y);
}
}
#line 213
edges = saturate(length(sums));
}
#line 216
void BilateralFilterPS(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float4 color : SV_Target0)
{
float sigma0 = max(Sigma0, 0.001);
float sigma1 = exp(Sigma1);
color = float4(0, 0, 0, 1);
float3 center = tex2D(sBackBuffer, texcoord).rgb;
color += center;
float3 weightSum = 1;
center = dot(center, float3(0.299, 0.587, 0.114)).xxx * 255;
float2 normals;
if(Anisotropy > 0)
{
normals = (NormalVector(texcoord).xy);
}
else
{
normals = 1;
}
[unroll]
for(int i = -2; i <= 2; i ++)
{
[unroll]
for(int j = -2; j <= 2; j ++)
{
if(all(abs(float2(i, j)) != 0))
{
float2 offset = (float2(i, j) * normals.xy) * 1 / float2(1280, 720);
float3 s = tex2D(sBackBuffer, texcoord + offset).rgb;
float luma = dot(s, float3(0.299, 0.587, 0.114));
float3 w = exp(((-(i * i + j * j) / (sigma0 * sigma0)) - ((center - luma) * (center - luma) / (sigma1 * sigma1))) * 0.5);
color.rgb += s * w;
weightSum += w;
}
}
}
color.rgb /= weightSum;
#line 253
color.rgb += TriDither(color.rgb, texcoord, 8);
#line 255
}
#line 258
void OutputPS(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float4 color : SV_Target0)
{
float sobel = tex2D(sSobel, texcoord).x;
if(1 - sobel > (1 - EdgeThreshold)) sobel = 0;
sobel *= exp(-(2 - EdgeStrength));
if (QuantizeLuma == true)
{
sobel = round(sobel * LevelCount) / LevelCount;
}
sobel = 1 - sobel;
color = tex2D(sBackBuffer, texcoord).rgba * sobel;
if (QuantizeLuma == true)
{
float depth = ReShade::GetLinearizedDepth(texcoord);
if(!IgnoreSky || depth < 1)
{
#line 275
float luma = round(dot(color.rgb, float3(0.299, 0.587, 0.114)) * LevelCount)/LevelCount;
float cb = -0.168736 * color.r - 0.331264 * color.g + 0.500000 * color.b;
float cr = +0.500000 * color.r - 0.418688 * color.g - 0.081312 * color.b;
color = float3(
luma + 1.402 * cr,
luma - 0.344136 * cb - 0.714136 * cr,
luma + 1.772 * cb);
}
}
#line 286
color.rgb += TriDither(color.rgb, texcoord, 8);
#line 288
}
#line 290
technique BilateralComic<ui_tooltip = "Cel-shading shader that uses a combination of bilateral filtering, posterization,\n"
"and edge detection to create a comic book style effect in games.\n\n"
"Part of Insane Shaders\n"
"By: Lord of Lunacy";>
{
pass
{
VertexShader = PostProcessVS;
PixelShader = LumaBicubicPS;
RenderTarget0 = Luma;
}
#line 302
pass
{
VertexShader = PostProcessVS;
PixelShader = SobelFilterPS;
RenderTarget0 = Sobel;
}
#line 309
pass
{
VertexShader = PostProcessVS;
PixelShader = BilateralFilterPS;
}
#line 315
pass
{
VertexShader = PostProcessVS;
PixelShader = OutputPS;
}
}

