#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DepthSharpenStaticDof.fx"
#line 20
uniform float sharp_strength <
ui_type = "slider";
ui_min = 0.1; ui_max = 10.0;
ui_tooltip = "Strength of the sharpening";
> = 3.0;
#line 26
uniform float sharp_clamp <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0; ui_step = 0.005;
ui_tooltip = "Limits maximum amount of sharpening a pixel receives";
> = 0.035;
#line 32
uniform int pattern <
ui_type = "combo";
ui_items = "Fast\0Normal\0Wider\0Pyramid shaped\0";
ui_tooltip = "Choose a sample pattern";
> = 2;
#line 38
uniform float offset_bias <
ui_type = "slider";
ui_min = 0.0; ui_max = 6.0;
ui_tooltip = "Offset bias adjusts the radius of the sampling pattern. I designed the pattern for offset_bias 1.0, but feel free to experiment.";
> = 1.0;
#line 44
uniform bool debug <
ui_tooltip = "Debug view.";
> = false;
#line 48
uniform float sharpenEndDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Max depth for sharpening";
> = 0.3;
#line 54
uniform float sharpenMaxDeltaDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Max depth difference between 2 samples to apply sharpen filter.";
> = 0.0025;
#line 60
uniform float dofStartDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Min depth for Depth of Field effect.";
> = 0.7;
#line 66
uniform float dofTransitionDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Distance of interpolation between no blur and full blur.";
> = 0.3;
#line 72
uniform float contourBlurMinDeltaDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_tooltip = "Min depth difference between 2 samples to apply blur filter";
> = 0.05;
#line 78
uniform float contourDepthExponent <
ui_type = "slider";
ui_min = 0.0; ui_max = 4.0;
ui_tooltip = "Influence of depth on coutour bluring (higher value will reduce blur on close object's contours)";
> = 2.0;
#line 86
uniform float maxDepth = 0.999;
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
#line 89 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DepthSharpenStaticDof.fx"
#line 106
float3 DepthSharpenconstDofPass(float4 position : SV_Position, float2 tex : TEXCOORD) : SV_Target
{
#line 109
const float3 ori = tex2D(ReShade::BackBuffer, tex).rgb;
#line 115
const float depth = ReShade::GetLinearizedDepth(tex).r;
#line 117
if( depth > maxDepth )
return ori;
#line 120
const float depthTL = ReShade::GetLinearizedDepth( tex + float2(- float2((1.0 / 3440), (1.0 / 1440)).x, - float2((1.0 / 3440), (1.0 / 1440)).y) ).r;
const float depthTR = ReShade::GetLinearizedDepth( tex + float2( float2((1.0 / 3440), (1.0 / 1440)).x, - float2((1.0 / 3440), (1.0 / 1440)).y) ).r;
const float deltaA = abs(depth-depthTL);
const float deltaB = abs(depth-depthTR);
float blurPercent = 0;
bool bluredEdge = false;
const bool shouldSharpen = depth < sharpenEndDepth && deltaA <= sharpenMaxDeltaDepth && deltaB <= sharpenMaxDeltaDepth;
#line 129
if( deltaA >= contourBlurMinDeltaDepth || deltaB >= contourBlurMinDeltaDepth )
{
blurPercent = saturate( (deltaA+deltaB)/2.0 * 10 ) * pow(abs(depth), contourDepthExponent);
bluredEdge = true;
}
else
blurPercent = (depth - dofStartDepth)/dofTransitionDepth;
#line 137
if( blurPercent <= 0 && !shouldSharpen )
if (debug)
return float3(0,1,0)*ori;
else
return ori;
#line 144
float3 sharp_strength_luma = ( float3(0.2126, 0.7152, 0.0722)       * sharp_strength); 
#line 150
float3 blur_ori;
#line 157
if (pattern == 0)
{
#line 164
blur_ori  = tex2D(ReShade::BackBuffer, tex + ( float2((1.0 / 3440), (1.0 / 1440)) / 3.0) * offset_bias).rgb;  
blur_ori += tex2D(ReShade::BackBuffer, tex + (- float2((1.0 / 3440), (1.0 / 1440)) / 3.0) * offset_bias).rgb; 
#line 167
blur_ori /= 2;  
#line 169
sharp_strength_luma *= 1.5; 
}
#line 173
if (pattern == 1)
{
#line 180
blur_ori  = tex2D(ReShade::BackBuffer, tex + float2( float2((1.0 / 3440), (1.0 / 1440)).x, - float2((1.0 / 3440), (1.0 / 1440)).y) * 0.5 * offset_bias).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex -  float2((1.0 / 3440), (1.0 / 1440)) * 0.5 * offset_bias).rgb;  
blur_ori += tex2D(ReShade::BackBuffer, tex +  float2((1.0 / 3440), (1.0 / 1440)) * 0.5 * offset_bias).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex - float2( float2((1.0 / 3440), (1.0 / 1440)).x, - float2((1.0 / 3440), (1.0 / 1440)).y) * 0.5 * offset_bias).rgb; 
#line 185
blur_ori *= 0.25;  
}
#line 189
if (pattern == 2)
{
#line 198
blur_ori  = tex2D(ReShade::BackBuffer, tex +  float2((1.0 / 3440), (1.0 / 1440)) * float2(0.4, -1.2) * offset_bias).rgb;  
blur_ori += tex2D(ReShade::BackBuffer, tex -  float2((1.0 / 3440), (1.0 / 1440)) * float2(1.2, 0.4) * offset_bias).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex +  float2((1.0 / 3440), (1.0 / 1440)) * float2(1.2, 0.4) * offset_bias).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex -  float2((1.0 / 3440), (1.0 / 1440)) * float2(0.4, -1.2) * offset_bias).rgb; 
#line 203
blur_ori *= 0.25;  
#line 205
sharp_strength_luma *= 0.51;
}
#line 209
if (pattern == 3)
{
#line 216
blur_ori  = tex2D(ReShade::BackBuffer, tex + float2(0.5 *  float2((1.0 / 3440), (1.0 / 1440)).x, - float2((1.0 / 3440), (1.0 / 1440)).y * offset_bias)).rgb;  
blur_ori += tex2D(ReShade::BackBuffer, tex + float2(offset_bias * - float2((1.0 / 3440), (1.0 / 1440)).x, 0.5 * - float2((1.0 / 3440), (1.0 / 1440)).y)).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex + float2(offset_bias *  float2((1.0 / 3440), (1.0 / 1440)).x, 0.5 *  float2((1.0 / 3440), (1.0 / 1440)).y)).rgb; 
blur_ori += tex2D(ReShade::BackBuffer, tex + float2(0.5 * - float2((1.0 / 3440), (1.0 / 1440)).x,  float2((1.0 / 3440), (1.0 / 1440)).y * offset_bias)).rgb; 
#line 221
blur_ori /= 4.0;  
#line 223
sharp_strength_luma *= 0.666; 
}
#line 231
if( blurPercent > 0 )
{
blurPercent = saturate(blurPercent);
if( debug )
if (bluredEdge)
return blurPercent * float3(0,0,1);
else
return blurPercent * float3(1,0,0);
#line 240
return blur_ori*blurPercent + ori*(1.0-blurPercent);
}
#line 244
if( sharpenEndDepth < 1.0 )
sharp_strength_luma *= 1.0 - depth/sharpenEndDepth; 
#line 252
const float3 sharp = ori - blur_ori;  
#line 255
const float4 sharp_strength_luma_clamp = float4(sharp_strength_luma * (0.5 / sharp_clamp),0.5); 
#line 257
float sharp_luma = saturate(dot(float4(sharp,1.0), sharp_strength_luma_clamp)); 
sharp_luma = (sharp_clamp * 2.0) * sharp_luma - sharp_clamp; 
#line 264
if (debug)
return saturate(0.5 + (sharp_luma * 4.0)).rrr;
#line 272
return ori + sharp_luma;    
#line 274
}
#line 276
technique DepthSharpenconstDof
{
pass
{
VertexShader = PostProcessVS;
PixelShader = DepthSharpenconstDofPass;
}
}

