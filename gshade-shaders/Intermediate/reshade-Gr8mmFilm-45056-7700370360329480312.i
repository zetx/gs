#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Gr8mmFilm.fx"
#line 33
uniform float Gr8mmFilmVignettePower <
ui_type = "slider";
ui_min = 0; ui_max = 2;
ui_step = 0.01;
ui_tooltip = "Strength of the effect at the edges";
ui_label = "Vignette strength";
> = 1.0;
#line 41
uniform float Gr8mmFilmPower <
ui_type = "slider";
ui_min = 0; ui_max = 1;
ui_step = 0.01;
ui_tooltip = "Overall intensity of the effect";
ui_label = "Overall strength";
> = 1.0;
#line 49
uniform float Gr8mmFilmAlphaPower <
ui_type = "slider";
ui_min = 0; ui_max = 2;
ui_step = 0.01;
ui_tooltip = "Takes gradients into account (white => transparent)";
ui_label = "Alpha";
> = 1.0;
#line 68
uniform float2 filmroll < source = "pingpong"; min = 0.0f; max = ( 7.0 - 1 ); step = float2(1.0f, 2.0f); >;
#line 71
texture Gr8mmFilmTex < source = "CFX_Gr8mmFilm.png"; > { Width =  1280 ; Height =  5040 ; Format = RGBA8; };
sampler	Gr8mmFilmColor 	{ Texture = Gr8mmFilmTex; };
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1798 * (1.0 / 997); }
float2 GetPixelSize() { return float2((1.0 / 1798), (1.0 / 997)); }
float2 GetScreenSize() { return float2(1798, 997); }
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
#line 74 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Gr8mmFilm.fx"
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
#line 77 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Gr8mmFilm.fx"
#line 80
float4 PS_Gr8mmFilm(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float4 singleGr8mmFilm = tex2D(Gr8mmFilmColor, float2(texcoord.x, texcoord.y/ 7.0  + (  5040 / 7.0 / 5040 )*
#line 86
trunc(filmroll.x)
#line 88
));
const float alpha = saturate(saturate(max(abs(texcoord.x-0.5f),abs(texcoord.y-0.5f))*Gr8mmFilmVignettePower + 0.75f - (singleGr8mmFilm.x+singleGr8mmFilm.y+singleGr8mmFilm.z)* Gr8mmFilmAlphaPower/3f));
#line 91
const float4 outcolor = lerp(tex2D(ReShade::BackBuffer, texcoord), singleGr8mmFilm, Gr8mmFilmPower*(alpha*alpha));
return float4(outcolor.xyz + TriDither(outcolor.xyz, texcoord, 8), outcolor.w);
#line 96
}
#line 98
technique Gr8mmFilm
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_Gr8mmFilm;
}
}

