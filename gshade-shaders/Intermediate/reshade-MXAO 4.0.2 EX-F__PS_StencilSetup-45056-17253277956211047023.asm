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
//   float MXAO_SAMPLE_RADIUS;          // Offset:    4 Size:     4
//   float MXAO_SAMPLE_NORMAL_BIAS;     // Offset:    8 Size:     4 [unused]
//   float MXAO_GLOBAL_RENDER_SCALE;    // Offset:   12 Size:     4 [unused]
//   float MXAO_SSAO_AMOUNT;            // Offset:   16 Size:     4 [unused]
//   float MXAO_SAMPLE_RADIUS_SECONDARY;// Offset:   20 Size:     4 [unused]
//   float MXAO_AMOUNT_FINE;            // Offset:   24 Size:     4 [unused]
//   float MXAO_AMOUNT_COARSE;          // Offset:   28 Size:     4 [unused]
//   float MXAO_GAMMA;                  // Offset:   32 Size:     4 [unused]
//   int MXAO_DEBUG_VIEW_ENABLE;        // Offset:   36 Size:     4 [unused]
//   int MXAO_BLEND_TYPE;               // Offset:   40 Size:     4 [unused]
//   float MXAO_FADE_DEPTH_START;       // Offset:   44 Size:     4 [unused]
//   float MXAO_FADE_DEPTH_END;         // Offset:   48 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__ReShade__DepthBufferTex      texture  float4          2d             t2      1 
// __V__MXAO_DepthTex                texture  float4          2d             t6      1 
// __V__MXAO_CullingTex              texture  float4          2d            t10      1 
// _Globals                          cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_POSITION              0   xyzw        0      POS   float       
// TEXCOORD                 0   xy          1     NONE   float       
// TEXCOORD                 1     zw        1     NONE   float     zw
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
dcl_constantbuffer CB0[4], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t2
dcl_resource_texture2d (float,float,float,float) t6
dcl_resource_texture2d (float,float,float,float) t10
dcl_input_ps linear v1.zw
dcl_output o0.xyzw
dcl_temps 2
sample_l_indexable(texture2d)(float,float,float,float) r0.x, v1.zwzz, t2.xyzw, s0, l(0.000000)
mad r0.y, -r0.x, l(999.000000), l(1000.000000)
div r0.x, r0.x, r0.y
ge r0.x, r0.x, cb0[3].x
mul r0.y, cb0[0].y, l(0.125000)
sample_indexable(texture2d)(float,float,float,float) r0.z, v1.zwzz, t6.yzxw, s0
add r0.z, r0.z, l(2.000000)
div r0.y, r0.y, r0.z
lt r0.y, r0.y, l(0.001302)
or r0.x, r0.y, r0.x
lt r0.yz, l(0.000000, 1.000000, 1.000000, 0.000000), v1.zzwz
or r0.x, r0.y, r0.x
or r0.x, r0.z, r0.x
add r1.xyzw, v1.zwzw, l(0.007812, 0.010417, -0.007812, 0.010417)
sample_indexable(texture2d)(float,float,float,float) r0.y, r1.xyxx, t10.yxzw, s0
sample_indexable(texture2d)(float,float,float,float) r0.z, r1.zwzz, t10.yzxw, s0
add r0.y, r0.z, r0.y
add r1.xyzw, v1.zwzw, l(0.007812, -0.010417, -0.007812, -0.010417)
sample_indexable(texture2d)(float,float,float,float) r0.z, r1.xyxx, t10.yzxw, s0
add r0.y, r0.z, r0.y
sample_indexable(texture2d)(float,float,float,float) r0.z, r1.zwzz, t10.yzxw, s0
add r0.y, r0.z, r0.y
ge r0.y, l(0.000001), r0.y
or r0.x, r0.y, r0.x
discard_nz r0.x
mov o0.xyzw, l(1.000000,1.000000,1.000000,1.000000)
ret 
// Approximately 27 instruction slots used
