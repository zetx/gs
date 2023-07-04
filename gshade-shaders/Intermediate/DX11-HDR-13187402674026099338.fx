#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HDR.fx"
#line 11
uniform float HDRPower <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Power";
> = 1.30;
uniform float radius1 <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Radius 1";
> = 0.793;
uniform float radius2 <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Radius 2";
ui_tooltip = "Raising this seems to make the effect stronger and also brighter.";
> = 0.87;
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
#line 28 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HDR.fx"
#line 34
float3 HDRPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 38
float3 bloom_sum1 = tex2D(ReShade::BackBuffer, texcoord + float2(1.5, -1.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2(-1.5, -1.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2( 1.5,  1.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2(-1.5,  1.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2( 0.0, -2.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2( 0.0,  2.5) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2(-2.5,  0.0) * radius1).rgb;
bloom_sum1 += tex2D(ReShade::BackBuffer, texcoord + float2( 2.5,  0.0) * radius1).rgb;
#line 47
bloom_sum1 *= 0.005;
#line 49
float3 bloom_sum2 = tex2D(ReShade::BackBuffer, texcoord + float2(1.5, -1.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2(-1.5, -1.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2( 1.5,  1.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2(-1.5,  1.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2( 0.0, -2.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2( 0.0,  2.5) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2(-2.5,  0.0) * radius2).rgb;
bloom_sum2 += tex2D(ReShade::BackBuffer, texcoord + float2( 2.5,  0.0) * radius2).rgb;
#line 58
bloom_sum2 *= 0.010;
#line 60
const float dist = radius2 - radius1;
const float3 HDR = (color + (bloom_sum2 - bloom_sum1)) * dist;
const float3 blend = HDR + color;
#line 69
return saturate(pow(abs(blend), HDRPower) + HDR);
#line 71
}
#line 73
technique HDR
{
pass
{
VertexShader = PostProcessVS;
PixelShader = HDRPass;
}
}

