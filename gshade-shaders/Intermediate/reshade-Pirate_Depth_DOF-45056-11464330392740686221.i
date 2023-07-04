#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pirate_Depth_DOF.fx"
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
#line 5 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pirate_Depth_DOF.fx"
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
#line 7 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Pirate_Depth_DOF.fx"
#line 19
uniform bool DOF_USE_AUTO_FOCUS <
ui_label = "Auto Focus";
> = 1;
uniform float DOF_RADIUS <
ui_label = "DOF - Radius";
ui_tooltip = "1.0 = Pixel perfect radius. Values above 1.0 might create artifacts.";
ui_type = "slider";
ui_min = 0.0; ui_max = 10.0;
> = 1.0;
uniform float DOF_NEAR_STRENGTH <
ui_label = "DOF - Near Blur Strength";
ui_tooltip = "Strength of the blur between the camera and focal point.";
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
> = 0.5;
uniform float DOF_FAR_STRENGTH <
ui_label = "DOF - Far Blur Strength";
ui_tooltip = "Strength of the blur past the focal point.";
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
> = 1.0;
uniform float DOF_FOCAL_RANGE <
ui_label = "DOF - Focal Range";
ui_tooltip = "Along with Focal Curve, this controls how much will be in focus";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.0;
uniform float DOF_FOCAL_CURVE <
ui_label = "DOF - Focal Curve";
ui_tooltip = "1.0 = No curve. Values above this put more things in focus, lower values create a macro effect.";
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
> = 1.0;
uniform float DOF_HYPERFOCAL <
ui_label = "DOF - Hyperfocal Range";
ui_tooltip = "When the focus goes past this point, everything in the distance is focused.";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.9;
uniform float DOF_BLEND <
ui_label = "DOF - Blending Curve";
ui_tooltip = "Controls the blending curve between the DOF texture and original image. Use this to avoid artifacts where the DOF begins";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.3;
uniform float DOF_BOKEH_CONTRAST <
ui_label = "DOF - Bokeh - Contrast";
ui_tooltip = "Contrast of bokeh and blurred areas. Use very small values.";
ui_type = "slider";
ui_min = -1.0; ui_max = 1.0;
> = 0.04;
uniform float DOF_BOKEH_BIAS <
ui_label = "DOF - Bokeh - Bias";
ui_tooltip = "0.0 = No Bokeh, 1.0 = Natural bokeh, 2.0 = Forced bokeh.";
ui_type = "slider";
ui_min = 0.0; ui_max = 2.0;
> = 1.0;
uniform float DOF_MANUAL_FOCUS <
ui_label = "DOF - Manual Focus";
ui_tooltip = "Only works when manual focus is on.";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.5;
uniform float DOF_FOCUS_X <
ui_label = "DOF - Auto Focus X";
ui_tooltip = "Horizontal point in the screen to focus. 0.5 = middle";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.5;
uniform float DOF_FOCUS_Y <
ui_label = "DOF - Auto Focus Y";
ui_tooltip = "Vertical point in the screen to focus. 0.5 = middle";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.5;
uniform float DOF_FOCUS_SPREAD <
ui_label = "DOF - Auto Focus Spread";
ui_tooltip = "Focus takes the average of 5 points, this is how far away they are. Use low values for a precise focus.";
ui_type = "slider";
ui_min = 0.0; ui_max = 0.5;
> = 0.05;
uniform float DOF_FOCUS_SPEED <
ui_label = "DOF - Auto Focus Speed";
ui_tooltip = "How fast focus changes happen. 1.0 = One second. Values above 1.0 are faster, bellow are slower.";
ui_type = "slider";
ui_min = 0.0; ui_max = 10.0;
> = 1.0;
uniform float DOF_SCRATCHES_STRENGTH <
ui_label = "DOF - Lens Scratches Strength";
ui_tooltip = "How strong is the scratch effect. Low values are better as this shows up a lot in bright scenes.";
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
> = 0.15;
uniform int DOF_DEBUG <
ui_label = "DOG - Debug - Show Focus";
ui_tooltip = "Black is in focus, red is blurred.";
ui_type = "combo";
ui_items = "No\0Yes\0";
> = 0;
uniform int LUMA_MODE <
ui_label = "Luma Mode";
ui_type = "combo";
ui_items = "Intensity\0Value\0Lightness\0Luma\0";
> = 3;
uniform int FOV <
ui_label = "FoV";
ui_type = "slider";
ui_min = 10; ui_max = 90;
> = 75;
#line 129
uniform float Frametime < source = "frametime"; >;
#line 132
texture2D	TexNormalDepth {Width = 792 * 		0.5	; Height = 710 * 		0.5	; Format = RGBA16; MipLevels = 		5	;};
sampler2D	SamplerND {Texture = TexNormalDepth; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
#line 135
texture2D	TexF1 {Width = 1; Height = 1; Format = R16F;};
sampler2D	SamplerFocalPoint {Texture = TexF1; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
texture2D	TexF2 {Width = 1; Height = 1; Format = R16F;};
sampler2D	SamplerFCopy {Texture = TexF2; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
#line 144
texture2D	TexFocus {Width = 792 * 		0.5	; Height = 710 * 		0.5	; Format = R8;};
sampler2D	SamplerFocus {Texture = TexFocus; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
#line 148
texture2D	TexDOF1 {Width = 792 * 		0.5	; Height = 710 * 		0.5	; Format = RGBA8;};
sampler2D	SamplerDOF1 {Texture = TexDOF1; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
texture2D	TexDOF2 {Width = 792 * 		0.5	; Height = 710 * 		0.5	; Format = RGBA8;};
sampler2D	SamplerDOF2 {Texture = TexDOF2; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
#line 153
float GetDepth(float2 coords)
{
return saturate(ReShade::GetLinearizedDepth(coords));
}
#line 158
float3 EyeVector(float3 vec)
{
vec.xy = vec.xy * 2.0 - 1.0;
vec.x -= vec.x * (1.0 - vec.z) * sin(radians(FOV));
vec.y -= vec.y * (1.0 - vec.z) * sin(radians(FOV * (  	float2((1.0 / 792), (1.0 / 710)).y /   	float2((1.0 / 792), (1.0 / 710)).x)));
return vec;
}
#line 166
float4 GetNormalDepth(float2 coords)
{
const float2 offsety = float2(0.0,   	float2((1.0 / 792), (1.0 / 710)).y);
const float2 offsetx = float2(  	float2((1.0 / 792), (1.0 / 710)).x, 0.0);
#line 171
const float pointdepth = GetDepth(coords);
#line 182
const float3 p = EyeVector(float3(coords, pointdepth));
float3 py1 = EyeVector(float3(coords + offsety, GetDepth(coords + offsety))) - p;
const float3 py2 = p - EyeVector(float3(coords - offsety, GetDepth(coords - offsety)));
float3 px1 = EyeVector(float3(coords + offsetx, GetDepth(coords + offsetx))) - p;
const float3 px2 = p - EyeVector(float3(coords - offsetx, GetDepth(coords - offsetx)));
py1 = lerp(py1, py2, abs(py1.z) > abs(py2.z));
px1 = lerp(px1, px2, abs(px1.z) > abs(px2.z));
#line 191
float3 normal = cross(py1, px1);
normal = (normalize(normal) + 1.0) * 0.5;
#line 194
return float4(normal, pointdepth);
}
#line 197
float4 LumaChroma(float4 col) {
if (LUMA_MODE == 0) { 			
const float i = dot(col.rgb, 0.3333);
return float4(col.rgb / i, i);
} else if (LUMA_MODE == 1) {		
const float v = max(max(col.r, col.g), col.b);
return float4(col.rgb / v, v);
} else if (LUMA_MODE == 2) { 		
const float high = max(max(col.r, col.g), col.b);
const float low = min(min(col.r, col.g), col.b);
const float l = (high + low) / 2;
return float4(col.rgb / l, l);
} else { 				
const float luma = dot(col.rgb, float3(0.21, 0.72, 0.07));
return float4(col.rgb / luma, luma);
}
}
#line 215
float3 BlendColorDodge(float3 a, float3 b) {
return a / (1 - b);
}
#line 219
float2 Rotate60(float2 v) {
#line 221
const float x = v.x * 0.5 - v.y *  0.86602540378f;
const float y = v.x *  0.86602540378f + v.y * 0.5;
return float2(x, y);
}
#line 226
float2 Rotate120(float2 v) {
#line 228
const float x = v.x * -0.5 - v.y *  0.58061118421f;
const float y = v.x *  0.58061118421f + v.y * -0.5;
return float2(x, y);
}
#line 233
float2 Rotate(float2 v, float angle) {
const float x = v.x * cos(angle) - v.y * sin(angle);
const float y = v.x * sin(angle) + v.y * cos(angle);
return float2(x, y);
}
#line 239
float GetFocus(float d) {
float focus;
if (!DOF_USE_AUTO_FOCUS)
focus = min(DOF_HYPERFOCAL, DOF_MANUAL_FOCUS);
else
focus = min(DOF_HYPERFOCAL, tex2D(SamplerFocalPoint, 0.5).x);
float res;
if (d > focus) {
res = smoothstep(focus, 1.0, d) * DOF_FAR_STRENGTH;
res = lerp(res, 0.0, focus / DOF_HYPERFOCAL);
} else if (d < focus) {
res = smoothstep(focus, 0.0, d) * DOF_NEAR_STRENGTH;
} else {
res = 0.0;
}
#line 255
res = pow(smoothstep(DOF_FOCAL_RANGE, 1.0, res), DOF_FOCAL_CURVE);
#line 260
return res;
}
float4 GenDOF(float2 texcoord, float2 v, sampler2D samp)
{
const float4 origcolor = tex2D(samp, texcoord);
float4 res = origcolor;
res.w = LumaChroma(origcolor).w;
#line 271
float bluramount = tex2D(SamplerFocus, texcoord).r;
if (bluramount == 0) return origcolor;
res.w *= bluramount;
#line 275
if (!DOF_USE_AUTO_FOCUS)
v = Rotate(v, tex2D(SamplerFocalPoint, 0.5).x * 2.0);
float4 bokeh = res;
res.rgb *= res.w;
#line 297
const float discradius = bluramount * DOF_RADIUS;
if (discradius <   	float2((1.0 / 792), (1.0 / 710)).x / 		0.5	)
return origcolor;
const float2 calcv = v * discradius *   	float2((1.0 / 792), (1.0 / 710)) / 		0.5	;
#line 303
for(int i=1; i <= 			4	; i++)
{
#line 307
float2 tapcoord = texcoord + calcv * i;
#line 309
float4 tap = tex2Dlod(samp, float4(tapcoord, 0, 0));
#line 315
tap.w = tex2Dlod(SamplerFocus, float4(tapcoord, 0, 0)).r * LumaChroma(tap).w;
#line 319
bokeh = lerp(bokeh, tap, (tap.w > bokeh.w) * tap.w);
#line 321
res.rgb += tap.rgb * tap.w;
res.w += tap.w;
#line 325
tapcoord = texcoord - calcv * i;
#line 327
tap = tex2Dlod(samp, float4(tapcoord, 0, 0));
#line 333
tap.w = tex2Dlod(SamplerFocus, float4(tapcoord, 0, 0)).r * LumaChroma(tap).w;
#line 337
bokeh = lerp(bokeh, tap, (tap.w > bokeh.w) * tap.w);
#line 339
res.rgb += tap.rgb * tap.w;
res.w += tap.w;
#line 342
}
#line 344
res.rgb /= res.w;
#line 349
res.rgb = lerp(res.rgb, bokeh.rgb, saturate(bokeh.w * DOF_BOKEH_BIAS));
#line 351
res.w = 1.0;
float4 lc = LumaChroma(res);
lc.w = pow(abs(lc.w), 1.0 + float(DOF_BOKEH_CONTRAST) / 10.0);
res.rgb = lc.rgb * lc.w;
#line 356
return res;
}
#line 359
float4 PS_DepthPrePass(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
return GetNormalDepth(texcoord);
}
float PS_GetFocus (float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
const float lastfocus = tex2D(SamplerFCopy, 0.5).x;
float res;
#line 368
const float2 offset[5]=
{
float2(0.0, 0.0),
float2(0.0, -1.0),
float2(0.0, 1.0),
float2(1.0, 0.0),
float2(-1.0, 0.0)
};
for(int i=0; i < 5; i++)
{
res += tex2D(SamplerND, float2(DOF_FOCUS_X, DOF_FOCUS_Y) + offset[i] * DOF_FOCUS_SPREAD).w;
}
res /= 5;
res = lerp(lastfocus, res, DOF_FOCUS_SPEED * Frametime / 1000.0);
return res;
}
float PS_CopyFocus (float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
return tex2D(SamplerFocalPoint, 0.5).x;
}
float PS_GenFocus (float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
return GetFocus(tex2D(SamplerND, texcoord).w);
}
float4 PS_DOF1(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
return GenDOF(texcoord, float2(1.0, 0.0), ReShade::BackBuffer);
}
float4 PS_DOF2(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
return GenDOF(texcoord, Rotate60(float2(1.0, 0.0)), SamplerDOF1);
}
float4 PS_DOF3(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
return GenDOF(texcoord, Rotate120(float2(1.0, 0.0)), SamplerDOF2);
}
float4 PS_DOFCombine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
#line 416
const float bluramount = tex2D(SamplerFocus, texcoord).r;
const float4 orig = tex2D(ReShade::BackBuffer, texcoord);
#line 419
float4 res;
if (bluramount == 0.0) {
res = orig;
} else {
res = lerp(orig, tex2D(SamplerDOF1, texcoord), smoothstep(0.0, DOF_BLEND, bluramount));
}
if (DOF_DEBUG) res = tex2D(SamplerFocus, texcoord);
#line 427
return float4(res.rgb + TriDither(res.rgb, texcoord, 8), res.a);
#line 432
}
#line 434
technique Pirate_DOF
{
pass DepthPre
{
VertexShader = PostProcessVS;
PixelShader  = PS_DepthPrePass;
RenderTarget = TexNormalDepth;
}
#line 443
pass GetFocus
{
VertexShader = PostProcessVS;
PixelShader  = PS_GetFocus;
RenderTarget = TexF1;
}
pass CopyFocus
{
VertexShader = PostProcessVS;
PixelShader  = PS_CopyFocus;
RenderTarget = TexF2;
}
pass FocalRange
{
VertexShader = PostProcessVS;
PixelShader  = PS_GenFocus;
RenderTarget = TexFocus;
}
pass DOF1
{
VertexShader = PostProcessVS;
PixelShader  = PS_DOF1;
RenderTarget = TexDOF1;
}
pass DOF2
{
VertexShader = PostProcessVS;
PixelShader  = PS_DOF2;
RenderTarget = TexDOF2;
}
pass DOF3
{
VertexShader = PostProcessVS;
PixelShader  = PS_DOF3;
RenderTarget = TexDOF1;
}
pass Combine
{
VertexShader = PostProcessVS;
PixelShader  = PS_DOFCombine;
}
}
