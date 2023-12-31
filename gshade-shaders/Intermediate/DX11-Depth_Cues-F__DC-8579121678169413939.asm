//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int Depth_Map;                     // Offset:    0 Size:     4 [unused]
//   float Depth_Map_Adjust;            // Offset:    4 Size:     4 [unused]
//   bool Depth_Map_Flip;               // Offset:    8 Size:     4 [unused]
//   bool DEPTH_DEBUG;                  // Offset:   12 Size:     4 [unused]
//   bool No_Depth_Map;                 // Offset:   16 Size:     4 [unused]
//   float Shade_Power;                 // Offset:   20 Size:     4
//   float Blur_Cues;                   // Offset:   24 Size:     4 [unused]
//   float Spread;                      // Offset:   28 Size:     4
//   bool Debug_View;                   // Offset:   32 Size:     4 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__BackBufferTex                texture  float4          2d             t2      1 
// __V__texHB                        texture  float4          2d             t4      1 
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
// SV_TARGET                0   x           0   TARGET   float   x   
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[2], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t2
dcl_resource_texture2d (float,float,float,float) t4
dcl_input_ps linear v1.xy
dcl_output o0.x
dcl_temps 2
sample_l_indexable(texture2d)(float,float,float,float) r0.x, v1.xyxx, t4.xyzw, s0, l(1.000000)
mad r1.xyzw, cb0[1].wwww, l(0.000327, 0.000000, 0.000000, 0.000781), v1.xyxy
sample_l_indexable(texture2d)(float,float,float,float) r0.y, r1.xyxx, t4.yxzw, s0, l(1.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.z, r1.zwzz, t4.yzxw, s0, l(1.000000)
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
mad r1.xyzw, cb0[1].wwww, l(-0.000327, 0.000000, 0.000000, -0.000781), v1.xyxy
sample_l_indexable(texture2d)(float,float,float,float) r0.y, r1.xyxx, t4.yxzw, s0, l(1.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.z, r1.zwzz, t4.yzxw, s0, l(1.000000)
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
mad r1.xyzw, cb0[1].wwww, l(0.000164, 0.000000, 0.000000, 0.000391), v1.xyxy
sample_l_indexable(texture2d)(float,float,float,float) r0.y, r1.xyxx, t4.yxzw, s0, l(1.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.z, r1.zwzz, t4.yzxw, s0, l(1.000000)
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
mad r1.xyzw, cb0[1].wwww, l(-0.000164, 0.000000, 0.000000, -0.000391), v1.xyxy
sample_l_indexable(texture2d)(float,float,float,float) r0.y, r1.xyxx, t4.yxzw, s0, l(1.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.z, r1.zwzz, t4.yzxw, s0, l(1.000000)
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
mul r0.x, r0.x, l(0.111111)
sample_l_indexable(texture2d)(float,float,float,float) r0.yzw, v1.xyxx, t2.wxyz, s0, l(0.000000)
dp3 r0.y, r0.yzwy, l(0.212600, 0.715200, 0.072200, 0.000000)
div_sat r0.x, r0.y, r0.x
add r0.x, r0.x, l(-1.000000)
mad o0.x, cb0[1].y, r0.x, l(1.000000)
ret 
// Approximately 28 instruction slots used
