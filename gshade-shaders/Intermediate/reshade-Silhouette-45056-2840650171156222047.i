#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Silhouette.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1280 * (1.0 / 720); }
float2 GetPixelSize() { return float2((1.0 / 1280), (1.0 / 720)); }
float2 GetScreenSize() { return float2(1280, 720); }
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
#line 42 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Silhouette.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\TriDither.fxh"
#line 31
uniform float DitherTimer < source = "timer"; >;
#line 34
float rand21(float2 uv)
{
const float2 noise = frac(sin(dot(uv, float2(12.9898, 78.233) * 2.0)) * 43758.5453);
return (noise.x + noise.y) * 0.5;
}
#line 40
float rand11(float x)
{
return frac(x * 0.024390243);
}
#line 45
float permute(float x)
{
return ((34.0 * x + 1.0) * x) % 289.0;
}
#line 50
float3 TriDither(float3 color, float2 uv, int bits)
{
const float bitstep = exp2(bits) - 1.0;
#line 54
const float3 m = float3(uv, rand21(uv + (DitherTimer * 0.001))) + 1.0;
float h = permute(permute(permute(m.x) + m.y) + m.z);
#line 57
float3 noise1, noise2;
noise1.x = rand11(h);
h = permute(h);
#line 61
noise2.x = rand11(h);
h = permute(h);
#line 64
noise1.y = rand11(h);
h = permute(h);
#line 67
noise2.y = rand11(h);
h = permute(h);
#line 70
noise1.z = rand11(h);
h = permute(h);
#line 73
noise2.z = rand11(h);
#line 75
return lerp(noise1 - 0.5, noise1 - noise2, min(saturate( (((color.xyz) - (0.0)) / ((0.5 / bitstep) - (0.0)))), saturate( (((color.xyz) - (1.0)) / (((bitstep - 0.5) / bitstep) - (1.0)))))) * (1.0 / bitstep);
}
#line 45 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Silhouette.fx"
#line 58
uniform bool SEnable_Foreground_Color <
ui_label = "Enable Foreground Color";
ui_tooltip = "Enable this to use a color instead of a texture for the foreground!";
> = false;
#line 63
uniform float3 SForeground_Color <
ui_type = "color";
ui_label = "Foreground Color (If Enabled)";
ui_tooltip = "If you enabled foreground color, use this to select the color.";
ui_min = 0;
ui_max = 255;
> = float3(0, 0, 0);
#line 71
uniform float SForeground_Stage_Opacity <
ui_label = "Foreground Opacity";
ui_tooltip = "Set the transparency of the image.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.001;
> = 1.0;
#line 80
uniform int SForeground_Tex_Select <
ui_label = "Foreground Texture";
ui_tooltip = "The image to use in the foreground.";
ui_type = "combo";
ui_items = "Papyrus2.png\0Papyrus6.png\0Metal1.jpg\0Ice1.jpg\0Silhouette1.png\0Silhouette2.png\0";
ui_bind = "SilhouetteTexture_Source";
> = 0;
#line 91
uniform bool SEnable_Background_Color <
ui_label = "Enable Background Color";
ui_tooltip = "Enable this to use a color instead of a texture for the background!";
> = false;
#line 96
uniform float3 SBackground_Color <
ui_type = "color";
ui_label = "Background Color (If Enabled)";
ui_tooltip = "If you enabled background color, use this to select the color.";
ui_min = 0;
ui_max = 255;
> = float3(0, 0, 0);
#line 104
uniform float SBackground_Stage_Opacity <
ui_label = "Background Opacity";
ui_tooltip = "Set the transparency of the image.";
ui_type = "slider";
ui_min = 0.0;
ui_max = 1.0;
ui_step = 0.002;
> = 1.0;
#line 113
uniform float SBackground_Stage_depth <
ui_type = "slider";
ui_min = 0.001;
ui_max = 1.0;
ui_label = "Background Depth";
> = 0.500;
#line 120
uniform int SBackground_Tex_Select <
ui_label = "Background Texture";
ui_tooltip = "The image to use in the background.";
ui_type = "combo";
ui_items = "Papyrus2.png\0Papyrus6.png\0Metal1.jpg\0Ice1.jpg\0Silhouette1.png\0Silhouette2.png\0";
ui_bind = "SilhouetteTexture2_Source";
> = 1;
#line 159
texture Silhouette_Texture <source =   "Papyrus2.png" ;> { Width = 1280; Height = 720; Format= RGBA8; };
sampler Silhouette_Sampler { Texture = Silhouette_Texture; };
#line 162
texture Silhouette2_Texture < source =   "Papyrus6.png" ; > { Width = 1280; Height = 720; Format =  RGBA8; };
sampler Silhouette2_Sampler { Texture = Silhouette2_Texture; };
#line 165
void PS_SilhouetteForeground(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float3 color : SV_Target)
{
const float4 Silhouette_Stage = tex2D(Silhouette_Sampler, texcoord);
color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 170
if (SEnable_Foreground_Color == true)
{
color = lerp(color, SForeground_Color.rgb, SForeground_Stage_Opacity);
}
else
{
color = lerp(color, Silhouette_Stage.rgb, Silhouette_Stage.a * SForeground_Stage_Opacity);
#line 178
color += TriDither(color, texcoord, 8);
#line 180
}
}
#line 183
void PS_SilhouetteBackground(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float3 color : SV_Target)
{
const float4 Silhouette2_Stage = tex2D(Silhouette2_Sampler, texcoord);
const float depth = 1 - ReShade::GetLinearizedDepth(texcoord).r;
color = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 189
if ((SEnable_Background_Color == true) && (depth < SBackground_Stage_depth))
{
color = lerp(color, SBackground_Color.rgb, SBackground_Stage_Opacity);
}
else if (depth < SBackground_Stage_depth)
{
color = lerp(color, Silhouette2_Stage.rgb, Silhouette2_Stage.a * SBackground_Stage_Opacity);
#line 197
color += TriDither(color, texcoord, 8);
#line 199
}
}
#line 202
technique Silhouette
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_SilhouetteForeground;
}
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_SilhouetteBackground;
}
}
