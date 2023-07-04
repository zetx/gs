//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int iUIInfo;                       // Offset:    0 Size:     4 [unused]
//   int iUIWhiteLevelFormula;          // Offset:    4 Size:     4 [unused]
//   float3 f3UICurveWhiteParam;        // Offset:   16 Size:    12 [unused]
//   int iUIBlackLevelFormula;          // Offset:   28 Size:     4 [unused]
//   float3 f3UICurveBlackParam;        // Offset:   32 Size:    12 [unused]
//   float fUIColorTempScaling;         // Offset:   44 Size:     4 [unused]
//   float fUISaturation;               // Offset:   48 Size:     4 [unused]
//   float3 fUITintWarm;                // Offset:   52 Size:    12 [unused]
//   float3 fUITintCold;                // Offset:   64 Size:    12 [unused]
//   int iUIDebug;                      // Offset:   76 Size:     4 [unused]
//   float fUIStrength;                 // Offset:   80 Size:     4 [unused]
//   int2 AdaptiveTintDebugPosition;    // Offset:   84 Size:     8
//   float AdaptiveTintDebugOpacity;    // Offset:   92 Size:     4
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
// __V__texAdaptiveTintDebug         texture  float4          2d            t12      1 
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
// SV_TARGET                0   xyz         0   TARGET   float   xyz 
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[6], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t12
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 3
sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s0
mul r1.xy, v1.xyxx, l(3440.000000, 1440.000000, 0.000000, 0.000000)
resinfo_indexable(texture2d)(float,float,float,float)_uint r1.zw, l(0), t12.zwxy
itof r1.zw, r1.zzzw
add r2.xy, -r1.zwzz, l(3440.000000, 1440.000000, 0.000000, 0.000000)
itof r2.zw, cb0[5].yyyz
max r2.zw, r2.zzzw, l(0.000000, 0.000000, 0.000000, 0.000000)
min r2.xy, r2.xyxx, r2.zwzz
add r2.zw, r1.zzzw, r2.xxxy
ge r2.zw, r2.zzzw, r1.xxxy
and r0.w, r2.w, r2.z
ge r1.xy, r1.xyxx, r2.xyxx
and r0.w, r0.w, r1.x
and r0.w, r1.y, r0.w
if_nz r0.w
  mad r1.xy, v1.xyxx, l(3440.000000, 1440.000000, 0.000000, 0.000000), -r2.xyxx
  div r1.xy, r1.xyxx, r1.zwzz
  sample_indexable(texture2d)(float,float,float,float) r1.xyz, r1.xyxx, t12.xyzw, s0
  mov r0.w, cb0[5].w
else 
  mov r1.xyz, r0.xyzx
  mov r0.w, l(0)
endif 
add r1.xyz, -r0.xyzx, r1.xyzx
mad o0.xyz, r0.wwww, r1.xyzx, r0.xyzx
ret 
// Approximately 26 instruction slots used
