#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NightVision.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1280 * (1.0 / 720); }
float2 GetPixelSize() { return float2((1.0 / 1280), (1.0 / 720)); }
float2 GetScreenSize() { return float2(1280, 720); }
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
#line 4 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\NightVision.fx"
#line 6
uniform float iGlobalTime < source = "timer"; >;
#line 8
float hash(in float n) { return frac(sin(n)*43758.5453123); }
#line 10
float mod(float x, float y)
{
return x - y * floor (x/y);
}
#line 15
float3 PS_Nightvision(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target
{
const float2 p = uv;
#line 19
const float2 u = p * 2. - 1.;
const float2 n = u * float2( (1280 * (1.0 / 720)), 1.0);
float3 c = tex2D(ReShade::BackBuffer, uv).xyz;
#line 24
c += sin(hash(iGlobalTime*0.001)) * 0.01;
c += hash((hash(n.x) + n.y) * iGlobalTime*0.001) * 0.5;
c *= smoothstep(length(n * n * n * float2(0.0, 0.0)), 1.0, 0.4);
c *= smoothstep(0.001, 3.5, iGlobalTime*0.001) * 1.5;
#line 29
return dot(c, float3(0.2126, 0.7152, 0.0722))
* float3(0.2, 1.5 - hash(iGlobalTime*0.001) * 0.1,0.4);
}
#line 33
technique Nightvision {
pass Nightvision {
VertexShader=PostProcessVS;
PixelShader=PS_Nightvision;
}
}

