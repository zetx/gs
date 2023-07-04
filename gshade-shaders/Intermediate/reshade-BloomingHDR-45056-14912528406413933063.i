#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BloomingHDR.fx"
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
#line 26 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\BloomingHDR.fx"
#line 29
uniform float CBT_Adjust <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Extracting Bright Colors";
ui_tooltip = "Use this to set the color based brightness threshold for what is and what isn't allowed.\n"
"This is the most important setting, use Debug View to adjust this.\n"
"Number 0.5 is default.";
ui_category = "HDR Adjustments";
> = 0.5;
#line 39
uniform float HDR_Adjust <
ui_type = "slider";
ui_min = 0.5; ui_max = 2.0;
ui_label = "HDR Adjust";
ui_tooltip = "Use this to adjust HDR levels for your content.\n"
"Number 1.125 is default.";
ui_category = "HDR Adjustments";
> = 1.125;
#line 48
uniform bool Auto_Exposure <
ui_label = "Auto Exposure";
ui_tooltip = "This will enable the shader to adjust exposure automaticly.\n"
"You will still need to adjust exposure below.";
ui_category = "HDR Adjustments";
> = false;
#line 55
uniform float Exposure<
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "Exposure";
ui_tooltip = "Use this to set HDR exposure for your content.\n"
"Number 0.100 is default.";
ui_category = "HDR Adjustments";
> = 0.100;
#line 64
uniform float Saturation <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.5;
ui_label = "Bloom Saturation";
ui_tooltip = "Adjustment The amount to adjust the saturation of the color.\n"
"Number 1.0 is default.";
ui_category = "HDR Adjustments";
> = 1.0;
#line 73
uniform float Spread <
ui_type = "slider";
ui_min = 25.0; ui_max = 50.0; ui_step = 0.5;
ui_label = "Bloom Spread";
ui_tooltip = "Adjust This to have the Bloom effect to fill in areas.\n"
"This is used for Bloom gap filling.\n"
"Number 37.5 is default.";
ui_category = "HDR Adjustments";
> = 37.5;
#line 83
uniform int Luma_Coefficient <
ui_type = "combo";
ui_label = "Luma";
ui_tooltip = "Changes how color get used for the other effects.\n";
ui_items = "SD video\0HD video\0HDR video\0Intensity\0";
ui_category = "HDR Adjustments";
> = 0;
#line 91
uniform bool Debug_View <
ui_label = "Debug View";
ui_tooltip = "To view Shade & Blur effect on the game, movie piture & ect.";
ui_category = "Debugging";
> = false;
#line 100
texture DepthBufferTex : DEPTH;
#line 102
sampler DepthBuffer
{
Texture = DepthBufferTex;
};
#line 107
texture BackBufferTex : COLOR;
#line 109
sampler BackBuffer
{
Texture = BackBufferTex;
};
texture texBC { Width = 1281 * 0.5; Height = 721 * 0.5; Format = RGBA8; MipLevels = 4;};
#line 115
sampler SamplerBC
{
Texture = texBC;
MipLODBias = 2.0f;
MinFilter = LINEAR;
MagFilter = LINEAR;
MipFilter = LINEAR;
};
#line 124
texture texBlur { Width = 1281 * 0.5; Height = 721 * 0.5; Format = RGBA8; MipLevels = 3;};
#line 126
sampler SamplerBlur
{
Texture = texBlur;
MinFilter = LINEAR;
MagFilter = LINEAR;
MipFilter = LINEAR;
};
#line 134
texture PastSingle_BackBuffer { Width = 1281; Height = 721; Format = RGBA8;};
#line 136
sampler PSBackBuffer
{
Texture = PastSingle_BackBuffer;
};
#line 142
uniform uint framecount < source = "framecount"; >;
uniform float frametime < source = "frametime";>;
#line 148
float3 Luma()
{
float3 Luma;
#line 152
if (Luma_Coefficient == 0)
{
Luma = float3(0.299, 0.587, 0.114); 
}
else if (Luma_Coefficient == 1)
{
Luma = float3(0.2126, 0.7152, 0.0722); 
}
else if (Luma_Coefficient == 2)
{
Luma = float3(0.2627, 0.6780, 0.0593); 
}
else
{
Luma = float3(0.3333, 0.3333, 0.3333); 
}
return Luma;
}
#line 173
texture texLumAvg {Width = 256; Height = 256; Format = RGBA8; MipLevels = 9;}; 
#line 175
sampler SamplerLum
{
Texture = texLumAvg;
MipLODBias = 11; 
MinFilter = LINEAR;
MagFilter = LINEAR;
MipFilter = LINEAR;
AddressU = Clamp;
AddressV = Clamp;
};
#line 186
texture PStexLumAvg {Width = 1281; Height = 721; Format = RGBA8; };
#line 188
sampler SamplerPSLum
{
Texture = PStexLumAvg;
MinFilter = LINEAR;
MagFilter = LINEAR;
MipFilter = LINEAR;
AddressU = Clamp;
AddressV = Clamp;
};
#line 198
float Luminance(float4 pos : SV_Position, float2 texcoords : TEXCOORD) : SV_Target
{
float GSBB = dot(tex2D(BackBuffer,texcoords).rgb, Luma());
return GSBB;
}
#line 204
float Average_Luminance(float2 texcoords : TEXCOORD)
{
const float2 tex_offset = 50 *  float2((1.0 / 1281), (1.0 / 721)); 
const float L = tex2D(SamplerLum, texcoords).x, PL = tex2D(PSBackBuffer, texcoords).w;
#line 216
const float lum = L;
const float lumlast = PL;
#line 219
return lumlast + (lum - lumlast) * (1.0 - exp2(-frametime));
}
#line 224
float4 BrightColors(float4 position : SV_Position, float2 texcoords : TEXCOORD) : SV_Target 
{
float4 BC, Color = tex2D(BackBuffer, texcoords);
#line 228
const float brightness = dot(Color.rgb, Luma());
#line 230
if(brightness > CBT_Adjust)
BC.rgb = Color.rgb;
else
BC.rgb = float3(0.0, 0.0, 0.0);
#line 235
const float3 intensity = dot(BC.rgb,Luma());
BC.rgb = lerp(intensity,BC.rgb,Saturation);
#line 238
return float4(BC.rgb,1.0);
}
#line 241
float4 Blur(float4 position : SV_Position, float2 texcoords : TEXCOORD) : SV_Target
{
float2 tex_offset = (Spread * 0.5f) *  float2((1.0 / 1281), (1.0 / 721)); 
float4 result = tex2D(SamplerBC,texcoords); 
if ( framecount % 2 == 0)
{
result += tex2D(SamplerBC,texcoords + float2( 1, 0) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2(-1, 0) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2( 0, 1) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2( 0,-1) * tex_offset );
tex_offset *= 0.75;
result += tex2D(SamplerBC,texcoords + float2( 1, 1) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2(-1,-1) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2( 1,-1) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2(-1, 1) * tex_offset );
}
else
{
tex_offset *= 0.5;
result += tex2D(SamplerBC,texcoords + float2( 1, 0) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2(-1, 0) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2( 0, 1) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2( 0,-1) * tex_offset );
tex_offset *= 0.75;
result += tex2D(SamplerBC,texcoords + float2( 1, 1) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2(-1,-1) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2( 1,-1) * tex_offset );
result += tex2D(SamplerBC,texcoords + float2(-1, 1) * tex_offset );
}
#line 271
return result / 9;
}
#line 274
float3 LastBlur(float2 texcoord : TEXCOORD0)
{
float2 tex_offset = (Spread * 0.25f) *  float2((1.0 / 1281), (1.0 / 721)); 
float3 result =  tex2Dlod(SamplerBlur, float4(texcoord, 0, 2 )).rgb;
result += tex2Dlod(SamplerBlur, float4(texcoord + float2( 1, 0) * tex_offset, 0,  2 )).rgb;
result += tex2Dlod(SamplerBlur, float4(texcoord + float2(-1, 0) * tex_offset, 0,  2 )).rgb;
result += tex2Dlod(SamplerBlur, float4(texcoord + float2( 0, 1) * tex_offset, 0,  2 )).rgb;
result += tex2Dlod(SamplerBlur, float4(texcoord + float2( 0,-1) * tex_offset, 0,  2 )).rgb;
tex_offset *= 0.75;
result += tex2Dlod(SamplerBlur, float4(texcoord + float2( 1, 1) * tex_offset, 0,  2 )).rgb;
result += tex2Dlod(SamplerBlur, float4(texcoord + float2(-1,-1) * tex_offset, 0,  2 )).rgb;
result += tex2Dlod(SamplerBlur, float4(texcoord + float2( 1,-1) * tex_offset, 0,  2 )).rgb;
result += tex2Dlod(SamplerBlur, float4(texcoord + float2(-1, 1) * tex_offset, 0,  2 )).rgb;
return result / 9;
}
#line 290
void Past_BackSingleBuffer(float4 position : SV_Position, float2 texcoords : TEXCOORD, out float4 PastSingle : SV_Target)
{
PastSingle = float4(LastBlur(texcoords),Average_Luminance(texcoords).x);
}
#line 295
float4 Out(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
float AL = Average_Luminance(texcoord).x, Ex = Exposure;
#line 299
if(Auto_Exposure)
Ex = Ex * AL;
#line 302
float4 Out;
float3 TM, Color = tex2D(BackBuffer, texcoord).rgb, HDR = tex2D(BackBuffer, texcoord).rgb;
float3 bloomColor = LastBlur(texcoord) + tex2D(PSBackBuffer, texcoord).rgb; 
#line 306
TM = 1.0 - exp(-bloomColor * Ex );
#line 308
HDR += TM;
Color = pow(abs(HDR),HDR_Adjust);
#line 311
if (!Debug_View)
{
Out = float4(Color, 1.0);
}
else
{
Out = float4(bloomColor, 1.0);
}
#line 321
return float4(Out.rgb + TriDither(Out.rgb, texcoord, 8), Out.a);
#line 325
}
#line 330
void PostProcessVS(in uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD)
{
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
if (id == 1)
texcoord.y = 2.0;
else
texcoord.y = 0.0;
position = float4(texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 344
technique Blooming_HDR
{
pass Bright_Filter
{
VertexShader = PostProcessVS;
PixelShader = BrightColors;
RenderTarget = texBC;
}
pass Blur_Filter
{
VertexShader = PostProcessVS;
PixelShader = Blur;
RenderTarget = texBlur;
}
pass Avg_Lum
{
VertexShader = PostProcessVS;
PixelShader = Luminance;
RenderTarget = texLumAvg;
}
pass HDROut
{
VertexShader = PostProcessVS;
PixelShader = Out;
}
pass PSB
{
VertexShader = PostProcessVS;
PixelShader = Past_BackSingleBuffer;
RenderTarget = PastSingle_BackBuffer;
}
}

