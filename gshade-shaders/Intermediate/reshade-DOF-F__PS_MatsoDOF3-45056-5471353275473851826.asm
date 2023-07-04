//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   bool DOF_AUTOFOCUS;                // Offset:    0 Size:     4 [unused]
//   bool DOF_MOUSEDRIVEN_AF;           // Offset:    4 Size:     4 [unused]
//   float2 DOF_FOCUSPOINT;             // Offset:    8 Size:     8 [unused]
//   float DOF_FOCUSSAMPLES;            // Offset:   16 Size:     4 [unused]
//   float DOF_FOCUSRADIUS;             // Offset:   20 Size:     4 [unused]
//   float DOF_NEARBLURCURVE;           // Offset:   24 Size:     4
//   float DOF_FARBLURCURVE;            // Offset:   28 Size:     4 [unused]
//   float DOF_MANUALFOCUSDEPTH;        // Offset:   32 Size:     4 [unused]
//   float DOF_INFINITEFOCUS;           // Offset:   36 Size:     4 [unused]
//   float DOF_BLURRADIUS;              // Offset:   40 Size:     4
//   float iRingDOFSamples;             // Offset:   44 Size:     4 [unused]
//   float iRingDOFRings;               // Offset:   48 Size:     4 [unused]
//   float fRingDOFThreshold;           // Offset:   52 Size:     4 [unused]
//   float fRingDOFGain;                // Offset:   56 Size:     4 [unused]
//   float fRingDOFBias;                // Offset:   60 Size:     4 [unused]
//   float fRingDOFFringe;              // Offset:   64 Size:     4 [unused]
//   float iMagicDOFBlurQuality;        // Offset:   68 Size:     4 [unused]
//   float fMagicDOFColorCurve;         // Offset:   72 Size:     4 [unused]
//   float iGPDOFQuality;               // Offset:   76 Size:     4 [unused]
//   bool bGPDOFPolygonalBokeh;         // Offset:   80 Size:     4 [unused]
//   float iGPDOFPolygonCount;          // Offset:   84 Size:     4 [unused]
//   float fGPDOFBias;                  // Offset:   88 Size:     4 [unused]
//   float fGPDOFBiasCurve;             // Offset:   92 Size:     4 [unused]
//   float fGPDOFBrightnessThreshold;   // Offset:   96 Size:     4 [unused]
//   float fGPDOFBrightnessMultiplier;  // Offset:  100 Size:     4 [unused]
//   float fGPDOFChromaAmount;          // Offset:  104 Size:     4 [unused]
//   bool bMatsoDOFChromaEnable;        // Offset:  108 Size:     4
//   float fMatsoDOFChromaPow;          // Offset:  112 Size:     4
//   float fMatsoDOFBokehCurve;         // Offset:  116 Size:     4
//   float iMatsoDOFBokehQuality;       // Offset:  120 Size:     4
//   float fMatsoDOFBokehAngle;         // Offset:  124 Size:     4
//   int iADOF_ShapeType;               // Offset:  128 Size:     4 [unused]
//   float iADOF_ShapeQuality;          // Offset:  132 Size:     4 [unused]
//   float fADOF_ShapeRotation;         // Offset:  136 Size:     4 [unused]
//   bool bADOF_RotAnimationEnable;     // Offset:  140 Size:     4 [unused]
//   float fADOF_RotAnimationSpeed;     // Offset:  144 Size:     4 [unused]
//   bool bADOF_ShapeCurvatureEnable;   // Offset:  148 Size:     4 [unused]
//   float fADOF_ShapeCurvatureAmount;  // Offset:  152 Size:     4 [unused]
//   bool bADOF_ShapeApertureEnable;    // Offset:  156 Size:     4 [unused]
//   float fADOF_ShapeApertureAmount;   // Offset:  160 Size:     4 [unused]
//   bool bADOF_ShapeAnamorphEnable;    // Offset:  164 Size:     4 [unused]
//   float fADOF_ShapeAnamorphRatio;    // Offset:  168 Size:     4 [unused]
//   bool bADOF_ShapeDistortEnable;     // Offset:  172 Size:     4 [unused]
//   float fADOF_ShapeDistortAmount;    // Offset:  176 Size:     4 [unused]
//   bool bADOF_ShapeDiffusionEnable;   // Offset:  180 Size:     4 [unused]
//   float fADOF_ShapeDiffusionAmount;  // Offset:  184 Size:     4 [unused]
//   bool bADOF_ShapeWeightEnable;      // Offset:  188 Size:     4 [unused]
//   float fADOF_ShapeWeightCurve;      // Offset:  192 Size:     4 [unused]
//   float fADOF_ShapeWeightAmount;     // Offset:  196 Size:     4 [unused]
//   float fADOF_BokehCurve;            // Offset:  200 Size:     4 [unused]
//   bool bADOF_ShapeChromaEnable;      // Offset:  204 Size:     4 [unused]
//   int iADOF_ShapeChromaMode;         // Offset:  208 Size:     4 [unused]
//   float fADOF_ShapeChromaAmount;     // Offset:  212 Size:     4 [unused]
//   bool bADOF_ImageChromaEnable;      // Offset:  216 Size:     4 [unused]
//   float iADOF_ImageChromaHues;       // Offset:  220 Size:     4 [unused]
//   float fADOF_ImageChromaCurve;      // Offset:  224 Size:     4 [unused]
//   float fADOF_ImageChromaAmount;     // Offset:  228 Size:     4 [unused]
//   float fADOF_SmootheningAmount;     // Offset:  232 Size:     4 [unused]
//   float2 MouseCoords;                // Offset:  240 Size:     8 [unused]
//   float Timer;                       // Offset:  248 Size:     4 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__texHDR1                      texture  float4          2d             t0      1 
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
dcl_constantbuffer CB0[8], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 8
sample_indexable(texture2d)(float,float,float,float) r0.x, v1.xyxx, t0.wxyz, s0
mad r0.y, r0.x, l(2.000000), l(-1.000000)
mul r0.y, |r0.y|, cb0[2].z
lt r0.z, r0.x, l(0.500000)
add r0.w, cb0[1].z, cb0[1].z
max r0.w, r0.w, l(1.000000)
div r0.w, l(1.000000, 1.000000, 1.000000, 1.000000), r0.w
mul r0.w, r0.w, r0.y
movc r0.y, r0.z, r0.w, r0.y
ftoi r0.z, -cb0[7].z
round_z r0.w, -cb0[7].z
lt r0.w, r0.w, cb0[7].z
mul r1.x, cb0[7].w, l(0.017500)
sincos r1.x, r2.x, r1.x
mul r1.yz, r2.xxxx, l(0.000000, -0.306000, 0.739000, 0.000000)
mad r2.x, -r1.x, l(0.739000), r1.y
mad r2.y, r1.x, r2.x, r1.z
mul r1.x, r0.y, l(0.000145)
div r1.x, r1.x, cb0[7].z
mul r1.y, r1.x, cb0[7].x
mul r3.xyzw, r1.yyyy, l(-1.000000, -1.000000, 0.584962, 0.584962)
exp r3.xyzw, r3.xyzw
add r1.x, -r1.x, l(1.000000)
mov r1.yzw, l(0,0,0,0)
mov r2.z, cb0[6].w
mov r2.w, l(0)
mov r4.xy, r0.zwzz
loop 
  breakc_z r4.y
  itof r4.z, r4.x
  mul r5.xy, r2.xyxx, r4.zzzz
  mul r5.xy, r0.yyyy, r5.xyxx
  mul r5.xy, r5.xyxx, l(0.000145, 0.000347, 0.000000, 0.000000)
  div r5.xy, r5.xyxx, cb0[7].zzzz
  add r5.xy, r5.xyxx, v1.xyxx
  if_nz r2.z
    mad r5.zw, r5.xxxy, l(0.000000, 0.000000, 2.000000, 2.000000), l(0.000000, 0.000000, -1.000000, -1.000000)
    mul r6.xyzw, r3.xyzw, r5.zwzw
    mad r6.xyzw, r6.xyzw, l(0.500000, 0.500000, 0.500000, 0.500000), l(0.500000, 0.500000, 0.500000, 0.500000)
    sample_l_indexable(texture2d)(float,float,float,float) r7.x, r6.xyxx, t0.xyzw, s0, l(0.000000)
    mad r5.zw, r5.zzzw, l(0.000000, 0.000000, 0.500000, 0.500000), l(0.000000, 0.000000, 0.500000, 0.500000)
    sample_l_indexable(texture2d)(float,float,float,float) r7.y, r5.zwzz, t0.xyzw, s0, l(0.000000)
    sample_l_indexable(texture2d)(float,float,float,float) r7.z, r6.zwzz, t0.xyzw, s0, l(0.000000)
    mul r6.xyz, r1.xxxx, r7.xyzx
  else 
    sample_l_indexable(texture2d)(float,float,float,float) r6.xyz, r5.xyxx, t0.xyzw, s0, l(0.000000)
  endif 
  dp3 r4.w, r6.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
  dp3 r5.x, r6.xyzx, r6.xyzx
  sqrt r5.x, r5.x
  add r4.w, r4.w, r5.x
  add r4.w, r4.w, l(0.100000)
  log r4.w, |r4.w|
  mul r4.w, r4.w, cb0[7].y
  exp r4.w, r4.w
  add r4.z, |r4.z|, r4.w
  mad r1.yzw, r6.xxyz, r4.zzzz, r1.yyzw
  add r2.w, r2.w, r4.z
  iadd r4.x, r4.x, l(1)
  itof r4.z, r4.x
  lt r4.y, r4.z, cb0[7].z
endloop 
div o0.xyz, r1.yzwy, r2.wwww
mov o0.w, r0.x
ret 
// Approximately 65 instruction slots used
