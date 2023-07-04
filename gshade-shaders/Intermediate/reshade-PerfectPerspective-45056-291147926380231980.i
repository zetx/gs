#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PerfectPerspective.fx"
#line 38
uniform int FOV <
ui_type = "slider";
ui_category = "Field of View";
ui_label = "Game field of view";
ui_tooltip = "This setting should match your in-game FOV (in degrees)";
#line 46
ui_min = 0; ui_max = 170;
> = 90;
#line 49
uniform int Type <
ui_type = "combo";
ui_category = "Field of View";
ui_label = "Type of FOV";
ui_tooltip = "...in stereographic mode\n"
"If image bulges in movement (too high FOV),\n"
"change it to 'Diagonal'.\n"
"When proportions are distorted at the periphery\n"
"(too low FOV), choose 'Vertical' or '4:3'.\n"
"For ultra-wide display you may want '16:9' instead.\n\n"
"Adjust so that round objects are still round in\n"
"the corners, and not oblong.\n\n"
"*This method works only in 'navigation' preset,\n"
"or k=0.5 in manual.";
ui_items =
"Horizontal FOV\0"
"Diagonal FOV\0"
"Vertical FOV\0"
"4:3 FOV\0"
"16:9 FOV\0";
> = 0;
#line 73
uniform int Projection <
ui_type = "radio";
ui_spacing = 1;
ui_category = "Perspective";
ui_category_closed = true;
ui_text = "Select gaming style:";
ui_label = "Perspective type";
ui_tooltip =
"Choose type of perspective, according to game-play style.\n"
"For manual perspective adjustment, select the last option.\n"
" Navigation  K  0.5  (Stereographic)\n"
" Aiming      K  0    (Equidistant)\n"
" Distance    K -0.5  (Equisolid)";
ui_items =
"Navigation\0"
"Aiming\0"
"Feel of distance\0"
"\tmanual adjustment*\0";
> = 0;
#line 93
uniform float K <
ui_type = "slider";
ui_category = "Perspective";
ui_label = "K (manual)*";
ui_tooltip =
"K  1.0 ...Rectilinear projection (standard), preserves straight lines,"
" but doesn't preserve proportions, angles or scale.\n"
"K  0.5 ...Stereographic projection (navigation, shapes) preserves angles and proportions,"
" best for navigation through tight spaces.\n"
"K  0 .....Equidistant (aiming) maintains angular speed of motion,"
" best for aiming at fast targets.\n"
"K -0.5 ...Equisolid projection (distances) preserves area relation,"
" best for navigation in open spaces.\n"
"K -1.0 ...Orthographic projection preserves planar luminance as cosine-law,"
" has extreme radial compression. Found in peephole viewer.";
ui_min = -1.0; ui_max = 1.0;
> = 1.0;
#line 111
uniform float Vertical <
ui_type = "slider";
ui_spacing = 2;
ui_category = "Perspective";
ui_text = "Global adjustments:";
ui_label = "Vertical distortion";
ui_tooltip =
"Cylindrical perspective <<>> Spherical perspective"
"\n\nFor curved displays set this above 1.";
ui_min = 0.0; ui_max = 1.2; ui_step = 0.01;
> = 1.0;
#line 123
uniform float VerticalScale <
ui_type = "slider";
ui_category = "Perspective";
ui_label = "Vertical proportions";
ui_tooltip = "Adjust anamorphic correction for cylindrical perspective";
ui_min = 0.8; ui_max = 1.0; ui_step = 0.01;
> = 0.98;
#line 133
uniform bool Vignette <
ui_type = "input";
ui_category = "Border";
ui_category_closed = true;
ui_label = "use Vignette";
ui_tooltip = "Create lens-correct natural vignette effect";
> = true;
#line 141
uniform float Zooming <
ui_type = "slider";
ui_spacing = 2;
ui_category = "Border";
ui_label = "Border scale";
ui_tooltip = "Adjust image scale and cropped area size";
ui_min = 0.5; ui_max = 2.0; ui_step = 0.001;
> = 1.0;
#line 150
uniform float2 Offset <
ui_type = "slider";
ui_category = "Border";
ui_label = "Border offset";
ui_tooltip = "Offset the picture in XY to adjust UI visibility";
ui_min = -0.1; ui_max = 0.1; ui_step = 0.001;
> = float2(0.0, 0.0);
#line 158
uniform float4 BorderColor <
ui_type = "color";
ui_spacing = 2;
ui_category = "Border";
ui_label = "Border color";
ui_tooltip = "Use Alpha to change transparency";
> = float4(0.027, 0.027, 0.027, 0.784);
#line 166
uniform bool BorderVignette <
ui_type = "input";
ui_category = "Border";
ui_label = "borders with Vignette";
ui_tooltip = "Affect borders with vignetting effect";
> = false;
#line 173
uniform float BorderCorner <
ui_type = "slider";
ui_category = "Border";
ui_label = "Corner roundness";
ui_tooltip = "Represents corners curvature\n0.0 gives sharp corners";
ui_min = 1.0; ui_max = 0.0;
> = 0.062;
#line 181
uniform bool MirrorBorder <
ui_type = "input";
ui_category = "Border";
ui_label = "Mirrored border";
ui_tooltip = "Choose original or mirrored image at the border";
> = true;
#line 190
uniform bool DebugPreview <
ui_type = "input";
ui_spacing = 2;
ui_category = "Tools for debugging";
ui_category_closed = true;
ui_label = "Resolution scale map";
ui_tooltip = "Color map of the Resolution Scale:\n"
" Red   - under-sampling\n"
" Green - super-sampling\n"
" Blue  - neutral sampling";
> = false;
#line 202
uniform int ResScaleVirtual <
ui_type = "slider";
ui_category = "Tools for debugging";
ui_label = "Virtual resolution";
ui_tooltip = "Simulates application running beyond\n"
"native screen resolution (using VSR or DSR)";
ui_min = 16; ui_max = 16384; ui_step = 0.2;
> = 1920;
#line 211
uniform int ResScaleScreen <
ui_type = "input";
ui_category = "Tools for debugging";
ui_label = "Native screen resolution";
ui_tooltip = "Simulates application running beyond\n"
"native screen resolution (using VSR or DSR)";
> = 1920;
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
#line 224 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PerfectPerspective.fx"
#line 227
sampler BackBuffer
{
Texture = ReShade::BackBufferTex;
AddressU = MIRROR;
AddressV = MIRROR;
#line 233
SRGBTexture = true;
#line 235
};
#line 243
float grayscale(float3 Color)
{ return max(max(Color.r, Color.g), Color.b); }
#line 246
float3 gamma(float3 grad) { return pow(abs(grad), 2.2); }
float4 gamma(float4 grad) { return pow(abs(grad), 2.2); }
#line 253
float pixStep(float grad)
{
float2 Del = float2(ddx(grad), ddy(grad));
return saturate(rsqrt(dot(Del, Del))*grad);
}
#line 276
float univPerspVignette(in out float2 viewCoord, float k, float l, float s)
{
#line 279
if (FOV==0 || k==1.0 && !Vignette && (l==1.0 || s==1.0)) return 1.0;
#line 282
float R = l==1.0?
dot(viewCoord, viewCoord) : 
(viewCoord.x*viewCoord.x)+l*(viewCoord.y*viewCoord.y); 
float rcpR = rsqrt(R); R = sqrt(R);
#line 288
const float halfOmega = radians(FOV*0.5);
#line 290
const float rTanHalfOmega = rcp(tan(halfOmega));
#line 293
float theta;
if (k>0.0) theta = atan(tan(k*halfOmega)*R)/k;
else if (k<0.0) theta = asin(sin(k*halfOmega)*R)/k;
else  theta = halfOmega*R;
#line 299
float vignetteMask;
if (Vignette && !DebugPreview)
{
#line 303
float thetaLimit = max(abs(k), 0.5)*theta;
#line 305
vignetteMask = cos(thetaLimit);
vignetteMask = lerp(
vignetteMask, 
vignetteMask*vignetteMask, 
clamp(k+0.5, 0.0, 1.0) 
);
#line 312
if (l!=1.0)
{
#line 315
float3 perspVec = float3( (sin(theta)/R)*viewCoord, cos(theta));
vignetteMask /= dot(perspVec, perspVec); 
}
}
else 
vignetteMask = 1.0;
#line 323
if (s!=1.0 && l!=1.0) viewCoord.y /= (s+l)-s*l; 
#line 326
viewCoord *= tan(theta)*rcpR*rTanHalfOmega;
#line 329
return vignetteMask;
}
#line 342
float BorderMaskPS(float2 sphCoord)
{
float borderMask;
#line 346
if (BorderCorner == 0.0) 
borderMask = max( abs(sphCoord.x), abs(sphCoord.y));
else 
{
#line 351
float2 borderCoord = abs(sphCoord);
#line 353
if ( (1024 * (1.0 / 768)) > 1.0) 
borderCoord.x = borderCoord.x* (1024 * (1.0 / 768))+(1.0- (1024 * (1.0 / 768)));
else if ( (1024 * (1.0 / 768)) < 1.0) 
borderCoord.y = borderCoord.y* (768*(1.0 / 1024))+(1.0- (768*(1.0 / 1024)));
#line 358
borderMask = length( max(borderCoord+BorderCorner-1.0, 0.0))/BorderCorner;
}
#line 361
return pixStep(borderMask-1.0);
}
#line 366
float3 DebugViewModePS(float3 display, float2 texCoord, float2 sphCoord)
{
#line 369
float4 radialCoord = float4(texCoord, sphCoord)*2.0-1.0;
#line 371
radialCoord.yw *=  (768*(1.0 / 1024));
#line 374
const float3   underSmpl = gamma(float3(1.0, 0.0, 0.2)); 
const float3   superSmpl = gamma(float3(0.0, 1.0, 0.5)); 
const float3 neutralSmpl = gamma(float3(0.0, 0.5, 1.0)); 
#line 379
float pixelScaleMap = fwidth( length(radialCoord.xy) );
#line 381
pixelScaleMap = pixelScaleMap*ResScaleScreen/ResScaleVirtual/fwidth(length(radialCoord.zw))-1.0;
#line 384
float3 resMap = lerp(
superSmpl,
underSmpl,
step(0.0, pixelScaleMap)
);
#line 391
pixelScaleMap = saturate(1.0-4.0*abs(pixelScaleMap)); 
#line 394
resMap = lerp(resMap, neutralSmpl, pixelScaleMap);
#line 397
return (0.8*grayscale(display)+0.2)*normalize(resMap);
}
#line 402
float3 PerfectPerspectivePS(float4 pos : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
#line 405
float FovType; switch(Type)
{
#line 408
default: FovType = 1.0; break;
#line 410
case 1: FovType = sqrt( (768*(1.0 / 1024))* (768*(1.0 / 1024))+1.0); break;
#line 412
case 2: FovType =  (768*(1.0 / 1024)); break;
#line 414
case 3: FovType = (4.0/3.0) * (768*(1.0 / 1024)); break;
#line 416
case 4: FovType = (16.0/9.0) * (768*(1.0 / 1024)); break;
}
#line 420
float2 sphCoord = texCoord*2.0 -1.0;
#line 422
sphCoord.x -= Offset.y; 
sphCoord.y  = Offset.x+sphCoord.y* (768*(1.0 / 1024));
#line 425
sphCoord *= clamp(Zooming, 0.5, 2.0)/FovType; 
#line 428
float k; switch (Projection)
{
case 0:  k =  0.5; break; 
case 1:  k =  0.0; break; 
case 2:  k = -0.5; break; 
#line 434
default: k = clamp(K, -1.0, 1.0); break;
}
#line 437
float vignetteMask = univPerspVignette(sphCoord, k, Vertical, VerticalScale);
#line 440
sphCoord *= FovType;
#line 443
sphCoord.y *=  (1024 * (1.0 / 768));
#line 446
float borderMask = BorderMaskPS(sphCoord);
#line 449
sphCoord = sphCoord*0.5+0.5;
#line 452
float3 display = tex2D(BackBuffer, sphCoord).rgb;
#line 455
float4 BorderColorLinear = gamma(BorderColor);
#line 457
if (BorderVignette)
display = vignetteMask*lerp(
display,
lerp(
MirrorBorder? display : tex2D(BackBuffer, texCoord).rgb,
BorderColorLinear.rgb,
BorderColorLinear.a
), borderMask
);
else display = lerp(
vignetteMask*display,
lerp(
MirrorBorder? display : tex2D(BackBuffer, texCoord).rgb,
BorderColorLinear.rgb,
BorderColorLinear.a
), borderMask
);
#line 476
if (DebugPreview) return DebugViewModePS(display, texCoord, sphCoord);
else return display;
}
#line 485
technique PerfectPerspective <
ui_label = "Perfect Perspective";
ui_tooltip =
"Adjust perspective for distortion-free picture\n"
"(fish-eye, panini shader and vignetting)\n\n"
"Manual:\n"
"Fist select proper FOV angle and type.\n"
"If FOV type is unknown, find a round object within the game and look at it upfront,\n"
"then rotate the camera so that the object is in the corner.\n"
"Change FOV type such that the object does not have an egg shape, but a perfect round shape.\n\n"
"Secondly adjust perspective type according to game-play style.\n"
"If you look mostly at the horizon, 'Vertical distortion' value can be lowered.\n"
"For curved-display correction, set it above one.\n\n"
"Thirdly, adjust visible borders. You can zoom in the picture and offset to hide borders and reveal UI.\n\n"
"Additionally for sharp image, use FilmicSharpen.fx or run the game at Super-Resolution.\n"
"Debug options can help you find the proper value.";
>
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PerfectPerspectivePS;
SRGBWriteEnable = true;
}
}

