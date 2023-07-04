//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_VERTEXID              0   x           0   VERTID    uint   x   
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_POSITION              0   xyzw        0      POS   float   xyzw
// TEXCOORD                 0   xy          1     NONE   float   xy  
// TEXCOORD                 1     zw        1     NONE   float     zw
// TEXCOORD                 2   x           2     NONE   float   x   
// TEXCOORD                 4    yzw        2     NONE   float    yzw
// TEXCOORD                 5   xyz         3     NONE   float   xyz 
//
vs_5_0
dcl_globalFlags refactoringAllowed
dcl_input_sgv v0.x, vertex_id
dcl_output_siv o0.xyzw, position
dcl_output o1.xy
dcl_output o1.zw
dcl_output o2.x
dcl_output o2.yzw
dcl_output o3.xyz
dcl_temps 1
mov o0.zw, l(0,0,0,1.000000)
ieq r0.xy, v0.xxxx, l(2, 1, 0, 0)
and r0.xy, r0.xyxx, l(0x40000000, 0x40000000, 0, 0)
mad o0.xy, r0.xyxx, l(2.000000, -2.000000, 0.000000, 0.000000), l(-1.000000, 1.000000, 0.000000, 0.000000)
mul o1.zw, r0.xxxy, l(0.000000, 0.000000, 2.000000, 2.000000)
mov o1.xy, r0.xyxx
mov o2.xyzw, l(24.000000,-1.000000,-1.000000,1.000000)
mov o3.xyz, l(2.000000,2.000000,0,0)
ret 
// Approximately 9 instruction slots used