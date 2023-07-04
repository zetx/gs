#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Wave.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Wave.fx"
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
#line 8 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Wave.fx"
#line 11
uniform int wave_type <
ui_type = "combo";
ui_label = "Wave Type";
ui_items = "X/X\0X/Y\0";
ui_tooltip = "Which axis the distortion should be performed against.";
> = 1;
#line 18
uniform float angle <
#line 22
ui_type = "slider";
#line 24
ui_min = -360.0; ui_max = 360.0; ui_step = 1.0;
> = 0.0;
#line 27
uniform float period <
#line 31
ui_type = "slider";
#line 33
ui_min = 0.1; ui_max = 10.0;
ui_tooltip = "The wavelength of the distortion. Smaller values make for a longer wavelength.";
> = 3.0;
#line 37
uniform float amplitude <
#line 41
ui_type = "slider";
#line 43
ui_min = -1.0; ui_max = 1.0;
ui_tooltip = "The amplitude of the distortion in each direction.";
> = 0.075;
#line 47
uniform float phase <
#line 51
ui_type = "slider";
#line 53
ui_min = -5.0; ui_max = 5.0;
ui_tooltip = "The offset being applied to the distortion's waves.";
> = 0.0;
#line 57
uniform float min_depth <
#line 61
ui_type = "slider";
#line 63
ui_label="Minimum Depth";
ui_min=0.0;
ui_max=1.0;
> = 0;
#line 68
uniform int animate <
ui_type = "combo";
ui_label = "Animate";
ui_items = "No\0Amplitude\0Phase\0Angle\0";
ui_tooltip = "Enable or disable the animation. Animates the wave effect by phase, amplitude, or angle.";
> = 0;
#line 75
uniform float anim_rate <
source = "timer";
>;
#line 79
uniform int render_type <
ui_type = "combo";
ui_label = "Render Type";
ui_items = "Normal\0Add\0Multiply\0Subtract\0Divide\0Darker\0Lighter\0";
ui_tooltip = "Applies different rendering modes to the output.";
> = 0;
#line 86
texture texColorBuffer : COLOR;
#line 88
sampler samplerColor
{
Texture = texColorBuffer;
#line 92
AddressU = WRAP;
AddressV = WRAP;
AddressW = WRAP;
#line 96
MagFilter = LINEAR;
MinFilter = LINEAR;
MipFilter = LINEAR;
#line 100
MinLOD = 0.0f;
MaxLOD = 1000.0f;
#line 103
MipLODBias = 0.0f;
#line 105
SRGBTexture = false;
};
#line 109
void FullScreenVS(uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD0)
{
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
#line 116
if (id == 1)
texcoord.y  = 2.0;
else
texcoord.y = 0.0;
#line 121
position = float4( texcoord * float2(2, -2) + float2(-1, 1), 0, 1);
#line 123
}
#line 125
float4 Wave(float4 pos : SV_Position, float2 texcoord : TEXCOORD0) : SV_TARGET
{
#line 128
const float ar = 1.0 * (float)710 / (float)792;
const float2 center = float2(0.5 / ar, 0.5);
const float depth = ReShade::GetLinearizedDepth(texcoord).r;
float2 tc = texcoord;
const float4 base = tex2D(samplerColor, texcoord);
float4 color;
#line 135
tc.x /= ar;
#line 137
const float theta = radians(animate == 3 ? (anim_rate * 0.01 % 360.0) : angle);
const float s =  sin(theta);
const float _s = sin(-theta);
const float c =  cos(theta);
const float _c = cos(-theta);
#line 143
tc = float2(dot(tc - center, float2(c, -s)), dot(tc - center, float2(s, c)));
if(depth >= min_depth){
if(wave_type == 0)
{
switch(animate)
{
default:
tc.x += amplitude * sin((tc.x * period * 10) + phase);
break;
case 1:
tc.x += (sin(anim_rate * 0.001) * amplitude) * sin((tc.x * period * 10) + phase);
break;
case 2:
tc.x += amplitude * sin((tc.x * period * 10) + (anim_rate * 0.001));
break;
}
}
else
{
switch(animate)
{
default:
tc.x +=  amplitude * sin((tc.y * period * 10) + phase);
break;
case 1:
tc.x += (sin(anim_rate * 0.001) * amplitude) * sin((tc.y * period * 10) + phase);
break;
case 2:
tc.x += amplitude * sin((tc.y * period * 10) + (anim_rate * 0.001));
break;
}
}
tc = float2(dot(tc, float2(_c, -_s)), dot(tc, float2(_s, _c))) + center;
#line 177
tc.x *= ar;
#line 179
color = tex2D(samplerColor, tc);
}
else
{
color = tex2D(samplerColor, texcoord);
}
#line 186
if(depth >= min_depth)
switch(render_type)
{
case 1: 
color += base;
break;
case 2: 
color *= base;
break;
case 3: 
color -= base;
break;
case 4: 
color /= base;
break;
case 5: 
if(length(color.rgb) > length(base.rgb))
color = base;
break;
case 6: 
if(length(color.rgb) < length( base.rgb))
color = base;
break;
}
#line 212
return float4(color.rgb + TriDither(color.rgb, texcoord, 8), color.a);
#line 216
}
#line 218
technique Wave
{
pass p0
{
VertexShader = FullScreenVS;
PixelShader = Wave;
}
}
