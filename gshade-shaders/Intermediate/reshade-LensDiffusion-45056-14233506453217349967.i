#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LensDiffusion.fx"
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
#line 35 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LensDiffusion.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersMacros.fxh"
#line 39 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LensDiffusion.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersCommon.fxh"
#line 34
uniform float  Timer      < source = "timer"; >;
#line 48
uniform bool   HasDepth      < source = "bufready_depth"; >;
#line 59
texture TexColor : COLOR;
texture TexDepth : DEPTH;
#line 65
 texture TexCopy { Width  = 1309; Height = 762; Format = RGBA8; };
#line 70
 texture TexBlur1 { Width  = 1309; Height = 762; Format = RGBA16; };
 texture TexBlur2 { Width  = 1309; Height = 762; Format = RGBA16; };
#line 76
 sampler TextureColor { Texture  = TexColor; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR; };
 sampler TextureLuma { Texture  = TexCopy; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR; };
 sampler TextureLin { Texture     = TexColor; AddressU    = MIRROR; AddressV    = MIRROR; AddressW    = MIRROR; SRGBTexture = true; };
 sampler TextureDepth { Texture  = TexDepth; AddressU = BORDER; AddressV = BORDER; AddressW = BORDER; };
 sampler TextureCopy { Texture  = TexCopy; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR; };
 sampler TextureBlur1 { Texture  = TexBlur1; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR; };
 sampler TextureBlur2 { Texture  = TexBlur2; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR; };
#line 87
void VS_Tri(in uint id : SV_VertexID, out float4 vpos : SV_Position, out float2 coord : TEXCOORD)
{
coord.x = (id == 2) ? 2.0 : 0.0;
coord.y = (id == 1) ? 2.0 : 0.0;
vpos = float4(coord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 97
float3 SRGBToLin(float3 SRGBColor)
{
#line 100
return saturate((SRGBColor * SRGBColor) - 0.00575);
}
#line 103
float3 LinToSRGB(float3 LinearColor)
{
#line 106
return saturate(sqrt(LinearColor + 0.00575));
}
#line 112
float rand21(float2 uv)
{
float2 noise = frac(sin(dot(uv, float2(12.9898, 78.233) * 2.0)) * 43758.5453);
return (noise.x + noise.y) * 0.5;
}
#line 118
float rand11(float x)
{
return frac(x * 0.024390243);
}
#line 123
float permute(float x)
{
return ((34.0 * x + 1.0) * x) % 289.0;
}
#line 132
float3 Dither(float3 color, float2 uv, int bits)
{
float bitstep = exp2(bits) - 1.0;
float lsb = 1.0 / bitstep;
float lobit = 0.5 / bitstep;
float hibit = (bitstep - 0.5) / bitstep;
#line 139
float3 m = float3(uv, rand21(uv + Timer)) + 1.0;
float h = permute(permute(permute(m.x) + m.y) + m.z);
#line 142
float3 noise1, noise2;
noise1.x = rand11(h); h = permute(h);
noise2.x = rand11(h); h = permute(h);
noise1.y = rand11(h); h = permute(h);
noise2.y = rand11(h); h = permute(h);
noise1.z = rand11(h); h = permute(h);
noise2.z = rand11(h);
#line 150
float3 lo = saturate( (((color.xyz) - (0.0)) / ((lobit) - (0.0))));
float3 hi = saturate( (((color.xyz) - (1.0)) / ((hibit) - (1.0))));
float3 uni = noise1 - 0.5;
float3 tri = noise1 - noise2;
return lerp(uni, tri, min(lo, hi)) * lsb;
}
#line 159
float3 tex2Dbicub(sampler texSampler, float2 coord)
{
float2 texsize = float2(1309, 762);
#line 163
float4 uv;
uv.xy = coord * texsize;
#line 167
float2 center  = floor(uv.xy - 0.5) + 0.5;
float2 dist1st = uv.xy - center;
float2 dist2nd = dist1st * dist1st;
float2 dist3rd = dist2nd * dist1st;
#line 173
float2 weight0 =     -dist3rd + 3 * dist2nd - 3 * dist1st + 1;
float2 weight1 =  3 * dist3rd - 6 * dist2nd               + 4;
float2 weight2 = -3 * dist3rd + 3 * dist2nd + 3 * dist1st + 1;
float2 weight3 =      dist3rd;
#line 178
weight0 += weight1;
weight2 += weight3;
#line 182
uv.xy  = center - 1 + weight1 / weight0;
uv.zw  = center + 1 + weight3 / weight2;
uv    /= texsize.xyxy;
#line 187
return (weight0.y * (tex2D(texSampler, uv.xy).rgb * weight0.x + tex2D(texSampler, uv.zy).rgb * weight2.x) +
weight2.y * (tex2D(texSampler, uv.xw).rgb * weight0.x + tex2D(texSampler, uv.zw).rgb * weight2.x)) / 36;
}
#line 45 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LensDiffusion.fx"
#line 49
  uniform int DIFF_BLEND <      ui_type            = "slider";   ui_spacing         =  0;  ui_category = "";     ui_label           =  " ""Diffusion Amount";   ui_tooltip         =  "";       ui_min             =  0;       ui_max             =  100; > = 75;
  uniform int TINT_AMOUNT <      ui_type            = "slider";   ui_spacing         =  1;  ui_category = "";     ui_label           =  " ""Lens Coating";   ui_tooltip         =  "Applies a color tint to the diffusion";       ui_min             =  0;       ui_max             =  100; > = 33;
  uniform float3 TINT_COLOR <      ui_type            = "color";   ui_spacing         =  1;  ui_category = "";     ui_label           =  " ""Lens Coating Color";   ui_tooltip         =  ""; > = float3(0.25, 0.0, 1.0);
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersGaussianBlurBounds.fxh"
#line 10
float Blur18H (float luma, sampler Samplerluma, float2 coord)
{
float offset[18] =
{
0.0,            1.4953705027, 3.4891992113,
5.4830312105,   7.4768683759, 9.4707125766,
11.4645656736, 13.4584295168, 15.4523059431,
17.4461967743, 19.4661974725, 21.4627427973,
23.4592916956, 25.455844494,  27.4524015179,
29.4489630909, 31.445529535,  33.4421011704
};
#line 22
float kernel[18] =
{
0.033245,     0.0659162217, 0.0636705814,
0.0598194658, 0.0546642566, 0.0485871646,
0.0420045997, 0.0353207015, 0.0288880982,
0.0229808311, 0.0177815511, 0.013382297,
0.0097960001, 0.0069746748, 0.0048301008,
0.0032534598, 0.0021315311, 0.0013582974
};
#line 32
luma *= kernel[0];
#line 34
[branch]
#line 36
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return luma;
#line 40
[loop]
for(int i = 1; i < 18; ++i)
{
#line 44
if (((coord.x + i *  float2((1.0 / 1309), (1.0 / 762)).x) >  0.675  ||
(coord.x - i *  float2((1.0 / 1309), (1.0 / 762)).x) <   0.325)) continue;
#line 47
luma += tex2Dlod(Samplerluma, float4(coord + float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).x * kernel[i];
}
#line 51
return luma;
}
#line 54
float Blur18V (float luma, sampler Samplerluma, float2 coord)
{
float offset[18] =
{
0.0,            1.4953705027, 3.4891992113,
5.4830312105,   7.4768683759, 9.4707125766,
11.4645656736, 13.4584295168, 15.4523059431,
17.4461967743, 19.4661974725, 21.4627427973,
23.4592916956, 25.455844494,  27.4524015179,
29.4489630909, 31.445529535,  33.4421011704
};
#line 66
float kernel[18] =
{
0.033245,     0.0659162217, 0.0636705814,
0.0598194658, 0.0546642566, 0.0485871646,
0.0420045997, 0.0353207015, 0.0288880982,
0.0229808311, 0.0177815511, 0.013382297,
0.0097960001, 0.0069746748, 0.0048301008,
0.0032534598, 0.0021315311, 0.0013582974
};
#line 76
luma *= kernel[0];
#line 78
[branch]
#line 80
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return luma;
#line 84
[loop]
for(int i = 1; i < 18; ++i)
{
#line 88
if (((coord.y + i *  float2((1.0 / 1309), (1.0 / 762)).y) >  0.675   ||
(coord.y - i *  float2((1.0 / 1309), (1.0 / 762)).y) <  0.325)) continue;
#line 91
luma += tex2Dlod(Samplerluma, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).x * kernel[i];
}
#line 95
return luma;
}
#line 98
float3 Blur18H (float3 color, sampler SamplerColor, float2 coord)
{
float offset[18] =
{
0.0,            1.4953705027, 3.4891992113,
5.4830312105,   7.4768683759, 9.4707125766,
11.4645656736, 13.4584295168, 15.4523059431,
17.4461967743, 19.4661974725, 21.4627427973,
23.4592916956, 25.455844494,  27.4524015179,
29.4489630909, 31.445529535,  33.4421011704
};
#line 110
float kernel[18] =
{
0.033245,     0.0659162217, 0.0636705814,
0.0598194658, 0.0546642566, 0.0485871646,
0.0420045997, 0.0353207015, 0.0288880982,
0.0229808311, 0.0177815511, 0.013382297,
0.0097960001, 0.0069746748, 0.0048301008,
0.0032534598, 0.0021315311, 0.0013582974
};
#line 120
color *= kernel[0];
#line 122
[branch]
#line 124
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return color;
#line 128
[loop]
for(int i = 1; i < 18; ++i)
{
#line 132
if (((coord.x + i *  float2((1.0 / 1309), (1.0 / 762)).x) >  0.675  ||
(coord.x - i *  float2((1.0 / 1309), (1.0 / 762)).x) <   0.325)) continue;
#line 135
color += tex2Dlod(SamplerColor, float4(coord + float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
}
#line 139
return color;
}
#line 142
float3 Blur18V (float3 color, sampler SamplerColor, float2 coord)
{
float offset[18] =
{
0.0,            1.4953705027, 3.4891992113,
5.4830312105,   7.4768683759, 9.4707125766,
11.4645656736, 13.4584295168, 15.4523059431,
17.4461967743, 19.4661974725, 21.4627427973,
23.4592916956, 25.455844494,  27.4524015179,
29.4489630909, 31.445529535,  33.4421011704
};
#line 154
float kernel[18] =
{
0.033245,     0.0659162217, 0.0636705814,
0.0598194658, 0.0546642566, 0.0485871646,
0.0420045997, 0.0353207015, 0.0288880982,
0.0229808311, 0.0177815511, 0.013382297,
0.0097960001, 0.0069746748, 0.0048301008,
0.0032534598, 0.0021315311, 0.0013582974
};
#line 164
color *= kernel[0];
#line 166
[branch]
#line 168
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return color;
#line 172
[loop]
for(int i = 1; i < 18; ++i)
{
#line 176
if (((coord.y + i *  float2((1.0 / 1309), (1.0 / 762)).y) >  0.675  ||
(coord.y - i *  float2((1.0 / 1309), (1.0 / 762)).y) <  0.325)) continue;
#line 179
color += tex2Dlod(SamplerColor, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).rgb * kernel[i];
}
#line 183
return color;
}
#line 188
float Blur11H (float luma, sampler Samplerluma, float2 coord)
{
float offset[11] = { 0.0, 1.4895848401, 3.4757135714, 5.4618796741, 7.4481042327, 9.4344079746, 11.420811147, 13.4073334, 15.3939936778, 17.3808101174, 19.3677999584 };
float kernel[11] = { 0.06649, 0.1284697563, 0.111918249, 0.0873132676, 0.0610011113, 0.0381655709, 0.0213835661, 0.0107290241, 0.0048206869, 0.0019396469, 0.0006988718 };
#line 193
luma *= kernel[0];
#line 195
[branch]
#line 197
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return luma;
#line 201
[loop]
for(int i = 1; i < 11; ++i)
{
#line 205
if (((coord.x + i *  float2((1.0 / 1309), (1.0 / 762)).x) >  0.675  ||
(coord.x - i *  float2((1.0 / 1309), (1.0 / 762)).x) <   0.325)) continue;
#line 208
luma += tex2Dlod(Samplerluma, float4(coord + float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).x * kernel[i];
}
#line 212
return luma;
}
#line 215
float Blur11V (float luma, sampler Samplerluma, float2 coord)
{
float offset[11] = { 0.0, 1.4895848401, 3.4757135714, 5.4618796741, 7.4481042327, 9.4344079746, 11.420811147, 13.4073334, 15.3939936778, 17.3808101174, 19.3677999584 };
float kernel[11] = { 0.06649, 0.1284697563, 0.111918249, 0.0873132676, 0.0610011113, 0.0381655709, 0.0213835661, 0.0107290241, 0.0048206869, 0.0019396469, 0.0006988718 };
#line 220
luma *= kernel[0];
#line 222
[branch]
#line 224
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return luma;
#line 228
[loop]
for(int i = 1; i < 11; ++i)
{
#line 232
if (((coord.y + i *  float2((1.0 / 1309), (1.0 / 762)).y) >  0.675   ||
(coord.y - i *  float2((1.0 / 1309), (1.0 / 762)).y) <  0.325)) continue;
#line 235
luma += tex2Dlod(Samplerluma, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).x * kernel[i];
}
#line 239
return luma;
}
#line 242
float3 Blur11H (float3 color, sampler SamplerColor, float2 coord)
{
float offset[11] = { 0.0, 1.4895848401, 3.4757135714, 5.4618796741, 7.4481042327, 9.4344079746, 11.420811147, 13.4073334, 15.3939936778, 17.3808101174, 19.3677999584 };
float kernel[11] = { 0.06649, 0.1284697563, 0.111918249, 0.0873132676, 0.0610011113, 0.0381655709, 0.0213835661, 0.0107290241, 0.0048206869, 0.0019396469, 0.0006988718 };
#line 247
color *= kernel[0];
#line 249
[branch]
#line 251
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return color;
#line 255
[loop]
for(int i = 1; i < 11; ++i)
{
#line 259
if (((coord.x + i *  float2((1.0 / 1309), (1.0 / 762)).x) >  0.675  ||
(coord.x - i *  float2((1.0 / 1309), (1.0 / 762)).x) <   0.325)) continue;
#line 262
color += tex2Dlod(SamplerColor, float4(coord + float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
}
#line 266
return color;
}
#line 269
float3 Blur11V (float3 color, sampler SamplerColor, float2 coord)
{
float offset[11] = { 0.0, 1.4895848401, 3.4757135714, 5.4618796741, 7.4481042327, 9.4344079746, 11.420811147, 13.4073334, 15.3939936778, 17.3808101174, 19.3677999584 };
float kernel[11] = { 0.06649, 0.1284697563, 0.111918249, 0.0873132676, 0.0610011113, 0.0381655709, 0.0213835661, 0.0107290241, 0.0048206869, 0.0019396469, 0.0006988718 };
#line 274
color *= kernel[0];
#line 276
[branch]
#line 278
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return color;
#line 282
[loop]
for(int i = 1; i < 11; ++i)
{
#line 286
if (((coord.y + i *  float2((1.0 / 1309), (1.0 / 762)).y) >  0.675  ||
(coord.y - i *  float2((1.0 / 1309), (1.0 / 762)).y) <  0.325)) continue;
#line 289
color += tex2Dlod(SamplerColor, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).rgb * kernel[i];
}
#line 293
return color;
}
#line 298
float Blur6H (float luma, sampler Samplerluma, float2 coord)
{
float offset[6] = { 0.0, 1.4584295168, 3.40398480678, 5.3518057801, 7.302940716, 9.2581597095 };
float kernel[6] = { 0.13298, 0.23227575, 0.1353261595, 0.0511557427, 0.01253922, 0.0019913644 };
#line 303
luma *= kernel[0];
#line 305
[branch]
#line 307
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return luma;
#line 311
[loop]
for(int i = 1; i < 11; ++i)
{
#line 315
if (((coord.x + i *  float2((1.0 / 1309), (1.0 / 762)).x) >  0.675  ||
(coord.x - i *  float2((1.0 / 1309), (1.0 / 762)).x) <   0.325)) continue;
#line 318
luma += tex2Dlod(Samplerluma, float4(coord + float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).x * kernel[i];
}
#line 322
return luma;
}
#line 325
float Blur6V (float luma, sampler Samplerluma, float2 coord)
{
float offset[6] = { 0.0, 1.4584295168, 3.40398480678, 5.3518057801, 7.302940716, 9.2581597095 };
float kernel[6] = { 0.13298, 0.23227575, 0.1353261595, 0.0511557427, 0.01253922, 0.0019913644 };
#line 330
luma *= kernel[0];
#line 332
[branch]
#line 334
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return luma;
#line 338
[loop]
for(int i = 1; i < 6; ++i)
{
#line 342
if (((coord.y + i *  float2((1.0 / 1309), (1.0 / 762)).y) >  0.675   ||
(coord.y - i *  float2((1.0 / 1309), (1.0 / 762)).y) <  0.325)) continue;
#line 345
luma += tex2Dlod(Samplerluma, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).x * kernel[i];
}
#line 349
return luma;
}
#line 352
float3 Blur6H (float3 color, sampler SamplerColor, float2 coord)
{
float offset[6] = { 0.0, 1.4584295168, 3.40398480678, 5.3518057801, 7.302940716, 9.2581597095 };
float kernel[6] = { 0.13298, 0.23227575, 0.1353261595, 0.0511557427, 0.01253922, 0.0019913644 };
#line 357
color *= kernel[0];
#line 359
[branch]
#line 361
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return color;
#line 365
[loop]
for(int i = 1; i < 6; ++i)
{
#line 369
if (((coord.x + i *  float2((1.0 / 1309), (1.0 / 762)).x) >  0.675  ||
(coord.x - i *  float2((1.0 / 1309), (1.0 / 762)).x) <   0.325)) continue;
#line 372
color += tex2Dlod(SamplerColor, float4(coord + float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(offset[i] *  float2((1.0 / 1309), (1.0 / 762)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
}
#line 376
return color;
}
#line 379
float3 Blur6V (float3 color, sampler SamplerColor, float2 coord)
{
float offset[6] = { 0.0, 1.4584295168, 3.40398480678, 5.3518057801, 7.302940716, 9.2581597095 };
float kernel[6] = { 0.13298, 0.23227575, 0.1353261595, 0.0511557427, 0.01253922, 0.0019913644 };
#line 384
color *= kernel[0];
#line 386
[branch]
#line 388
if ((coord.x >  0.675 || coord.x <   0.325   ||
coord.y >  0.675 || coord.y <  0.325))
return color;
#line 392
[loop]
for(int i = 1; i < 6; ++i)
{
#line 396
if (((coord.y + i *  float2((1.0 / 1309), (1.0 / 762)).y) >  0.675  ||
(coord.y - i *  float2((1.0 / 1309), (1.0 / 762)).y) <  0.325)) continue;
#line 399
color += tex2Dlod(SamplerColor, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1309), (1.0 / 762)).y), 0.0, 0.0)).rgb * kernel[i];
}
#line 403
return color;
}
#line 66 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LensDiffusion.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersAVGen.fxh"
#line 64
namespace avGen {
#line 69
texture texOrig : COLOR;
texture texLod {
Width  =   (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1); Height =   (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1);
MipLevels =
(   (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1) >   (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) *  ( (((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xAAAAAAAA) != 0) | ((((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xFFFF0000) != 0) << 4) | ((((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xFF00FF00) != 0) << 3) | ((((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xF0F0F0F0) != 0) << 2) | ((((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xCCCCCCCC) != 0) << 1)) +
(   (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1) >=   (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) *  ( (((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xAAAAAAAA) != 0) | ((((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xFFFF0000) != 0) << 4) | ((((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xFF00FF00) != 0) << 3) | ((((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xF0F0F0F0) != 0) << 2) | ((((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xCCCCCCCC) != 0) << 1)) - 1 ;
Format = RGB10A2;
};
#line 78
sampler sampOrig { Texture = texOrig; };
sampler sampLod  { Texture = texLod; };
#line 81
float3 get() {
float3 res    = 0;
int2   lvl    = int2( ( (((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xAAAAAAAA) != 0) | ((((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xFFFF0000) != 0) << 4) | ((((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xFF00FF00) != 0) << 3) | ((((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xF0F0F0F0) != 0) << 2) | ((((  (( (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) | (   (   ( (1309) | ( (1309) >> 1) ) | (   ( (1309) | ( (1309) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xCCCCCCCC) != 0) << 1)),  ( (((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xAAAAAAAA) != 0) | ((((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xFFFF0000) != 0) << 4) | ((((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xFF00FF00) != 0) << 3) | ((((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xF0F0F0F0) != 0) << 2) | ((((  (( (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) | (   (   ( (762) | ( (762) >> 1) ) | (   ( (762) | ( (762) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xCCCCCCCC) != 0) << 1)));
float4 stp    = 0;
stp.xy = 0.5 / float2(1 << max(lvl.xy-lvl.yx,0));
stp.zw = stp.x > stp.y ? stp.zy : stp.xw;
lvl    = int2(min(lvl.x, lvl.y)-1, 1 << abs(lvl.x-lvl.y) );
#line 89
[unroll]
for(int i=0; i < lvl.y; i++)
res += tex2Dlod(sampLod, float4(stp.xy + stp.zw*2*i,0,lvl.x)).rgb;
#line 93
return res/(float)lvl.y;
}
float3 getLog() {
return exp2(get());
}
float4 vs_main( uint vid : SV_VertexID, out float2 uv : TEXCOORD0 ) : SV_Position {
uv = (vid.xx == uint2(2,1))?(float2)2:0;
return float4(uv.x*2.-1.,1.-uv.y*2.,0,1);
}
float4 ps_main( float4 pos: SV_Position, float2 uv: TEXCOORD0 ) : SV_Target {
return tex2D(sampOrig, uv); 
}
float4 ps_main_log( float4 pos: SV_Position, float2 uv: TEXCOORD0 ) : SV_Target {
return log2(tex2D(sampOrig, uv)); 
}
} 
#line 67 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LensDiffusion.fx"
#line 74
void PS_Downscale( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2D(TextureColor,  (coord - 0.5) / 0.25 + 0.5).rgb;
}
#line 80
void PS_BlurH( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2D(TextureBlur1, coord).rgb;
#line 84
color  = Blur6H(color, TextureBlur1, coord);
}
#line 88
void PS_BlurV( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2D(TextureBlur2, coord).rgb;
#line 92
color  = Blur6V(color, TextureBlur2, coord);
}
#line 96
void PS_Upscale( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2Dbicub(TextureBlur1,  (coord - 0.5) / 4.0 + 0.5).rgb;
#line 100
color += Dither(color, coord,            8);
}
#line 104
void PS_Combine( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
float3 blur, orig, tint;
float  luma, avg;
#line 110
avg    =  dot(pow(max(avGen::get(), 0.0), 0.75), float3(0.212395, 0.701049, 0.086556));
#line 113
orig   = tex2D(TextureColor, coord).rgb;
#line 116
blur   = tex2D(TextureBlur2, coord).rgb;
#line 119
luma   =  dot(orig, float3(0.212395, 0.701049, 0.086556));
#line 124
luma   = 1-pow(max(luma, 0.0), lerp(0.01, 1.15, avg));
#line 131
tint   = lerp(1.0, TINT_COLOR, TINT_AMOUNT * 0.01);
#line 134
blur   = (blur * tint) -  dot(blur * tint, float3(0.212395, 0.701049, 0.086556)) +  dot(blur, float3(0.212395, 0.701049, 0.086556));
#line 137
color  = lerp(orig, lerp(orig, blur, luma), DIFF_BLEND * 0.01);
#line 140
color += Dither(color, coord,            8);
}
#line 161
 technique LensDiffusion < ui_label = "Lens Diffusion"; ui_tooltip = ""; > {
pass { VertexShader  = avGen::vs_main; PixelShader   = avGen::ps_main; RenderTarget  = avGen::texLod; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_BlurH; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_BlurV; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_BlurH; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_BlurV; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Upscale; RenderTarget  = TexBlur2; }
#line 153
pass { VertexShader  = VS_Tri; PixelShader   = PS_Combine; } }

