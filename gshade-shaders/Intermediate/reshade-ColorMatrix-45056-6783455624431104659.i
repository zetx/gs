#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorMatrix.fx"
#line 9
uniform float3 ColorMatrix_Red <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Matrix Red";
ui_tooltip = "How much of a red, green and blue tint the new red value should contain. Should sum to 1.0 if you don't wish to change the brightness.";
> = float3(0.817, 0.183, 0.000);
uniform float3 ColorMatrix_Green <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Matrix Green";
ui_tooltip = "How much of a red, green and blue tint the new green value should contain. Should sum to 1.0 if you don't wish to change the brightness.";
> = float3(0.333, 0.667, 0.000);
uniform float3 ColorMatrix_Blue <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Matrix Blue";
ui_tooltip = "How much of a red, green and blue tint the new blue value should contain. Should sum to 1.0 if you don't wish to change the brightness.";
> = float3(0.000, 0.125, 0.875);
#line 28
uniform float Strength <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 1.0;
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
#line 33 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorMatrix.fx"
#line 39
float3 ColorMatrixPass(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 43
const float3x3 ColorMatrix = float3x3(ColorMatrix_Red, ColorMatrix_Green, ColorMatrix_Blue);
#line 49
return saturate(lerp(color, mul(ColorMatrix, color), Strength));
#line 51
}
#line 53
technique ColorMatrix
{
pass
{
VertexShader = PostProcessVS;
PixelShader = ColorMatrixPass;
}
}

