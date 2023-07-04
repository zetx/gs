#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SlitScan.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SlitScan.fx"
#line 5
;
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
#line 8 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SlitScan.fx"
#line 11
uniform float x_col <
ui_type = "slider";
ui_label="X";
ui_max = 1.0;
ui_min = 0.0;
> = 0.250;
#line 18
uniform float scan_speed <
ui_type = "slider";
ui_label="Scan Speed";
ui_tooltip=
"Adjusts the rate of the scan. Lower values mean a slower scan, which can get you better images at the cost of scan speed.";
ui_max = 3.0;
ui_min = 0.0;
> = 1.0;
#line 27
uniform float anim_rate <
source = "framecount";
>;
#line 31
uniform float min_depth <
#line 35
ui_type = "slider";
#line 37
ui_label="Minimum Depth";
ui_tooltip="Unmasks anything before a set depth.";
ui_min=0.0;
ui_max=1.0;
> = 0;
#line 43
texture texColorBuffer: COLOR;
#line 45
texture ssTexture {
Height = 995;
Width = 1799;
};
#line 50
sampler samplerColor {
Texture = texColorBuffer;
#line 53
Width = 1799;
Height = 995;
Format = RGBA16;
#line 57
};
#line 59
sampler ssTarget {
Texture = ssTexture;
#line 62
AddressU = WRAP;
AddressV = WRAP;
AddressW = WRAP;
#line 66
Height = 995;
Width = 1799;
Format = RGBA16;
};
#line 73
void FullScreenVS(uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD0)
{
#line 76
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
#line 81
if (id == 1)
texcoord.y  = 2.0;
else
texcoord.y = 0.0;
#line 86
position = float4( texcoord * float2(2, -2) + float2(-1, 1), 0, 1);
};
#line 89
void SlitScan(float4 pos : SV_Position, float2 texcoord : TEXCOORD0, out float4 color : SV_TARGET)
{
float4 col_pixels =  tex2D(samplerColor, float2(x_col, texcoord.y));
const float pix_w =  scan_speed * (1.0 / 1799);
#line 94
float slice_to_fill = (anim_rate * pix_w) % 1;
#line 96
float4 cols = tex2Dfetch(ssTarget, texcoord);
float4 col_to_write = tex2Dfetch(ssTarget, texcoord);
if(texcoord.x >= slice_to_fill - pix_w && texcoord.x <= slice_to_fill + pix_w)
col_to_write.rgba = col_pixels.rgba;
else
discard;
color = col_to_write;
};
#line 105
void SlitScanPost(float4 pos : SV_Position, float2 texcoord : TEXCOORD0, out float4 color : SV_TARGET)
{
const float depth = ReShade::GetLinearizedDepth(texcoord).r;
float2 uv = texcoord;
float4 screen = tex2D(samplerColor, texcoord);
float pix_w =  scan_speed * (1.0 / 1799);
uv.x +=  (anim_rate * pix_w) - x_col % 1 ;
float4 scanned = tex2D(ssTarget, uv);
#line 115
float4 mask = step(texcoord.x, x_col);
if(depth >= min_depth)
color = lerp(screen, scanned, mask);
else
color = screen;
#line 122
color.rgb += TriDither(color.rgb, texcoord, 8);
#line 124
}
#line 128
technique SlitScan <
ui_label="Slit Scan";
> {
pass p0 {
#line 133
VertexShader = FullScreenVS;
PixelShader = SlitScan;
#line 136
RenderTarget = ssTexture;
}
#line 139
pass p1 {
#line 141
VertexShader = FullScreenVS;
PixelShader = SlitScanPost;
#line 144
}
}
