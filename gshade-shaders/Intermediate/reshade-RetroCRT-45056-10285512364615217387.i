#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RetroCRT.fx"
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
#line 52 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RetroCRT.fx"
#line 58
uniform float Timer < source = "timer"; >;
#line 60
float4 RetroCRTPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float GLTimer = Timer * 0.0001;
#line 64
const float vPos = float( ( texcoord.y + GLTimer * 0.5 ) * 272.0 );
const float line_intensity = vPos - 2.0 * floor(vPos / 2.0);
#line 68
const float2 shift = float2( line_intensity * 0.0005, 0 );
#line 71
const float2 colorShift = float2( 0.001, 0 );
#line 82
const float4 c = float4( tex2D( ReShade::BackBuffer, texcoord + colorShift + shift ).x,			
tex2D( ReShade::BackBuffer, texcoord - colorShift + shift ).y * 0.99,	
tex2D( ReShade::BackBuffer, texcoord ).z,				
1.0) * clamp( line_intensity, 0.85, 1.0 );
return c + (sin( ( texcoord.y + GLTimer ) * 4.0 ) * 0.02);
#line 88
}
#line 90
technique RetroCRT
{
pass
{
VertexShader = PostProcessVS;
PixelShader = RetroCRTPass;
}
}
