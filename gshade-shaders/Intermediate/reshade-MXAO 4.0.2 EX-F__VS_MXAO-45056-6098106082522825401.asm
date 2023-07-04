//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int MXAO_GLOBAL_SAMPLE_QUALITY_PRESET;// Offset:    0 Size:     4
//   float MXAO_SAMPLE_RADIUS;          // Offset:    4 Size:     4 [unused]
//   float MXAO_SAMPLE_NORMAL_BIAS;     // Offset:    8 Size:     4 [unused]
//   float MXAO_GLOBAL_RENDER_SCALE;    // Offset:   12 Size:     4
//   float MXAO_SSAO_AMOUNT;            // Offset:   16 Size:     4 [unused]
//   float MXAO_SAMPLE_RADIUS_SECONDARY;// Offset:   20 Size:     4 [unused]
//   float MXAO_AMOUNT_FINE;            // Offset:   24 Size:     4 [unused]
//   float MXAO_AMOUNT_COARSE;          // Offset:   28 Size:     4 [unused]
//   float MXAO_GAMMA;                  // Offset:   32 Size:     4 [unused]
//   int MXAO_DEBUG_VIEW_ENABLE;        // Offset:   36 Size:     4 [unused]
//   int MXAO_BLEND_TYPE;               // Offset:   40 Size:     4 [unused]
//   float MXAO_FADE_DEPTH_START;       // Offset:   44 Size:     4 [unused]
//   float MXAO_FADE_DEPTH_END;         // Offset:   48 Size:     4 [unused]
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
// TEXCOORD                 4    yzw        2     NONE   float    yzw
// TEXCOORD                 5   xyz         3     NONE   float   xyz 
//
vs_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[1], immediateIndexed
dcl_input_sgv v0.x, vertex_id
dcl_output_siv o0.xyzw, position
dcl_output o1.xy
dcl_output o1.zw
dcl_output o2.x
dcl_output o2.yzw
dcl_output o3.xyz
dcl_temps 2
mov o0.zw, l(0,0,0,1.000000)
ieq r0.xy, v0.xxxx, l(2, 1, 0, 0)
and r0.xy, r0.xyxx, l(0x40000000, 0x40000000, 0, 0)
mad o0.xy, r0.xyxx, l(2.000000, -2.000000, 0.000000, 0.000000), l(-1.000000, 1.000000, 0.000000, 0.000000)
div o1.zw, r0.xxxy, cb0[0].wwww
mov o1.xy, r0.xyxx
ieq r0.xy, cb0[0].xxxx, l(5, 6, 0, 0)
movc r0.y, r0.y, l(255.000000), l(8.000000)
movc r0.x, r0.x, l(64.000000), r0.y
ieq r1.xyzw, cb0[0].xxxx, l(1, 2, 3, 4)
movc r0.x, r1.w, l(32.000000), r0.x
movc r0.x, r1.z, l(24.000000), r0.x
movc r0.x, r1.y, l(16.000000), r0.x
movc r0.x, r1.x, l(8.000000), r0.x
movc o2.x, cb0[0].x, r0.x, l(4.000000)
mov o2.yzw, l(0,-1.000000,-1.000000,1.000000)
mov o3.xyz, l(2.000000,2.000000,0,0)
ret 
// Approximately 18 instruction slots used