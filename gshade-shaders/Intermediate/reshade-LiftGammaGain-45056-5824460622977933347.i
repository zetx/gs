#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LiftGammaGain.fx"
#line 6
uniform float3 RGB_Lift <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
ui_label = "RGB Lift";
ui_tooltip = "Adjust shadows for red, green and blue.";
> = float3(1.0, 1.0, 1.0);
uniform float3 RGB_Gamma <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
ui_label = "RGB Gamma";
ui_tooltip = "Adjust midtones for red, green and blue.";
> = float3(1.0, 1.0, 1.0);
uniform float3 RGB_Gain <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
ui_label = "RGB Gain";
ui_tooltip = "Adjust highlights for red, green and blue.";
> = float3(1.0, 1.0, 1.0);
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
#line 26 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LiftGammaGain.fx"
#line 32
float3 LiftGammaGainPass(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 37
color = color * (1.5 - 0.5 * RGB_Lift) + 0.5 * RGB_Lift - 0.5;
color = saturate(color); 
#line 41
color *= RGB_Gain;
#line 48
return saturate(pow(abs(color), 1.0 / RGB_Gamma));
#line 50
}
#line 53
technique LiftGammaGain
{
pass
{
VertexShader = PostProcessVS;
PixelShader = LiftGammaGainPass;
}
}

