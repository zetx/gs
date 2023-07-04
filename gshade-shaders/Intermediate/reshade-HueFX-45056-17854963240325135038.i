#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HueFX.fx"
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
#line 7 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HueFX.fx"
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
#line 10 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\HueFX.fx"
#line 13
uniform float hueMid <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Hue Mid";
ui_tooltip = "Hue (rotation around the color wheel) of the color which you want to keep";
> = 0.6;
uniform float hueRange <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Hue Range";
ui_tooltip = "Range of different hue's around the hueMid that will also kept";
> = 0.1;
uniform float satLimit <
ui_type = "slider";
ui_min = 0.1; ui_max = 4.0;
ui_label = "Saturation Limit";
ui_tooltip = "Saturation control, better keep it higher than 0 for strong colors in contrast to the gray stuff around";
> = 2.9;
uniform float fxcolorMix <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Color Mix";
ui_tooltip = "Interpolation between the original and the effect, 0 means full original image, 1 means full grey-color image";
> = 2.9;
uniform bool fxuseColorSat <
ui_label = "Use Color Saturation";
ui_tooltip = "This will use original color saturation as an added limiter to the strength of the effect.";
> = 0;
#line 45
float smootherstep(float edge0, float edge1, float x)
{
x = clamp((x - edge0)/(edge1 - edge0), 0.0, 1.0);
return x*x*x*(x*(x*6 - 15) + 10);
}
#line 51
float3 Hue(in float3 RGB)
{
#line 54
const float Epsilon = 1e-10;
float4 P;
if (RGB.g < RGB.b)
P = float4(RGB.bg, -1.0, 2.0/3.0);
else
P = float4(RGB.gb, 0.0, -1.0/3.0);
#line 61
float4 Q;
if (RGB.r < P.x)
Q = float4(P.xyw, RGB.r);
else
Q = float4(RGB.r, P.yzx);
#line 67
const float C = Q.x - min(Q.w, Q.y);
const float H = abs((Q.w - Q.y) / (6 * C + Epsilon) + Q.z);
return float3(H, C, Q.x);
}
#line 72
float3 HUEFXPass(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 76
float3 fxcolor = saturate( color.xyz );
const float greyVal = dot( fxcolor.xyz,  	float3(0.212656, 0.715158, 0.072186).xyz );
const float3 HueSat = Hue( fxcolor.xyz );
const float colorHue = HueSat.x;
const float colorInt = HueSat.z - HueSat.y * 0.5;
float colorSat = HueSat.y / ( 1.0 - abs( colorInt * 2.0 - 1.0 ) * 1e-10 );
#line 84
if ( fxuseColorSat == 0 )   colorSat = 1.0f;
#line 86
const float hueMin_1 = hueMid - hueRange;
const float hueMax_1 = hueMid + hueRange;
float hueMin_2 = 0.0f;
float hueMax_2 = 0.0f;
#line 92
if ( hueMin_1 < 0.0 )
{
hueMin_2 = 1.0f + hueMin_1;
hueMax_2 = 1.0f + hueMid;
#line 97
if ( colorHue >= hueMin_1 && colorHue <= hueMid )
fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
else if ( colorHue >= hueMid && colorHue <= hueMax_1 )
fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
else if ( colorHue >= hueMin_2 && colorHue <= hueMax_2 )
fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_2, hueMax_2, colorHue ) * ( colorSat * satLimit ));
else
fxcolor.xyz = greyVal.xxx;
}
#line 107
else if ( hueMax_1 > 1.0 )
{
hueMin_2 = 0.0f - ( 1.0f - hueMid );
hueMax_2 = hueMax_1 - 1.0f;
#line 112
if ( colorHue >= hueMin_1 && colorHue <= hueMid )
fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
else if ( colorHue >= hueMid && colorHue <= hueMax_1 )
fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
else if ( colorHue >= hueMin_2 && colorHue <= hueMax_2 )
fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMin_2, hueMax_2, colorHue )) * ( colorSat * satLimit ));
else
fxcolor.xyz = greyVal.xxx;
}
#line 122
else
{
if ( colorHue >= hueMin_1 && colorHue <= hueMid )
fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
else if ( colorHue > hueMid && colorHue <= hueMax_1 )
fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
else
fxcolor.xyz = greyVal.xxx;
}
#line 133
const float3 outcolor = lerp( color.xyz, fxcolor.xyz, fxcolorMix );
return outcolor + TriDither(outcolor, texcoord, 8);
#line 138
}
#line 140
technique HueFX
{
pass
{
VertexShader = PostProcessVS;
PixelShader = HUEFXPass;
}
}

