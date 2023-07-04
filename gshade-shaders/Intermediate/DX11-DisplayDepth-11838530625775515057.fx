#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DisplayDepth.fx"
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
#line 9 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\DisplayDepth.fx"
#line 11
uniform int iUIPresentType <
ui_type = "combo";
ui_label = "Present type";
ui_items = "Depth map\0"
"Normal map\0"
"Show both (Vertical 50/50)\0";
> = 2;
#line 53
uniform int Depth_help <
ui_type = "radio"; ui_label = " ";
ui_text =
"\nThe right settings need to be set in the dialog that opens after clicking the \"Edit global preprocessor definitions\" button above.\n"
"\n"
 "RESHADE_DEPTH_INPUT_IS_UPSIDE_DOWN is currently set to 0.\n""If the Depth map is shown upside down set it to 1." "\n"
"\n"
 "RESHADE_DEPTH_INPUT_IS_REVERSED is currently set to 0.\n""If close objects in the Depth map are bright and far ones are dark set it to 1.\n""Also try this if you can see the normals, but the depth view is all black." "\n"
"\n"
 "RESHADE_DEPTH_INPUT_IS_LOGARITHMIC is currently set to 0.\n""If the Normal map has banding artifacts (extra stripes) set it to 1.";
>;
#line 95
uniform int Advanced_help <
ui_category = "Advanced settings";
ui_category_closed = true;
ui_type = "radio"; ui_label = " ";
ui_text =
"\nThe following settings also need to be set using \"Edit global preprocessor definitions\" above in order to take effect.\n"
"You can preview how they will affect the Depth map using the controls below.\n\n"
"It is rarely necessary to change these though, as their defaults fit almost all games.";
>;
#line 105
uniform bool bUIUseLivePreview <
ui_category = "Advanced settings";
ui_label = "Show live preview";
ui_tooltip = "Enable this to show use the preview settings below rather than the saved preprocessor settings.";
> = true;
#line 112
uniform float2 fUIScale <
ui_category = "Advanced settings";
ui_type = "drag";
ui_label = "Scale (Preview)";
ui_tooltip = "Best use 'Present type'->'Depth map' and enable 'Offset' in the options below to set the scale.\n"
"Use these values for:\nRESHADE_DEPTH_INPUT_X_SCALE=<left value>\nRESHADE_DEPTH_INPUT_Y_SCALE=<right value>\n"
"\n"
"If you know the right resolution of the games depth buffer then this scale value is simply the ratio\n"
"between the correct resolution and the resolution Reshade thinks it is.\n"
"For example:\n"
"If it thinks the resolution is 1920 x 1080, but it's really 1280 x 720 then the right scale is (1.5 , 1.5)\n"
"because 1920 / 1280 is 1.5 and 1080 / 720 is also 1.5, so 1.5 is the right scale for both the x and the y";
ui_min = 0.0; ui_max = 2.0;
ui_step = 0.001;
> = float2( 1,  1);
#line 128
uniform int2 iUIOffset <
ui_category = "Advanced settings";
ui_type = "drag";
ui_label = "Offset (Preview)";
ui_tooltip = "Best use 'Present type'->'Depth map' and enable 'Offset' in the options below to set the offset in pixels.\n"
"Use these values for:\nRESHADE_DEPTH_INPUT_X_PIXEL_OFFSET=<left value>\nRESHADE_DEPTH_INPUT_Y_PIXEL_OFFSET=<right value>";
ui_step = 1;
> = int2( 0,  0);
#line 137
uniform bool bUIShowOffset <
ui_category = "Advanced settings";
ui_label = "Blend Depth map into the image (to help with finding the right offset)";
> = false;
#line 142
uniform float fUIFarPlane <
ui_category = "Advanced settings";
ui_type = "drag";
ui_label = "Far Plane (Preview)";
ui_tooltip = "RESHADE_DEPTH_LINEARIZATION_FAR_PLANE=<value>\n"
"Changing this value is not necessary in most cases.";
ui_min = 0.0; ui_max = 1000.0;
ui_step = 0.1;
> = 1000.0;
#line 152
uniform float fUIDepthMultiplier <
ui_category = "Advanced settings";
ui_type = "drag";
ui_label = "Multiplier (Preview)";
ui_tooltip = "RESHADE_DEPTH_MULTIPLIER=<value>";
ui_min = 0.0; ui_max = 1000.0;
ui_step = 0.001;
> =  1;
#line 162
float GetLinearizedDepth(float2 texcoord)
{
if (!bUIUseLivePreview)
{
return ReShade::GetLinearizedDepth(texcoord);
}
else
{
if ( 0) 
texcoord.y = 1.0 - texcoord.y;
#line 173
texcoord.x /= fUIScale.x; 
texcoord.y /= fUIScale.y; 
texcoord.x -= iUIOffset.x * (1.0 / 3440); 
texcoord.y += iUIOffset.y * (1.0 / 1440); 
#line 178
float depth = tex2Dlod(ReShade::DepthBuffer, float4(texcoord, 0, 0)).x * fUIDepthMultiplier;
#line 180
const float C = 0.01;
if ( 0) 
depth = (exp(depth * log(C + 1.0)) - 1.0) / C;
#line 184
if ( 0) 
depth = 1.0 - depth;
#line 187
const float N = 1.0;
depth /= fUIFarPlane - depth * (fUIFarPlane - N);
#line 190
return depth;
}
}
#line 194
float3 GetScreenSpaceNormal(float2 texcoord)
{
float3 offset = float3( float2((1.0 / 3440), (1.0 / 1440)), 0.0);
float2 posCenter = texcoord.xy;
float2 posNorth  = posCenter - offset.zy;
float2 posEast   = posCenter + offset.xz;
#line 201
float3 vertCenter = float3(posCenter - 0.5, 1) * GetLinearizedDepth(posCenter);
float3 vertNorth  = float3(posNorth - 0.5,  1) * GetLinearizedDepth(posNorth);
float3 vertEast   = float3(posEast - 0.5,   1) * GetLinearizedDepth(posEast);
#line 205
return normalize(cross(vertCenter - vertNorth, vertCenter - vertEast)) * 0.5 + 0.5;
}
#line 208
void PS_DisplayDepth(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float3 color : SV_Target)
{
float3 depth = GetLinearizedDepth(texcoord).xxx;
float3 normal = GetScreenSpaceNormal(texcoord);
#line 215
const float dither_bit = 8.0; 
#line 217
float grid_position = frac(dot(texcoord, ( float2(3440, 1440) * float2(1.0 / 16.0, 10.0 / 36.0)) + 0.25));
#line 219
float dither_shift = 0.25 * (1.0 / (pow(2, dither_bit) - 1.0));
#line 221
float3 dither_shift_RGB = float3(dither_shift, -dither_shift, dither_shift); 
#line 223
dither_shift_RGB = lerp(2.0 * dither_shift_RGB, -2.0 * dither_shift_RGB, grid_position);
depth += dither_shift_RGB;
#line 227
color = depth;
if (iUIPresentType == 1)
color = normal;
if (iUIPresentType == 2)
color = lerp(normal, depth, step(3440 * 0.5, position.x));
#line 233
if (bUIShowOffset)
{
float3 color_orig = tex2D(ReShade::BackBuffer, texcoord).rgb;
#line 238
color = lerp(2 * color * color_orig, 1.0 - 2.0 * (1.0 - color) * (1.0 - color_orig), max(color.r, max(color.g, color.b)) < 0.5 ? 0.0 : 1.0);
}
}
#line 242
technique DisplayDepth <
ui_tooltip = "This shader helps you set the right preprocessor settings for depth input.\n"
"To set the settings click on 'Edit global preprocessor definitions' and set them there - not in this shader.\n"
"The settings will then take effect for all shaders, including this one.\n"
"\n"
"By default calculated normals and depth are shown side by side.\n"
"Normals (on the left) should look smooth and the ground should be greenish when looking at the horizon.\n"
"Depth (on the right) should show close objects as dark and use gradually brighter shades the further away objects are.\n";
>
#line 252
{
pass
{
VertexShader = PostProcessVS;
PixelShader = PS_DisplayDepth;
}
}

