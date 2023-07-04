#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ZigZag.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ZigZag.fx"
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
#line 8 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ZigZag.fx"
#line 12
uniform float radius <
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.5;
#line 18
uniform float angle <
ui_type = "slider";
ui_tooltip = "Adjusts the ripple angle. Positive and negative values affect the animation direction.";
ui_min = -999.0;
ui_max = 999.0;
ui_step = 1.0;
> = 180.0;
#line 26
uniform float period <
ui_type = "slider";
ui_min = 0.1;
ui_max = 10.0;
> = 0.25;
#line 32
uniform float amplitude <
ui_type = "slider";
ui_min = -10.0;
ui_max = 10.0;
> = 3.0;
#line 38
uniform float2 coordinates <
ui_type = "slider";
ui_label="Coordinates";
ui_tooltip="The X and Y position of the center of the effect.";
ui_min = 0.0;
ui_max = 1.0;
> = float2(0.25, 0.25);
#line 46
uniform bool use_mouse_point <
ui_label="Use Mouse Coordinates";
ui_tooltip="When enabled, uses the mouse's current coordinates instead of those defined by the Coordinates sliders";
> = false;
#line 51
uniform float aspect_ratio <
ui_type = "slider";
ui_label="Aspect Ratio";
ui_min = -100.0;
ui_max = 100.0;
> = 0;
#line 58
uniform float min_depth <
ui_type = "slider";
ui_label="Minimum Depth";
ui_min=0.0;
ui_max=1.0;
> = 0;
#line 65
uniform float tension <
ui_type = "slider";
ui_label = "Tension";
ui_min = 0;
ui_max = 10;
ui_step = 0.001;
> = 1.0;
#line 73
uniform float phase <
ui_type = "slider";
ui_min = -5.0;
ui_max = 5.0;
> = 0.0;
#line 79
uniform int animate <
ui_type = "combo";
ui_label = "Animate";
ui_items = "No\0Amplitude\0Phase\0";
ui_tooltip = "Enable or disable the animation. Animates the zigzag effect by phase or by amplitude.";
> = 0;
#line 86
uniform int render_type <
ui_type = "combo";
ui_label = "Render Type";
ui_items = "Normal\0Add\0Multiply\0Subtract\0Divide\0Darker\0Lighter\0";
ui_tooltip = "Applies different rendering modes to the output.";
> = 0;
#line 93
uniform float anim_rate <
source = "timer";
>;
#line 97
uniform float2 mouse_coordinates <
source= "mousepoint";
>;
#line 101
texture texColorBuffer : COLOR;
texture texDepthBuffer : DEPTH;
#line 104
sampler samplerColor
{
Texture = texColorBuffer;
#line 108
AddressU = WRAP;
AddressV = WRAP;
AddressW = WRAP;
#line 112
};
#line 114
float2x2 swirlTransform(float theta) {
const float c = cos(theta);
const float s = sin(theta);
#line 118
const float m1 = c;
const float m2 = -s;
const float m3 = s;
const float m4 = c;
#line 123
return float2x2(
m1, m2,
m3, m4
);
}
#line 130
void FullScreenVS(uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD0)
{
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
#line 137
if (id == 1)
texcoord.y  = 2.0;
else
texcoord.y = 0.0;
#line 142
position = float4( texcoord * float2(2, -2) + float2(-1, 1), 0, 1);
}
#line 146
float4 ZigZag(float4 pos : SV_Position, float2 texcoord : TEXCOORD0) : SV_TARGET
{
const float ar_raw = 1.0 * (float)721 / (float)1281;
const float depth = ReShade::GetLinearizedDepth(texcoord).r;
float4 color;
const float4 base = tex2D(samplerColor, texcoord);
float ar = lerp(ar_raw, 1, aspect_ratio * 0.01);
#line 154
float2 center = coordinates;
if (use_mouse_point)
center = float2(mouse_coordinates.x * (1.0 / 1281) / 2.0, mouse_coordinates.y * (1.0 / 721) / 2.0);
#line 158
float2 tc = texcoord - center;
#line 160
center.x /= ar;
tc.x /= ar;
#line 164
if (depth >= min_depth)
{
const float dist = distance(tc, center);
const float tension_radius = lerp(radius-dist, radius, tension);
const float percent = max(radius-dist, 0) / tension_radius;
#line 170
const float theta = percent * percent * (animate == 1 ? amplitude * sin(anim_rate * 0.0005) : amplitude) * sin(percent * percent / period * radians(angle) + (phase + (animate == 2 ? 0.00075 * anim_rate : 0)));
#line 172
const float s =  sin(theta);
const float c = cos(theta);
tc = mul(swirlTransform(theta), tc-center);
#line 176
tc += (2.0 * center);
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
if(length(color.rgb) < length(base.rgb))
color = base;
break;
}
#line 212
return float4(color.rgb + TriDither(color.rgb, texcoord, 8), color.a);
#line 216
}
#line 219
technique ZigZag
{
pass p0
{
VertexShader = FullScreenVS;
PixelShader = ZigZag;
}
};
