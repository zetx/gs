#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Curves.fx"
#line 9
uniform int Mode <
ui_type = "combo";
ui_items = "Luma\0Chroma\0Both Luma and Chroma\0";
ui_tooltip = "Choose what to apply contrast to.";
> = 0;
uniform int Formula <
ui_type = "combo";
ui_items = "Sine\0Abs split\0Smoothstep\0Exp formula\0Simplified Catmull-Rom (0,0,1,1)\0Perlins Smootherstep\0Abs add\0Techicolor Cinestyle\0Parabola\0Half-circles\0Polynomial split\0";
ui_tooltip = "The contrast s-curve you want to use. Note that Technicolor Cinestyle is practically identical to Sine, but runs slower. In fact I think the difference might only be due to rounding errors. I prefer 2 myself, but 3 is a nice alternative with a little more effect (but harsher on the highlight and shadows) and it's the fastest formula.";
> = 4;
#line 20
uniform float Contrast <
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "The amount of contrast you want.";
> = 0.65;
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
#line 26 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Curves.fx"
#line 32
float4 CurvesPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float4 colorInput = tex2D(ReShade::BackBuffer, texcoord);
const float3 lumCoeff = float3(0.2126, 0.7152, 0.0722);  
float Contrast_blend = Contrast;
const float PI = 3.1415927;
#line 45
const float luma = dot(lumCoeff, colorInput.rgb);
#line 47
const float3 chroma = colorInput.rgb - luma;
#line 51
float3 x;
if (Mode == 0)
x = luma; 
else if (Mode == 1)
x = chroma, 
x = x * 0.5 + 0.5; 
else
x = colorInput.rgb; 
#line 65
if (Formula == 0)
{
x = sin(PI * 0.5 * x); 
x *= x;
#line 72
}
#line 75
if (Formula == 1)
{
x = x - 0.5;
x = (x / (0.5 + abs(x))) + 0.5;
#line 81
}
#line 84
if (Formula == 2)
{
#line 87
x = x*x*(3.0 - 2.0*x); 
#line 89
}
#line 92
if (Formula == 3)
{
x = (1.0524 * exp(6.0 * x) - 1.05248) / (exp(6.0 * x) + 20.0855); 
}
#line 98
if (Formula == 4)
{
#line 102
x = x * (x * (1.5 - x) + 0.5); 
#line 104
Contrast_blend = Contrast * 2.0; 
}
#line 108
if (Formula == 5)
{
x = x*x*x*(x*(x*6.0 - 15.0) + 10.0); 
}
#line 114
if (Formula == 6)
{
#line 117
x = x - 0.5;
x = x / ((abs(x)*1.25) + 0.375) + 0.5;
#line 120
}
#line 123
if (Formula == 7)
{
x = (x * (x * (x * (x * (x * (x * (1.6 * x - 7.2) + 10.8) - 4.2) - 3.6) + 2.7) - 1.8) + 2.7) * x * x; 
}
#line 129
if (Formula == 8)
{
x = -0.5 * (x*2.0 - 1.0) * (abs(x*2.0 - 1.0) - 2.0) + 0.5; 
}
#line 135
if (Formula == 9)
{
const float3 xstep = step(x, 0.5); 
const float3 xstep_shift = (xstep - 0.5);
const float3 shifted_x = x + xstep_shift;
#line 141
x = abs(xstep - sqrt(-shifted_x * shifted_x + shifted_x)) - xstep_shift;
#line 158
Contrast_blend = Contrast * 0.5; 
}
#line 162
if (Formula == 10)
{
float3 a = float3(0.0, 0.0, 0.0);
float3 b = float3(0.0, 0.0, 0.0);
#line 167
a = x * x * 2.0;
b = (2.0 * -x + 4.0) * x - 1.0;
if (x.r < 0.5 || x.g < 0.5 || x.b < 0.5)
x = a;
else
x = b;
}
#line 179
if (Mode == 0) 
{
x = lerp(luma, x, Contrast_blend); 
colorInput.rgb = x + chroma; 
}
else if (Mode == 1) 
{
x = x * 2.0 - 1.0; 
const float3 color = luma + x; 
colorInput.rgb = lerp(colorInput.rgb, color, Contrast_blend); 
}
else 
{
const float3 color = x;  
colorInput.rgb = lerp(colorInput.rgb, color, Contrast_blend); 
}
#line 199
return colorInput;
#line 201
}
#line 203
technique Curves
{
pass
{
VertexShader = PostProcessVS;
PixelShader = CurvesPass;
}
}

