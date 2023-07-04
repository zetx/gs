#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\KeepUI.fx"
#line 47
uniform bool bKeepUIOcclude <
ui_category = "Options";
ui_label = "Occlusion Assistance";
ui_tooltip = "Set to 1 if you notice odd graphical issues with Bloom or similar shaders. May cause problems with SSDO when enabled.";
ui_bind = "KeepUIOccludeAssist";
> = 0;
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
#line 82 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\KeepUI.fx"
#line 84
texture KeepUI_Tex { Width = 3440; Height = 1440; };
sampler KeepUI_Sampler { Texture = KeepUI_Tex; };
#line 87
void PS_KeepUI(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{
color = tex2D(ReShade::BackBuffer, texcoord);
#line 93
}
#line 103
void PS_RestoreUI(float4 pos : SV_Position, float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{
#line 134
const float4 keep = tex2D(KeepUI_Sampler, texcoord);
#line 136
color   = float4(lerp(tex2D(ReShade::BackBuffer, texcoord), keep, keep.a).rgb, keep.a);
#line 138
}
#line 140
technique FFKeepUI <
ui_tooltip = "Place this at the top of your Technique list to save the UI into a texture for restoration with FFRestoreUI.\n"
"To use this Technique, you must also enable \"FFRestoreUI\".\n";
>
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_KeepUI;
RenderTarget = KeepUI_Tex;
}
#line 158
}
#line 160
technique FFRestoreUI <
ui_tooltip = "Place this at the bottom of your Technique list to restore the UI texture saved by FFKeepUI.\n"
"To use this Technique, you must also enable \"FFKeepUI\".\n";
>
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_RestoreUI;
}
}

