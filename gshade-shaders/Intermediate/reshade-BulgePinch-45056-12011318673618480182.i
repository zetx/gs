#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BulgePinch.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BulgePinch.fx"
#line 7
uniform float radius <
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.5;
#line 13
uniform float magnitude <
ui_type = "slider";
ui_min = -1.0;
ui_max = 1.0;
> = -0.5;
#line 19
uniform float tension <
ui_type = "slider";
ui_min = 0.;
ui_max = 10.;
ui_step = 0.001;
> = 1.0;
#line 26
uniform float2 coordinates <
ui_type = "slider";
ui_label="Coordinates";
ui_tooltip="The X and Y position of the center of the effect.";
ui_min = 0.0; ui_max = 1.0;
> = 0.25;
#line 33
uniform bool use_mouse_point <
ui_label="Use Mouse Coordinates";
ui_tooltip="When enabled, uses the mouse's current coordinates instead of those defined by the Coordinates sliders";
> = false;
#line 38
uniform float min_depth <
ui_type = "slider";
ui_label="Minimum Depth";
ui_min=0.0;
ui_max=1.0;
> = 0;
#line 45
uniform float aspect_ratio <
ui_type = "slider";
ui_label="Aspect Ratio";
ui_min = -100.0;
ui_max = 100.0;
> = 0;
#line 52
uniform int animate <
ui_type = "combo";
ui_label = "Animate";
ui_items = "No\0Yes\0";
ui_tooltip = "Animates the effect.";
> = 0;
#line 59
uniform int render_type <
ui_type = "combo";
ui_label = "Blending Mode";
ui_items = "Normal\0Add\0Multiply\0Subtract\0Divide\0Darker\0Lighter\0";
ui_tooltip = "Choose a blending mode.";
> = 0;
#line 66
uniform float anim_rate <
source = "timer";
>;
#line 70
uniform float2 mouse_coordinates <
source= "mousepoint";
>;
#line 74
texture texColorBuffer : COLOR;
#line 76
sampler samplerColor
{
Texture = texColorBuffer;
#line 80
AddressU = WRAP;
AddressV = WRAP;
AddressW = WRAP;
#line 84
MagFilter = LINEAR;
MinFilter = LINEAR;
MipFilter = LINEAR;
#line 88
MinLOD = 0.0f;
MaxLOD = 1000.0f;
#line 91
MipLODBias = 0.0f;
#line 93
SRGBTexture = false;
};
#line 97
void FullScreenVS(uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD0)
{
texcoord.x = (id == 2) ? 2.0 : 0.0;
texcoord.y = (id == 1) ? 2.0 : 0.0;
#line 102
position = float4( texcoord * float2(2, -2) + float2(-1, 1), 0, 1);
#line 105
}
#line 108
float4 PBDistort(float4 pos : SV_Position, float2 texcoord : TEXCOORD0) : SV_TARGET
{
const float ar_raw = 1.0 * (float)997 / (float)1798;
float ar = lerp(ar_raw, 1, aspect_ratio * 0.01);
#line 113
float2 center = coordinates;
if (use_mouse_point)
center = float2(mouse_coordinates.x * (1.0 / 1798) / 2.0, mouse_coordinates.y * (1.0 / 997) / 2.0);
#line 117
float2 tc = texcoord - center;
#line 119
float4 color;
const float4 base = tex2D(samplerColor, texcoord);
const float depth = ReShade::GetLinearizedDepth(texcoord).r;
#line 123
center.x /= ar;
tc.x /= ar;
#line 126
float dist = distance(tc, center);
if (dist < radius && depth >= min_depth)
{
float anim_mag = (animate == 1 ? magnitude * sin(radians(anim_rate * 0.05)) : magnitude);
float tension_radius = lerp(dist, radius, tension);
float percent = (dist)/tension_radius;
if(anim_mag > 0)
tc = (tc-center) * lerp(1.0, smoothstep(0.0, radius/dist, percent), anim_mag * 0.75);
else
tc = (tc-center) * lerp(1.0, pow(abs(percent), 1.0 + anim_mag * 0.75) * radius/dist, 1.0 - percent);
#line 137
tc += (2*center);
tc.x *= ar;
#line 140
color = tex2D(samplerColor, tc);
}
else {
color = tex2D(samplerColor, texcoord);
}
#line 146
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
#line 171
return color;
}
#line 175
technique BulgePinch < ui_label="Bulge/Pinch";>
{
pass p0
{
VertexShader = FullScreenVS;
PixelShader = PBDistort;
}
};
