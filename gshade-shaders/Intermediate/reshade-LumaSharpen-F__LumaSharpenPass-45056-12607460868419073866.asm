//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float sharp_strength;              // Offset:    0 Size:     4
//   float sharp_clamp;                 // Offset:    4 Size:     4
//   int pattern;                       // Offset:    8 Size:     4
//   float offset_bias;                 // Offset:   12 Size:     4
//   bool show_sharpen;                 // Offset:   16 Size:     4
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
// SV_TARGET                0   xyz         0   TARGET   float   xyz 
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[2], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 8
sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s0
ieq r1.xyz, cb0[0].zzzz, l(1, 2, 3, 0)
if_z cb0[0].z
  mad r2.xyzw, cb0[0].wwww, l(0.000185, 0.000335, -0.000185, -0.000335), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
  add r2.xyz, r2.xyzx, r3.xyzx
  mul r2.xyz, r2.xyzx, l(0.500000, 0.500000, 0.500000, 0.000000)
  mul r3.xyz, cb0[0].xxxx, l(0.318900, 1.072800, 0.108300, 0.000000)
else 
  mul r3.xyz, cb0[0].xxxx, l(0.212600, 0.715200, 0.072200, 0.000000)
  mov r2.xyz, l(0,0,0,0)
endif 
if_nz r1.x
  mad r4.xyzw, cb0[0].wwww, l(0.000278, -0.000503, 0.000278, 0.000503), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  mad r6.xyzw, -cb0[0].wwww, l(0.000278, 0.000503, 0.000278, -0.000503), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r7.xyz, r6.xyxx, t0.xyzw, s0
  add r5.xyz, r5.xyzx, r7.xyzx
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  add r4.xyz, r4.xyzx, r5.xyzx
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r6.zwzz, t0.xyzw, s0
  add r4.xyz, r4.xyzx, r5.xyzx
  mul r2.xyz, r4.xyzx, l(0.250000, 0.250000, 0.250000, 0.000000)
endif 
if_nz r1.y
  mad r4.xyzw, cb0[0].wwww, l(0.000222, -0.001206, 0.000667, 0.000402), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r1.xyw, r4.xyxx, t0.xywz, s0
  mad r5.xyzw, -cb0[0].wwww, l(0.000667, 0.000402, 0.000222, -0.001206), v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r6.xyz, r5.xyxx, t0.xyzw, s0
  add r1.xyw, r1.xyxw, r6.xyxz
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  add r1.xyw, r1.xyxw, r4.xyxz
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r5.zwzz, t0.xyzw, s0
  add r1.xyw, r1.xyxw, r4.xyxz
  mul r2.xyz, r1.xywx, l(0.250000, 0.250000, 0.250000, 0.000000)
  mul r3.xyz, r3.xyzx, l(0.510000, 0.510000, 0.510000, 0.000000)
endif 
if_nz r1.z
  mov r1.xw, l(0.000278,0,0,-0.000503)
  mul r1.yz, cb0[0].wwww, l(0.000000, -0.001005, -0.000556, 0.000000)
  add r1.xyzw, r1.xyzw, v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r1.xyxx, t0.xyzw, s0
  sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t0.xyzw, s0
  add r1.xyz, r1.xyzx, r4.xyzx
  mul r4.xw, cb0[0].wwww, l(0.000556, 0.000000, 0.000000, 0.001005)
  mov r4.yz, l(0,0.000503,-0.000278,0)
  add r4.xyzw, r4.xyzw, v1.xyxy
  sample_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0
  add r1.xyz, r1.xyzx, r5.xyzx
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.zwzz, t0.xyzw, s0
  add r1.xyz, r1.xyzx, r4.xyzx
  mul r2.xyz, r1.xyzx, l(0.250000, 0.250000, 0.250000, 0.000000)
  mul r3.xyz, r3.xyzx, l(0.666000, 0.666000, 0.666000, 0.000000)
endif 
add r1.xyz, r0.xyzx, -r2.xyzx
div r0.w, l(0.500000), cb0[0].y
mul r2.xyz, r0.wwww, r3.xyzx
mov r1.w, l(1.000000)
mov r2.w, l(0.500000)
dp4_sat r0.w, r1.xyzw, r2.xyzw
dp2 r0.w, cb0[0].yyyy, r0.wwww
add r0.w, r0.w, -cb0[0].y
add r0.xyz, r0.wwww, r0.xyzx
mad_sat r0.w, r0.w, l(4.000000), l(0.500000)
movc_sat o0.xyz, cb0[1].xxxx, r0.wwww, r0.xyzx
ret 
// Approximately 67 instruction slots used
