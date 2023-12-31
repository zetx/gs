//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   bool Cancel_Depth;                 // Offset:    0 Size:     4
//   bool Mask_Cycle;                   // Offset:    4 Size:     4 [unused]
//   bool Text_Info;                    // Offset:    8 Size:     4 [unused]
//   bool CLK;                          // Offset:   12 Size:     4 [unused]
//   bool Trigger_Fade_A;               // Offset:   16 Size:     4 [unused]
//   bool Trigger_Fade_B;               // Offset:   20 Size:     4 [unused]
//   bool overlay_open;                 // Offset:   24 Size:     4 [unused]
//   float2 Mousecoords;                // Offset:   32 Size:     8 [unused]
//   float frametime;                   // Offset:   40 Size:     4
//   float timer;                       // Offset:   44 Size:     4 [unused]
//   bool DepthCheck;                   // Offset:   48 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __s2                              sampler      NA          NA             s2      1 
// __V__DepthBufferTex               texture  float4          2d             t0      1 
// __V__texDMVR                      texture  float4          2d             t4      1 
// __V__texLumVR                     texture  float4          2d            t16      1 
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
// SV_TARGET                0   xy          0   TARGET   float   xy  
// SV_TARGET                1   x           1   TARGET   float   x   
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[4], immediateIndexed
dcl_sampler s0, mode_default
dcl_sampler s2, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t4
dcl_resource_texture2d (float,float,float,float) t16
dcl_input_ps linear v1.xy
dcl_output o0.xy
dcl_output o1.x
dcl_temps 2
sample_l_indexable(texture2d)(float,float,float,float) r0.x, v1.xyxx, t0.xyzw, s0, l(0.000000)
mad r0.x, r0.x, l(-58.999996), l(59.999996)
rcp r0.y, r0.x
mov_sat r0.y, r0.y
lt r0.zw, v1.xxxy, l(0.000000, 0.000000, 0.000581, 0.001389)
and r1.x, r0.w, r0.z
if_nz r1.x
  mov r1.x, r0.y
else 
  sample_l_indexable(texture2d)(float,float,float,float) r1.x, v1.xyxx, t4.xyzw, s2, l(0.000000)
endif 
add r1.yz, -v1.yyxy, l(0.000000, 1.000000, 1.000000, 0.000000)
lt r1.yz, r1.yyzy, l(0.000000, 0.001389, 0.000581, 0.000000)
and r1.w, r1.y, r1.z
if_nz r1.w
  mov r1.x, r0.y
endif 
and r0.zw, r0.zzzw, r1.yyyz
if_nz r0.z
  mov r1.x, r0.y
endif 
if_nz r0.w
  mov r1.x, r0.y
endif 
sample_l_indexable(texture2d)(float,float,float,float) r0.w, v1.xyxx, t16.xzwy, s2, l(11.000000)
mov_sat r0.w, r0.w
add r0.w, r0.w, l(0.017500)
mul r0.w, r0.w, l(8.510638)
min r0.w, r0.w, l(1.000000)
mad r1.y, r0.w, l(-2.000000), l(3.000000)
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, r1.y
div r0.w, r1.x, r0.w
min r0.w, r0.w, l(1.000000)
sample_indexable(texture2d)(float,float,float,float) r1.y, l(0.000000, 0.250000, 0.000000, 0.000000), t16.xzyw, s2
mov_sat r1.y, r1.y
mad r1.z, r1.y, l(-2.000000), l(3.000000)
mul r1.y, r1.y, r1.y
mul r1.y, r1.y, r1.z
mad r1.y, r1.y, l(-0.500000), l(1.000000)
mul r1.y, r1.y, l(0.025000)
div r1.y, r1.y, r0.w
add r1.y, -r1.y, l(1.000000)
add r0.w, r0.w, -r1.y
mad r0.w, r0.w, l(0.500000), r1.y
add r1.x, -r0.w, r1.x
add r1.y, r0.w, r0.w
mad r1.x, r0.y, r1.x, r1.y
mul r1.y, r1.x, l(0.500000)
mad r0.w, -r1.x, l(0.500000), r0.w
mad r0.x, r0.w, l(0.937500), r1.y
movc r0.xy, cb0[3].xxxx, r0.xyxx, l(0.062500,0.062500,0,0)
movc r1.xy, cb0[0].xxxx, l(0.062500,0.062500,0,0), r0.xyxx
if_nz r1.w
  sample_l_indexable(texture2d)(float,float,float,float) r0.x, l(0.500000, 0.500000, 0.000000, 0.000000), t0.xyzw, s0, l(0.000000)
  mad r0.x, r0.x, l(-58.999996), l(59.999996)
  rcp r0.x, r0.x
  mov_sat r0.x, r0.x
  mul r0.x, r0.x, l(4.000000)
  min r0.x, r0.x, l(1.000000)
  mad r0.y, r0.x, l(-2.000000), l(3.000000)
  mul r0.x, r0.x, r0.x
  mul r0.x, r0.x, r0.y
  min r0.x, r0.x, l(0.750000)
  sample_indexable(texture2d)(float,float,float,float) r0.y, l(0.000000, 0.750000, 0.000000, 0.000000), t16.xzyw, s2
  add r0.x, -r0.y, r0.x
  mul r0.w, cb0[2].z, l(-0.002885)
  exp r0.w, r0.w
  add r0.w, -r0.w, l(1.000000)
  mad r1.z, r0.x, r0.w, r0.y
else 
  mov r1.z, r1.y
endif 
if_nz r0.z
  sample_indexable(texture2d)(float,float,float,float) r0.x, l(0.000000, 0.916000, 0.000000, 0.000000), t16.zxyw, s2
  mul r0.z, cb0[2].z, l(-0.002885)
  exp r0.z, r0.z
  add r0.yz, -r0.xxzx, l(0.000000, 0.030000, 1.000000, 0.000000)
  mad r1.z, r0.y, r0.z, r0.x
endif 
mov o0.xy, r1.xzxx
mov o1.x, r1.x
ret 
// Approximately 83 instruction slots used
