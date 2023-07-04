#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AdaptiveColorGrading.fx"
#line 21
uniform bool DebugLuma <
ui_label = "Show Luma Debug Bars";
ui_tooltip = "Draws debug bars on top left of screen";
> = false;
#line 26
uniform bool DebugLumaOutput <
ui_label = "Show Luma Output";
ui_tooltip = "Black/White blurry mode!";
> = false;
#line 31
uniform bool DebugLumaOutputHQ <
ui_label = "Show Luma Output at Native Resolution";
ui_tooltip = "Black/White mode!";
> = false;
#line 36
uniform bool EnableHighlightsInDarkScenes <
ui_label = "Enable Highlights";
ui_tooltip = "Add highlights to bright objects when in dark scenes";
> = true;
#line 41
uniform bool DebugHighlights <
ui_label = "Show Debug Highlights";
ui_tooltip = "If any highlights are in the frame, this colours them magenta";
> = false;
#line 46
uniform float LumaChangeSpeed <
ui_label = "Adaptation Speed";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.05;
#line 53
uniform float LumaHigh <
ui_label = "Luma Max Threshold";
ui_tooltip = "Luma above this level uses full Daytime LUT\nSet higher than Min Threshold";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.75;
#line 61
uniform float LumaLow <
ui_label = "Luma Min Threshold";
ui_tooltip = "Luma below this level uses full NightTime LUT\nSet lower than Max Threshold";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.2;
#line 69
uniform float AmbientHighlightThreshold <
ui_label = "Low Luma Highlight Start";
ui_tooltip = "If average luma falls below this limit, start adding highlights\nSimulates HDR look in low light";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.5;
#line 77
uniform float HighlightThreshold <
ui_label = "Minimum Luma For Highlights";
ui_tooltip = "Any luma value above this will have highlights\nSimulates HDR look in low light";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.5;
#line 85
uniform float HighlightMaxThreshold <
ui_label = "Max Luma For Highlights";
ui_tooltip = "Highlights reach maximum strength at this luma value\nSimulates HDR look in low light";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.8;
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
#line 93 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\AdaptiveColorGrading.fx"
#line 99
texture LumaInputTex { Width = 3440; Height = 1440; Format = R8; MipLevels = 6; };
sampler LumaInputSampler { Texture = LumaInputTex; MipLODBias = 6.0f; };
sampler LumaInputSamplerHQ { Texture = LumaInputTex; };
#line 103
texture LumaTex { Width = 1; Height = 1; Format = R8; };
sampler LumaSampler { Texture = LumaTex; };
#line 106
texture LumaTexLF { Width = 1; Height = 1; Format = R8; };
sampler LumaSamplerLF { Texture = LumaTexLF; };
#line 109
texture texLUTDay < source =  "lutDAY.png"; > { Width =  32* 32; Height =  32; Format = RGBA8; };
sampler	SamplerLUTDay	{ Texture = texLUTDay; };
#line 112
texture texLUTNight < source =  "lutNIGHT.png"; > { Width =  32* 32; Height =  32; Format = RGBA8; };
sampler	SamplerLUTNight	{ Texture = texLUTNight; };
#line 115
float SampleLuma(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target {
float luma = 0.0;
#line 118
const int width = 3440 / 64;
const int height = 1440 / 64;
#line 121
for (int i = width/3; i < 2*width/3; i++) {
for (int j = height/3; j < 2*height/3; j++) {
luma += tex2Dlod(LumaInputSampler, float4(i, j, 0, 6)).x;
}
}
#line 127
luma /= (width * 1/3) * (height * 1/3);
#line 129
const float lastFrameLuma = tex2D(LumaSamplerLF, float2(0.5, 0.5)).x;
#line 131
return lerp(lastFrameLuma, luma, LumaChangeSpeed);
}
#line 134
float LumaInput(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target {
const float3 color = tex2D(ReShade::BackBuffer, texcoord).xyz;
#line 137
return pow(abs((color.r*2 + color.b + color.g*3) / 6), 1/2.2);
}
#line 140
float3 ApplyLUT(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target {
float3 color = tex2D(ReShade::BackBuffer, texcoord.xy).rgb;
const float lumaVal = tex2D(LumaSampler, float2(0.5, 0.5)).x;
const float highlightLuma = tex2D(LumaInputSamplerHQ, texcoord.xy).x;
#line 145
if (DebugLumaOutputHQ) {
return highlightLuma;
}
else if (DebugLumaOutput) {
return lumaVal;
}
#line 152
if (DebugLuma) {
if (texcoord.y <= 0.01 && texcoord.x <= 0.01) {
return lumaVal;
}
if (texcoord.y <= 0.01 && texcoord.x > 0.01 && texcoord.x <= 0.02) {
if (lumaVal > LumaHigh) {
return float3(1.0, 1.0, 1.0);
}
else {
return float3(0.0, 0.0, 0.0);
}
}
if (texcoord.y <= 0.01 && texcoord.x > 0.02 && texcoord.x <= 0.03) {
if (lumaVal <= LumaHigh && lumaVal >= LumaLow) {
return float3(1.0, 1.0, 1.0);
}
else {
return float3(0.0, 0.0, 0.0);
}
}
if (texcoord.y <= 0.01 && texcoord.x > 0.03 && texcoord.x <= 0.04) {
if (lumaVal < LumaLow) {
return float3(1.0, 1.0, 1.0);
}
else {
return float3(0.0, 0.0, 0.0);
}
}
}
#line 182
float2 texelsize = 1.0 /  32;
texelsize.x /=  32;
#line 185
float3 lutcoord = float3((color.xy* 32-color.xy+0.5)*texelsize.xy,color.z* 32-color.z);
const float lerpfact = frac(lutcoord.z);
#line 188
lutcoord.x += (lutcoord.z-lerpfact)*texelsize.y;
#line 190
const float3 color1 = lerp(tex2D(SamplerLUTDay, lutcoord.xy).xyz, tex2D(SamplerLUTDay, float2(lutcoord.x+texelsize.y,lutcoord.y)).xyz,lerpfact);
const float3 color2 = lerp(tex2D(SamplerLUTNight, lutcoord.xy).xyz, tex2D(SamplerLUTNight, float2(lutcoord.x+texelsize.y,lutcoord.y)).xyz,lerpfact);
#line 193
const float range = (lumaVal - LumaLow)/(LumaHigh - LumaLow);
#line 195
if (lumaVal > LumaHigh) {
color.xyz = color1.xyz;
}
else if (lumaVal < LumaLow) {
color.xyz = color2.xyz;
}
else {
color.xyz = lerp(color2.xyz, color1.xyz, range);
}
#line 205
float3 lutcoord2 = float3((color.xy* 32-color.xy+0.5)*texelsize.xy,color.z* 32-color.z);
const float lerpfact2 = frac(lutcoord2.z);
#line 208
lutcoord2.x += (lutcoord2.z-lerpfact2)*texelsize.y;
#line 210
const float3 highlightColor = lerp(tex2D(SamplerLUTDay, lutcoord2.xy).xyz, tex2D(SamplerLUTDay, float2(lutcoord2.x+texelsize.y,lutcoord2.y)).xyz,lerpfact2);
#line 213
if (EnableHighlightsInDarkScenes) {
if (lumaVal < AmbientHighlightThreshold && highlightLuma > HighlightThreshold) {
const float range = saturate((highlightLuma - HighlightThreshold)/(HighlightMaxThreshold - HighlightThreshold)) *
saturate((AmbientHighlightThreshold - lumaVal)/(0.1));
#line 218
if (DebugHighlights) {
color.xyz = lerp(color.xyz, float3(1.0, 0.0, 1.0), range);
#line 221
if (range >= 1.0) {
color.xyz = float3(1.0, 0.0, 0.0);
}
}
#line 226
color.xyz = lerp(color.xyz, highlightColor.xyz, range);
}
}
#line 232
return color;
#line 234
}
#line 236
float SampleLumaLF(float4 position : SV_Position, float2 texcoord: TexCoord) : SV_Target {
return tex2D(LumaSampler, float2(0.5, 0.5)).x;
}
#line 240
technique AdaptiveColorGrading {
pass Input {
VertexShader = PostProcessVS;
PixelShader = LumaInput;
RenderTarget = LumaInputTex
;
}
pass StoreLuma {
VertexShader = PostProcessVS;
PixelShader = SampleLuma;
RenderTarget = LumaTex;
}
pass Apply_LUT {
VertexShader = PostProcessVS;
PixelShader = ApplyLUT;
}
pass StoreLumaLF {
VertexShader = PostProcessVS;
PixelShader = SampleLumaLF;
RenderTarget = LumaTexLF;
}
}

