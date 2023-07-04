#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CEOG.fx"
#line 10
uniform float ceog_ctr <
ui_type = "slider";
ui_min = -100.0; ui_max = 100.0;
ui_step = 0.01;
ui_tooltip = "Contrast";
ui_label = "Contrast";
> = 0.0;
uniform float ceog_e <
ui_type = "slider";
ui_min = -20.0; ui_max = 20.0;
ui_step = 0.01;
ui_tooltip = "Exposure";
ui_label = "Exposure";
> = 0.0;
uniform float ceog_o <
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_step = 0.005;
ui_tooltip = "Offset";
ui_label = "Offset";
> = 0.00;
uniform float ceog_g <
ui_type = "slider";
ui_min = 0.0; ui_max = 10.0;
ui_step = 0.01;
ui_tooltip = "Gamma";
ui_label = "Gamma";
> = 1.0;
uniform float Saturation <
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "Adjust saturation";
> = 0.0;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1798 * (1.0 / 997); }
float2 GetPixelSize() { return float2((1.0 / 1798), (1.0 / 997)); }
float2 GetScreenSize() { return float2(1798, 997); }
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
#line 44 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CEOG.fx"
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
#line 47 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\CEOG.fx"
#line 50
float3 CEOGPass(float4 position : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 54
const float mn=min(color.r, min(color.g, color.b));
const float mx=max(color.r, max(color.g, color.b));
#line 57
if(mn >=  0.00  && mx <=  1.00 )
{
float ctr=ceog_ctr;
const float3 color_tmp=color.rgb;
#line 62
if (ctr < 0.0)
ctr = max(ctr/100.0, -100.0);
else
ctr = min(ctr, 100.0);
color.rgb=(color.rgb-0.5)*max(ctr+1.0, 0.0)+0.5;
#line 68
color.rgb=pow(saturate(color.rgb*pow(2, ceog_e)+ceog_o), 1/ceog_g);
#line 70
const float3 diffcolor = color - dot(color, (1.0 / 3.0));
color = (color + diffcolor * Saturation) / (1 + (diffcolor * Saturation)); 
#line 73
if( 0.00  > 0 &&  1.00  < 1)
{
const float dlt=( 1.00 - 0.00 )*0.25;
if(mn <= ( 0.00 +dlt)) color.rgb=lerp(color_tmp, color.rgb, (mn- 0.00 )/dlt);
else if(mx >= ( 1.00 -dlt)) color.rgb=lerp(color_tmp, color.rgb, ( 1.00 -mx)/dlt);
}
}
#line 82
return color + TriDither(color, texcoord, 8);
#line 86
}
#line 89
technique CEOG
{
pass
{
VertexShader = PostProcessVS;
PixelShader = CEOGPass;
}
}
