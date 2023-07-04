//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float HDRPower;                    // Offset:    0 Size:     4
//   float radius1;                     // Offset:    4 Size:     4
//   float radius2;                     // Offset:    8 Size:     4
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
dcl_constantbuffer CB0[1], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 4
mad r0.xyzw, cb0[0].yyyy, l(1.500000, -1.500000, -1.500000, -1.500000), v1.xyxy
sample_indexable(texture2d)(float,float,float,float) r1.xyz, r0.xyxx, t0.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r0.xyz, r0.zwzz, t0.xyzw, s0
add r0.xyz, r0.xyzx, r1.xyzx
mad r1.xyzw, cb0[0].yyyy, l(1.500000, 1.500000, -1.500000, 1.500000), v1.xyxy
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r1.xyxx, t0.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t0.xyzw, s0
add r0.xyz, r0.xyzx, r2.xyzx
add r0.xyz, r1.xyzx, r0.xyzx
mad r1.xyzw, cb0[0].yyyy, l(0.000000, -2.500000, -2.500000, 0.000000), v1.xyxy
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r1.xyxx, t0.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t0.xyzw, s0
add r0.xyz, r0.xyzx, r2.xyzx
mad r2.xyzw, cb0[0].yyyy, l(0.000000, 2.500000, 2.500000, 0.000000), v1.xyxy
sample_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
add r0.xyz, r0.xyzx, r3.xyzx
add r0.xyz, r1.xyzx, r0.xyzx
add r0.xyz, r2.xyzx, r0.xyzx
mul r0.xyz, r0.xyzx, l(0.005000, 0.005000, 0.005000, 0.000000)
mad r1.xyzw, cb0[0].zzzz, l(1.500000, -1.500000, -1.500000, -1.500000), v1.xyxy
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r1.xyxx, t0.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t0.xyzw, s0
add r1.xyz, r1.xyzx, r2.xyzx
mad r2.xyzw, cb0[0].zzzz, l(1.500000, 1.500000, -1.500000, 1.500000), v1.xyxy
sample_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
add r1.xyz, r1.xyzx, r3.xyzx
add r1.xyz, r2.xyzx, r1.xyzx
mad r2.xyzw, cb0[0].zzzz, l(0.000000, -2.500000, 0.000000, 2.500000), v1.xyxy
sample_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
add r1.xyz, r1.xyzx, r3.xyzx
add r1.xyz, r2.xyzx, r1.xyzx
mad r2.xyzw, cb0[0].zzzz, l(-2.500000, 0.000000, 2.500000, 0.000000), v1.xyxy
sample_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0
add r1.xyz, r1.xyzx, r3.xyzx
add r1.xyz, r2.xyzx, r1.xyzx
mad r0.xyz, r1.xyzx, l(0.010000, 0.010000, 0.010000, 0.000000), -r0.xyzx
sample_indexable(texture2d)(float,float,float,float) r1.xyz, v1.xyxx, t0.xyzw, s0
add r0.xyz, r0.xyzx, r1.xyzx
add r0.w, -cb0[0].y, cb0[0].z
mad r1.xyz, r0.xyzx, r0.wwww, r1.xyzx
log r1.xyz, |r1.xyzx|
mul r1.xyz, r1.xyzx, cb0[0].xxxx
exp r1.xyz, r1.xyzx
mad_sat o0.xyz, r0.xyzx, r0.wwww, r1.xyzx
ret 
// Approximately 49 instruction slots used
