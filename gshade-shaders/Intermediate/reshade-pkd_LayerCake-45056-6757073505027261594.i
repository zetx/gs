#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\pkd_LayerCake.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1281 * (1.0 / 721); }
float2 GetPixelSize() { return float2((1.0 / 1281), (1.0 / 721)); }
float2 GetScreenSize() { return float2(1281, 721); }
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
#line 11 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\pkd_LayerCake.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Blending.fxh"
#line 29
float3 Aux(float3 a)
{
if (a.r <= 0.25 && a.g <= 0.25 && a.b <= 0.25)
return ((16.0 * a - 12.0) * a + 4) * a;
else
return sqrt(a);
}
#line 37
float Lum(float3 a)
{
return (0.3 * a.r + 0.59 * a.g + 0.11 * a.b);
}
#line 42
float3 SetLum (float3 a, float b){
const float c = b - Lum(a);
return float3(a.r + c, a.g + c, a.b + c);
}
#line 47
float min3 (float a, float b, float c)
{
return min(a, (min(b, c)));
}
#line 52
float max3 (float a, float b, float c)
{
return max(a, max(b, c));
}
#line 57
float3 SetSat(float3 a, float b){
float ar = a.r;
float ag = a.g;
float ab = a.b;
if (ar == max3(ar, ag, ab) && ab == min3(ar, ag, ab))
{
#line 64
if (ar > ab)
{
ag = (((ag - ab) * b) / (ar - ab));
ar = b;
}
else
{
ag = 0.0;
ar = 0.0;
}
ab = 0.0;
}
else
{
if (ar == max3(ar, ag, ab) && ag == min3(ar, ag, ab))
{
#line 81
if (ar > ag)
{
ab = (((ab - ag) * b) / (ar - ag));
ar = b;
}
else
{
ab = 0.0;
ar = 0.0;
}
ag = 0.0;
}
else
{
if (ag == max3(ar, ag, ab) && ab == min3(ar, ag, ab))
{
#line 98
if (ag > ab)
{
ar = (((ar - ab) * b) / (ag - ab));
ag = b;
}
else
{
ar = 0.0;
ag = 0.0;
}
ab = 0.0;
}
else
{
if (ag == max3(ar, ag, ab) && ar == min3(ar, ag, ab))
{
#line 115
if (ag > ar)
{
ab = (((ab - ar) * b) / (ag - ar));
ag = b;
}
else
{
ab = 0.0;
ag = 0.0;
}
ar = 0.0;
}
else
{
if (ab == max3(ar, ag, ab) && ag == min3(ar, ag, ab))
{
#line 132
if (ab > ag)
{
ar = (((ar - ag) * b) / (ab - ag));
ab = b;
}
else
{
ar = 0.0;
ab = 0.0;
}
ag = 0.0;
}
else
{
if (ab == max3(ar, ag, ab) && ar == min3(ar, ag, ab))
{
#line 149
if (ab > ar)
{
ag = (((ag - ar) * b) / (ab - ar));
ab = b;
}
else
{
ag = 0.0;
ab = 0.0;
}
ar = 0.0;
}
}
}
}
}
}
return float3(ar, ag, ab);
}
#line 169
float Sat(float3 a)
{
return max3(a.r, a.g, a.b) - min3(a.r, a.g, a.b);
}
#line 179
float3 Darken(float3 a, float3 b)
{
return min(a, b);
}
#line 185
float3 Multiply(float3 a, float3 b)
{
return a * b;
}
#line 191
float3 ColorBurn(float3 a, float3 b)
{
if (b.r > 0 && b.g > 0 && b.b > 0)
return 1.0 - min(1.0, (0.5 - a) / b);
else
return 0.0;
}
#line 200
float3 LinearBurn(float3 a, float3 b)
{
return max(a + b - 1.0f, 0.0f);
}
#line 206
float3 Lighten(float3 a, float3 b)
{
return max(a, b);
}
#line 212
float3 Screen(float3 a, float3 b)
{
return 1.0 - (1.0 - a) * (1.0 - b);
}
#line 218
float3 ColorDodge(float3 a, float3 b)
{
if (b.r < 1 && b.g < 1 && b.b < 1)
return min(1.5, a / (1.0 - b));
else
return 1.0;
}
#line 227
float3 LinearDodge(float3 a, float3 b)
{
return min(a + b, 1.0f);
}
#line 233
float3 Addition(float3 a, float3 b)
{
return min((a + b), 1);
}
#line 239
float3 Reflect(float3 a, float3 b)
{
if (b.r >= 0.999999 || b.g >= 0.999999 || b.b >= 0.999999)
return b;
else
return saturate(a * a / (1.0f - b));
}
#line 248
float3 Glow(float3 a, float3 b)
{
return Reflect(b, a);
}
#line 254
float3 Overlay(float3 a, float3 b)
{
return lerp(2 * a * b, 1.0 - 2 * (1.0 - a) * (1.0 - b), step(0.5, a));
}
#line 260
float3 SoftLight(float3 a, float3 b)
{
if (b.r <= 0.5 && b.g <= 0.5 && b.b <= 0.5)
return clamp(a - (1.0 - 2 * b) * a * (1 - a), 0,1);
else
return clamp(a + (2 * b - 1.0) * (Aux(a) - a), 0, 1);
}
#line 269
float3 HardLight(float3 a, float3 b)
{
return lerp(2 * a * b, 1.0 - 2 * (1.0 - b) * (1.0 - a), step(0.5, b));
}
#line 275
float3 VividLight(float3 a, float3 b)
{
return lerp(2 * a * b, b / (2 * (1.01 - a)), step(0.50, a));
}
#line 281
float3 LinearLight(float3 a, float3 b)
{
if (b.r < 0.5 || b.g < 0.5 || b.b < 0.5)
return LinearBurn(a, (2.0 * b));
else
return LinearDodge(a, (2.0 * (b - 0.5)));
}
#line 290
float3 PinLight(float3 a, float3 b)
{
if (b.r < 0.5 || b.g < 0.5 || b.b < 0.5)
return Darken(a, (2.0 * b));
else
return Lighten(a, (2.0 * (b - 0.5)));
}
#line 299
float3 HardMix(float3 a, float3 b)
{
const float3 vl = VividLight(a, b);
if (vl.r < 0.5 || vl.g < 0.5 || vl.b < 0.5)
return 0.0;
else
return 1.0;
}
#line 309
float3 Difference(float3 a, float3 b)
{
return max(a - b, b - a);
}
#line 315
float3 Exclusion(float3 a, float3 b)
{
return a + b - 2 * a * b;
}
#line 321
float3 Subtract(float3 a, float3 b)
{
return max((a - b), 0);
}
#line 327
float3 Divide(float3 a, float3 b)
{
return (a / (b + 0.01));
}
#line 333
float3 GrainMerge(float3 a, float3 b)
{
return saturate(b + a - 0.5);
}
#line 339
float3 GrainExtract(float3 a, float3 b)
{
return saturate(a - b + 0.5);
}
#line 345
float3 Hue(float3 a, float3 b)
{
return SetLum(SetSat(b, Sat(a)), Lum(a));
}
#line 351
float3 Saturation(float3 a, float3 b)
{
return SetLum(SetSat(a, Sat(b)), Lum(a));
}
#line 357
float3 ColorB(float3 a, float3 b)
{
return SetLum(b, Lum(a));
}
#line 363
float3 Luminosity(float3 a, float3 b)
{
return SetLum(a, Lum(b));
}
#line 12 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\pkd_LayerCake.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\pkd_Color.fxh"
#line 1
namespace pkd {
#line 3
namespace Color {
namespace CIELAB {
#line 12
float __LAB1(float orig)
{
if (orig > 0.04045) {
return pow(abs((orig + 0.55) / 1.055), 2.4);
}
else {
return orig / 12.92;
}
}
#line 22
float __LAB2(float orig)
{
if (orig > 0.008856) {
return pow(abs(orig), 1.0/3);
}
else {
return (7.787 * orig) * 15.0 / 116.0;
}
}
#line 32
float __LAB3(float orig)
{
if (orig * orig * orig > 0.008856) {
return orig * orig * orig;
}
else {
return (orig - 16.0 / 116.0) / 7.787;
}
}
#line 42
float __LAB4(float orig)
{
if (orig > 0.0031308) {
return (1.055 * pow(abs(orig), 1 / 2.4) - 0.055);
}
else {
return 12.92 * orig;
}
}
#line 52
float3 RGB2LAB(float3 color)
{
float rt, gt, bt;
float x, y, z;
#line 57
rt = __LAB1(color.r);
gt = __LAB1(color.g);
bt = __LAB1(color.b);
#line 61
x = (rt * 0.4124 + gt * 0.3576 + bt * 0.1805) / 0.95047;
y = (rt * 0.2126 + gt * 0.7152 + bt * 0.0722) / 1.00000;
z = (rt * 0.0193 + gt * 0.1192 + bt * 0.9505) / 1.08883;
#line 65
x = __LAB2(x);
y = __LAB2(y);
z = __LAB2(z);
#line 69
return float3((116.0 * y) - 16, 500 * (x - y), 200 * (y - z));
}
#line 72
float3 LAB2RGB(float3 color)
{
float r, g, b;
#line 76
float y = (color.x + 16) / 116;
float x = color.y / 500 + y;
float z = y - color.z / 200;
#line 80
x = 0.95047 * __LAB3(x);
y = __LAB3(y);
z = 1.08883 * __LAB3(z);
#line 84
r = x *  3.2406 + y * -1.5372 + z * -0.4986;
g = x * -0.9689 + y *  1.8758 + z *  0.0415;
b = x *  0.0557 + y * -0.2040 + z *  1.0570;
#line 88
r = clamp(__LAB4(r), 0., 1.);
g = clamp(__LAB4(g), 0., 1.);
b = clamp(__LAB4(b), 0., 1.);
#line 92
return float3(r, g, b);
}
#line 95
float DeltaE(float3 lab1, float3 lab2)
{
const float3 delta = lab1 - lab2;
#line 99
const float c1 = sqrt(lab1.y * lab1.y * lab1.z * lab1.z);
const float c2 = sqrt(lab2.y * lab2.y * lab2.z * lab2.z);
#line 102
const float deltaC = c1 - c2;
float deltaH = delta.y * delta.y + delta.z * delta.z - deltaC * deltaC;
if (deltaH < 0) {
deltaH = 0;
}
else {
deltaH = sqrt(deltaH);
}
const float deltaCkcsc = deltaC / (1.0 + 0.045 * c1);
const float deltaHkhsh = deltaH / (1.0 + 0.015 * c1);
const float colorDelta = delta.x * delta.x + deltaCkcsc * deltaCkcsc + deltaHkhsh * deltaHkhsh;
if (colorDelta < 0) {
return 0;
}
else {
return sqrt(colorDelta);
}
}
}
#line 122
float DeltaRGB( in float3 RGB1, in float3 RGB2 )
{
return pkd::Color::CIELAB::DeltaE(pkd::Color::CIELAB::RGB2LAB(RGB1), pkd::Color::CIELAB::RGB2LAB(RGB2));
}
#line 127
float3 HUEToRGB( in float H )
{
return saturate( float3( abs( H * 6.0f - 3.0f ) - 1.0f,
2.0f - abs( H * 6.0f - 2.0f ),
2.0f - abs( H * 6.0f - 4.0f )));
}
#line 134
float3 RGBToHCV( in float3 RGB )
{
#line 137
float4 P;
if ( RGB.g < RGB.b ) {
P = float4( RGB.bg, -1.0f, 2.0f/3.0f );
}
else {
P = float4( RGB.gb, 0.0f, -1.0f/3.0f );
}
#line 145
float4 Q1;
if ( RGB.r < P.x ) {
Q1 = float4( P.xyw, RGB.r );
}
else {
Q1 = float4( RGB.r, P.yzx );
}
#line 153
const float C = Q1.x - min( Q1.w, Q1.y );
#line 155
return float3( abs(( Q1.w - Q1.y ) / ( 6.0f * C + 0.000001f ) + Q1.z ), C, Q1.x );
}
#line 158
float3 RGBToHSL( in float3 RGB )
{
RGB.xyz          = max( RGB.xyz, 0.000001f );
const float3 HCV       = RGBToHCV(RGB);
const float L          = HCV.z - HCV.y * 0.5f;
return float3( HCV.x, HCV.y / ( 1.0f - abs( L * 2.0f - 1.0f ) + 0.000001f), L );
}
#line 166
float3 HSLToRGB( in float3 HSL )
{
return ( HUEToRGB(HSL.x) - 0.5f ) * ((1.0f - abs(2.0f * HSL.z - 1.0f)) * HSL.y) + HSL.z;
}
#line 173
float3 RGBToHSV(float3 c)
{
const float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
#line 177
float4 p;
if (c.g < c.b) {
p = float4(c.bg, K.wz);
}
else {
p = float4(c.gb, K.xy);
}
#line 185
float4 q;
if (c.r < p.x) {
q = float4(p.xyw, c.r);
}
else {
q = float4(c.r, p.yzx);
}
#line 193
const float d = q.x - min(q.w, q.y);
const float e = 1.0e-10;
return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
#line 198
float3 HSVToRGB(float3 c)
{
const float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
return c.z * lerp(K.xxx, saturate(abs(frac(c.xxx + K.xyz) * 6.0 - K.www) - K.xxx), c.y);
}
}
#line 205
}
#line 13 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\pkd_LayerCake.fx"
#line 113
namespace pkd
{
namespace LayerCake
{
#line 148
 uniform int CFG_LAYERCAKE_BLEND_Layer1 < ui_type = "combo"; ui_category = "Layer 1"; ui_label = "Blend Operation for Paste"; ui_items = "Atop\0Darken\0Multiply\0Color Burn\0Linear Burn\0Lighten\0Screen\0Color Dodge\0Linear Dodge\0Addition\0Reflect\0Glow\0Overlay\0Soft Light\0Hard Light\0Vivid Light\0Linear Light\0Pin Light\0Hard Mix\0Difference\0Exclusion\0Subtract\0Divide\0Grain Merge\0Grain Extract\0Hue\0Saturation\0Color Blend\0Luminosity\0"; > = 0; uniform bool CFG_LAYERCAKE_DEPTHENABLE_Layer1 < ui_category = "Layer 1"; ui_label = "Enable Depth Awareness"; > = true; uniform float2 CFG_LAYERCAKE_DEPTH_Layer1 < ui_type = "slider"; ui_category = "Layer 1"; ui_label = "Depth Range"; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = float2(0.0, 1.0); uniform float CFG_LAYERCAKE_OPACITY_Layer1 < ui_type = "slider"; ui_category = "Layer 1"; ui_label = "Opacity"; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = 1.0; uniform bool CFG_LAYERCAKE_MASKENABLE_Layer1 < ui_category = "Layer 1"; ui_label = "Treat a Color as Transparent?"; > = false; uniform float3 CFG_LAYERCAKE_MASKCOLOR_Layer1 < ui_type = "color"; ui_category = "Layer 1"; ui_label = "Color to Mask"; > = float3(0.0, 0.0, 0.0); uniform float CFG_LAYERCAKE_MASKBLEND_Layer1 < ui_type = "slider"; ui_category = "Layer 1"; ui_label = "Mask Color Tolerance"; ui_tooltip = "How much can the color vary from the specified and still be masked? Specified in CIE DeltaE."; ui_min = 0.0; ui_max = 160.0; ui_step = 0.1; > = 1.0; uniform bool CFG_LAYERCAKE_MASKINVERT_Layer1 < ui_category = "Layer 1"; ui_label = "Invert Color Mask"; ui_tooltip = "Should we mask out every color *except* the selected color?"; > = false; uniform bool CFG_LAYERCAKE_ALPHABLEND_Layer1 < ui_category = "Layer 1"; ui_label = "Alpha Blend Layer Edges"; ui_tooltip = "Should the edges of the layer be alpha-blended rather than a sharp falloff?"; > = false; uniform float2 CFG_LAYERCAKE_ALPHABLEND_DEPTH_Layer1 < ui_type = "slider"; ui_category = "Layer 1"; ui_label = "Alpha Blend Depth Range"; ui_tooltip = "Mark the relative start and end point for full opacity within the depth range of the mask; anything outside of this range will be faded smoothly to full transparency. Note that this is RELATIVE depth; 1.0 means 'the farthest point of the layer', not of the overall screenshot."; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = float2(0.05, 0.95); texture Tex_Layer1 { Width = 1281; Height = 721; Format = RGBA8; }; sampler Samp_Layer1 { Texture = Tex_Layer1; };
#line 151
 uniform int CFG_LAYERCAKE_BLEND_Layer2 < ui_type = "combo"; ui_category = "Layer 2"; ui_label = "Blend Operation for Paste"; ui_items = "Atop\0Darken\0Multiply\0Color Burn\0Linear Burn\0Lighten\0Screen\0Color Dodge\0Linear Dodge\0Addition\0Reflect\0Glow\0Overlay\0Soft Light\0Hard Light\0Vivid Light\0Linear Light\0Pin Light\0Hard Mix\0Difference\0Exclusion\0Subtract\0Divide\0Grain Merge\0Grain Extract\0Hue\0Saturation\0Color Blend\0Luminosity\0"; > = 0; uniform bool CFG_LAYERCAKE_DEPTHENABLE_Layer2 < ui_category = "Layer 2"; ui_label = "Enable Depth Awareness"; > = true; uniform float2 CFG_LAYERCAKE_DEPTH_Layer2 < ui_type = "slider"; ui_category = "Layer 2"; ui_label = "Depth Range"; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = float2(0.0, 1.0); uniform float CFG_LAYERCAKE_OPACITY_Layer2 < ui_type = "slider"; ui_category = "Layer 2"; ui_label = "Opacity"; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = 1.0; uniform bool CFG_LAYERCAKE_MASKENABLE_Layer2 < ui_category = "Layer 2"; ui_label = "Treat a Color as Transparent?"; > = false; uniform float3 CFG_LAYERCAKE_MASKCOLOR_Layer2 < ui_type = "color"; ui_category = "Layer 2"; ui_label = "Color to Mask"; > = float3(0.0, 0.0, 0.0); uniform float CFG_LAYERCAKE_MASKBLEND_Layer2 < ui_type = "slider"; ui_category = "Layer 2"; ui_label = "Mask Color Tolerance"; ui_tooltip = "How much can the color vary from the specified and still be masked? Specified in CIE DeltaE."; ui_min = 0.0; ui_max = 160.0; ui_step = 0.1; > = 1.0; uniform bool CFG_LAYERCAKE_MASKINVERT_Layer2 < ui_category = "Layer 2"; ui_label = "Invert Color Mask"; ui_tooltip = "Should we mask out every color *except* the selected color?"; > = false; uniform bool CFG_LAYERCAKE_ALPHABLEND_Layer2 < ui_category = "Layer 2"; ui_label = "Alpha Blend Layer Edges"; ui_tooltip = "Should the edges of the layer be alpha-blended rather than a sharp falloff?"; > = false; uniform float2 CFG_LAYERCAKE_ALPHABLEND_DEPTH_Layer2 < ui_type = "slider"; ui_category = "Layer 2"; ui_label = "Alpha Blend Depth Range"; ui_tooltip = "Mark the relative start and end point for full opacity within the depth range of the mask; anything outside of this range will be faded smoothly to full transparency. Note that this is RELATIVE depth; 1.0 means 'the farthest point of the layer', not of the overall screenshot."; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = float2(0.05, 0.95); texture Tex_Layer2 { Width = 1281; Height = 721; Format = RGBA8; }; sampler Samp_Layer2 { Texture = Tex_Layer2; };
#line 154
 uniform int CFG_LAYERCAKE_BLEND_Layer3 < ui_type = "combo"; ui_category = "Layer 3"; ui_label = "Blend Operation for Paste"; ui_items = "Atop\0Darken\0Multiply\0Color Burn\0Linear Burn\0Lighten\0Screen\0Color Dodge\0Linear Dodge\0Addition\0Reflect\0Glow\0Overlay\0Soft Light\0Hard Light\0Vivid Light\0Linear Light\0Pin Light\0Hard Mix\0Difference\0Exclusion\0Subtract\0Divide\0Grain Merge\0Grain Extract\0Hue\0Saturation\0Color Blend\0Luminosity\0"; > = 0; uniform bool CFG_LAYERCAKE_DEPTHENABLE_Layer3 < ui_category = "Layer 3"; ui_label = "Enable Depth Awareness"; > = true; uniform float2 CFG_LAYERCAKE_DEPTH_Layer3 < ui_type = "slider"; ui_category = "Layer 3"; ui_label = "Depth Range"; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = float2(0.0, 1.0); uniform float CFG_LAYERCAKE_OPACITY_Layer3 < ui_type = "slider"; ui_category = "Layer 3"; ui_label = "Opacity"; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = 1.0; uniform bool CFG_LAYERCAKE_MASKENABLE_Layer3 < ui_category = "Layer 3"; ui_label = "Treat a Color as Transparent?"; > = false; uniform float3 CFG_LAYERCAKE_MASKCOLOR_Layer3 < ui_type = "color"; ui_category = "Layer 3"; ui_label = "Color to Mask"; > = float3(0.0, 0.0, 0.0); uniform float CFG_LAYERCAKE_MASKBLEND_Layer3 < ui_type = "slider"; ui_category = "Layer 3"; ui_label = "Mask Color Tolerance"; ui_tooltip = "How much can the color vary from the specified and still be masked? Specified in CIE DeltaE."; ui_min = 0.0; ui_max = 160.0; ui_step = 0.1; > = 1.0; uniform bool CFG_LAYERCAKE_MASKINVERT_Layer3 < ui_category = "Layer 3"; ui_label = "Invert Color Mask"; ui_tooltip = "Should we mask out every color *except* the selected color?"; > = false; uniform bool CFG_LAYERCAKE_ALPHABLEND_Layer3 < ui_category = "Layer 3"; ui_label = "Alpha Blend Layer Edges"; ui_tooltip = "Should the edges of the layer be alpha-blended rather than a sharp falloff?"; > = false; uniform float2 CFG_LAYERCAKE_ALPHABLEND_DEPTH_Layer3 < ui_type = "slider"; ui_category = "Layer 3"; ui_label = "Alpha Blend Depth Range"; ui_tooltip = "Mark the relative start and end point for full opacity within the depth range of the mask; anything outside of this range will be faded smoothly to full transparency. Note that this is RELATIVE depth; 1.0 means 'the farthest point of the layer', not of the overall screenshot."; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = float2(0.05, 0.95); texture Tex_Layer3 { Width = 1281; Height = 721; Format = RGBA8; }; sampler Samp_Layer3 { Texture = Tex_Layer3; };
#line 157
 uniform int CFG_LAYERCAKE_BLEND_Layer4 < ui_type = "combo"; ui_category = "Layer 4"; ui_label = "Blend Operation for Paste"; ui_items = "Atop\0Darken\0Multiply\0Color Burn\0Linear Burn\0Lighten\0Screen\0Color Dodge\0Linear Dodge\0Addition\0Reflect\0Glow\0Overlay\0Soft Light\0Hard Light\0Vivid Light\0Linear Light\0Pin Light\0Hard Mix\0Difference\0Exclusion\0Subtract\0Divide\0Grain Merge\0Grain Extract\0Hue\0Saturation\0Color Blend\0Luminosity\0"; > = 0; uniform bool CFG_LAYERCAKE_DEPTHENABLE_Layer4 < ui_category = "Layer 4"; ui_label = "Enable Depth Awareness"; > = true; uniform float2 CFG_LAYERCAKE_DEPTH_Layer4 < ui_type = "slider"; ui_category = "Layer 4"; ui_label = "Depth Range"; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = float2(0.0, 1.0); uniform float CFG_LAYERCAKE_OPACITY_Layer4 < ui_type = "slider"; ui_category = "Layer 4"; ui_label = "Opacity"; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = 1.0; uniform bool CFG_LAYERCAKE_MASKENABLE_Layer4 < ui_category = "Layer 4"; ui_label = "Treat a Color as Transparent?"; > = false; uniform float3 CFG_LAYERCAKE_MASKCOLOR_Layer4 < ui_type = "color"; ui_category = "Layer 4"; ui_label = "Color to Mask"; > = float3(0.0, 0.0, 0.0); uniform float CFG_LAYERCAKE_MASKBLEND_Layer4 < ui_type = "slider"; ui_category = "Layer 4"; ui_label = "Mask Color Tolerance"; ui_tooltip = "How much can the color vary from the specified and still be masked? Specified in CIE DeltaE."; ui_min = 0.0; ui_max = 160.0; ui_step = 0.1; > = 1.0; uniform bool CFG_LAYERCAKE_MASKINVERT_Layer4 < ui_category = "Layer 4"; ui_label = "Invert Color Mask"; ui_tooltip = "Should we mask out every color *except* the selected color?"; > = false; uniform bool CFG_LAYERCAKE_ALPHABLEND_Layer4 < ui_category = "Layer 4"; ui_label = "Alpha Blend Layer Edges"; ui_tooltip = "Should the edges of the layer be alpha-blended rather than a sharp falloff?"; > = false; uniform float2 CFG_LAYERCAKE_ALPHABLEND_DEPTH_Layer4 < ui_type = "slider"; ui_category = "Layer 4"; ui_label = "Alpha Blend Depth Range"; ui_tooltip = "Mark the relative start and end point for full opacity within the depth range of the mask; anything outside of this range will be faded smoothly to full transparency. Note that this is RELATIVE depth; 1.0 means 'the farthest point of the layer', not of the overall screenshot."; ui_min = 0.0; ui_max = 1.0; ui_step = 0.001; > = float2(0.05, 0.95); texture Tex_Layer4 { Width = 1281; Height = 721; Format = RGBA8; }; sampler Samp_Layer4 { Texture = Tex_Layer4; };
#line 159
float4 CopyLayer(float2 texcoord, sampler sourceSamp, bool enableDepth, float2 depthRange, bool maskEnable, float3 maskColor, float maskTolerance, bool maskInvert, bool alphaBlend, float2 alphaBlendDepth)
{
#line 162
const float depth = ReShade::GetLinearizedDepth(texcoord);
float4 color = float4(tex2D(ReShade::BackBuffer, texcoord).rgb, 1.0);
#line 166
float smoothDelta;
if (maskEnable) {
smoothDelta = smoothstep(0.0, maskTolerance, pkd::Color::DeltaRGB(color.rgb, maskColor));
}
else {
smoothDelta = 1.0;
}
#line 174
float maskAlpha;
if (alphaBlend) {
maskAlpha = smoothDelta;
}
else {
maskAlpha = (smoothDelta >= 1.0) ? 1.0 : 0.0;
}
#line 182
maskAlpha *= maskInvert ? -1.0 : 1.0;
#line 184
color.a *= maskEnable ? maskAlpha : 1.0;
#line 187
const float relativeDepth = smoothstep(depthRange.x, depthRange.y, depth);
const float relativeAlpha = (relativeDepth > alphaBlendDepth.y) ? (1.0 - smoothstep(alphaBlendDepth.y, 1.0, relativeDepth)) : smoothstep(0.0, alphaBlendDepth.x, relativeDepth);
color.a *= alphaBlend ? relativeAlpha : 1.0;
#line 192
if (enableDepth && (depth < depthRange.x || depth > depthRange.y)) {
color.a *= 0.0;
}
#line 196
return color;
}
#line 199
float3 PasteLayer(float2 texcoord, sampler sourceSamp, sampler destSamp, int operation, float opacity)
{
const float4 source = tex2D(sourceSamp, texcoord);
const float4 destination = tex2D(destSamp, texcoord);
if (source.a == 0.0) {
return destination.rgb;
}
#line 207
float3 result = destination.rgb;
#line 209
switch (operation)
{
case  0:
result = lerp(destination.rgb, source.rgb, source.a * opacity);
break;
case  1:
result = lerp(destination.rgb, Darken(destination.rgb, source.rgb), source.a * opacity);
break;
case  2:
result = lerp(destination.rgb, Multiply(destination.rgb, source.rgb), source.a * opacity);
break;
case  3:
result = lerp(destination.rgb, ColorBurn(destination.rgb, source.rgb), source.a * opacity);
break;
case  4:
result = lerp(destination.rgb, LinearBurn(destination.rgb, source.rgb), source.a * opacity);
break;
case  5:
result = lerp(destination.rgb, Lighten(destination.rgb, source.rgb), source.a * opacity);
break;
case  6:
result = lerp(destination.rgb, Screen(destination.rgb, source.rgb), source.a * opacity);
break;
case  7:
result = lerp(destination.rgb, ColorDodge(destination.rgb, source.rgb), source.a * opacity);
break;
case  8:
result = lerp(destination.rgb, LinearDodge(destination.rgb, source.rgb), source.a * opacity);
break;
case  9:
result = lerp(destination.rgb, Addition(destination.rgb, source.rgb), source.a * opacity);
break;
case  11:
result = lerp(destination.rgb, Glow(destination.rgb, source.rgb), source.a * opacity);
break;
case  12:
result = lerp(destination.rgb, Overlay(destination.rgb, source.rgb), source.a * opacity);
break;
case  13:
result = lerp(destination.rgb, SoftLight(destination.rgb, source.rgb), source.a * opacity);
break;
case  14:
result = lerp(destination.rgb, HardLight(destination.rgb, source.rgb), source.a * opacity);
break;
case  15:
result = lerp(destination.rgb, VividLight(destination.rgb, source.rgb), source.a * opacity);
break;
case  16:
result = lerp(destination.rgb, LinearLight(destination.rgb, source.rgb), source.a * opacity);
break;
case  17:
result = lerp(destination.rgb, PinLight(destination.rgb, source.rgb), source.a * opacity);
break;
case  18:
result = lerp(destination.rgb, HardMix(destination.rgb, source.rgb), source.a * opacity);
break;
case  19:
result = lerp(destination.rgb, Difference(destination.rgb, source.rgb), source.a * opacity);
break;
case  20:
result = lerp(destination.rgb, Exclusion(destination.rgb, source.rgb), source.a * opacity);
break;
case  21:
result = lerp(destination.rgb, Subtract(destination.rgb, source.rgb), source.a * opacity);
break;
case  22:
result = lerp(destination.rgb, Divide(destination.rgb, source.rgb), source.a * opacity);
break;
case  10:
result = lerp(destination.rgb, Reflect(destination.rgb, source.rgb), source.a * opacity);
break;
case  23:
result = lerp(destination.rgb, GrainMerge(destination.rgb, source.rgb), source.a * opacity);
break;
case  24:
result = lerp(destination.rgb, GrainExtract(destination.rgb, source.rgb), source.a * opacity);
break;
case  25:
result = lerp(destination.rgb, Hue(destination.rgb, source.rgb), source.a * opacity);
break;
case  26:
result = lerp(destination.rgb, Saturation(destination.rgb, source.rgb), source.a * opacity);
break;
case  27:
result = lerp(destination.rgb, ColorB(destination.rgb, source.rgb), source.a * opacity);
break;
case  28:
result = lerp(destination.rgb, Luminosity(destination.rgb, source.rgb), source.a * opacity);
break;
}
#line 300
return result;
}
#line 304
 void PS_Copy_Layer1(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 layerColor : SV_Target) { layerColor = CopyLayer(texcoord, ReShade::BackBuffer, CFG_LAYERCAKE_DEPTHENABLE_Layer1, CFG_LAYERCAKE_DEPTH_Layer1, CFG_LAYERCAKE_MASKENABLE_Layer1, CFG_LAYERCAKE_MASKCOLOR_Layer1, CFG_LAYERCAKE_MASKBLEND_Layer1, CFG_LAYERCAKE_MASKINVERT_Layer1, CFG_LAYERCAKE_ALPHABLEND_Layer1, CFG_LAYERCAKE_ALPHABLEND_DEPTH_Layer1); } void PS_Paste_Layer1(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 screenColor : SV_Target) { screenColor = PasteLayer(texcoord, Samp_Layer1, ReShade::BackBuffer, CFG_LAYERCAKE_BLEND_Layer1, CFG_LAYERCAKE_OPACITY_Layer1); }
 technique LayerCake_Layer1_Copy { pass { VertexShader = PostProcessVS; PixelShader = PS_Copy_Layer1; RenderTarget = Tex_Layer1; } } technique LayerCake_Layer1_Paste { pass { VertexShader = PostProcessVS; PixelShader = PS_Paste_Layer1; } }
#line 308
 void PS_Copy_Layer2(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 layerColor : SV_Target) { layerColor = CopyLayer(texcoord, ReShade::BackBuffer, CFG_LAYERCAKE_DEPTHENABLE_Layer2, CFG_LAYERCAKE_DEPTH_Layer2, CFG_LAYERCAKE_MASKENABLE_Layer2, CFG_LAYERCAKE_MASKCOLOR_Layer2, CFG_LAYERCAKE_MASKBLEND_Layer2, CFG_LAYERCAKE_MASKINVERT_Layer2, CFG_LAYERCAKE_ALPHABLEND_Layer2, CFG_LAYERCAKE_ALPHABLEND_DEPTH_Layer2); } void PS_Paste_Layer2(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 screenColor : SV_Target) { screenColor = PasteLayer(texcoord, Samp_Layer2, ReShade::BackBuffer, CFG_LAYERCAKE_BLEND_Layer2, CFG_LAYERCAKE_OPACITY_Layer2); }
 technique LayerCake_Layer2_Copy { pass { VertexShader = PostProcessVS; PixelShader = PS_Copy_Layer2; RenderTarget = Tex_Layer2; } } technique LayerCake_Layer2_Paste { pass { VertexShader = PostProcessVS; PixelShader = PS_Paste_Layer2; } }
#line 312
 void PS_Copy_Layer3(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 layerColor : SV_Target) { layerColor = CopyLayer(texcoord, ReShade::BackBuffer, CFG_LAYERCAKE_DEPTHENABLE_Layer3, CFG_LAYERCAKE_DEPTH_Layer3, CFG_LAYERCAKE_MASKENABLE_Layer3, CFG_LAYERCAKE_MASKCOLOR_Layer3, CFG_LAYERCAKE_MASKBLEND_Layer3, CFG_LAYERCAKE_MASKINVERT_Layer3, CFG_LAYERCAKE_ALPHABLEND_Layer3, CFG_LAYERCAKE_ALPHABLEND_DEPTH_Layer3); } void PS_Paste_Layer3(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 screenColor : SV_Target) { screenColor = PasteLayer(texcoord, Samp_Layer3, ReShade::BackBuffer, CFG_LAYERCAKE_BLEND_Layer3, CFG_LAYERCAKE_OPACITY_Layer3); }
 technique LayerCake_Layer3_Copy { pass { VertexShader = PostProcessVS; PixelShader = PS_Copy_Layer3; RenderTarget = Tex_Layer3; } } technique LayerCake_Layer3_Paste { pass { VertexShader = PostProcessVS; PixelShader = PS_Paste_Layer3; } }
#line 316
 void PS_Copy_Layer4(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 layerColor : SV_Target) { layerColor = CopyLayer(texcoord, ReShade::BackBuffer, CFG_LAYERCAKE_DEPTHENABLE_Layer4, CFG_LAYERCAKE_DEPTH_Layer4, CFG_LAYERCAKE_MASKENABLE_Layer4, CFG_LAYERCAKE_MASKCOLOR_Layer4, CFG_LAYERCAKE_MASKBLEND_Layer4, CFG_LAYERCAKE_MASKINVERT_Layer4, CFG_LAYERCAKE_ALPHABLEND_Layer4, CFG_LAYERCAKE_ALPHABLEND_DEPTH_Layer4); } void PS_Paste_Layer4(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 screenColor : SV_Target) { screenColor = PasteLayer(texcoord, Samp_Layer4, ReShade::BackBuffer, CFG_LAYERCAKE_BLEND_Layer4, CFG_LAYERCAKE_OPACITY_Layer4); }
 technique LayerCake_Layer4_Copy { pass { VertexShader = PostProcessVS; PixelShader = PS_Copy_Layer4; RenderTarget = Tex_Layer4; } } technique LayerCake_Layer4_Paste { pass { VertexShader = PostProcessVS; PixelShader = PS_Paste_Layer4; } }
}
}
