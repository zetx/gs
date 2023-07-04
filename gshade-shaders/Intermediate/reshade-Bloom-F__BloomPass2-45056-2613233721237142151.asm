//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__texBloom2                    texture  float4          2d             t6      1 
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
dcl_resource_texture2d (float,float,float,float) t6
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 3
add r0.xyzw, v1.xyxy, l(0.001644, 0.003928, -0.001644, -0.003928)
sample_indexable(texture2d)(float,float,float,float) r1.xyzw, r0.xyxx, t6.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r2.xyzw, r0.xwxx, t6.xyzw, s0
add r1.xyzw, r1.xyzw, r2.xyzw
sample_indexable(texture2d)(float,float,float,float) r2.xyzw, r0.zyzz, t6.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r0.xyzw, r0.zwzz, t6.xyzw, s0
add r1.xyzw, r1.xyzw, r2.xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
add r1.xyzw, v1.xyxy, l(0.000000, 0.005556, 0.000000, -0.005556)
sample_indexable(texture2d)(float,float,float,float) r2.xyzw, r1.xyxx, t6.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r1.xyzw, r1.zwzz, t6.xyzw, s0
add r0.xyzw, r0.xyzw, r2.xyzw
add r0.xyzw, r1.xyzw, r0.xyzw
add r1.xyzw, v1.xyxy, l(0.002326, 0.000000, -0.002326, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r2.xyzw, r1.xyxx, t6.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r1.xyzw, r1.zwzz, t6.xyzw, s0
add r0.xyzw, r0.xyzw, r2.xyzw
add r0.xyzw, r1.xyzw, r0.xyzw
mul o0.xyzw, r0.xyzw, l(0.500000, 0.500000, 0.500000, 0.500000)
ret 
// Approximately 20 instruction slots used