#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColShift.fx"
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
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColShift.fx"
#line 7
uniform float HardRedCutoff <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Hard Red Cutoff";
> = float(0.85);
#line 13
uniform float SoftRedCutoff <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Soft Red Cutoff";
> = float(0.6);
#line 19
uniform float HardGreenCutoff <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Hard Green Cutoff";
> = float(0.6);
#line 25
uniform float SoftGreenCutoff <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Soft Green Cutoff";
> = float(0.85);
#line 31
uniform float BlueCutoff <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Blue Cutoff";
> = float(0.3);
#line 37
uniform bool Yellow <
ui_type = "checkbox";
ui_label = "Yellow instead of Green";
> = false;
#line 43
float3 ColShiftPass(float4 position: SV_Position, float2 texcoord: TexCoord): SV_Target
{
const float3 input = tex2D(ReShade::BackBuffer, texcoord).rgb;
if (input.r >= HardRedCutoff && input.g <= HardGreenCutoff && input.b <= BlueCutoff)
{
if (Yellow)
return input.rrb;
else
return input.grb;
}
#line 54
if (input.r >= SoftRedCutoff && input.g <= SoftGreenCutoff && input.b <= BlueCutoff)
{
const float alphaR = (input.r - SoftRedCutoff) / (HardRedCutoff - SoftRedCutoff);
if (Yellow)
return lerp(input.rgb, input.rrb, alphaR);
else
return lerp(input.rgb, input.grb, alphaR);
}
#line 66
return input;
#line 68
}
#line 70
technique ColShift
{
pass
{
VertexShader = PostProcessVS;
PixelShader = ColShiftPass;
}
}

