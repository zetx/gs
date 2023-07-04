#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HexLensFlare.fx"
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
#line 4 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HexLensFlare.fx"
#line 50
static const float cAspectRatio = 5360 * (1.0 / 1440);
static const float2 cPixelSize = float2((1.0 / 5360), (1.0 / 1440));
static const float2 cScreenSize = float2(5360, 1440);
#line 55
static const float c2PI = 3.14159 * 2.0;
#line 61
uniform float uIntensity <
ui_label = "Intensity";
ui_category = "Lens Flare";
ui_tooltip = "Default: 1.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 3.0;
ui_step = 0.001;
> = 1.0;
#line 71
uniform float uThreshold <
ui_label = "Threshold";
ui_category = "Lens Flare";
ui_tooltip = "Default: 0.99";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.95;
#line 81
uniform float uScale <
ui_label = "Scale";
ui_category = "Lens Flare";
ui_tooltip = "Default: 1.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
ui_step = 0.001;
> = 1.0;
#line 91
uniform float3 uColor0 <
ui_label = "#1";
ui_category = "Colors";
ui_tooltip = "Default: R:147 G:255 B:0";
ui_type = "color";
> = float3(147, 255, 0) / 255.0;
#line 98
uniform float3 uColor1 <
ui_label = "#2";
ui_category = "Colors";
ui_tooltip = "Default: R:66 G:151 B:255";
ui_type = "color";
> = float3(66, 151, 255) / 255.0;
#line 105
uniform float3 uColor2 <
ui_label = "#3";
ui_category = "Colors";
ui_tooltip = "Default: R:255 G:147 B:0";
ui_type = "color";
> = float3(255, 147, 0) / 255.0;
#line 112
uniform float3 uColor3 <
ui_label = "#4";
ui_category = "Colors";
ui_tooltip = "Default: R:100 G:236 B:255";
ui_type = "color";
> = float3(100, 236, 255) / 255.0;
#line 135
texture2D tHexLensFlare_Color : COLOR;
sampler2D sColor {
Texture = tHexLensFlare_Color;
#line 139
SRGBTexture = true;
#line 141
AddressU = BORDER;
AddressV = BORDER;
};
#line 145
texture2D tHexLensFlare_Prepare {
Width = 5360 /  4;
Height = 1440 /  4;
Format = RGBA16F;
};
sampler2D sPrepare {
Texture = tHexLensFlare_Prepare;
};
#line 154
texture2D tHexLensFlare_VerticalBlur {
Width = 5360 /  4;
Height = 1440 /  4;
Format = RGBA16F;
};
sampler2D sVerticalBlur {
Texture = tHexLensFlare_VerticalBlur;
};
#line 163
texture2D tHexLensFlare_DiagonalBlur {
Width = 5360 /  4;
Height = 1440 /  4;
Format = RGBA16F;
};
sampler2D sDiagonalBlur {
Texture = tHexLensFlare_DiagonalBlur;
};
#line 172
texture2D tHexLensFlare_RhomboidBlur {
Width = 5360 /  4;
Height = 1440 /  4;
Format = RGBA16F;
};
sampler2D sRhomboidBlur {
Texture = tHexLensFlare_RhomboidBlur;
};
#line 189
float2 scale(float2 uv, float2 s, float2 c) {
return (uv - c) * s + c;
}
#line 193
float2 scale(float2 uv, float2 s) {
return scale(uv, s, 0.5);
}
#line 197
float3 blur(sampler2D sp, float2 uv, float2 dir) {
float4 color = 0.0;
#line 200
dir *=  4 * uScale;
uv += dir * 0.5;
#line 203
[loop]
for (int i = 0; i <  16; ++i)
color += float4(tex2D(sp, uv + dir * i).rgb, 1.0);
#line 207
return color.rgb / color.a;
}
#line 210
float get_light(sampler2D sp, float2 uv, float t) {
return step(t, dot(tex2D(sp, uv).rgb, 0.333));
}
#line 218
void VS_PostProcess(
uint id : SV_VERTEXID,
out float4 position : SV_POSITION,
out float2 uv : TEXCOORD
) {
if (id == 2)
uv.x = 2.0;
else
uv.x = 0.0;
if (id == 1)
uv.y = 2.0;
else
uv.y = 0.0;
position = float4(
uv * float2(2.0, -2.0) + float2(-1.0, 1.0),
0.0,
1.0
);
}
#line 238
float4 PS_Prepare(
float4 position : SV_POSITION,
float2 uv : TEXCOORD
) : SV_TARGET {
uv = 1.0 - uv;
#line 244
float3 color = 0.0;
color += get_light(sColor, uv, uThreshold) * uColor0;
color += get_light(sColor, scale(uv, 3.0), uThreshold) * uColor1;
color += get_light(sColor, scale(uv, 9.0), uThreshold) * uColor2;
color += get_light(sColor, scale(1.0 - uv, 0.666), uThreshold) * uColor3;
#line 250
return float4(color, 1.0);
}
#line 253
float4 PS_VerticalBlur(
float4 position : SV_POSITION,
float2 uv : TEXCOORD
) : SV_TARGET {
const float2 dir = cPixelSize * float2(cos(c2PI / 2), sin(c2PI / 2));
#line 259
return float4(blur(sPrepare, uv, dir), 1.0);
}
#line 262
float4 PS_DiagonalBlur(
float4 position : SV_POSITION,
float2 uv : TEXCOORD
) : SV_TARGET {
const float2 dir = cPixelSize * float2(cos(-c2PI / 6), sin(-c2PI / 6));
float3 color = blur(sPrepare, uv, dir);
color += tex2D(sVerticalBlur, uv).rgb;
#line 270
return float4(color, 1.0);
}
#line 273
float4 PS_RhomboidBlur(
float4 position : SV_POSITION,
float2 uv : TEXCOORD
) : SV_TARGET {
const float2 dir1 = cPixelSize * float2(cos(-c2PI / 6), sin(-c2PI / 6));
const float3 color1 = blur(sVerticalBlur, uv, dir1);
#line 280
const float2 dir2 = cPixelSize * float2(cos(-5 * c2PI / 6), sin(-5 * c2PI / 6));
const float3 color2 = blur(sDiagonalBlur, uv, dir2);
#line 283
return float4((color1 + color2) * 0.5, 1.0);
}
#line 286
float4 PS_Blend(
float4 position : SV_POSITION,
float2 uv : TEXCOORD
) : SV_TARGET {
float3 color = tex2D(sColor, uv).rgb;
const float3 result = tex2D(sRhomboidBlur, uv).rgb;
#line 293
color = 1.0 - (1.0 - color) * (1.0 - result * uIntensity);
#line 303
return float4(color + TriDither(color, uv, 8), 1.0);
#line 307
}
#line 313
technique HexLensFlare {
pass Prepare {
VertexShader = VS_PostProcess;
PixelShader = PS_Prepare;
RenderTarget = tHexLensFlare_Prepare;
}
pass VerticalBlur {
VertexShader = VS_PostProcess;
PixelShader = PS_VerticalBlur;
RenderTarget = tHexLensFlare_VerticalBlur;
}
pass DiagonalBlur {
VertexShader = VS_PostProcess;
PixelShader = PS_DiagonalBlur;
RenderTarget = tHexLensFlare_DiagonalBlur;
}
pass RhomboidBlur {
VertexShader = VS_PostProcess;
PixelShader = PS_RhomboidBlur;
RenderTarget = tHexLensFlare_RhomboidBlur;
}
pass Blend {
VertexShader = VS_PostProcess;
PixelShader = PS_Blend;
#line 339
SRGBWriteEnable = true;
#line 341
}
}

