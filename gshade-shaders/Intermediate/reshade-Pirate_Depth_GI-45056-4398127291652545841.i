#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pirate_Depth_GI.fx"
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
#line 21 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pirate_Depth_GI.fx"
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
#line 23 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pirate_Depth_GI.fx"
#line 27
uniform float GI_DIFFUSE_RADIUS <
ui_label = "GI - Radius";
ui_type = "slider";
ui_min = 0.0; ui_max = 200.0;
> = 1.0;
uniform float GI_DIFFUSE_STRENGTH <
ui_label = "GI - Diffuse - Strength";
ui_type = "slider";
ui_min = 0.0; ui_max = 30.0;
> = 4.0;
#line 38
uniform int GI_DIFFUSE_MIPLEVEL <
ui_label = "GI - Diffuse - Miplevel";
ui_type = "slider";
ui_min = 0; ui_max = 		11	;
> = 4;
#line 44
uniform int GI_DIFFUSE_CURVE_MODE <
ui_label = "GI - Diffuse - Curve Mode";
ui_type = "combo";
ui_items = "Linear\0Squared\0Log\0Sine\0Mid Range Sine\0";
> = 4;
uniform int GI_DIFFUSE_BLEND_MODE <
ui_label = "GI - Diffuse - Blend Mode";
ui_type = "combo";
ui_items = "Linear\0Screen\0Soft Light\0Color Dodge\0Hybrid\0";
> = 2;
uniform float GI_REFLECT_RADIUS <
ui_label = "GI - Reflection - Radius";
ui_type = "slider";
ui_min = 0.0; ui_max = 200.0;
> = 1.0;
uniform int GI_DIFFUSE_DEBUG <
ui_label = "GI - Debug";
ui_type = "combo";
ui_items = "None\0Color\0Gatherer\0";
> = 0;
uniform int GI_FOV <
ui_label = "FoV";
ui_type = "slider";
ui_min = 10; ui_max = 90;
> = 75;
#line 71
texture2D	TexGINormalDepth {Width = 1799 * 		1.0	; Height = 998 * 		1.0	; Format = RGBA16; MipLevels = 		11	;};
sampler2D	SamplerGIND {Texture = TexGINormalDepth; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
#line 74
texture2D	TexGI {Width = 1799 *  		1.0	; Height = 998 *  		1.0	; Format = RGBA8;};
sampler2D	SamplerGI {Texture = TexGI; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
#line 77
float GetRandom(float2 co)
{
#line 80
return frac(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}
#line 83
float2 GetRandomVector(float2 coords)
{
return normalize(float2(GetRandom(coords)*2-1, GetRandom(1.42 * coords)*2-1));
}
#line 88
float2 Rotate45(float2 coords) {
#line 90
float x = coords.x *  0.70710678118;
float y = coords.y *  0.70710678118;
return float2(x - y, x + y);
}
#line 95
float2 Rotate90(float2 coords)
{
return float2(-coords.y, coords.x);
}
#line 100
float3 EyeVector(float3 vec)
{
vec.xy = vec.xy * 2.0 - 1.0;
vec.x -= vec.x * (1.0 - vec.z) * sin(radians(GI_FOV));
vec.y -= vec.y * (1.0 - vec.z) * sin(radians(GI_FOV * (ReShade:: GetPixelSize().y / ReShade:: GetPixelSize().x)));
return vec;
}
#line 108
float3 BlendScreen(float3 a, float3 b)
{
return 1 - ((1 - a) * (1 - b));
}
#line 113
float3 BlendSoftLight(float3 a, float3 b)
{
return (1 - 2 * b) * pow(a, 2) + 2 * b * a;
}
#line 118
float3 BlendColorDodge(float3 a, float3 b)
{
return a / (1 - b);
}
#line 124
float4 PS_DepthPrePass(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
const float2 offsety = float2(0.0, ReShade:: GetPixelSize().y);
const float2 offsetx = float2(ReShade:: GetPixelSize().x, 0.0);
#line 129
float pointdepth = saturate(ReShade::GetLinearizedDepth(texcoord));
#line 140
const float3 p = EyeVector(float3(texcoord, pointdepth));
float3 py1 = EyeVector(float3(texcoord + offsety, saturate(ReShade::GetLinearizedDepth(texcoord + offsety)))) - p;
const float3 py2 = p - EyeVector(float3(texcoord - offsety, saturate(ReShade::GetLinearizedDepth(texcoord - offsety))));
float3 px1 = EyeVector(float3(texcoord + offsetx, saturate(ReShade::GetLinearizedDepth(texcoord + offsetx)))) - p;
const float3 px2 = p - EyeVector(float3(texcoord - offsetx, saturate(ReShade::GetLinearizedDepth(texcoord - offsetx))));
py1 = lerp(py1, py2, abs(py1.z) > abs(py2.z));
px1 = lerp(px1, px2, abs(px1.z) > abs(px2.z));
#line 149
return float4((normalize(cross(py1, px1)) + 1.0) * 0.5, pointdepth);
}
#line 152
float4 PS_GIDiffuse(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
float4 res;
float4 pointnd = tex2D(SamplerGIND, texcoord);
if (pointnd.w == 1.0) return 0.0;
pointnd.xyz = (pointnd.xyz * 2.0) - 1.0;
#line 159
const float3 pointvector = EyeVector(float3(texcoord, pointnd.w));
#line 166
float2 randomvector = GetRandomVector(texcoord * pointnd.w) * (0.5 + GetRandom(texcoord)/2);
#line 169
float2 psize = lerp(GI_DIFFUSE_RADIUS, 1.0, pow(abs(pointnd.w), 0.25)) * ReShade:: GetPixelSize();
psize /=  		1.0	;
#line 172
for(int p=1; p <= 		4	; p++)
{
float2 coordmult = psize * p;
#line 179
for(int i=0; i < 4; i++)
{
randomvector = Rotate90(randomvector);
float2 tapcoord = texcoord + randomvector * coordmult;
#line 186
float4 tapnd = tex2Dlod(SamplerGIND, float4(tapcoord, 0, GI_DIFFUSE_MIPLEVEL));
#line 188
tapnd.xyz = (tapnd.xyz * 2.0) - 1.0;
if (tapnd.w == 1.0) continue;
float3 tapvector = EyeVector(float3(tapcoord, tapnd.w));
#line 192
float3 pttvector = tapvector - pointvector;
#line 194
float weight = (1.0 - max(0.0, dot(pointnd.xyz, tapnd.xyz))); 
weight *= max(0.0, -dot(normalize(pttvector), tapnd.xyz)); 
weight *= saturate(coordmult.x - abs(pttvector.z)) / coordmult.x; 
float3 coltap = tex2Dlod(ReShade::BackBuffer, float4(tapcoord, 0, 0)).rgb;
res.rgb += coltap * weight;
res.w += weight;
}
randomvector = Rotate45(randomvector);
}
#line 204
res /= 4 * 		4	;
#line 206
return res;
}
#line 211
float4 PS_GICombine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
float4 diffuse = tex2D(SamplerGI, texcoord);
float4 res = tex2D(ReShade::BackBuffer, texcoord);
#line 218
if (GI_DIFFUSE_CURVE_MODE == 1) 
diffuse = pow(diffuse, 2);
else if (GI_DIFFUSE_CURVE_MODE == 2) 
diffuse = log10(diffuse * 10.0);
else if (GI_DIFFUSE_CURVE_MODE == 3) 
diffuse = (sin( 4.71238898038f + diffuse *  3.14159265358) + 1) / 2;
else if (GI_DIFFUSE_CURVE_MODE == 4) 
diffuse = sin(diffuse *  3.14159265358);
diffuse = saturate(diffuse * GI_DIFFUSE_STRENGTH);
#line 228
if (GI_DIFFUSE_BLEND_MODE == 0) 
res.rgb += diffuse.rgb;
else if (GI_DIFFUSE_BLEND_MODE == 1) 
res.rgb = BlendScreen(res.rgb, diffuse.rgb);
else if (GI_DIFFUSE_BLEND_MODE == 2) 
res.rgb = BlendSoftLight(res.rgb, 0.5 + diffuse.rgb);
else if (GI_DIFFUSE_BLEND_MODE == 3) 
res.rgb = BlendColorDodge(res.rgb, diffuse.rgb);
else 
res.rgb = lerp(res.rgb + diffuse.rgb, res.rgb * (1.0 + diffuse.rgb), dot(res.rgb, 0.3333));
#line 240
if (GI_DIFFUSE_DEBUG == 1)
res.rgb = diffuse.rgb;
else if (GI_DIFFUSE_DEBUG == 2)
res.rgb = diffuse.w;
#line 246
return float4(res.rgb + TriDither(res.rgb, texcoord, 8), 1.0);
#line 250
}
#line 252
technique Pirate_GI
{
pass DepthPre
{
VertexShader = PostProcessVS;
PixelShader  = PS_DepthPrePass;
RenderTarget = TexGINormalDepth;
}
pass Diffuse
{
VertexShader = PostProcessVS;
PixelShader  = PS_GIDiffuse;
RenderTarget = TexGI;
}
pass GITest
{
VertexShader = PostProcessVS;
PixelShader  = PS_GICombine;
}
}
