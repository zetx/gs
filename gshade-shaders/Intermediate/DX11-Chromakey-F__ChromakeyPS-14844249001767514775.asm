//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float Threshold;                   // Offset:    0 Size:     4
//   bool RadialX;                      // Offset:    4 Size:     4
//   bool RadialY;                      // Offset:    8 Size:     4
//   int FOV;                           // Offset:   12 Size:     4
//   int CKPass;                        // Offset:   16 Size:     4
//   bool Floor;                        // Offset:   20 Size:     4
//   float FloorAngle;                  // Offset:   24 Size:     4
//   int Precision;                     // Offset:   28 Size:     4
//   int Color;                         // Offset:   32 Size:     4
//   float3 CustomColor;                // Offset:   36 Size:    12
//   bool AntiAliased;                  // Offset:   48 Size:     4
//   bool InvertDepth;                  // Offset:   52 Size:     4
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
dcl_constantbuffer CB0[4], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t2
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 5
switch cb0[2].x
  case l(0)
  mov r0.xyz, l(0,1.000000,0,0)
  break 
  case l(1)
  mov r0.xyz, l(1.000000,0,0,0)
  break 
  case l(2)
  mov r0.xyz, l(0,0,1.000000,0)
  break 
  case l(3)
  mov r0.xyz, l(0.070000,0.180000,0.720000,0)
  break 
  case l(4)
  mov r0.xyz, l(0.290000,0.840000,0.360000,0)
  break 
  case l(5)
  mov r0.xyz, cb0[2].yzwy
  break 
  default 
  mov r0.xyz, l(0,0,0,0)
  break 
endswitch 
if_nz cb0[3].y
  sample_l_indexable(texture2d)(float,float,float,float) r0.w, v1.xyxx, t2.yzwx, s0, l(0.000000)
  mad r1.x, -r0.w, l(999.000000), l(1000.000000)
  div r0.w, r0.w, r1.x
  add r0.w, -r0.w, l(1.000000)
else 
  sample_l_indexable(texture2d)(float,float,float,float) r1.x, v1.xyxx, t2.xyzw, s0, l(0.000000)
  mad r1.y, -r1.x, l(999.000000), l(1000.000000)
  div r0.w, r1.x, r1.y
endif 
itof r1.x, cb0[0].w
mul r1.x, r1.x, l(0.008727)
sincos r1.x, r2.x, r1.x
div r1.x, r1.x, r2.x
mul r1.y, r1.x, l(0.418605)
add r1.zw, v1.xxxy, l(0.000000, 0.000000, -0.500000, -0.500000)
mul r2.xz, r1.xxyx, r1.zzwz
mov r2.yw, l(0,1.000000,0,1.000000)
dp2 r1.x, r2.xyxx, r2.xyxx
sqrt r1.x, r1.x
mul r1.x, r0.w, r1.x
movc r0.w, cb0[0].y, r1.x, r0.w
dp2 r1.x, r2.zwzz, r2.zwzz
sqrt r1.x, r1.x
mul r1.x, r0.w, r1.x
movc r0.w, cb0[0].z, r1.x, r0.w
ge r1.x, r0.w, cb0[0].x
and r1.x, r1.x, l(0x3f800000)
deriv_rtx_coarse r1.y, r0.w
deriv_rty_coarse r1.z, r0.w
add r1.y, |r1.z|, |r1.y|
mad r1.z, -r1.y, l(0.500000), cb0[0].x
mad r1.y, r1.y, l(0.500000), cb0[0].x
add r1.y, -r1.z, r1.y
add r0.w, r0.w, -r1.z
div r1.y, l(1.000000, 1.000000, 1.000000, 1.000000), r1.y
mul_sat r0.w, r0.w, r1.y
mad r1.y, r0.w, l(-2.000000), l(3.000000)
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, r1.y
movc r0.w, cb0[3].x, r0.w, r1.x
if_nz cb0[1].y
  add r1.xyzw, v1.xyxy, l(-0.000000, -0.000694, 0.000291, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.x, v1.xyxx, t2.xyzw, s0, l(0.000000)
  mad r2.y, -r2.x, l(999.000000), l(1000.000000)
  div r2.x, r2.x, r2.y
  add r3.xz, v1.yyxy, l(-0.500000, 0.000000, -0.500000, 0.000000)
  mov r3.y, l(1.000000)
  mul r2.xyz, r2.xxxx, r3.xyzx
  sample_l_indexable(texture2d)(float,float,float,float) r1.x, r1.xyxx, t2.xyzw, s0, l(0.000000)
  mad r1.y, -r1.x, l(999.000000), l(1000.000000)
  div r1.x, r1.x, r1.y
  add r3.yz, v1.xxyx, l(0.000000, -0.500000, -0.500694, 0.000000)
  mov r3.x, l(1.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r1.y, r1.zwzz, t2.yxzw, s0, l(0.000000)
  mad r1.z, -r1.y, l(999.000000), l(1000.000000)
  div r1.y, r1.y, r1.z
  add r4.xz, v1.yyxy, l(-0.500000, 0.000000, -0.499709, 0.000000)
  mov r4.y, l(1.000000)
  mad r1.xzw, -r3.xxyz, r1.xxxx, r2.yyzx
  mad r2.xyz, -r4.xyzx, r1.yyyy, r2.xyzx
  mul r3.xyz, r1.xzwx, r2.xyzx
  mad r1.xyz, r1.wxzw, r2.yzxy, -r3.xyzx
  dp3 r1.x, r1.xyzx, r1.xyzx
  rsq r1.x, r1.x
  mul r1.x, r1.x, r1.y
  mad r1.x, r1.x, l(0.500000), l(0.500000)
  itof r1.y, cb0[1].w
  mul r1.x, r1.y, r1.x
  round_ne r1.x, r1.x
  div r1.x, r1.x, r1.y
  mul r1.z, r1.y, cb0[1].z
  round_ne r1.z, r1.z
  div r1.y, r1.z, r1.y
  eq r1.x, r1.y, r1.x
  movc r0.w, r1.x, l(1.000000), r0.w
endif 
add r1.x, -r0.w, l(1.000000)
movc r0.w, cb0[1].x, r1.x, r0.w
sample_indexable(texture2d)(float,float,float,float) r1.xyz, v1.xyxx, t0.xyzw, s0
add r0.xyz, r0.xyzx, -r1.xyzx
mad o0.xyz, r0.wwww, r0.xyzx, r1.xyzx
ret 
// Approximately 106 instruction slots used
