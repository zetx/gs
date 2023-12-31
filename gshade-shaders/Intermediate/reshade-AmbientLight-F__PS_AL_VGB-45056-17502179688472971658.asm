//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   bool alDebug;                      // Offset:    0 Size:     4 [unused]
//   float alInt;                       // Offset:    4 Size:     4 [unused]
//   float alThreshold;                 // Offset:    8 Size:     4
//   bool AL_Dither;                    // Offset:   12 Size:     4 [unused]
//   bool AL_Adaptation;                // Offset:   16 Size:     4 [unused]
//   float alAdapt;                     // Offset:   20 Size:     4 [unused]
//   float alAdaptBaseMult;             // Offset:   24 Size:     4 [unused]
//   int alAdaptBaseBlackLvL;           // Offset:   28 Size:     4 [unused]
//   bool AL_Dirt;                      // Offset:   32 Size:     4 [unused]
//   bool AL_DirtTex;                   // Offset:   36 Size:     4 [unused]
//   bool AL_Vibrance;                  // Offset:   40 Size:     4 [unused]
//   int AL_Adaptive;                   // Offset:   44 Size:     4 [unused]
//   float alDirtInt;                   // Offset:   48 Size:     4 [unused]
//   float alDirtOVInt;                 // Offset:   52 Size:     4 [unused]
//   bool AL_Lens;                      // Offset:   56 Size:     4 [unused]
//   float alLensThresh;                // Offset:   60 Size:     4 [unused]
//   float alLensInt;                   // Offset:   64 Size:     4 [unused]
//   float2 AL_t;                       // Offset:   68 Size:     8
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__alOutTex                     texture  float4          2d             t6      1 
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
dcl_constantbuffer CB0[5], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t6
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 5
sample_indexable(texture2d)(float,float,float,float) r0.xyzw, v1.xyxx, t6.xyzw, s0
mad r0.xyz, r0.xyzx, l(0.168190, 0.168190, 0.168190, 0.000000), -cb0[0].zzzz
mul r1.w, r0.w, l(0.168190)
max r1.xyz, r0.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
add r0.xyzw, v1.yxyy, l(0.027053, 0.000000, 0.027053, -0.027053)
lt r0.x, r0.x, l(1.050000)
sample_indexable(texture2d)(float,float,float,float) r2.xyzw, r0.yzyy, t6.xyzw, s0
lt r0.y, l(-0.050000), r0.w
mad r0.z, cb0[4].y, l(0.000200), l(1.080000)
mul r2.xyzw, r0.zzzz, r2.xyzw
mad r2.xyzw, r2.xyzw, l(0.272770, 0.272770, 0.272770, 0.272770), r1.xyzw
movc r1.xyzw, r0.xxxx, r2.xyzw, r1.xyzw
add r2.xyzw, v1.xyyy, l(-0.000000, -0.027053, 0.048309, -0.048309)
sample_indexable(texture2d)(float,float,float,float) r3.xyzw, r2.xyxx, t6.xyzw, s0
mul r3.xyzw, r0.zzzz, r3.xyzw
mad r3.xyzw, r3.xyzw, l(0.272770, 0.272770, 0.272770, 0.272770), r1.xyzw
movc r1.xyzw, r0.yyyy, r3.xyzw, r1.xyzw
add r3.xyzw, v1.xyxy, l(0.000000, 0.048309, -0.000000, -0.048309)
sample_indexable(texture2d)(float,float,float,float) r4.xyzw, r3.xyxx, t6.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r3.xyzw, r3.zwzz, t6.xyzw, s0
mul r3.xyzw, r0.zzzz, r3.xyzw
mul r4.xyzw, r0.zzzz, r4.xyzw
mad r4.xyzw, r4.xyzw, l(0.111690, 0.111690, 0.111690, 0.111690), r1.xyzw
lt r0.x, r2.z, l(1.050000)
lt r0.y, l(-0.050000), r2.w
movc r1.xyzw, r0.xxxx, r4.xyzw, r1.xyzw
mad r2.xyzw, r3.xyzw, l(0.111690, 0.111690, 0.111690, 0.111690), r1.xyzw
movc r1.xyzw, r0.yyyy, r2.xyzw, r1.xyzw
add r2.xyzw, v1.yxyy, l(0.069565, 0.000000, 0.069565, -0.069565)
sample_indexable(texture2d)(float,float,float,float) r3.xyzw, r2.yzyy, t6.xyzw, s0
mul r3.xyzw, r0.zzzz, r3.xyzw
mad r3.xyzw, r3.xyzw, l(0.024068, 0.024068, 0.024068, 0.024068), r1.xyzw
lt r0.x, r2.x, l(1.050000)
lt r0.y, l(-0.050000), r2.w
movc r1.xyzw, r0.xxxx, r3.xyzw, r1.xyzw
add r2.xyzw, v1.xyyy, l(-0.000000, -0.069565, 0.090821, -0.090821)
sample_indexable(texture2d)(float,float,float,float) r3.xyzw, r2.xyxx, t6.xyzw, s0
mul r3.xyzw, r0.zzzz, r3.xyzw
mad r3.xyzw, r3.xyzw, l(0.024068, 0.024068, 0.024068, 0.024068), r1.xyzw
movc r1.xyzw, r0.yyyy, r3.xyzw, r1.xyzw
add r3.xyzw, v1.xyxy, l(0.000000, 0.090821, -0.000000, -0.090821)
sample_indexable(texture2d)(float,float,float,float) r4.xyzw, r3.xyxx, t6.xyzw, s0
sample_indexable(texture2d)(float,float,float,float) r3.xyzw, r3.zwzz, t6.xyzw, s0
mul r3.xyzw, r0.zzzz, r3.xyzw
mul r0.xyzw, r0.zzzz, r4.xyzw
mad r0.xyzw, r0.xyzw, l(0.002111, 0.002111, 0.002111, 0.002111), r1.xyzw
lt r2.x, r2.z, l(1.050000)
lt r2.y, l(-0.050000), r2.w
movc r0.xyzw, r2.xxxx, r0.xyzw, r1.xyzw
mad r1.xyzw, r3.xyzw, l(0.002111, 0.002111, 0.002111, 0.002111), r0.xyzw
movc o0.xyzw, r2.yyyy, r1.xyzw, r0.xyzw
ret 
// Approximately 52 instruction slots used
