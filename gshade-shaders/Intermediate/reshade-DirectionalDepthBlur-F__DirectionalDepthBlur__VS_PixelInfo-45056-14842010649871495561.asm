//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float FocusPlane;                  // Offset:    0 Size:     4
//   float FocusRange;                  // Offset:    4 Size:     4
//   float FocusPlaneMaxRange;          // Offset:    8 Size:     4
//   float BlurAngle;                   // Offset:   12 Size:     4
//   float BlurLength;                  // Offset:   16 Size:     4
//   float BlurQuality;                 // Offset:   20 Size:     4 [unused]
//   float ScaleFactor;                 // Offset:   24 Size:     4
//   int BlurType;                      // Offset:   28 Size:     4 [unused]
//   float2 FocusPoint;                 // Offset:   32 Size:     8 [unused]
//   float3 FocusPointBlendColor;       // Offset:   48 Size:    12 [unused]
//   float FocusPointBlendFactor;       // Offset:   60 Size:     4 [unused]
//   float HighlightGain;               // Offset:   64 Size:     4 [unused]
//   float BlendFactor;                 // Offset:   68 Size:     4 [unused]
//   float2 MouseCoords;                // Offset:   72 Size:     8 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// _Globals                          cbuffer      NA          NA            cb0      1 
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
// TEXCOORD                 3    y          2     NONE   float    y  
// TEXCOORD                 4     z         2     NONE   float     z 
// TEXCOORD                 5   xyzw        3     NONE   float   xyzw
//
vs_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[2], immediateIndexed
dcl_input_sgv v0.x, vertex_id
dcl_output_siv o0.xyzw, position
dcl_output o1.xy
dcl_output o1.zw
dcl_output o2.x
dcl_output o2.y
dcl_output o2.z
dcl_output o3.xyzw
dcl_temps 3
mov o0.zw, l(0,0,0,1.000000)
ieq r0.xy, v0.xxxx, l(2, 1, 0, 0)
and r0.xy, r0.xyxx, l(0x40000000, 0x40000000, 0, 0)
mad o0.xy, r0.xyxx, l(2.000000, -2.000000, 0.000000, 0.000000), l(-1.000000, 1.000000, 0.000000, 0.000000)
mul r0.z, cb0[0].w, l(6.283185)
sincos r1.x, r2.x, r0.z
mov r0.z, r2.x
mov r0.w, r1.x
mul o1.zw, r0.zzzw, l(0.000000, 0.000000, 0.000753, 0.000753)
mov o1.xy, r0.xyxx
mul r0.zw, cb0[0].zzzz, cb0[0].xxxy
mul o2.yz, r0.zzwz, l(0.000000, 0.001000, 0.001000, 0.000000)
mul o2.x, cb0[1].x, l(3729.235840)
mul o3.xy, r0.xyxx, cb0[1].zzzz
div o3.zw, r0.xxxy, cb0[1].zzzz
ret 
// Approximately 16 instruction slots used
