#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DisplayMod.fx"
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
#line 37 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DisplayMod.fx"
#line 39
uniform float Display_Scale <
ui_type = "slider";
ui_label = "Scale X & Y";
ui_min = 0.001; ui_max = 5.0;
ui_step = 0.001;
> = 1.001;
#line 46
uniform float Display_ScaleX <
ui_type = "slider";
ui_label = "Scale X";
ui_min = 0.001; ui_max = 5.0;
ui_step = 0.001;
> = 1.0;
#line 53
uniform float Display_ScaleY <
ui_type = "slider";
ui_label = "Scale Y";
ui_min = 0.001; ui_max = 5.0;
ui_step = 0.001;
> = 1.0;
#line 60
uniform float Display_PosX <
ui_type = "slider";
ui_label = "Position X";
ui_min = -2.0; ui_max = 2.0;
ui_step = 0.001;
> = 0.5;
#line 67
uniform float Display_PosY <
ui_type = "slider";
ui_label = "Position Y";
ui_min = -2.0; ui_max = 2.0;
ui_step = 0.001;
> = 0.5;
#line 74
uniform int Display_SnapRotate <
ui_type = "combo";
ui_label = "Snap Rotation";
ui_items = "None\0"
"90 Degrees\0"
"-90 Degrees\0"
"180 Degrees\0"
"-180 Degrees\0";
ui_tooltip = "Snap rotation to a specific angle.";
> = false;
#line 85
uniform float Display_Rotate <
ui_label = "Rotate";
ui_type = "slider";
ui_min = -180.0;
ui_max = 180.0;
ui_step = 0.01;
> = 0;
#line 93
void PS_DisplayMod(in float4 position : SV_Position, in float2 texCoord : TEXCOORD, out float4 passColor : SV_Target)
{
const float3 pivot = float3(0.5, 0.5, 0.0);
const float AspectX = (1.0 - 792 * (1.0 / 710));
const float AspectY = (1.0 - 710 * (1.0 / 792));
const float3 mulUV = float3(texCoord.x, texCoord.y, 1);
const float2 ScaleSize = (float2(792, 710) * Display_Scale /  float2(792, 710));
const float ScaleX =  ScaleSize.x * AspectX * Display_ScaleX;
const float ScaleY =  ScaleSize.y * AspectY * Display_ScaleY;
float Rotate = Display_Rotate * (3.1415926 / 180.0);
#line 104
switch(Display_SnapRotate)
{
default:
break;
case 1:
Rotate = -90.0 * (3.1415926 / 180.0);
break;
case 2:
Rotate = 90.0 * (3.1415926 / 180.0);
break;
case 3:
Rotate = 0.0;
break;
case 4:
Rotate = 180.0 * (3.1415926 / 180.0);
break;
case 5:
Rotate = -180.0 * (3.1415926 / 180.0);
break;
}
#line 125
const float3x3 positionMatrix = float3x3 (
1, 0, 0,
0, 1, 0,
-Display_PosX, -Display_PosY, 1
);
const float3x3 scaleMatrix = float3x3 (
1/ScaleX, 0, 0,
0,  1/ScaleY, 0,
0, 0, 1
);
const float3x3 rotateMatrix = float3x3 (
(cos (Rotate) * AspectX), (sin(Rotate) * AspectX), 0,
(-sin(Rotate) * AspectY), (cos(Rotate) * AspectY), 0,
0, 0, 1
);
#line 141
const float3 SumUV = mul (mul (mul (mulUV, positionMatrix), rotateMatrix), scaleMatrix);
passColor = tex2D(ReShade::BackBuffer, SumUV.rg + pivot.rg) * all(SumUV + pivot == saturate(SumUV + pivot));
}
#line 145
technique DisplayMod
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_DisplayMod;
}
}
