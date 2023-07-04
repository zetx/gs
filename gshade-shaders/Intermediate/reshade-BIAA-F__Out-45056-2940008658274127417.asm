//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float AA_Power;                    // Offset:    0 Size:     4
//   int View_Mode;                     // Offset:    4 Size:     4
//   float Mask_Adjust;                 // Offset:    8 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__BackBufferTex                texture  float4          2d             t0      1 
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
dcl_constantbuffer CB0[1], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 7
sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s0
add r1.xyzw, v1.xyxy, l(-0.000781, -0.000000, 0.000781, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r1.xyxx, t0.xyzw, s0
dp3 r0.w, r2.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t0.xyzw, s0
dp3 r1.x, r1.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
add r1.x, r1.x, r1.x
add r2.xyzw, v1.xyxy, l(-0.000000, -0.001387, 0.000000, 0.001387)
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
mul r1.y, cb0[0].z, l(-8.965784)
exp r1.y, r1.y
lt r0.w, r0.w, r1.y
and r1.y, r0.w, l(0x3f800000)
if_nz r0.w
  mov r3.xyz, r0.xyzx
else 
  add r0.w, -cb0[0].x, l(1.000000)
  add r4.xyzw, v1.xyxy, l(-0.001561, -0.000000, -0.000781, -0.001387)
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  dp3 r1.w, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  dp3 r2.z, r0.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  dp3 r2.w, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r2.zw, r2.zzzw, r2.zzzw
  add r4.xyzw, v1.xyxy, l(-0.000781, 0.001387, 0.001561, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  dp3 r3.w, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r4.x, r3.w, r3.w
  mad r5.x, r3.w, l(2.000000), -r2.w
  mad r5.y, -r1.w, l(2.000000), r2.z
  mad r2.xy, r5.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  sample_indexable(texture2d)(float,float,float,float) r4.yzw, r4.zwzz, t0.wxyz, s0
  dp3 r1.w, r4.yzwy, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r5.xyzw, v1.xyxy, l(0.000781, -0.001387, 0.000781, 0.001387)
  sample_indexable(texture2d)(float,float,float,float) r4.yzw, r5.xyxx, t0.wxyz, s0
  dp3 r3.w, r4.yzwy, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r4.y, r3.w, r3.w
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r5.zwzz, t0.xyzw, s0
  dp3 r4.z, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r5.x, r4.z, l(2.000000), -r4.y
  mad r5.y, r1.w, l(2.000000), -r2.z
  mad r2.xy, r5.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  add r5.xyzw, v1.xyxy, l(-0.000000, -0.002774, 0.000000, 0.002774)
  sample_indexable(texture2d)(float,float,float,float) r6.xyz, r5.xyxx, t0.xyzw, s0
  dp3 r1.w, r6.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r5.x, -r1.w, l(2.000000), r2.z
  mad r5.y, r3.w, l(2.000000), -r2.w
  mad r2.xy, r5.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r5.zwzz, t0.xyzw, s0
  dp3 r1.w, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r5.x, r1.w, l(2.000000), -r2.z
  mad r5.y, r4.z, l(2.000000), -r4.x
  mad r2.xy, r5.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  add r4.xyzw, v1.xyxy, l(-0.001561, -0.001387, 0.000000, -0.001387)
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  dp3 r1.w, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  dp3 r2.z, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r2.z, r2.z, r2.z
  add r4.xyzw, v1.xyxy, l(-0.000781, -0.002774, -0.000781, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  dp3 r2.w, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  dp3 r3.w, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  add r3.w, r3.w, r3.w
  mad r4.x, -r2.w, l(2.000000), r3.w
  mad r4.y, -r1.w, l(2.000000), r2.z
  mad r2.xy, r4.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  add r4.xyzw, v1.xyxy, l(-0.001561, 0.001387, -0.000781, 0.002774)
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  dp3 r1.w, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  dp3 r2.w, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r4.x, r2.w, l(2.000000), -r3.w
  mad r4.y, -r1.w, l(2.000000), r1.z
  mad r2.xy, r4.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  add r4.xyzw, v1.xyxy, l(0.001561, -0.001387, 0.000781, -0.002774)
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  dp3 r1.w, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  dp3 r2.w, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r4.x, -r2.w, l(2.000000), r1.x
  mad r4.y, r1.w, l(2.000000), -r2.z
  mad r2.xy, r4.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), r2.xyxx
  add r4.xyzw, v1.xyxy, l(0.001561, 0.001387, 0.000781, 0.002774)
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  dp3 r1.w, r5.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  dp3 r2.z, r4.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  mad r4.x, r2.z, l(2.000000), -r1.x
  mad r4.y, r1.w, l(2.000000), -r1.z
  mad r1.xz, r4.xxyx, l(0.500000, 0.000000, 0.500000, 0.000000), r2.xxyx
  mul r1.w, cb0[0].x, l(0.166667)
  mad r2.xyzw, r1.xzxz, l(0.000390, -0.000693, 0.000195, -0.000347), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r2.xyxx, t0.xyzw, s0
  mul r4.xyz, r1.wwww, r4.xyzx
  mad r4.xyz, r0.xyzx, r0.wwww, r4.xyzx
  mad r5.xyzw, -r1.xzxz, l(0.000390, -0.000693, 0.000195, -0.000347), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r6.xyz, r5.xyxx, t0.xyzw, s0
  mad r4.xyz, r6.xyzx, r1.wwww, r4.xyzx
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
  mad r2.xyz, r2.xyzx, r1.wwww, r4.xyzx
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r5.zwzz, t0.xyzw, s0
  mad r2.xyz, r4.xyzx, r1.wwww, r2.xyzx
  mad r4.xy, r1.xzxx, l(0.000781, -0.001387, 0.000000, 0.000000), v1.xyxx
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.xyxx, t0.xyzw, s0
  mad r2.xyz, r4.xyzx, r1.wwww, r2.xyzx
  mad r1.xz, -r1.xxzx, l(0.000781, 0.000000, -0.001387, 0.000000), v1.xxyx
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r1.xzxx, t0.xyzw, s0
  mad r3.xyz, r4.xyzx, r1.wwww, r2.xyzx
endif 
add r0.xyz, r0.xyzx, l(-1.000000, -0.000000, -1.000000, 0.000000)
mad r0.xyz, r1.yyyy, r0.xyzx, l(1.000000, 0.000000, 1.000000, 0.000000)
movc o0.xyz, cb0[0].yyyy, r0.xyzx, r3.xyzx
mov o0.w, l(1.000000)
ret 
// Approximately 126 instruction slots used
