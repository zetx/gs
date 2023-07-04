//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float fDithering;                  // Offset:    0 Size:     4
//   float fQuantization;               // Offset:    4 Size:     4
//   int iDitherMode;                   // Offset:    8 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __srgbV__ReShade__BackBufferTex    texture  float4          2d             t1      1 
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
dcl_constantbuffer CB0[1], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t1
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 3
dcl_indexableTemp x0[64], 4
mov x0[0].x, l(0)
mov x0[1].x, l(48)
mov x0[2].x, l(12)
mov x0[3].x, l(60)
mov x0[4].x, l(3)
mov x0[5].x, l(51)
mov x0[6].x, l(15)
mov x0[7].x, l(63)
mov x0[8].x, l(32)
mov x0[9].x, l(16)
mov x0[10].x, l(44)
mov x0[11].x, l(28)
mov x0[12].x, l(35)
mov x0[13].x, l(19)
mov x0[14].x, l(47)
mov x0[15].x, l(31)
mov x0[16].x, l(8)
mov x0[17].x, l(56)
mov x0[18].x, l(4)
mov x0[19].x, l(52)
mov x0[20].x, l(11)
mov x0[21].x, l(59)
mov x0[22].x, l(7)
mov x0[23].x, l(55)
mov x0[24].x, l(40)
mov x0[25].x, l(24)
mov x0[26].x, l(36)
mov x0[27].x, l(20)
mov x0[28].x, l(43)
mov x0[29].x, l(27)
mov x0[30].x, l(39)
mov x0[31].x, l(23)
mov x0[32].x, l(2)
mov x0[33].x, l(50)
mov x0[34].x, l(14)
mov x0[35].x, l(62)
mov x0[36].x, l(1)
mov x0[37].x, l(49)
mov x0[38].x, l(13)
mov x0[39].x, l(61)
mov x0[40].x, l(34)
mov x0[41].x, l(18)
mov x0[42].x, l(46)
mov x0[43].x, l(30)
mov x0[44].x, l(33)
mov x0[45].x, l(17)
mov x0[46].x, l(45)
mov x0[47].x, l(29)
mov x0[48].x, l(10)
mov x0[49].x, l(58)
mov x0[50].x, l(6)
mov x0[51].x, l(54)
mov x0[52].x, l(9)
mov x0[53].x, l(57)
mov x0[54].x, l(5)
mov x0[55].x, l(53)
mov x0[56].x, l(42)
mov x0[57].x, l(26)
mov x0[58].x, l(38)
mov x0[59].x, l(22)
mov x0[60].x, l(41)
mov x0[61].x, l(25)
mov x0[62].x, l(37)
mov x0[63].x, l(21)
mul r0.xyzw, v1.xyxy, l(3440.000000, 1440.000000, 27520.000000, 11520.000000)
ge r1.xyzw, r0.zwzw, -r0.zwzw
movc r1.xyzw, r1.xyzw, l(8.000000,8.000000,0.125000,0.125000), l(-8.000000,-8.000000,-0.125000,-0.125000)
mul r0.xy, r0.xyxx, r1.zwzz
frc r0.xy, r0.xyxx
mul r0.xy, r0.xyxx, r1.xyxx
ftoi r0.xy, r0.xyxx
ishl r0.y, r0.y, l(3)
iadd r0.x, r0.y, r0.x
mov r0.x, x0[r0.x + 0].x
iadd r0.x, r0.x, l(1)
itof r0.x, r0.x
mul r0.x, r0.x, l(0.015625)
sample_indexable(texture2d)(float,float,float,float) r1.xyzw, v1.xyxx, t1.xyzw, s0
mul r2.xyzw, r1.xyzw, cb0[0].yyyy
round_ne r2.xyzw, r2.xyzw
div r2.xyzw, r2.xyzw, cb0[0].yyyy
lt r0.y, l(0.000000), cb0[0].y
movc r1.xyzw, r0.yyyy, r2.xyzw, r1.xyzw
dp3 r0.y, r1.xyzx, l(0.212600, 0.715200, 0.072200, 0.000000)
ge r0.x, r0.y, r0.x
and r0.y, r0.x, l(0x3f800000)
mul r0.yzw, r0.yyyy, r1.xxyz
mad r0.yzw, r0.yyzw, cb0[0].xxxx, r1.xxyz
add r2.x, -cb0[0].x, l(1.000000)
movc r0.x, r0.x, l(1.000000), r2.x
mul r1.xyz, r0.xxxx, r1.xyzx
mov o0.w, r1.w
movc o0.xyz, cb0[0].zzzz, r1.xyzx, r0.yzwy
ret 
// Approximately 94 instruction slots used
