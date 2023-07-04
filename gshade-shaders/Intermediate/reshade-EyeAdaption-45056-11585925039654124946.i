#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\EyeAdaption.fx"
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
#line 13 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\EyeAdaption.fx"
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
#line 16 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\EyeAdaption.fx"
#line 20
uniform float fAdp_Delay <
ui_label = "Adaption Delay";
ui_tooltip = "How fast the image adapts to brightness changes.\n"
"0 = instantanous adaption\n"
"2 = very slow adaption";
ui_category = "General settings";
ui_type = "slider";
ui_min = 0.0;
ui_max = 2.0;
> = 1.6;
#line 31
uniform float fAdp_TriggerRadius <
ui_label = "Adaption TriggerRadius";
ui_tooltip = "Screen area, whose average brightness triggers adaption.\n"
"1 = only the center of the image is used\n"
"7 = the whole image is used";
ui_category = "General settings";
ui_type = "slider";
ui_min = 1.0;
ui_max = 7.0;
ui_step = 0.1;
> = 6.0;
#line 43
uniform float fAdp_YAxisFocalPoint <
ui_label = "Y Axis Focal Point";
ui_tooltip = "Where along the Y Axis the Adaption TriggerRadius applies.\n"
"0 = Top of the screen\n"
"1 = Bottom of the screen";
ui_category = "General settings";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.5;
#line 54
uniform float fAdp_Equilibrium <
ui_label = "Adaption Equilibrium";
ui_tooltip = "The value of image brightness for which there is no brightness adaption.\n"
"0 = late brightening, early darkening\n"
"1 = early brightening, late darkening";
ui_category = "General settings";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.5;
#line 65
uniform float fAdp_Strength <
ui_label = "Adaption Strength";
ui_tooltip = "Base strength of brightness adaption.\n";
ui_category = "General settings";
ui_type = "slider";
ui_min = 0.0;
ui_max = 2.0;
> = 1.0;
#line 74
uniform bool bAdp_IgnoreOccludedByUI <
ui_label = "Ignore Trigger Area if Occluded by UI (FFXIV)";
ui_category = "General settings";
> = 0;
#line 79
uniform float fAdp_IgnoreTreshold <
ui_label = "Ignore Alpha Treshold";
ui_tooltip = "How visible the UI must be to be ignored"
"0 = any UI, including window shadows prevents occlusion"
"1 = only 100% opaque windows prevent occlusion";
ui_category = "General settings";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.2;
#line 90
uniform float fAdp_BrightenHighlights <
ui_label = "Brighten Highlights";
ui_tooltip = "Brightening strength for highlights.";
ui_category = "Brightening";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.1;
#line 99
uniform float fAdp_BrightenMidtones <
ui_label = "Brighten Midtones";
ui_tooltip = "Brightening strength for midtones.";
ui_category = "Brightening";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.2;
#line 108
uniform float fAdp_BrightenShadows <
ui_label = "Brighten Shadows";
ui_tooltip = "Brightening strength for shadows.\n"
"Set this to 0 to preserve pure black.";
ui_category = "Brightening";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.1;
#line 118
uniform float fAdp_DarkenHighlights <
ui_label = "Darken Highlights";
ui_tooltip = "Darkening strength for highlights.\n"
"Set this to 0 to preserve pure white.";
ui_category = "Darkening";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.1;
#line 128
uniform float fAdp_DarkenMidtones <
ui_label = "Darken Midtones";
ui_tooltip = "Darkening strength for midtones.";
ui_category = "Darkening";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.2;
#line 137
uniform float fAdp_DarkenShadows <
ui_label = "Darken Shadows";
ui_tooltip = "Darkening strength for shadows.";
ui_category = "Darkening";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.1;
#line 148
uniform float Frametime < source = "frametime";>;
#line 151
texture2D TexLuma { Width = 256; Height = 256; Format = R8; MipLevels = 7; };
texture2D TexAvgLuma { Format = R16F; };
texture2D TexAvgLumaLast { Format = R16F; };
#line 155
sampler SamplerLuma { Texture = TexLuma; };
sampler SamplerAvgLuma { Texture = TexAvgLuma; };
sampler SamplerAvgLumaLast { Texture = TexAvgLumaLast; };
#line 160
float PS_Luma(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float4 color = tex2Dlod(ReShade::BackBuffer, float4(texcoord, 0, 0));
return dot(color.xyz,  float3(0.212656, 0.715158, 0.072186));
}
#line 166
float PS_AvgLuma(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float avgLumaCurrFrame = tex2Dlod(SamplerLuma, float4(fAdp_YAxisFocalPoint.xx, 0, fAdp_TriggerRadius)).x;
const float avgLumaLastFrame = tex2Dlod(SamplerAvgLumaLast, float4(0.0.xx, 0, 0)).x;
const float uiVisibility = tex2D(ReShade::BackBuffer, float2(0.5, 0.5)).a;
if(bAdp_IgnoreOccludedByUI && uiVisibility > fAdp_IgnoreTreshold)
{
return avgLumaLastFrame;
}
const float delay = sign(fAdp_Delay) * saturate(0.815 + fAdp_Delay / 10.0 - Frametime / 1000.0);
return lerp(avgLumaCurrFrame, avgLumaLastFrame, delay);
}
#line 179
float AdaptionDelta(float luma, float strengthMidtones, float strengthShadows, float strengthHighlights)
{
const float midtones = (4.0 * strengthMidtones - strengthHighlights - strengthShadows) * luma * (1.0 - luma);
const float shadows = strengthShadows * (1.0 - luma);
const float highlights = strengthHighlights * luma;
return midtones + shadows + highlights;
}
#line 187
float4 PS_Adaption(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
float4 color = tex2Dlod(ReShade::BackBuffer, float4(texcoord, 0, 0));
const float avgLuma = tex2Dlod(SamplerAvgLuma, float4(0.0.xx, 0, 0)).x;
#line 192
color.xyz = pow(abs(color.xyz), 1.0/2.2);
float luma = dot(color.xyz,  float3(0.212656, 0.715158, 0.072186));
const float3 chroma = color.xyz - luma;
#line 196
const float avgLumaAdjusted = lerp (avgLuma, 1.4 * avgLuma / (0.4 + avgLuma), fAdp_Equilibrium);
float delta = 0;
#line 199
const float curve = fAdp_Strength * 10.0 * pow(abs(avgLumaAdjusted - 0.5), 4.0);
if (avgLumaAdjusted < 0.5) {
delta = AdaptionDelta(luma, fAdp_BrightenMidtones, fAdp_BrightenShadows, fAdp_BrightenHighlights);
} else {
delta = -AdaptionDelta(luma, fAdp_DarkenMidtones, fAdp_DarkenShadows, fAdp_DarkenHighlights);
}
delta *= curve;
#line 207
luma += delta;
color.xyz = saturate(luma + chroma);
color.xyz = pow(abs(color.xyz), 2.2);
#line 212
return float4(color.xyz + TriDither(color.xyz, texcoord, 8), color.w);
#line 216
}
#line 218
float PS_StoreAvgLuma(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
return tex2Dlod(SamplerAvgLuma, float4(0.0.xx, 0, 0)).x;
}
#line 224
technique EyeAdaption {
#line 226
pass Luma
{
VertexShader = PostProcessVS;
PixelShader = PS_Luma;
RenderTarget = TexLuma;
}
#line 233
pass AvgLuma
{
VertexShader = PostProcessVS;
PixelShader = PS_AvgLuma;
RenderTarget = TexAvgLuma;
}
#line 240
pass Adaption
{
VertexShader = PostProcessVS;
PixelShader = PS_Adaption;
}
#line 246
pass StoreAvgLuma
{
VertexShader = PostProcessVS;
PixelShader = PS_StoreAvgLuma;
RenderTarget = TexAvgLumaLast;
}
}

