#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AtmosphericDensity.fx"
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
#line 36 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AtmosphericDensity.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersMacros.fxh"
#line 40 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AtmosphericDensity.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersCommon.fxh"
#line 34
uniform float  Timer      < source = "timer"; >;
#line 48
uniform bool   HasDepth      < source = "bufready_depth"; >;
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
#line 46 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AtmosphericDensity.fx"
#line 62
  uniform int DISTANCE <      ui_type            = "slider";   ui_spacing         =  0;  ui_category = "\n" "Fog Physical Properties""\n\n";     ui_label           =  " ""Density";   ui_tooltip         =  "Determines the apparent thickness of the fog.";       ui_min             =  1;       ui_max             =  100; > = 75;
  uniform int HIGHLIGHT_DIST <      ui_type            = "slider";   ui_spacing         =  1;  ui_category = "\n" "Fog Physical Properties""\n\n";     ui_label           =  " ""Highlight Distance";   ui_tooltip         =  "Controls how far into the fog that highlights can penetrate.";       ui_min             =  0;       ui_max             =  100; > = 100;
#line 65
  uniform float3 FOG_TINT <      ui_type            = "color";   ui_spacing         =  5;  ui_category = "\n" "Fog Physical Properties""\n\n";     ui_label           =  " ""Fog Color";   ui_tooltip         =  ""; > = float3(0.4, 0.45, 0.5);
#line 78
  uniform int AUTO_COLOR <      ui_type            = "combo";   ui_spacing         =  1;  ui_category = "\n" "Fog Physical Properties""\n\n";     ui_label           =  " ""Fog Color Mode";     ui_items           =
"Exact Fog Color\0"
"Preserve Scene Luminance\0"
#line 69
"Use Blurred Scene Luminance\0";   ui_tooltip         =  ""; > = 3;
  uniform int WIDTH <      ui_type            = "slider";   ui_spacing         =  1;  ui_category = "\n" "Fog Physical Properties""\n\n";     ui_label           =  " ""Light Scattering";   ui_tooltip         =  "Controls width of light glow. Needs blurred scene luminance enabled.";       ui_min             =  0;       ui_max             =  100; > = 50;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MShadersAVGen.fxh"
#line 64
namespace avGen {
#line 69
texture texOrig : COLOR;
texture texLod {
Width  =   (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1); Height =   (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1);
MipLevels =
(   (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1) >   (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) *  ( (((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xAAAAAAAA) != 0) | ((((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xFFFF0000) != 0) << 4) | ((((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xFF00FF00) != 0) << 3) | ((((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xF0F0F0F0) != 0) << 2) | ((((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xCCCCCCCC) != 0) << 1)) +
(   (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1) >=   (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) *  ( (((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xAAAAAAAA) != 0) | ((((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xFFFF0000) != 0) << 4) | ((((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xFF00FF00) != 0) << 3) | ((((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xF0F0F0F0) != 0) << 2) | ((((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xCCCCCCCC) != 0) << 1)) - 1 ;
Format = RGB10A2;
};
#line 78
sampler sampOrig { Texture = texOrig; };
sampler sampLod  { Texture = texLod; };
#line 81
float3 get() {
float3 res    = 0;
int2   lvl    = int2( ( (((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xAAAAAAAA) != 0) | ((((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xFFFF0000) != 0) << 4) | ((((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xFF00FF00) != 0) << 3) | ((((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xF0F0F0F0) != 0) << 2) | ((((  (( (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) | (   (   ( (1280) | ( (1280) >> 1) ) | (   ( (1280) | ( (1280) >> 1) ) >> 2) ) >> 4) ) >> 8) ) >>1)+1)) & 0xCCCCCCCC) != 0) << 1)),  ( (((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xAAAAAAAA) != 0) | ((((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xFFFF0000) != 0) << 4) | ((((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xFF00FF00) != 0) << 3) | ((((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xF0F0F0F0) != 0) << 2) | ((((  (( (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) | (   (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) | (   (   ( (720) | ( (720) >> 1) ) | (   ( (720) | ( (720) >> 1) ) >> 2) ) >> 4) ) >> 8) )>>1)+1)) & 0xCCCCCCCC) != 0) << 1)));
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
#line 87 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AtmosphericDensity.fx"
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
#line 88 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AtmosphericDensity.fx"
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return luma;
#line 40
[loop]
for(int i = 1; i < 18; ++i)
{
#line 44
if (((coord.x + i *  float2((1.0 / 1280), (1.0 / 720)).x) >  0.575  ||
(coord.x - i *  float2((1.0 / 1280), (1.0 / 720)).x) <   0.425)) continue;
#line 47
luma += tex2Dlod(Samplerluma, float4(coord + float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).x * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return luma;
#line 84
[loop]
for(int i = 1; i < 18; ++i)
{
#line 88
if (((coord.y + i *  float2((1.0 / 1280), (1.0 / 720)).y) >  0.575   ||
(coord.y - i *  float2((1.0 / 1280), (1.0 / 720)).y) <  0.425)) continue;
#line 91
luma += tex2Dlod(Samplerluma, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).x * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return color;
#line 128
[loop]
for(int i = 1; i < 18; ++i)
{
#line 132
if (((coord.x + i *  float2((1.0 / 1280), (1.0 / 720)).x) >  0.575  ||
(coord.x - i *  float2((1.0 / 1280), (1.0 / 720)).x) <   0.425)) continue;
#line 135
color += tex2Dlod(SamplerColor, float4(coord + float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return color;
#line 172
[loop]
for(int i = 1; i < 18; ++i)
{
#line 176
if (((coord.y + i *  float2((1.0 / 1280), (1.0 / 720)).y) >  0.575  ||
(coord.y - i *  float2((1.0 / 1280), (1.0 / 720)).y) <  0.425)) continue;
#line 179
color += tex2Dlod(SamplerColor, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).rgb * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return luma;
#line 201
[loop]
for(int i = 1; i < 11; ++i)
{
#line 205
if (((coord.x + i *  float2((1.0 / 1280), (1.0 / 720)).x) >  0.575  ||
(coord.x - i *  float2((1.0 / 1280), (1.0 / 720)).x) <   0.425)) continue;
#line 208
luma += tex2Dlod(Samplerluma, float4(coord + float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).x * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return luma;
#line 228
[loop]
for(int i = 1; i < 11; ++i)
{
#line 232
if (((coord.y + i *  float2((1.0 / 1280), (1.0 / 720)).y) >  0.575   ||
(coord.y - i *  float2((1.0 / 1280), (1.0 / 720)).y) <  0.425)) continue;
#line 235
luma += tex2Dlod(Samplerluma, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).x * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return color;
#line 255
[loop]
for(int i = 1; i < 11; ++i)
{
#line 259
if (((coord.x + i *  float2((1.0 / 1280), (1.0 / 720)).x) >  0.575  ||
(coord.x - i *  float2((1.0 / 1280), (1.0 / 720)).x) <   0.425)) continue;
#line 262
color += tex2Dlod(SamplerColor, float4(coord + float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return color;
#line 282
[loop]
for(int i = 1; i < 11; ++i)
{
#line 286
if (((coord.y + i *  float2((1.0 / 1280), (1.0 / 720)).y) >  0.575  ||
(coord.y - i *  float2((1.0 / 1280), (1.0 / 720)).y) <  0.425)) continue;
#line 289
color += tex2Dlod(SamplerColor, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).rgb * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return luma;
#line 311
[loop]
for(int i = 1; i < 11; ++i)
{
#line 315
if (((coord.x + i *  float2((1.0 / 1280), (1.0 / 720)).x) >  0.575  ||
(coord.x - i *  float2((1.0 / 1280), (1.0 / 720)).x) <   0.425)) continue;
#line 318
luma += tex2Dlod(Samplerluma, float4(coord + float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).x * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return luma;
#line 338
[loop]
for(int i = 1; i < 6; ++i)
{
#line 342
if (((coord.y + i *  float2((1.0 / 1280), (1.0 / 720)).y) >  0.575   ||
(coord.y - i *  float2((1.0 / 1280), (1.0 / 720)).y) <  0.425)) continue;
#line 345
luma += tex2Dlod(Samplerluma, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).x * kernel[i];
luma += tex2Dlod(Samplerluma, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).x * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return color;
#line 365
[loop]
for(int i = 1; i < 6; ++i)
{
#line 369
if (((coord.x + i *  float2((1.0 / 1280), (1.0 / 720)).x) >  0.575  ||
(coord.x - i *  float2((1.0 / 1280), (1.0 / 720)).x) <   0.425)) continue;
#line 372
color += tex2Dlod(SamplerColor, float4(coord + float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(offset[i] *  float2((1.0 / 1280), (1.0 / 720)).x, 0.0), 0.0, 0.0)).rgb * kernel[i];
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
if ((coord.x >  0.575 || coord.x <   0.425   ||
coord.y >  0.575 || coord.y <  0.425))
return color;
#line 392
[loop]
for(int i = 1; i < 6; ++i)
{
#line 396
if (((coord.y + i *  float2((1.0 / 1280), (1.0 / 720)).y) >  0.575  ||
(coord.y - i *  float2((1.0 / 1280), (1.0 / 720)).y) <  0.425)) continue;
#line 399
color += tex2Dlod(SamplerColor, float4(coord + float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).rgb * kernel[i];
color += tex2Dlod(SamplerColor, float4(coord - float2(0.0, offset[i] *  float2((1.0 / 1280), (1.0 / 720)).y), 0.0, 0.0)).rgb * kernel[i];
}
#line 403
return color;
}
#line 95 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AtmosphericDensity.fx"
#line 101
void PS_Copy( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2D(TextureColor, coord).rgb;
}
#line 107
void PS_CopyDepth( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = ReShade::GetLinearizedDepth(coord);
}
#line 113
void PS_Restore( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2D(TextureCopy, coord).rgb;
}
#line 120
void PS_PrepLuma( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 luma : SV_Target)
{
float depth, sky;
luma  = tex2D(TextureColor, coord).rgb;
depth = ReShade::GetLinearizedDepth(coord);
sky   = all(1-depth);
#line 128
luma  = lerp(luma, pow(abs(luma), lerp(2.0, 4.0, DISTANCE * 0.01)), depth * sky);
#line 131
luma  =  dot(luma, float3(0.212395, 0.701049, 0.086556));
#line 136
}
#line 139
void PS_Prep( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
float depth, sky, width, luma;
float3 tint, orig;
color  = tex2D(TextureColor, coord).rgb;
luma   = tex2D(TextureBlur2, coord).x;
depth  = ReShade::GetLinearizedDepth(coord);
sky    = all(1-depth);
#line 149
depth  = pow(abs(depth), lerp(10.0, 0.25, DISTANCE * 0.01));
#line 152
color  = lerp(color, pow(abs(color), lerp(2.0, 4.0, DISTANCE * 0.01)), depth * sky);
#line 155
color  = lerp(color, lerp( dot(color, float3(0.212395, 0.701049, 0.086556)), color, lerp(0.75, 1.0, (AUTO_COLOR != 0))), depth);
#line 158
tint   = FOG_TINT;
#line 161
if (AUTO_COLOR > 0)
{
#line 164
if (AUTO_COLOR > 1)
{
#line 167
width  = sin(3.1415927 * 0.5 * luma);
width *= width;
luma   = lerp(luma, width, lerp(1.0, -1.0, WIDTH * 0.01));
}
#line 172
tint = tint -  dot(tint, 0.3333); 
tint = tint + luma;         
}
#line 178
color  = lerp(color, lerp(tint + 0.125, tint, tint), depth * (1-smoothstep(0.0, 1.0, color) * (smoothstep(1.0, lerp(0.5, lerp(1.0, 0.75, DISTANCE * 0.01), HIGHLIGHT_DIST * 0.01), depth))));
#line 185
}
#line 190
void PS_Downscale1( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 luma : SV_Target)
{
#line 193
if (AUTO_COLOR > 1)
{
#line 199
luma = tex2D(TextureColor,  (coord - 0.5) / 0.125 + 0.5).rgb;
#line 201
}
else
{
#line 205
luma = tex2D(TextureColor, coord).rgb;
}
#line 208
luma += Dither(luma, coord,            8);
}
#line 212
void PS_Downscale2( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
#line 215
color  = tex2D(TextureColor,  (coord - 0.5) / 0.5 + 0.5).rgb;
}
#line 219
void PS_Downscale3( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
#line 225
color = tex2D(TextureColor,  (coord - 0.5) / 0.125 + 0.5).rgb;
#line 227
}
#line 232
void PS_LumaBlurH( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 luma : SV_Target)
{
luma = tex2D(TextureBlur1, coord).x;
#line 236
if (AUTO_COLOR > 1)
{
luma  = Blur18H(luma, TextureBlur1, coord).xxx;
}
}
#line 242
void PS_LumaBlurV( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 luma : SV_Target)
{
luma  = tex2D(TextureBlur2, coord).x;
#line 246
if (AUTO_COLOR > 1)
{
luma = Blur18V(luma, TextureBlur2, coord).xxx;
}
}
#line 253
void PS_BlurH( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2D(TextureBlur1, coord).rgb;
color  = Blur18H(color, TextureBlur1, coord);
}
#line 259
void PS_BlurV( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
color  = tex2D(TextureBlur2, coord).rgb;
color  = Blur18V(color, TextureBlur2, coord);
}
#line 268
void PS_UpScale1( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 luma : SV_Target)
{
#line 271
if (AUTO_COLOR > 1)
{
#line 277
luma  = tex2Dbicub(TextureBlur1,  (coord - 0.5) / 8.0 + 0.5).rgb;
#line 279
}
else
{
#line 283
luma  = tex2D(TextureBlur1, coord).xxx;
}
}
#line 288
void PS_UpScale2( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
#line 291
color  = tex2Dbicub(TextureBlur1,  (coord - 0.5) / 2.0 + 0.5).rgb;
}
#line 295
void PS_UpScale3( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
#line 301
color  = tex2Dbicub(TextureBlur1,  (coord - 0.5) / 8.0 + 0.5).rgb;
#line 303
}
#line 306
void PS_Combine( float4 vpos : SV_Position, float2 coord : TEXCOORD , out float3 color : SV_Target)
{
float3 orig, blur, blur2, tint;
float  depth, depth_avg, sky;
#line 311
blur      = tex2D(TextureBlur2, coord).rgb;
blur2     = tex2D(TextureColor, coord).rgb;
color     = tex2D(TextureCopy,  coord).rgb;
depth     = ReShade::GetLinearizedDepth(coord);
sky       = all(1-depth);
depth_avg = avGen::get().x;
orig      = color;
#line 324
depth     = pow(abs(depth), lerp(10.0, 0.33, DISTANCE * 0.01));
#line 327
color     = lerp(color, blur2, depth);
#line 331
if (AUTO_COLOR < 1)
{
color = lerp(color, lerp(color * pow(abs(blur), 10.0), color, color), depth * saturate(1- dot(color * 0.75, float3(0.212395, 0.701049, 0.086556))) * sky);
}
#line 338
color     = lerp(color, pow(abs(blur), lerp(0.75, 1.0, (AUTO_COLOR != 0))), depth * saturate(1- dot(color * 0.75, float3(0.212395, 0.701049, 0.086556))));
#line 344
color     = lerp(color, ((color * 0.5) + pow(abs(blur * 2.0), 0.75)) * 0.5, depth);
#line 347
color    += Dither(color, coord,            8);
#line 350
if ((depth_avg == 0.0) || (depth_avg == 1.0))
color = orig;
#line 356
}
#line 425
 technique AtmosphericDensity < ui_label = "Atmospheric Density"; ui_tooltip =
"Atmospheric Density is a psuedo-volumetric\n"
"fog shader. You will likely need to adjust\n"
"the fog color to match your scene."; > {
#line 431
pass { VertexShader  = VS_Tri; PixelShader   = PS_Copy; RenderTarget  = TexCopy; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_CopyDepth; }
pass { VertexShader  = avGen::vs_main; PixelShader   = avGen::ps_main; RenderTarget  = avGen::texLod; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Restore; }
#line 437
pass { VertexShader  = VS_Tri; PixelShader   = PS_PrepLuma; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale1; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_LumaBlurH; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_LumaBlurV; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_UpScale1; RenderTarget  = TexBlur2; }
#line 444
pass { VertexShader  = VS_Tri; PixelShader   = PS_Prep; }
#line 447
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale2; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_UpScale2; }
#line 451
pass { VertexShader  = VS_Tri; PixelShader   = PS_Downscale3; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_BlurH; RenderTarget  = TexBlur2; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_BlurV; RenderTarget  = TexBlur1; }
pass { VertexShader  = VS_Tri; PixelShader   = PS_UpScale3; RenderTarget  = TexBlur2; }
#line 393
pass { VertexShader  = VS_Tri; PixelShader   = PS_Combine; } }             

