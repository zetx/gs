#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BadBloomPS2.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 3440 * (1.0 / 1440); }
float2 GetPixelSize() { return float2((1.0 / 3440), (1.0 / 1440)); }
float2 GetScreenSize() { return float2(3440, 1440); }
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
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BadBloomPS2.fx"
#line 11
uniform float3 uColor <
ui_label = "Color";
ui_type = "color";
> = float3(1.0,1.0,1.0);
#line 16
uniform float uAmount <
ui_label = "Amount";
ui_tooltip = "Default: 1.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
ui_step = 0.001;
> = 1.0;
#line 25
uniform float uThreshold <
ui_label = "Threshold";
ui_tooltip =
"Minimum pixel brightness required to generate bloom.\n"
"Anything below this will be cut-off before blurring.\n"
"Default: 0.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.0;
#line 37
uniform float uCutOff <
ui_label = "Cut-Off";
ui_tooltip =
"Same as threshold but applied to the post-blur bloom texture.\n"
"Anything below this will be be cut-off after blurring.\n"
"Default: 0.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.0;
#line 49
uniform float uCurve <
ui_label = "Curve";
ui_tooltip = "Default: 1.0";
ui_type = "slider";
ui_min = 0.001;
ui_max = 10.0;
ui_step = 0.01;
> = 1.0;
#line 58
uniform float2 uScale <
ui_label = "Scale";
ui_tooltip = "Default: 1.0 1.0";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
ui_step = 0.001;
> = float2(1, 1);
#line 67
uniform float uMaxBrightness <
ui_label = "Max Brightness";
ui_tooltip = "Default: 100.0";
ui_type = "slider";
ui_min = 1.0;
ui_max = 1000.0;
ui_step = 1.0;
> = 100.0;
#line 76
texture tBadBloom_Threshold {
Width = 3440 /  8;
Height = 1440 /  8;
Format = RGBA16F;
};
sampler sThreshold {
Texture = tBadBloom_Threshold;
};
#line 85
texture tBadBloom_Blur {
Width = 3440 /  8;
Height = 1440 /  8;
};
sampler sBlur {
Texture = tBadBloom_Blur;
};
#line 93
float4 gamma(float4 col, float g)
{
const float i = 1.0 / g;
return float4(pow(col.x, i)
, pow(col.y, i)
, pow(col.z, i)
, col.w);
}
#line 102
float3 jodieReinhardTonemap(float3 c){
const float l = dot(c, float3(0.2126, 0.7152, 0.0722));
const float3 tc = c / (c + 1.0);
#line 106
return lerp(c / (l + 1.0), tc, tc);
}
#line 109
float3 inv_reinhard(float3 color, float inv_max) {
return (color / max(1.0 - color, inv_max));
}
#line 113
float3 inv_reinhard_lum(float3 color, float inv_max) {
float lum = max(color.r, max(color.g, color.b));
return color * (lum / max(1.0 - lum, inv_max));
}
#line 118
float3 reinhard(float3 color) {
return color / (1.0 + color);
}
#line 122
float4 PS_Threshold(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET {
float4 color = tex2D(ReShade::BackBuffer, uv);
#line 126
color.rgb = inv_reinhard(color.rgb, 1.0 / uMaxBrightness);
#line 128
color.rgb *= step(uThreshold, dot(color.rgb, float3(0.299, 0.587, 0.114)));
color.rgb = pow(abs(color.rgb), uCurve);
#line 131
return color;
}
#line 134
float4 PS_Blur(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET {
float4 color = tex2D(sThreshold,uv);
const float2 pix = uScale *  float2((1.0 / 3440), (1.0 / 1440));
#line 138
color = tex2D(sThreshold, uv) * 0.204164;
#line 141
color += tex2D(sThreshold, uv + float2(pix.x * 8 * 1.407333,0)) * 0.304005;
color += tex2D(sThreshold, uv - float2(pix.x * 4 * 1.407333,0)) * 0.304005;
color += tex2D(sThreshold, uv + float2(pix.x * 2 * 3.294215,0)) * 0.093913;
color += tex2D(sThreshold, uv - float2(pix.x * 1 * 3.294215,0)) * 0.093913;
#line 147
color += tex2D(sThreshold,( uv + float2(0,pix.y * 8 * 1.407333))) * 0.304005;
color += tex2D(sThreshold,( uv - float2(0,pix.y * 4 * 1.407333))) * 0.304005;
color += tex2D(sThreshold,( uv + float2(0,pix.y * 2 * 3.294215))) * 0.093913;
color += tex2D(sThreshold,( uv - float2(0,pix.y * 1 * 3.294215))) * 0.093913;
#line 152
color *= 0.25;
return color;
}
#line 156
float4 PS_Blend(float4 p : SV_POSITION, float2 uv : TEXCOORD) : SV_TARGET {
float4 color = tex2D(ReShade::BackBuffer, uv);
color.rgb = inv_reinhard(color.rgb, 1.0 / uMaxBrightness);
#line 160
float4 blur = tex2D(sBlur, uv);
blur *= step(uCutOff, blur);
#line 163
color.rgb = mad(blur.rgb, uAmount * uColor, color.rgb);
color.rgb = reinhard(color.rgb);
#line 169
return color;
#line 171
}
#line 173
technique BadBloomPS2 {
pass Threshold {
VertexShader = PostProcessVS;
PixelShader = PS_Threshold;
RenderTarget = tBadBloom_Threshold;
}
pass BlurPS2 {
VertexShader = PostProcessVS;
PixelShader = PS_Blur;
RenderTarget = tBadBloom_Blur;
}
pass BlendPS2 {
VertexShader = PostProcessVS;
PixelShader = PS_Blend;
}
}
