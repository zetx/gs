#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Chromakey.fx"
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
#line 10 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Chromakey.fx"
#line 16
uniform float Threshold <
ui_label = "Threshold";
ui_type = "slider";
ui_min = 0.0; ui_max = 0.999; ui_step = 0.001;
ui_category = "Distance adjustment";
> = 0.5;
#line 23
uniform bool RadialX <
ui_label = "Horizontally radial depth";
ui_category = "Radial distance";
ui_category_closed = true;
> = false;
uniform bool RadialY <
ui_label = "Vertically radial depth";
ui_category = "Radial distance";
> = false;
#line 33
uniform int FOV <
ui_label = "FOV (horizontal)";
ui_type = "slider";
ui_tooltip = "Field of view in degrees";
ui_step = .01;
ui_min = 0; ui_max = 200;
ui_category = "Radial distance";
> = 90;
#line 42
uniform int CKPass <
ui_label = "Keying type";
ui_type = "combo";
ui_items = "Background key\0Foreground key\0";
ui_category = "Direction adjustment";
> = 0;
#line 49
uniform bool Floor <
ui_label = "Mask floor";
ui_category = "Floor masking (experimental)";
ui_category_closed = true;
> = false;
#line 55
uniform float FloorAngle <
ui_label = "Floor angle";
ui_type = "slider";
ui_category = "Floor masking (experimental)";
ui_min = 0.0; ui_max = 1.0;
> = 1.0;
#line 62
uniform int Precision <
ui_label = "Floor precision";
ui_type = "slider";
ui_category = "Floor masking (experimental)";
ui_min = 2; ui_max = 9216;
> = 4;
#line 69
uniform int Color <
ui_label = "Keying color";
ui_tooltip = "Ultimatte(tm) Super Blue and Green are industry standard colors for chromakey";
ui_type = "combo";
ui_items = "Pure Green (RGB 0,255,0)\0Pure Red (RGB 255,0,255)\0Pure Blue (RGB 0,255,0)\0Super Blue Ultimatte(tm) (RGB 18,46,184)\0Green Ultimatte(tm) (RGB 74,214,92)\0Custom\0";
ui_category = "Color settings";
ui_category_closed = false;
> = 0;
#line 78
uniform float3 CustomColor <
ui_type = "color";
ui_label = "Custom color";
ui_category = "Color settings";
> = float3(0.0, 1.0, 0.0);
#line 84
uniform bool AntiAliased <
ui_label = "Anti-aliased mask";
ui_tooltip = "Disabling this option will reduce masking gaps";
ui_category = "Additional settings";
ui_category_closed = true;
> = false;
#line 91
uniform bool InvertDepth <
ui_label = "Invert Depth";
ui_tooltip = "Inverts the depth buffer so that the color is applied to the foreground instead.";
ui_category = "Additional settings";
> = false;
#line 102
float MaskAA(float2 texcoord)
{
#line 105
float Depth;
if (InvertDepth)
Depth = 1 - ReShade::GetLinearizedDepth(texcoord);
else
Depth = ReShade::GetLinearizedDepth(texcoord);
#line 112
float2 Size;
Size.x = tan(radians(FOV*0.5));
Size.y = Size.x /  (1799 * (1.0 / 995));
if(RadialX) Depth *= length(float2((texcoord.x-0.5)*Size.x, 1.0));
if(RadialY) Depth *= length(float2((texcoord.y-0.5)*Size.y, 1.0));
#line 119
if(!AntiAliased) return step(Threshold, Depth);
#line 122
float hPixel = fwidth(Depth)*0.5;
#line 124
return smoothstep(Threshold-hPixel, Threshold+hPixel, Depth);
}
#line 127
float3 GetPosition(float2 texcoord)
{
#line 130
const float theta = radians(FOV*0.5);
#line 132
float3 position = float3( texcoord*2.0-1.0, ReShade::GetLinearizedDepth(texcoord) );
#line 134
position.xy *= position.z;
#line 136
return position;
}
#line 140
float3 GetNormal(float2 texcoord)
{
const float3 offset = float3( float2((1.0 / 1799), (1.0 / 995)).xy, 0.0);
const float2 posCenter = texcoord.xy;
const float2 posNorth  = posCenter - offset.zy;
const float2 posEast   = posCenter + offset.xz;
#line 147
const float3 vertCenter = float3(posCenter - 0.5, 1.0) * ReShade::GetLinearizedDepth(posCenter);
const float3 vertNorth  = float3(posNorth - 0.5,  1.0) * ReShade::GetLinearizedDepth(posNorth);
const float3 vertEast   = float3(posEast - 0.5,   1.0) * ReShade::GetLinearizedDepth(posEast);
#line 151
return normalize(cross(vertCenter - vertNorth, vertCenter - vertEast)) * 0.5 + 0.5;
}
#line 158
float3 ChromakeyPS(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
#line 161
float3 Screen;
switch(Color)
{
case 0:{ Screen = float3(0.0, 1.0, 0.0); break; }    
case 1:{ Screen = float3(1.0, 0.0, 0.0); break; }    
case 2:{ Screen = float3(0.0, 0.0, 1.0); break; }    
case 3:{ Screen = float3(0.07, 0.18, 0.72); break; } 
case 4:{ Screen = float3(0.29, 0.84, 0.36); break; } 
case 5:{ Screen = CustomColor;              break; } 
}
#line 173
float DepthMask = MaskAA(texcoord);
#line 175
if (Floor)
{
#line 178
bool FloorMask = (float)round( GetNormal(texcoord).y*Precision )/Precision==(float)round( FloorAngle*Precision )/Precision;
#line 180
if (FloorMask)
DepthMask = 1.0;
}
#line 184
if(bool(CKPass)) DepthMask = 1.0-DepthMask;
#line 186
return lerp(tex2D(ReShade::BackBuffer, texcoord).rgb, Screen, DepthMask);
}
#line 194
technique Chromakey < ui_tooltip = "Generate green-screen wall based of depth"; >
{
pass
{
VertexShader = PostProcessVS;
PixelShader = ChromakeyPS;
}
}

