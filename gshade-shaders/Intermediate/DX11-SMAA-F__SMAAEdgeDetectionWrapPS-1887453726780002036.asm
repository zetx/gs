//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int EdgeDetectionType;             // Offset:    0 Size:     4
//   float EdgeDetectionThreshold;      // Offset:    4 Size:     4
//   float DepthEdgeDetectionThreshold; // Offset:    8 Size:     4
//   int MaxSearchSteps;                // Offset:   12 Size:     4 [unused]
//   int MaxSearchStepsDiagonal;        // Offset:   16 Size:     4 [unused]
//   int CornerRounding;                // Offset:   20 Size:     4 [unused]
//   bool PredicationEnabled;           // Offset:   24 Size:     4
//   float PredicationThreshold;        // Offset:   28 Size:     4
//   float PredicationScale;            // Offset:   32 Size:     4
//   float PredicationStrength;         // Offset:   36 Size:     4
//   int DebugOutput;                   // Offset:   40 Size:     4 [unused]
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
// __V__ReShade__BackBufferTex       texture  float4          2d             t0      1 
// __V__depthTex                     texture  float4          2d             t4      1 
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
// TEXCOORD                 1   xyzw        2     NONE   float   xyzw
// TEXCOORD                 2   xyzw        3     NONE   float   xyzw
// TEXCOORD                 3   xyzw        4     NONE   float   xyzw
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_TARGET                0   xy          0   TARGET   float   xy  
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[3], immediateIndexed
dcl_sampler s0, mode_default
dcl_sampler s1, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t4
dcl_input_ps linear v1.xy
dcl_input_ps linear v2.xyzw
dcl_input_ps linear v3.xyzw
dcl_input_ps linear v4.xyzw
dcl_output o0.xy
dcl_temps 7
ieq r0.x, cb0[0].x, l(0)
ine r0.y, cb0[1].z, l(0)
ieq r0.y, r0.y, l(-1)
and r0.x, r0.y, r0.x
if_nz r0.x
  add r0.xy, v1.xyxx, l(-0.000145, -0.000347, 0.000000, 0.000000)
  gather4_indexable(texture2d)(float,float,float,float) r0.xyz, r0.xyxx, t4.xyzw, s0.x
  add r0.xy, -r0.xzxx, r0.yyyy
  ge r0.xy, |r0.xyxx|, cb0[1].wwww
  and r0.xy, r0.xyxx, l(0x3f800000, 0x3f800000, 0, 0)
  mul r0.z, cb0[0].y, cb0[2].x
  mad r0.xy, -cb0[2].yyyy, r0.xyxx, l(1.000000, 1.000000, 0.000000, 0.000000)
  mul r0.xy, r0.xyxx, r0.zzzz
  sample_indexable(texture2d)(float,float,float,float) r1.xyz, v1.xyxx, t0.xyzw, s1
  dp3 r0.z, r1.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r1.xyz, v2.xyxx, t0.xyzw, s1
  dp3 r1.x, r1.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, v2.zwzz, t0.xyzw, s1
  dp3 r1.y, r2.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
  add r1.zw, r0.zzzz, -r1.xxxy
  ge r0.xy, |r1.zwzz|, r0.xyxx
  and r0.xy, r0.xyxx, l(0x3f800000, 0x3f800000, 0, 0)
  dp2 r0.w, r0.xyxx, l(1.000000, 1.000000, 0.000000, 0.000000)
  eq r0.w, r0.w, l(0.000000)
  discard_nz r0.w
  if_z r0.w
    sample_indexable(texture2d)(float,float,float,float) r2.xyz, v3.xyxx, t0.xyzw, s1
    dp3 r2.x, r2.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
    sample_indexable(texture2d)(float,float,float,float) r3.xyz, v3.zwzz, t0.xyzw, s1
    dp3 r2.y, r3.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
    add r0.zw, r0.zzzz, -r2.xxxy
    max r0.zw, |r0.zzzw|, |r1.zzzw|
    sample_indexable(texture2d)(float,float,float,float) r2.xyz, v4.xyxx, t0.xyzw, s1
    dp3 r2.x, r2.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
    sample_indexable(texture2d)(float,float,float,float) r3.xyz, v4.zwzz, t0.xyzw, s1
    dp3 r2.y, r3.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
    add r1.xy, r1.xyxx, -r2.xyxx
    max r0.zw, r0.zzzw, |r1.xxxy|
    max r0.z, r0.w, r0.z
    add r1.xy, |r1.zwzz|, |r1.zwzz|
    ge r0.zw, r1.xxxy, r0.zzzz
    and r0.zw, r0.zzzw, l(0, 0, 0x3f800000, 0x3f800000)
    mul o0.xy, r0.zwzz, r0.xyxx
  else 
    mov o0.xy, l(0,0,0,0)
  endif 
  ret 
else 
  if_z cb0[0].x
    sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s1
    dp3 r0.x, r0.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
    sample_indexable(texture2d)(float,float,float,float) r0.yzw, v2.xyxx, t0.wxyz, s1
    dp3 r1.x, r0.yzwy, l(0.212600, 0.715200, 0.072200, 0.000000)
    sample_indexable(texture2d)(float,float,float,float) r0.yzw, v2.zwzz, t0.wxyz, s1
    dp3 r1.y, r0.yzwy, l(0.212600, 0.715200, 0.072200, 0.000000)
    add r0.yz, r0.xxxx, -r1.xxyx
    ge r1.zw, |r0.yyyz|, cb0[0].yyyy
    and r1.zw, r1.zzzw, l(0, 0, 0x3f800000, 0x3f800000)
    dp2 r0.w, r1.zwzz, l(1.000000, 1.000000, 0.000000, 0.000000)
    eq r0.w, r0.w, l(0.000000)
    discard_nz r0.w
    if_z r0.w
      sample_indexable(texture2d)(float,float,float,float) r2.xyz, v3.xyxx, t0.xyzw, s1
      dp3 r2.x, r2.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
      sample_indexable(texture2d)(float,float,float,float) r3.xyz, v3.zwzz, t0.xyzw, s1
      dp3 r2.y, r3.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
      add r0.xw, r0.xxxx, -r2.xxxy
      max r0.xw, |r0.xxxw|, |r0.yyyz|
      sample_indexable(texture2d)(float,float,float,float) r2.xyz, v4.xyxx, t0.xyzw, s1
      dp3 r2.x, r2.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
      sample_indexable(texture2d)(float,float,float,float) r3.xyz, v4.zwzz, t0.xyzw, s1
      dp3 r2.y, r3.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
      add r1.xy, r1.xyxx, -r2.xyxx
      max r0.xw, r0.xxxw, |r1.xxxy|
      max r0.x, r0.w, r0.x
      add r0.yz, |r0.yyzy|, |r0.yyzy|
      ge r0.xy, r0.yzyy, r0.xxxx
      and r0.xy, r0.xyxx, l(0x3f800000, 0x3f800000, 0, 0)
      mul o0.xy, r0.xyxx, r1.zwzz
    else 
      mov o0.xy, l(0,0,0,0)
    endif 
    ret 
  endif 
endif 
ieq r0.x, cb0[0].x, l(2)
if_nz r0.x
  add r0.xy, v1.xyxx, l(-0.000145, -0.000347, 0.000000, 0.000000)
  gather4_indexable(texture2d)(float,float,float,float) r0.xyz, r0.xyxx, t4.xyzw, s0.x
  add r0.xy, -r0.xzxx, r0.yyyy
  ge r0.xy, |r0.xyxx|, cb0[0].zzzz
  and r0.xy, r0.xyxx, l(0x3f800000, 0x3f800000, 0, 0)
  dp2 r0.z, r0.xyxx, l(1.000000, 1.000000, 0.000000, 0.000000)
  eq r0.z, r0.z, l(0.000000)
  discard_nz r0.z
  movc o0.xy, r0.zzzz, l(0,0,0,0), r0.xyxx
  ret 
endif 
if_nz cb0[1].z
  add r0.xy, v1.xyxx, l(-0.000145, -0.000347, 0.000000, 0.000000)
  gather4_indexable(texture2d)(float,float,float,float) r0.xyz, r0.xyxx, t4.xyzw, s0.x
  add r0.xy, -r0.xzxx, r0.yyyy
  ge r0.xy, |r0.xyxx|, cb0[1].wwww
  and r0.xy, r0.xyxx, l(0x3f800000, 0x3f800000, 0, 0)
  mul r0.z, cb0[0].y, cb0[2].x
  mad r0.xy, -cb0[2].yyyy, r0.xyxx, l(1.000000, 1.000000, 0.000000, 0.000000)
  mul r0.xy, r0.xyxx, r0.zzzz
  sample_indexable(texture2d)(float,float,float,float) r1.xyz, v1.xyxx, t0.xyzw, s1
  sample_indexable(texture2d)(float,float,float,float) r2.xyz, v2.xyxx, t0.xyzw, s1
  add r3.xyz, r1.xyzx, -r2.xyzx
  max r0.z, |r3.y|, |r3.x|
  max r3.x, |r3.z|, r0.z
  sample_indexable(texture2d)(float,float,float,float) r4.xyz, v2.zwzz, t0.xyzw, s1
  add r5.xyz, r1.xyzx, -r4.xyzx
  max r0.z, |r5.y|, |r5.x|
  max r3.y, |r5.z|, r0.z
  ge r0.xy, r3.xyxx, r0.xyxx
  and r0.xy, r0.xyxx, l(0x3f800000, 0x3f800000, 0, 0)
  dp2 r0.z, r0.xyxx, l(1.000000, 1.000000, 0.000000, 0.000000)
  eq r0.z, r0.z, l(0.000000)
  discard_nz r0.z
  if_z r0.z
    sample_indexable(texture2d)(float,float,float,float) r5.xyz, v3.xyxx, t0.xyzw, s1
    add r5.xyz, r1.xyzx, -r5.xyzx
    max r0.z, |r5.y|, |r5.x|
    max r5.x, |r5.z|, r0.z
    sample_indexable(texture2d)(float,float,float,float) r6.xyz, v3.zwzz, t0.xyzw, s1
    add r1.xyz, r1.xyzx, -r6.xyzx
    max r0.z, |r1.y|, |r1.x|
    max r5.y, |r1.z|, r0.z
    max r0.zw, r3.xxxy, r5.xxxy
    sample_indexable(texture2d)(float,float,float,float) r1.xyz, v4.xyxx, t0.xyzw, s1
    add r1.xyz, -r1.xyzx, r2.xyzx
    max r1.x, |r1.y|, |r1.x|
    max r1.x, |r1.z|, r1.x
    sample_indexable(texture2d)(float,float,float,float) r2.xyz, v4.zwzz, t0.xyzw, s1
    add r2.xyz, -r2.xyzx, r4.xyzx
    max r1.z, |r2.y|, |r2.x|
    max r1.y, |r2.z|, r1.z
    max r0.zw, r0.zzzw, r1.xxxy
    max r0.z, r0.w, r0.z
    add r1.xy, r3.xyxx, r3.xyxx
    ge r0.zw, r1.xxxy, r0.zzzz
    and r0.zw, r0.zzzw, l(0, 0, 0x3f800000, 0x3f800000)
    mul o0.xy, r0.zwzz, r0.xyxx
  else 
    mov o0.xy, l(0,0,0,0)
  endif 
  ret 
else 
  sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s1
  sample_indexable(texture2d)(float,float,float,float) r1.xyz, v2.xyxx, t0.xyzw, s1
  add r2.xyz, r0.xyzx, -r1.xyzx
  max r0.w, |r2.y|, |r2.x|
  max r2.x, |r2.z|, r0.w
  sample_indexable(texture2d)(float,float,float,float) r3.xyz, v2.zwzz, t0.xyzw, s1
  add r4.xyz, r0.xyzx, -r3.xyzx
  max r0.w, |r4.y|, |r4.x|
  max r2.y, |r4.z|, r0.w
  ge r2.zw, r2.xxxy, cb0[0].yyyy
  and r2.zw, r2.zzzw, l(0, 0, 0x3f800000, 0x3f800000)
  dp2 r0.w, r2.zwzz, l(1.000000, 1.000000, 0.000000, 0.000000)
  eq r0.w, r0.w, l(0.000000)
  discard_nz r0.w
  if_z r0.w
    sample_indexable(texture2d)(float,float,float,float) r4.xyz, v3.xyxx, t0.xyzw, s1
    add r4.xyz, r0.xyzx, -r4.xyzx
    max r0.w, |r4.y|, |r4.x|
    max r4.x, |r4.z|, r0.w
    sample_indexable(texture2d)(float,float,float,float) r5.xyz, v3.zwzz, t0.xyzw, s1
    add r0.xyz, r0.xyzx, -r5.xyzx
    max r0.x, |r0.y|, |r0.x|
    max r4.y, |r0.z|, r0.x
    max r0.xy, r2.xyxx, r4.xyxx
    sample_indexable(texture2d)(float,float,float,float) r4.xyz, v4.xyxx, t0.xyzw, s1
    add r1.xyz, r1.xyzx, -r4.xyzx
    max r0.z, |r1.y|, |r1.x|
    max r1.x, |r1.z|, r0.z
    sample_indexable(texture2d)(float,float,float,float) r4.xyz, v4.zwzz, t0.xyzw, s1
    add r3.xyz, r3.xyzx, -r4.xyzx
    max r0.z, |r3.y|, |r3.x|
    max r1.y, |r3.z|, r0.z
    max r0.xy, r0.xyxx, r1.xyxx
    max r0.x, r0.y, r0.x
    add r0.yz, r2.xxyx, r2.xxyx
    ge r0.xy, r0.yzyy, r0.xxxx
    and r0.xy, r0.xyxx, l(0x3f800000, 0x3f800000, 0, 0)
    mul o0.xy, r0.xyxx, r2.zwzz
  else 
    mov o0.xy, l(0,0,0,0)
  endif 
  ret 
endif 
ret 
// Approximately 194 instruction slots used
