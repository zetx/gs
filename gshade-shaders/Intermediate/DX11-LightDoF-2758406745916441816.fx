#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LightDoF.fx"
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
#line 37 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\LightDoF.fx"
#line 45
uniform float fLightDoF_Width <
ui_label = "Bokeh Width [Light DoF]";
ui_type = "slider";
ui_min = 1.0;
ui_max = 25.0;
> = 5.0;
#line 52
uniform float fLightDoF_Amount <
ui_label = "DoF Amount [Light DoF]";
ui_type = "slider";
ui_min = 0.0;
ui_max = 10.0;
> = 10.0;
#line 59
uniform bool bLightDoF_UseCA <
ui_label = "Use Chromatic Aberration [Light DoF]";
ui_tooltip = "Use color channel shifting.";
> = false;
#line 64
uniform float2 f2LightDoF_CA <
ui_label = "Chromatic Aberration [Light DoF]";
ui_tooltip = "Shifts color channels.\nFirst value controls far CA, second controls near CA.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = float2(0.0, 1.0);
#line 72
uniform bool bLightDoF_AutoFocus <
ui_label = "Use Auto Focus [Light DoF]";
> = true;
#line 76
uniform float fLightDoF_AutoFocusSpeed <
ui_label = "Auto Focus Speed [Light DoF]";
ui_type = "slider";
ui_min = 0.001;
ui_max = 1.0;
> = 0.1;
#line 83
uniform bool bLightDoF_UseMouseFocus <
ui_label = "Use Mouse for Auto Focus Center [Light DoF]";
ui_tooltip = "Use the mouse position as the auto focus center";
> = false;
#line 88
uniform float2 f2Bokeh_AutoFocusCenter <
ui_label = "Auto Focus Center [Light DoF]";
ui_tooltip = "Target for auto focus.\nFirst value is horizontal: Left<->Right\nSecond value is vertical: Up<->Down";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = float2(0.5, 0.5);
#line 96
uniform float fLightDoF_ManualFocus <
ui_label = "Manual Focus [Light DoF]";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
> = 0.0;
#line 106
uniform float2 f2LightDoF_MouseCoord <source="mousepoint";>;
#line 118
texture tFocus { Format = R16F; };
#line 120
texture tLastFocus { Format = R16F; };
#line 125
sampler sFocus { Texture=tFocus; };
#line 127
sampler sLastFocus { Texture=tLastFocus; };
#line 132
float getFocus(float2 coord, bool farOrNear) {
float depth = ReShade::GetLinearizedDepth(coord);
#line 135
if (bLightDoF_AutoFocus)
depth -= tex2D(sFocus, 0).x;
else
depth -= fLightDoF_ManualFocus;
#line 140
if (farOrNear) {
depth = saturate(-depth * fLightDoF_Amount);
}
else {
depth = saturate(depth * fLightDoF_Amount);
}
#line 147
return depth;
}
#line 151
float2 rot2D(float2 pos, float angle) {
const float2 source = float2(sin(angle), cos(angle));
return float2(dot(pos, float2(source.y, -source.x)), dot(pos, source));
}
#line 157
float3 poisson(sampler sp, float2 uv, float farOrNear, float CA) {
float2 poisson[12];
poisson[0]  = float2(-.326,-.406);
poisson[1]  = float2(-.840,-.074);
poisson[2]  = float2(-.696, .457);
poisson[3]  = float2(-.203, .621);
poisson[4]  = float2( .962,-.195);
poisson[5]  = float2( .473,-.480);
poisson[6]  = float2( .519, .767);
poisson[7]  = float2( .185,-.893);
poisson[8]  = float2( .507, .064);
poisson[9]  = float2( .896, .412);
poisson[10] = float2(-.322,-.933);
poisson[11] = float2(-.792,-.598);
#line 172
float3 col = 0;
const float random = frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
const float4 basis = float4(rot2D(float2(1, 0), random), rot2D(float2(0, 1), random));
[loop]
for (int i = 0; i < 12; ++i) {
float2 offset = poisson[i];
offset = float2(dot(offset, basis.xz), dot(offset, basis.yw));
#line 180
if (bLightDoF_UseCA) {
float2 rCoord = uv + offset *  float2((1.0 / 3440), (1.0 / 1440)) * fLightDoF_Width * (1.0 + CA);
float2 gCoord = uv + offset *  float2((1.0 / 3440), (1.0 / 1440)) * fLightDoF_Width * (1.0 + CA * 0.5);
float2 bCoord = uv + offset *  float2((1.0 / 3440), (1.0 / 1440)) * fLightDoF_Width;
#line 185
rCoord = lerp(uv, rCoord, getFocus(rCoord, farOrNear));
gCoord = lerp(uv, gCoord, getFocus(gCoord, farOrNear));
bCoord = lerp(uv, bCoord, getFocus(bCoord, farOrNear));
#line 189
col += 	float3(
tex2Dlod(sp, float4(rCoord, 0, 0)).r,
tex2Dlod(sp, float4(gCoord, 0, 0)).g,
tex2Dlod(sp, float4(bCoord, 0, 0)).b
);
}
else {
float2 coord = uv + offset *  float2((1.0 / 3440), (1.0 / 1440)) * fLightDoF_Width;
coord = lerp(uv, coord, getFocus(coord, farOrNear));
col += tex2Dlod(sp, float4(coord, 0, 0)).rgb;
}
#line 201
}
return col * 0.083;
}
#line 208
float3 Far(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
#line 213
return poisson(ReShade::BackBuffer, uv, false, f2LightDoF_CA.x);
#line 215
}
#line 218
float3 Near(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
#line 223
return poisson(ReShade::BackBuffer, uv, true, f2LightDoF_CA.y);
#line 225
}
#line 228
float GetFocus(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
const float2 linearMouse = f2LightDoF_MouseCoord *  float2((1.0 / 3440), (1.0 / 1440)); 
float2 focus;
if (bLightDoF_UseMouseFocus)
focus = linearMouse;
else
focus = f2Bokeh_AutoFocusCenter;
return lerp(tex2D(sLastFocus, 0).x, ReShade::GetLinearizedDepth(focus), fLightDoF_AutoFocusSpeed);
}
#line 239
float SaveFocus(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target {
return tex2D(sFocus, 0).x;
}
#line 247
technique LightDoF_AutoFocus {
pass GetFocus {
VertexShader=PostProcessVS;
PixelShader=GetFocus;
RenderTarget=tFocus;
}
pass SaveFocus {
VertexShader=PostProcessVS;
PixelShader=SaveFocus;
RenderTarget=tLastFocus;
}
}
#line 261
technique LightDoF_Far {
pass Far {
VertexShader=PostProcessVS;
PixelShader=Far;
}
}
#line 269
technique LightDoF_Near {
pass Near {
VertexShader=PostProcessVS;
PixelShader=Near;
}
}

