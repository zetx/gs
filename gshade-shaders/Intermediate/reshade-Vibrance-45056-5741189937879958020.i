#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Vibrance.fx"
#line 20
uniform float Vibrance <
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "Intelligently saturates (or desaturates if you use negative values) the pixels depending on their original saturation.";
> = 0.15;
#line 26
uniform float3 VibranceRGBBalance <
ui_type = "slider";
ui_min = 0.0; ui_max = 10.0;
ui_label = "RGB Balance";
ui_tooltip = "A per channel multiplier to the Vibrance strength so you can give more boost to certain colors over others.\nThis is handy if you are colorblind and less sensitive to a specific color.\nYou can then boost that color more than the others.";
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
#line 41 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Vibrance.fx"
#line 47
float3 VibrancePass(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 51
const float luma = dot(float3(0.212656, 0.715158, 0.072186), color);
#line 54
const float3 coeffVibrance = float3(VibranceRGBBalance * Vibrance);
#line 60
return lerp(luma, color, 1.0 + (coeffVibrance * (1.0 - (sign(coeffVibrance) * (max(color.r, max(color.g, color.b)) - min(color.r, min(color.g, color.b)))))));
#line 62
}
#line 64
technique Vibrance
{
pass
{
VertexShader = PostProcessVS;
PixelShader = VibrancePass;
}
}

