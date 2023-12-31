//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float3 ColorA;                     // Offset:    0 Size:    12
//   float3 ColorB;                     // Offset:   16 Size:    12
//   bool Flip;                         // Offset:   28 Size:     4
//   int Axis;                          // Offset:   32 Size:     4
//   float Scale;                       // Offset:   36 Size:     4
//   float Offset;                      // Offset:   40 Size:     4
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
dcl_constantbuffer CB0[3], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 3
add r0.xy, v1.xyxx, l(0.000000, 0.694444, 0.000000, 0.000000)
mad r0.xy, r0.xyxx, l(2.000000, 0.837209, 0.000000, 0.000000), l(-1.000000, -1.000000, 0.000000, 0.000000)
mul r0.xy, r0.xyxx, cb0[2].yyyy
itof r0.z, -cb0[2].x
mul r0.z, r0.z, l(0.017453)
sincos r1.x, r2.x, r0.z
mov r1.y, r2.x
dp2 r0.x, r1.xyxx, r0.xyxx
add r0.x, r0.x, cb0[2].z
mad r0.x, r0.x, l(0.500000), l(0.500000)
min r0.y, r0.x, l(0.500000)
max r0.x, r0.x, l(0.500000)
add r0.z, r0.x, r0.x
mad r0.y, r0.y, r0.y, r0.z
mad r0.x, -r0.x, r0.x, r0.y
mad r0.x, r0.x, l(2.000000), l(-1.500000)
add r0.y, -r0.x, l(1.000000)
add r1.xyz, -cb0[0].xyzx, cb0[1].xyzx
mad r0.yzw, r0.yyyy, r1.xxyz, cb0[0].xxyz
mad r1.xyz, r0.xxxx, r1.xyzx, cb0[0].xyzx
add r1.xyz, -r1.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
add r0.xyz, -r0.yzwy, l(1.000000, 1.000000, 1.000000, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r2.xyz, v1.xyxx, t0.xyzw, s0
add r2.xyz, -r2.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
mad r0.xyz, -r2.xyzx, r0.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
mad r1.xyz, -r2.xyzx, r1.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
movc o0.xyz, cb0[1].wwww, r0.xyzx, r1.xyzx
ret 
// Approximately 28 instruction slots used
