#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LUT.fx"
#line 70
uniform int fLUT_Selector <
ui_type = "combo";
ui_items = "GShade/Angelite\0LUT - Warm.fx\0Autumn\0ninjafada Gameplay\0ReShade 3/4\0Sleeps_Hungry\0Feli\0Lufreine Legacy\0Ipsusu Gameplay\0Potatoshade\0";
ui_label = "The LUT file to use.";
ui_tooltip = "Set this to whichever your preset requires!\nPlease note that the Potatoshade option will require you to obtain a copy of \"seilut.png\" from the Potoshade zip and place it in the \"?:\\Program Files\\GShade\\gshade-shaders\\Textures\" folder before it becomes usable.";
ui_bind = "LUTTexture_Source";
> = 0;
#line 83
uniform float fLUT_AmountChroma <
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT chroma amount";
ui_tooltip = "Intensity of color/chroma change of the LUT.";
> = 1.00;
#line 90
uniform float fLUT_AmountLuma <
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_label = "LUT luma amount";
ui_tooltip = "Intensity of luma change of the LUT.";
> = 1.00;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1500 * (1.0 / 1004); }
float2 GetPixelSize() { return float2((1.0 / 1500), (1.0 / 1004)); }
float2 GetScreenSize() { return float2(1500, 1004); }
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
#line 101 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LUT.fx"
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
#line 104 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LUT.fx"
#line 150
texture texLUT < source =   "lut_GShade.png" ; > { Width =   32 *   32; Height =   32; Format = RGBA8; };
sampler	SamplerLUT 	{ Texture = texLUT; };
#line 157
void PS_LUT_Apply(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float3 res : SV_Target0)
{
res = tex2D(ReShade::BackBuffer, texcoord.xy).xyz;
#line 161
float2 texelsize = 1.0 /   32;
texelsize.x /=   32;
#line 164
float3 lutcoord = float3((res.xy *   32 - res.xy + 0.5) * texelsize.xy, res.z *   32 - res.z);
const float lerpfact = frac(lutcoord.z);
lutcoord.x += (lutcoord.z - lerpfact) * texelsize.y;
#line 168
const float3 lutcolor = lerp(tex2D(SamplerLUT, lutcoord.xy).xyz, tex2D(SamplerLUT, float2(lutcoord.x+texelsize.y,lutcoord.y)).xyz, lerpfact);
#line 170
res = lerp(normalize(res), normalize(lutcolor), fLUT_AmountChroma) *
lerp(length(res),    length(lutcolor),    fLUT_AmountLuma);
#line 174
res += TriDither(res, texcoord, 8);
#line 176
}
#line 183
technique LUT
{
pass LUT_Apply
{
VertexShader = PostProcessVS;
PixelShader = PS_LUT_Apply;
}
}
