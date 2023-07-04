//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int GaussianBloomRadius;           // Offset:    0 Size:     4 [unused]
//   float GaussianBloomOffset;         // Offset:    4 Size:     4
//   float Threshold;                   // Offset:    8 Size:     4 [unused]
//   float3 BloomTint;                  // Offset:   16 Size:    12 [unused]
//   float Exposure;                    // Offset:   28 Size:     4 [unused]
//   float GaussianBloomSaturation;     // Offset:   32 Size:     4
//   float DitherStrength;              // Offset:   36 Size:     4
//   float GaussianBloomStrength;       // Offset:   40 Size:     4
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
// __V__GaussianBloomTex             texture  float4          2d             t4      1 
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
dcl_sampler s1, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t4
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 3
dp2 r0.x, v1.xyxx, l(12.989800, 78.233002, 0.000000, 0.000000)
sincos r0.x, null, r0.x
mad r0.x, r0.x, l(43758.542969), v1.x
frc r0.x, r0.x
mad r0.y, r0.x, l(0.012000), l(-0.006000)
mov r0.xz, -r0.yyyy
div r1.xy, v1.xyxx, cb0[0].yyyy
sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.xyxx, t4.xyzw, s1
dp3 r0.w, r1.xyzx, l(0.333333, 0.333333, 0.333333, 0.000000)
add r1.xyz, -r0.wwww, r1.xyzx
mad r1.xyz, cb0[2].xxxx, r1.xyzx, r0.wwww
mad r0.xyz, r0.xyzx, cb0[2].yyyy, r1.xyzx
ne r0.w, l(0.000000, 0.000000, 0.000000, 0.000000), cb0[2].y
movc r0.xyz, r0.wwww, r0.xyzx, r1.xyzx
add r0.xyz, -r0.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r1.xyz, v1.xyxx, t0.xyzw, s0
add r2.xyz, -r1.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
mad r0.xyz, -r2.xyzx, r0.xyzx, -r1.xyzx
add r0.xyz, r0.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
mad_sat o0.xyz, cb0[2].zzzz, r0.xyzx, r1.xyzx
ret 
// Approximately 21 instruction slots used
