#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CinematicDOF.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1281 * (1.0 / 721); }
float2 GetPixelSize() { return float2((1.0 / 1281), (1.0 / 721)); }
float2 GetScreenSize() { return float2(1281, 721); }
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
#line 94 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CinematicDOF.fx"
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
#line 97 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CinematicDOF.fx"
#line 100
namespace CinematicDOF
{
#line 114
uniform bool UseAutoFocus <
ui_category = "Focusing";
ui_label = "Use auto-focus";
ui_tooltip = "If enabled it will make the shader focus on the point specified as 'Auto-focus point',\notherwise it will put the focus plane at the depth specified in 'Manual-focus plane'.";
> = true;
uniform bool UseMouseDrivenAutoFocus <
ui_category = "Focusing";
ui_label = "Use mouse-driven auto-focus";
ui_tooltip = "Enables mouse driven auto-focus. If enabled, and 'Use auto-focus' is enabled, the\nauto-focus point is read from the mouse coordinates, otherwise the 'Auto-focus point' is used.";
> = true;
uniform float2 AutoFocusPoint <
ui_category = "Focusing";
ui_label = "Auto-focus point";
ui_type = "slider";
ui_step = 0.001;
ui_min = 0.000; ui_max = 1.000;
ui_tooltip = "The X and Y coordinates of the auto-focus point. 0,0 is the upper left corner,\nand 0.5, 0.5 is at the center of the screen. Only used if 'Use auto focus' is enabled.";
> = float2(0.5, 0.5);
uniform float AutoFocusTransitionSpeed <
ui_category = "Focusing";
ui_label= "Auto-focus transition speed";
ui_type = "slider";
ui_min = 0.001; ui_max = 1.0;
ui_step = 0.01;
ui_tooltip = "The speed the shader will transition between different focus points when using auto-focus.\n0.001 means very slow, 1.0 means instantly. Only used if 'Use auto-focus' is enabled.";
> = 0.2;
uniform float ManualFocusPlane <
ui_category = "Focusing";
ui_label= "Manual-focus plane";
ui_type = "slider";
ui_min = 0.100; ui_max = 150.00;
ui_step = 0.01;
ui_tooltip = "The depth of focal plane related to the camera when 'Use auto-focus' is off.\nOnly used if 'Use auto-focus' is disabled.";
> = 10.00;
uniform float FocalLength <
ui_category = "Focusing";
ui_label = "Focal length (mm)";
ui_type = "slider";
ui_min = 10; ui_max = 300.0;
ui_step = 1.0;
ui_tooltip = "Focal length of the used lens. The longer the focal length, the narrower the\ndepth of field and thus the more is out of focus. For portraits, start with 120 or 150.";
> = 100.00;
uniform float FNumber <
ui_category = "Focusing";
ui_label = "Aperture (f-number)";
ui_type = "slider";
ui_min = 1; ui_max = 22.0;
ui_step = 0.1;
ui_tooltip = "The f-number (also known as f-stop) to use. The higher the number, the wider\nthe depth of field, meaning the more is in-focus and thus the less is out of focus.\nFor portraits, start with 2.8.";
> = 2.8;
#line 165
uniform bool ShowOutOfFocusPlaneOnMouseDown <
ui_category = "Focusing, overlay";
ui_label = "Show out-of-focus plane overlay on mouse down";
ui_tooltip = "Enables the out-of-focus plane overlay when the left mouse button is pressed down,\nwhich helps with fine-tuning the focusing.";
> = true;
uniform float3 OutOfFocusPlaneColor <
ui_category = "Focusing, overlay";
ui_label = "Out-of-focus plane overlay color";
ui_type= "color";
ui_tooltip = "Specifies the color of the out-of-focus planes rendered when the left-mouse button\nis pressed and 'Show out-of-focus plane on mouse down' is enabled. In (red , green, blue)";
> = float3(0.8,0.8,0.8);
uniform float OutOfFocusPlaneColorTransparency <
ui_category = "Focusing, overlay";
ui_label = "Out-of-focus plane transparency";
ui_type = "slider";
ui_min = 0.01; ui_max = 1.0;
ui_tooltip = "Amount of transparency of the out-of-focus planes. 0.0 is transparent, 1.0 is opaque.";
> = 0.7;
uniform float3 FocusPlaneColor <
ui_category = "Focusing, overlay";
ui_label = "Focus plane overlay color";
ui_type= "color";
ui_tooltip = "Specifies the color of the focus plane rendered when the left-mouse button\nis pressed and 'Show out-of-focus plane on mouse down' is enabled. In (red , green, blue)";
> = float3(0.0, 0.0, 1.0);
uniform float4 FocusCrosshairColor<
ui_category = "Focusing, overlay";
ui_label = "Focus crosshair color";
ui_type = "color";
ui_tooltip = "Specifies the color of the crosshair for the auto-focus.\nAuto-focus must be enabled";
> = float4(1.0, 0.0, 1.0, 1.0);
#line 197
uniform float FarPlaneMaxBlur <
ui_category = "Blur tweaking";
ui_label = "Far plane max blur";
ui_type = "slider";
ui_min = 0.000; ui_max = 4.0;
ui_step = 0.01;
ui_tooltip = "The maximum blur a pixel can have when it has its maximum CoC in the far plane. Use this as a tweak\nto adjust the max far plane blur defined by the lens parameters. Don't use this as your primarily\nblur factor, use the lens parameters Focal Length and Aperture for that instead.";
> = 1.0;
uniform float NearPlaneMaxBlur <
ui_category = "Blur tweaking";
ui_label = "Near plane max blur";
ui_type = "slider";
ui_min = 0.000; ui_max = 4.0;
ui_step = 0.01;
ui_tooltip = "The maximum blur a pixel can have when it has its maximum CoC in the near Plane. Use this as a tweak to\nadjust the max near plane blur defined by the lens parameters.  Don't use this as your primarily blur factor,\nuse the lens parameters Focal Length and Aperture for that instead.";
> = 1.0;
uniform float BlurQuality <
ui_category = "Blur tweaking";
ui_label = "Overall blur quality";
ui_type = "slider";
ui_min = 2.0; ui_max = 12.0;
ui_tooltip = "The number of rings to use in the disc-blur algorithm. The more rings the better\nthe blur results, but also the slower it will get.";
ui_step = 1;
> = 5.0;
uniform float BokehBusyFactor <
ui_category = "Blur tweaking";
ui_label="Bokeh busy factor";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_tooltip = "The 'bokeh busy factor' for the blur: 0 means no busyness boost, 1.0 means extra busyness boost.";
ui_step = 0.01;
> = 0.500;
uniform float PostBlurSmoothing <
ui_category = "Blur tweaking";
ui_label = "Post-blur smoothing factor";
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
ui_tooltip = "The amount of post-blur smoothing blur to apply. 0.0 means no smoothing blur is applied.";
ui_step = 0.01;
> = 0.0;
#line 238
uniform float HighlightAnamorphicFactor <
ui_category = "Highlight tweaking, anamorphism";
ui_label="Anamorphic factor";
ui_type = "slider";
ui_min = 0.01; ui_max = 1.00;
ui_tooltip = "The anamorphic factor of the bokeh highlights. A value of 1.0 (default) gives perfect\ncircles, a factor of e.g. 0.1 gives thin ellipses";
ui_step = 0.01;
> = 1.0;
uniform float HighlightAnamorphicSpreadFactor <
ui_category = "Highlight tweaking, anamorphism";
ui_label="Anamorphic spread factor";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_tooltip = "The spread factor for the anamorphic factor. 0.0 means it's relative to the distance\nto the center of the screen, 1.0 means the factor is applied everywhere evenly,\nno matter how far the pixel is to the center of the screen.";
ui_step = 0.01;
> = 0.0;
uniform float HighlightAnamorphicAlignmentFactor <
ui_category = "Highlight tweaking, anamorphism";
ui_label="Anamorphic alignment factor";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_tooltip = "The alignment factor for the anamorphic deformation. 0.0 means you get evenly rotated\nellipses around the center of the screen, 1.0 means all bokeh highlights are\naligned vertically.";
ui_step = 0.01;
> = 0.0;
uniform float HighlightGainFarPlane <
ui_category = "Highlight tweaking, far plane";
ui_label="Highlight gain";
ui_type = "slider";
ui_min = 0.00; ui_max = 5.00;
ui_tooltip = "The gain for highlights in the far plane. The higher the more a highlight gets\nbrighter. Tweak this in tandem with the Highlight threshold. Best results are\nachieved with bright spots in dark(er) backgrounds.";
ui_step = 0.01;
> = 0.500;
uniform float HighlightThresholdFarPlane <
ui_category = "Highlight tweaking, far plane";
ui_label="Highlight threshold";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_tooltip = "The threshold for the source pixels. Pixels with a luminosity above this threshold\nwill be highlighted. Raise this value to only keep the highlights you want.\nWhen highlight type is Twinkle circlets, set the threshold at 0.5 or higher\nfor blur without highlights.";
ui_step = 0.01;
> = 0.0;
uniform float HighlightGainNearPlane <
ui_category = "Highlight tweaking, near plane";
ui_label="Highlight gain";
ui_type = "slider";
ui_min = 0.00; ui_max = 5.00;
ui_tooltip = "The gain for highlights in the near plane. The higher the more a highlight gets\nbrighter. Tweak this in tandem with the Highlight threshold. Best results are\nachieved with bright spots in dark(er) foregrounds.";
ui_step = 0.01;
> = 0.000;
uniform float HighlightThresholdNearPlane <
ui_category = "Highlight tweaking, near plane";
ui_label="Highlight threshold";
ui_type = "slider";
ui_min = 0.00; ui_max = 1.00;
ui_tooltip = "The threshold for the source pixels. Pixels with a luminosity above this threshold\nwill be highlighted. Raise this value to only keep the highlights you want.\nWhen highlight type is Twinkle circlets, set the threshold at 0.5 or higher\nfor blur without highlights.";
ui_step = 0.01;
> = 0.0;
#line 296
uniform bool ShowCoCValues <
ui_category = "Advanced";
ui_label = "Show CoC values and focus plane";
ui_tooltip = "Shows blur disc size (CoC) as grey (far plane) and red (near plane) and focus plane as blue";
> = false;
#line 364
texture texCDCurrentFocus		{ Width = 1; Height = 1; Format = R16F; };		
texture texCDPreviousFocus		{ Width = 1; Height = 1; Format = R16F; };		
texture texCDCoC				{ Width = 1281; Height = 721; Format = R16F; };
texture texCDCoCTileTmp			{ Width = 1281/(			1			*		1); Height = 721/(			1			*		1); Format = R16F; };	
texture texCDCoCTile			{ Width = 1281/(			1			*		1); Height = 721/(			1			*		1); Format = R16F; };	
texture texCDCoCTileNeighbor	{ Width = 1281/(			1			*		1); Height = 721/(			1			*		1); Format = R16F; };	
texture texCDCoCTmp1			{ Width = 1281/2; Height = 721/2; Format = R16F; };	
texture texCDCoCBlurred			{ Width = 1281/2; Height = 721/2; Format = RG16F; };	
texture texCDBuffer1 			{ Width = 1281/2; Height = 721/2; Format = RGBA16F; };
texture texCDBuffer2 			{ Width = 1281/2; Height = 721/2; Format = RGBA16F; };
texture texCDBuffer3 			{ Width = 1281/2; Height = 721/2; Format = RGBA16F; };
texture texCDBuffer4 			{ Width = 1281; Height = 721; Format = RGBA16F; }; 	
texture texCDBuffer5 			{ Width = 1281; Height = 721; Format = RGBA16F; }; 	
texture texCDNoise				< source = "pd80_gaussnoise.png"; > { Width = 512; Height = 512; Format = RGBA8; };
#line 379
sampler	SamplerCDCurrentFocus		{ Texture = texCDCurrentFocus; };
sampler SamplerCDPreviousFocus		{ Texture = texCDPreviousFocus; };
sampler SamplerCDBuffer1 			{ Texture = texCDBuffer1; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDBuffer2 			{ Texture = texCDBuffer2; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDBuffer3 			{ Texture = texCDBuffer3; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDBuffer4 			{ Texture = texCDBuffer4; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDBuffer5 			{ Texture = texCDBuffer5; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDCoC				{ Texture = texCDCoC; MagFilter = POINT; MinFilter = POINT; MipFilter = POINT; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDCoCTmp1			{ Texture = texCDCoCTmp1; MagFilter = POINT; MinFilter = POINT; MipFilter = POINT; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDCoCBlurred			{ Texture = texCDCoCBlurred; MagFilter = POINT; MinFilter = POINT; MipFilter = POINT; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDCoCTileTmp			{ Texture = texCDCoCTileTmp; MagFilter = POINT; MinFilter = POINT; MipFilter = POINT; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDCoCTile			{ Texture = texCDCoCTile; MagFilter = POINT; MinFilter = POINT; MipFilter = POINT; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDCoCTileNeighbor	{ Texture = texCDCoCTileNeighbor; MagFilter = POINT; MinFilter = POINT; MipFilter = POINT; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler SamplerCDNoise				{ Texture = texCDNoise; MipFilter = POINT; MinFilter = POINT; MagFilter = POINT; AddressU = WRAP; AddressV = WRAP; AddressW = WRAP;};
#line 394
uniform float2 MouseCoords < source = "mousepoint"; >;
uniform bool LeftMouseDown < source = "mousebutton"; keycode = 0; toggle = false; >;
#line 398
struct VSFOCUSINFO
{
float4 vpos : SV_Position;
float2 texcoord : TEXCOORD0;
float focusDepth : TEXCOORD1;
float focusDepthInM : TEXCOORD2;
float focusDepthInMM : TEXCOORD3;
float pixelSizeLength : TEXCOORD4;
float nearPlaneInMM : TEXCOORD5;
float farPlaneInMM : TEXCOORD6;
};
#line 410
struct VSDISCBLURINFO
{
float4 vpos : SV_Position;
float2 texcoord : TEXCOORD0;
float numberOfRings : TEXCOORD1;
float farPlaneMaxBlurInPixels : TEXCOORD2;
float nearPlaneMaxBlurInPixels : TEXCOORD3;
float cocFactorPerPixel : TEXCOORD4;
};
#line 426
float3 AccentuateWhites(float3 fragment)
{
return fragment / (1.5 - clamp(fragment, 0, 1.49));	
}
#line 431
float3 CorrectForWhiteAccentuation(float3 fragment)
{
return (fragment.rgb * 1.5) / (1.0 + fragment.rgb);		
}
#line 438
float4 CalculateAnamorphicFactor(float2 pixelVector)
{
const float normalizedFactor = lerp(1, HighlightAnamorphicFactor, lerp(length(pixelVector * 2), 1, HighlightAnamorphicSpreadFactor));
return float4(0, 1 + (1-normalizedFactor), normalizedFactor, 0);
}
#line 447
float2x2 CalculateAnamorphicRotationMatrix(float2 texcoord)
{
float2 pixelVector = normalize(texcoord - 0.5);
const float limiter = (1-HighlightAnamorphicAlignmentFactor)/2;
pixelVector.y = clamp(pixelVector.y, -limiter, limiter);
const float2 refVector = normalize(float2(-0.5, 0));
float2 sincosFactor = float2(0,0);
#line 455
sincos(atan2(pixelVector.y, pixelVector.x) - atan2(refVector.y, refVector.x), sincosFactor.x, sincosFactor.y);
return float2x2(sincosFactor.y, sincosFactor.x, -sincosFactor.x, sincosFactor.y);
}
#line 459
float2 MorphPointOffsetWithAnamorphicDeltas(float2 pointOffset, float4 anamorphicFactors, float2x2 anamorphicRotationMatrix)
{
pointOffset.x = pointOffset.x * anamorphicFactors.x + pointOffset.x*anamorphicFactors.z;
pointOffset.y = pointOffset.y * anamorphicFactors.y + pointOffset.y*anamorphicFactors.w;
return mul(pointOffset, anamorphicRotationMatrix);
}
#line 468
float PerformTileGatherHorizontal(sampler source, float2 texcoord)
{
const float tileSize = 			1			 * (float( float2(1281, 721).x) / 	1920.0f);
float minCoC = 10;
float coc;
float2 coordOffset = float2( float2((1.0 / 1281), (1.0 / 721)).x, 0);
for(float i = 0; i <= tileSize; ++i)
{
coc = tex2Dlod(source, float4(texcoord + coordOffset, 0, 0)).r;
minCoC = min(minCoC, coc);
coc = tex2Dlod(source, float4(texcoord - coordOffset, 0, 0)).r;
minCoC = min(minCoC, coc);
coordOffset.x+= float2((1.0 / 1281), (1.0 / 721)).x;
}
return minCoC;
}
#line 487
float PerformTileGatherVertical(sampler source, float2 texcoord)
{
const float tileSize = 			1			 * (float( float2(1281, 721).y) / 	1200.0f);
float minCoC = 10;
float coc;
float2 coordOffset = float2(0,  float2((1.0 / 1281), (1.0 / 721)).y);
[unroll]
for(float i = 0; i <= tileSize; ++i)
{
coc = tex2Dlod(source, float4(texcoord + coordOffset, 0, 0)).r;
minCoC = min(minCoC, coc);
coc = tex2Dlod(source, float4(texcoord - coordOffset, 0, 0)).r;
minCoC = min(minCoC, coc);
coordOffset.y+= float2((1.0 / 1281), (1.0 / 721)).y;
}
return minCoC;
}
#line 506
float PerformNeighborTileGather(sampler source, float2 texcoord)
{
float minCoC = 10;
const float tileSizeX = 			1			 * (float( float2(1281, 721).x) / 	1920.0f);
const float tileSizeY = 			1			 * (float( float2(1281, 721).y) / 	1200.0f);
#line 513
const float2 baseCoordOffset = float2( float2((1.0 / 1281), (1.0 / 721)).x * (tileSizeX*2+1),  float2((1.0 / 1281), (1.0 / 721)).x * (tileSizeY*2+1));
for(float i=-1;i<2;i++)
{
for(float j=-1;j<2;j++)
{
float2 coordOffset = float2(baseCoordOffset.x * i, baseCoordOffset.y * j);
float coc = tex2Dlod(source, float4(texcoord + coordOffset, 0, 0)).r;
minCoC = min(minCoC, coc);
}
}
return minCoC;
}
#line 530
float4 GetDebugFragment(float radius, bool showInFocus)
{
float4 toReturn = (radius/2 <= length( float2((1.0 / 1281), (1.0 / 721)))) && showInFocus ? float4(0.0, 0.0, 1.0, 1.0) : float4(radius, radius, radius, 1.0);
if(radius < 0)
{
toReturn = float4(-radius, 0, 0, 1);
}
return toReturn;
}
#line 543
float CalculateBlurDiscSize(VSFOCUSINFO focusInfo)
{
const float pixelDepth = ReShade::GetLinearizedDepth(focusInfo.texcoord);
const float pixelDepthInM = pixelDepth * 1000.0;			
#line 557
const float cocInMM = (((FocalLength*FocalLength) / FNumber) / ((focusInfo.focusDepthInM/1000.0) -FocalLength)) *
(abs(pixelDepthInM - focusInfo.focusDepthInM) / (pixelDepthInM + (pixelDepthInM==0)));
const float toReturn = clamp(saturate(abs(cocInMM) * 			0.024		), 0, 1); 
return (pixelDepth < focusInfo.focusDepth) ? -toReturn : toReturn;
}
#line 564
float CalculateSampleWeight(float sampleRadiusInCoC, float ringDistanceInCoC)
{
return  saturate(sampleRadiusInCoC - ringDistanceInCoC + 0.5);
}
#line 570
float3 PostProcessBlurredFragment(float3 fragment, float maxLuma, float3 averageGained, float normalizationFactor)
{
const float3 lumaDotWeight = float3(0.3, 0.59, 0.11);
#line 574
const float newFragmentLuma = dot(fragment, lumaDotWeight);
averageGained.rgb = CorrectForWhiteAccentuation(averageGained.rgb);
#line 578
averageGained.rgb *= 1+saturate(maxLuma-newFragmentLuma);
fragment = (1-normalizationFactor) * fragment + normalizationFactor * averageGained.rgb;
return fragment;
}
#line 591
float4 PerformNearPlaneDiscBlur(VSDISCBLURINFO blurInfo, sampler2D source)
{
const float3 lumaDotWeight = float3(0.3, 0.59, 0.11);
float4 fragment = tex2Dlod(source, float4(blurInfo.texcoord, 0, 0));
#line 596
const float2 fragmentRadii = tex2Dlod(SamplerCDCoCBlurred, float4(blurInfo.texcoord, 0, 0)).rg;
const float fragmentRadiusToUse = fragmentRadii.r;
#line 599
if(fragmentRadii.r <=0)
{
#line 603
fragment.a = 0;
return fragment;
}
#line 608
const float numberOfRings = max(blurInfo.numberOfRings, 1) + 1;
const float pointsFirstRing = 7;
#line 611
const float bokehBusyFactorToUse = saturate(1.0-BokehBusyFactor);		
float4 average = float4(fragment.rgb * fragmentRadiusToUse * bokehBusyFactorToUse, bokehBusyFactorToUse);
float3 averageGained = AccentuateWhites(average.rgb);
float2 pointOffset = float2(0,0);
const float nearPlaneBlurInPixels = blurInfo.nearPlaneMaxBlurInPixels * fragmentRadiusToUse;
const float2 ringRadiusDeltaCoords =  float2((1.0 / 1281), (1.0 / 721)) * (nearPlaneBlurInPixels / (numberOfRings-1));
float pointsOnRing = pointsFirstRing;
float2 currentRingRadiusCoords = ringRadiusDeltaCoords;
float maxLuma = dot(averageGained, lumaDotWeight) * -fragmentRadii.g * (1-HighlightThresholdNearPlane);
const float4 anamorphicFactors = CalculateAnamorphicFactor(blurInfo.texcoord - 0.5); 
const float2x2 anamorphicRotationMatrix = CalculateAnamorphicRotationMatrix(blurInfo.texcoord);
for(float ringIndex = 0; ringIndex < numberOfRings; ringIndex++)
{
float anglePerPoint = 6.28318530717958 / pointsOnRing;
float angle = anglePerPoint;
#line 627
float weight = lerp(ringIndex/numberOfRings, 1, smoothstep(0, 1, bokehBusyFactorToUse));
for(float pointNumber = 0; pointNumber < pointsOnRing; pointNumber++)
{
sincos(angle, pointOffset.y, pointOffset.x);
#line 633
pointOffset = MorphPointOffsetWithAnamorphicDeltas(pointOffset, anamorphicFactors, anamorphicRotationMatrix);
float4 tapCoords = float4(blurInfo.texcoord + (pointOffset * currentRingRadiusCoords), 0, 0);
float4 tap = tex2Dlod(source, tapCoords);
#line 637
float2 sampleRadii = tex2Dlod(SamplerCDCoCBlurred, tapCoords).rg;
float blurredSampleRadius = sampleRadii.r;
average.rgb += tap.rgb * weight;
average.w += weight;
float3 gainedTap = AccentuateWhites(tap.rgb);
averageGained += gainedTap * weight;
float lumaSample = dot(gainedTap, lumaDotWeight) * saturate(blurredSampleRadius) * (1-HighlightThresholdNearPlane);
maxLuma = max(maxLuma, lumaSample);
angle+=anglePerPoint;
}
pointsOnRing+=pointsFirstRing;
currentRingRadiusCoords += ringRadiusDeltaCoords;
}
#line 651
average.rgb/=(average.w + (average.w ==0));
const float alpha = saturate((min(2.5, NearPlaneMaxBlur) + 0.4) * (fragmentRadiusToUse > 0.1 ? (fragmentRadii.g <=0 ? 2 : 1) * fragmentRadiusToUse : max(fragmentRadiusToUse, -fragmentRadii.g)));
fragment.rgb = average.rgb;
fragment.a = alpha;
#line 661
fragment.rgb = PostProcessBlurredFragment(fragment.rgb, maxLuma, (averageGained / (average.w + (average.w==0))), HighlightGainNearPlane);
#line 668
return fragment;
}
#line 677
float4 PerformDiscBlur(VSDISCBLURINFO blurInfo, sampler2D source)
{
const float3 lumaDotWeight = float3(0.3, 0.59, 0.11);
const float pointsFirstRing = 7; 	
float4 fragment = tex2Dlod(source, float4(blurInfo.texcoord, 0, 0));
const float fragmentRadius = tex2Dlod(SamplerCDCoC, float4(blurInfo.texcoord, 0, 0)).r;
#line 684
if(fragmentRadius < 0 || blurInfo.farPlaneMaxBlurInPixels <=0)
{
#line 687
return fragment;
}
#line 690
const float bokehBusyFactorToUse = saturate(1.0-BokehBusyFactor)-0.2;		
float4 average = float4(fragment.rgb * fragmentRadius * bokehBusyFactorToUse, bokehBusyFactorToUse);
float3 averageGained = AccentuateWhites(average.rgb);
float2 pointOffset = float2(0,0);
const float2 ringRadiusDeltaCoords =  ( float2((1.0 / 1281), (1.0 / 721)) * blurInfo.farPlaneMaxBlurInPixels * fragmentRadius) / blurInfo.numberOfRings;
float2 currentRingRadiusCoords = ringRadiusDeltaCoords;
const float cocPerRing = (fragmentRadius * FarPlaneMaxBlur) / blurInfo.numberOfRings;
float pointsOnRing = pointsFirstRing;
float maxLuma = dot(averageGained.rgb, lumaDotWeight) * fragmentRadius * (1-HighlightThresholdFarPlane);
const float4 anamorphicFactors = CalculateAnamorphicFactor(blurInfo.texcoord - 0.5); 
const float2x2 anamorphicRotationMatrix = CalculateAnamorphicRotationMatrix(blurInfo.texcoord);
for(float ringIndex = 0; ringIndex < blurInfo.numberOfRings; ringIndex++)
{
float anglePerPoint = 6.28318530717958 / pointsOnRing;
float angle = anglePerPoint;
float ringWeight = lerp(ringIndex/blurInfo.numberOfRings, 1, bokehBusyFactorToUse);
float ringDistance = cocPerRing * ringIndex;
for(float pointNumber = 0; pointNumber < pointsOnRing; pointNumber++)
{
sincos(angle, pointOffset.y, pointOffset.x);
#line 712
pointOffset = MorphPointOffsetWithAnamorphicDeltas(pointOffset, anamorphicFactors, anamorphicRotationMatrix);
float4 tapCoords = float4(blurInfo.texcoord + (pointOffset * currentRingRadiusCoords), 0, 0);
float sampleRadius = tex2Dlod(SamplerCDCoC, tapCoords).r;
float4 tap = tex2Dlod(source, tapCoords);
float weight = (sampleRadius >=0) * ringWeight * CalculateSampleWeight(sampleRadius * FarPlaneMaxBlur, ringDistance);
average.rgb += tap.rgb * weight;
average.w += weight;
float3 gainedTap = sampleRadius >= 0 ? AccentuateWhites(tap.rgb) : tap.rgb;
averageGained += gainedTap * weight;
float lumaSample = saturate(dot(gainedTap, lumaDotWeight) * sampleRadius * (1-HighlightThresholdFarPlane));
maxLuma = sampleRadius > 0 ? max(maxLuma, lumaSample) : maxLuma;
angle+=anglePerPoint;
}
pointsOnRing+=pointsFirstRing;
currentRingRadiusCoords += ringRadiusDeltaCoords;
}
fragment.rgb = average.rgb / (average.w + (average.w==0));
fragment.rgb = PostProcessBlurredFragment(fragment.rgb, maxLuma, (averageGained / (average.w + (average.w==0))), HighlightGainFarPlane);
return fragment;
}
#line 739
float4 PerformPreDiscBlur(VSDISCBLURINFO blurInfo, sampler2D source)
{
const float radiusFactor = 1.0/max(blurInfo.numberOfRings, 1);
const float pointsFirstRing = max(blurInfo.numberOfRings-3, 2); 	
float4 fragment = tex2Dlod(source, float4(blurInfo.texcoord, 0, 0));
const float signedFragmentRadius = tex2Dlod(SamplerCDCoC, float4(blurInfo.texcoord, 0, 0)).x * radiusFactor;
const float absoluteFragmentRadius = abs(signedFragmentRadius);
bool isNearPlaneFragment = signedFragmentRadius < 0;
const float blurFactorToUse = isNearPlaneFragment ? NearPlaneMaxBlur : FarPlaneMaxBlur;
#line 749
const float numberOfRings = max(blurInfo.numberOfRings-2, 1);
float4 average = absoluteFragmentRadius == 0 ? fragment : float4(fragment.rgb * absoluteFragmentRadius, absoluteFragmentRadius);
float2 pointOffset = float2(0,0);
#line 753
const float2 ringRadiusDeltaCoords =  float2((1.0 / 1281), (1.0 / 721))
* ((isNearPlaneFragment ? blurInfo.nearPlaneMaxBlurInPixels : blurInfo.farPlaneMaxBlurInPixels) *  absoluteFragmentRadius)
* rcp((numberOfRings-1) + (numberOfRings==1));
float pointsOnRing = pointsFirstRing;
float2 currentRingRadiusCoords = ringRadiusDeltaCoords;
const float cocPerRing = (signedFragmentRadius * blurFactorToUse) / numberOfRings;
for(float ringIndex = 0; ringIndex < numberOfRings; ringIndex++)
{
float anglePerPoint = 6.28318530717958 / pointsOnRing;
float angle = anglePerPoint;
float ringDistance = cocPerRing * ringIndex;
for(float pointNumber = 0; pointNumber < pointsOnRing; pointNumber++)
{
sincos(angle, pointOffset.y, pointOffset.x);
float4 tapCoords = float4(blurInfo.texcoord + (pointOffset * currentRingRadiusCoords), 0, 0);
float signedSampleRadius = tex2Dlod(SamplerCDCoC, tapCoords).x * radiusFactor;
float absoluteSampleRadius = abs(signedSampleRadius);
float isSamePlaneAsFragment = ((signedSampleRadius > 0 && !isNearPlaneFragment) || (signedSampleRadius <= 0 && isNearPlaneFragment));
float weight = CalculateSampleWeight(absoluteSampleRadius * blurFactorToUse, ringDistance) * isSamePlaneAsFragment *
(absoluteFragmentRadius - absoluteSampleRadius < 0.001);
average.rgb += (tex2Dlod(source, tapCoords).rgb) * weight;
average.w += weight;
angle+=anglePerPoint;
}
pointsOnRing+=pointsFirstRing;
currentRingRadiusCoords += ringRadiusDeltaCoords;
}
fragment.rgb = average.rgb/(average.w + (average.w==0));
#line 782
fragment.a = dot(fragment.rgb, float3(0.3, 0.59, 0.11));
return fragment;
}
#line 794
float GetBlurDiscRadiusFromSource(sampler2D source, float2 texcoord, bool flattenToZero)
{
const float coc = tex2Dlod(source, float4(texcoord, 0, 0)).r;
#line 799
return (flattenToZero && coc >= 0) ? 0 : abs(coc);
}
#line 811
float PerformSingleValueGaussianBlur(sampler2D source, float2 texcoord, float2 offsetWeight, bool flattenToZero)
{
const float offset[18] = { 0.0, 1.4953705027, 3.4891992113, 5.4830312105, 7.4768683759, 9.4707125766, 11.4645656736, 13.4584295168, 15.4523059431, 17.4461967743, 19.4661974725, 21.4627427973, 23.4592916956, 25.455844494, 27.4524015179, 29.4489630909, 31.445529535, 33.4421011704 };
float weight[18] = { 0.033245, 0.0659162217, 0.0636705814, 0.0598194658, 0.0546642566, 0.0485871646, 0.0420045997, 0.0353207015, 0.0288880982, 0.0229808311, 0.0177815511, 0.013382297, 0.0097960001, 0.0069746748, 0.0048301008, 0.0032534598, 0.0021315311, 0.0013582974 };
#line 816
float coc = GetBlurDiscRadiusFromSource(source, texcoord, flattenToZero);
coc *= weight[0];
#line 819
const float2 factorToUse = offsetWeight * NearPlaneMaxBlur * 0.8;
for(int i = 1; i < 18; ++i)
{
float2 coordOffset = factorToUse * offset[i];
float weightSample = weight[i];
coc += GetBlurDiscRadiusFromSource(source, texcoord + coordOffset, flattenToZero) * weightSample;
coc += GetBlurDiscRadiusFromSource(source, texcoord - coordOffset, flattenToZero) * weightSample;
}
#line 828
return saturate(coc);
}
#line 837
float4 PerformFullFragmentGaussianBlur(sampler2D source, float2 texcoord, float2 offsetWeight)
{
const float offset[6] = { 0.0, 1.4584295168, 3.40398480678, 5.3518057801, 7.302940716, 9.2581597095 };
const float weight[6] = { 0.13298, 0.23227575, 0.1353261595, 0.0511557427, 0.01253922, 0.0019913644 };
const float3 lumaDotWeight = float3(0.3, 0.59, 0.11);
#line 843
const float coc = tex2Dlod(SamplerCDCoC, float4(texcoord, 0, 0)).r;
float4 fragment = tex2Dlod(source, float4(texcoord, 0, 0));
const float fragmentLuma = dot(fragment.rgb, lumaDotWeight);
const float4 originalFragment = fragment;
const float absoluteCoC = abs(coc);
const float lengthPixelSize = length( float2((1.0 / 1281), (1.0 / 721)));
if(absoluteCoC < 0.2 || PostBlurSmoothing < 0.01 || fragmentLuma < 0.3)
{
#line 852
return fragment;
}
fragment.rgb *= weight[0];
const float2 factorToUse = offsetWeight * PostBlurSmoothing;
for(int i = 1; i < 6; ++i)
{
float2 coordOffset = factorToUse * offset[i];
float weightSample = weight[i];
float sampleCoC = tex2Dlod(SamplerCDCoC, float4(texcoord + coordOffset, 0, 0)).r;
float maskFactor = abs(sampleCoC) < 0.2;		
fragment.rgb += (originalFragment.rgb * maskFactor * weightSample) +
(tex2Dlod(source, float4(texcoord + coordOffset, 0, 0)).rgb * (1-maskFactor) * weightSample);
sampleCoC = tex2Dlod(SamplerCDCoC, float4(texcoord - coordOffset, 0, 0)).r;
maskFactor = abs(sampleCoC) < 0.2;
fragment.rgb += (originalFragment.rgb * maskFactor * weightSample) +
(tex2Dlod(source, float4(texcoord - coordOffset, 0, 0)).rgb * (1-maskFactor) * weightSample);
}
return saturate(fragment);
}
#line 874
void FillFocusInfoData(inout VSFOCUSINFO toFill)
{
#line 881
toFill.focusDepth = tex2Dlod(SamplerCDCurrentFocus, float4(0, 0, 0, 0)).r;
toFill.focusDepthInM = toFill.focusDepth * 1000.0; 		
toFill.focusDepthInMM = toFill.focusDepthInM * 1000.0; 	
toFill.pixelSizeLength = length( float2((1.0 / 1281), (1.0 / 721)));
#line 887
const float hyperFocal = (FocalLength * FocalLength) / (FNumber * 			0.024		);
const float hyperFocalFocusDepthFocus = (hyperFocal * toFill.focusDepthInMM);
toFill.nearPlaneInMM = hyperFocalFocusDepthFocus / (hyperFocal + (toFill.focusDepthInMM - FocalLength));	
toFill.farPlaneInMM = hyperFocalFocusDepthFocus / (hyperFocal - (toFill.focusDepthInMM - FocalLength));		
}
#line 901
VSFOCUSINFO VS_Focus(in uint id : SV_VertexID)
{
VSFOCUSINFO focusInfo;
#line 905
focusInfo.texcoord.x = (id == 2) ? 2.0 : 0.0;
focusInfo.texcoord.y = (id == 1) ? 2.0 : 0.0;
focusInfo.vpos = float4(focusInfo.texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
#line 918
FillFocusInfoData(focusInfo);
#line 920
return focusInfo;
}
#line 924
VSDISCBLURINFO VS_DiscBlur(in uint id : SV_VertexID)
{
VSDISCBLURINFO blurInfo;
#line 928
blurInfo.texcoord.x = (id == 2) ? 2.0 : 0.0;
blurInfo.texcoord.y = (id == 1) ? 2.0 : 0.0;
blurInfo.vpos = float4(blurInfo.texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
#line 932
blurInfo.numberOfRings = round(BlurQuality);
float pixelSizeLength = length( float2((1.0 / 1281), (1.0 / 721)));
blurInfo.farPlaneMaxBlurInPixels = (FarPlaneMaxBlur / 100.0) / pixelSizeLength;
blurInfo.nearPlaneMaxBlurInPixels = (NearPlaneMaxBlur / 100.0) / pixelSizeLength;
blurInfo.cocFactorPerPixel = length( float2((1.0 / 1281), (1.0 / 721))) * blurInfo.farPlaneMaxBlurInPixels;	
return blurInfo;
}
#line 947
void PS_DetermineCurrentFocus(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float fragment : SV_Target0)
{
const float2 autoFocusPointToUse = UseMouseDrivenAutoFocus ? MouseCoords *  float2((1.0 / 1281), (1.0 / 721)) : AutoFocusPoint;
fragment = UseAutoFocus ? lerp(tex2D(SamplerCDPreviousFocus, float2(0, 0)).r, ReShade::GetLinearizedDepth(autoFocusPointToUse), AutoFocusTransitionSpeed)
: (ManualFocusPlane / 1000);
}
#line 955
void PS_CopyCurrentFocus(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float fragment : SV_Target0)
{
fragment = tex2D(SamplerCDCurrentFocus, float2(0, 0)).r;
}
#line 961
void PS_CalculateCoCValues(VSFOCUSINFO focusInfo, out float fragment : SV_Target0)
{
#line 966
fragment = CalculateBlurDiscSize(focusInfo);
}
#line 971
void PS_PreBlur(VSDISCBLURINFO blurInfo, out float4 fragment : SV_Target0)
{
fragment = PerformPreDiscBlur(blurInfo, ReShade::BackBuffer);
}
#line 977
void PS_BokehBlur(VSDISCBLURINFO blurInfo, out float4 fragment : SV_Target0)
{
fragment = PerformDiscBlur(blurInfo, SamplerCDBuffer1);
}
#line 984
void PS_NearBokehBlur(VSDISCBLURINFO blurInfo, out float4 fragment : SV_Target0)
{
fragment = PerformNearPlaneDiscBlur(blurInfo, SamplerCDBuffer2);
}
#line 990
void PS_CoCTile1(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float fragment : SV_Target0)
{
fragment = PerformTileGatherHorizontal(SamplerCDCoC, texcoord);
}
#line 996
void PS_CoCTile2(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float fragment : SV_Target0)
{
fragment = PerformTileGatherVertical(SamplerCDCoCTileTmp, texcoord);
}
#line 1002
void PS_CoCTileNeighbor(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float fragment : SV_Target0)
{
fragment = PerformNeighborTileGather(SamplerCDCoCTile, texcoord);
}
#line 1008
void PS_CoCGaussian1(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float fragment : SV_Target0)
{
#line 1011
fragment = PerformSingleValueGaussianBlur(SamplerCDCoCTileNeighbor, texcoord,
float2( float2((1.0 / 1281), (1.0 / 721)).x * ( float2(1281, 721).x/	1920.0f), 0.0), true);
}
#line 1016
void PS_CoCGaussian2(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float2 fragment : SV_Target0)
{
#line 1019
fragment = float2(PerformSingleValueGaussianBlur(SamplerCDCoCTmp1, texcoord,
float2(0.0,  float2((1.0 / 1281), (1.0 / 721)).y * ( float2(1281, 721).y/	1200.0f)), false),
tex2D(SamplerCDCoCTileNeighbor, texcoord).x);
}
#line 1025
void PS_Combiner(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 fragment : SV_Target0)
{
#line 1028
const float4 originalFragment = tex2D(ReShade::BackBuffer, texcoord);
const float4 farFragment = tex2D(SamplerCDBuffer3, texcoord);
const float4 nearFragment = tex2D(SamplerCDBuffer1, texcoord);
#line 1032
const float realCoC = tex2D(SamplerCDCoC, texcoord).r * clamp(0, 1, FarPlaneMaxBlur);
#line 1035
const float blendFactor = (realCoC > 0.1) ? 1 : smoothstep(0, 1, (realCoC / 0.1));
fragment = lerp(originalFragment, farFragment, blendFactor);
fragment.rgb = lerp(fragment.rgb, nearFragment.rgb, nearFragment.a * (NearPlaneMaxBlur != 0));
#line 1044
fragment.a = 1.0;
}
#line 1050
void PS_TentFilter(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 fragment : SV_Target0)
{
const float4 coord =  float2((1.0 / 1281), (1.0 / 721)).xyxy * float4(1, 1, -1, 0);
float4 average;
average = tex2D(SamplerCDBuffer2, texcoord - coord.xy);
average += tex2D(SamplerCDBuffer2, texcoord - coord.wy) * 2;
average += tex2D(SamplerCDBuffer2, texcoord - coord.zy);
average += tex2D(SamplerCDBuffer2, texcoord + coord.zw) * 2;
average += tex2D(SamplerCDBuffer2, texcoord) * 4;
average += tex2D(SamplerCDBuffer2, texcoord + coord.xw) * 2;
average += tex2D(SamplerCDBuffer2, texcoord + coord.zy);
average += tex2D(SamplerCDBuffer2, texcoord + coord.wy) * 2;
average += tex2D(SamplerCDBuffer2, texcoord + coord.xy);
fragment = average / 16;
}
#line 1067
void PS_PostSmoothing1(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 fragment : SV_Target0)
{
fragment = PerformFullFragmentGaussianBlur(SamplerCDBuffer4, texcoord, float2( float2((1.0 / 1281), (1.0 / 721)).x, 0.0));
}
#line 1076
void PS_PostSmoothing2AndFocusing(in VSFOCUSINFO focusInfo, out float4 fragment : SV_Target0)
{
if(ShowCoCValues)
{
fragment = GetDebugFragment(tex2D(SamplerCDCoC, focusInfo.texcoord).r, true);
return;
}
#line 1105
fragment = PerformFullFragmentGaussianBlur(SamplerCDBuffer5, focusInfo.texcoord, float2(0.0,  float2((1.0 / 1281), (1.0 / 721)).y));
float4 originalFragment = tex2D(SamplerCDBuffer4, focusInfo.texcoord);
#line 1108
float2 uv = float2(1281, 721) / float2( 512.0f, 512.0f ); 
uv.xy = uv.xy * focusInfo.texcoord.xy;
float noise = tex2D(SamplerCDNoise, uv).x; 
fragment.xyz = saturate(fragment.xyz + lerp( -0.5/255.0, 0.5/255.0, noise)); 
#line 1113
float coc = abs(tex2Dlod(SamplerCDCoC, float4(focusInfo.texcoord, 0, 0)).r);
fragment.rgb = lerp(originalFragment.rgb, fragment.rgb, saturate(coc < length( float2((1.0 / 1281), (1.0 / 721))) ? 0 : 4 * coc));
fragment.w = 1.0;
#line 1120
if(ShowOutOfFocusPlaneOnMouseDown && LeftMouseDown)
{
const float depthPixelInMM = ReShade::GetLinearizedDepth(focusInfo.texcoord) * 1000.0 * 1000.0;
float4 colorToBlend = fragment;
if(depthPixelInMM < focusInfo.nearPlaneInMM || (focusInfo.farPlaneInMM > 0 && depthPixelInMM > focusInfo.farPlaneInMM))
{
colorToBlend = float4(OutOfFocusPlaneColor, 1.0);
}
else
{
if(abs(coc) < focusInfo.pixelSizeLength)
{
colorToBlend = float4(FocusPlaneColor, 1.0);
}
}
fragment = lerp(fragment, colorToBlend, OutOfFocusPlaneColorTransparency);
if(UseAutoFocus)
{
const float2 focusPointCoords = UseMouseDrivenAutoFocus ? MouseCoords *  float2((1.0 / 1281), (1.0 / 721)) : AutoFocusPoint;
fragment = lerp(fragment, FocusCrosshairColor, FocusCrosshairColor.w * saturate(exp(-1281 * length(focusInfo.texcoord - float2(focusPointCoords.x, focusInfo.texcoord.y)))));
fragment = lerp(fragment, FocusCrosshairColor, FocusCrosshairColor.w * saturate(exp(-721 * length(focusInfo.texcoord - float2(focusInfo.texcoord.x, focusPointCoords.y)))));
}
}
#line 1145
fragment.rgb = fragment.rgb + TriDither(fragment.rgb, focusInfo.texcoord, 8);
#line 1147
}
#line 1155
technique CinematicDOF
< ui_tooltip = "Cinematic Depth of Field "
 "v1.1.18"
"\n===========================================\n\n"
"Cinematic Depth of Field is a state of the art depth of field shader,\n"
"offering fine-grained control over focusing, blur aspects and highlights,\n"
"using real-life lens aspects. Cinematic Depth of Field is based on\n"
"various papers, of which the references are included in the source code.\n\n"
"Cinematic Depth of Field was written by Frans 'Otis_Inf' Bouma and is part of OtisFX\n"
"https://fransbouma.com | https://github.com/FransBouma/OtisFX"; >
{
pass DetermineCurrentFocus { VertexShader = PostProcessVS; PixelShader = PS_DetermineCurrentFocus; RenderTarget = texCDCurrentFocus; }
pass CopyCurrentFocus { VertexShader = PostProcessVS; PixelShader = PS_CopyCurrentFocus; RenderTarget = texCDPreviousFocus; }
pass CalculateCoC { VertexShader = VS_Focus; PixelShader = PS_CalculateCoCValues; RenderTarget = texCDCoC; }
pass CoCTile1 { VertexShader = PostProcessVS; PixelShader = PS_CoCTile1; RenderTarget = texCDCoCTileTmp; }
pass CoCTile2 { VertexShader = PostProcessVS; PixelShader = PS_CoCTile2; RenderTarget = texCDCoCTile; }
pass CoCTileNeighbor { VertexShader = PostProcessVS; PixelShader = PS_CoCTileNeighbor; RenderTarget = texCDCoCTileNeighbor; }
pass CoCBlur1 { VertexShader = PostProcessVS; PixelShader = PS_CoCGaussian1; RenderTarget = texCDCoCTmp1; }
pass CoCBlur2 { VertexShader = PostProcessVS; PixelShader = PS_CoCGaussian2; RenderTarget = texCDCoCBlurred; }
pass PreBlur { VertexShader = VS_DiscBlur; PixelShader = PS_PreBlur; RenderTarget = texCDBuffer1; }
pass BokehBlur { VertexShader = VS_DiscBlur; PixelShader = PS_BokehBlur; RenderTarget = texCDBuffer2; }
pass NearBokehBlur { VertexShader = VS_DiscBlur; PixelShader = PS_NearBokehBlur; RenderTarget = texCDBuffer1; }
pass TentFilter { VertexShader = PostProcessVS; PixelShader = PS_TentFilter; RenderTarget = texCDBuffer3; }
pass Combiner { VertexShader = PostProcessVS; PixelShader = PS_Combiner; RenderTarget = texCDBuffer4; }
pass PostSmoothing1 { VertexShader = PostProcessVS; PixelShader = PS_PostSmoothing1; RenderTarget = texCDBuffer5; }
pass PostSmoothing2AndFocusing { VertexShader = VS_Focus; PixelShader = PS_PostSmoothing2AndFocusing;}
}
}
