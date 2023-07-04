#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Swirl.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Swirl.fx"
#line 11
uniform float radius <
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.5;
#line 17
uniform float angle <
ui_type = "slider";
ui_min = -1800.0;
ui_max = 1800.0;
ui_step = 1.0;
> = 180.0;
#line 24
uniform float tension <
ui_type = "slider";
ui_min = 0;
ui_max = 10;
ui_step = 0.001;
ui_tooltip="Determines how rapidly the swirl reaches the maximum angle.";
> = 1.0;
#line 32
uniform float2 coordinates <
ui_type = "slider";
ui_label="Coordinates";
ui_tooltip="The X and Y position of the center of the effect.";
ui_min = 0.0;
ui_max = 1.0;
> = float2(0.25, 0.25);
#line 40
uniform bool use_mouse_point <
ui_label="Use Mouse Coordinates";
ui_tooltip="When enabled, uses the mouse's current coordinates instead of those defined by the Coordinates sliders";
> = false;
#line 45
uniform float aspect_ratio <
ui_type = "slider";
ui_label="Aspect Ratio";
ui_min = -100.0;
ui_max = 100.0;
ui_tooltip = "Changes the distortion's aspect ratio in regards to the display aspect ratio.";
> = 0;
#line 53
uniform float min_depth <
ui_type = "slider";
ui_label="Minimum Depth";
ui_min=0.0;
ui_max=1.0;
ui_tooltip="The minimum depth to distort.\nAnything closer than the threshold will appear normally. (0 = Near, 1 = Far)";
> = 0;
#line 61
uniform int animate <
ui_type = "combo";
ui_label = "Animate";
ui_items = "No\0Yes\0";
ui_tooltip = "Animates the swirl, moving it clockwise and counterclockwise.";
> = 0;
#line 68
uniform int inverse <
ui_type = "combo";
ui_label = "Inverse Angle";
ui_items = "No\0Yes\0";
ui_tooltip = "Inverts the angle of the swirl, making the edges the most distorted.";
> = 0;
#line 75
uniform int render_type <
ui_type = "combo";
ui_label = "Render Type";
ui_items = "Normal\0Add\0Multiply\0Subtract\0Divide\0Darker\0Lighter\0";
ui_tooltip = "Additively render the effect.";
> = 0;
#line 82
uniform float anim_rate <
source = "timer";
>;
#line 86
uniform float2 mouse_coordinates <
source= "mousepoint";
>;
#line 90
texture texColorBuffer : COLOR;
#line 92
sampler samplerColor
{
Texture = texColorBuffer;
#line 96
AddressU = WRAP;
AddressV = WRAP;
AddressW = WRAP;
#line 100
Width = 3440;
Height = 1440;
Format = RGBA16;
};
#line 105
float2x2 swirlTransform(float theta) {
const float c = cos(theta);
const float s = sin(theta);
#line 109
const float m1 = c;
const float m2 = -s;
const float m3 = s;
const float m4 = c;
#line 114
return float2x2(
m1, m2,
m3, m4
);
}
#line 121
void FullScreenVS(uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD0)
{
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
#line 128
if (id == 1)
texcoord.y  = 2.0;
else
texcoord.y = 0.0;
#line 133
position = float4( texcoord * float2(2, -2) + float2(-1, 1), 0, 1);
}
#line 137
float4 Swirl(float4 pos : SV_Position, float2 texcoord : TEXCOORD0) : SV_TARGET
{
const float ar_raw = 1.0 * (float)1440 / (float)3440;
float ar = lerp(ar_raw, 1, aspect_ratio * 0.01);
const float4 base = tex2D(samplerColor, texcoord);
const float depth = ReShade::GetLinearizedDepth(texcoord).r;
float2 center = coordinates;
#line 145
if (use_mouse_point)
center = float2(mouse_coordinates.x * (1.0 / 3440) / 2.0, mouse_coordinates.y * (1.0 / 1440) / 2.0);
#line 148
float2 tc = texcoord - center;
float4 color;
#line 151
center.x /= ar;
tc.x /= ar;
#line 154
if (depth >= min_depth)
{
const float dist = distance(tc, center);
const float dist_radius = radius-dist;
const float tension_radius = lerp(radius-dist, radius, tension);
float percent = max(dist_radius, 0) / tension_radius;
if(inverse && dist < radius)
percent = 1 - percent;
const float theta = percent * percent * radians(angle * (animate == 1 ? sin(anim_rate * 0.0005) : 1.0));
#line 164
tc = mul(swirlTransform(theta), tc-center);
tc += (2 * center);
tc.x *= ar;
#line 168
color = tex2D(samplerColor, tc);
}
else
{
color = tex2D(samplerColor, texcoord);
}
#line 175
if(depth >= min_depth){
#line 177
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
}
#line 205
return color;
#line 207
}
#line 210
technique Swirl< ui_label="Swirl";>
{
pass p0
{
VertexShader = FullScreenVS;
PixelShader = Swirl;
}
};
