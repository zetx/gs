//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float sstr;                        // Offset:    0 Size:     4
//   float cstr;                        // Offset:    4 Size:     4
//   float xstr;                        // Offset:    8 Size:     4 [unused]
//   float xrep;                        // Offset:   12 Size:     4 [unused]
//   float lstr;                        // Offset:   16 Size:     4
//   float pstr;                        // Offset:   20 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__ReShade__BackBufferTex       texture  float4          2d             t0      1 
// _Globals                          cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_POSITION              0   xyzw        0      POS   float       
// TEXCOORD                 0   xy          1     NONE   float   xy  
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_TARGET                0   xyzw        0   TARGET   float   xyzw
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[2], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 3
add r0.xyzw, v1.xyxy, l(0.000000, -0.000694, -0.000291, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r0.zw, r0.zwzz, t0.yzxw, s0
sample_indexable(texture2d)(float,float,float,float) r0.xy, r0.xyxx, t0.xwyz, s0
add r0.x, -r0.x, r0.y
add r0.y, -r0.z, r0.w
lt r0.z, l(0.000000), r0.y
lt r0.w, r0.y, l(0.000000)
iadd r0.z, -r0.z, r0.w
itof r0.z, r0.z
mul r0.w, cb0[0].x, l(0.003922)
mul r1.x, cb0[1].x, l(0.003922)
div r1.y, |r0.y|, |r1.x|
mul r0.yz, r0.yywy, r0.yyzy
log r1.y, r1.y
div r1.z, l(1.000000, 1.000000, 1.000000, 1.000000), cb0[1].y
mul r1.y, r1.y, r1.z
exp r1.y, r1.y
mul r0.z, r0.z, r1.y
add r1.y, cb0[0].x, l(0.100000)
mad r1.w, r1.y, l(0.000015), r0.y
div r0.y, r0.y, r1.w
mul r0.y, r0.y, r0.z
lt r0.z, l(0.000000), r0.x
lt r1.w, r0.x, l(0.000000)
iadd r0.z, -r0.z, r1.w
itof r0.z, r0.z
div r1.w, |r0.x|, |r1.x|
mul r0.xz, r0.xxwx, r0.xxzx
log r1.w, r1.w
mul r1.w, r1.w, r1.z
exp r1.w, r1.w
mul r0.z, r0.z, r1.w
mad r1.w, r1.y, l(0.000015), r0.x
div r0.x, r0.x, r1.w
mad r0.x, r0.z, r0.x, r0.y
add r2.xyzw, v1.xyxy, l(0.000291, 0.000000, 0.000000, 0.000694)
sample_indexable(texture2d)(float,float,float,float) r0.yz, r2.xyxx, t0.yxwz, s0
sample_indexable(texture2d)(float,float,float,float) r2.xy, r2.zwzz, t0.xwyz, s0
add r1.w, -r2.x, r2.y
add r0.y, -r0.y, r0.z
lt r0.z, l(0.000000), r0.y
lt r2.x, r0.y, l(0.000000)
iadd r0.z, -r0.z, r2.x
itof r0.z, r0.z
div r2.x, |r0.y|, |r1.x|
mul r0.yz, r0.yywy, r0.yyzy
log r2.x, r2.x
mul r2.x, r1.z, r2.x
exp r2.x, r2.x
mul r0.z, r0.z, r2.x
mad r2.x, r1.y, l(0.000015), r0.y
div r0.y, r0.y, r2.x
mad r0.x, r0.z, r0.y, r0.x
lt r0.y, l(0.000000), r1.w
lt r0.z, r1.w, l(0.000000)
iadd r0.y, -r0.y, r0.z
itof r0.y, r0.y
mul r0.y, r0.w, r0.y
div r0.z, |r1.w|, |r1.x|
mul r1.w, r1.w, r1.w
log r0.z, r0.z
mul r0.z, r0.z, r1.z
exp r0.z, r0.z
mul r0.y, r0.z, r0.y
mad r0.z, r1.y, l(0.000015), r1.w
div r0.z, r1.w, r0.z
mad r0.x, r0.y, r0.z, r0.x
sample_indexable(texture2d)(float,float,float,float) r2.xyzw, v1.xyxx, t0.xyzw, s0
add r0.y, -r2.x, r2.w
lt r0.z, l(0.000000), r0.y
lt r1.w, r0.y, l(0.000000)
iadd r0.z, -r0.z, r1.w
itof r0.z, r0.z
div r1.w, |r0.y|, |r1.x|
mul r0.yz, r0.yywy, r0.yyzy
log r1.w, r1.w
mul r1.w, r1.w, r1.z
exp r1.w, r1.w
mul r0.z, r0.z, r1.w
mad r1.w, r1.y, l(0.000015), r0.y
div r0.y, r0.y, r1.w
mul r1.w, r0.y, r0.z
mad r0.y, r0.z, r0.y, r2.w
mov o0.yz, r2.yyzy
mad r0.x, r1.w, l(2.000000), r0.x
add r2.xyzw, v1.xyxy, l(-0.000291, -0.000694, 0.000291, -0.000694)
sample_indexable(texture2d)(float,float,float,float) r2.zw, r2.zwzz, t0.yzxw, s0
sample_indexable(texture2d)(float,float,float,float) r2.xy, r2.xyxx, t0.xwyz, s0
add r0.z, -r2.x, r2.y
add r1.w, -r2.z, r2.w
lt r2.x, l(0.000000), r1.w
lt r2.y, r1.w, l(0.000000)
iadd r2.x, -r2.x, r2.y
itof r2.x, r2.x
mul r2.x, r0.w, r2.x
div r2.y, |r1.w|, |r1.x|
mul r1.w, r1.w, r1.w
log r2.y, r2.y
mul r2.y, r1.z, r2.y
exp r2.y, r2.y
mul r2.x, r2.y, r2.x
mad r2.y, r1.y, l(0.000015), r1.w
div r1.w, r1.w, r2.y
mul r1.w, r1.w, r2.x
lt r2.x, l(0.000000), r0.z
lt r2.y, r0.z, l(0.000000)
iadd r2.x, -r2.x, r2.y
itof r2.x, r2.x
mul r2.x, r0.w, r2.x
div r2.y, |r0.z|, |r1.x|
mul r0.z, r0.z, r0.z
log r2.y, r2.y
mul r2.y, r1.z, r2.y
exp r2.y, r2.y
mul r2.x, r2.y, r2.x
mad r2.y, r1.y, l(0.000015), r0.z
div r0.z, r0.z, r2.y
mad r0.z, r2.x, r0.z, r1.w
add r2.xyzw, v1.xyxy, l(-0.000291, 0.000694, 0.000291, 0.000694)
sample_indexable(texture2d)(float,float,float,float) r2.xy, r2.xyxx, t0.xwyz, s0
sample_indexable(texture2d)(float,float,float,float) r2.zw, r2.zwzz, t0.yzxw, s0
add r1.w, -r2.z, r2.w
add r2.x, -r2.x, r2.y
lt r2.y, l(0.000000), r2.x
lt r2.z, r2.x, l(0.000000)
iadd r2.y, -r2.y, r2.z
itof r2.y, r2.y
mul r2.y, r0.w, r2.y
div r2.z, |r2.x|, |r1.x|
mul r2.x, r2.x, r2.x
div r1.x, |r1.w|, |r1.x|
log r1.x, r1.x
mul r1.x, r1.x, r1.z
exp r1.x, r1.x
log r2.z, r2.z
mul r1.z, r1.z, r2.z
exp r1.z, r1.z
mul r1.z, r1.z, r2.y
mad r2.y, r1.y, l(0.000015), r2.x
div r2.x, r2.x, r2.y
mad r0.z, r1.z, r2.x, r0.z
lt r1.z, l(0.000000), r1.w
lt r2.x, r1.w, l(0.000000)
mul r1.w, r1.w, r1.w
iadd r1.z, -r1.z, r2.x
itof r1.z, r1.z
mul r0.w, r0.w, r1.z
mul r0.w, r1.x, r0.w
mad r1.x, r1.y, l(0.000015), r1.w
div r1.x, r1.w, r1.x
mad r0.z, r0.w, r1.x, r0.z
mad r0.x, r0.x, l(2.000000), r0.z
mul r0.x, r0.x, cb0[0].y
mad o0.xw, -r0.xxxx, l(0.062500, 0.000000, 0.000000, 0.062500), r0.yyyy
ret 
// Approximately 155 instruction slots used
