//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__BackBufferTex                texture  float4          2d             t0      1 
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
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 6
sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s0
add r1.xyzw, v1.xyxy, l(-0.000291, -0.000000, 0.000291, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r1.xyxx, t0.xyzw, s0
dp3 r0.w, r2.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t0.xyzw, s0
dp3 r1.x, r1.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
add r1.x, r1.x, r1.x
add r2.xyzw, v1.xyxy, l(-0.000000, -0.000694, 0.000000, 0.000694)
sample_indexable(texture2d)(float,float,float,float) r1.yzw, r2.xyxx, t0.wxyz, s0
dp3 r1.y, r1.yzwy, l(0.333000, 0.333000, 0.333000, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
dp3 r1.z, r2.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
add r1.z, r1.z, r1.z
mad r2.x, -r1.y, l(2.000000), r1.z
mad r2.y, -r0.w, l(2.000000), r1.x
mul r2.xy, r2.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000)
mov r2.z, -r2.y
dp2 r0.w, r2.xzxx, r2.xzxx
sqrt r0.w, r0.w
lt r0.w, r0.w, l(0.097249)
if_z r0.w
  add r3.xyzw, v1.xyxy, l(-0.000581, -0.000000, -0.000291, -0.000694)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r3.xyxx, t0.xyzw, s0
  dp3 r0.w, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  dp3 r1.y, r0.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r3.zwzz, t0.xyzw, s0
  dp3 r1.w, r3.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r1.yw, r1.yyyw, r1.yyyw
  add r3.xyzw, v1.xyxy, l(-0.000291, 0.000694, 0.000581, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r3.xyxx, t0.xyzw, s0
  dp3 r2.z, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r2.w, r2.z, r2.z
  mad r3.x, r2.z, l(2.000000), -r1.w
  mad r3.y, -r0.w, l(2.000000), r1.y
  mad r2.xy, r3.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r3.zwzz, t0.xyzw, s0
  dp3 r0.w, r3.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r3.xyzw, v1.xyxy, l(0.000291, -0.000694, 0.000291, 0.000694)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r3.xyxx, t0.xyzw, s0
  dp3 r2.z, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r3.x, r2.z, r2.z
  sample_indexable(texture2d)(float,float,float,float) r3.yzw, r3.zwzz, t0.wxyz, s0
  dp3 r3.y, r3.yzwy, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r4.x, r3.y, l(2.000000), -r3.x
  mad r4.y, r0.w, l(2.000000), -r1.y
  mad r2.xy, r4.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  add r4.xyzw, v1.xyxy, l(-0.000000, -0.001389, 0.000000, 0.001389)
  sample_indexable(texture2d)(float,float,float,float) r3.xzw, r4.xyxx, t0.xwyz, s0
  dp3 r0.w, r3.xzwx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r4.x, -r0.w, l(2.000000), r1.y
  mad r4.y, r2.z, l(2.000000), -r1.w
  mad r2.xy, r4.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  sample_indexable(texture2d)(float,float,float,float) r3.xzw, r4.zwzz, t0.xwyz, s0
  dp3 r0.w, r3.xzwx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r4.x, r0.w, l(2.000000), -r1.y
  mad r4.y, r3.y, l(2.000000), -r2.w
  mad r1.yw, r4.xxxy, l(0.000000, 0.500000, 0.000000, 0.500000), r2.xxxy
  add r2.xyzw, v1.xyxy, l(-0.000581, -0.000694, 0.000000, -0.000694)
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0
  dp3 r0.w, r3.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
  dp3 r2.x, r2.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r2.x, r2.x, r2.x
  add r3.xyzw, v1.xyxy, l(-0.000291, -0.001389, -0.000291, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r2.yzw, r3.xyxx, t0.wxyz, s0
  dp3 r2.y, r2.yzwy, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r3.zwzz, t0.xyzw, s0
  dp3 r2.z, r3.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r2.z, r2.z, r2.z
  mad r3.x, -r2.y, l(2.000000), r2.z
  mad r3.y, -r0.w, l(2.000000), r2.x
  mad r1.yw, r3.xxxy, l(0.000000, 0.500000, 0.000000, 0.500000), r1.yyyw
  add r3.xyzw, v1.xyxy, l(-0.000581, 0.000694, -0.000291, 0.001389)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r3.xyxx, t0.xyzw, s0
  dp3 r0.w, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r3.zwzz, t0.xyzw, s0
  dp3 r2.y, r3.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r3.x, r2.y, l(2.000000), -r2.z
  mad r3.y, -r0.w, l(2.000000), r1.z
  mad r1.yw, r3.xxxy, l(0.000000, 0.500000, 0.000000, 0.500000), r1.yyyw
  add r3.xyzw, v1.xyxy, l(0.000581, -0.000694, 0.000291, -0.001389)
  sample_indexable(texture2d)(float,float,float,float) r2.yzw, r3.xyxx, t0.wxyz, s0
  dp3 r0.w, r2.yzwy, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r2.yzw, r3.zwzz, t0.wxyz, s0
  dp3 r2.y, r2.yzwy, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r3.x, -r2.y, l(2.000000), r1.x
  mad r3.y, r0.w, l(2.000000), -r2.x
  mad r1.yw, r3.xxxy, l(0.000000, 0.500000, 0.000000, 0.500000), r1.yyyw
  add r2.xyzw, v1.xyxy, l(0.000581, 0.000694, 0.000291, 0.001389)
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0
  dp3 r0.w, r3.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
  dp3 r2.x, r2.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r2.x, r2.x, l(2.000000), -r1.x
  mad r2.y, r0.w, l(2.000000), -r1.z
  mad r1.xy, r2.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r1.ywyy
  mad r2.xyzw, r1.xyxy, l(0.000145, -0.000347, 0.000073, -0.000174), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0
  mul r3.xyz, r3.xyzx, l(0.125000, 0.125000, 0.125000, 0.000000)
  mad r3.xyz, r0.xyzx, l(0.250000, 0.250000, 0.250000, 0.000000), r3.xyzx
  mad r4.xyzw, -r1.xyxy, l(0.000145, -0.000347, 0.000073, -0.000174), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  mad r3.xyz, r5.xyzx, l(0.125000, 0.125000, 0.125000, 0.000000), r3.xyzx
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
  mad r2.xyz, r2.xyzx, l(0.125000, 0.125000, 0.125000, 0.000000), r3.xyzx
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r4.zwzz, t0.xyzw, s0
  mad r2.xyz, r3.xyzx, l(0.125000, 0.125000, 0.125000, 0.000000), r2.xyzx
  mad r1.zw, r1.xxxy, l(0.000000, 0.000000, 0.000291, -0.000694), v1.xxxy
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r1.zwzz, t0.xyzw, s0
  mad r2.xyz, r3.xyzx, l(0.125000, 0.125000, 0.125000, 0.000000), r2.xyzx
  mad r1.xy, -r1.xyxx, l(0.000291, -0.000694, 0.000000, 0.000000), v1.xyxx
  sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.xyxx, t0.xyzw, s0
  mad r0.xyz, r1.xyzx, l(0.125000, 0.125000, 0.125000, 0.000000), r2.xyzx
endif 
mov o0.xyz, r0.xyzx
mov o0.w, l(1.000000)
ret 
// Approximately 117 instruction slots used
