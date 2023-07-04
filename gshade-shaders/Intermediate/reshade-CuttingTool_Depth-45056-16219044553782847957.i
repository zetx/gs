#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CuttingTool_Depth.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1500 * (1.0 / 1004); }
float2 GetPixelSize() { return float2((1.0 / 1500), (1.0 / 1004)); }
float2 GetScreenSize() { return float2(1500, 1004); }
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CuttingTool_Depth.fx"
#line 15
uniform float3 Point1 <
ui_label = "Point 1 (near)";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.00001;
> = 0.0;
#line 22
uniform float3 Point2 <
ui_label = "Point 2 (far)";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.00001;
> = 1.0;
#line 33
void PS_Main(float4 pos : SV_Position, float2 texCoord : TEXCOORD, out float4 frontColor : SV_Target)
{
const float3 gameCoord = float3(texCoord, ReShade::GetLinearizedDepth(texCoord));
frontColor = tex2D(ReShade::BackBuffer, texCoord);
frontColor.a = 1.0 - gameCoord.z;
frontColor *= step(1.0, 1.0 - (gameCoord - clamp(gameCoord, Point1, Point2)));
}
#line 45
technique CuttingTool_Depth <
ui_label = "Cutting Tool (Depth-based)";
> {
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_Main;
}
}

