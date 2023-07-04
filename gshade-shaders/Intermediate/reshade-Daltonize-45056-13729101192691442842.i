#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Daltonize.fx"
#line 8
uniform int Type <
ui_type = "combo";
ui_items = "Protanopia\0Deuteranopia\0Tritanopia\0";
> = 0;
#line 13
uniform float RedAdjust <
ui_label = "Base Red Adjustment";
ui_type = "slider";
ui_step = 0.001;
ui_min = 0.001;
ui_max = 2.0;
> = 1.0;
#line 21
uniform float GreenAdjust <
ui_label = "Base Green Adjustment";
ui_type = "slider";
ui_step = 0.001;
ui_min = 0.001;
ui_max = 2.0;
> = 1.0;
#line 29
uniform float BlueAdjust <
ui_label = "Base Blue Adjustment";
ui_type = "slider";
ui_step = 0.001;
ui_min = 0.001;
ui_max = 2.0;
> = 1.0;
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
#line 37 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Daltonize.fx"
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
#line 40 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Daltonize.fx"
#line 43
float3 PS_DaltonizeFXmain(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 input = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 47
input.r = input.r * RedAdjust;
#line 49
input.g = input.g * GreenAdjust;
#line 51
input.b = input.b * BlueAdjust;
#line 54
const float OnizeL = (17.8824f * input.r) + (43.5161f * input.g) + (4.11935f * input.b);
const float OnizeM = (3.45565f * input.r) + (27.1554f * input.g) + (3.86714f * input.b);
const float OnizeS = (0.0299566f * input.r) + (0.184309f * input.g) + (1.46709f * input.b);
#line 59
float Daltl, Daltm, Dalts;
#line 61
if (Type == 0) 
{
Daltl = 0.0f * OnizeL + 2.02344f * OnizeM + -2.52581f * OnizeS;
Daltm = 0.0f * OnizeL + 1.0f * OnizeM + 0.0f * OnizeS;
Dalts = 0.0f * OnizeL + 0.0f * OnizeM + 1.0f * OnizeS;
}
else if (Type == 1) 
{
Daltl = 1.0f * OnizeL + 0.0f * OnizeM + 0.0f * OnizeS;
Daltm = 0.494207f * OnizeL + 0.0f * OnizeM + 1.24827f * OnizeS;
Dalts = 0.0f * OnizeL + 0.0f * OnizeM + 1.0f * OnizeS;
}
else if (Type == 2) 
{
Daltl = 1.0f * OnizeL + 0.0f * OnizeM + 0.0f * OnizeS;
Daltm = 0.0f * OnizeL + 1.0f * OnizeM + 0.0f * OnizeS;
Dalts = -0.395913f * OnizeL + 0.801109f * OnizeM + 0.0f * OnizeS;
}
#line 82
const float3 error = input - float3((0.0809444479f * Daltl) + (-0.130504409f * Daltm) + (0.116721066f * Dalts), (-0.0102485335f * Daltl) + (0.0540193266f * Daltm) + (-0.113614708f * Dalts), (-0.000365296938f * Daltl) + (-0.00412161469f * Daltm) + (0.693511405f * Dalts));
#line 86
input = input + float3(0, (error.r * 0.7) + (error.g * 1.0), (error.r * 0.7) + (error.b * 1.0));
return input + TriDither(input, texcoord, 8);
#line 91
}
#line 93
technique Daltonize
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_DaltonizeFXmain;
}
}

