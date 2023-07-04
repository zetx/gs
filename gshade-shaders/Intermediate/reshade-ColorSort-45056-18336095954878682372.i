#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\ComputeShaders\ColorSort.fx"
#line 22
uniform bool ReverseSort <
ui_tooltip = "While active, it orders from dark to bright, top to bottom. Else it will sort from bright to dark.";
> = false;
uniform bool FilterColor <
ui_tooltip = "Activates the color filter option.";
> = false;
uniform bool ShowSelectedHue <
ui_tooltip = "Display the current selected hue range on the top of the image.";
> = false;
uniform float Value <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The Value describes the brightness of the hue. 0 is black/no hue and 1 is maximum hue(e.g. pure red).";
> = 1.0;
uniform float ValueRange <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The tolerance around the value.";
> = 1.0;
uniform float Hue <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The hue describes the color category. It can be red, green, blue or a mix of them.";
> = 1.0;
uniform float HueRange <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The tolerance around the hue.";
> = 1.0;
uniform float Saturation <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The saturation determins the colorfulness. 0 is greyscale and 1 pure colors.";
> = 1.0;
uniform float SaturationRange <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The tolerance around the saturation.";
> = 1.0;
uniform bool FilterDepth <
ui_tooltip = "Activates the depth filter option.";
> = false;
uniform float FocusDepth <
ui_type = "slider";
ui_min = 0.000; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "Manual focus depth of the point which has the focus. Range from 0.0, which means camera is the focus plane, till 1.0 which means the horizon is focus plane.";
> = 0.026;
uniform float FocusRangeDepth <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.000;
ui_step = 0.001;
ui_tooltip = "The depth of the range around the manual focus depth which should be emphasized. Outside this range, de-emphasizing takes place";
> = 0.001;
uniform bool Spherical <
ui_tooltip = "Enables Emphasize in a sphere around the focus-point instead of a 2D plane";
> = false;
uniform int Sphere_FieldOfView <
ui_type = "slider";
ui_min = 1; ui_max = 180;
ui_tooltip = "Specifies the estimated Field of View you are currently playing with. Range from 1, which means 1 Degree, till 180 which means 180 Degree (half the scene).\nNormal games tend to use values between 60 and 90.";
> = 75;
uniform float Sphere_FocusHorizontal <
ui_type = "slider";
ui_min = 0; ui_max = 1;
ui_tooltip = "Specifies the location of the focuspoint on the horizontal axis. Range from 0, which means left screen border, till 1 which means right screen border.";
> = 0.5;
uniform float Sphere_FocusVertical <
ui_type = "slider";
ui_min = 0; ui_max = 1;
ui_tooltip = "Specifies the location of the focuspoint on the vertical axis. Range from 0, which means upper screen border, till 1 which means bottom screen border.";
> = 0.5;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Reshade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 1500 * (1.0 / 1004); }
float2 GetPixelSize() { return float2((1.0 / 1500), (1.0 / 1004)); }
float2 GetScreenSize() { return float2(1500, 1004); }
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
#line 101 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\ComputeShaders\ColorSort.fx"
#line 112
namespace primitiveColor
{
#line 118
texture texHalfRes{ Width = 1500; Height = 	640 ; Format = RGBA16F; };
texture texColorSort{ Width = 1500; Height = 	640 ; Format = RGBA16F; };
storage texColorSortStorage{ Texture = texColorSort; };
#line 126
sampler2D SamplerHalfRes{ Texture = texHalfRes; };
sampler2D SamplerColorSort{ Texture = texColorSort; };
#line 133
bool min_color(float4 a, float4 b)
{
float val = b.a - a.a; 
val = (abs(val) < 0.1) ? ((a.r + a.g + a.b) - (b.r + b.g + b.b))*(1-ReverseSort-ReverseSort) : val;
return (val < 0) ? false : true; 
}
#line 140
float3 mod(float3 x, float y) 
{
return x - y * floor(x / y);
}
#line 146
float4 hsv2rgb(float4 c)
{
float3 rgb = clamp(abs(mod(float3(c.x*6.0, c.x*6.0+4.0, c.x*6.0+2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
#line 150
rgb = rgb * rgb*(3.0 - 2.0*rgb); 
#line 152
return float4(c.z * lerp(float3(1.0,1.0,1.0), rgb, c.y),1.0);
}
#line 156
float4 rgb2hsv(float4 c)
{
float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
#line 162
float d = q.x - min(q.w, q.y);
float e = 1.0e-10;
return float4(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x,1.0);
}
#line 168
float4 showHue(float2 texcoord, float4 fragment)
{
float range = 0.145;
float depth = 0.06;
if (abs(texcoord.x - 0.5) < range && texcoord.y < depth)
{
float4 hsvval = float4(saturate(texcoord.x - 0.5 + range) / (2 * range), 1, 1, 1);
float4 rgbval = hsv2rgb(hsvval);
bool active = min(abs(hsvval.r - Hue), (1 - abs(hsvval.r - Hue))) < HueRange;
fragment = active ? rgbval : float4(0.5, 0.5, 0.5, 1);
}
return fragment;
}
#line 182
bool inFocus(float4 rgbval, float scenedepth, float2 texcoord)
{
#line 185
float4 hsvval = rgb2hsv(rgbval);
bool d1 = abs(hsvval.b - Value) < ValueRange;
bool d2 = abs(hsvval.r - Hue) < (HueRange + pow(2.71828, -(hsvval.g*hsvval.g) / 0.005)) || (1-abs(hsvval.r - Hue)) < (HueRange+pow(2.71828,-(hsvval.g*hsvval.g)/0.01));
bool d3 = abs(hsvval.g - Saturation) <= SaturationRange;
bool is_color_focus = (d3 && d2 && d1) || FilterColor == 0; 
#line 191
float depthdiff;
texcoord.x = (texcoord.x - Sphere_FocusHorizontal)*ReShade:: GetScreenSize().x;
texcoord.y = (texcoord.y - Sphere_FocusVertical)*ReShade:: GetScreenSize().y;
const float degreePerPixel = Sphere_FieldOfView / ReShade:: GetScreenSize().x;
const float fovDifference = sqrt((texcoord.x*texcoord.x) + (texcoord.y*texcoord.y))*degreePerPixel;
depthdiff = Spherical ? sqrt((scenedepth*scenedepth) + (FocusDepth*FocusDepth) - (2 * scenedepth*FocusDepth*cos(fovDifference*(2 *  3.1415927 / 360)))) : depthdiff = abs(scenedepth - FocusDepth);
#line 198
bool is_depth_focus = (depthdiff < FocusRangeDepth) || FilterDepth == 0;
return is_color_focus && is_depth_focus;
}
#line 202
groupshared float4 colortable[2 * 	640 ];
#line 204
void merge_sort(int low, int high, int em)
{
float4 temp[	640  / 	16 ];
for (int i = 0; i < 	640  / 	16 ; i++)
{
temp[i] = colortable[low + i];
}
for (int m = em; m <= high - low; m = 2 * m)
{
for (int i = low; i < high; i += 2 * m)
{
int from = i;
int mid = i + m - 1;
int to = min(i + 2 * m - 1, high);
#line 219
int k = from, i_2 = from, j = mid + 1;
while (i_2 <= mid && j <= to)
{
if (min_color(colortable[i_2], colortable[j])) {
temp[k++ - low] = colortable[i_2++];
}
else {
temp[k++ - low] = colortable[j++];
}
}
while (i_2 < high && i_2 <= mid)
{
temp[k++ - low] = colortable[i_2++];
}
for (i_2 = from; i_2 <= to; i_2++)
{
colortable[i_2] = temp[i_2 - low];
}
}
}
}
#line 242
groupshared int evenblock[2 * 	16 ];
groupshared int oddblock[2 * 	16 ];
#line 245
void sort_color(uint3 id : SV_DispatchThreadID, uint3 tid : SV_GroupThreadID)
{
int row = tid.y*uint(	640 ) / uint(	16 );
int interval_start = row + tid.x*	640 ;
int interval_end = row - 1 + uint(	640 ) / uint(	16 ) + tid.x*	640 ;
int i;
#line 252
if (tid.y == 0)
{
bool was_focus = false;
bool is_focus = false;
int maskval = 0;
for (i = 0; i < 	640 ; i++)
{
colortable[i + tid.x*	640 ] = tex2Dfetch(SamplerHalfRes, int2(id.x, i), 0);
float scenedepth = ReShade::GetLinearizedDepth(float2((id.x+0.5) / float(1500), (i+0.5) / float(	640 )));
is_focus = inFocus(colortable[i + tid.x*	640 ], scenedepth, float2((id.x + 0.5) / float(1500), (i + 0.5) / float(	640 )));
#line 263
if (!(is_focus && was_focus))
maskval++;
was_focus = is_focus;
colortable[i + tid.x*	640 ].a = (float)maskval+0.5*is_focus;
#line 268
}
}
barrier();
#line 272
merge_sort(interval_start, interval_end, 1);
#line 274
float4 key[	16 ];
float4 key_sorted[	16 ];
float4 sorted_array[2 * uint(	640 ) / uint(	16 )];
for (i = 1; i < 	16 ; i = 2 * i) 
{
barrier();
int groupsize = 2 * i;
#line 282
for (int j = 0; j < groupsize; j++) 
{
int curr = tid.y - (tid.y % groupsize) + j;
int ct = uint(curr * 	640 ) / uint(	16 );
key[curr] = colortable[ct + tid.x*	640 ];
}
#line 289
int idy_sorted;
int even = tid.y - (tid.y % uint(groupsize));
int k = even;
int mid = even + uint(groupsize) / uint(2) - 1;
int odd = mid + 1;
int to = even + groupsize - 1;
while (even <= mid && odd <= to)
{
if (min_color(key[even], key[odd]))
{
if (tid.y == even) idy_sorted = k;
key_sorted[k++] = key[even++];
}
else
{
if (tid.y == odd) idy_sorted = k;
key_sorted[k++] = key[odd++];
}
}
#line 309
while (even <= mid)
{
if (tid.y == even) idy_sorted = k;
key_sorted[k++] = key[even++];
}
while (odd <= to)
{
if (tid.y == odd) idy_sorted = k;
key_sorted[k++] = key[odd++];
}
#line 320
int diff_sorted = (uint(idy_sorted)%uint(groupsize)) - (tid.y % (uint(groupsize) / uint(2)));
int pos1 = tid.y *uint(	640 ) / uint(	16 );
bool is_even = (tid.y%uint(groupsize)) < uint(groupsize) / uint(2);
if (is_even)
{
evenblock[idy_sorted + tid.x*	16 ] = pos1;
if (diff_sorted == 0)
{
oddblock[idy_sorted + tid.x*	16 ] = (tid.y - (tid.y%uint(groupsize)) + uint(groupsize) / uint(2))*uint(	640 ) / uint(	16 );
}
else
{
int odd_block_search_start = (tid.y - (tid.y%uint(groupsize)) + uint(groupsize) / uint(2) + diff_sorted - 1)*uint(	640 ) / uint(	16 );
for (int i2 = 0; i2 < 	640  / 	16 ; i2++)
{ 
oddblock[idy_sorted + tid.x*	16 ] = odd_block_search_start + i2;
if (min_color(key_sorted[idy_sorted], colortable[odd_block_search_start + i2 + tid.x*	640 ]))
{
break;
}
else
{
oddblock[idy_sorted + tid.x*	16 ] = odd_block_search_start + i2 + 1;
}
}
}
}
else
{
oddblock[idy_sorted + tid.x*	16 ] = pos1;
if (diff_sorted == 0)
{
evenblock[idy_sorted + tid.x*	16 ] = (tid.y - (tid.y%uint(groupsize)))*uint(	640 ) / uint(	16 );
}
else
{
int even_block_search_start = (tid.y - (tid.y%uint(groupsize)) + diff_sorted - 1)*uint(	640 ) / uint(	16 );
for (int i2 = 0; i2 < uint(	640 ) / uint(	16 ); i2++) {
evenblock[idy_sorted + tid.x*	16 ] = even_block_search_start + i2;
if (min_color(key_sorted[idy_sorted], colortable[even_block_search_start + i2 + tid.x*	640 ]))
{
break;
}
else
{
evenblock[idy_sorted + tid.x*	16 ] = even_block_search_start + i2 + 1;
}
}
}
}
#line 371
barrier();
int even_start, even_end, odd_start, odd_end;
even_start = evenblock[tid.y + tid.x*	16 ];
odd_start = oddblock[tid.y + tid.x*	16 ];
if ((tid.y + 1) % uint(groupsize) == 0)
{
even_end = (tid.y - (tid.y%uint(groupsize)) + uint(groupsize) / uint(2)) *uint(	640 ) / uint(	16 );
odd_end = (tid.y - (tid.y%uint(groupsize)) + groupsize) * uint(	640 ) / uint(	16 );
}
else
{
even_end = evenblock[tid.y + 1 + tid.x*	16 ];
odd_end = oddblock[tid.y + 1 + tid.x*	16 ];
}
#line 386
int even_counter = even_start;
int odd_counter = odd_start;
int cc = 0;
while (even_counter < even_end && odd_counter < odd_end)
{
if (min_color(colortable[even_counter + tid.x*	640 ], colortable[odd_counter + tid.x*	640 ])) {
sorted_array[cc++] = colortable[even_counter++ + tid.x*	640 ];
}
else {
sorted_array[cc++] = colortable[odd_counter++ + tid.x*	640 ];
}
}
while (even_counter < even_end)
{
sorted_array[cc++] = colortable[even_counter++ + tid.x*	640 ];
}
while (odd_counter < odd_end)
{
sorted_array[cc++] = colortable[odd_counter++ + tid.x*	640 ];
}
#line 407
barrier();
int sorted_array_size = cc;
int global_position = odd_start + even_start - (tid.y - (tid.y%uint(groupsize)) + uint(groupsize) / uint(2)) *uint(	640 ) / uint(	16 );
for (int w = 0; w < cc; w++)
{
colortable[global_position + w + tid.x*	640 ] = sorted_array[w];
}
}
barrier();
for (i = 0; i < uint(	640 ) / uint(	16 ); i++)
{
colortable[row + i + tid.x*	640 ].a = colortable[row + i + tid.x*	640 ].a % 1;
tex2Dstore(texColorSortStorage, float2(id.x, row + i), float4(colortable[row + i + tid.x*	640 ]));
}
}
#line 423
void half_color(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 fragment : SV_Target)
{
fragment = tex2D(ReShade::BackBuffer, texcoord);
}
#line 428
void downsample_color(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 fragment : SV_Target)
{
fragment = tex2D(ReShade::BackBuffer, texcoord);
float fragment_depth = ReShade::GetLinearizedDepth(texcoord);
fragment = inFocus(fragment, fragment_depth, texcoord) ? tex2D(SamplerColorSort, texcoord) : fragment;
fragment = (ShowSelectedHue*FilterColor) ? showHue(texcoord, fragment) : fragment;
}
#line 437
technique ColorSort
{
pass halfColor { VertexShader = PostProcessVS; PixelShader = half_color; RenderTarget = texHalfRes; }
pass sortColor { ComputeShader = sort_color<2, 	16 >; DispatchSizeX = 1500 / 2; DispatchSizeY = 1; }
pass downsampleColor { VertexShader = PostProcessVS; PixelShader = downsample_color; }
}
}

