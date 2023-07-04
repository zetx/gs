//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   bool enable_weber;                 // Offset:    0 Size:     4
//   bool enable_sdeviation;            // Offset:    4 Size:     4
//   bool enable_depthbuffer;           // Offset:    8 Size:     4
//   float t1;                          // Offset:   12 Size:     4
//   float t2;                          // Offset:   16 Size:     4
//   float banding_depth;               // Offset:   20 Size:     4
//   float range;                       // Offset:   24 Size:     4
//   int iterations;                    // Offset:   28 Size:     4
//   int debug_output;                  // Offset:   32 Size:     4
//   int drandom;                       // Offset:   36 Size:     4
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
// __V__ReShade__DepthBufferTex      texture  float4          2d             t2      1 
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
dcl_constantbuffer CB0[3], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t2
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 9
sample_l_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.w, v1.xyxx, t2.yzwx, s0, l(0.000000)
mad r1.x, -r0.w, l(999.000000), l(1000.000000)
div r0.w, r0.w, r1.x
lt r0.w, r0.w, cb0[1].y
ine r1.x, cb0[0].z, l(0)
and r0.w, r0.w, r1.x
if_nz r0.w
  mov o0.xyz, r0.xyzx
  ret 
endif 
add r1.xy, v1.xyxx, l(1.000000, 1.000000, 0.000000, 0.000000)
itof r0.w, cb0[2].y
mad r0.w, r0.w, l(0.000031), l(1.000000)
mad r1.z, r1.x, l(34.000000), l(1.000000)
mul r1.x, r1.x, r1.z
mul r1.z, r1.x, l(289.000000)
ge r1.z, r1.z, -r1.z
movc r1.zw, r1.zzzz, l(0,0,289.000000,0.003460), l(0,0,-289.000000,-0.003460)
mul r1.x, r1.w, r1.x
frc r1.x, r1.x
mad r1.x, r1.z, r1.x, r1.y
mad r1.y, r1.x, l(34.000000), l(1.000000)
mul r1.x, r1.x, r1.y
mul r1.y, r1.x, l(289.000000)
ge r1.y, r1.y, -r1.y
movc r1.yz, r1.yyyy, l(0,289.000000,0.003460,0), l(0,-289.000000,-0.003460,0)
mul r1.x, r1.z, r1.x
frc r1.x, r1.x
mad r0.w, r1.y, r1.x, r0.w
mad r1.x, r0.w, l(34.000000), l(1.000000)
mul r0.w, r0.w, r1.x
mul r1.x, r0.w, l(289.000000)
ge r1.x, r1.x, -r1.x
movc r1.xy, r1.xxxx, l(289.000000,0.003460,0,0), l(-289.000000,-0.003460,0,0)
mul r0.w, r0.w, r1.y
frc r0.w, r0.w
mul r0.w, r0.w, r1.x
mad r1.x, r0.w, l(34.000000), l(1.000000)
mul r1.x, r0.w, r1.x
mul r1.y, r1.x, l(289.000000)
ge r1.y, r1.y, -r1.y
movc r1.yz, r1.yyyy, l(0,289.000000,0.003460,0), l(0,-289.000000,-0.003460,0)
mul r1.x, r1.z, r1.x
frc r1.x, r1.x
mul r1.x, r1.x, r1.y
mul r1.x, r1.x, l(0.024390)
frc r1.x, r1.x
mul r1.x, r1.x, l(6.283185)
sincos r1.x, r2.x, r1.x
ige r1.y, cb0[1].w, l(1)
mov r1.zw, l(0,0,0,0)
mov r3.x, r0.w
mov r3.y, l(1)
mov r3.z, r1.y
loop 
  breakc_z r3.z
  mul r3.w, r3.x, l(0.024390)
  frc r3.w, r3.w
  mul r3.w, r3.w, cb0[1].z
  itof r4.x, r3.y
  mul r3.w, r3.w, r4.x
  mul r1.zw, r3.wwww, l(0.000000, 0.000000, 0.000291, 0.000694)
  mad r3.w, r3.x, l(34.000000), l(1.000000)
  mul r3.w, r3.x, r3.w
  mul r4.x, r3.w, l(289.000000)
  ge r4.x, r4.x, -r4.x
  movc r4.xy, r4.xxxx, l(289.000000,0.003460,0,0), l(-289.000000,-0.003460,0,0)
  mul r3.w, r3.w, r4.y
  frc r3.w, r3.w
  mul r3.x, r3.w, r4.x
  iadd r3.y, r3.y, l(1)
  ige r3.z, cb0[1].w, r3.y
endloop 
mov r2.y, r1.x
mad r1.xy, r1.zwzz, r2.xyxx, v1.xyxx
sample_l_indexable(texture2d)(float,float,float,float) r3.xyz, r1.xyxx, t0.xyzw, s0, l(0.000000)
mad r1.xy, r1.zwzz, -r2.xyxx, v1.xyxx
sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r1.xyxx, t0.xyzw, s0, l(0.000000)
mov r2.zw, -r2.yyyx
mad r1.xyzw, r1.zwzw, r2.zxyw, v1.xyxy
sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r1.xyxx, t0.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t0.xyzw, s0, l(0.000000)
add r5.xyz, r0.xyzx, r3.xyzx
add r5.xyz, r4.xyzx, r5.xyzx
add r5.xyz, r2.xyzx, r5.xyzx
add r5.xyz, r1.xyzx, r5.xyzx
mul r6.xyz, r5.xyzx, l(0.200000, 0.200000, 0.200000, 0.000000)
mad r7.xyz, -r5.xyzx, l(0.200000, 0.200000, 0.200000, 0.000000), r0.xyzx
mad r8.xyz, -r5.xyzx, l(0.200000, 0.200000, 0.200000, 0.000000), r3.xyzx
add r7.xyz, |r7.xyzx|, |r8.xyzx|
mad r8.xyz, -r5.xyzx, l(0.200000, 0.200000, 0.200000, 0.000000), r4.xyzx
add r7.xyz, r7.xyzx, |r8.xyzx|
mad r8.xyz, -r5.xyzx, l(0.200000, 0.200000, 0.200000, 0.000000), r2.xyzx
add r7.xyz, r7.xyzx, |r8.xyzx|
mad r5.xyz, -r5.xyzx, l(0.200000, 0.200000, 0.200000, 0.000000), r1.xyzx
add r5.xyz, |r5.xyzx|, r7.xyzx
mul r5.xyz, r5.xyzx, l(0.200000, 0.200000, 0.200000, 0.000000)
div r5.xyz, r5.xyzx, r6.xyzx
add r6.xyz, -r0.xyzx, r3.xyzx
add r7.xyz, -r0.xyzx, r4.xyzx
mul r7.xyz, r7.xyzx, r7.xyzx
mad r6.xyz, r6.xyzx, r6.xyzx, r7.xyzx
add r7.xyz, -r0.xyzx, r2.xyzx
mad r6.xyz, r7.xyzx, r7.xyzx, r6.xyzx
add r7.xyz, -r0.xyzx, r1.xyzx
mad r6.xyz, r7.xyzx, r7.xyzx, r6.xyzx
mul r6.xyz, r6.xyzx, l(0.250000, 0.250000, 0.250000, 0.000000)
sqrt r6.xyz, r6.xyzx
ine r0.w, cb0[2].x, l(1)
itof r1.w, cb0[1].w
mul r2.w, r1.w, cb0[1].x
ge r5.xyz, r2.wwww, r5.xyzx
movc r5.xyz, cb0[0].xxxx, r5.xyzx, l(-1,-1,-1,0)
mul r1.w, r1.w, cb0[0].w
ge r6.xyz, r1.wwww, r6.xyzx
and r6.xyz, r5.xyzx, r6.xyzx
movc r5.xyz, cb0[0].yyyy, r6.xyzx, r5.xyzx
movc r5.xyz, r0.wwww, r5.xyzx, l(-1,-1,-1,0)
and r0.w, r5.y, r5.x
and r0.w, r5.z, r0.w
if_nz r0.w
  ieq r0.w, cb0[2].x, l(2)
  add r3.xyz, r3.xyzx, r4.xyzx
  add r2.xyz, r2.xyzx, r3.xyzx
  add r1.xyz, r1.xyzx, r2.xyzx
  mul r1.xyz, r1.xyzx, l(0.250000, 0.250000, 0.250000, 0.000000)
  movc r1.xyz, r0.wwww, l(0,1.000000,0,0), r1.xyzx
  dp2 r0.w, v1.xyxx, l(215.250000, 400.250031, 0.000000, 0.000000)
  frc r0.w, r0.w
  mov r1.w, l(0.001961)
  mad r2.xyz, r0.wwww, l(-0.003922, 0.003922, -0.003922, 0.000000), r1.wyww
  mov r1.y, l(-0.001961)
  add o0.xyz, r2.xyzx, r1.xyzx
  ret 
else 
  mov o0.xyz, r0.xyzx
  ret 
endif 
ret 
// Approximately 140 instruction slots used
