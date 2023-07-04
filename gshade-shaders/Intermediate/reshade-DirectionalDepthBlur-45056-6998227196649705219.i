#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DirectionalDepthBlur.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1799 * (1.0 / 995); }
float2 GetPixelSize() { return float2((1.0 / 1799), (1.0 / 995)); }
float2 GetScreenSize() { return float2(1799, 995); }
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
#line 43 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DirectionalDepthBlur.fx"
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
#line 46 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DirectionalDepthBlur.fx"
#line 49
namespace DirectionalDepthBlur
{
#line 62
uniform float FocusPlane <
ui_category = "Focusing";
ui_label= "Focus plane";
ui_type = "slider";
ui_min = 0.001; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The depth of the plane where the blur starts, related to the camera";
> = 0.010;
uniform float FocusRange <
ui_category = "Focusing";
ui_label= "Focus range";
ui_type = "slider";
ui_min = 0.001; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The range around the focus plane that's more or less not blurred.\n1.0 is the FocusPlaneMaxRange.";
> = 0.001;
uniform float FocusPlaneMaxRange <
ui_category = "Focusing";
ui_label= "Focus plane max range";
ui_type = "slider";
ui_min = 10; ui_max = 300;
ui_step = 1;
ui_tooltip = "The max range Focus Plane for when Focus Plane is 1.0.\n1000 is the horizon.";
> = 150;
uniform float BlurAngle <
ui_category = "Blur tweaking";
ui_label="Blur angle";
ui_type = "slider";
ui_min = 0.01; ui_max = 1.00;
ui_tooltip = "The angle of the blur direction";
ui_step = 0.01;
> = 1.0;
uniform float BlurLength <
ui_category = "Blur tweaking";
ui_label = "Blur length";
ui_type = "slider";
ui_min = 0.000; ui_max = 1.0;
ui_step = 0.001;
ui_tooltip = "The length of the blur strokes per pixel. 1.0 is the entire screen.";
> = 0.1;
uniform float BlurQuality <
ui_category = "Blur tweaking";
ui_label = "Blur quality";
ui_type = "slider";
ui_min = 0.01; ui_max = 1.0;
ui_step = 0.01;
ui_tooltip = "The quality of the blur. 1.0 means all pixels in the blur length are\nread, 0.5 means half of them are read.";
> = 0.5;
uniform float ScaleFactor <
ui_category = "Blur tweaking";
ui_label = "Scale factor";
ui_type = "slider";
ui_min = 0.010; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The scale factor for the pixels to blur. Lower values downscale the\nsource frame and will result in wider blur strokes.";
> = 1.000;
uniform int BlurType <
ui_category = "Blur tweaking";
ui_type = "combo";
ui_min= 0; ui_max=1;
ui_items="Parallel Strokes\0Focus Point Targeting Strokes\0";
ui_label = "The blur type";
ui_tooltip = "The blur type. Focus Point Targeting Strokes means the blur directions\nper pixel are towards the Focus Point.";
> = 0;
uniform float2 FocusPoint <
ui_category = "Blur tweaking";
ui_label = "Blur focus point";
ui_type = "slider";
ui_step = 0.001;
ui_min = 0.000; ui_max = 1.000;
ui_tooltip = "The X and Y coordinates of the blur focus point, which is used for\nthe Blur type 'Focus Point Targeting Strokes'. 0,0 is the\nupper left corner, and 0.5, 0.5 is at the center of the screen.";
> = float2(0.5, 0.5);
uniform float3 FocusPointBlendColor <
ui_category = "Blur tweaking";
ui_label = "Focus point color";
ui_type= "color";
ui_tooltip = "The color of the focus point in Point focused mode. The closer a\npixel is to the focus point, the more it will become this color.\nIn (red , green, blue)";
> = float3(0.0,0.0,0.0);
uniform float FocusPointBlendFactor <
ui_category = "Blur tweaking";
ui_label = "Focus point color blend factor";
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The factor with which the focus point color is blended with the final image";
> = 1.000;
uniform float HighlightGain <
ui_category = "Blur tweaking";
ui_label="Highlight gain";
ui_type = "slider";
ui_min = 0.00; ui_max = 5.00;
ui_tooltip = "The gain for highlights in the strokes plane. The higher the more a highlight gets\nbrighter.";
ui_step = 0.01;
> = 0.500;
uniform float BlendFactor <
ui_category = "Blur tweaking";
ui_label="Blend factor";
ui_type = "drag";
ui_min = 0.00; ui_max = 1.00;
ui_tooltip = "How strong the effect is applied to the original image. 1.0 is 100%, 0.0 is 0%.";
ui_step = 0.01;
> = 1.000;
#line 198
uniform float2 MouseCoords < source = "mousepoint"; >;
#line 200
texture texDownsampledBackBuffer { Width = 1799; Height = 995; Format = RGBA16F; };
texture texBlurDestination { Width = 1799; Height = 995; Format = RGBA16F; };
#line 203
sampler samplerDownsampledBackBuffer { Texture = texDownsampledBackBuffer; AddressU = MIRROR; AddressV = MIRROR; AddressW = MIRROR;};
sampler samplerBlurDestination { Texture = texBlurDestination; };
#line 206
struct VSPIXELINFO
{
float4 vpos : SV_Position;
float2 texCoords : TEXCOORD0;
float2 pixelDelta: TEXCOORD1;
float blurLengthInPixels: TEXCOORD2;
float focusPlane: TEXCOORD3;
float focusRange: TEXCOORD4;
float4 texCoordsScaled: TEXCOORD5;
};
#line 223
float2 CalculatePixelDeltas(float2 texCoords)
{
float2 mouseCoords = MouseCoords *  float2((1.0 / 1799), (1.0 / 995));
#line 227
return (float2(FocusPoint.x - texCoords.x, FocusPoint.y - texCoords.y)) * length( float2((1.0 / 1799), (1.0 / 995)));
}
#line 230
float3 AccentuateWhites(float3 fragment)
{
return fragment / (1.5 - clamp(fragment, 0, 1.49));	
}
#line 235
float3 CorrectForWhiteAccentuation(float3 fragment)
{
return (fragment.rgb * 1.5) / (1.0 + fragment.rgb);		
}
#line 240
float3 PostProcessBlurredFragment(float3 fragment, float maxLuma, float3 averageGained, float normalizationFactor)
{
const float3 lumaDotWeight = float3(0.3, 0.59, 0.11);
#line 244
averageGained.rgb = CorrectForWhiteAccentuation(averageGained.rgb);
#line 247
averageGained.rgb *= 1+saturate(maxLuma - dot(fragment, lumaDotWeight));
fragment = (1-normalizationFactor) * fragment + normalizationFactor * averageGained.rgb;
return fragment;
}
#line 258
VSPIXELINFO VS_PixelInfo(in uint id : SV_VertexID)
{
VSPIXELINFO pixelInfo;
#line 262
if (id == 2)
pixelInfo.texCoords.x = 2.0;
else
pixelInfo.texCoords.x = 0.0;
if (id == 1)
pixelInfo.texCoords.y = 2.0;
else
pixelInfo.texCoords.y = 0.0;
pixelInfo.vpos = float4(pixelInfo.texCoords * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
sincos(6.28318530717958 * BlurAngle, pixelInfo.pixelDelta.y, pixelInfo.pixelDelta.x);
pixelInfo.pixelDelta *= length( float2((1.0 / 1799), (1.0 / 995)));
pixelInfo.blurLengthInPixels = length( float2(1799, 995)) * BlurLength;
pixelInfo.focusPlane = (FocusPlane * FocusPlaneMaxRange) / 1000.0;
pixelInfo.focusRange = (FocusRange * FocusPlaneMaxRange) / 1000.0;
pixelInfo.texCoordsScaled = float4(pixelInfo.texCoords * ScaleFactor, pixelInfo.texCoords / ScaleFactor);
return pixelInfo;
}
#line 286
void PS_Blur(VSPIXELINFO pixelInfo, out float4 fragment : SV_Target0)
{
const float3 lumaDotWeight = float3(0.3, 0.59, 0.11);
#line 290
float4 average = float4(tex2Dlod(samplerDownsampledBackBuffer, float4(pixelInfo.texCoordsScaled.xy, 0, 0)).rgb, 1.0);
float3 averageGained = AccentuateWhites(average.rgb);
float2 pixelDelta;
if (BlurType == 0)
pixelDelta = pixelInfo.pixelDelta;
else
pixelDelta = CalculatePixelDeltas(pixelInfo.texCoords);
float maxLuma = dot(AccentuateWhites(float4(tex2Dlod(samplerDownsampledBackBuffer, float4(pixelInfo.texCoordsScaled.xy, 0, 0)).rgb, 1.0).rgb).rgb, lumaDotWeight);
for(float tapIndex=0.0;tapIndex<pixelInfo.blurLengthInPixels;tapIndex+=(1/BlurQuality))
{
float2 tapCoords = (pixelInfo.texCoords + (pixelDelta * tapIndex));
float3 tapColor = tex2Dlod(samplerDownsampledBackBuffer, float4(tapCoords * ScaleFactor, 0, 0)).rgb;
float weight;
if (ReShade::GetLinearizedDepth(tapCoords) <= pixelInfo.focusPlane)
weight = 0.0;
else
weight = 1-(tapIndex/ pixelInfo.blurLengthInPixels);
average.rgb+=(tapColor * weight);
average.a+=weight;
float3 gainedTap = AccentuateWhites(tapColor.rgb);
averageGained += gainedTap * weight;
if (weight > 0)
maxLuma = max(maxLuma, saturate(dot(gainedTap, lumaDotWeight)));
}
fragment.rgb = average.rgb / (average.a + (average.a==0));
if (BlurType != 0)
fragment.rgb = lerp(fragment.rgb, lerp(FocusPointBlendColor, fragment.rgb, smoothstep(0, 1, distance(pixelInfo.texCoords, FocusPoint))), FocusPointBlendFactor);
fragment.rgb = lerp(tex2Dlod(samplerDownsampledBackBuffer, float4(pixelInfo.texCoordsScaled.xy, 0, 0)).rgb, PostProcessBlurredFragment(fragment.rgb, saturate(maxLuma), (averageGained / (average.a + (average.a==0))), HighlightGain), BlendFactor);
fragment.a = 1.0;
}
#line 322
void PS_Combiner(VSPIXELINFO pixelInfo, out float4 fragment : SV_Target0)
{
const float colorDepth = ReShade::GetLinearizedDepth(pixelInfo.texCoords);
fragment = tex2Dlod(ReShade::BackBuffer, float4(pixelInfo.texCoords, 0, 0));
if(colorDepth <= pixelInfo.focusPlane || (BlurLength <= 0.0))
return;
const float rangeEnd = (pixelInfo.focusPlane+pixelInfo.focusRange);
float blendFactor = 1.0;
if (rangeEnd > colorDepth)
blendFactor = smoothstep(0, 1, 1-((rangeEnd-colorDepth) / pixelInfo.focusRange));
fragment.rgb = lerp(fragment.rgb, tex2Dlod(samplerBlurDestination, float4(pixelInfo.texCoords, 0, 0)).rgb, blendFactor);
#line 334
fragment.rgb += TriDither(fragment.rgb, pixelInfo.texCoords, 8);
#line 336
}
#line 338
void PS_DownSample(VSPIXELINFO pixelInfo, out float4 fragment : SV_Target0)
{
#line 341
const float2 sourceCoords = pixelInfo.texCoordsScaled.zw;
if(max(sourceCoords.x, sourceCoords.y) > 1.0001)
{
#line 345
discard;
}
fragment = tex2D(ReShade::BackBuffer, sourceCoords);
}
#line 356
technique DirectionalDepthBlur
< ui_tooltip = "Directional Depth Blur "
 "v1.2"
"\n===========================================\n\n"
"Directional Depth Blur is a shader for adding far plane directional blur\n"
"based on the depth of each pixel\n\n"
"Directional Depth Blur was written by Frans 'Otis_Inf' Bouma and is part of OtisFX\n"
"https://fransbouma.com | https://github.com/FransBouma/OtisFX"; >
{
pass Downsample { VertexShader = VS_PixelInfo ; PixelShader = PS_DownSample; RenderTarget = texDownsampledBackBuffer; }
pass BlurPass { VertexShader = VS_PixelInfo; PixelShader = PS_Blur; RenderTarget = texBlurDestination; }
pass Combiner { VertexShader = VS_PixelInfo; PixelShader = PS_Combiner; }
}
}

