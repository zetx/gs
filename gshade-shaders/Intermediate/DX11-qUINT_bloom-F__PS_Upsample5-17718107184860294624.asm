//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float BLOOM_INTENSITY;             // Offset:    0 Size:     4 [unused]
//   float BLOOM_CURVE;                 // Offset:    4 Size:     4 [unused]
//   float BLOOM_SAT;                   // Offset:    8 Size:     4 [unused]
//   float BLOOM_LAYER_MULT_1;          // Offset:   12 Size:     4 [unused]
//   float BLOOM_LAYER_MULT_2;          // Offset:   16 Size:     4
//   float BLOOM_LAYER_MULT_3;          // Offset:   20 Size:     4 [unused]
//   float BLOOM_LAYER_MULT_4;          // Offset:   24 Size:     4 [unused]
//   float BLOOM_LAYER_MULT_5;          // Offset:   28 Size:     4 [unused]
//   float BLOOM_LAYER_MULT_6;          // Offset:   32 Size:     4 [unused]
//   float BLOOM_LAYER_MULT_7;          // Offset:   36 Size:     4 [unused]
//   float BLOOM_ADAPT_STRENGTH;        // Offset:   40 Size:     4 [unused]
//   float BLOOM_ADAPT_EXPOSURE;        // Offset:   44 Size:     4 [unused]
//   float BLOOM_ADAPT_SPEED;           // Offset:   48 Size:     4 [unused]
//   float BLOOM_TONEMAP_COMPRESSION;   // Offset:   52 Size:     4 [unused]
//   float FRAME_TIME;                  // Offset:   56 Size:     4 [unused]
//   int FRAME_COUNT;                   // Offset:   60 Size:     4 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__MXBLOOM_BloomTex3            texture  float4          2d            t10      1 
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
dcl_resource_texture2d (float,float,float,float) t10
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 5
add r0.xyzw, v1.xyxy, l(-0.003488, -0.008333, 0.003488, 0.008333)
sample_l_indexable(texture2d)(float,float,float,float) r1.xyz, r0.xyxx, t10.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r0.zyzz, t10.xyzw, s0, l(0.000000)
add r1.xyz, r1.xyzx, r2.xyzx
sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r0.zwzz, t10.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r0.xyz, r0.xwxx, t10.xyzw, s0, l(0.000000)
add r1.xyz, r1.xyzx, r2.xyzx
add r0.xyz, r0.xyzx, r1.xyzx
mul r0.xyz, r0.xyzx, l(0.062500, 0.062500, 0.062500, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r1.xyz, v1.xyxx, t10.xyzw, s0
mad r0.xyz, r1.xyzx, l(0.250000, 0.250000, 0.250000, 0.000000), r0.xyzx
add r1.xyzw, v1.xyxy, l(0.003488, 0.000000, 0.000000, 0.008333)
sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r1.xyxx, t10.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t10.xyzw, s0, l(0.000000)
add r3.xyzw, v1.xyxy, l(-0.003488, 0.000000, 0.000000, -0.008333)
sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r3.xyxx, t10.xyzw, s0, l(0.000000)
sample_l_indexable(texture2d)(float,float,float,float) r3.xyz, r3.zwzz, t10.xyzw, s0, l(0.000000)
add r2.xyz, r2.xyzx, r4.xyzx
add r1.xyz, r1.xyzx, r2.xyzx
add r1.xyz, r3.xyzx, r1.xyzx
mad o0.xyz, r1.xyzx, l(0.125000, 0.125000, 0.125000, 0.000000), r0.xyzx
mov o0.w, cb0[1].x
ret 
// Approximately 23 instruction slots used
