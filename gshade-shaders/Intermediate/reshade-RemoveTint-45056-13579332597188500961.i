#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RemoveTint.fx"
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
#line 2 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RemoveTint.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RemoveTint.fx"
#line 8
uniform float fUISpeed <
ui_type = "slider";
ui_label = "Adaptions Speed";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.01;
> = 0.1;
#line 15
uniform bool bUIUseExcludeColor <
ui_spacing = 5;
ui_tooltip = "Enable this to exclude a certain color from being used in the min/max-RGB calculation. Can reduce the impact of the game UI.";
ui_type = "radio";
ui_label = "Enable Exclude Color";
> = false;
#line 22
uniform float3 fUIExcludeColor <
ui_type = "color";
ui_label = "Exclude Color";
> = float3(1.0, 1.0, 1.0);
#line 27
uniform float fUIExcludeColorStrength <
ui_type = "slider";
ui_label = "Strength";
ui_min = 1.0; ui_max = 4.0;
> = 3.0;
#line 33
uniform int cUIDebug <
ui_type = "combo";
ui_label = "Debug";
ui_items = "Off\0Show Diff To Avg. RGB\0";
> = 0;
#line 39
uniform float fUIStrength <
ui_spacing = 5;
ui_type = "slider";
ui_label = "Strength";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.01;
> = 1.0;
#line 47
uniform float frametime < source = "frametime"; >;
#line 49
namespace RemoveTint {
#line 55
texture2D texBackBuffer { Width = 3440/ 16; Height = 1440/ 16; Format = RGBA16F; };
sampler2D samplerBackBuffer { Texture = texBackBuffer; };
#line 58
texture2D texMinRGB { Width = 1; Height = 1; Format = RGBA16F; };
sampler2D samplerMinRGB { Texture = texMinRGB; };
texture2D texMaxRGB { Width = 1; Height = 1; Format = RGBA16F; };
sampler2D samplerMaxRGB { Texture = texMaxRGB; };
#line 63
texture2D texMinRGBLastFrame { Width = 1; Height = 1; Format = RGBA16F; };
sampler2D samplerMinRGBLastFrame { Texture = texMinRGBLastFrame; };
texture2D texMaxRGBLastFrame { Width = 1; Height = 1; Format = RGBA16F; };
sampler2D samplerMaxRGBLastFrame { Texture = texMaxRGBLastFrame; };
#line 68
float LerpValue(float luma, float2 values) {
return ((smoothstep(0.0, 1.0, 4.0 * luma - ((1.0 - values.x) *2.0 - 1.0)) + (1.0 - smoothstep(0.0, 1.0, 4.0 * luma - (2.0 + (values.y)*2.0)))) * 0.5 - 0.5) * 2.0;
}
#line 72
void BackBuffer_PS(float4 vpos : SV_Position, float2 texcoord : TexCoord, out float4 backbuffer : SV_Target0) {
backbuffer = tex2Dfetch(ReShade::BackBuffer, int2(vpos.xy *  16), 0);
}
#line 76
void MinMaxRGB_PS(float4 vpos : SV_Position, float2 texcoord : TexCoord, out float4 resultMinRGB : SV_Target0, out float4 resultMaxRGB : SV_Target1) {
float diff;
float brightnessFilter;
float luma;
float lerpValue;
float3 color;
float4 currentMinRGB = 1.0.rrrr;
float4 currentMaxRGB = 0.0.rrrr;
#line 85
const int2 size =  float2(3440, 1440) /  16;
#line 87
for(int y = 0; y < size.y; y++) {
for(int x = 0; x < size.x; x++) {
color = tex2Dfetch(RemoveTint::samplerBackBuffer, int2(x, y), 0).rgb;
luma = dot(color, float3(0.2126, 0.7151, 0.0721));
diff = saturate(pow(abs(dot(color, fUIExcludeColor)), fUIExcludeColorStrength));
if (bUIUseExcludeColor)
lerpValue = 1.0 - diff;
else
lerpValue = 1.0;
#line 97
currentMaxRGB.r = lerp(currentMaxRGB.r, color.r, min(step(currentMaxRGB.r, color.r), lerpValue));
currentMaxRGB.g = lerp(currentMaxRGB.g, color.g, min(step(currentMaxRGB.g, color.g), lerpValue));
currentMaxRGB.b = lerp(currentMaxRGB.b, color.b, min(step(currentMaxRGB.b, color.b), lerpValue));
#line 101
currentMinRGB.r = lerp(currentMinRGB.r, color.r, min(step(color.r, currentMinRGB.r), lerpValue));
currentMinRGB.g = lerp(currentMinRGB.g, color.g, min(step(color.g, currentMinRGB.g), lerpValue));
currentMinRGB.b = lerp(currentMinRGB.b, color.b, min(step(color.b, currentMinRGB.b), lerpValue));
}
}
#line 107
const float4 lastMinRGB = tex2Dfetch(RemoveTint::samplerMinRGBLastFrame, int2(0, 0), 0);
const float4 lastMaxRGB = tex2Dfetch(RemoveTint::samplerMaxRGBLastFrame, int2(0, 0), 0);
#line 110
resultMinRGB = saturate(lerp(lastMinRGB, currentMinRGB, saturate(fUISpeed * frametime * 0.01)));
resultMaxRGB = saturate(lerp(lastMaxRGB, currentMaxRGB, saturate(fUISpeed * frametime * 0.01)));
resultMinRGB.a = 1.0;
resultMaxRGB.a = 1.0;
}
#line 116
void MinMaxRGBBackup_PS(float4 vpos : SV_Position, float2 texcoord : TexCoord, out float4 currentMinRGB : SV_Target0, out float4 currentMaxRGB : SV_Target1) {
currentMinRGB = tex2Dfetch(RemoveTint::samplerMinRGB, int2(0, 0), 0);
currentMaxRGB = tex2Dfetch(RemoveTint::samplerMaxRGB, int2(0, 0), 0);
}
#line 121
float4 Apply_PS(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target {
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
const float3 MinRGB = tex2Dfetch(RemoveTint::samplerMinRGB, int2(0, 0), 0).rgb;
const float3 MaxRGB = tex2Dfetch(RemoveTint::samplerMaxRGB, int2(0, 0), 0).rgb;
const float3 colorNormalize = (color - MinRGB) / (MaxRGB-MinRGB);
float3 tintRemoved = colorNormalize;
#line 128
tintRemoved = normalize(tintRemoved) * length(color).rrr;
#line 130
tintRemoved = lerp(tintRemoved, color, saturate(pow(abs(dot(color, fUIExcludeColor)), fUIExcludeColorStrength)));
#line 133
const float3 outcolor = saturate(lerp(color, tintRemoved, fUIStrength)).rgb;
return float4(outcolor + TriDither(outcolor, texcoord, 8), 1.0);
#line 138
}
}
#line 141
technique RemoveTint
{
pass {
VertexShader = PostProcessVS;
PixelShader = RemoveTint::BackBuffer_PS;
RenderTarget = RemoveTint::texBackBuffer;
}
pass {
VertexShader = PostProcessVS;
PixelShader = RemoveTint::MinMaxRGB_PS;
RenderTarget0 = RemoveTint::texMinRGB;
RenderTarget1 = RemoveTint::texMaxRGB;
}
pass {
VertexShader = PostProcessVS;
PixelShader = RemoveTint::MinMaxRGBBackup_PS;
RenderTarget0 = RemoveTint::texMinRGBLastFrame;
RenderTarget1 = RemoveTint::texMaxRGBLastFrame;
}
pass {
VertexShader = PostProcessVS;
PixelShader = RemoveTint::Apply_PS;
#line 164
}
}

