//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float Strength;                    // Offset:    0 Size:     4
//   float Offset;                      // Offset:    4 Size:     4
//   float Clamp;                       // Offset:    8 Size:     4
//   bool UseMask;                      // Offset:   12 Size:     4
//   bool DepthMask;                    // Offset:   16 Size:     4
//   int DepthMaskContrast;             // Offset:   20 Size:     4
//   int Coefficient;                   // Offset:   24 Size:     4
//   bool Preview;                      // Offset:   28 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __s1                              sampler      NA          NA             s1      1 
// __srgbV__ReShade__BackBufferTex    texture  float4          2d             t1      1 
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
dcl_constantbuffer CB0[2], immediateIndexed
dcl_sampler s0, mode_default
dcl_sampler s1, mode_default
dcl_resource_texture2d (float,float,float,float) t1
dcl_resource_texture2d (float,float,float,float) t2
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 7
sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t1.xyzw, s1
if_nz cb0[0].w
  mad r1.xy, v1.xyxx, l(2.000000, 2.000000, 0.000000, 0.000000), l(-1.000000, -1.000000, 0.000000, 0.000000)
  dp2 r0.w, r1.xyxx, r1.xyxx
  sqrt r0.w, r0.w
  add r0.w, -r0.w, l(1.000000)
  min r1.x, r0.w, l(0.500000)
  max r0.w, r0.w, l(0.500000)
  add r1.y, r0.w, r0.w
  mad r1.x, r1.x, r1.x, r1.y
  mad r0.w, -r0.w, r0.w, r1.x
  mad r0.w, r0.w, l(2.000000), l(-1.500000)
  mul r0.w, r0.w, cb0[0].x
  ge r1.x, l(0.000000), r0.w
  if_nz r1.x
    mov o0.xyz, r0.xyzx
    ret 
  endif 
else 
  mov r0.w, cb0[0].x
endif 
movc r1.xyz, cb0[1].zzzz, l(0.299000,0.587000,0.114000,0), l(0.212600,0.715200,0.072200,0)
if_nz cb0[1].x
  mad r2.xy, cb0[0].yyyy, l(0.000694, 0.000291, 0.000000, 0.000000), l(0.000694, 0.000291, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r1.w, v1.xyxx, t2.yzwx, s0, l(0.000000)
  mad r2.z, -r1.w, l(999.000000), l(1000.000000)
  div r1.w, r1.w, r2.z
  mad r3.xy, cb0[0].yyyy, l(0.000694, 0.000291, 0.000000, 0.000000), v1.yxyy
  mad r4.xy, -cb0[0].yyyy, l(0.000694, 0.000291, 0.000000, 0.000000), v1.yxyy
  add r5.xy, r2.xyxx, v1.yxyy
  add r2.xy, -r2.xyxx, v1.yxyy
  mov r3.zw, v1.xxxy
  sample_indexable(texture2d)(float,float,float,float) r6.xyz, r3.zxzz, t1.xyzw, s1
  dp3 r6.x, r6.xyzx, r1.xyzx
  sample_l_indexable(texture2d)(float,float,float,float) r3.x, r3.zxzz, t2.xyzw, s0, l(0.000000)
  mad r3.z, -r3.x, l(999.000000), l(1000.000000)
  div r3.x, r3.x, r3.z
  mov r5.zw, v1.xxxy
  sample_l_indexable(texture2d)(float,float,float,float) r3.z, r5.zxzz, t2.yzxw, s0, l(0.000000)
  mad r5.x, -r3.z, l(999.000000), l(1000.000000)
  div r3.z, r3.z, r5.x
  add r3.x, r3.z, r3.x
  mov r4.zw, v1.xxxy
  sample_indexable(texture2d)(float,float,float,float) r6.yzw, r4.zxzz, t1.wxyz, s1
  dp3 r3.z, r6.yzwy, r1.xyzx
  add r3.z, r3.z, r6.x
  sample_l_indexable(texture2d)(float,float,float,float) r4.x, r4.zxzz, t2.xyzw, s0, l(0.000000)
  mad r4.z, -r4.x, l(999.000000), l(1000.000000)
  div r4.x, r4.x, r4.z
  mov r2.zw, v1.xxxy
  sample_l_indexable(texture2d)(float,float,float,float) r2.x, r2.zxzz, t2.xyzw, s0, l(0.000000)
  mad r2.z, -r2.x, l(999.000000), l(1000.000000)
  div r2.x, r2.x, r2.z
  add r2.x, r2.x, r4.x
  sample_indexable(texture2d)(float,float,float,float) r6.xyz, r3.ywyy, t1.xyzw, s1
  dp3 r2.z, r6.xyzx, r1.xyzx
  add r2.xz, r2.xxzx, r3.xxzx
  sample_l_indexable(texture2d)(float,float,float,float) r3.x, r3.ywyy, t2.xyzw, s0, l(0.000000)
  mad r3.y, -r3.x, l(999.000000), l(1000.000000)
  div r3.x, r3.x, r3.y
  sample_l_indexable(texture2d)(float,float,float,float) r3.y, r5.ywyy, t2.yxzw, s0, l(0.000000)
  mad r3.z, -r3.y, l(999.000000), l(1000.000000)
  div r3.y, r3.y, r3.z
  add r3.x, r3.y, r3.x
  add r2.x, r2.x, r3.x
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, r4.ywyy, t1.xyzw, s1
  dp3 r3.x, r3.xyzx, r1.xyzx
  add r2.z, r2.z, r3.x
  sample_l_indexable(texture2d)(float,float,float,float) r3.x, r4.ywyy, t2.xyzw, s0, l(0.000000)
  mad r3.y, -r3.x, l(999.000000), l(1000.000000)
  div r3.x, r3.x, r3.y
  sample_l_indexable(texture2d)(float,float,float,float) r2.y, r2.ywyy, t2.yxzw, s0, l(0.000000)
  mad r2.w, -r2.y, l(999.000000), l(1000.000000)
  div r2.y, r2.y, r2.w
  add r2.y, r2.y, r3.x
  add r2.x, r2.y, r2.x
  dp3 r2.y, r0.xyzx, r1.xyzx
  mad r2.y, r2.z, l(0.250000), -r2.y
  mul r2.y, r2.y, l(0.500000)
  mad r1.w, -r2.x, l(0.125000), r1.w
  add r1.w, r1.w, l(1.000000)
  min r2.x, r1.w, l(1.000000)
  add r2.x, r2.x, l(1.000000)
  max r1.w, r1.w, l(1.000000)
  add r1.w, -r1.w, r2.x
  itof r2.x, cb0[1].y
  mad r1.w, r2.x, r1.w, l(1.000000)
  add_sat r1.w, -r2.x, r1.w
  mul r2.x, r0.w, r1.w
  mad r2.x, r2.x, -r2.y, l(0.500000)
  ne r2.y, cb0[0].z, l(1.000000)
  add r2.z, -cb0[0].z, l(1.000000)
  max r2.z, r2.z, r2.x
  min r2.z, r2.z, cb0[0].z
  movc r2.x, r2.y, r2.z, r2.x
  if_nz cb0[1].w
    mad r2.y, r2.x, r1.w, -r2.x
    mad r3.yz, r2.yyyy, l(0.000000, 0.500000, 0.500000, 0.000000), r2.xxxx
    add r2.y, -r2.x, l(1.000000)
    mad r3.x, -r1.w, r2.y, l(1.000000)
    log r2.yzw, |r3.xxyz|
    mul r2.yzw, r2.yyzw, l(0.000000, 2.200000, 2.200000, 2.200000)
    exp o0.xyz, r2.yzwy
    ret 
  endif 
  min r2.yzw, r0.xxyz, l(0.000000, 0.500000, 0.500000, 0.500000)
  min r1.w, r2.x, l(0.500000)
  max r3.xyz, r0.xyzx, l(0.500000, 0.500000, 0.500000, 0.000000)
  max r2.x, r2.x, l(0.500000)
  mad r2.yzw, r2.yyzw, r1.wwww, r3.xxyz
  add r2.yzw, r2.xxxx, r2.yyzw
  mad r2.xyz, -r3.xyzx, r2.xxxx, r2.yzwy
  mad o0.xyz, r2.xyzx, l(2.000000, 2.000000, 2.000000, 0.000000), l(-1.500000, -1.500000, -1.500000, 0.000000)
  ret 
else 
  mad r2.xy, cb0[0].yyyy, l(0.000694, 0.000291, 0.000000, 0.000000), v1.yxyy
  mad r3.xy, -cb0[0].yyyy, l(0.000694, 0.000291, 0.000000, 0.000000), v1.yxyy
  mov r2.zw, v1.xxxy
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r2.zxzz, t1.xyzw, s1
  dp3 r1.w, r4.xyzx, r1.xyzx
  mov r3.zw, v1.xxxy
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, r3.zxzz, t1.xyzw, s1
  dp3 r2.x, r4.xyzx, r1.xyzx
  add r1.w, r1.w, r2.x
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.ywyy, t1.xyzw, s1
  dp3 r2.x, r2.xyzx, r1.xyzx
  add r1.w, r1.w, r2.x
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, r3.ywyy, t1.xyzw, s1
  dp3 r2.x, r2.xyzx, r1.xyzx
  add r1.w, r1.w, r2.x
  dp3 r1.x, r0.xyzx, r1.xyzx
  mad r1.x, r1.w, l(0.250000), -r1.x
  mul r1.x, r1.x, l(0.500000)
  mad r0.w, r0.w, -r1.x, l(0.500000)
  ne r1.x, cb0[0].z, l(1.000000)
  add r1.y, -cb0[0].z, l(1.000000)
  max r1.y, r0.w, r1.y
  min r1.y, r1.y, cb0[0].z
  movc r0.w, r1.x, r1.y, r0.w
  if_nz cb0[1].w
    log r1.x, |r0.w|
    mul r1.x, r1.x, l(2.200000)
    exp o0.xyz, r1.xxxx
    ret 
  else 
    min r1.xyz, r0.xyzx, l(0.500000, 0.500000, 0.500000, 0.000000)
    min r1.w, r0.w, l(0.500000)
    max r0.xyz, r0.xyzx, l(0.500000, 0.500000, 0.500000, 0.000000)
    max r0.w, r0.w, l(0.500000)
    mad r1.xyz, r1.xyzx, r1.wwww, r0.xyzx
    add r1.xyz, r0.wwww, r1.xyzx
    mad r0.xyz, -r0.xyzx, r0.wwww, r1.xyzx
    mad o0.xyz, r0.xyzx, l(2.000000, 2.000000, 2.000000, 0.000000), l(-1.500000, -1.500000, -1.500000, 0.000000)
    ret 
  endif 
endif 
ret 
// Approximately 157 instruction slots used
