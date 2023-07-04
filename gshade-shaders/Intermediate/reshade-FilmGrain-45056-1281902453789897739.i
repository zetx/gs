#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmGrain.fx"
#line 8
uniform float Intensity <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "How visible the grain is. Higher is more visible.";
> = 0.50;
uniform float Variance <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Controls the variance of the Gaussian noise. Lower values look smoother.";
> = 0.40;
uniform float Mean <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Affects the brightness of the noise.";
> = 0.5;
#line 24
uniform int SignalToNoiseRatio <
ui_type = "slider";
ui_min = 0; ui_max = 16;
ui_label = "Signal-to-Noise Ratio";
ui_tooltip = "Higher Signal-to-Noise Ratio values give less grain to brighter pixels. 0 disables this feature.";
> = 6;
#line 31
uniform float Timer < source = "timer"; >;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1024 * (1.0 / 768); }
float2 GetPixelSize() { return float2((1.0 / 1024), (1.0 / 768)); }
float2 GetScreenSize() { return float2(1024, 768); }
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
#line 33 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\FilmGrain.fx"
#line 35
float3 FilmGrainPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 39
const float inv_luma = dot(color, float3(-1.0/3.0, -1.0/3.0, -1.0/3.0)) + 1.0; 
#line 45
const float PI = 3.1415927;
#line 48
const float t = Timer * 0.0022337;
#line 51
const float seed = dot(texcoord, float2(12.9898, 78.233));
const float sine = sin(seed);
const float cosine = cos(seed);
float uniform_noise1 = frac(sine * 43758.5453 + t); 
const float uniform_noise2 = frac(cosine * 53758.5453 - t); 
#line 58
float stn;
if (SignalToNoiseRatio != 0)
stn = pow(abs(inv_luma), (float)SignalToNoiseRatio);
else
stn = 1.0;
const float variance = (Variance*Variance) * stn;
const float mean = Mean;
#line 67
if (uniform_noise1 < 0.0001)
uniform_noise1 = 0.0001; 
#line 70
float r = sqrt(-log(uniform_noise1));
if (uniform_noise1 < 0.0001)
r = PI; 
const float theta = (2.0 * PI) * uniform_noise2;
#line 75
const float gauss_noise1 = variance * r * cos(theta) + mean;
#line 78
const float grain = lerp(1.0 + Intensity,  1.0 - Intensity, gauss_noise1);
#line 83
color = color * grain;
#line 96
return color.rgb;
}
#line 99
technique FilmGrain
{
pass
{
VertexShader = PostProcessVS;
PixelShader = FilmGrainPass;
}
}

