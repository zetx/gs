#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Depth_Cues.fx"
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
#line 21 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Depth_Cues.fx"
#line 39
uniform int Depth_Map <
ui_type = "combo";
ui_items = "Normal\0Reverse\0";
ui_label = "Custom Depth Map";
ui_tooltip = "Pick your Depth Map.";
ui_category = "Depth Buffer";
> = 0;
#line 47
uniform float Depth_Map_Adjust <
ui_type = "slider";
ui_min = 1.0; ui_max = 1000.0; ui_step = 0.125;
ui_label = "Depth Map Adjustment";
ui_tooltip = "Adjust the depth map and sharpness distance.";
ui_category = "Depth Buffer";
> = 250.0;
#line 55
uniform bool Depth_Map_Flip <
ui_label = "Depth Map Flip";
ui_tooltip = "Flip the depth map if it is upside down.";
ui_category = "Depth Buffer";
> = false;
#line 61
uniform bool DEPTH_DEBUG <
ui_label = "View Depth";
ui_tooltip = "Shows depth, you want close objects to be black and far objects to be white for things to work properly.";
ui_category = "Depth Buffer";
> = false;
#line 67
uniform bool No_Depth_Map <
ui_label = "No Depth Map";
ui_tooltip = "If you have No Depth Buffer turn this On.";
ui_category = "Depth Buffer";
> = false;
#line 73
uniform float Shade_Power <
ui_type = "slider";
ui_min = 0.25; ui_max = 1.0;
ui_label = "Shade Power";
ui_tooltip = "Adjust the Shade Power This improves AO, Shadows, & Darker Areas in game.\n"
"Number 0.625 is default.";
ui_category = "Depth Cues";
> = 0.625;
#line 82
uniform float Blur_Cues <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Blur Shade";
ui_tooltip = "Adjust the to make Shade Softer in the Image.\n"
"Number 0.5 is default.";
ui_category = "Depth Cues";
> = 0.5;
#line 91
uniform float Spread <
ui_type = "slider";
ui_min = 1.0; ui_max = 25.0; ui_step = 0.25;
ui_label = "Shade Fill";
ui_tooltip = "Adjust This to have the shade effect to fill in areas gives fakeAO effect.\n"
"This is used for gap filling.\n"
"Number 7.5 is default.";
ui_category = "Depth Cues";
> = 12.5;
#line 101
uniform bool Debug_View <
ui_label = "Depth Cues Debug";
ui_tooltip = "Depth Cues Debug output the shadeded output.";
ui_category = "Depth Cues";
> = false;
#line 127
texture DepthBufferTex : DEPTH;
#line 129
sampler DepthBuffer
{
Texture = DepthBufferTex;
};
#line 134
texture BackBufferTex : COLOR;
#line 136
sampler BackBuffer
{
Texture = BackBufferTex;
};
#line 141
texture texHB { Width = 792  * 0.5 ; Height = 710 * 0.5 ; Format = R8; MipLevels = 1;};
#line 143
sampler SamplerHB
{
Texture = texHB;
};
#line 148
texture texDC { Width = 792; Height = 710; Format = R8; MipLevels = 3;};
#line 150
sampler SamplerDC
{
Texture = texDC;
};
#line 156
float Depth(in float2 texcoord : TEXCOORD0)
{
if (Depth_Map_Flip)
texcoord.y =  1 - texcoord.y;
#line 161
float zBuffer = tex2D(DepthBuffer, texcoord).x; 
#line 165
const float Far = 1.0, Near = 0.125/Depth_Map_Adjust; 
#line 167
const float2 Z = float2( zBuffer, 1-zBuffer );
#line 169
if (Depth_Map == 0)
zBuffer = Far * Near / (Far + Z.x * (Near - Far));
else if (Depth_Map == 1)
zBuffer = Far * Near / (Far + Z.y * (Near - Far));
#line 174
return saturate(zBuffer);
}
#line 177
float3 BB(in float2 texcoord, float2 AD)
{
#line 184
return tex2Dlod(BackBuffer, float4(texcoord + AD,0,0)).rgb;
}
#line 187
float H_Blur(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float S =  Spread *  0.5 * 0.125;
#line 191
float3 sum = BB(texcoord,0).rgb *  12 ;
#line 193
float total =  12 ;
#line 195
for ( int j = - 12 ; j <=  12 ; ++j)
{
float W =  12 ;
#line 199
sum += BB(texcoord , + float2( float2((1.0 / 792), (1.0 / 710)).x * S,0) * j ) * W;
#line 201
total += W;
}
return dot(sum / total, float3(0.2126, 0.7152, 0.0722) ); 
}
#line 207
float DepthCues(float2 texcoord)
{
float2 S =  Spread *  0.5 * 0.75f *  float2((1.0 / 792), (1.0 / 710));
#line 211
const float M_Cues = 1;
float result = tex2Dlod(SamplerHB,float4(texcoord,0,M_Cues)).x;
result += tex2Dlod(SamplerHB,float4(texcoord + float2( 1, 0) * S ,0,M_Cues)).x;
result += tex2Dlod(SamplerHB,float4(texcoord + float2( 0, 1) * S ,0,M_Cues)).x;
result += tex2Dlod(SamplerHB,float4(texcoord + float2(-1, 0) * S ,0,M_Cues)).x;
result += tex2Dlod(SamplerHB,float4(texcoord + float2( 0,-1) * S ,0,M_Cues)).x;
S *= 0.5;
result += tex2Dlod(SamplerHB,float4(texcoord + float2( 1, 0) * S ,0,M_Cues)).x;
result += tex2Dlod(SamplerHB,float4(texcoord + float2( 0, 1) * S ,0,M_Cues)).x;
result += tex2Dlod(SamplerHB,float4(texcoord + float2(-1, 0) * S ,0,M_Cues)).x;
result += tex2Dlod(SamplerHB,float4(texcoord + float2( 0,-1) * S ,0,M_Cues)).x;
result *= rcp(9);
#line 225
const float DC = (dot(BB(texcoord,0),float3(0.2126, 0.7152, 0.0722)) / result );
return lerp(1.0f,saturate(DC),Shade_Power);
}
#line 229
float DC(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
return DepthCues(texcoord); 
}
#line 234
float3 Out(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float DCB = tex2Dlod(SamplerDC,float4(texcoord,0, Blur_Cues *  0.5)).x;
const float3 DC = DCB.xxx , BBN = tex2D(BackBuffer,texcoord).rgb;
float DB = Depth(texcoord).r;
#line 240
if(No_Depth_Map)
{
DB = 0.0;
}
#line 245
if (Debug_View)
return lerp(DC,1., DB);
#line 248
if (DEPTH_DEBUG)
return DB;
#line 252
const float3 outcolor = BBN * lerp(DC,1., DB);
return outcolor + TriDither(outcolor, texcoord, 8);
#line 257
}
#line 262
void PostProcessVS(in uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD)
{
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
#line 269
if (id == 1)
texcoord.y = 2.0;
else
texcoord.y = 0.0;
#line 274
position = float4(texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 278
technique Monocular_Cues
{
#line 281
pass Blur
{
VertexShader = PostProcessVS;
PixelShader = H_Blur;
RenderTarget = texHB;
}
pass BlurDC
{
VertexShader = PostProcessVS;
PixelShader = DC;
RenderTarget = texDC;
}
pass UnsharpMask
{
VertexShader = PostProcessVS;
PixelShader = Out;
}
}
