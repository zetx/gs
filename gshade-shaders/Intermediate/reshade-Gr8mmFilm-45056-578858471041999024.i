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
#line 74 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Gr8mmFilm.fx"
#line 80
float4 PS_Gr8mmFilm(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float4 singleGr8mmFilm = tex2D(Gr8mmFilmColor, float2(texcoord.x, texcoord.y/ 7.0  + (  5040 / 7.0 / 5040 )*
#line 86
trunc(filmroll.x)
#line 88
));
const float alpha = saturate(saturate(max(abs(texcoord.x-0.5f),abs(texcoord.y-0.5f))*Gr8mmFilmVignettePower + 0.75f - (singleGr8mmFilm.x+singleGr8mmFilm.y+singleGr8mmFilm.z)* Gr8mmFilmAlphaPower/3f));
#line 94
return lerp(tex2D(ReShade::BackBuffer, texcoord), singleGr8mmFilm, Gr8mmFilmPower*(alpha*alpha));
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

