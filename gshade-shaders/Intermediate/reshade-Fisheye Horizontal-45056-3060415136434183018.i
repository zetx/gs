#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Fisheye Horizontal.fx"
#line 9
uniform float fFisheyeZoom <
ui_type = "slider";
ui_min = 0.5; ui_max = 1.0;
ui_label = "Fish Eye Zoom";
ui_tooltip = "Lens zoom to hide bugged edges due to texcoord modification";
> = 0.55;
uniform float fFisheyeDistortion <
ui_type = "slider";
ui_min = -0.300; ui_max = 0.300;
ui_label = "Fisheye Distortion";
ui_tooltip = "Distortion of image";
> = 0.01;
uniform float fFisheyeDistortionCubic <
ui_type = "slider";
ui_min = -0.300; ui_max = 0.300;
ui_label = "Fisheye Distortion Cubic";
ui_tooltip = "Distortion of image, cube based";
> = 0.7;
uniform float fFisheyeColorshift <
ui_type = "slider";
ui_min = -0.10; ui_max = 0.10;
ui_label = "Colorshift";
ui_tooltip = "Amount of color shifting";
> = 0.002;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 792 * (1.0 / 710); }
float2 GetPixelSize() { return float2((1.0 / 792), (1.0 / 710)); }
float2 GetScreenSize() { return float2(792, 710); }
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
#line 34 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Fisheye Horizontal.fx"
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
#line 37 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Fisheye Horizontal.fx"
#line 40
float3 FISHEYE_CAPass(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 44
float4 coord=0.0;
coord.xy=texcoord.xy;
coord.w=0.0;
#line 48
color.rgb = 0.0;
#line 50
float3 eta = float3(1.0+fFisheyeColorshift*0.9,1.0+fFisheyeColorshift*0.6,1.0+fFisheyeColorshift*0.3);
float2 center;
center.x = coord.x-0.5;
center.y = coord.y-0.5;
float LensZoom = 1.0/fFisheyeZoom;
#line 56
float r2 = (texcoord.y-0.5) * (texcoord.y-0.5);
float f = 0;
#line 59
if( fFisheyeDistortionCubic == 0.0){
f = 1 + r2 * fFisheyeDistortion;
}else{
f = 1 + r2 * (fFisheyeDistortion + fFisheyeDistortionCubic * sqrt(r2));
};
#line 65
float x = f*LensZoom*(coord.x-0.5)+0.5;
float y = f*LensZoom*(coord.y-0.5)+0.5;
float2 rCoords = (f*eta.r)*LensZoom*(center.xy*0.5)+0.5;
float2 gCoords = (f*eta.g)*LensZoom*(center.xy*0.5)+0.5;
float2 bCoords = (f*eta.b)*LensZoom*(center.xy*0.5)+0.5;
#line 71
color.x = tex2D(ReShade::BackBuffer,rCoords).r;
color.y = tex2D(ReShade::BackBuffer,gCoords).g;
color.z = tex2D(ReShade::BackBuffer,bCoords).b;
#line 76
return color + TriDither(color, texcoord, 8);
#line 80
}
#line 83
technique FISHEYE_CA_HORIZONTAL
{
pass
{
VertexShader = PostProcessVS;
PixelShader = FISHEYE_CAPass;
}
}
