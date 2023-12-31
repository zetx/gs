//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int Type;                          // Offset:    0 Size:     4
//   float Ratio;                       // Offset:    4 Size:     4
//   float Radius;                      // Offset:    8 Size:     4
//   float Amount;                      // Offset:   12 Size:     4
//   int Slope;                         // Offset:   16 Size:     4
//   float2 Center;                     // Offset:   20 Size:     8
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
// SV_TARGET                0   xyzw        0   TARGET   float   xyzw
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[2], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 5
add r0.xy, v1.xyxx, -cb0[1].yzyy
mov r1.x, l(2.388889)
mov r1.y, cb0[0].y
mul r0.xy, r0.xyxx, r1.xyxx
div r0.xy, r0.xyxx, cb0[0].zzzz
dp2 r0.x, r0.xyxx, r0.xyxx
log r0.x, r0.x
itof r0.y, cb0[1].x
mul r0.y, r0.y, l(0.500000)
mul r0.x, r0.x, r0.y
exp r0.x, r0.x
mad r0.x, r0.x, cb0[0].w, l(1.000000)
sample_indexable(texture2d)(float,float,float,float) r1.xyzw, v1.xyxx, t0.xyzw, s0
mul r0.xyz, r0.xxxx, r1.xyzx
movc r0.xyz, cb0[0].xxxx, r1.xyzx, r0.xyzx
mov o0.w, r1.w
mad r1.xyzw, -v1.xyxy, v1.xyxy, v1.xyxy
mul r0.w, r1.z, cb0[0].y
mad r0.w, r0.w, l(5.706791), r1.w
mul_sat r0.w, r0.w, l(4.000000)
mul r2.xyz, r0.xyzx, r0.wwww
ieq r3.xyzw, cb0[0].xxxx, l(1, 2, 3, 4)
movc r0.xyz, r3.xxxx, r2.xyzx, r0.xyzx
movc r1.xyzw, r3.xxxx, r1.xyzw, v1.xyxy
mad r2.xyzw, -r1.zwzw, r1.xyzw, r1.xyzw
movc r1.xyzw, r3.yyyy, r2.xyzw, r1.xyzw
mul r0.w, r2.w, r2.z
mul_sat r0.w, r0.w, l(100.000000)
mul r2.xyz, r0.xyzx, r0.wwww
movc r0.xyz, r3.yyyy, r2.xyzx, r0.xyzx
mov r2.w, l(1.000000)
add r3.xy, r1.zwzz, l(-0.500000, -0.500000, 0.000000, 0.000000)
mov r2.xy, |r3.xyxx|
mov r2.z, -r2.x
dp4 r0.w, r2.zzxy, r2.yyww
movc r1.xyzw, r3.zzzz, r2.xyxy, r1.xyzw
add_sat r0.w, r0.w, l(-0.495000)
mad r0.w, -r0.w, l(200.000000), l(1.000000)
mul r0.w, r0.w, r0.w
mad r0.w, r0.w, r0.w, l(0.250000)
mul r2.xyz, r0.wwww, r0.xyzx
movc r0.xyz, r3.zzzz, r2.xyzx, r0.xyzx
add r2.xy, r1.zwzz, l(-0.500000, -0.500000, 0.000000, 0.000000)
mov r2.xy, |r2.xyxx|
mov r2.z, -r2.x
mov r2.w, l(1.000000)
dp4 r0.w, r2.zzxy, r2.yyww
movc r1.xyzw, r3.wwww, r2.xyxy, r1.xyzw
add_sat r0.w, r0.w, l(-0.495000)
add r0.w, r0.w, l(-0.000200)
mad r0.w, -r0.w, l(200.000000), l(1.000000)
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, r0.w
mul r2.xyz, r0.wwww, r0.xyzx
movc r0.xyz, r3.wwww, r2.xyzx, r0.xyzx
add r2.xyzw, r1.zwzw, l(-0.500000, -0.500000, -0.500000, -0.500000)
mad r0.w, |r2.w|, l(-2.000000), l(1.000000)
mad r0.w, |r2.z|, r0.w, |r2.w|
add_sat r0.w, r0.w, l(-0.495000)
mad r0.w, r0.w, l(-200.000000), l(1.000000)
mul r0.w, r0.w, r0.w
mad r0.w, r0.w, r0.w, l(0.250000)
mul r3.xyz, r0.wwww, r0.xyzx
ieq r4.xy, cb0[0].xxxx, l(5, 6, 0, 0)
movc r0.xyz, r4.xxxx, r3.xyzx, r0.xyzx
movc r1.xyzw, r4.xxxx, |r2.xyzw|, r1.xyzw
mov r2.xy, -r1.zwzz
mov r2.zw, l(0,0,1.000000,1.000000)
dp4 r0.w, r1.xyzw, r2.xyzw
mul_sat r0.w, r0.w, l(4.000000)
mul r1.xyz, r0.xyzx, r0.wwww
movc o0.xyz, r4.yyyy, r1.xyzx, r0.xyzx
ret 
// Approximately 73 instruction slots used
