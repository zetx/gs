//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int fLUT_MultiLUTSelector;         // Offset:    0 Size:     4 [unused]
//   int fLUT_LutSelector;              // Offset:    4 Size:     4
//   float fLUT_Intensity;              // Offset:    8 Size:     4
//   float fLUT_AmountChroma;           // Offset:   12 Size:     4
//   float fLUT_AmountLuma;             // Offset:   16 Size:     4
//   bool fLUT_MultiLUTPass2;           // Offset:   20 Size:     4 [unused]
//   bool fLUT_MultiLUTPass3;           // Offset:   24 Size:     4 [unused]
//   float DitherTimer;                 // Offset:   28 Size:     4
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
// __V__texMultiLUT                  texture  float4          2d             t4      1 
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
dcl_resource_texture2d (float,float,float,float) t4
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 5
mad r0.xy, cb0[1].wwww, l(0.001000, 0.001000, 0.000000, 0.000000), v1.xyxx
dp2 r0.x, r0.xyxx, l(25.979601, 156.466003, 0.000000, 0.000000)
sincos r0.x, null, r0.x
mul r0.x, r0.x, l(43758.542969)
frc r0.z, r0.x
mov r0.xy, v1.xyxx
add r0.xyz, r0.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
mad r0.w, r0.x, l(34.000000), l(1.000000)
mul r0.x, r0.x, r0.w
mul r0.w, r0.x, l(289.000000)
ge r0.w, r0.w, -r0.w
movc r1.xy, r0.wwww, l(289.000000,0.003460,0,0), l(-289.000000,-0.003460,0,0)
mul r0.x, r0.x, r1.y
frc r0.x, r0.x
mad r0.x, r1.x, r0.x, r0.y
mad r0.y, r0.x, l(34.000000), l(1.000000)
mul r0.x, r0.x, r0.y
mul r0.y, r0.x, l(289.000000)
ge r0.y, r0.y, -r0.y
movc r0.yw, r0.yyyy, l(0,289.000000,0,0.003460), l(0,-289.000000,0,-0.003460)
mul r0.x, r0.w, r0.x
frc r0.x, r0.x
mad r0.x, r0.y, r0.x, r0.z
mad r0.y, r0.x, l(34.000000), l(1.000000)
mul r0.x, r0.x, r0.y
mul r0.y, r0.x, l(289.000000)
ge r0.y, r0.y, -r0.y
movc r0.yz, r0.yyyy, l(0,289.000000,0.003460,0), l(0,-289.000000,-0.003460,0)
mul r0.x, r0.z, r0.x
frc r0.x, r0.x
mul r0.x, r0.x, r0.y
mad r0.y, r0.x, l(34.000000), l(1.000000)
mul r0.y, r0.x, r0.y
mul r0.x, r0.x, l(0.024390)
frc r1.x, r0.x
mul r0.x, r0.y, l(289.000000)
ge r0.x, r0.x, -r0.x
movc r0.xz, r0.xxxx, l(289.000000,0,0.003460,0), l(-289.000000,0,-0.003460,0)
mul r0.y, r0.z, r0.y
frc r0.y, r0.y
mul r0.x, r0.y, r0.x
mad r0.y, r0.x, l(34.000000), l(1.000000)
mul r0.y, r0.x, r0.y
mul r0.x, r0.x, l(0.024390)
frc r2.x, r0.x
mul r0.x, r0.y, l(289.000000)
ge r0.x, r0.x, -r0.x
movc r0.xz, r0.xxxx, l(289.000000,0,0.003460,0), l(-289.000000,0,-0.003460,0)
mul r0.y, r0.z, r0.y
frc r0.y, r0.y
mul r0.x, r0.y, r0.x
mad r0.y, r0.x, l(34.000000), l(1.000000)
mul r0.y, r0.x, r0.y
mul r0.x, r0.x, l(0.024390)
frc r1.y, r0.x
mul r0.x, r0.y, l(289.000000)
ge r0.x, r0.x, -r0.x
movc r0.xz, r0.xxxx, l(289.000000,0,0.003460,0), l(-289.000000,0,-0.003460,0)
mul r0.y, r0.z, r0.y
frc r0.y, r0.y
mul r0.x, r0.y, r0.x
mad r0.y, r0.x, l(34.000000), l(1.000000)
mul r0.y, r0.x, r0.y
mul r0.x, r0.x, l(0.024390)
frc r2.y, r0.x
mul r0.x, r0.y, l(289.000000)
ge r0.x, r0.x, -r0.x
movc r0.xz, r0.xxxx, l(289.000000,0,0.003460,0), l(-289.000000,0,-0.003460,0)
mul r0.y, r0.z, r0.y
frc r0.y, r0.y
mul r0.x, r0.y, r0.x
mad r0.y, r0.x, l(34.000000), l(1.000000)
mul r0.y, r0.x, r0.y
mul r0.x, r0.x, l(0.024390)
frc r1.z, r0.x
mul r0.x, r0.y, l(289.000000)
ge r0.x, r0.x, -r0.x
movc r0.xz, r0.xxxx, l(289.000000,0,0.003460,0), l(-289.000000,0,-0.003460,0)
mul r0.y, r0.z, r0.y
frc r0.y, r0.y
mul r0.x, r0.y, r0.x
mul r0.x, r0.x, l(0.024390)
frc r2.z, r0.x
add r0.xyz, r1.xyzx, -r2.xyzx
add r1.xyz, r1.xyzx, l(-0.500000, -0.500000, -0.500000, 0.000000)
add r0.xyz, r0.xyzx, -r1.xyzx
sample_indexable(texture2d)(float,float,float,float) r2.xyz, v1.xyxx, t0.xyzw, s0
mul r0.w, r2.z, l(31.000000)
frc r0.w, r0.w
mad r1.w, r2.z, l(31.000000), -r0.w
mad r3.xy, r2.xyxx, l(31.000000, 31.000000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
mul r3.xy, r3.xyxx, l(0.000977, 0.001838, 0.000000, 0.000000)
mad r4.x, r1.w, l(0.031250), r3.x
add r4.z, r4.x, l(0.031250)
itof r1.w, cb0[0].y
mad r4.y, r1.w, l(0.058824), r3.y
sample_indexable(texture2d)(float,float,float,float) r3.xyz, r4.zyzz, t4.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r4.xyz, r4.xyxx, t4.xyzw, s0
add r3.xyz, r3.xyzx, -r4.xyzx
mad r3.xyz, r0.wwww, r3.xyzx, r4.xyzx
add r3.xyz, -r2.xyzx, r3.xyzx
mad r3.xyz, cb0[0].zzzz, r3.xyzx, r2.xyzx
dp3 r0.w, r3.xyzx, r3.xyzx
rsq r1.w, r0.w
sqrt r0.w, r0.w
dp3 r2.w, r2.xyzx, r2.xyzx
rsq r3.w, r2.w
sqrt r2.w, r2.w
mul r2.xyz, r2.xyzx, r3.wwww
mad r3.xyz, r3.xyzx, r1.wwww, -r2.xyzx
mad r2.xyz, cb0[0].wwww, r3.xyzx, r2.xyzx
add r0.w, r0.w, -r2.w
mad r0.w, cb0[1].x, r0.w, r2.w
mad r3.xyz, r2.xyzx, r0.wwww, l(-1.000000, -1.000000, -1.000000, 0.000000)
mul r2.xyz, r0.wwww, r2.xyzx
mul_sat r3.xyz, r3.xyzx, l(-509.992279, -509.992279, -509.992279, 0.000000)
mul_sat r4.xyz, r2.xyzx, l(509.999969, 509.999969, 509.999969, 0.000000)
min r3.xyz, r3.xyzx, r4.xyzx
mad r0.xyz, r3.xyzx, r0.xyzx, r1.xyzx
mad o0.xyz, r0.xyzx, l(0.003922, 0.003922, 0.003922, 0.000000), r2.xyzx
ret 
// Approximately 121 instruction slots used