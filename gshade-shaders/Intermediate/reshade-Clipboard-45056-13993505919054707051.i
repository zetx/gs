#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Clipboard.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1799 * (1.0 / 998); }
float2 GetPixelSize() { return float2((1.0 / 1799), (1.0 / 998)); }
float2 GetScreenSize() { return float2(1799, 998); }
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Clipboard.fx"
#line 15
texture Clipboard_Texture
{
Width = 1799;
Height = 998;
Format = RGBA8;
};
#line 26
sampler Sampler
{
Texture = Clipboard_Texture;
};
#line 35
uniform float BlendIntensity <
ui_label = "Alpha blending level";
ui_type = "drag";
ui_min = 0.001; ui_max = 1000.0;
ui_step = 0.001;
> = 1.0;
#line 46
void PS_Copy(float4 pos : SV_Position, float2 texCoord : TEXCOORD, out float4 frontColor : SV_Target)
{
frontColor = tex2D(ReShade::BackBuffer, texCoord);
}
#line 51
void PS_Paste(float4 pos : SV_Position, float2 texCoord : TEXCOORD, out float4 frontColor : SV_Target)
{
const float4 backColor = tex2D(ReShade::BackBuffer, texCoord);
#line 55
frontColor = tex2D(Sampler, texCoord);
frontColor = lerp(backColor, frontColor, min(1.0, frontColor.a * BlendIntensity));
}
#line 63
technique Copy
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_Copy;
RenderTarget = Clipboard_Texture;
}
}
#line 73
technique Paste
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_Paste;
}
}

