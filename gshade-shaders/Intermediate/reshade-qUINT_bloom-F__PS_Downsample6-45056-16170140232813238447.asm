//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__MXBLOOM_BloomTex5            texture  float4          2d            t14      1 
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
dcl_resource_texture2d (float,float,float,float) t14
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 4
add r0.xyzw, v1.xyxy, l(0.037209, 0.088889, -0.037209, -0.088889)
sample_l_indexable(texture2d)(float,float,float,float) r1.xyzw, r0.xyxx, t14.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r2.xyzw, r0.zyzz, t14.xyzw, s0, l(0.000000)
add r1.xyzw, r1.xyzw, r2.xyzw
sample_l_indexable(texture2d)(float,float,float,float) r2.xyzw, r0.zwzz, t14.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.xyzw, r0.xwxx, t14.xyzw, s0, l(0.000000)
add r1.xyzw, r1.xyzw, r2.xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
mul r0.xyzw, r0.xyzw, l(0.125000, 0.125000, 0.125000, 0.125000)
sample_indexable(texture2d)(float,float,float,float) r1.xyzw, v1.xyxx, t14.xyzw, s0
mad r0.xyzw, r1.xyzw, l(0.125000, 0.125000, 0.125000, 0.125000), r0.xyzw
add r1.xyzw, v1.xyxy, l(0.074419, 0.177778, -0.074419, -0.177778)
sample_l_indexable(texture2d)(float,float,float,float) r2.xyzw, r1.xyxx, t14.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r3.xyzw, r1.zyzz, t14.xyzw, s0, l(0.000000)
add r2.xyzw, r2.xyzw, r3.xyzw
sample_l_indexable(texture2d)(float,float,float,float) r3.xyzw, r1.zwzz, t14.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r1.xyzw, r1.xwxx, t14.xyzw, s0, l(0.000000)
add r2.xyzw, r2.xyzw, r3.xyzw
add r1.xyzw, r1.xyzw, r2.xyzw
mad r0.xyzw, r1.xyzw, l(0.031250, 0.031250, 0.031250, 0.031250), r0.xyzw
add r1.xyzw, v1.xyxy, l(0.074419, 0.000000, -0.074419, 0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r2.xyzw, r1.xyxx, t14.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r1.xyzw, r1.zwzz, t14.xyzw, s0, l(0.000000)
add r1.xyzw, r1.xyzw, r2.xyzw
add r2.xyzw, v1.xyxy, l(0.000000, 0.177778, 0.000000, -0.177778)
sample_l_indexable(texture2d)(float,float,float,float) r3.xyzw, r2.xyxx, t14.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r2.xyzw, r2.zwzz, t14.xyzw, s0, l(0.000000)
add r1.xyzw, r1.xyzw, r3.xyzw
add r1.xyzw, r2.xyzw, r1.xyzw
mad o0.xyzw, r1.xyzw, l(0.062500, 0.062500, 0.062500, 0.062500), r0.xyzw
ret 
// Approximately 31 instruction slots used
