#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PPFX_Godrays.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1281 * (1.0 / 721); }
float2 GetPixelSize() { return float2((1.0 / 1281), (1.0 / 721)); }
float2 GetScreenSize() { return float2(1281, 721); }
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
#line 11 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PPFX_Godrays.fx"
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
#line 14 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PPFX_Godrays.fx"
#line 22
uniform int pGodraysSampleAmount <
ui_label = "Sample Amount";
ui_tooltip = "Effectively the ray's resolution. Low values may look coarse but yield a higher framerate.";
ui_type = "slider";
ui_min = 8;
ui_max = 250;
ui_step = 1;
> = 64;
#line 31
uniform float2 pGodraysSource <
ui_label = "Light Source";
ui_tooltip = "The vanishing point of the godrays in screen-space. 0.500,0.500 is the middle of your screen.";
ui_type = "slider";
ui_min = -0.5;
ui_max = 1.5;
ui_step = 0.001;
> = float2(0.5, 0.4);
#line 40
uniform float pGodraysExposure <
ui_label = "Exposure";
ui_tooltip = "Contribution exposure of each single light patch to the final ray. 0.100 should generally be enough.";
ui_type = "slider";
ui_min = 0.01;
ui_max = 1.0;
ui_step = 0.01;
> = 0.1;
#line 49
uniform float pGodraysFreq <
ui_label = "Frequency";
ui_tooltip = "Higher values result in a higher density of the single rays. '1.000' leads to rays that'll always cover the whole screen. Balance between falloff, samples and this value.";
ui_type = "slider";
ui_min = 1.0;
ui_max = 10.0;
ui_step = 0.001;
> = 1.2;
#line 58
uniform float pGodraysThreshold <
ui_label = "Threshold";
ui_tooltip = "Pixels darker than this value won't cast rays.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 0.65;
#line 67
uniform float pGodraysFalloff <
ui_label = "Falloff";
ui_tooltip = "Lets the rays' brightness fade/falloff with their distance from the light source specified in 'Light Source'.";
ui_type = "slider";
ui_min = 1.0;
ui_max = 2.0;
ui_step = 0.001;
> = 1.06;
#line 81
texture texColorGRA { Width = 1281; Height = 721; Format = RGBA16F; };
texture texColorGRB < pooled = true; > { Width = 1281; Height = 721; Format = RGBA16F; };
texture texGameDepth : DEPTH;
#line 91
sampler SamplerColorGRA
{
Texture = texColorGRA;
AddressU = BORDER;
AddressV = BORDER;
MinFilter = LINEAR;
MagFilter = LINEAR;
};
#line 100
sampler SamplerColorGRB
{
Texture = texColorGRB;
AddressU = BORDER;
AddressV = BORDER;
MinFilter = LINEAR;
MagFilter = LINEAR;
};
#line 109
sampler2D SamplerDepth
{
Texture = texGameDepth;
};
#line 118
static const float3 lumaCoeff = float3(0.2126f,0.7152f,0.0722f);
#line 126
struct VS_OUTPUT_POST
{
float4 vpos : SV_Position;
float2 txcoord : TEXCOORD0;
};
#line 132
struct VS_INPUT_POST
{
uint id : SV_VertexID;
};
#line 141
float linearDepth(float2 txCoords)
{
return (2.0* 0.3)/( 50.0+ 0.3-tex2D(SamplerDepth,txCoords).x*( 50.0- 0.3));
}
#line 151
float4 FX_Godrays( float4 pxInput, float2 txCoords )
{
const float2	stepSize = (txCoords-pGodraysSource) / (pGodraysSampleAmount*pGodraysFreq);
float3	rayMask = 0.0;
float	rayWeight = 1.0;
float	finalWhitePoint = pxInput.w;
#line 158
[loop]
for (int i=1;i<(int)pGodraysSampleAmount;i++)
{
rayMask += saturate(saturate(tex2Dlod(SamplerColorGRB, float4(txCoords-stepSize*(float)i, 0.0, 0.0)).xyz) - pGodraysThreshold) * rayWeight * pGodraysExposure;
finalWhitePoint += rayWeight * pGodraysExposure;
rayWeight /= pGodraysFalloff;
}
#line 166
rayMask.xyz = dot(rayMask.xyz,lumaCoeff.xyz) / (finalWhitePoint-pGodraysThreshold);
return float4(pxInput.xyz+rayMask.xyz,finalWhitePoint);
}
#line 174
VS_OUTPUT_POST VS_PostProcess(VS_INPUT_POST IN)
{
VS_OUTPUT_POST OUT;
#line 178
if (IN.id == 2)
OUT.txcoord.x = 2.0;
else
OUT.txcoord.x = 0.0;
#line 183
if (IN.id == 1)
OUT.txcoord.y = 2.0;
else
OUT.txcoord.y = 0.0;
#line 188
OUT.vpos = float4(OUT.txcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
return OUT;
}
#line 199
float4 PS_LightFX(VS_OUTPUT_POST IN) : COLOR
{
const float2 pxCoord = IN.txcoord.xy;
const float4 res = tex2D(ReShade::BackBuffer,pxCoord);
#line 204
return FX_Godrays(res,pxCoord.xy);
}
#line 207
float4 PS_ColorFX(VS_OUTPUT_POST IN) : COLOR
{
const float2 pxCoord = IN.txcoord.xy;
const float4 res = tex2D(SamplerColorGRA,pxCoord);
#line 212
return float4(res.xyz,1.0);
}
#line 215
float4 PS_ImageFX(VS_OUTPUT_POST IN) : COLOR
{
const float2 pxCoord = IN.txcoord.xy;
const float4 res = tex2D(SamplerColorGRB,pxCoord);
#line 221
return float4(res.xyz + TriDither(res.xyz, IN.txcoord, 8), 1.0);
#line 225
}
#line 231
technique PPFX_Godrays < ui_label = "PPFX Godrays"; ui_tooltip = "Godrays | Lets bright areas cast rays on the screen."; >
{
pass lightFX
{
VertexShader = VS_PostProcess;
PixelShader = PS_LightFX;
RenderTarget0 = texColorGRA;
}
#line 240
pass colorFX
{
VertexShader = VS_PostProcess;
PixelShader = PS_ColorFX;
RenderTarget0 = texColorGRB;
}
#line 247
pass imageFX
{
VertexShader = VS_PostProcess;
PixelShader = PS_ImageFX;
}
}
