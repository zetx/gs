//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int Monochrome_preset;             // Offset:    0 Size:     4
//   float3 Monochrome_conversion_values;// Offset:    4 Size:    12
//   float Monochrome_color_saturation; // Offset:   16 Size:     4
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
dcl_constantbuffer CB0[2], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 2
dcl_indexableTemp x0[18], 4
mov x0[0].xyz, cb0[0].yzwy
mov x0[1].xyz, l(0.210000,0.720000,0.070000,0)
mov x0[2].xyz, l(0.333333,0.333333,0.333333,0)
mov x0[3].xyz, l(0.180000,0.410000,0.410000,0)
mov x0[4].xyz, l(0.250000,0.390000,0.360000,0)
mov x0[5].xyz, l(0.210000,0.400000,0.390000,0)
mov x0[6].xyz, l(0.200000,0.410000,0.390000,0)
mov x0[7].xyz, l(0.210000,0.420000,0.370000,0)
mov x0[8].xyz, l(0.220000,0.420000,0.360000,0)
mov x0[9].xyz, l(0.310000,0.360000,0.330000,0)
mov x0[10].xyz, l(0.280000,0.410000,0.310000,0)
mov x0[11].xyz, l(0.230000,0.370000,0.400000,0)
mov x0[12].xyz, l(0.330000,0.360000,0.310000,0)
mov x0[13].xyz, l(0.360000,0.310000,0.330000,0)
mov x0[14].xyz, l(0.210000,0.420000,0.370000,0)
mov x0[15].xyz, l(0.240000,0.370000,0.390000,0)
mov x0[16].xyz, l(0.270000,0.360000,0.370000,0)
mov x0[17].xyz, l(0.250000,0.350000,0.400000,0)
mov r0.x, cb0[0].x
mov r0.xyz, x0[r0.x + 0].xyzx
sample_indexable(texture2d)(float,float,float,float) r1.xyz, v1.xyxx, t0.xyzw, s0
dp3 r0.x, r0.xyzx, r1.xyzx
add r0.yzw, -r0.xxxx, r1.xxyz
mad_sat o0.xyz, cb0[1].xxxx, r0.yzwy, r0.xxxx
ret 
// Approximately 25 instruction slots used
