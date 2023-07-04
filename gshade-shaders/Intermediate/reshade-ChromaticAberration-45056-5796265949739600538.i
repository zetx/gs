#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ChromaticAberration.fx"
#line 8
uniform float2 Shift <
ui_type = "slider";
ui_min = -10; ui_max = 10;
ui_tooltip = "Distance (X,Y) in pixels to shift the color components. For a slightly blurred look try fractional values (.5) between two pixels.";
> = float2(2.5, -0.5);
uniform float Strength <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.5;
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
#line 18 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ChromaticAberration.fx"
#line 24
float3 ChromaticAberrationPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 color, colorInput = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 28
color.r = tex2D(ReShade::BackBuffer, texcoord + ( float2((1.0 / 3440), (1.0 / 1440)) * Shift)).r;
color.g = colorInput.g;
color.b = tex2D(ReShade::BackBuffer, texcoord - ( float2((1.0 / 3440), (1.0 / 1440)) * Shift)).b;
#line 38
return lerp(colorInput, color, Strength);
#line 40
}
#line 42
technique CA
{
pass
{
VertexShader = PostProcessVS;
PixelShader = ChromaticAberrationPass;
}
}

