//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__texBloom1                    texture  float4          2d             t4      1 
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
dcl_resource_texture2d (float,float,float,float) t4
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 5
add r0.xyzw, v1.xyxy, l(0.001163, 0.002778, -0.001163, -0.002778)
sample_indexable(texture2d)(float,float,float,float) r1.xyzw, r0.xyxx, t4.xyzw, s0
add r2.xyzw, v1.xyxy, l(0.000000, -0.002778, 0.000000, 0.002778)
sample_indexable(texture2d)(float,float,float,float) r3.xyzw, r2.xyxx, t4.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r2.xyzw, r2.zwzz, t4.xyzw, s0
add r1.xyzw, r1.xyzw, r3.xyzw
sample_indexable(texture2d)(float,float,float,float) r4.xyzw, r0.zyzz, t4.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r0.xyzw, r0.zwzz, t4.xyzw, s0
add r1.xyzw, r1.xyzw, r4.xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
add r0.xyzw, r2.xyzw, r0.xyzw
add r0.xyzw, r3.xyzw, r0.xyzw
add r1.xyzw, v1.xyxy, l(0.001163, 0.000000, -0.001163, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r2.xyzw, r1.xyxx, t4.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r1.xyzw, r1.zwzz, t4.xyzw, s0
add r0.xyzw, r0.xyzw, r2.xyzw
add r0.xyzw, r1.xyzw, r0.xyzw
mul o0.xyzw, r0.xyzw, l(0.125000, 0.125000, 0.125000, 0.125000)
ret 
// Approximately 19 instruction slots used
