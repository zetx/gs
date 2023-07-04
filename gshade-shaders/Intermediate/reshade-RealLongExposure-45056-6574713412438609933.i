#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RealLongExposure.fx"
#line 13
uniform uint RealExposureDuration <
ui_type = "slider";
ui_min = 1; ui_max = 120;
ui_step = 1;
ui_tooltip = "Exposure Duration in seconds.";
> = 1;
uniform bool StartExposure <
ui_tooltip = "Click to start the Exposure Process. It will run for the given amount of seconds and then freeze. Tip: Bind this to a hotkey to use it conveniently.";
> = false;
uniform bool ShowGreenOnFinish <
ui_tooltip = "Display a green dot at the top to signalize the exposure has finished and entered preview mode.";
> = false;
uniform float ISO <
ui_type = "slider";
ui_min = 100; ui_max = 1600;
ui_step = 1;
ui_tooltip = "ISO. 100 is normalized to the game. 1600 is 16 times the sensitivity.";
> = 100;
uniform float Threshold <
ui_type = "slider";
ui_min = 0; ui_max = 1;
ui_step = 0.001;
ui_tooltip = "Disables ISO scaling for values below Threshold to avoid average game brightness to bleed into the long exposure. 0 means black, 1 is white (maximum luminosity).";
> = 0;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Reshade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 5360 * (1.0 / 1440); }
float2 GetPixelSize() { return float2((1.0 / 5360), (1.0 / 1440)); }
float2 GetScreenSize() { return float2(5360, 1440); }
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
#line 38 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\RealLongExposure.fx"
#line 40
uniform float timer < source = "timer"; > ;
#line 42
namespace RealisticLongExposure {
#line 48
texture texExposureReal{ Width = 5360; Height = 1440; Format = RGBA32F; };
texture texExposureRealCopy{ Width = 5360; Height = 1440; Format = RGBA32F; };
texture texTimer{ Width = 2; Height = 1; Format = R32F; };
texture texTimerCopy{ Width = 2; Height = 1; Format = R32F; };
sampler2D samplerExposure{ Texture = texExposureReal; };
sampler2D samplerExposureCopy{ Texture = texExposureRealCopy; };
sampler2D samplerTimer{ Texture = texTimer; };
sampler2D samplerTimerCopy{ Texture = texTimerCopy; };
#line 60
float encodeTimer(float value)
{
return value / 8388608; 
}
float decodeTimer(float value)
{
return value * 8388608; 
}
float4 show_green(float2 texcoord, float4 fragment)
{
if (sqrt((0.5 - texcoord.x) * (0.5 - texcoord.x) + (0.06 - texcoord.y) * (0.06 - texcoord.y)) < 0.02)
{
fragment = float4(0.5, 1, 0.5, 1);
}
return fragment;
#line 76
}
float4 getExposure(float4 rgbval, bool e)
{
float enc = 1.0;
if ((rgbval.r + rgbval.g + rgbval.b) / 3 > Threshold)
enc = ISO/100;
#line 83
if (e)
rgbval.rgb = enc * rgbval.rgb / 14400;
#line 86
return rgbval;
#line 88
}
void long_exposure(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 fragment : SV_Target)
{
#line 95
if (StartExposure) {
if (abs(timer - decodeTimer(tex2D(samplerTimer, float2(0.25, 0.5)).r)) < 1000 * RealExposureDuration)
{
fragment = tex2D(samplerExposureCopy, texcoord);
fragment.rgb += getExposure(tex2D(ReShade::BackBuffer, texcoord), true).rgb;
}
}
else
{
fragment = float4(0,0,0,1);
}
}
void copy_exposure(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 fragment : SV_Target)
{
fragment = tex2D(samplerExposure, texcoord);
}
#line 112
void update_timer(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float fragment : SV_Target)
{
#line 117
const float start_time = decodeTimer(tex2D(samplerTimerCopy, float2(0.25, 0.5)).r);
const float framecounter = decodeTimer(tex2D(samplerTimerCopy, float2(0.75, 0.5)).r);
float new_value = 0.0;
if (texcoord.x < 0.5)
{
if (StartExposure)
new_value = start_time;
else
new_value = timer;
}
else
{
if (abs(timer - start_time) < 1000 * RealExposureDuration && StartExposure)
{
new_value = framecounter + 1.0;
}
else if (StartExposure)
{
new_value = framecounter;
}
}
fragment = encodeTimer(new_value);
}
void copy_timer(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float fragment : SV_Target)
{
fragment = tex2D(samplerTimer, texcoord).r;
}
#line 145
void downsample_exposure(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 fragment : SV_Target)
{
const float framecounter = decodeTimer(tex2D(samplerTimer, float2(0.75, 0.5)).r);
float4 result = float4(0.0, 0.0, 0.0, 1.0);
if (StartExposure && framecounter)
{
result = getExposure(float4(tex2D(samplerExposure, texcoord).rgb * (14400 / framecounter), result.a), false);
}
else
{
result = tex2D(ReShade::BackBuffer, texcoord);
}
fragment = ((int)ShowGreenOnFinish*(int)StartExposure*(int)(timer - decodeTimer(tex2D(samplerTimer, float2(0.25, 0.5)).r) > 1000* RealExposureDuration)) ? show_green(texcoord, result) : result;
}
#line 160
technique RealLongExposure
{
pass longExposure { VertexShader = PostProcessVS; PixelShader = long_exposure; RenderTarget = texExposureReal; }
pass copyExposure { VertexShader = PostProcessVS; PixelShader = copy_exposure; RenderTarget = texExposureRealCopy; }
pass updateTimer { VertexShader = PostProcessVS; PixelShader = update_timer; RenderTarget = texTimer; }
pass copyTimer { VertexShader = PostProcessVS; PixelShader = copy_timer; RenderTarget = texTimerCopy; }
pass downsampleExposure { VertexShader = PostProcessVS; PixelShader = downsample_exposure; }
}
}

