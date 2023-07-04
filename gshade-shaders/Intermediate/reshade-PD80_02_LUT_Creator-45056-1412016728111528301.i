#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PD80_02_LUT_Creator.fx"
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
#line 51 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\PD80_02_LUT_Creator.fx"
#line 65
namespace pd80_lutoverlay
{
#line 72
texture texPicture < source =     "pd80_neutral-lut.png"; > { Width =    512.0; Height =   512.0; Format = RGBA8; };
#line 75
sampler samplerPicture {
Texture = texPicture;
AddressU = CLAMP;
AddressV = CLAMP;
AddressW = CLAMP;
};
#line 87
float4 PS_OverlayLUT(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
float2 coords   = float2( 792, 710 ) / float2(    512.0,   512.0 );
coords.xy      *= texcoord.xy;
float3 lut      = tex2D( samplerPicture, coords ).xyz;
float3 color    = tex2D( ReShade::BackBuffer, texcoord ).xyz;
float2 cutoff   = float2( (1.0 / 792), (1.0 / 710) ) * float2(    512.0,   512.0 );
color           = ( texcoord.y > cutoff.y || texcoord.x > cutoff.x ) ? color : lut;
#line 96
return float4( color.xyz, 1.0f );
}
#line 100
technique prod80_02_LUT_Creator
< ui_tooltip =  "This shader overlays the screen with a 512x512 high quality LUT.\n"
"One can run effects on this LUT using Reshade and export the results in a PNG\n"
"screenshot. You can take this screenshot into your favorite image editor and\n"
"make it into a 4096x64 LUT texture that can be read by Reshade's LUT shaders.\n"
"This way you can safe performance by using a texture to apply your favorite\n"
"effects instead of Reshade's color manipulation shaders.";>
{
pass prod80_pass0
{
VertexShader   = PostProcessVS;
PixelShader    = PS_OverlayLUT;
}
}
}

