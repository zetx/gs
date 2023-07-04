#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VHSM.fx"
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
#line 34 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VHSM.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersMacros.fxh"
#line 38 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VHSM.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersCommon.fxh"
#line 34
uniform float  Timer      < source = "timer"; >;
#line 59
texture TexColor : COLOR;
texture TexDepth : DEPTH;
#line 65
 texture TexCopy { Width  = 1280; Height = 720; Format = RGBA8; };
#line 70
 texture TexBlur1 { Width  = 1280; Height = 720; Format = RGBA16; };
 texture TexBlur2 { Width  = 1280; Height = 720; Format = RGBA16; };
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
float2 texsize = float2(1280, 720);
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
#line 54 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VHSM.fx"
#line 79
  uniform int TAPE_SELECT <      ui_type            = "combo";   ui_spacing         =  0;  ui_category = "\n" "VCR Settings""\n\n";     ui_label           =  " ""Tape Selection";     ui_items           =
"Betamax\0"
"S-VHS\0"
"VHS\0"
"Bad VHS\0"
#line 64
"U-Matic\0";   ui_tooltip         =  "Choose your video cassette type."; > = 2;
  uniform int CHROMA_SHIFT <      ui_type            = "slider";   ui_spacing         =  5;  ui_category = "\n" "VCR Settings""\n\n";     ui_label           =  " ""Misalign Chroma";   ui_tooltip         =  "Splits the color channels.";       ui_min             =  -100;       ui_max             =  100; > = 50;
#line 78
  uniform int SHIFT_MODE <      ui_type            = "combo";   ui_spacing         =  1;  ui_category = "\n" "VCR Settings""\n\n";     ui_label           =  " ""Misalignment Mode";     ui_items           =
"Red / Blue\0"
"Green / Magenta\0"
#line 69
"Yellow / Violet\0";   ui_tooltip         =  "Determines the color combination for the split channels"; > = 0;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersBlendingModes.fxh"
#line 8
float BlendOverlay(float base, float blend)
{
return lerp((2.0 * base * blend),
(1.0 - 2.0 * (1.0 - base) * (1.0 - blend)),
step(blend, 0.5));
}
#line 15
float3 BlendOverlay(float3 base, float3 blend)
{
return lerp((2.0 * base * blend),
(1.0 - 2.0 * (1.0 - base) * (1.0 - blend)),
step(blend, 0.5));
}
#line 25
float BlendSoftLight(float base, float blend)
{
return lerp((2.0 * base * blend + base * base * (1.0 - 2.0 * blend)),
(sqrt(base) * (2.0 * blend - 1.0) + 2.0 * base * (1.0 - blend)),
step(blend, 0.5));
}
#line 32
float3 BlendSoftLight(float3 base, float3 blend)
{
return lerp((2.0 * base * blend + base * base * (1.0 - 2.0 * blend)),
(sqrt(base) * (2.0 * blend - 1.0) + 2.0 * base * (1.0 - blend)),
step(blend, 0.5));
}
#line 42
float BlendHardLight(float base, float blend)
{
return BlendOverlay(blend, base);
}
#line 47
float3 BlendHardLight(float3 base, float3 blend)
{
return BlendOverlay(blend, base);
}
#line 55
float BlendAdd(float base, float blend)
{
return min(base + blend, 1.0);
}
#line 60
float3 BlendAdd(float3 base, float3 blend)
{
return min(base + blend, 1.0);
}
#line 68
float BlendSubtract(float base, float blend)
{
return max(base + blend - 1.0, 0.0);
}
#line 73
float3 BlendSubtract(float3 base, float3 blend)
{
return max(base + blend - 1.0, 0.0);
}
#line 81
float BlendLinearDodge(float base, float blend)
{
return BlendAdd(base, blend);
}
#line 86
float3 BlendLinearDodge(float3 base, float3 blend)
{
return BlendAdd(base, blend);
}
#line 94
float BlendLinearBurn(float base, float blend)
{
return BlendSubtract(base, blend);
}
#line 99
float3 BlendLinearBurn(float3 base, float3 blend)
{
return BlendSubtract(base, blend);
}
#line 107
float BlendLighten(float base, float blend)
{
return max(blend, base);
}
#line 112
float3 BlendLighten(float3 base, float3 blend)
{
return max(blend, base);
}
#line 120
float BlendDarken(float base, float blend)
{
return min(blend, base);
}
#line 125
float3 BlendDarken(float3 base, float3 blend)
{
return min(blend, base);
}
#line 133
float BlendLinearLight(float base, float blend)
{
return lerp(BlendLinearBurn(base, (2.0 *  blend)),
BlendLinearDodge(base, (2.0 * (blend - 0.5))),
step(blend, 0.5));
}
#line 140
float3 BlendLinearLight(float3 base, float3 blend)
{
return lerp(BlendLinearBurn(base, (2.0 *  blend)),
BlendLinearDodge(base, (2.0 * (blend - 0.5))),
step(blend, 0.5));
}
#line 150
float BlendScreen(float base, float blend)
{
return 1.0 - ((1.0 - base) * (1.0 - blend));
}
#line 155
float3 BlendScreen(float3 base, float3 blend)
{
return 1.0 - ((1.0 - base) * (1.0 - blend));
}
#line 163
float BlendScreenHDR(float base, float blend)
{
return base + (blend / (1 + base));
}
#line 168
float3 BlendScreenHDR(float3 base, float3 blend)
{
return base + (blend / (1 + base));
}
#line 176
float BlendColorDodge(float base, float blend)
{
return lerp(blend, min(base / (1.0 - blend), 1.0), (blend == 1.0));
}
#line 181
float3 BlendColorDodge(float3 base, float3 blend)
{
return lerp(blend, min(base / (1.0 - blend), 1.0), (blend == 1.0));
}
#line 189
float BlendColorBurn(float base, float blend)
{
return lerp(blend, max((1.0 - ((1.0 - base) / blend)), 0.0), (blend == 0.0));
}
#line 194
float3 BlendColorBurn(float3 base, float3 blend)
{
return lerp(blend, max((1.0 - ((1.0 - base) / blend)), 0.0), (blend == 0.0));
}
#line 202
float BlendVividLight(float base, float blend)
{
return lerp(BlendColorBurn (base, (2.0 *  blend)),
BlendColorDodge(base, (2.0 * (blend - 0.5))),
step(blend, 0.5));
}
#line 209
float3 BlendVividLight(float3 base, float3 blend)
{
return lerp(BlendColorBurn (base, (2.0 *  blend)),
BlendColorDodge(base, (2.0 * (blend - 0.5))),
step(blend, 0.5));
}
#line 219
float BlendPinLight(float base, float blend)
{
return lerp(BlendDarken (base, (2.0 *  blend)),
BlendLighten(base, (2.0 * (blend - 0.5))),
step(blend, 0.5));
}
#line 226
float3 BlendPinLight(float3 base, float3 blend)
{
return lerp(BlendDarken (base, (2.0 *  blend)),
BlendLighten(base, (2.0 * (blend - 0.5))),
step(blend, 0.5));
}
#line 236
float BlendHardMix(float base, float blend)
{
return lerp(0.0, 1.0, step(BlendVividLight(base, blend), 0.5));
}
#line 241
float3 BlendHardMix(float3 base, float3 blend)
{
return lerp(0.0, 1.0, step(BlendVividLight(base, blend), 0.5));
}
#line 249
float BlendReflect(float base, float blend)
{
return lerp(blend, min(base * base / (1.0 - blend), 1.0), (blend == 1.0));
}
#line 254
float3 BlendReflect(float3 base, float3 blend)
{
return lerp(blend, min(base * base / (1.0 - blend), 1.0), (blend == 1.0));
}
#line 262
float BlendAverage(float base, float blend)
{
return (base + blend) / 2.0;
}
#line 267
float3 BlendAverage(float3 base, float3 blend)
{
return (base + blend) / 2.0;
}
#line 275
float BlendDifference(float base, float blend)
{
return abs(base - blend);
}
#line 280
float3 BlendDifference(float3 base, float3 blend)
{
return abs(base - blend);
}
#line 288
float BlendNegation(float base, float blend)
{
return 1.0 - abs(1.0 - base - blend);
}
#line 293
float3 BlendNegation(float3 base, float3 blend)
{
return 1.0 - abs(1.0 - base - blend);
}
#line 301
float BlendExclusion(float base, float blend)
{
return base + blend - 2.0 * base * blend;
}
#line 306
float3 BlendExclusion(float3 base, float3 blend)
{
return base + blend - 2.0 * base * blend;
}
#line 314
float BlendGlow(float base, float blend)
{
return BlendReflect(blend, base);
}
#line 319
float3 BlendGlow(float3 base, float3 blend)
{
return BlendReflect(blend, base);
}
#line 327
float BlendPhoenix(float base, float blend)
{
return min(base, blend) - max(base, blend) + 1.0;
}
#line 332
float3 BlendPhoenix(float3 base, float3 blend)
{
return min(base, blend) - max(base, blend) + 1.0;
}
#line 77 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VHSM.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersLUTAtlas.fxh"
#line 7
float3 LUTAtlas(float3 color, sampler SamplerLUT, int INDEX, float2 coord)
{
float3 lutcoord;
float2 texel;
float  lookup;
#line 13
texel       = 1.0 /   32;
texel.x    /=   32;
#line 16
lutcoord    = float3((color.xy*   32 - color.xy + 0.5) * texel.xy, color.z *   32 - color.z);
lutcoord.y /=  5;
lutcoord.y += (float(INDEX) /  5);
lookup      = frac(lutcoord.z);
lutcoord.x += (lutcoord.z-lookup)*texel.y;
#line 22
return lerp(tex2D(SamplerLUT, lutcoord.xy).xyz, tex2D(SamplerLUT, float2(lutcoord.x + texel.y, lutcoord.y)).xyz, lookup);
}
#line 81 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\VHSM.fx"
#line 92
 texture TexVHSLUTs < source = "VideoCassette.png"; > { Width  = 1024; Height = 160; Format = RGBA8; };
 sampler TextureVHSLUTs { Texture  = TexVHSLUTs; AddressU = BORDER; AddressV = BORDER; AddressW = BORDER; };
#line 98
void PS_Copy( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2D(TextureColor, coord).rgb;
}
#line 103
void PS_Downscale1( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
#line 106
color  = tex2D(TextureBlur2,  (coord - 0.5) /    float2(0.5, 0.75) + 0.5).rgb;
}
#line 109
void PS_Upscale1( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
#line 112
color  = tex2Dbicub(TextureBlur1,  (coord - 0.5) / (1.0 /    float2(0.5, 0.75)) + 0.5).rgb;
}
#line 115
void PS_SDLuma( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float4 color : SV_Target)
{
#line 118
color.rgb = tex2D(TextureBlur2, coord).rgb;
color.a   =  dot(tex2D(TextureBlur2, coord).rgb, float3(0.212395, 0.701049, 0.086556));
}
#line 122
void PS_Downscale2( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float4 color : SV_Target)
{
#line 125
color.rgb = tex2D(TextureBlur1,  (coord - 0.5) /    float2(0.5, 0.75) + 0.5).rgb;
color.a   = tex2D(TextureBlur1, coord).a;
}
#line 129
void PS_Downscale3( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float4 color : SV_Target)
{
#line 132
color.rgb = tex2D(TextureBlur2,  (coord - 0.5) /  float2(0.5, 1.0) + 0.5).rgb;
color.a   = tex2D(TextureBlur2, coord).a;
}
#line 136
void PS_Downscale4( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float4 color : SV_Target)
{
#line 139
color.rgb = tex2D(TextureBlur1,  (coord - 0.5) /  float2(0.5, 1.0) + 0.5).rgb;
color.a   = tex2D(TextureBlur1, coord).a;
}
#line 143
void PS_Upscale2( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float4 color : SV_Target)
{
#line 146
color.rgb = tex2Dbicub(TextureBlur2,  (coord - 0.5) / (1.0 /    float2(0.5, 0.75)) + 0.5).rgb;
color.a   = tex2D(TextureBlur2, coord).a;
}
#line 150
void PS_Upscale3( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float4 color : SV_Target)
{
#line 153
color.rgb = tex2Dbicub(TextureBlur1,  (coord - 0.5) / (1.0 /  float2(0.5, 1.0)) + 0.5).rgb;
color.a   = tex2D(TextureBlur1, coord).a;
}
#line 157
void PS_Upscale4( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float4 color : SV_Target)
{
#line 160
color.rgb = tex2Dbicub(TextureBlur2,  (coord - 0.5) / (1.0 /  float2(0.5, 1.0)) + 0.5).rgb;
color.a   = tex2D(TextureBlur2, coord).a;
}
#line 164
void PS_Combine( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
float4 buffer;
float  luma, shift;
#line 169
shift = lerp(0.0, 0.002, CHROMA_SHIFT * 0.01);
#line 172
if      (SHIFT_MODE == 0) 
{
buffer.r   = tex2D(TextureBlur1, float2(coord.x + shift, coord.y)).r;
buffer.g   = tex2D(TextureBlur1, coord).g;
buffer.b   = tex2D(TextureBlur1, float2(coord.x - shift, coord.y)).b;
}
else if (SHIFT_MODE == 1) 
{
buffer.r   = tex2D(TextureBlur1, float2(coord.x - shift, coord.y)).r;
buffer.g   = tex2D(TextureBlur1, float2(coord.x + shift, coord.y)).g;
buffer.b   = tex2D(TextureBlur1, coord).b;
}
else if (SHIFT_MODE == 2) 
{
buffer.r   = tex2D(TextureBlur1, coord).r;
buffer.g   = tex2D(TextureBlur1, float2(coord.x - shift, coord.y)).g;
buffer.b   = tex2D(TextureBlur1, float2(coord.x + shift, coord.y)).b;
}
#line 192
buffer.a   = tex2D(TextureBlur1, coord).a;
#line 195
luma       =  dot(tex2D(TextureBlur1, coord).rgb, float3(0.212395, 0.701049, 0.086556));
#line 198
buffer.rgb = buffer.rgb - luma;
buffer.rgb = buffer.rgb + buffer.a;
#line 202
buffer.rgb = lerp(16 / 255.0, 235 / 255.0, buffer.rgb);
#line 205
color      = LUTAtlas(pow(saturate(buffer.rgb), 0.8), TextureVHSLUTs, TAPE_SELECT, coord);
#line 208
color     += Dither(color, coord,            8);
#line 210
}
#line 264
 technique VHSM < ui_label = "VHS-M"; ui_tooltip =
"Emulates clean, artifact-free, output of a VHS tape"; > {
#line 268
pass { VertexShader  = VS_Tri; PixelShader   = PS_Copy; RenderTarget  = TexBlur2; }
#line 271
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale1; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Upscale1; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale1; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Upscale1; RenderTarget  = TexBlur2; }
#line 277
pass { VertexShader  = VS_Tri; PixelShader   = PS_SDLuma; RenderTarget  = TexBlur1; }
#line 280
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale2; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale3; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale4; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Upscale2; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Upscale3; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Upscale4; RenderTarget  = TexBlur1; }
#line 240
pass { VertexShader  = VS_Tri; PixelShader   = PS_Combine; } }

