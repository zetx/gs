#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MartyMcFlyDOF.fx"
#line 24
uniform bool DOF_AUTOFOCUS <
ui_tooltip = "Enables automated focus recognition based on samples around autofocus center.";
ui_category = "DOF";
> = true;
uniform bool DOF_MOUSEDRIVEN_AF <
ui_tooltip = "Enables mouse driven auto-focus. If 1 the AF focus point is read from the mouse coordinates, otherwise the DOF_FOCUSPOINT is used.";
ui_category = "DOF";
> = false;
uniform float2 DOF_FOCUSPOINT <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "X and Y coordinates of autofocus center. Axes start from upper left screen corner.";
ui_category = "DOF";
> = float2(0.5, 0.5);
uniform float DOF_FOCUSSAMPLES <
ui_type = "slider";
ui_min = 3; ui_max = 10;
ui_tooltip = "Amount of samples around the focus point for smoother focal plane detection.";
ui_category = "DOF";
> = 6;
uniform float DOF_FOCUSRADIUS <
ui_type = "slider";
ui_min = 0.02; ui_max = 0.20;
ui_tooltip = "Radius of samples around the focus point.";
ui_category = "DOF";
> = 0.05;
uniform float DOF_NEARBLURCURVE <
ui_type = "slider";
ui_min = 0.5; ui_max = 1000.0;
ui_step = 0.5;
ui_tooltip = "Curve of blur closer than focal plane. Higher means less blur.";
ui_category = "DOF";
> = 1.60;
uniform float DOF_FARBLURCURVE <
ui_type = "slider";
ui_min = 0.05; ui_max = 5.0;
ui_tooltip = "Curve of blur behind focal plane. Higher means less blur.";
ui_category = "DOF";
> = 2.00;
uniform float DOF_MANUALFOCUSDEPTH <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Depth of focal plane when autofocus is off. 0.0 means camera, 1.0 means infinite distance.";
ui_category = "DOF";
> = 0.02;
uniform float DOF_INFINITEFOCUS <
ui_type = "slider";
ui_min = 0.01; ui_max = 1.0;
ui_tooltip = "Distance at which depth is considered as infinite. 1.0 is standard.\nLow values only produce out of focus blur when focus object is very close to the camera. Recommended for gaming.";
ui_category = "DOF";
> = 1.00;
uniform float DOF_BLURRADIUS <
ui_type = "slider";
ui_min = 2.0; ui_max = 100.0;
ui_tooltip = "Maximal blur radius in pixels.";
ui_category = "DOF";
> = 15.0;
#line 109
uniform int iADOF1_ShapeType <
ui_type = "combo";
ui_items = "Circle (GShade/Angelite)\0Pentagon (ReShade 3/4)\0Diamond\0Triangle\0";
ui_tooltip = "Shape of the DOF.";
ui_category = "MartyMcFly DOF";
> = 0;
uniform int iADOF2_ShapeType <
ui_type = "combo";
ui_items = "Circle (GShade/Angelite)\0Pentagon (ReShade 3/4)\0Diamond\0Triangle\0";
ui_tooltip = "Shape of the DOF.";
ui_category = "MartyMcFly DOF";
> = 0;
uniform int iADOF3_ShapeType <
ui_type = "combo";
ui_items = "Circle (GShade/Angelite)\0Pentagon (ReShade 3/4)\0Diamond\0Triangle\0";
ui_tooltip = "Shape of the DOF.";
ui_category = "MartyMcFly DOF";
> = 0;
uniform float iADOF_ShapeQuality <
ui_type = "slider";
ui_min = 1; ui_max = 255;
ui_tooltip = "Quality level of DOF shape. Higher means more offsets taken, cleaner shape but also less performance. Compilation time stays same.";
ui_category = "MartyMcFly DOF";
> = 17;
uniform float fADOF_ShapeRotation <
ui_type = "slider";
ui_min = 0; ui_max = 360; ui_step = 1;
ui_tooltip = "Static rotation of bokeh shape.";
ui_category = "MartyMcFly DOF";
> = 15;
uniform bool bADOF_RotAnimationEnable <
ui_tooltip = "Enables constant shape rotation in time.";
ui_category = "MartyMcFly DOF";
> = false;
uniform float fADOF_RotAnimationSpeed <
ui_type = "slider";
ui_min = -5; ui_max = 5;
ui_tooltip = "Speed of shape rotation. Negative numbers change direction.";
ui_category = "MartyMcFly DOF";
> = 2.0;
uniform bool bADOF_ShapeCurvatureEnable <
ui_tooltip = "Bends edges of polygonal shape outwards (or inwards). Circular shape best with vertices > 7";
ui_category = "MartyMcFly DOF";
> = false;
uniform float fADOF_ShapeCurvatureAmount <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Amount of edge bending. 1.0 results in circular shape. Values below 0 produce star-like shapes.";
ui_category = "MartyMcFly DOF";
> = 0.3;
uniform bool bADOF_ShapeApertureEnable <
ui_tooltip = "Enables deformation of bokeh shape into swirl-like aperture. You will recognize it when you try it out. Best with big bokeh shapes.";
ui_category = "MartyMcFly DOF";
> = false;
uniform float fADOF_ShapeApertureAmount <
ui_type = "slider";
ui_min = -0.300; ui_max = 0.800;
ui_tooltip = "Amount of deformation. Negative values mirror the effect. ";
ui_category = "MartyMcFly DOF";
> = 0.01;
uniform bool bADOF_ShapeAnamorphEnable <
ui_tooltip = "Lessens horizontal width of shape to simulate anamorphic bokeh shape seen in movies.";
ui_category = "MartyMcFly DOF";
> = false;
uniform float fADOF_ShapeAnamorphRatio <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Horizontal width factor. 1.0 means 100% width, 0.0 means 0% width (bokeh shape will be vertical line).";
ui_category = "MartyMcFly DOF";
> = 0.2;
uniform bool bADOF_ShapeDistortEnable <
ui_tooltip = "Deforms bokeh shape at screen borders to simulate lens distortion. Bokeh shapes at screen egdes look like an egg.";
ui_category = "MartyMcFly DOF";
> = false;
uniform float fADOF_ShapeDistortAmount <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Amount of deformation.";
ui_category = "MartyMcFly DOF";
> = 0.2;
uniform bool bADOF_ShapeDiffusionEnable <
ui_tooltip = "Enables some fuzzyness of bokeh shape, makes it less clearly defined.";
ui_category = "MartyMcFly DOF";
> = false;
uniform float fADOF_ShapeDiffusionAmount <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Amount of shape diffusion. High values look like the bokeh shape exploded.";
ui_category = "MartyMcFly DOF";
> = 0.1;
uniform bool bADOF_ShapeWeightEnable <
ui_tooltip = "Enables bokeh shape weight bias and shifts color to the shape borders.";
ui_category = "MartyMcFly DOF";
> = false;
uniform float fADOF_ShapeWeightCurve <
ui_type = "slider";
ui_min = 0.5; ui_max = 8.0;
ui_tooltip = "Curve of shape weight bias.";
ui_category = "MartyMcFly DOF";
> = 4.0;
uniform float fADOF_ShapeWeightAmount <
ui_type = "slider";
ui_min = 0.5; ui_max = 8.0;
ui_tooltip = "Amount of shape weight bias.";
ui_category = "MartyMcFly DOF";
> = 1.0;
uniform float fADOF_BokehCurve <
ui_type = "slider";
ui_min = 1.0; ui_max = 20.0;
ui_tooltip = "Bokeh factor. Higher values produce more defined bokeh shapes for separated bright spots.";
ui_category = "MartyMcFly DOF";
> = 4.0;
#line 223
uniform bool bADOF_ShapeChromaEnable <
ui_tooltip = "Enables chromatic aberration at bokeh shape borders. This means 3 times more samples = less performance.";
ui_category = "MartyMcFly DOF Advanced";
> = false;
uniform int iADOF_ShapeChromaMode <
ui_type = "combo";
ui_items = "Mode 1\0Mode 2\0Mode 3\0Mode 4\0Mode 5\0Mode 6\0";
ui_tooltip = "Switches through the possible R G B shifts.";
ui_category = "MartyMcFly DOF Advanced";
> = 3;
uniform float fADOF_ShapeChromaAmount <
ui_type = "slider";
ui_min = 0.0; ui_max = 0.5;
ui_tooltip = "Amount of color shifting.";
ui_category = "MartyMcFly DOF Advanced";
> = 0.125;
uniform bool bADOF_ImageChromaEnable <
ui_tooltip = "Enables image chromatic aberration at screen corners.\nThis one is way more complex than the shape chroma (and any other chroma on the web).";
ui_category = "MartyMcFly DOF Advanced";
> = false;
uniform float iADOF_ImageChromaHues <
ui_type = "slider";
ui_min = 2; ui_max = 20;
ui_tooltip = "Amount of samples through the light spectrum to get a smooth gradient.";
ui_category = "MartyMcFly DOF Advanced";
> = 5;
uniform float fADOF_ImageChromaCurve <
ui_type = "slider";
ui_min = 0.5; ui_max = 2.0;
ui_tooltip = "Image chromatic aberration curve. Higher means less chroma at screen center areas.";
ui_category = "MartyMcFly DOF Advanced";
> = 1.0;
uniform float fADOF_ImageChromaAmount <
ui_type = "slider";
ui_min = 0.25; ui_max = 10.0;
ui_tooltip = "Linearly increases image chromatic aberration amount.";
ui_category = "MartyMcFly DOF Advanced";
> = 3.0;
#line 263
uniform float fADOF_SmootheningAmount <
ui_type = "slider";
ui_min = 0.5; ui_max = 2.0;
ui_tooltip = "Blur multiplicator of box blur after bokeh to smoothen shape. Box blur is better than gaussian.";
ui_category = "MartyMcFly DOF Advanced";
> = 1.0;
#line 309
texture texHDR1 { Width = 3440 *  0.6; Height = 1440 *  0.6; Format = RGBA8; };
texture texHDR2 { Width = 3440 *  0.6; Height = 1440 *  0.6; Format = RGBA8; };
sampler SamplerHDR1 { Texture = texHDR1; };
sampler SamplerHDR2 { Texture = texHDR2; };
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
#line 317 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MartyMcFlyDOF.fx"
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
#line 320 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\MartyMcFlyDOF.fx"
#line 323
uniform float2 MouseCoords < source = "mousepoint"; >;
#line 325
float GetCoC(float2 coords)
{
float scenedepth = ReShade::GetLinearizedDepth(coords);
float scenefocus, scenecoc = 0.0;
#line 330
if (DOF_AUTOFOCUS)
{
scenefocus = 0.0;
#line 334
float2 focusPoint;
if (DOF_MOUSEDRIVEN_AF)
focusPoint = MouseCoords *  float2((1.0 / 3440), (1.0 / 1440));
else
focusPoint = DOF_FOCUSPOINT;
#line 340
[loop]
for (int r = DOF_FOCUSSAMPLES; 0 < r; r--)
{
sincos((6.2831853 / DOF_FOCUSSAMPLES) * r, coords.y, coords.x);
coords.y *=  (3440 * (1.0 / 1440));
scenefocus += ReShade::GetLinearizedDepth(coords * DOF_FOCUSRADIUS + focusPoint);
}
scenefocus /= DOF_FOCUSSAMPLES;
}
else
{
scenefocus = DOF_MANUALFOCUSDEPTH;
}
#line 354
scenefocus = smoothstep(0.0, DOF_INFINITEFOCUS, scenefocus);
scenedepth = smoothstep(0.0, DOF_INFINITEFOCUS, scenedepth);
#line 357
if (scenedepth < scenefocus)
{
scenecoc = (scenedepth - scenefocus) / scenefocus;
}
else
{
scenecoc = saturate((scenedepth - scenefocus) / (scenefocus * pow(4.0, DOF_FARBLURCURVE) - scenefocus));
}
#line 366
return saturate(scenecoc * 0.5 + 0.5);
}
#line 372
void PS_Focus(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 hdr1R : SV_Target0)
{
hdr1R = tex2D(ReShade::BackBuffer, texcoord);
hdr1R.w = GetCoC(texcoord);
}
#line 379
float2 GetDistortedOffsets(float2 intexcoord, float2 sampleoffset)
{
const float2 tocenter = intexcoord - float2(0.5, 0.5);
const float3 perp = normalize(float3(tocenter.y, -tocenter.x, 0.0));
#line 384
const float rotangle = length(tocenter) * 2.221 * fADOF_ShapeDistortAmount;
const float3 oldoffset = float3(sampleoffset, 0);
#line 387
const float3 rotatedoffset =  oldoffset * cos(rotangle) + cross(perp, oldoffset) * sin(rotangle) + perp * dot(perp, oldoffset) * (1.0 - cos(rotangle));
#line 389
return rotatedoffset.xy;
}
#line 392
float4 tex2Dchroma(sampler2D tex, float2 sourcecoord, float2 offsetcoord)
{
#line 395
const float3 sample1 = tex2Dlod(tex, float4(sourcecoord.xy + offsetcoord.xy * (1.0 - fADOF_ShapeChromaAmount), 0, 0)).xyz;
const float4 sample2 = tex2Dlod(tex, float4(sourcecoord.xy + offsetcoord.xy, 0, 0));
const float3 sample3 = tex2Dlod(tex, float4(sourcecoord.xy + offsetcoord.xy * (1.0 + fADOF_ShapeChromaAmount), 0, 0)).xyz;
float4 res = (0.0, 0.0, 0.0, sample2.w);
#line 400
switch (iADOF_ShapeChromaMode)
{
case 0:
res.xyz = float3(sample1.x, sample2.y, sample3.z);
return res;
case 1:
res.xyz = float3(sample2.x, sample3.y, sample1.z);
return res;
case 2:
res.xyz = float3(sample3.x, sample1.y, sample2.z);
return res;
case 3:
res.xyz = float3(sample1.x, sample3.y, sample2.z);
return res;
case 4:
res.xyz = float3(sample2.x, sample1.y, sample3.z);
return res;
default:
res.xyz = float3(sample3.x, sample2.y, sample1.z);
return res;
}
}
#line 428
uniform float Timer < source = "timer"; >;
#line 430
float3 BokehBlur(sampler2D tex, float2 coord, float CoC, float centerDepth)
{
float4 res = float4(tex2Dlod(tex, float4(coord.xy, 0.0, 0.0)).xyz, 1.0);
const int ringCount = round(lerp(1.0, (float)iADOF_ShapeQuality, CoC / DOF_BLURRADIUS));
float rotAngle = fADOF_ShapeRotation;
float2 discRadius = CoC *  float2((1.0 / 3440), (1.0 / 1440));
int shapeVertices;
float2 edgeVertices[ 12  + 1];
float2 Grain;
#line 440
switch(iADOF1_ShapeType)
{
#line 443
case 0:
shapeVertices =  12 ;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 448
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 450
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 453
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 456
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 462
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 468
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 481
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 487
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 489
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 492
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 495
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 498
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 504
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 509
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 516
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 523
default:
shapeVertices =  5;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 528
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 530
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 533
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 536
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 542
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 548
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 561
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 567
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 569
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 572
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 575
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 578
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 584
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 589
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 596
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 603
case 2:
shapeVertices =  4;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 608
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 610
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 613
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 616
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 622
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 628
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 641
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 647
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 649
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 652
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 655
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 658
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 664
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 669
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 676
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 684
case 3:
shapeVertices =  3;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 689
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 691
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 694
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 697
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 703
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 709
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 722
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 728
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 730
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 733
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 736
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 739
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 745
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 750
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 757
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
}
#line 765
res.xyz = max(res.xyz / res.w, 0.0);
return pow(res.xyz, 1.0 / fADOF_BokehCurve);
}
#line 769
float3 BokehBlur2(sampler2D tex, float2 coord, float CoC, float centerDepth)
{
float4 res = float4(tex2Dlod(tex, float4(coord.xy, 0.0, 0.0)).xyz, 1.0);
const int ringCount = round(lerp(1.0, (float)iADOF_ShapeQuality, CoC / DOF_BLURRADIUS));
float rotAngle = fADOF_ShapeRotation;
float2 discRadius = CoC *  float2((1.0 / 3440), (1.0 / 1440));
int shapeVertices;
float2 edgeVertices[ 12  + 1];
float2 Grain;
#line 779
switch(iADOF2_ShapeType)
{
#line 782
case 0:
shapeVertices =  12 ;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 787
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 789
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 792
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 795
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 801
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 807
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 820
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 826
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 828
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 831
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 834
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 837
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 843
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 848
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 855
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 862
default:
shapeVertices =  5;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 867
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 869
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 872
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 875
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 881
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 887
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 900
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 906
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 908
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 911
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 914
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 917
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 923
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 928
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 935
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 942
case 2:
shapeVertices =  4;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 947
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 949
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 952
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 955
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 961
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 967
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 980
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 986
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 988
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 991
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 994
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 997
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 1003
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 1008
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 1015
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 1023
case 3:
shapeVertices =  3;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 1028
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 1030
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 1033
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 1036
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 1042
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 1048
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 1061
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 1067
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 1069
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 1072
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 1075
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 1078
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 1084
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 1089
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 1096
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
}
#line 1104
res.xyz = max(res.xyz / res.w, 0.0);
return pow(res.xyz, 1.0 / fADOF_BokehCurve);
}
#line 1108
float3 BokehBlur3(sampler2D tex, float2 coord, float CoC, float centerDepth)
{
float4 res = float4(tex2Dlod(tex, float4(coord.xy, 0.0, 0.0)).xyz, 1.0);
const int ringCount = round(lerp(1.0, (float)iADOF_ShapeQuality, CoC / DOF_BLURRADIUS));
float rotAngle = fADOF_ShapeRotation;
float2 discRadius = CoC *  float2((1.0 / 3440), (1.0 / 1440));
int shapeVertices;
float2 edgeVertices[ 12  + 1];
float2 Grain;
#line 1118
switch(iADOF3_ShapeType)
{
#line 1121
case 0:
shapeVertices =  12 ;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 1126
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 1128
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 1131
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 1134
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 1140
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 1146
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 1159
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 1165
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 1167
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 1170
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 1173
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 1176
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 1182
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 1187
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 1194
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 1201
default:
shapeVertices =  5;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 1206
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 1208
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 1211
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 1214
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 1220
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 1226
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 1239
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 1245
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 1247
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 1250
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 1253
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 1256
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 1262
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 1267
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 1274
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 1281
case 2:
shapeVertices =  4;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 1286
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 1288
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 1291
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 1294
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 1300
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 1306
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 1319
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 1325
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 1327
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 1330
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 1333
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 1336
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 1342
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 1347
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 1354
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
#line 1362
case 3:
shapeVertices =  3;
if (bADOF_ShapeWeightEnable)
res.w = (1.0 - fADOF_ShapeWeightAmount);
#line 1367
res.xyz = pow(abs(res.xyz), fADOF_BokehCurve)*res.w;
#line 1369
if (bADOF_ShapeAnamorphEnable)
discRadius.x *= fADOF_ShapeAnamorphRatio;
#line 1372
if (bADOF_RotAnimationEnable)
rotAngle += fADOF_RotAnimationSpeed * Timer * 0.005;
#line 1375
if (bADOF_ShapeDiffusionEnable)
{
Grain = float2(frac(sin(coord.x + coord.y * 543.31) *  493013.0), frac(cos(coord.x - coord.y * 573.31) * 289013.0));
Grain = (Grain - 0.5) * fADOF_ShapeDiffusionAmount + 1.0;
}
#line 1381
[unroll]
for (int z = 0; z <= shapeVertices; z++)
{
sincos((6.2831853 / shapeVertices)*z + radians(rotAngle), edgeVertices[z].y, edgeVertices[z].x);
}
#line 1387
[loop]
for (float i = 1; i <= ringCount; i++)
{
[loop]
for (int j = 1; j <= shapeVertices; j++)
{
float radiusCoeff = i / ringCount;
float blursamples = i;
#line 1400
[loop]
for (float k = 0; k < blursamples; k++)
{
if (bADOF_ShapeApertureEnable)
radiusCoeff *= 1.0 + sin(k / blursamples * 6.2831853 - 1.5707963)*fADOF_ShapeApertureAmount; 
#line 1406
float2 sampleOffset = lerp(edgeVertices[j - 1], edgeVertices[j], k / blursamples) * radiusCoeff;
#line 1408
if (bADOF_ShapeCurvatureEnable)
sampleOffset = lerp(sampleOffset, normalize(sampleOffset) * radiusCoeff, fADOF_ShapeCurvatureAmount);
#line 1411
if (bADOF_ShapeDistortEnable)
sampleOffset = GetDistortedOffsets(coord, sampleOffset);
#line 1414
if (bADOF_ShapeDiffusionEnable)
sampleOffset *= Grain;
#line 1417
float4 tap;
if (bADOF_ShapeChromaEnable)
tap = tex2Dchroma(tex, coord, sampleOffset * discRadius);
else
tap = tex2Dlod(tex, float4(coord.xy + sampleOffset.xy * discRadius, 0, 0));
#line 1423
if (tap.w >= centerDepth*0.99)
tap.w = 1.0;
else
tap.w = pow(abs(tap.w * 2.0 - 1.0), 4.0);
#line 1428
if (bADOF_ShapeWeightEnable)
tap.w *= lerp(1.0, pow(length(sampleOffset), fADOF_ShapeWeightCurve), fADOF_ShapeWeightAmount);
#line 1435
res.xyz += pow(abs(tap.xyz), fADOF_BokehCurve) * tap.w;
res.w += tap.w;
}
}
}
break;
}
#line 1443
res.xyz = max(res.xyz / res.w, 0.0);
return pow(res.xyz, 1.0 / fADOF_BokehCurve);
}
#line 1447
void PS_McFlyDOF1(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 hdr2R : SV_Target0)
{
texcoord /=  0.6;
#line 1451
hdr2R = tex2D(SamplerHDR1, saturate(texcoord));
#line 1453
const float centerDepth = hdr2R.w;
float discRadius = abs(centerDepth * 2.0 - 1.0) * DOF_BLURRADIUS;
#line 1456
if (centerDepth < 0.5)
discRadius *= 1.0 / max(DOF_NEARBLURCURVE * 2.0, 1.0);
else
discRadius *= 1.0;
#line 1461
if (max(texcoord.x, texcoord.y) <= 1.05 && discRadius >= 1.2)
{
#line 1464
if (discRadius >= 1.2)
hdr2R.xyz = BokehBlur(SamplerHDR1, texcoord, discRadius, centerDepth);
#line 1467
hdr2R.w = centerDepth;
}
}
void PS_McFlyDOF12(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 hdr2R : SV_Target0)
{
texcoord /=  0.6;
#line 1474
hdr2R = tex2D(SamplerHDR1, saturate(texcoord));
#line 1476
const float centerDepth = hdr2R.w;
float discRadius = abs(centerDepth * 2.0 - 1.0) * DOF_BLURRADIUS;
#line 1479
if (centerDepth < 0.5)
discRadius *= 1.0 / max(DOF_NEARBLURCURVE * 2.0, 1.0);
else
discRadius *= 1.0;
#line 1484
if (max(texcoord.x, texcoord.y) <= 1.05 && discRadius >= 1.2)
{
#line 1487
if (discRadius >= 1.2)
hdr2R.xyz = BokehBlur2(SamplerHDR1, texcoord, discRadius, centerDepth);
#line 1490
hdr2R.w = centerDepth;
}
}
void PS_McFlyDOF13(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 hdr2R : SV_Target0)
{
texcoord /=  0.6;
#line 1497
hdr2R = tex2D(SamplerHDR1, saturate(texcoord));
#line 1499
const float centerDepth = hdr2R.w;
float discRadius = abs(centerDepth * 2.0 - 1.0) * DOF_BLURRADIUS;
#line 1502
if (centerDepth < 0.5)
discRadius *= 1.0 / max(DOF_NEARBLURCURVE * 2.0, 1.0);
else
discRadius *= 1.0;
#line 1507
if (max(texcoord.x, texcoord.y) <= 1.05 && discRadius >= 1.2)
{
#line 1510
if (discRadius >= 1.2)
hdr2R.xyz = BokehBlur3(SamplerHDR1, texcoord, discRadius, centerDepth);
#line 1513
hdr2R.w = centerDepth;
}
}
void PS_McFlyDOF2(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 scenecolor : SV_Target)
{
scenecolor = 0.0;
#line 1520
const float centerDepth = GetCoC(texcoord);
float discRadius = abs(centerDepth * 2.0 - 1.0) * DOF_BLURRADIUS;
#line 1523
if (centerDepth < 0.5)
discRadius *= 1.0 / max(DOF_NEARBLURCURVE * 2.0, 1.0);
else
discRadius *= 1.0;
#line 1531
if (bADOF_ImageChromaEnable)
{
const float2 coord = texcoord * 2.0 - 1.0;
float centerfact = length(coord);
centerfact = pow(centerfact, fADOF_ImageChromaCurve) * fADOF_ImageChromaAmount;
#line 1537
float3 chromadivisor = 0.0;
#line 1539
for (float c = 0; c < iADOF_ImageChromaHues; c++)
{
const float temphue = c / iADOF_ImageChromaHues;
float3 tempchroma = saturate(float3(abs(temphue * 6.0 - 3.0) - 1.0, 2.0 - abs(temphue * 6.0 - 2.0), 2.0 - abs(temphue * 6.0 - 4.0)));
scenecolor.xyz += tex2Dlod(SamplerHDR2, float4((coord.xy * (1.0 + ((1.0 / 3440) * centerfact * discRadius) * ((c + 0.5) / iADOF_ImageChromaHues - 0.5)) * 0.5 + 0.5) *  0.6, 0, 0)).xyz*tempchroma.xyz;
chromadivisor += tempchroma;
}
#line 1547
scenecolor.xyz /= dot(chromadivisor.xyz, 0.333);
}
else
{
scenecolor = tex2D(SamplerHDR2, texcoord* 0.6);
}
#line 1554
scenecolor.xyz = lerp(scenecolor.xyz, tex2D(ReShade::BackBuffer, texcoord).xyz, smoothstep(2.0,1.2,discRadius));
#line 1556
scenecolor.w = centerDepth;
#line 1559
scenecolor.xyz += TriDither(scenecolor.xyz, texcoord, 8);
#line 1561
}
void PS_McFlyDOF3(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 scenecolor : SV_Target)
{
scenecolor = tex2D(ReShade::BackBuffer, texcoord);
float4 blurcolor = 0.0001;
#line 1568
const float2 blurmult = smoothstep(0.3, 0.8, abs(scenecolor.w * 2.0 - 1.0)) *  float2((1.0 / 3440), (1.0 / 1440)) * fADOF_SmootheningAmount;
#line 1570
const float weights[3] = { 1.0,0.75,0.5 };
#line 1572
for (int x = -2; x <= 2; x++)
{
for (int y = -2; y <= 2; y++)
{
const float offsetweight = weights[abs(x)] * weights[abs(y)];
blurcolor.xyz += tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(x, y) * blurmult, 0, 0)).xyz * offsetweight;
blurcolor.w += offsetweight;
}
}
#line 1582
scenecolor.xyz = blurcolor.xyz / blurcolor.w;
#line 1606
scenecolor.xyz += TriDither(scenecolor.xyz, texcoord, 8);
#line 1608
}
#line 1613
technique MartyMcFlyDOF1
{
pass Focus { VertexShader = PostProcessVS; PixelShader = PS_Focus; RenderTarget = texHDR1; }
pass McFlyDOF1 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF1; RenderTarget = texHDR2; }
pass McFlyDOF2 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF2;  }
pass McFlyDOF3 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF3;  }
}
technique MartyMcFlyDOF2
{
pass Focus { VertexShader = PostProcessVS; PixelShader = PS_Focus; RenderTarget = texHDR1; }
pass McFlyDOF1 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF12; RenderTarget = texHDR2; }
pass McFlyDOF2 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF2;  }
pass McFlyDOF3 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF3;  }
}
technique MartyMcFlyDOF3
{
pass Focus { VertexShader = PostProcessVS; PixelShader = PS_Focus; RenderTarget = texHDR1; }
pass McFlyDOF1 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF13; RenderTarget = texHDR2; }
pass McFlyDOF2 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF2;  }
pass McFlyDOF3 { VertexShader = PostProcessVS; PixelShader = PS_McFlyDOF3;  }
}

