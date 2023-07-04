#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pixelate.fx"
#line 4
uniform int cell_size
<
ui_type		= "slider";
ui_min		= 2;
ui_max		= 48;
ui_label	= "Cell Size";
> = 4;
#line 12
uniform float avg_amount
<
ui_type		= "slider";
ui_min		= 0.0;
ui_max		= 1.0;
ui_label	= "Smoothness";
> = 0.333;
#line 20
uniform int stats
<
ui_type		= "combo";
ui_items	= "NO\0YES\0";
ui_label	= "Display Stats";
> = 0;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1024 * (1.0 / 768); }
float2 GetPixelSize() { return float2((1.0 / 1024), (1.0 / 768)); }
float2 GetScreenSize() { return float2(1024, 768); }
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
#line 27 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pixelate.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DrawText.fxh"
#line 174
texture Texttex < source = "FontAtlas.png"; > {
Width  = 512;
Height = 512;
};
#line 179
sampler samplerText {
Texture = Texttex;
};
#line 195
float2 DrawText_Shift( float2 pos, int2 shift, float size, float ratio ) {
return pos + size * shift * float2(0.5, 1.0) / ratio;
}
#line 199
void DrawText_Digit( float2 pos, float size, float ratio, float2 tex, int digit, float data, inout float res) {
int digits[13] = {
          16 ,           17 ,           18 ,           19 ,           20 ,           21 ,           22 ,           23 ,           24 ,           25 ,       13 ,        0 ,         14 
};
#line 204
float2 uv = (tex * float2(1024, 768) - pos) / size;
uv.y      = saturate(uv.y);
uv.x     *= ratio * 2.0;
#line 208
const float  t  = abs(data);
int radix;
if (floor(t))
radix = ceil(log2(t)/3.32192809);
else
radix = 0;
#line 216
if(uv.x > digit+1 || -uv.x > radix+1) return;
#line 218
float index = t;
if(floor(uv.x) > 0)
for(int i = ceil(-uv.x); i<0; i++) index *= 10.;
else
for(int i = ceil(uv.x); i<0; i++) index /= 10.;
#line 225
if (uv.x >= -radix-!radix)
index = index%10;
else
index = (10+step(0, data));
#line 230
if (uv.x > 0 && uv.x < 1)
index = 12;
index = digits[(uint)index];
#line 234
res  += tex2D(samplerText, (frac(uv) + float2( index % 14.0, trunc(index / 14.0))) /
float2(  14.0,  7.0)).x;
}
#line 28 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pixelate.fx"
#line 31
void PixelatePass(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{
int2 pixcoord = floor(( float2(1024, 768) * texcoord) / cell_size) * cell_size;
color =  tex2D(ReShade::BackBuffer, ((pixcoord) + 0.5) *  float2((1.0 / 1024), (1.0 / 768)));
#line 36
if(avg_amount > 0.1)
{
float step = cell_size * 0.25;
float4 avg_color = 0.0;
#line 41
for( int x = 0 ; x < 4 ; ++x )
for( int y = 0 ; y < 4 ; ++y )
avg_color +=  tex2D(ReShade::BackBuffer, ((float2(pixcoord.x + (x * step), pixcoord.y + (y * step))) + 0.5) *  float2((1.0 / 1024), (1.0 / 768)));
#line 45
avg_color *= 0.0625;
color = (avg_color * avg_amount) + (color * (1.0 - avg_amount));
}
#line 49
if(stats)
{
DrawText_Digit(float2( float2(1024, 768).x - 256, 128), 64, 1, texcoord, -1, ( float2(1024, 768).x / cell_size), color.x);
DrawText_Digit(float2( float2(1024, 768).x - 256, 192), 64, 1, texcoord, -1, ( float2(1024, 768).y / cell_size), color.x);
}
}
#line 56
technique Pixelate
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PixelatePass;
}
}

