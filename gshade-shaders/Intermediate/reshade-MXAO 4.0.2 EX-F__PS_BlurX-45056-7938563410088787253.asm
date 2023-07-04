//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int MXAO_GLOBAL_SAMPLE_QUALITY_PRESET;// Offset:    0 Size:     4 [unused]
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
// __s0                              sampler      NA          NA             s0      1 
// __V__ReShade__BackBufferTex       texture  float4          2d             t0      1 
// __V__MXAO_DepthTex                texture  float4          2d             t6      1 
// __V__MXAO_NormalTex               texture  float4          2d             t8      1 
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
// TEXCOORD                 1     zw        1     NONE   float       
// TEXCOORD                 2   x           2     NONE   float       
// TEXCOORD                 4    yzw        2     NONE   float       
// TEXCOORD                 5   xyz         3     NONE   float       
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
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t6
dcl_resource_texture2d (float,float,float,float) t8
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 4
dcl_indexableTemp x0[8], 4
mov r0.xy, v1.xyxx
mul r0.xy, r0.xyxx, cb0[0].wwww
sample_l_indexable(texture2d)(float,float,float,float) r0.x, r0.xyxx, t0.wxyz, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.yzw, v1.xyxx, t8.wxyz, s0, l(0.000000)
mad r0.yzw, r0.yyzw, l(0.000000, 2.000000, 2.000000, 2.000000), l(0.000000, -1.000000, -1.000000, -1.000000)
sample_l_indexable(texture2d)(float,float,float,float) r1.x, v1.xyxx, t6.xyzw, s0, l(0.000000)
mad r2.xy, v1.xyxx, l(2.000000, 2.000000, 0.000000, 0.000000), l(-1.000000, -1.000000, 0.000000, 0.000000)
mov r2.z, l(1.000000)
mul r1.yzw, r1.xxxx, r2.xxyz
dp3 r2.x, r1.yzwy, r1.yzwy
rsq r2.x, r2.x
mul r1.yzw, r1.yyzw, r2.xxxx
dp3 r1.y, r0.yzwy, r1.yzwy
mov_sat r1.y, -r1.y
div r1.y, l(0.150000), r1.y
mov r2.x, l(1.000000)
mov r2.y, r0.x
mov r1.zw, l(0,0,0,-1)
loop 
  breakc_z r1.w
  mov x0[0].xy, l(1.500000,0.500000,0,0)
  mov x0[1].xy, l(-1.500000,-0.500000,0,0)
  mov x0[2].xy, l(-0.500000,1.500000,0,0)
  mov x0[3].xy, l(0.500000,-1.500000,0,0)
  mov x0[4].xy, l(1.500000,2.500000,0,0)
  mov x0[5].xy, l(-1.500000,-2.500000,0,0)
  mov x0[6].xy, l(-2.500000,1.500000,0,0)
  mov x0[7].xy, l(2.500000,-1.500000,0,0)
  mov r2.zw, x0[r1.z + 0].xxxy
  mul r2.zw, r2.zzzw, l(0.000000, 0.000000, 0.000781, 0.001389)
  div r2.zw, r2.zzzw, cb0[0].wwww
  add r2.zw, r2.zzzw, v1.xxxy
  mul r3.xy, r2.zwzz, cb0[0].wwww
  sample_l_indexable(texture2d)(float,float,float,float) r3.x, r3.xyxx, t0.wxyz, s0, l(0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r3.yzw, r2.zwzz, t8.wxyz, s0, l(0.000000)
  mad r3.yzw, r3.yyzw, l(0.000000, 2.000000, 2.000000, 2.000000), l(0.000000, -1.000000, -1.000000, -1.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.z, r2.zwzz, t6.yzxw, s0, l(0.000000)
  add r2.z, -r1.x, r2.z
  dp3 r2.w, r3.yzwy, r0.yzwy
  add_sat r2.w, -r2.w, l(1.000000)
  add_sat r2.z, r1.y, -|r2.z|
  add r2.w, -r2.w, l(0.650000)
  max r2.w, r2.w, l(0.000000)
  mul r2.z, r2.w, r2.z
  mul r2.z, r2.z, l(4.000000)
  min r2.z, r2.z, l(1.000000)
  add r2.w, r2.z, r2.z
  mad r2.y, r3.x, r2.w, r2.y
  mad r2.x, r2.z, l(2.000000), r2.x
  iadd r1.z, r1.z, l(1)
  ilt r1.w, r1.z, l(8)
endloop 
div o0.w, r2.y, r2.x
mad o0.xyz, r0.yzwy, l(0.500000, 0.500000, 0.500000, 0.000000), l(0.500000, 0.500000, 0.500000, 0.000000)
ret 
// Approximately 55 instruction slots used
