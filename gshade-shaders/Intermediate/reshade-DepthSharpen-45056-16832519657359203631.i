#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DepthSharpen.fx"
#line 18
uniform float sharp_strength <
ui_type = "slider";
ui_min = 0.1; ui_max = 10.0;
ui_tooltip = "Strength of the sharpening";
> = 3.0;
#line 24
uniform float sharp_clamp <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0; ui_step = 0.005;
ui_tooltip = "Limits maximum amount of sharpening a pixel receives";
> = 0.035;
#line 30
uniform int pattern <
ui_type = "combo";
ui_items = "Fast\0Normal\0Wider\0Pyramid shaped\0";
ui_tooltip = "Choose a sample pattern";
> = 2;
#line 36
uniform float offset_bias <
ui_type = "slider";
ui_min = 0.0; ui_max = 6.0;
ui_tooltip = "Offset bias adjusts the radius of the sampling pattern. I designed the pattern for offset_bias 1.0, but feel free to experiment.";
> = 1.0;
#line 42
uniform bool debug <
ui_tooltip = "Debug view.";
> = false;
#line 46
uniform float sharpenEndDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Max depth for sharpening";
> = 0.3;
#line 52
uniform float sharpenMaxDeltaDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Max depth difference between 2 samples to apply sharpen filter.";
> = 0.0025;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1799 * (1.0 / 998); }
float2 GetPixelSize() { return float2((1.0 / 1799), (1.0 / 998)); }
float2 GetScreenSize() { return float2(1799, 998); }
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
#line 58 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DepthSharpen.fx"
#line 71
float3 DepthSharpenPass(float4 position : SV_Position, float2 tex : TEXCOORD) : SV_Target
{
#line 74
const float3 ori = tex2D(ReShade::BackBuffer, tex).rgb;
#line 80
const float depth = ReShade::GetLinearizedDepth(tex).r;
#line 83
float3 sharp_strength_luma = ( float3(0.2126, 0.7152, 0.0722)       * sharp_strength); 
#line 89
float3 blur_ori;
#line 96
if (pattern == 0)
{
#line 103
blur_ori  = tex2D(ReShade::BackBuffer, tex + ( float2((1.0 / 1799), (1.0 / 998)) / 3.0) * offset_bias).rgb;  
blur_ori += tex2D(ReShade::BackBuffer, tex + (- float2((1.0 / 1799), (1.0 / 998)) / 3.0) * offset_bias).rgb; 
#line 106
blur_ori /= 2;  
#line 108
sharp_strength_luma *= 1.5; 
}
#line 112
if (pattern == 1)
{
#line 119
blur_ori  = tex2D(ReShade::BackBuffer, tex + float2( float2((1.0 / 1799), (1.0 / 998)).x, - float2((1.0 / 1799), (1.0 / 998)).y) * 0.5 * offset_bias).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex -  float2((1.0 / 1799), (1.0 / 998)) * 0.5 * offset_bias).rgb;  
blur_ori += tex2D(ReShade::BackBuffer, tex +  float2((1.0 / 1799), (1.0 / 998)) * 0.5 * offset_bias).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex - float2( float2((1.0 / 1799), (1.0 / 998)).x, - float2((1.0 / 1799), (1.0 / 998)).y) * 0.5 * offset_bias).rgb; 
#line 124
blur_ori *= 0.25;  
}
#line 128
if (pattern == 2)
{
#line 137
blur_ori  = tex2D(ReShade::BackBuffer, tex +  float2((1.0 / 1799), (1.0 / 998)) * float2(0.4, -1.2) * offset_bias).rgb;  
blur_ori += tex2D(ReShade::BackBuffer, tex -  float2((1.0 / 1799), (1.0 / 998)) * float2(1.2, 0.4) * offset_bias).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex +  float2((1.0 / 1799), (1.0 / 998)) * float2(1.2, 0.4) * offset_bias).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex -  float2((1.0 / 1799), (1.0 / 998)) * float2(0.4, -1.2) * offset_bias).rgb; 
#line 142
blur_ori *= 0.25;  
#line 144
sharp_strength_luma *= 0.51;
}
#line 148
if (pattern == 3)
{
#line 155
blur_ori  = tex2D(ReShade::BackBuffer, tex + float2(0.5 *  float2((1.0 / 1799), (1.0 / 998)).x, - float2((1.0 / 1799), (1.0 / 998)).y * offset_bias)).rgb;  
blur_ori += tex2D(ReShade::BackBuffer, tex + float2(offset_bias * - float2((1.0 / 1799), (1.0 / 998)).x, 0.5 * - float2((1.0 / 1799), (1.0 / 998)).y)).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex + float2(offset_bias *  float2((1.0 / 1799), (1.0 / 998)).x, 0.5 *  float2((1.0 / 1799), (1.0 / 998)).y)).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex + float2(0.5 * - float2((1.0 / 1799), (1.0 / 998)).x,  float2((1.0 / 1799), (1.0 / 998)).y * offset_bias)).rgb; 
#line 160
blur_ori /= 4.0;  
#line 162
sharp_strength_luma *= 0.666; 
}
#line 170
if( sharpenEndDepth < 1.0 )
sharp_strength_luma *= 1.0 - depth/sharpenEndDepth; 
#line 178
const float3 sharp = ori - blur_ori;  
#line 181
const float4 sharp_strength_luma_clamp = float4(sharp_strength_luma * (0.5 / sharp_clamp),0.5); 
#line 183
float sharp_luma = saturate(dot(float4(sharp,1.0), sharp_strength_luma_clamp)); 
sharp_luma = (sharp_clamp * 2.0) * sharp_luma - sharp_clamp; 
#line 190
if (debug)
return saturate(0.5 + (sharp_luma * 4.0)).rrr;
#line 194
return ori + sharp_luma;    
}
#line 197
technique DepthSharpen
{
pass
{
VertexShader = PostProcessVS;
PixelShader = DepthSharpenPass;
}
}

