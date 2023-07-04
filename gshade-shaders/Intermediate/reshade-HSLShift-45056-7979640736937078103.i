#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HSLShift.fx"
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
#line 7 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HSLShift.fx"
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
#line 10 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HSLShift.fx"
#line 15
uniform float3 HUERed <
ui_type = "color";
ui_label="Red";
ui_tooltip =
"Be careful. Do not to push too far!\n"
"You can only shift as far as the next\n"
"or previous hue's current value.\n\n"
"Editing is easiest using the widget\n"
"Click the colored box to open it.\n\n"
"RGB Red Default Value:\n"
"255 : R:  191, G:   64, B:   64\n"
"0.00: R:0.750, G:0.250, B:0.250";
> = float3(0.75, 0.25, 0.25);
#line 29
uniform float3 HUEOrange <
ui_type = "color";
ui_label = "Orange";
ui_tooltip =
"Be careful. Do not to push too far!\n"
"You can only shift as far as the next\n"
"or previous hue's current value.\n\n"
"Editing is easiest using the widget\n"
"Click the colored box to open it.\n\n"
"RGB Orange Default Value:\n"
"255 : R:  191, G:  128, B:   64\n"
"0.00: R:0.750, G:0.500, B:0.250";
> = float3(0.75, 0.50, 0.25);
#line 43
uniform float3 HUEYellow <
ui_type = "color";
ui_label = "Yellow";
ui_tooltip =
"Be careful. Do not to push too far!\n"
"You can only shift as far as the next\n"
"or previous hue's current value.\n\n"
"Editing is easiest using the widget\n"
"Click the colored box to open it.\n\n"
"RGB Yellow Default Value:\n"
"255 : R:  191, G:  191, B:   64\n"
"0.00: R:0.750, G:0.750, B:0.250";
> = float3(0.75, 0.75, 0.25);
#line 57
uniform float3 HUEGreen <
ui_type = "color";
ui_label = "Green";
ui_tooltip =
"Be careful. Do not to push too far!\n"
"You can only shift as far as the next\n"
"or previous hue's current value.\n\n"
"Editing is easiest using the widget\n"
"Click the colored box to open it.\n\n"
"RGB Green Default Value:\n"
"255 : R:   64, G:  191, B:   64\n"
"0.00: R:0.250, G:0.750, B:0.250";
> = float3(0.25, 0.75, 0.25);
#line 71
uniform float3 HUECyan <
ui_type = "color";
ui_label = "Cyan";
ui_tooltip =
"Be careful. Do not to push too far!\n"
"You can only shift as far as the next\n"
"or previous hue's current value.\n\n"
"Editing is easiest using the widget\n"
"Click the colored box to open it.\n\n"
"RGB Cyan Default Value:\n"
"255 : R:   64, G:  191, B:  191\n"
"0.00: R:0.250, G:0.750, B:0.750";
> = float3(0.25, 0.75, 0.75);
#line 85
uniform float3 HUEBlue <
ui_type = "color";
ui_label="Blue";
ui_tooltip =
"Be careful. Do not to push too far!\n"
"You can only shift as far as the next\n"
"or previous hue's current value.\n\n"
"Editing is easiest using the widget\n"
"Click the colored box to open it.\n\n"
"RGB Blue Default Value:\n"
"255 : R:   64, G:   64, B:  191\n"
"0.00: R:0.250, G:0.250, B:0.750";
> = float3(0.25, 0.25, 0.75);
#line 99
uniform float3 HUEPurple <
ui_type = "color";
ui_label="Purple";
ui_tooltip =
"Be careful. Do not to push too far!\n"
"You can only shift as far as the next\n"
"or previous hue's current value.\n\n"
"Editing is easiest using the widget\n"
"Click the colored box to open it.\n\n"
"RGB Purple Default Value:\n"
"255 : R:  128, G:   64, B:  191\n"
"0.00: R:0.500, G:0.250, B:0.750";
> = float3(0.50, 0.25, 0.75);
#line 113
uniform float3 HUEMagenta <
ui_type = "color";
ui_label="Magenta";
ui_tooltip =
"Be careful. Do not to push too far!\n"
"You can only shift as far as the next\n"
"or previous hue's current value.\n\n"
"Editing is easiest using the widget\n"
"Click the colored box to open it.\n\n"
"RGB Magenta Default Value:\n"
"255 : R:  191, G:   64, B:  191\n"
"0.00: R:0.750, G:0.250, B:0.750";
> = float3(0.75, 0.25, 0.75);
#line 130
static const float HSL_Threshold_Base  = 0.05;
static const float HSL_Threshold_Curve = 1.0;
#line 133
float3 RGB_to_HSL(float3 color)
{
float3 HSL   = 0.0f;
const float  M     = max(color.r, max(color.g, color.b));
const float  C     = M - min(color.r, min(color.g, color.b));
HSL.z = M - 0.5 * C;
#line 140
if (C != 0.0f)
{
float3 Delta  = (color.brg - color.rgb) / C + float3(2.0f, 4.0f, 6.0f);
Delta *= step(M, color.gbr); 
HSL.x = frac(max(Delta.r, max(Delta.g, Delta.b)) / 6.0);
if (HSL.z == 1)
HSL.y = 0.0;
else
HSL.y = C / (1 - abs( 2 * HSL.z - 1));
}
#line 151
return HSL;
}
#line 154
float3 Hue_to_RGB( float h)
{
return saturate(float3( abs(h * 6.0f - 3.0f) - 1.0f,
2.0f - abs(h * 6.0f - 2.0f),
2.0f - abs(h * 6.0f - 4.0f)));
}
#line 161
float3 HSL_to_RGB( float3 HSL )
{
return (Hue_to_RGB(HSL.x) - 0.5) * (1.0 - abs(2.0 * HSL.z - 1)) * HSL.y + HSL.z;
}
#line 166
float LoC( float L0, float L1, float angle)
{
return sqrt(L0*L0+L1*L1-2.0*L0*L1*cos(angle));
}
#line 171
float3 HSLShift(float3 color)
{
const float3 hsl = RGB_to_HSL(color);
const float4 node[9]=
{
float4(HUERed, 0.0),
float4(HUEOrange, 30.0),
float4(HUEYellow, 60.0),
float4(HUEGreen, 120.0),
float4(HUECyan, 180.0),
float4(HUEBlue, 240.0),
float4(HUEPurple, 270.0),
float4(HUEMagenta, 300.0),
float4(HUERed, 360.0),
};
#line 187
int base;
for(int i=0; i<8; i++) if(node[i].a < hsl.r*360.0 )base = i;
#line 190
float w = saturate((hsl.r*360.0-node[base].a)/(node[base+1].a-node[base].a));
#line 192
const float3 H0 = RGB_to_HSL(node[base].rgb);
float3 H1 = RGB_to_HSL(node[base+1].rgb);
#line 195
if (H1.x < H0.x)
H1.x += 1.0;
else
H1.x += 0.0;
#line 200
float3 shift = frac(lerp( H0, H1 , w));
w = max( hsl.g, 0.0)*max( 1.0-hsl.b, 0.0);
shift.b = (shift.b - 0.5)*(pow(w, HSL_Threshold_Curve)*(1.0-HSL_Threshold_Base)+HSL_Threshold_Base)*2.0;
#line 204
return HSL_to_RGB(saturate(float3(shift.r, hsl.g*(shift.g*2.0), hsl.b*(1.0+shift.b))));
}
#line 209
float4	PS_HSLShift(float4 position : SV_Position, float2 txcoord : TexCoord) : SV_Target
{
#line 212
const float3 outcolor = HSLShift(tex2D(ReShade::BackBuffer, txcoord).rgb);
return float4(outcolor + TriDither(outcolor, txcoord, 8), 1.0);
#line 217
}
#line 222
technique HSLShift
{
pass HSLPass
{
VertexShader = PostProcessVS;
PixelShader = PS_HSLShift;
}
}

