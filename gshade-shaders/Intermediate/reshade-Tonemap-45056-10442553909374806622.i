#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Tonemap.fx"
#line 7
uniform float Gamma <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
ui_tooltip = "Adjust midtones. 1.0 is neutral. This setting does exactly the same as the one in Lift Gamma Gain, only with less control.";
> = 1.0;
uniform float Exposure <
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "Adjust exposure";
> = 0.0;
uniform float Saturation <
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "Adjust saturation";
> = 0.0;
#line 23
uniform float Bleach <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Brightens the shadows and fades the colors";
> = 0.0;
#line 29
uniform float Defog <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "How much of the color tint to remove";
> = 0.0;
uniform float3 FogColor <
ui_type = "color";
ui_label = "Defog Color";
ui_tooltip = "Which color tint to remove";
> = float3(0.0, 0.0, 1.0);
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
#line 41 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Tonemap.fx"
#line 47
float3 TonemapPass(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 color = saturate(tex2D(ReShade::BackBuffer, texcoord).rgb - Defog * FogColor * 2.55); 
color *= pow(2.0f, Exposure); 
color = pow(color, Gamma); 
#line 53
const float lum = dot(float3(0.2126, 0.7152, 0.0722), color);
#line 55
const float3 A2 = Bleach * color;
#line 57
color += ((1.0f - A2) * (A2 * lerp(2.0f * color * lum, 1.0f - 2.0f * (1.0f - lum) * (1.0f - color), saturate(10.0 * (lum - 0.45)))));
#line 63
const float3 diffcolor = (color - dot(color, (1.0 / 3.0))) * Saturation;
#line 65
color = (color + diffcolor) / (1 + diffcolor); 
#line 70
return color;
#line 72
}
#line 74
technique Tonemap
{
pass
{
VertexShader = PostProcessVS;
PixelShader = TonemapPass;
}
}

