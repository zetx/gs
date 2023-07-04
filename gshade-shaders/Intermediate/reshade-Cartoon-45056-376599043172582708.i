#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Cartoon.fx"
#line 7
uniform float Power <
ui_type = "slider";
ui_min = 0.1; ui_max = 10.0;
ui_tooltip = "Amount of effect you want.";
> = 1.5;
uniform float EdgeSlope <
ui_type = "slider";
ui_min = 0.1; ui_max = 6.0;
ui_label = "Edge Slope";
ui_tooltip = "Raise this to filter out fainter edges. You might need to increase the power to compensate. Whole numbers are faster.";
> = 1.5;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 792 * (1.0 / 710); }
float2 GetPixelSize() { return float2((1.0 / 792), (1.0 / 710)); }
float2 GetScreenSize() { return float2(792, 710); }
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
#line 19 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Cartoon.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\TriDither.fxh"
#line 31
uniform float DitherTimer < source = "timer"; >;
#line 34
float rand21(float2 uv)
{
const float2 noise = frac(sin(dot(uv, float2(12.9898, 78.233) * 2.0)) * 43758.5453);
return (noise.x + noise.y) * 0.5;
}
#line 40
float rand11(float x)
{
return frac(x * 0.024390243);
}
#line 45
float permute(float x)
{
return ((34.0 * x + 1.0) * x) % 289.0;
}
#line 50
float3 TriDither(float3 color, float2 uv, int bits)
{
const float bitstep = exp2(bits) - 1.0;
#line 54
const float3 m = float3(uv, rand21(uv + (DitherTimer * 0.001))) + 1.0;
float h = permute(permute(permute(m.x) + m.y) + m.z);
#line 57
float3 noise1, noise2;
noise1.x = rand11(h);
h = permute(h);
#line 61
noise2.x = rand11(h);
h = permute(h);
#line 64
noise1.y = rand11(h);
h = permute(h);
#line 67
noise2.y = rand11(h);
h = permute(h);
#line 70
noise1.z = rand11(h);
h = permute(h);
#line 73
noise2.z = rand11(h);
#line 75
return lerp(noise1 - 0.5, noise1 - noise2, min(saturate( (((color.xyz) - (0.0)) / ((0.5 / bitstep) - (0.0)))), saturate( (((color.xyz) - (1.0)) / (((bitstep - 0.5) / bitstep) - (1.0)))))) * (1.0 / bitstep);
}
#line 22 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Cartoon.fx"
#line 25
float3 CartoonPass(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
const float3 coefLuma = float3(0.2126, 0.7152, 0.0722);
#line 30
float diff1 = dot(coefLuma, tex2D(ReShade::BackBuffer, texcoord +  float2((1.0 / 792), (1.0 / 710))).rgb);
diff1 = dot(float4(coefLuma, -1.0), float4(tex2D(ReShade::BackBuffer, texcoord -  float2((1.0 / 792), (1.0 / 710))).rgb , diff1));
float diff2 = dot(coefLuma, tex2D(ReShade::BackBuffer, texcoord +  float2((1.0 / 792), (1.0 / 710)) * float2(1, -1)).rgb);
diff2 = dot(float4(coefLuma, -1.0), float4(tex2D(ReShade::BackBuffer, texcoord +  float2((1.0 / 792), (1.0 / 710)) * float2(-1, 1)).rgb , diff2));
#line 35
const float edge = dot(float2(diff1, diff2), float2(diff1, diff2));
#line 38
const float3 outcolor = saturate(pow(abs(edge), EdgeSlope) * -Power + color);
return outcolor + TriDither(outcolor, texcoord, 8);
#line 43
}
#line 45
technique Cartoon
{
pass
{
VertexShader = PostProcessVS;
PixelShader = CartoonPass;
}
}

