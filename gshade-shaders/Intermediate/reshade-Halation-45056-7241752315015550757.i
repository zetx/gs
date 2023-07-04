#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Halation.fx"
#line 6
uniform int halationRadius <
ui_type = "slider";
ui_min = 0; ui_max = 4;
ui_label = "Radius";
ui_tooltip = "[0|1|2|3|4] Adjusts the radius of the effect. Higher values increase the radius.";
> = 0;
#line 13
uniform float halationOffset <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Offset";
ui_tooltip = "Additional adjustment for the radius. Values less than 1.00 will reduce the radius.";
> = 1.0;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1309 * (1.0 / 762); }
float2 GetPixelSize() { return float2((1.0 / 1309), (1.0 / 762)); }
float2 GetScreenSize() { return float2(1309, 762); }
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
#line 20 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Halation.fx"
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
#line 23 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Halation.fx"
#line 26
texture HalationTex { Width = 1309; Height = 762; Format = RGBA8; };
sampler HalationSamp { Texture = HalationTex; };
#line 29
texture GaussianBlurHalTex { Width = 1309; Height = 762; Format = RGBA8; };
sampler GaussianBlurHalSampler { Texture = GaussianBlurHalTex; };
#line 32
float3 red(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
const float3 orig = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 36
return saturate(min(((orig.r + orig.g + orig.b) / 3) * float3(1.0, 0.0, 0.0), orig));
}
#line 39
float3 GaussianBlurH(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
float3 color = tex2D(HalationSamp, texcoord).rgb;
float offset[18];
float weight[18];
#line 45
switch (halationRadius)
{
case 0:
offset = { 0.0, 1.1824255238, 3.0293122308, 5.0040701377, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
weight = { 0.39894, 0.2959599993, 0.0045656525, 0.00000149278686458842, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
color *= weight[0];
[unroll]
for(int i = 1; i < 4; ++i)
{
color += tex2Dlod(HalationSamp, float4(texcoord + float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(HalationSamp, float4(texcoord - float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
case 1:
offset = { 0.0, 1.4584295168, 3.40398480678, 5.3518057801, 7.302940716, 9.2581597095, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
weight = { 0.13298, 0.23227575, 0.1353261595, 0.0511557427, 0.01253922, 0.0019913644, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
color *= weight[0];
[unroll]
for(int i = 1; i < 6; ++i)
{
color += tex2Dlod(HalationSamp, float4(texcoord + float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(HalationSamp, float4(texcoord - float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
case 2:
[unroll]
offset = { 0.0, 1.4895848401, 3.4757135714, 5.4618796741, 7.4481042327, 9.4344079746, 11.420811147, 13.4073334, 15.3939936778, 17.3808101174, 19.3677999584, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
weight = { 0.06649, 0.1284697563, 0.111918249, 0.0873132676, 0.0610011113, 0.0381655709, 0.0213835661, 0.0107290241, 0.0048206869, 0.0019396469, 0.0006988718, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
color *= weight[0];
for(int i = 1; i < 11; ++i)
{
color += tex2Dlod(HalationSamp, float4(texcoord + float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(HalationSamp, float4(texcoord - float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
case 3:
[unroll]
offset = { 0.0, 1.4953705027, 3.4891992113, 5.4830312105, 7.4768683759, 9.4707125766, 11.4645656736, 13.4584295168, 15.4523059431, 17.4461967743, 19.4401038149, 21.43402885, 23.4279736431, 25.4219399344, 27.4159294386, 0.0, 0.0, 0.0 };
weight = { 0.0443266667, 0.0872994708, 0.0820892038, 0.0734818355, 0.0626171681, 0.0507956191, 0.0392263968, 0.0288369812, 0.0201808877, 0.0134446557, 0.0085266392, 0.0051478359, 0.0029586248, 0.0016187257, 0.0008430913, 0.0, 0.0, 0.0 };
color *= weight[0];
[unroll]
for(int i = 1; i < 15; ++i)
{
color += tex2Dlod(HalationSamp, float4(texcoord + float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(HalationSamp, float4(texcoord - float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
case 4:
offset = { 0.0, 1.4953705027, 3.4891992113, 5.4830312105, 7.4768683759, 9.4707125766, 11.4645656736, 13.4584295168, 15.4523059431, 17.4461967743, 19.4661974725, 21.4627427973, 23.4592916956, 25.455844494, 27.4524015179, 29.4489630909, 31.445529535, 33.4421011704 };
weight = { 0.033245, 0.0659162217, 0.0636705814, 0.0598194658, 0.0546642566, 0.0485871646, 0.0420045997, 0.0353207015, 0.0288880982, 0.0229808311, 0.0177815511, 0.013382297, 0.0097960001, 0.0069746748, 0.0048301008, 0.0032534598, 0.0021315311, 0.0013582974 };
color *= weight[0];
[unroll]
for(int i = 1; i < 18; ++i)
{
color += tex2Dlod(HalationSamp, float4(texcoord + float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(HalationSamp, float4(texcoord - float2(offset[i] * ReShade:: GetPixelSize().x, 0.0) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
}
#line 105
return saturate(color);
}
#line 108
float3 GaussianBlurV(in float4 pos : SV_Position, in float2 texcoord : TEXCOORD) : COLOR
{
float3 color = tex2D(GaussianBlurHalSampler, texcoord).rgb;
float offset[18];
float weight[18];
#line 114
switch (halationRadius)
{
case 0:
offset = { 0.0, 1.1824255238, 3.0293122308, 5.0040701377, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
weight = { 0.39894, 0.2959599993, 0.0045656525, 0.00000149278686458842, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
color *= weight[0];
[unroll]
for(int i = 1; i < 4; ++i)
{
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord + float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord - float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
case 1:
offset = { 0.0, 1.4584295168, 3.40398480678, 5.3518057801, 7.302940716, 9.2581597095, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
weight = { 0.13298, 0.23227575, 0.1353261595, 0.0511557427, 0.01253922, 0.0019913644, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
color *= weight[0];
[unroll]
for(int i = 1; i < 6; ++i)
{
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord + float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord - float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
case 2:
offset = { 0.0, 1.4895848401, 3.4757135714, 5.4618796741, 7.4481042327, 9.4344079746, 11.420811147, 13.4073334, 15.3939936778, 17.3808101174, 19.3677999584, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
weight = { 0.06649, 0.1284697563, 0.111918249, 0.0873132676, 0.0610011113, 0.0381655709, 0.0213835661, 0.0107290241, 0.0048206869, 0.0019396469, 0.0006988718, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
color *= weight[0];
[unroll]
for(int i = 1; i < 11; ++i)
{
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord + float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord - float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
case 3:
offset = { 0.0, 1.4953705027, 3.4891992113, 5.4830312105, 7.4768683759, 9.4707125766, 11.4645656736, 13.4584295168, 15.4523059431, 17.4461967743, 19.4401038149, 21.43402885, 23.4279736431, 25.4219399344, 27.4159294386, 0.0, 0.0, 0.0 };
weight = { 0.0443266667, 0.0872994708, 0.0820892038, 0.0734818355, 0.0626171681, 0.0507956191, 0.0392263968, 0.0288369812, 0.0201808877, 0.0134446557, 0.0085266392, 0.0051478359, 0.0029586248, 0.0016187257, 0.0008430913, 0.0, 0.0, 0.0 };
color *= weight[0];
[unroll]
for(int i = 1; i < 15; ++i)
{
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord + float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord - float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
case 4:
offset = { 0.0, 1.4953705027, 3.4891992113, 5.4830312105, 7.4768683759, 9.4707125766, 11.4645656736, 13.4584295168, 15.4523059431, 17.4461967743, 19.4661974725, 21.4627427973, 23.4592916956, 25.455844494, 27.4524015179, 29.4489630909, 31.445529535, 33.4421011704 };
weight = { 0.033245, 0.0659162217, 0.0636705814, 0.0598194658, 0.0546642566, 0.0485871646, 0.0420045997, 0.0353207015, 0.0288880982, 0.0229808311, 0.0177815511, 0.013382297, 0.0097960001, 0.0069746748, 0.0048301008, 0.0032534598, 0.0021315311, 0.0013582974 };
color *= weight[0];
[unroll]
for(int i = 1; i < 18; ++i)
{
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord + float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
color += tex2Dlod(GaussianBlurHalSampler, float4(texcoord - float2(0.0, offset[i] * ReShade:: GetPixelSize().y) * halationOffset, 0.0, 0.0)).rgb * weight[i];
}
break;
}
#line 174
const float3 outcolor = saturate(max(color, tex2D(ReShade::BackBuffer, texcoord).rgb));
return outcolor + TriDither(outcolor, texcoord, 8);
#line 179
}
#line 181
technique Halation
{
pass pass0
{
VertexShader = PostProcessVS;
PixelShader = red;
RenderTarget = HalationTex;
}
pass pass1
{
VertexShader = PostProcessVS;
PixelShader = GaussianBlurH;
RenderTarget = GaussianBlurHalTex;
}
pass pass2
{
VertexShader = PostProcessVS;
PixelShader = GaussianBlurV;
}
}

