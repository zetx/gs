#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PerfectPerspective2.fx"
#line 27
uniform int FovType <
ui_type = "combo";
ui_category = "Game field-of-view"; ui_category_closed = false;
ui_label = "FOV type";
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
"horizontal\0"
"diagonal\0"
"vertical\0"
"4:3\0"
"16:9\0";
> = 0;
#line 49
uniform int FovAngle <
ui_type = "slider";
ui_category = "Game field-of-view";
ui_label = "FOV angle";
ui_tooltip = "This setting should match your in-game FOV (in degrees)";
#line 57
ui_min = 0; ui_max = 170;
> = 90;
#line 62
uniform int SimplePresets <
ui_type = "radio";
ui_category = "Presets"; ui_category_closed = false;
ui_label = "Gaming style";
ui_items =
"shooting\0"
"racing\0"
"skating (ref.)\0"
"flying\0"
"stereopsis\0"
"cinematic\0";
> = 0;
#line 75
uniform bool Manual <
ui_type = "input";
ui_category = "Manual"; ui_category_closed = true;
ui_label = "enable Manual";
ui_tooltip = "Change horizontal and vertical perspective manually.";
> = false;
#line 82
uniform int PresetKx <
ui_type = "radio";
ui_category = "Manual";
ui_label = "Horizontal perspective";
ui_spacing = 1;
ui_items =
"x  shape/angle\0"
"x  speed/aim\0"
"x  distance/size\0";
> = 0;
#line 93
uniform int PresetKy <
ui_type = "radio";
ui_category = "Manual";
ui_label = "Vertical perspective";
ui_spacing = 2;
ui_items =
"y  shape/angle\0"
"y  speed/aim\0"
"y  distance/size\0";
> = 0;
#line 104
uniform bool Expert <
ui_type = "input";
ui_category = "Expert"; ui_category_closed = true;
ui_label = "enable Expert";
> = false;
#line 110
uniform float2 K <
ui_type = "slider";
ui_category = "Expert";
ui_label = "k 2D";
ui_spacing = 1;
ui_tooltip =
"K  1 ...Rectilinear projection (standard), preserves straight lines,"
" but doesn't preserve proportions, angles or scale.\n"
"K  0.5 ...Stereographic projection (navigation, shapes) preserves angles and proportions,"
" best for navigation through tight spaces.\n"
"K  0 .....Equidistant (aiming) maintains angular speed of motion,"
" best for aiming at fast targets.\n"
"K -0.5 ...Equisolid projection (distances) preserves area relation,"
" best for navigation in open spaces.\n"
"K -1 ...Orthographic projection preserves planar luminance as cosine-law,"
" has extreme radial compression. Found in peephole viewer.";
ui_min = -1; ui_max = 1;
> = float2(1, 1);
#line 131
uniform float Zoom <
ui_type = "drag";
ui_category = "Border settings"; ui_category_closed = true;
ui_label = "Scale image";
ui_tooltip = "Adjust image scale and cropped area size";
ui_min = 0.8; ui_max = 1.5; ui_step = 0.001;
> = 1;
#line 139
uniform float4 BorderColor <
ui_type = "color";
ui_category = "Border settings";
ui_label = "Border color";
ui_spacing = 2;
ui_tooltip = "Use Alpha to change transparency";
> = float4(0.027, 0.027, 0.027, 0.784);
#line 148
uniform float BorderCorners <
ui_type = "slider";
ui_category = "Border settings";
ui_label = "Corner roundness";
ui_tooltip = "Represents corners curvature\n0 gives sharp corners";
ui_min = 0; ui_max = 1;
> = 0.0862;
#line 156
uniform bool MirrorBorder <
ui_type = "input";
ui_category = "Border settings";
ui_label = "Mirror background";
ui_tooltip = "Choose original or mirrored image at the border";
> = true;
#line 163
uniform int VignettingStyle <
ui_type = "radio";
ui_category = "Border settings";
ui_label = "Vignetting style";
ui_spacing = 2;
ui_items =
"vignette turned off\0"
"vignette inside\0"
"vignette on borders\0";
> = 2;
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
#line 183 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PerfectPerspective2.fx"
#line 186
sampler BackBuffer
{
Texture = ReShade::BackBufferTex;
AddressU = MIRROR;
AddressV = MIRROR;
#line 192
SRGBTexture = true;
#line 194
};
#line 210
float aastep(float grad)
{
float2 Del = float2(ddx(grad), ddy(grad));
return saturate(rsqrt(dot(Del, Del))*grad+0.5);
}
#line 224
float glength(int G, float2 pos)
{
if (G<=0) return max(abs(pos.x), abs(pos.y)); 
pos = pow(abs(pos), ++G); 
return pow(pos.x+pos.y, rcp(G)); 
}
#line 244
float pantomorphic(float halfOmega, float2 k, inout float2 viewcoord)
{
#line 247
if (halfOmega==0.0) return 1.0;
#line 250
float rcp_f;
{
#line 253
if (k.x>0.0)	  rcp_f = tan(k.x*halfOmega)/k.x;
else if (k.x<0.0) rcp_f = sin(k.x*halfOmega)/k.x;
else              rcp_f = halfOmega;
}
#line 259
float r = length(viewcoord);
#line 262
float2 theta2;
{
#line 265
if (k.x>0.0)	  theta2.x = atan(r*k.x*rcp_f)/k.x;
else if (k.x<0.0) theta2.x = asin(r*k.x*rcp_f)/k.x;
else			  theta2.x = r*rcp_f;
#line 269
if (k.y>0.0)	  theta2.y = atan(r*k.y*rcp_f)/k.y;
else if (k.y<0.0) theta2.y = asin(r*k.y*rcp_f)/k.y;
else			  theta2.y = r*rcp_f;
}
#line 275
float2 philerp = viewcoord*viewcoord; philerp /= philerp.x+philerp.y; 
#line 278
float vignetteMask; if (VignettingStyle!=0)
{	
float2 vignetteMask2 = cos(max(abs(k), 0.5)*theta2);
#line 282
vignetteMask2 = pow(abs(vignetteMask2), k*0.5+1.5);
#line 284
vignetteMask = dot(vignetteMask2, philerp);
} else vignetteMask = 1.0; 
#line 288
float theta = dot(theta2, philerp);
#line 290
viewcoord *= tan(theta)/(tan(halfOmega)*r);
#line 292
return vignetteMask;
}
#line 301
float BorderMaskPS(float2 borderCoord)
{
#line 304
borderCoord = abs(borderCoord);
if (BorderCorners!=0.0) 
{
#line 308
if ( (1024 * (1.0 / 768))>1.0) 
borderCoord.x = borderCoord.x* (1024 * (1.0 / 768))+(1.0- (1024 * (1.0 / 768)));
else if ( (1024 * (1.0 / 768))<1.0) 
borderCoord.y = borderCoord.y* (768*(1.0 / 1024))+(1.0- (768*(1.0 / 1024)));
#line 313
borderCoord = max(borderCoord+(BorderCorners-1.0), 0.0)/BorderCorners;
#line 315
return aastep(glength( 2, borderCoord)-1.0); 
} 
else return aastep(glength(0, borderCoord)-1.0);
}
#line 321
float3 PantomorphicPS(float4 pos : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
#line 324
float halfHorizontalFov = tan(radians(FovAngle*0.5));
#line 326
switch(FovType)
{
#line 329
case 1: halfHorizontalFov *= rsqrt( (768*(1.0 / 1024))* (768*(1.0 / 1024))+1); break;
#line 331
case 2: halfHorizontalFov *=  (1024 * (1.0 / 768)); break;
#line 333
case 3: halfHorizontalFov *= (3.0/4.0)* (1024 * (1.0 / 768)); break;
#line 336
case 4: halfHorizontalFov *= (9.0/16.0)* (1024 * (1.0 / 768)); break;
#line 339
}
#line 341
halfHorizontalFov = atan(halfHorizontalFov);
#line 344
float2 sphCoord = texCoord*2.0-1.0;
#line 346
sphCoord.y *=  (768*(1.0 / 1024));
#line 348
sphCoord *= clamp(Zoom, 0.8, 1.5); 
#line 351
float2 k;
if (Expert) k = clamp(K, -1.0, 1.0);
else if (Manual)
{
switch (PresetKx)
{
default: k.x =  0.5; break; 
case 1:  k.x =  0.0; break; 
case 2:  k.x = -0.5; break; 
#line 361
}
switch (PresetKy)
{
default: k.y =  0.5; break; 
case 1:  k.y =  0.0; break; 
case 2:  k.y = -0.5; break; 
#line 368
}
}
else switch (SimplePresets)
{
default: k = float2( 0.0, 0.5); break; 
case 1:  k = float2( 0.5,-0.5); break; 
case 2:  k = float2( 0.5, 0.5); break; 
case 3:  k = float2(-0.5, 0.0); break; 
case 4:  k = float2( 0.0,-0.5); break; 
case 5:  k = float2( 0.618, 0.862); break; 
#line 379
}
#line 382
float vignetteMask = pantomorphic(halfHorizontalFov, k, sphCoord);
#line 385
sphCoord.y *=  (1024 * (1.0 / 768));
#line 388
float3 display = tex2D(BackBuffer, sphCoord*0.5+0.5).rgb;
#line 390
if (VignettingStyle!=1 && BorderColor.a==0.0 && MirrorBorder) return vignetteMask*display;
#line 393
float borderMask = BorderMaskPS(sphCoord);
#line 396
if (VignettingStyle==2)
return vignetteMask*lerp(
display,
lerp(
MirrorBorder? display : tex2D(BackBuffer, texCoord).rgb,
 pow(abs(BorderColor.rgb), 2.2),
 pow(abs(BorderColor.a), 2.2)
), borderMask);
else return lerp(
vignetteMask*display,
lerp(
MirrorBorder? display : tex2D(BackBuffer, texCoord).rgb,
 pow(abs(BorderColor.rgb), 2.2),
 pow(abs(BorderColor.a), 2.2)
), borderMask);
}
#line 418
technique Pantomorphic <
ui_tooltip =
"Adjust perspective for distortion-free picture\n"
"(anamorphic, fish-eye and vignetting)\n"
"\nManual:\n"
"Fist select proper FOV angle and type.\n"
"If FOV type is unknown, set preset to 'skating' and find a round object within the game.\n"
"look at it upfront, then rotate the camera so that the object is in the corner.\n"
"Change FOV type such that the object does not have an egg shape, but a perfect round shape.\n"
"\nSecondly adjust perspective type according to game-play style.\n"
"Thirdly, adjust visible borders. You can zoom in the picture to hide borders and reveal UI.\n"
"\nAdditionally for sharp image, use FilmicSharpen.fx or run the game at Super-Resolution.";
>
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PantomorphicPS;
SRGBWriteEnable = true;
}
}

