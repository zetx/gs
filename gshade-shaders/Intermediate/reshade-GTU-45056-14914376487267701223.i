#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\GTU.fx"
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
#line 8 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\GTU.fx"
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
#line 11 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\GTU.fx"
#line 14
uniform float texture_sizeX <
ui_type = "slider";
ui_min = 1.0;
ui_max = 1799;
ui_label = "Screen Width (GTU)";
> = 320.0;
#line 21
uniform float texture_sizeY <
ui_type = "slider";
ui_min = 1.0;
ui_max = 998;
ui_label = "Screen Height (GTU)";
> = 240.0;
#line 28
uniform float video_sizeX <
ui_type = "slider";
ui_min = 1.0;
ui_max = 1799;
ui_label = "Frame Width (GTU)";
ui_tooltip = "This should be sized according to the video data in the texture (If you're using emulators, set this to the Emu video frame size, otherwise, keep it the same as Screen Width/Height or Fullscreen res.)";
> = 320.0;
#line 36
uniform float video_sizeY <
ui_type = "slider";
ui_min = 1.0;
ui_max = 998;
ui_label = "Frame Height (GTU)";
ui_tooltip = "This should be sized according to the video data in the texture (If you're using emulators, set this to the Emu video frame size, otherwise, keep it the same as Screen Width/Height or Fullscreen res.)";
> = 240.0;
#line 44
uniform bool compositeConnection <
ui_label = "Enables Composite Connection (GTU)";
> = 0;
#line 48
uniform bool noScanlines <
ui_label = "Disables Scanlines (GTU)";
> = 0;
#line 52
uniform float signalResolution <
ui_type = "slider";
ui_min = 16.0; ui_max = 1024.0;
ui_tooltip = "Signal Resolution Y (GTU)";
ui_step = 16.0;
> = 256.0;
#line 59
uniform float signalResolutionI <
ui_type = "slider";
ui_min = 1.0; ui_max = 350.0;
ui_tooltip = "Signal Resolution I (GTU)";
ui_step = 2.0;
> = 83.0;
#line 66
uniform float signalResolutionQ <
ui_type = "slider";
ui_min = 1.0; ui_max = 350.0;
ui_tooltip = "Signal Resolution Q (GTU)";
ui_step = 2.0;
> = 25.0;
#line 73
uniform float tvVerticalResolution <
ui_type = "slider";
ui_min = 20.0; ui_max = 1000.0;
ui_tooltip = "TV Vertical Resolution (GTU)";
ui_step = 10.0;
> = 250.0;
#line 80
uniform float blackLevel <
ui_type = "slider";
ui_min = -0.30; ui_max = 0.30;
ui_tooltip = "Black Level (GTU)";
ui_step = 0.01;
> = 0.07;
#line 87
uniform float contrast <
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
ui_tooltip = "Constrast (GTU)";
ui_step = 0.1;
> = 1.0;
#line 94
texture target0_gtu
{
Width = 1799;
Height = 998;
Format = RGBA32F;
};
sampler s0 { Texture = target0_gtu; };
#line 112
float normalGaussIntegral(float x)
{
const float t = 1.0 / (1.0 + 0.3326700 * abs(x));
return (0.5 - ((exp(-(x) * (x) * 0.5)) / sqrt(2.0 *         3.14159265358)) * (t * (0.4361836 + t * (-0.1201676 + 0.9372980 * t)))) * sign(x);
}
#line 118
float3 scanlines( float x , float3 c)
{
const float temp = sqrt(2 *         3.14159265358) * (tvVerticalResolution / texture_sizeY);
#line 122
const float rrr = 0.5 * (texture_sizeY / ReShade:: GetScreenSize().y);
const float x1 = (x + rrr) * temp;
const float x2 = (x - rrr) * temp;
c.r = (c.r * (normalGaussIntegral(x1) - normalGaussIntegral(x2)));
c.g = (c.g * (normalGaussIntegral(x1) - normalGaussIntegral(x2)));
c.b = (c.b * (normalGaussIntegral(x1) - normalGaussIntegral(x2)));
c *= (ReShade:: GetScreenSize().y / texture_sizeY);
return c;
}
#line 132
float4 PS_GTU1(float4 vpos : SV_Position, float2 tex : TexCoord) : SV_Target
{
float4 c = tex2D(ReShade::BackBuffer, tex);
if(compositeConnection)
{
c.rgb = mul(transpose(float3x3( 0.299 , 0.595716 , 0.211456 , 0.587 , -0.274453 , -0.522591 , 0.114 , -0.321263 , 0.311135 )), c.rgb);
}
return c;
}
#line 142
float4 PS_GTU2(float4 vpos : SV_Position, float2 tex : TexCoord) : SV_Target
{
const float offset   = frac((tex.x *  float2(texture_sizeX, texture_sizeY).x) - 0.5);
float3 tempColor = float3(0.0,0.0,0.0);
float X;
float3 c;
float range;
if (compositeConnection)
{
range = ceil(0.5 +  float2(video_sizeX, video_sizeY).x / min(min(signalResolution,signalResolutionI),signalResolutionQ));
}
else
{
range = ceil(0.5 +  float2(video_sizeX, video_sizeY).x / signalResolution);
}
#line 158
float i;
if(compositeConnection)
{
for (i = -range; i < range + 2.0; i++)
{
X = (offset - i);
c = tex2Dlod(s0, float4(float2(tex.x - X /  float2(texture_sizeX, texture_sizeY).x, tex.y), 0.0, 0.0)).rgb;
tempColor += float3((c.x *  (( (        3.14159265358 * (signalResolution / float2(video_sizeX, video_sizeY).x) * min(abs(X) + 0.5, 1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x))) + sin( (        3.14159265358 * (signalResolution / float2(video_sizeX, video_sizeY).x) * min(abs(X) + 0.5, 1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x)))) -  (        3.14159265358 * (signalResolution / float2(video_sizeX, video_sizeY).x) * min(max(abs(X) - 0.5, -1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x)), 1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x))) - sin( (        3.14159265358 * (signalResolution / float2(video_sizeX, video_sizeY).x) * min(max(abs(X) - 0.5, -1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x)), 1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x))))) / (2.0 *         3.14159265358))), (c.y *  (( (        3.14159265358 * (signalResolutionI / float2(video_sizeX, video_sizeY).x) * min(abs(X) + 0.5, 1.0 / (signalResolutionI / float2(video_sizeX, video_sizeY).x))) + sin( (        3.14159265358 * (signalResolutionI / float2(video_sizeX, video_sizeY).x) * min(abs(X) + 0.5, 1.0 / (signalResolutionI / float2(video_sizeX, video_sizeY).x)))) -  (        3.14159265358 * (signalResolutionI / float2(video_sizeX, video_sizeY).x) * min(max(abs(X) - 0.5, -1.0 / (signalResolutionI / float2(video_sizeX, video_sizeY).x)), 1.0 / (signalResolutionI / float2(video_sizeX, video_sizeY).x))) - sin( (        3.14159265358 * (signalResolutionI / float2(video_sizeX, video_sizeY).x) * min(max(abs(X) - 0.5, -1.0 / (signalResolutionI / float2(video_sizeX, video_sizeY).x)), 1.0 / (signalResolutionI / float2(video_sizeX, video_sizeY).x))))) / (2.0 *         3.14159265358))), c.z *  (( (        3.14159265358 * (signalResolutionQ / float2(video_sizeX, video_sizeY).x) * min(abs(X) + 0.5, 1.0 / (signalResolutionQ / float2(video_sizeX, video_sizeY).x))) + sin( (        3.14159265358 * (signalResolutionQ / float2(video_sizeX, video_sizeY).x) * min(abs(X) + 0.5, 1.0 / (signalResolutionQ / float2(video_sizeX, video_sizeY).x)))) -  (        3.14159265358 * (signalResolutionQ / float2(video_sizeX, video_sizeY).x) * min(max(abs(X) - 0.5, -1.0 / (signalResolutionQ / float2(video_sizeX, video_sizeY).x)), 1.0 / (signalResolutionQ / float2(video_sizeX, video_sizeY).x))) - sin( (        3.14159265358 * (signalResolutionQ / float2(video_sizeX, video_sizeY).x) * min(max(abs(X) - 0.5, -1.0 / (signalResolutionQ / float2(video_sizeX, video_sizeY).x)), 1.0 / (signalResolutionQ / float2(video_sizeX, video_sizeY).x))))) / (2.0 *         3.14159265358)));
}
}
else
{
for (i = -range; i < range + 2.0; i++)
{
X = (offset - i);
c = tex2Dlod(s0, float4(float2(tex.x - X /  float2(texture_sizeX, texture_sizeY).x, tex.y), 0.0, 0.0)).rgb;
tempColor += c *  (( (        3.14159265358 * (signalResolution / float2(video_sizeX, video_sizeY).x) * min(abs(X) + 0.5, 1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x))) + sin( (        3.14159265358 * (signalResolution / float2(video_sizeX, video_sizeY).x) * min(abs(X) + 0.5, 1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x)))) -  (        3.14159265358 * (signalResolution / float2(video_sizeX, video_sizeY).x) * min(max(abs(X) - 0.5, -1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x)), 1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x))) - sin( (        3.14159265358 * (signalResolution / float2(video_sizeX, video_sizeY).x) * min(max(abs(X) - 0.5, -1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x)), 1.0 / (signalResolution / float2(video_sizeX, video_sizeY).x))))) / (2.0 *         3.14159265358));
}
}
if(compositeConnection)
{
tempColor = clamp(mul(transpose(float3x3(1.0 , 1.0  , 1.0 , 0.9563 , -0.2721 , -1.1070 , 0.6210 , -0.6474 , 1.7046)), tempColor), 0.0, 1.0);
}
else
{
tempColor = clamp(tempColor, 0.0, 1.0);
}
#line 187
return float4(tempColor + TriDither(tempColor, tex, 8), 1.0);
#line 191
}
#line 193
float4 PS_GTU3(float4 vpos : SV_Position, float2 tex : TexCoord) : SV_Target
{
const float2 offset = frac((tex.xy *  float2(texture_sizeX, texture_sizeY)) - 0.5);
float3 tempColor = float3(0.0, 0.0, 0.0);
#line 198
const float range = ceil(0.5 +  float2(video_sizeX, video_sizeY).y / tvVerticalResolution);
#line 200
float i;
#line 202
if (noScanlines)
{
for (i =- range; i < range + 2.0; i++)
{
tempColor += ((tex2Dlod(ReShade::BackBuffer, float4(float2(tex.x, tex.y - (offset.y - (i)) /  float2(texture_sizeX, texture_sizeY).y), 0.0, 0.0)).xyz) *  (( (        3.14159265358 * (tvVerticalResolution / float2(video_sizeX, video_sizeY).y) * min(abs((frac((tex.xy * float2(texture_sizeX, texture_sizeY)) - 0.5).y - (i))) + 0.5, 1.0 / (tvVerticalResolution / float2(video_sizeX, video_sizeY).y))) + sin( (        3.14159265358 * (tvVerticalResolution / float2(video_sizeX, video_sizeY).y) * min(abs((frac((tex.xy * float2(texture_sizeX, texture_sizeY)) - 0.5).y - (i))) + 0.5, 1.0 / (tvVerticalResolution / float2(video_sizeX, video_sizeY).y)))) -  (        3.14159265358 * (tvVerticalResolution / float2(video_sizeX, video_sizeY).y) * min(max(abs((frac((tex.xy * float2(texture_sizeX, texture_sizeY)) - 0.5).y - (i))) - 0.5, -1.0 / (tvVerticalResolution / float2(video_sizeX, video_sizeY).y)), 1.0 / (tvVerticalResolution / float2(video_sizeX, video_sizeY).y))) - sin( (        3.14159265358 * (tvVerticalResolution / float2(video_sizeX, video_sizeY).y) * min(max(abs((frac((tex.xy * float2(texture_sizeX, texture_sizeY)) - 0.5).y - (i))) - 0.5, -1.0 / (tvVerticalResolution / float2(video_sizeX, video_sizeY).y)), 1.0 / (tvVerticalResolution / float2(video_sizeX, video_sizeY).y))))) / (2.0 *         3.14159265358)));
}
}
else
{
for (i = -range; i < range + 2.0; i++)
{
tempColor += scanlines((offset.y - (i)), tex2Dlod(ReShade::BackBuffer, float4(float2(tex.x, tex.y - (offset.y - (i)) /  float2(texture_sizeX, texture_sizeY).y), 0.0, 0.0)).xyz);
}
}
#line 217
tempColor -= float3(blackLevel, blackLevel, blackLevel);
tempColor *= (contrast / float3(1.0 - blackLevel, 1.0 - blackLevel, 1.0 - blackLevel));
#line 220
return float4(tempColor + TriDither(tempColor, tex, 8), 1.0);
#line 224
}
#line 226
technique GTUV50 {
pass GTU1
{
RenderTarget = target0_gtu;
#line 231
VertexShader = PostProcessVS;
PixelShader = PS_GTU1;
}
#line 235
pass p2
{
VertexShader = PostProcessVS;
PixelShader = PS_GTU2;
}
#line 241
pass p3
{
VertexShader = PostProcessVS;
PixelShader = PS_GTU3;
}
}
