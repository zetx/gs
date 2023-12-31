//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int iBloomMixmode;                 // Offset:    0 Size:     4 [unused]
//   float fBloomThreshold;             // Offset:    4 Size:     4 [unused]
//   float fBloomAmount;                // Offset:    8 Size:     4 [unused]
//   float fBloomSaturation;            // Offset:   12 Size:     4 [unused]
//   float3 fBloomTint;                 // Offset:   16 Size:    12 [unused]
//   bool bLensdirtEnable;              // Offset:   28 Size:     4 [unused]
//   int iLensdirtMixmode;              // Offset:   32 Size:     4 [unused]
//   float fLensdirtIntensity;          // Offset:   36 Size:     4 [unused]
//   float fLensdirtSaturation;         // Offset:   40 Size:     4 [unused]
//   float3 fLensdirtTint;              // Offset:   48 Size:    12 [unused]
//   bool bAnamFlareEnable;             // Offset:   60 Size:     4
//   float fAnamFlareThreshold;         // Offset:   64 Size:     4 [unused]
//   float fAnamFlareWideness;          // Offset:   68 Size:     4 [unused]
//   float fAnamFlareAmount;            // Offset:   72 Size:     4 [unused]
//   float fAnamFlareCurve;             // Offset:   76 Size:     4 [unused]
//   float3 fAnamFlareColor;            // Offset:   80 Size:    12 [unused]
//   bool bLenzEnable;                  // Offset:   92 Size:     4 [unused]
//   float fLenzIntensity;              // Offset:   96 Size:     4 [unused]
//   float fLenzThreshold;              // Offset:  100 Size:     4 [unused]
//   bool bChapFlareEnable;             // Offset:  104 Size:     4
//   float fChapFlareTreshold;          // Offset:  108 Size:     4
//   int iChapFlareCount;               // Offset:  112 Size:     4
//   float fChapFlareDispersal;         // Offset:  116 Size:     4
//   float fChapFlareSize;              // Offset:  120 Size:     4
//   float3 fChapFlareCA;               // Offset:  128 Size:    12
//   float fChapFlareIntensity;         // Offset:  140 Size:     4
//   bool bGodrayEnable;                // Offset:  144 Size:     4
//   float fGodrayDecay;                // Offset:  148 Size:     4
//   float fGodrayExposure;             // Offset:  152 Size:     4 [unused]
//   float fGodrayWeight;               // Offset:  156 Size:     4
//   float fGodrayDensity;              // Offset:  160 Size:     4
//   float fGodrayThreshold;            // Offset:  164 Size:     4
//   int iGodraySamples;                // Offset:  168 Size:     4
//   float fFlareLuminance;             // Offset:  172 Size:     4
//   float fFlareBlur;                  // Offset:  176 Size:     4
//   float fFlareIntensity;             // Offset:  180 Size:     4
//   float3 fFlareTint;                 // Offset:  192 Size:    12
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__ReShade__BackBufferTex       texture  float4          2d            t18      1 
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
dcl_constantbuffer CB0[13], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t18
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 8
if_nz cb0[6].z
  add r0.xy, -v1.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000)
  mul r0.xy, r0.xyxx, cb0[7].yyyy
  dp2 r0.z, r0.xyxx, r0.xyxx
  rsq r0.z, r0.z
  mul r0.zw, r0.zzzz, r0.xxxy
  mul r1.xy, r0.zwzz, cb0[7].zzzz
  mad r0.zw, r0.zzzw, cb0[7].zzzz, v1.xxxy
  mul r2.xyz, cb0[8].xyzx, l(2.500000, 2.500000, 2.500000, 0.000000)
  min r1.z, r2.y, r2.x
  min r1.z, r2.z, r1.z
  mad r1.zw, r1.xxxy, r1.zzzz, r0.zzzw
  lt r3.xy, l(1.000000, 1.000000, 0.000000, 0.000000), r1.zwzz
  or r2.w, r3.y, r3.x
  lt r1.zw, r1.zzzw, l(0.000000, 0.000000, -1.000000, -1.000000)
  or r1.z, r1.z, r2.w
  or r1.z, r1.w, r1.z
  if_nz r1.z
    mov r3.xyz, l(0,0,0,0)
  else 
    mad r4.xyzw, r1.xyxy, r2.xxyy, r0.zwzw
    sample_l_indexable(texture2d)(float,float,float,float) r2.xyw, r4.xyxx, t18.xywz, s0, l(4.000000)
    dp3 r1.z, r2.xywx, l(0.333000, 0.333000, 0.333000, 0.000000)
    add r1.z, r1.z, -cb0[6].w
    max r1.z, r1.z, l(0.000000)
    mul r3.x, r1.z, cb0[8].w
    sample_l_indexable(texture2d)(float,float,float,float) r2.xyw, r4.zwzz, t18.xywz, s0, l(4.000000)
    dp3 r1.z, r2.xywx, l(0.333000, 0.333000, 0.333000, 0.000000)
    add r1.z, r1.z, -cb0[6].w
    max r1.z, r1.z, l(0.000000)
    mul r3.y, r1.z, cb0[8].w
    mad r0.zw, r1.xxxy, r2.zzzz, r0.zzzw
    sample_l_indexable(texture2d)(float,float,float,float) r1.xyz, r0.zwzz, t18.xyzw, s0, l(4.000000)
    dp3 r0.z, r1.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
    add r0.z, r0.z, -cb0[6].w
    max r0.z, r0.z, l(0.000000)
    mul r3.z, r0.z, cb0[8].w
  endif 
  ilt r0.z, l(0), cb0[7].x
  min r0.w, cb0[8].y, cb0[8].x
  min r0.w, r0.w, cb0[8].z
  mov r1.xyz, r3.xyzx
  mov r1.w, l(0)
  mov r2.x, r0.z
  loop 
    breakc_z r2.x
    itof r2.y, r1.w
    mul r2.zw, r0.xxxy, r2.yyyy
    mad r4.xy, r0.xyxx, r2.yyyy, v1.xyxx
    mad r4.zw, r2.zzzw, r0.wwww, r4.xxxy
    lt r5.xy, l(1.000000, 1.000000, 0.000000, 0.000000), r4.zwzz
    or r2.y, r5.y, r5.x
    lt r4.zw, r4.zzzw, l(0.000000, 0.000000, -1.000000, -1.000000)
    or r2.y, r2.y, r4.z
    or r2.y, r4.w, r2.y
    if_nz r2.y
      mov r5.xyz, l(0,0,0,0)
    else 
      mad r6.xyzw, r2.zwzw, cb0[8].xxyy, r4.xyxy
      sample_l_indexable(texture2d)(float,float,float,float) r7.xyz, r6.xyxx, t18.xyzw, s0, l(4.000000)
      dp3 r2.y, r7.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
      add r2.y, r2.y, -cb0[6].w
      max r2.y, r2.y, l(0.000000)
      mul r5.x, r2.y, cb0[8].w
      sample_l_indexable(texture2d)(float,float,float,float) r6.xyz, r6.zwzz, t18.xyzw, s0, l(4.000000)
      dp3 r2.y, r6.xyzx, l(0.333000, 0.333000, 0.333000, 0.000000)
      add r2.y, r2.y, -cb0[6].w
      max r2.y, r2.y, l(0.000000)
      mul r5.y, r2.y, cb0[8].w
      mad r2.yz, r2.zzwz, cb0[8].zzzz, r4.xxyx
      sample_l_indexable(texture2d)(float,float,float,float) r2.yzw, r2.yzyy, t18.wxyz, s0, l(4.000000)
      dp3 r2.y, r2.yzwy, l(0.333000, 0.333000, 0.333000, 0.000000)
      add r2.y, r2.y, -cb0[6].w
      max r2.y, r2.y, l(0.000000)
      mul r5.z, r2.y, cb0[8].w
    endif 
    add r1.xyz, r1.xyzx, r5.xyzx
    iadd r1.w, r1.w, l(1)
    ilt r2.x, r1.w, cb0[7].x
  endloop 
  itof r0.x, cb0[7].x
  div r0.xyz, r1.xyzx, r0.xxxx
else 
  mov r0.xyz, l(0,0,0,0)
endif 
if_nz cb0[9].x
  add r1.xy, v1.xyxx, l(-0.500000, -0.500000, 0.000000, 0.000000)
  itof r0.w, cb0[10].z
  mul r0.w, r0.w, cb0[10].x
  div r1.xy, r1.xyxx, r0.wwww
  add r1.xy, -r1.xyxx, v1.xyxx
  sample_l_indexable(texture2d)(float,float,float,float) r1.xyz, r1.xyxx, t18.xyzw, s0, l(0.000000)
  dp3 r0.w, r1.xyzx, l(0.333300, 0.333300, 0.333300, 0.000000)
  add_sat r2.w, r0.w, -cb0[10].y
  ilt r0.w, l(0), cb0[10].z
  mul r2.xyz, r1.xyzx, l(1.000000, 0.950000, 0.850000, 0.000000)
  mov r1.xyz, r0.xyzx
  mov r3.x, l(1.000000)
  mov r1.w, l(0)
  mov r3.z, r0.w
  loop 
    breakc_z r3.z
    mul r3.xy, r3.xxxx, cb0[9].ywyy
    mul r4.xyzw, r2.xyzw, r3.yyyy
    mad r1.xyz, r4.xyzx, r4.wwww, r1.xyzx
    iadd r1.w, r1.w, l(1)
    ilt r3.z, r1.w, cb0[10].z
  endloop 
  mov r0.xyz, r1.xyzx
endif 
if_nz cb0[3].w
  add r1.xy, v1.xyxx, l(0.000000, -0.005556, 0.000000, 0.000000)
  mad r1.yz, r1.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
  div r1.x, r1.y, -cb0[11].x
  mad r1.xy, r1.xzxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r1.xyz, r1.xyxx, t18.xyzw, s0, l(0.000000)
  add r2.xyz, r1.xyzx, -cb0[10].wwww
  max r2.xyz, r2.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r2.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r1.xyz, r1.xyzx, r0.wwww
  mul r1.xyz, r1.xyzx, cb0[12].xyzx
  add r2.xy, v1.xyxx, l(0.000000, -0.004167, 0.000000, 0.000000)
  mad r2.yz, r2.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
  div r2.x, r2.y, -cb0[11].x
  mad r2.xy, r2.xzxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.xyxx, t18.xyzw, s0, l(0.000000)
  add r3.xyz, r2.xyzx, -cb0[10].wwww
  max r3.xyz, r3.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r3.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mul r2.xyz, r2.xyzx, cb0[12].xyzx
  mul r2.xyz, r2.xyzx, l(0.054054, 0.054054, 0.054054, 0.000000)
  mad r1.xyz, r1.xyzx, l(0.016216, 0.016216, 0.016216, 0.000000), r2.xyzx
  add r2.xy, v1.xyxx, l(0.000000, -0.002778, 0.000000, 0.000000)
  mad r2.yz, r2.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
  div r2.x, r2.y, -cb0[11].x
  mad r2.xy, r2.xzxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.xyxx, t18.xyzw, s0, l(0.000000)
  add r3.xyz, r2.xyzx, -cb0[10].wwww
  max r3.xyz, r3.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r3.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mul r2.xyz, r2.xyzx, cb0[12].xyzx
  mad r1.xyz, r2.xyzx, l(0.121622, 0.121622, 0.121622, 0.000000), r1.xyzx
  add r2.xy, v1.xyxx, l(0.000000, -0.001389, 0.000000, 0.000000)
  mad r2.yz, r2.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
  div r2.x, r2.y, -cb0[11].x
  mad r2.xy, r2.xzxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.xyxx, t18.xyzw, s0, l(0.000000)
  add r3.xyz, r2.xyzx, -cb0[10].wwww
  max r3.xyz, r3.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r3.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mul r2.xyz, r2.xyzx, cb0[12].xyzx
  mad r1.xyz, r2.xyzx, l(0.194595, 0.194595, 0.194595, 0.000000), r1.xyzx
  mad r0.w, v1.x, l(2.000000), l(-1.000000)
  div r2.x, r0.w, -cb0[11].x
  mad r2.y, v1.y, l(2.000000), l(-1.000000)
  mad r2.xy, r2.xyxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.xyxx, t18.xyzw, s0, l(0.000000)
  add r3.xyz, r2.xyzx, -cb0[10].wwww
  max r3.xyz, r3.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r3.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mul r2.xyz, r2.xyzx, cb0[12].xyzx
  mad r1.xyz, r2.xyzx, l(0.227027, 0.227027, 0.227027, 0.000000), r1.xyzx
  add r2.xy, v1.xyxx, l(0.000000, 0.001389, 0.000000, 0.000000)
  mad r2.yz, r2.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
  div r2.x, r2.y, -cb0[11].x
  mad r2.xy, r2.xzxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.xyxx, t18.xyzw, s0, l(0.000000)
  add r3.xyz, r2.xyzx, -cb0[10].wwww
  max r3.xyz, r3.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r3.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mul r2.xyz, r2.xyzx, cb0[12].xyzx
  mad r1.xyz, r2.xyzx, l(0.194595, 0.194595, 0.194595, 0.000000), r1.xyzx
  add r2.xy, v1.xyxx, l(0.000000, 0.002778, 0.000000, 0.000000)
  mad r2.yz, r2.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
  div r2.x, r2.y, -cb0[11].x
  mad r2.xy, r2.xzxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.xyxx, t18.xyzw, s0, l(0.000000)
  add r3.xyz, r2.xyzx, -cb0[10].wwww
  max r3.xyz, r3.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r3.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mul r2.xyz, r2.xyzx, cb0[12].xyzx
  mad r1.xyz, r2.xyzx, l(0.121622, 0.121622, 0.121622, 0.000000), r1.xyzx
  add r2.xy, v1.xyxx, l(0.000000, 0.004167, 0.000000, 0.000000)
  mad r2.yz, r2.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
  div r2.x, r2.y, -cb0[11].x
  mad r2.xy, r2.xzxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.xyxx, t18.xyzw, s0, l(0.000000)
  add r3.xyz, r2.xyzx, -cb0[10].wwww
  max r3.xyz, r3.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r3.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mul r2.xyz, r2.xyzx, cb0[12].xyzx
  mad r1.xyz, r2.xyzx, l(0.054054, 0.054054, 0.054054, 0.000000), r1.xyzx
  add r2.xy, v1.xyxx, l(0.000000, 0.005556, 0.000000, 0.000000)
  mad r2.yz, r2.xxyx, l(0.000000, 2.000000, 2.000000, 0.000000), l(0.000000, -1.000000, -1.000000, 0.000000)
  div r2.x, r2.y, -cb0[11].x
  mad r2.xy, r2.xzxx, l(0.500000, 0.500000, 0.000000, 0.000000), l(0.500000, 0.500000, 0.000000, 0.000000)
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.xyxx, t18.xyzw, s0, l(0.000000)
  add r3.xyz, r2.xyzx, -cb0[10].wwww
  max r3.xyz, r3.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
  dp3 r0.w, r3.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
  add r0.w, r0.w, r0.w
  min r0.w, r0.w, l(1.000000)
  mad r1.w, r0.w, l(-2.000000), l(3.000000)
  mul r0.w, r0.w, r0.w
  mul r0.w, r0.w, r1.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mul r2.xyz, r2.xyzx, cb0[12].xyzx
  mad r1.xyz, r2.xyzx, l(0.016216, 0.016216, 0.016216, 0.000000), r1.xyzx
  mad r0.xyz, r1.xyzx, cb0[11].yyyy, r0.xyzx
endif 
mov o0.xyz, r0.xyzx
mov o0.w, l(0)
ret 
// Approximately 260 instruction slots used
