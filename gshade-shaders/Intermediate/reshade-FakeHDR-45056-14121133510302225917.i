#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FakeHDR.fx"
#line 9
uniform float fHDRPower <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Power";
> = 1.30;
uniform float fradius1 <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Radius 1";
> = 0.793;
uniform float fradius2 <
ui_type = "slider";
ui_min = 0.0; ui_max = 8.0;
ui_label = "Radius 2";
ui_tooltip = "Raising this seems to make the effect stronger and also brighter.";
> = 0.87;
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
#line 26 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FakeHDR.fx"
#line 33
float3 fHDRPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 38
const float2 rad1 = fradius1 *  float2((1.0 / 3440), (1.0 / 1440));
const float2 rad2 = fradius2 *  float2((1.0 / 3440), (1.0 / 1440));
#line 42
const float3 bloom_sum1  = (
tex2D(ReShade::BackBuffer, texcoord + float2( 1.5, -1.5) * rad1).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2(-1.5, -1.5) * rad1).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2( 1.5,  1.5) * rad1).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2(-1.5,  1.5) * rad1).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2( 0.0, -2.5) * rad1).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2( 0.0,  2.5) * rad1).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2(-2.5,  0.0) * rad1).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2( 2.5,  0.0) * rad1).rgb
) * 0.005;
#line 54
const float3 bloom_sum2  = (
tex2D(ReShade::BackBuffer, texcoord + float2( 1.5, -1.5) * rad2).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2(-1.5, -1.5) * rad2).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2( 1.5,  1.5) * rad2).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2(-1.5,  1.5) * rad2).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2( 0.0, -2.5) * rad2).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2( 0.0,  2.5) * rad2).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2(-2.5,  0.0) * rad2).rgb +
tex2D(ReShade::BackBuffer, texcoord + float2( 2.5,  0.0) * rad2).rgb
) * 0.01;
#line 65
const float3 HDR = (color + (bloom_sum2 - bloom_sum1)) * (fradius2 - fradius1);
#line 71
return saturate(pow(abs(HDR + color), abs(fHDRPower)) + HDR); 
#line 73
}
#line 75
technique FakeHDR
{
pass
{
VertexShader = PostProcessVS;
PixelShader = fHDRPass;
}
}

