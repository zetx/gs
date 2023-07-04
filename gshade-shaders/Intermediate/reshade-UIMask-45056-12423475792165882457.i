#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\UIMask.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1799 * (1.0 / 995); }
float2 GetPixelSize() { return float2((1.0 / 1799), (1.0 / 995)); }
float2 GetScreenSize() { return float2(1799, 995); }
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
#line 99 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\UIMask.fx"
#line 123
uniform float fMask_Intensity <
ui_type = "slider";
ui_label = "Mask Intensity";
ui_tooltip = "How much to mask effects to the original image.";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 1.0;
#line 132
uniform bool bDisplayMask <
ui_type = "radio";
ui_label = "Display Mask";
ui_tooltip =
"Display the mask texture.\n"
"Useful for testing multiple channels or simply the mask itself.";
> = false;
#line 146
texture tUIMask_Backup { Width = 1799; Height = 995; };
texture tUIMask_Mask <source="UIMask.png";> { Width = 1799; Height = 995; Format= R8; };
#line 149
sampler sUIMask_Mask { Texture = tUIMask_Mask; };
sampler sUIMask_Backup { Texture = tUIMask_Backup; };
#line 152
float4 PS_Backup(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return tex2D(ReShade::BackBuffer, uv);
}
#line 156
float4 PS_ApplyMask(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
float3 col = tex2D(ReShade::BackBuffer, uv).rgb;
#line 160
float mask = tex2D(sUIMask_Mask, uv).r;
#line 167
mask = lerp(1.0, mask, fMask_Intensity);
col = lerp(tex2D(sUIMask_Backup, uv).rgb, col, mask);
if (bDisplayMask)
col = mask;
#line 172
return float4(col, 1.0);
}
#line 175
technique UIMask_Top {
pass {
VertexShader = PostProcessVS;
PixelShader = PS_Backup;
RenderTarget = tUIMask_Backup;
}
}
#line 183
technique UIMask_Bottom {
pass {
VertexShader = PostProcessVS;
PixelShader = PS_ApplyMask;
}
}

