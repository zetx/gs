#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\TinyPlanet.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\TinyPlanet.fx"
#line 13
uniform float center_x <
ui_type = "slider";
ui_min = 0.0;
ui_max = 360.0;
> = 0;
#line 19
uniform float center_y <
ui_type = "slider";
ui_min = 0.0;
ui_max = 360.0;
> =0;
#line 25
uniform float offset_x <
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0;
#line 31
uniform float offset_y <
ui_type = "slider";
ui_min = 0.0;
ui_max = .5;
> = 0;
#line 37
uniform float scale <
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
> = 10.0;
#line 43
uniform float z_rotation <
ui_type = "slider";
ui_min = 0.0;
ui_max = 360.0;
> = 0.5;
#line 49
uniform float seam_scale <
ui_type = "slider";
ui_min = 0.5;
ui_max = 1.0;
ui_label = "Seam Blending";
ui_tooltip = "Blends the ends of the screen so that the seam is somewhat reasonably hidden.";
> = 0.5;
#line 57
float3x3 getrot(float3 r)
{
const float cx = cos(radians(r.x));
const float sx = sin(radians(r.x));
const float cy = cos(radians(r.y));
const float sy = sin(radians(r.y));
const float cz = cos(radians(r.z));
const float sz = sin(radians(r.z));
#line 66
const float m1 = cy * cz;
const float m2= cx * sz + sx * sy * cz;
const float m3= sx * sz - cx * sy * cz;
const float m4= -cy * sz;
const float m5= cx * cz - sx * sy * sz;
const float m6= sx * cz + cx * sy * sz;
const float m7= sy;
const float m8= -sx * cy;
const float m9= cx * cy;
#line 76
return float3x3
(
m1,m2,m3,
m4,m5,m6,
m7,m8,m9
);
};
#line 84
texture texColorBuffer : COLOR;
#line 86
sampler samplerColor
{
Texture = texColorBuffer;
#line 90
AddressU = WRAP;
AddressV = WRAP;
AddressW = WRAP;
#line 94
MagFilter = LINEAR;
MinFilter = LINEAR;
MipFilter = LINEAR;
#line 98
MinLOD = 0.0f;
MaxLOD = 1000.0f;
#line 101
MipLODBias = 0.0f;
#line 103
SRGBTexture = false;
};
#line 107
void FullScreenVS(uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD0)
{
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
#line 114
if (id == 1)
texcoord.y  = 2.0;
else
texcoord.y = 0.0;
#line 119
position = float4( texcoord * float2(2, -2) + float2(-1, 1), 0, 1);
}
#line 123
float4 PreTP(float4 pos : SV_Position, float2 texcoord : TEXCOORD0) : SV_TARGET
{
const float inv_seam = 1 - seam_scale;
float4 tc1 =  tex2D(samplerColor, texcoord + float2(inv_seam, 0.0));
float4 tc = tex2D(samplerColor, texcoord * float2(seam_scale, 1.0));
#line 129
if(texcoord.x < inv_seam){
tc.rgb = lerp(tc1.rgb, tc.rgb, 1- clamp((inv_seam-texcoord.x) * 10., 0, 1));
}
if(texcoord.x > seam_scale) tc.rgb = lerp(tc.rgb, tc1.rgb, clamp((texcoord.x-seam_scale) * 10., 0, 1));
return tc;
}
#line 136
float4 TinyPlanet(float4 pos : SV_Position, float2 texcoord : TEXCOORD0) : SV_TARGET
{
const float ar = 1.0 * (float)1440 / (float)3440;
#line 140
const float3x3 rot = getrot(float3(center_x,center_y, z_rotation));
#line 142
const float2 rads = float2( 3.141592358 * 2.0 ,  3.141592358);
const float2 offset=float2(offset_x, offset_y);
const float2 pnt = (texcoord - 0.5 - offset).xy * float2(scale, scale*ar);
#line 147
const float x2y2 = pnt.x * pnt.x + pnt.y * pnt.y;
float3 sphere_pnt = float3(2.0 * pnt, x2y2 - 1.0) / (x2y2 + 1.0);
#line 150
sphere_pnt = mul(sphere_pnt, rot);
#line 153
const float r = length(sphere_pnt);
const float lon = atan2(sphere_pnt.y, sphere_pnt.x);
const float lat = acos(sphere_pnt.z / r);
#line 161
return tex2D(samplerColor, float2(lon, lat) / rads);
#line 163
}
#line 166
technique TinyPlanet<ui_label="Tiny Planet";>
{
pass p0
{
VertexShader = FullScreenVS;
PixelShader = PreTP;
}
pass p1
{
VertexShader = FullScreenVS;
PixelShader = TinyPlanet;
}
};
