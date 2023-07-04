#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\TiltShift.fx"
#line 18
uniform bool Line <
ui_label = "Show Center Line";
> = false;
#line 22
uniform int Axis <
ui_label = "Angle";
ui_type = "slider";
ui_step = 1;
ui_min = -89; ui_max = 90;
> = 0;
#line 29
uniform float Offset <
ui_type = "slider";
ui_min = -1.41; ui_max = 1.41; ui_step = 0.01;
> = 0.05;
#line 34
uniform float BlurCurve <
ui_label = "Blur Curve";
ui_type = "slider";
ui_min = 1.0; ui_max = 5.0; ui_step = 0.01;
ui_label = "Blur Curve";
> = 1.0;
uniform float BlurMultiplier <
ui_label = "Blur Multiplier";
ui_type = "slider";
ui_min = 0.0; ui_max = 100.0; ui_step = 0.2;
> = 6.0;
#line 46
uniform int BlurSamples <
ui_label = "Blur Samples";
ui_type = "slider";
ui_min = 2; ui_max = 32;
> = 11;
#line 53
texture TiltShiftTarget < pooled = true; > { Width = 3440; Height = 1440; Format = RGBA8; };
sampler TiltShiftSampler { Texture = TiltShiftTarget; };
#line 64
float get_weight(float t)
{
const float bottom = min(t, 0.5);
const float top = max(t, 0.5);
return 2.0 *(bottom*bottom +top +top -top*top) -1.5;
}
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
#line 75 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\TiltShift.fx"
#line 81
void TiltShiftPass1PS(float4 vpos : SV_Position, float2 UvCoord : TEXCOORD, out float4 Image : SV_Target)
{
#line 84
Image.rgb = tex2D(ReShade::BackBuffer, UvCoord).rgb;
#line 86
float2 UvCoordAspect = UvCoord;
UvCoordAspect.y += ReShade:: GetAspectRatio() * 0.5 - 0.5;
UvCoordAspect.y /= ReShade:: GetAspectRatio();
#line 90
UvCoordAspect = UvCoordAspect * 2.0 - 1.0;
#line 92
const float Angle = radians(-Axis);
const float2 TiltVector = float2(sin(Angle), cos(Angle));
#line 95
float BlurMask = abs(dot(TiltVector, UvCoordAspect) + Offset);
BlurMask = max(0.0, min(1.0, BlurMask));
#line 98
Image.a = BlurMask;
BlurMask = pow(Image.a, BlurCurve);
#line 102
if(BlurMask > 0)
{
#line 105
const float UvOffset = ReShade:: GetPixelSize().x *BlurMask *BlurMultiplier;
#line 107
float total_weight = 0.5;
#line 109
for (int i=1; i<BlurSamples; i++)
{
#line 112
const float current_sample = float(i)/float(BlurSamples);
#line 114
const float current_weight = get_weight(1.0-current_sample);
#line 116
total_weight += current_weight;
#line 118
const float SampleOffset = current_sample*11.0 * UvOffset; 
#line 120
Image.rgb += (
tex2Dlod( ReShade::BackBuffer, float4(float2(UvCoord.x+SampleOffset, UvCoord.y), 0.0, 0.0) ).rgb
+tex2Dlod( ReShade::BackBuffer, float4(float2(UvCoord.x-SampleOffset, UvCoord.y), 0.0, 0.0) ).rgb
) *current_weight;
}
#line 126
Image.rgb /= total_weight*2.0;
}
}
#line 130
void TiltShiftPass2PS(float4 vpos : SV_Position, float2 UvCoord : TEXCOORD, out float4 Image : SV_Target)
{
#line 133
Image = tex2D(TiltShiftSampler, UvCoord);
#line 135
float BlurMask = pow(abs(Image.a), BlurCurve);
#line 137
if(BlurMask > 0)
{
#line 140
const float UvOffset = ReShade:: GetPixelSize().y *BlurMask *BlurMultiplier;
#line 142
float total_weight = 0.5;
#line 144
for (int i=1; i<BlurSamples; i++)
{
#line 147
const float current_sample = float(i)/float(BlurSamples);
#line 149
const float current_weight = get_weight(1.0-current_sample);
#line 151
total_weight += current_weight;
#line 153
const float SampleOffset = current_sample*11.0 * UvOffset; 
#line 155
Image.rgb += (
tex2Dlod( TiltShiftSampler, float4(float2(UvCoord.x, UvCoord.y+SampleOffset), 0.0, 0.0) ).rgb
+tex2Dlod( TiltShiftSampler, float4(float2(UvCoord.x, UvCoord.y-SampleOffset), 0.0, 0.0) ).rgb
) *current_weight;
}
#line 161
Image.rgb /= total_weight*2.0;
}
#line 165
if (Line && Image.a < 0.01)
Image.rgb = float3(1.0, 0.0, 0.0);
#line 171
}
#line 178
technique TiltShift < ui_label = "Tilt Shift"; >
{
pass AlphaAndHorizontalGaussianBlur
{
VertexShader = PostProcessVS;
PixelShader = TiltShiftPass1PS;
RenderTarget = TiltShiftTarget;
}
pass VerticalGaussianBlurAndRedLine
{
VertexShader = PostProcessVS;
PixelShader = TiltShiftPass2PS;
}
}

