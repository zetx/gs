//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float fRBM_BlurWidthPixels;        // Offset:    0 Size:     4
//   int iRBM_SampleCount;              // Offset:    4 Size:     4
//   float fRBM_ReliefHeight;           // Offset:    8 Size:     4
//   float fRBM_FresnelReflectance;     // Offset:   12 Size:     4
//   float fRBM_FresnelMult;            // Offset:   16 Size:     4
//   float fRBM_LowerThreshold;         // Offset:   20 Size:     4
//   float fRBM_UpperThreshold;         // Offset:   24 Size:     4
//   float fRBM_ColorMask_Red;          // Offset:   28 Size:     4
//   float fRBM_ColorMask_Orange;       // Offset:   32 Size:     4
//   float fRBM_ColorMask_Yellow;       // Offset:   36 Size:     4
//   float fRBM_ColorMask_Green;        // Offset:   40 Size:     4
//   float fRBM_ColorMask_Cyan;         // Offset:   44 Size:     4
//   float fRBM_ColorMask_Blue;         // Offset:   48 Size:     4
//   float fRBM_ColorMask_Magenta;      // Offset:   52 Size:     4
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
// SV_TARGET                0   xyzw        0   TARGET   float   xyzw
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[4], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t2
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 7
sample_l_indexable(texture2d)(float,float,float,float) r0.x, v1.xyxx, t2.xyzw, s0, l(0.000000)
mad r0.y, -r0.x, l(999.000000), l(1000.000000)
div r0.x, r0.x, r0.y
mul r1.z, r0.x, l(1000.000000)
mad r0.yz, v1.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
mul r1.xy, r1.zzzz, r0.yzyy
add r2.xyzw, v1.xyxy, l(0.000291, 0.000000, -0.000291, 0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.y, r2.xyxx, t2.yxzw, s0, l(0.000000)
mad r0.z, -r0.y, l(999.000000), l(1000.000000)
div r0.y, r0.y, r0.z
mul r3.y, r0.y, l(1000.000000)
mad r4.xyzw, r2.xyzw, l(2.000000, 2.000000, 2.000000, 2.000000), l(-1.000000, -1.000000, -1.000000, -1.000000)
mul r3.xz, r3.yyyy, r4.yyxy
add r0.yzw, -r1.yyzx, r3.xxyz
sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.zwzz, t2.yzwx, s0, l(0.000000)
mad r2.x, -r1.w, l(999.000000), l(1000.000000)
div r1.w, r1.w, r2.x
mul r2.y, r1.w, l(1000.000000)
mul r2.xz, r2.yyyy, r4.wwzw
add r2.xyz, r1.yzxy, -r2.xyzx
add r3.xyzw, v1.xyxy, l(0.000000, 0.000694, 0.000000, -0.000694)
sample_l_indexable(texture2d)(float,float,float,float) r1.w, r3.xyxx, t2.yzwx, s0, l(0.000000)
mad r2.w, -r1.w, l(999.000000), l(1000.000000)
div r1.w, r1.w, r2.w
mul r4.x, r1.w, l(1000.000000)
mad r5.xyzw, r3.xyzw, l(2.000000, 2.000000, 2.000000, 2.000000), l(-1.000000, -1.000000, -1.000000, -1.000000)
mul r4.yz, r4.xxxx, r5.xxyx
add r4.xyz, -r1.zxyz, r4.xyzx
sample_l_indexable(texture2d)(float,float,float,float) r1.w, r3.zwzz, t2.yzwx, s0, l(0.000000)
mad r2.w, -r1.w, l(999.000000), l(1000.000000)
div r1.w, r1.w, r2.w
mul r3.x, r1.w, l(1000.000000)
mul r3.yz, r3.xxxx, r5.zzwz
add r3.xyz, r1.zxyz, -r3.xyzx
lt r1.w, |r2.y|, |r0.z|
and r1.w, r1.w, l(0x3f800000)
add r2.xyz, -r0.yzwy, r2.xyzx
mad r0.yzw, r1.wwww, r2.xxyz, r0.yyzw
lt r1.w, |r3.x|, |r4.x|
and r1.w, r1.w, l(0x3f800000)
add r2.xyz, -r4.xyzx, r3.xyzx
mad r2.xyz, r1.wwww, r2.xyzx, r4.xyzx
mul r3.xyz, r0.yzwy, r2.xyzx
mad r0.yzw, r2.zzxy, r0.zzwy, -r3.xxyz
dp3 r1.w, r0.yzwy, r0.yzwy
rsq r1.w, r1.w
mul r0.yzw, r0.yyzw, r1.wwww
div r2.xyz, l(0.000003, 0.000007, 0.000200, 0.000000), r0.xxxx
add r1.w, r2.z, l(0.100000)
mov r2.w, l(0)
add r3.xyzw, r2.xwwy, v1.xyxy
sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r3.xyxx, t0.xyzw, s0, l(0.000000)
dp3 r2.z, r4.xyzx, l(0.299000, 0.587000, 0.114000, 0.000000)
mul r2.z, r1.w, r2.z
add r4.xyzw, -r2.xwwy, v1.xyxy
sample_l_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0, l(0.000000)
dp3 r2.w, r5.xyzx, l(0.299000, 0.587000, 0.114000, 0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r5.xyz, r3.zwzz, t0.xyzw, s0, l(0.000000)
dp3 r5.x, r5.xyzx, l(0.299000, 0.587000, 0.114000, 0.000000)
mul r5.x, r1.w, r5.x
sample_l_indexable(texture2d)(float,float,float,float) r5.yzw, r4.zwzz, t0.wxyz, s0, l(0.000000)
dp3 r5.y, r5.yzwy, l(0.299000, 0.587000, 0.114000, 0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r3.x, r3.xyxx, t2.xyzw, s0, l(0.000000)
mad r3.y, -r3.x, l(999.000000), l(1000.000000)
div r3.x, r3.x, r3.y
sample_l_indexable(texture2d)(float,float,float,float) r3.y, r4.xyxx, t2.yxzw, s0, l(0.000000)
mad r4.x, -r3.y, l(999.000000), l(1000.000000)
div r3.y, r3.y, r4.x
sample_l_indexable(texture2d)(float,float,float,float) r3.z, r3.zwzz, t2.yzxw, s0, l(0.000000)
mad r3.w, -r3.z, l(999.000000), l(1000.000000)
div r3.z, r3.z, r3.w
sample_l_indexable(texture2d)(float,float,float,float) r3.w, r4.zwzz, t2.yzwx, s0, l(0.000000)
mad r4.x, -r3.w, l(999.000000), l(1000.000000)
div r3.w, r3.w, r4.x
add r3.xz, -r3.xxzx, r3.yywy
mov r3.xy, |r3.xzxx|
mad r3.xy, -r3.xyxx, l(1000.000000, 1000.000000, 0.000000, 0.000000), l(1.000000, 1.000000, 0.000000, 0.000000)
max r3.xy, r3.xyxx, l(0.000000, 0.000000, 0.000000, 0.000000)
mad r2.z, r2.w, r1.w, -r2.z
add r2.xy, r2.xyxx, r2.xyxx
div r2.x, r2.z, r2.x
mul r4.z, r3.x, r2.x
mad r1.w, r5.y, r1.w, -r5.x
div r1.w, r1.w, r2.y
mul r4.w, r3.y, r1.w
mov r4.xy, l(1.000000,1.000000,0,0)
dp3 r1.w, r4.yzwy, r4.yzwy
rsq r1.w, r1.w
mul r2.xyzw, r1.wwww, r4.xyzw
mul r3.xyzw, r0.yzww, r2.xyzw
add r3.xy, r3.zwzz, r3.xyxx
mul r3.z, r0.w, r2.y
dp3 r1.w, r3.xyzx, r3.xyzx
rsq r1.w, r1.w
mad r2.xyz, r3.xyzx, r1.wwww, -r0.yzwy
mad r0.yzw, cb0[0].zzzz, r2.xxyz, r0.yyzw
dp3 r1.w, r0.yzwy, r0.yzwy
rsq r1.w, r1.w
mul r0.yzw, r0.yyzw, r1.wwww
dp3 r1.w, r1.xyzx, r1.xyzx
rsq r1.w, r1.w
mul r1.xyz, r1.wwww, r1.xyzx
sample_indexable(texture2d)(float,float,float,float) r2.xyz, v1.xyxx, t0.xyzw, s0
itof r1.w, cb0[0].y
ge r2.w, r1.w, l(1.000000)
mul r3.xy, r0.yzyy, l(0.000291, 0.000694, 0.000000, 0.000000)
add r3.z, cb0[1].z, l(0.000010)
add r3.z, r3.z, -cb0[1].y
div r3.z, l(1.000000, 1.000000, 1.000000, 1.000000), r3.z
mov r4.xyz, l(0,0,0,0)
mov r3.w, l(1.000000)
mov r4.w, r2.w
loop 
  breakc_z r4.w
  mul r5.xy, r3.wwww, r3.xyxx
  div r5.xy, r5.xyxx, r1.wwww
  mad r5.xy, r5.xyxx, cb0[0].xxxx, v1.xyxx
  sample_l_indexable(texture2d)(float,float,float,float) r6.xyz, r5.xyxx, t0.xyzw, s0, l(0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r5.x, r5.xyxx, t2.xyzw, s0, l(0.000000)
  mad r5.y, -r5.x, l(999.000000), l(1000.000000)
  div r5.x, r5.x, r5.y
  add r5.x, r0.x, -r5.x
  add r5.x, r5.x, l(-0.005000)
  mul_sat r5.x, r5.x, l(-200.000000)
  mad r5.y, r5.x, l(-2.000000), l(3.000000)
  mul r5.x, r5.x, r5.x
  mul r5.x, r5.x, r5.y
  dp3 r5.y, r6.xyzx, l(0.299000, 0.587000, 0.114000, 0.000000)
  add r5.y, r5.y, -cb0[1].y
  mul_sat r5.y, r3.z, r5.y
  mad r5.z, r5.y, l(-2.000000), l(3.000000)
  mul r5.y, r5.y, r5.y
  mul r5.y, r5.y, r5.z
  mul r5.x, r5.y, r5.x
  add r5.yzw, -r2.xxyz, r6.xxyz
  mad r5.xyz, r5.xxxx, r5.yzwy, r2.xyzx
  add r4.xyz, r4.xyzx, r5.xyzx
  add r3.w, r3.w, l(1.000000)
  ge r4.w, r1.w, r3.w
endloop 
div r3.xyz, r4.xyzx, r1.wwww
dp3 r0.x, -r1.xyzx, r0.yzwy
add r0.x, -r0.x, l(1.000000)
mul r0.y, r0.x, r0.x
mul r0.y, r0.y, r0.y
mul r0.z, r0.y, r0.x
mad r0.x, -r0.x, r0.y, l(1.000000)
mad_sat r0.x, cb0[0].w, r0.x, r0.z
mul r0.x, r0.x, cb0[1].x
lt r0.y, r2.y, r2.z
mov r1.xy, r2.zyzz
mov r1.zw, l(0,0,-1.000000,0.666667)
mov r4.xy, r1.yxyy
mov r4.zw, l(0,0,0,-0.333333)
movc r1.xyzw, r0.yyyy, r1.xyzw, r4.xyzw
lt r0.y, r2.x, r1.x
mov r4.z, r2.x
mov r4.xyw, r1.xwxz
movc r0.yzw, r0.yyyy, r4.xxyz, r4.zzwx
min r1.x, r1.y, r0.w
add r1.x, r0.y, -r1.x
add r0.w, -r1.y, r0.w
mad r1.y, r1.x, l(6.000000), l(0.000000)
div r0.w, r0.w, r1.y
add r0.z, r0.w, r0.z
add r0.w, r0.y, l(0.000000)
div r0.w, r1.x, r0.w
mul r1.x, |r0.z|, l(12.000001)
min r1.x, r1.x, l(1.000000)
add r1.x, -r1.x, l(1.000000)
add r4.xyzw, -|r0.zzzz|, l(0.083333, 0.166667, 0.333333, 0.500000)
mul r4.xyzw, r4.xyzw, l(-12.000001, -6.000000, 6.000000, 6.000000)
min r4.xyzw, |r4.xyzw|, l(1.000000, 1.000000, 1.000000, 1.000000)
add r4.xyzw, -r4.xyzw, l(1.000000, 1.000000, 1.000000, 1.000000)
mul r1.y, r4.x, cb0[2].x
mad r1.x, cb0[1].w, r1.x, r1.y
mad r1.x, cb0[2].y, r4.y, r1.x
mad r1.x, cb0[2].z, r4.z, r1.x
mad r1.x, cb0[2].w, r4.w, r1.x
add r1.yzw, -|r0.zzzz|, l(0.000000, 0.666667, 0.833333, 1.000000)
mul r1.yzw, r1.yyzw, l(0.000000, 6.000000, 6.000000, 6.000000)
min r1.yzw, |r1.yyzw|, l(0.000000, 1.000000, 1.000000, 1.000000)
add r1.yzw, -r1.yyzw, l(0.000000, 1.000000, 1.000000, 1.000000)
mad r0.z, cb0[3].x, r1.y, r1.x
mad r0.z, cb0[3].y, r1.z, r0.z
mad r0.z, cb0[1].w, r1.w, r0.z
mul_sat r0.yw, r0.yyyw, l(0.000000, 10.000000, 0.000000, 5.000000)
mad r1.x, r0.w, l(-2.000000), l(3.000000)
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, r1.x
mad r1.x, r0.y, l(-2.000000), l(3.000000)
mul r0.y, r0.y, r0.y
mul r0.y, r0.y, r1.x
mul r0.y, r0.y, r0.w
add r0.z, r0.z, l(-1.000000)
mad r0.y, r0.y, r0.z, l(1.000000)
mul r0.x, r0.y, r0.x
add r0.yzw, -r2.xxyz, r3.xxyz
mad o0.xyz, r0.xxxx, r0.yzwy, r2.xyzx
mov o0.w, l(1.000000)
ret 
// Approximately 201 instruction slots used
