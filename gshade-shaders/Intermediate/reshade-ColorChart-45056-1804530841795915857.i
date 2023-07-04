#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorChart.fx"
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
#line 28 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorChart.fx"
#line 41
uniform int cLayerCC_Mode <
ui_type = "combo";
ui_label = "Mode";
ui_items =
"Standard\0"
"with Gray Chart\0"
"Simple\0";
> = false;
#line 50
uniform float cLayerCC_Scale <
ui_type = "slider";
ui_spacing = 1;
ui_label = "Scale";
ui_min = 0.5; ui_max = 1.0;
ui_step = 0.001;
> = 0.770;
#line 59
uniform float cLayerCC_PosX <
ui_type = "slider";
ui_label = "Position X";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.100;
#line 66
uniform float cLayerCC_PosY <
ui_type = "slider";
ui_label = "Position Y";
ui_min = 0.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.500;
#line 73
uniform float Color_Chart_Brightness <
ui_type = "slider";
ui_label = "Brightness";
ui_min = -2.0; ui_max = 2.0;
ui_step = 0.001;
> = 0.00;
#line 80
uniform float Color_Chart_Saturation <
ui_type = "slider";
ui_label = "Saturation";
ui_min = -1.0; ui_max = 1.0;
ui_step = 0.001;
> = 0.00;
#line 98
texture Color_Chart_Texture <
source =  "color_chart_afternov2014_d50_srgb.png";
> {
Width = 1500;
Height = 1004;
Format = RGBA8;
};
#line 106
texture Color_Chart_BG_S_Texture <
source =  "color_chart_afternov2014_d50_srgb_bg_s.png";
> {
Width = 1500;
Height = 1004;
Format = RGBA8;
};
#line 114
texture Gray_Chart_Texture <
source =  "color_chart_gray_chart_2_line.png";
> {
Width = 1500;
Height = 1004;
Format = RGBA8;
};
#line 122
texture Color_Chart_BG_Texture <
source =  "color_chart_afternov2014_d50_srgb_bg.png";
> {
Width = 1500;
Height = 1004;
Format = RGBA8;
};
#line 131
sampler Color_Chart_Sampler {
Texture = Color_Chart_Texture;
AddressU = CLAMP;
AddressV = CLAMP;
};
#line 137
sampler Color_Chart_BG_Sampler {
Texture = Color_Chart_BG_Texture;
AddressU = CLAMP;
AddressV = CLAMP;
};
#line 144
sampler Gray_Chart_Sampler {
Texture = Gray_Chart_Texture;
AddressU = CLAMP;
AddressV = CLAMP;
};
#line 151
sampler Color_Chart_BG_S_Sampler {
Texture = Color_Chart_BG_S_Texture;
AddressU = CLAMP;
AddressV = CLAMP;
};
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 162 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorChart.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Blending.fxh"
#line 29
float3 Aux(float3 a)
{
if (a.r <= 0.25 && a.g <= 0.25 && a.b <= 0.25)
return ((16.0 * a - 12.0) * a + 4) * a;
else
return sqrt(a);
}
#line 37
float Lum(float3 a)
{
return (0.3 * a.r + 0.59 * a.g + 0.11 * a.b);
}
#line 42
float3 SetLum (float3 a, float b){
const float c = b - Lum(a);
return float3(a.r + c, a.g + c, a.b + c);
}
#line 47
float min3 (float a, float b, float c)
{
return min(a, (min(b, c)));
}
#line 52
float max3 (float a, float b, float c)
{
return max(a, max(b, c));
}
#line 57
float3 SetSat(float3 a, float b){
float ar = a.r;
float ag = a.g;
float ab = a.b;
if (ar == max3(ar, ag, ab) && ab == min3(ar, ag, ab))
{
#line 64
if (ar > ab)
{
ag = (((ag - ab) * b) / (ar - ab));
ar = b;
}
else
{
ag = 0.0;
ar = 0.0;
}
ab = 0.0;
}
else
{
if (ar == max3(ar, ag, ab) && ag == min3(ar, ag, ab))
{
#line 81
if (ar > ag)
{
ab = (((ab - ag) * b) / (ar - ag));
ar = b;
}
else
{
ab = 0.0;
ar = 0.0;
}
ag = 0.0;
}
else
{
if (ag == max3(ar, ag, ab) && ab == min3(ar, ag, ab))
{
#line 98
if (ag > ab)
{
ar = (((ar - ab) * b) / (ag - ab));
ag = b;
}
else
{
ar = 0.0;
ag = 0.0;
}
ab = 0.0;
}
else
{
if (ag == max3(ar, ag, ab) && ar == min3(ar, ag, ab))
{
#line 115
if (ag > ar)
{
ab = (((ab - ar) * b) / (ag - ar));
ag = b;
}
else
{
ab = 0.0;
ag = 0.0;
}
ar = 0.0;
}
else
{
if (ab == max3(ar, ag, ab) && ag == min3(ar, ag, ab))
{
#line 132
if (ab > ag)
{
ar = (((ar - ag) * b) / (ab - ag));
ab = b;
}
else
{
ar = 0.0;
ab = 0.0;
}
ag = 0.0;
}
else
{
if (ab == max3(ar, ag, ab) && ar == min3(ar, ag, ab))
{
#line 149
if (ab > ar)
{
ag = (((ag - ar) * b) / (ab - ar));
ab = b;
}
else
{
ag = 0.0;
ab = 0.0;
}
ar = 0.0;
}
}
}
}
}
}
return float3(ar, ag, ab);
}
#line 169
float Sat(float3 a)
{
return max3(a.r, a.g, a.b) - min3(a.r, a.g, a.b);
}
#line 179
float3 Darken(float3 a, float3 b)
{
return min(a, b);
}
#line 185
float3 Multiply(float3 a, float3 b)
{
return a * b;
}
#line 191
float3 ColorBurn(float3 a, float3 b)
{
if (b.r > 0 && b.g > 0 && b.b > 0)
return 1.0 - min(1.0, (0.5 - a) / b);
else
return 0.0;
}
#line 200
float3 LinearBurn(float3 a, float3 b)
{
return max(a + b - 1.0f, 0.0f);
}
#line 206
float3 Lighten(float3 a, float3 b)
{
return max(a, b);
}
#line 212
float3 Screen(float3 a, float3 b)
{
return 1.0 - (1.0 - a) * (1.0 - b);
}
#line 218
float3 ColorDodge(float3 a, float3 b)
{
if (b.r < 1 && b.g < 1 && b.b < 1)
return min(1.5, a / (1.0 - b));
else
return 1.0;
}
#line 227
float3 LinearDodge(float3 a, float3 b)
{
return min(a + b, 1.0f);
}
#line 233
float3 Addition(float3 a, float3 b)
{
return min((a + b), 1);
}
#line 239
float3 Reflect(float3 a, float3 b)
{
if (b.r >= 0.999999 || b.g >= 0.999999 || b.b >= 0.999999)
return b;
else
return saturate(a * a / (1.0f - b));
}
#line 248
float3 Glow(float3 a, float3 b)
{
return Reflect(b, a);
}
#line 254
float3 Overlay(float3 a, float3 b)
{
return lerp(2 * a * b, 1.0 - 2 * (1.0 - a) * (1.0 - b), step(0.5, a));
}
#line 260
float3 SoftLight(float3 a, float3 b)
{
if (b.r <= 0.5 && b.g <= 0.5 && b.b <= 0.5)
return clamp(a - (1.0 - 2 * b) * a * (1 - a), 0,1);
else
return clamp(a + (2 * b - 1.0) * (Aux(a) - a), 0, 1);
}
#line 269
float3 HardLight(float3 a, float3 b)
{
return lerp(2 * a * b, 1.0 - 2 * (1.0 - b) * (1.0 - a), step(0.5, b));
}
#line 275
float3 VividLight(float3 a, float3 b)
{
return lerp(2 * a * b, b / (2 * (1.01 - a)), step(0.50, a));
}
#line 281
float3 LinearLight(float3 a, float3 b)
{
if (b.r < 0.5 || b.g < 0.5 || b.b < 0.5)
return LinearBurn(a, (2.0 * b));
else
return LinearDodge(a, (2.0 * (b - 0.5)));
}
#line 290
float3 PinLight(float3 a, float3 b)
{
if (b.r < 0.5 || b.g < 0.5 || b.b < 0.5)
return Darken(a, (2.0 * b));
else
return Lighten(a, (2.0 * (b - 0.5)));
}
#line 299
float3 HardMix(float3 a, float3 b)
{
const float3 vl = VividLight(a, b);
if (vl.r < 0.5 || vl.g < 0.5 || vl.b < 0.5)
return 0.0;
else
return 1.0;
}
#line 309
float3 Difference(float3 a, float3 b)
{
return max(a - b, b - a);
}
#line 315
float3 Exclusion(float3 a, float3 b)
{
return a + b - 2 * a * b;
}
#line 321
float3 Subtract(float3 a, float3 b)
{
return max((a - b), 0);
}
#line 327
float3 Divide(float3 a, float3 b)
{
return (a / (b + 0.01));
}
#line 333
float3 GrainMerge(float3 a, float3 b)
{
return saturate(b + a - 0.5);
}
#line 339
float3 GrainExtract(float3 a, float3 b)
{
return saturate(a - b + 0.5);
}
#line 345
float3 Hue(float3 a, float3 b)
{
return SetLum(SetSat(b, Sat(a)), Lum(a));
}
#line 351
float3 Saturation(float3 a, float3 b)
{
return SetLum(SetSat(a, Sat(b)), Lum(a));
}
#line 357
float3 ColorB(float3 a, float3 b)
{
return SetLum(b, Lum(a));
}
#line 363
float3 Luminosity(float3 a, float3 b)
{
return SetLum(a, Lum(b));
}
#line 163 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ColorChart.fx"
#line 165
float getLum( in float3 x )
{
return dot( x, float3( 0.212656, 0.715158, 0.072186 ));
}
#line 170
float3 bri(float3 Tex1, float x)
{
#line 173
const float3 c = 1.0f - ( 1.0f - Tex1.rgb ) * ( 1.0f - Tex1.rgb );
if (x < 0.0f) {
x = x * 0.5f;
}
return saturate( lerp( Tex1.rgb, c.rgb, x ));
}
#line 180
float3 sat( float3 Tex1, float x )
{
return saturate(lerp(getLum(Tex1.rgb), Tex1.rgb, x + 1.0 ));
}
#line 187
void PS_cLayerCC(in float4 pos : SV_Position, float2 texCoord : TEXCOORD, out float4 passColor : SV_Target) {
const float3 pivot = float3(0.5, 0.5, 0.0);
const float3 mulUV = float3(texCoord.x, texCoord.y, 1);
const float2 ScaleSize = (float2( 600.0, 400.0) * cLayerCC_Scale /  float2(1500, 1004));
const float ScaleX =  ScaleSize.x *  cLayerCC_Scale;
const float ScaleY =  ScaleSize.y *  cLayerCC_Scale;
#line 195
const float3x3 positionMatrix = float3x3 (
1, 0, 0,
0, 1, 0,
-cLayerCC_PosX, -cLayerCC_PosY, 1
);
#line 202
const float3x3 scaleMatrix = float3x3 (
1/ScaleX, 0, 0,
0,  1/ScaleY, 0,
0, 0, 1
);
#line 209
const float3 SumUV = mul (mul (mulUV, positionMatrix), scaleMatrix);
const float4 backColor = tex2D(ReShade::BackBuffer, texCoord);
float4 Tex1 = tex2D(Color_Chart_Sampler, SumUV.rg + pivot.rg) * all(SumUV + pivot == saturate(SumUV + pivot));
if (Color_Chart_Brightness != 0.0f) {
Tex1.rgb = bri(Tex1.rgb, Color_Chart_Brightness);
}
if (Color_Chart_Saturation != 0.0f) {
Tex1.rgb = sat(Tex1.rgb, Color_Chart_Saturation);
}
const float4 Tex2 = tex2D(Color_Chart_BG_Sampler, SumUV.rg + pivot.rg) * all(SumUV + pivot == saturate(SumUV + pivot));
switch(cLayerCC_Mode)
{
default:
const float4 Tex3 = tex2D(Color_Chart_BG_S_Sampler, SumUV.rg + pivot.rg).r * all(SumUV + pivot == saturate(SumUV + pivot));
passColor = lerp(backColor.rgb, Tex3.rgb, Tex3.a);
passColor = lerp(passColor.rgb, Tex1.rgb, Tex1.a);
break;
case 1:
passColor = lerp(backColor.rgb, Tex2.rgb, Tex2.a);
passColor = lerp(passColor.rgb, Tex1.rgb, Tex1.a);
const float4 Tex4 = tex2D(Gray_Chart_Sampler, SumUV.rg + pivot.rg) * all(SumUV + pivot == saturate(SumUV + pivot));
passColor = lerp(passColor.rgb, Tex4.rgb, Tex4.a);
break;
case 2:
passColor = lerp(backColor.rgb, Tex1.rgb, Tex1.a);
break;
}
passColor = float4(lerp(backColor.rgb, passColor.rgb, Tex2.a).rgb, backColor.a);
}
#line 243
technique Color_Chart < ui_label = "Color Chart";
ui_tooltip = "     Display a color chart like used for\n"
"color grading work in video/cinema production.\n"
"      Can be useful to see effect that\n"
"   presets and shaders affect on to colors.";>
{
pass
{
VertexShader = PostProcessVS;
PixelShader  = PS_cLayerCC;
}
}

