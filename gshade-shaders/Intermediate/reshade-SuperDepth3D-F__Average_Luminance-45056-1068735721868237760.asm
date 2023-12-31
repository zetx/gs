//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   float Divergence;                  // Offset:    0 Size:     4 [unused]
//   float2 ZPD_Separation;             // Offset:    4 Size:     8 [unused]
//   int Auto_Balance_Ex;               // Offset:   12 Size:     4
//   int ZPD_Boundary;                  // Offset:   16 Size:     4 [unused]
//   float2 ZPD_Boundary_n_Fade;        // Offset:   20 Size:     8 [unused]
//   int View_Mode;                     // Offset:   28 Size:     4 [unused]
//   int Custom_Sidebars;               // Offset:   32 Size:     4 [unused]
//   float Max_Depth;                   // Offset:   36 Size:     4 [unused]
//   int Performance_Level;             // Offset:   40 Size:     4 [unused]
//   float DLSS_FSR_Offset;             // Offset:   44 Size:     4
//   int Depth_Map;                     // Offset:   48 Size:     4
//   float Depth_Map_Adjust;            // Offset:   52 Size:     4
//   float Offset;                      // Offset:   56 Size:     4
//   float Auto_Depth_Adjust;           // Offset:   60 Size:     4 [unused]
//   int Depth_Detection;               // Offset:   64 Size:     4 [unused]
//   int Depth_Map_View;                // Offset:   68 Size:     4 [unused]
//   bool Depth_Map_Flip;               // Offset:   72 Size:     4
//   int WP;                            // Offset:   76 Size:     4
//   float4 Weapon_Adjust;              // Offset:   80 Size:    16
//   float3 WZPD_and_WND;               // Offset:   96 Size:    12 [unused]
//   int FPSDFIO;                       // Offset:  108 Size:     4 [unused]
//   int3 Eye_Fade_Reduction_n_Power;   // Offset:  112 Size:    12 [unused]
//   float Weapon_ZPD_Boundary;         // Offset:  124 Size:     4 [unused]
//   int Stereoscopic_Mode;             // Offset:  128 Size:     4 [unused]
//   float3 Interlace_Anaglyph_Calibrate;// Offset:  132 Size:    12 [unused]
//   int Scaling_Support;               // Offset:  144 Size:     4 [unused]
//   int Perspective;                   // Offset:  148 Size:     4 [unused]
//   bool Eye_Swap;                     // Offset:  152 Size:     4 [unused]
//   int Cursor_Type;                   // Offset:  156 Size:     4 [unused]
//   int2 Cursor_SC;                    // Offset:  160 Size:     8 [unused]
//   bool Cursor_Lock;                  // Offset:  168 Size:     4 [unused]
//   bool Cancel_Depth;                 // Offset:  172 Size:     4 [unused]
//   bool Mask_Cycle;                   // Offset:  176 Size:     4 [unused]
//   bool Text_Info;                    // Offset:  180 Size:     4 [unused]
//   bool CLK;                          // Offset:  184 Size:     4 [unused]
//   bool Trigger_Fade_A;               // Offset:  188 Size:     4 [unused]
//   bool Trigger_Fade_B;               // Offset:  192 Size:     4 [unused]
//   float2 Mousecoords;                // Offset:  196 Size:     8 [unused]
//   float frametime;                   // Offset:  204 Size:     4 [unused]
//   float timer;                       // Offset:  208 Size:     4 [unused]
//   float3 motion[2];                  // Offset:  224 Size:    28 [unused]
//   bool DepthCheck;                   // Offset:  252 Size:     4 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __s3                              sampler      NA          NA             s3      1 
// __s4                              sampler      NA          NA             s4      1 
// __V__DepthBufferTex               texture  float4          2d             t0      1 
// __V__texDMN                       texture  float4          2d             t4      1 
// __V__texzBufferN_P                texture  float4          2d             t6      1 
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
dcl_constantbuffer CB0[6], immediateIndexed
dcl_sampler s0, mode_default
dcl_sampler s3, mode_default
dcl_sampler s4, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t4
dcl_resource_texture2d (float,float,float,float) t6
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 24
dcl_indexableTemp x0[6], 4
dcl_indexableTemp x1[6], 4
mov x0[0].xyzw, l(0,1.000000,0,1.000000)
mov x0[1].xyzw, l(0,1.000000,0,0.750000)
mov x0[2].xyzw, l(0,1.000000,0,0.500000)
mov x0[3].xyzw, l(0,1.000000,0.156250,0.468750)
mov x0[4].xyzw, l(0.375000,0.250000,0.437500,0.125000)
mov x0[5].xyzw, l(0.375000,0.250000,0,1.000000)
mov r0.x, cb0[0].w
mov r0.xyzw, x0[r0.x + 0].xyzw
mad r0.xy, v1.xyxx, r0.ywyy, r0.xzxx
add r0.w, -r0.y, l(1.000000)
movc r0.z, cb0[4].z, r0.w, r0.y
mad r0.xy, -cb0[2].wwww, l(0.000291, 0.000694, 0.000000, 0.000000), r0.xzxx
sample_l_indexable(texture2d)(float,float,float,float) r0.x, r0.xyxx, t0.xyzw, s0, l(0.000000)
div r0.y, l(0.125000), cb0[3].y
div r0.y, l(1.000000, 1.000000, 1.000000, 1.000000), r0.y
add r0.z, -r0.y, l(1.000000)
lt r0.w, cb0[3].z, l(0.000000)
add r1.x, |cb0[3].z|, l(1.000000)
mul r1.y, r0.x, r1.x
min r1.y, r1.y, l(1.000000)
add r1.z, -r0.x, l(1.000000)
mad r2.xy, r0.xxxx, l(1.000000, -1.000000, 0.000000, 0.000000), l(0.000000, 1.000000, 0.000000, 0.000000)
movc r3.xy, r0.wwww, r1.yyyy, r2.xyxx
lt r1.y, l(0.000000), cb0[3].z
or r1.y, r0.w, r1.y
add r1.w, cb0[3].z, l(1.000000)
mul r4.x, r1.w, r3.x
add r2.z, -cb0[3].z, l(1.000000)
div r4.y, r3.y, r2.z
min r4.xy, r4.xyxx, l(1.000000, 1.000000, 0.000000, 0.000000)
add r3.z, -r3.y, l(1.000000)
movc r3.zw, r0.wwww, r3.xxxz, r4.xxxy
movc r3.xy, r1.yyyy, r3.zwzz, r3.xyxx
mad r3.xy, r3.xyxx, r0.zzzz, r0.yyyy
ieq r2.w, cb0[3].x, l(1)
rcp r3.xy, r3.xyxx
movc r3.y, r2.w, r3.y, r0.x
movc_sat r3.x, cb0[3].x, r3.y, r3.x
itof r4.x, cb0[4].w
eq r5.xyzw, r4.xxxx, l(2.000000, 3.000000, 4.000000, 5.000000)
eq r6.xyzw, r4.xxxx, l(6.000000, 7.000000, 8.000000, 9.000000)
eq r7.xyzw, r4.xxxx, l(10.000000, 11.000000, 12.000000, 13.000000)
or r4.yz, r7.zzyz, r7.yyxy
eq r8.xyzw, r4.xxxx, l(14.000000, 15.000000, 16.000000, 17.000000)
eq r9.xyzw, r4.xxxx, l(18.000000, 19.000000, 20.000000, 21.000000)
eq r10.xyzw, r4.xxxx, l(22.000000, 23.000000, 24.000000, 25.000000)
eq r11.xyzw, r4.xxxx, l(26.000000, 27.000000, 28.000000, 29.000000)
or r4.w, r11.w, r11.z
eq r12.xyzw, r4.xxxx, l(30.000000, 31.000000, 32.000000, 33.000000)
eq r13.xyzw, r4.xxxx, l(34.000000, 35.000000, 36.000000, 37.000000)
eq r14.xyzw, r4.xxxx, l(38.000000, 39.000000, 40.000000, 41.000000)
or r15.x, r14.y, r14.x
eq r16.xyzw, r4.xxxx, l(42.000000, 43.000000, 44.000000, 45.000000)
eq r17.xyzw, r4.xxxx, l(46.000000, 47.000000, 48.000000, 49.000000)
eq r18.xyzw, r4.xxxx, l(50.000000, 51.000000, 52.000000, 53.000000)
eq r19.xyzw, r4.xxxx, l(54.000000, 55.000000, 56.000000, 57.000000)
eq r20.xyzw, r4.xxxx, l(58.000000, 59.000000, 60.000000, 61.000000)
eq r21.xyzw, r4.xxxx, l(62.000000, 63.000000, 64.000000, 65.000000)
eq r22.xyzw, r4.xxxx, l(66.000000, 67.000000, 68.000000, 69.000000)
eq r23.xyzw, r4.xxxx, l(70.000000, 71.000000, 72.000000, 73.000000)
eq r15.yzw, r4.xxxx, l(0.000000, 74.000000, 75.000000, 76.000000)
add r4.x, cb0[5].y, l(0.000000)
div r4.x, l(0.125000), r4.x
movc r4.x, r5.x, l(0.025000), r4.x
movc r4.x, r5.y, l(0.007692), r4.x
movc r4.x, r5.z, l(0.003846), r4.x
movc r4.x, r5.w, l(0.011905), r4.x
movc r4.x, r6.x, l(0.003205), r4.x
movc r4.x, r6.y, l(0.006250), r4.x
movc r4.x, r6.z, l(0.005952), r4.x
movc r4.x, r6.w, l(0.000704), r4.x
movc r4.x, r7.x, l(0.001250), r4.x
movc r4.x, r4.y, l(0.000615), r4.x
movc r4.x, r7.w, l(0.001000), r4.x
movc r4.x, r8.x, l(0.000625), r4.x
movc r4.x, r8.y, l(0.000769), r4.x
movc r4.x, r8.z, l(0.005263), r4.x
movc r4.x, r8.w, l(0.002083), r4.x
movc r4.x, r9.x, l(0.008696), r4.x
movc r4.x, r9.y, l(0.004167), r4.x
movc r4.x, r9.z, l(0.002000), r4.x
movc r4.x, r9.w, l(0.010417), r4.x
movc r4.x, r10.x, l(0.010000), r4.x
movc r4.x, r10.y, l(0.000083), r4.x
movc r4.x, r10.z, l(0.000500), r4.x
movc r4.x, r10.w, l(0.000357), r4.x
movc r4.x, r11.x, l(0.019608), r4.x
movc r4.x, r11.y, l(0.022472), r4.x
movc r4.x, r4.w, l(0.004167), r4.x
movc r4.x, r12.x, l(0.006250), r4.x
movc r4.x, r12.y, l(0.013889), r4.x
movc r4.x, r12.z, l(0.002000), r4.x
movc r4.x, r12.w, l(0.001333), r4.x
movc r4.x, r13.x, l(0.002273), r4.x
movc r4.x, r13.y, l(0.003333), r4.x
movc r4.x, r13.z, l(0.001190), r4.x
movc r4.x, r13.w, l(12500000.000000), r4.x
movc r4.x, r15.x, l(0.006250), r4.x
movc r4.x, r14.z, l(0.001563), r4.x
movc r4.x, r14.w, l(0.006667), r4.x
movc r4.x, r16.x, l(0.007143), r4.x
movc r4.x, r16.y, l(0.010000), r4.x
movc r4.x, r16.z, l(0.006250), r4.x
movc r4.x, r16.w, l(0.007143), r4.x
movc r4.x, r17.x, l(0.013889), r4.x
movc r4.x, r17.y, l(0.006250), r4.x
movc r4.x, r17.z, l(0.010000), r4.x
movc r4.x, r17.w, l(0.003333), r4.x
movc r4.x, r18.x, l(0.007692), r4.x
movc r4.x, r18.y, l(0.002000), r4.x
movc r4.x, r18.z, l(0.001818), r4.x
movc r4.x, r18.w, l(0.000526), r4.x
movc r4.x, r19.x, l(0.002500), r4.x
movc r4.x, r19.y, l(0.008333), r4.x
movc r4.x, r19.z, l(0.005882), r4.x
movc r4.x, r19.w, l(0.023810), r4.x
movc r4.x, r20.x, l(0.004000), r4.x
movc r4.x, r20.y, l(0.015625), r4.x
movc r4.x, r20.z, l(0.013889), r4.x
movc r4.x, r20.w, l(0.009091), r4.x
movc r4.x, r21.x, l(0.023810), r4.x
movc r4.x, r21.y, l(0.000694), r4.x
movc r4.x, r21.z, l(0.002273), r4.x
movc r4.x, r21.w, l(0.001250), r4.x
movc r4.x, r22.x, l(0.002381), r4.x
movc r4.x, r22.y, l(0.010000), r4.x
movc r4.x, r22.z, l(0.007812), r4.x
movc r4.x, r22.w, l(0.007407), r4.x
movc r4.x, r23.x, l(0.021978), r4.x
movc r4.x, r23.y, l(0.012346), r4.x
movc r4.x, r23.z, l(0.020000), r4.x
movc r4.x, r23.w, l(0.008333), r4.x
movc r4.x, r15.y, l(0.002000), r4.x
movc r4.x, r15.z, l(0.001111), r4.x
movc r4.yw, r5.xxxx, l(0,1.125000,0,0.425000), cb0[5].zzzx
movc r4.yw, r5.yyyy, l(0,9.150000,0,0.276000), r4.yyyw
movc r4.yw, r5.zzzz, l(0,7.150000,0,0.500000), r4.yyyw
movc r4.yw, r5.wwww, l(0,0.872500,0,0.284000), r4.yyyw
movc r4.yw, r6.xxxx, l(0,97.500000,0,0.253000), r4.yyyw
movc r4.yw, r6.yyyy, l(0,9.562500,0,0.276000), r4.yyyw
movc r4.yw, r6.zzzz, l(0,9.137500,0,0.338000), r4.yyyw
movc r4.yw, r6.wwww, l(0,63.025002,0,0.255000), r4.yyyw
movc r4.y, r7.x, l(0.984300), r4.y
movc r4.y, r7.y, l(0.984350), r4.y
movc r4.y, r7.z, l(0.984330), r4.y
movc r4.y, r7.w, l(0.984300), r4.y
movc r4.y, r8.x, l(63.000000), r4.y
movc r4.y, r8.y, l(3.975000), r4.y
movc r4.y, r8.z, l(0.984250), r4.y
movc r4.y, r8.w, l(15.156250), r4.y
movc r4.y, r9.x, l(2.500000), r4.y
movc r4.y, r9.y, l(1.050000), r4.y
movc r4.y, r9.z, l(9.100000), r4.y
movc r4.y, r9.w, l(23.750000), r4.y
movc r4.y, r10.x, l(2.000000), r4.y
movc r4.y, r10.y, l(7.000000), r4.y
movc r4.y, r10.z, l(0), r4.y
movc r4.y, r10.w, l(0.785000), r4.y
movc r4.y, r11.x, l(53.750000), r4.y
movc r4.y, r11.y, l(0), r4.y
movc r4.y, r11.z, l(1.025000), r4.y
movc r4.y, r11.w, l(14.000000), r4.y
movc r4.y, r12.x, l(0), r4.y
movc r4.y, r12.y, l(2.362500), r4.y
movc r4.y, r12.z, l(0.988750), r4.y
movc r4.y, r12.w, l(0.818750), r4.y
movc r4.y, r13.x, l(0.900000), r4.y
movc r4.y, r13.y, l(9.100000), r4.y
movc r4.y, r13.z, l(8.862500), r4.y
movc r4.y, r13.w, l(0), r4.y
movc r4.y, r14.x, l(0.180000), r4.y
movc r4.y, r14.y, l(1.187500), r4.y
movc r4.y, r14.z, l(7.000000), r4.y
movc r4.y, r14.w, l(9.030000), r4.y
movc r4.y, r16.x, l(0.901500), r4.y
movc r4.y, r16.y, l(0.300000), r4.y
movc r4.y, r16.z, l(8.800000), r4.y
movc r4.y, r16.w, l(0), r4.y
movc r4.y, r17.x, l(2.375000), r4.y
movc r4.y, r17.y, l(9.000000), r4.y
movc r4.y, r17.z, l(1.000000), r4.y
movc r4.y, r17.w, l(0.998750), r4.y
movc r4.y, r18.x, l(0.090000), r4.y
movc r4.y, r18.y, l(0.962500), r4.y
movc r4.y, r18.z, l(1.020000), r4.y
movc r4.y, r18.w, l(0.836250), r4.y
movc r4.y, r19.x, l(0), r4.y
movc r4.y, r19.y, l(99.000000), r4.y
movc r4.y, r19.z, l(99.500000), r4.y
movc r4.y, r19.w, l(1.000000), r4.y
movc r4.y, r20.x, l(8.875000), r4.y
movc r4.y, r20.y, l(0), r4.y
movc r4.y, r20.z, l(1.800000), r4.y
or r5.x, r20.w, r21.x
movc r4.y, r5.x, l(0), r4.y
movc r4.y, r21.y, l(9.000000), r4.y
movc r4.y, r21.z, l(1000.000000), r4.y
movc r4.y, r21.w, l(0.905000), r4.y
movc r4.y, r22.x, l(987.500000), r4.y
movc r4.y, r22.y, l(925.000000), r4.y
movc r4.y, r22.z, l(0.185000), r4.y
movc r4.y, r22.w, l(0), r4.y
movc r4.y, r23.x, l(950.000000), r4.y
movc r4.y, r23.y, l(1.825000), r4.y
movc r4.y, r23.z, l(0.100000), r4.y
movc r4.y, r23.w, l(0.300000), r4.y
movc r4.xy, r15.wyww, l(0.007143,0,0,0), r4.xyxx
movc r4.y, r15.z, l(0.500000), r4.y
movc r4.y, r15.w, l(2.050000), r4.y
add r5.x, r4.y, l(1.000000)
add r5.y, -r4.y, l(1.000000)
lt r4.y, l(0.000000), r4.y
mul r6.x, r0.x, r5.x
div r6.y, r1.z, r5.y
min r5.zw, r6.xxxy, l(0.000000, 0.000000, 1.000000, 1.000000)
movc r2.xy, r4.yyyy, r5.zwzz, r2.xyxx
if_z cb0[3].x
  add r1.z, r4.x, l(-1.000000)
  mad r1.z, r2.x, r1.z, l(1.000000)
  div r1.z, r4.x, r1.z
else 
  add r2.x, r4.x, l(-1.000000)
  mad r2.x, r2.y, r2.x, l(1.000000)
  div r2.x, r4.x, r2.x
  movc r1.z, r2.w, r2.x, r0.x
endif 
or r0.x, r7.z, r4.z
or r0.x, r7.w, r0.x
movc r0.x, r0.x, l(0.254000), r4.w
movc r0.x, r8.x, l(0.255000), r0.x
movc r0.x, r8.y, l(0.510000), r0.x
movc r0.x, r8.z, l(0.254000), r0.x
movc r0.x, r8.w, l(0.375000), r0.x
movc r0.x, r9.x, l(0.700000), r0.x
movc r0.x, r9.y, l(0.750000), r0.x
movc r0.x, r9.z, l(0.278000), r0.x
movc r0.x, r9.w, l(0.450000), r0.x
movc r0.x, r10.x, l(0.350000), r0.x
movc r0.x, r10.y, l(0.286000), r0.x
movc r0.x, r10.z, l(35.000000), r0.x
movc r0.x, r10.w, l(0.625000), r0.x
movc r0.x, r11.x, l(0.255000), r0.x
movc r0.x, r11.y, l(0.450000), r0.x
movc r0.x, r11.z, l(0.750000), r0.x
movc r0.x, r11.w, l(0.266000), r0.x
movc r0.x, r12.x, l(3.625000), r0.x
movc r0.x, r12.y, l(0.700000), r0.x
movc r0.x, r12.z, l(0.489400), r0.x
movc r0.x, r12.w, l(1.000000), r0.x
movc r0.x, r13.x, l(1.150000), r0.x
movc r0.x, r13.y, l(0.278000), r0.x
movc r0.x, r13.z, l(0.277000), r0.x
movc r0.x, r13.w, l(0), r0.x
movc r0.x, r14.x, l(0.780000), r0.x
movc r0.x, r14.y, l(0.444000), r0.x
movc r0.x, r14.z, l(0.286000), r0.x
movc r0.x, r14.w, l(0.280000), r0.x
movc r0.x, r16.x, l(0.300000), r0.x
movc r0.x, r16.y, l(1.200000), r0.x
movc r0.x, r16.z, l(0.277000), r0.x
movc r0.x, r16.w, l(1.300000), r0.x
movc r0.x, r17.x, l(0.625000), r0.x
movc r0.x, r17.y, l(0.280000), r0.x
movc r0.x, r17.z, l(0.460000), r0.x
movc r0.x, r17.w, l(1.500000), r0.x
movc r0.x, r18.x, l(2.000000), r0.x
movc r0.x, r18.y, l(0.485000), r0.x
movc r0.x, r18.z, l(0.489000), r0.x
movc r0.x, r18.w, l(1.000000), r0.x
movc r0.x, r19.x, l(13.870000), r0.x
or r2.x, r19.z, r19.y
or r2.x, r19.w, r2.x
movc r0.x, r2.x, l(0.425000), r0.x
movc r0.x, r20.x, l(0.519000), r0.x
movc r0.x, r20.y, l(0.500000), r0.x
movc r0.x, r20.z, l(0.350000), r0.x
movc r0.x, r20.w, l(1.825000), r0.x
movc r0.x, r21.x, l(1.953000), r0.x
movc r0.x, r21.y, l(0.287000), r0.x
movc r0.x, r21.z, l(0.250300), r0.x
movc r0.x, r21.w, l(0.279000), r0.x
movc r0.x, r22.x, l(0.250300), r0.x
movc r0.x, r22.y, l(0.251000), r0.x
movc r0.x, r22.z, l(1.035000), r0.x
movc r0.x, r22.w, l(1.553000), r0.x
movc r0.x, r23.x, l(0.251000), r0.x
movc r0.x, r23.y, l(0.345000), r0.x
movc r0.x, r23.z, l(0.430000), r0.x
movc r0.x, r23.w, l(0.800000), r0.x
movc r0.x, r15.y, l(13.300000), r0.x
movc r0.x, r15.z, l(0.750000), r0.x
movc r0.x, r15.w, l(0.350000), r0.x
div r0.x, r0.x, cb0[3].y
mul r0.x, r0.x, l(0.500000)
if_nz cb0[4].w
  mov_sat r1.z, r1.z
  ge r2.x, r0.x, r3.x
  and r2.x, r2.x, l(0x3f800000)
  add r1.z, -r3.x, r1.z
  mad r3.x, r2.x, r1.z, r3.x
endif 
add r1.z, -v1.y, l(1.000000)
movc r2.y, cb0[4].z, r1.z, v1.y
mov r2.x, v1.x
mad r2.xy, -cb0[2].wwww, l(0.000291, 0.000694, 0.000000, 0.000000), r2.xyxx
sample_l_indexable(texture2d)(float,float,float,float) r1.z, r2.xyxx, t0.yzxw, s0, l(0.000000)
mul r1.x, r1.x, r1.z
min r1.x, r1.x, l(1.000000)
add r2.x, -r1.z, l(1.000000)
mad r4.zw, r1.zzzz, l(0.000000, 0.000000, 1.000000, -1.000000), l(0.000000, 0.000000, 0.000000, 1.000000)
movc r6.xy, r0.wwww, r1.xxxx, r4.zwzz
mul r7.x, r1.w, r6.x
div r7.y, r6.y, r2.z
min r1.xw, r7.xxxy, l(1.000000, 0.000000, 0.000000, 1.000000)
add r6.z, -r6.y, l(1.000000)
movc r1.xw, r0.wwww, r6.xxxz, r1.xxxw
movc r1.xy, r1.yyyy, r1.xwxx, r6.xyxx
mad r0.yz, r1.xxyx, r0.zzzz, r0.yyyy
rcp r0.yz, r0.yyzy
movc r0.z, r2.w, r0.z, r1.z
movc_sat r3.y, cb0[3].x, r0.z, r0.y
mul r1.x, r5.x, r1.z
div r1.y, r2.x, r5.y
min r0.yz, r1.xxyx, l(0.000000, 1.000000, 1.000000, 0.000000)
movc r0.yz, r4.yyyy, r0.yyzy, r4.zzwz
if_z cb0[3].x
  add r0.w, r4.x, l(-1.000000)
  mad r0.y, r0.y, r0.w, l(1.000000)
  div r0.y, r4.x, r0.y
else 
  add r0.w, r4.x, l(-1.000000)
  mad r0.z, r0.z, r0.w, l(1.000000)
  div r0.z, r4.x, r0.z
  movc r0.y, r2.w, r0.z, r1.z
endif 
if_nz cb0[4].w
  mov_sat r0.y, r0.y
  ge r0.x, r0.x, r3.y
  and r0.x, r0.x, l(0x3f800000)
  add r0.y, -r3.y, r0.y
  mad r3.y, r0.x, r0.y, r3.y
endif 
sample_indexable(texture2d)(float,float,float,float) r0.x, l(0.000000, 0.000000, 0.000000, 0.000000), t4.xyzw, s3
sample_indexable(texture2d)(float,float,float,float) r0.y, l(1.000000, 1.000000, 0.000000, 0.000000), t4.yxzw, s3
sample_indexable(texture2d)(float,float,float,float) r0.z, l(0.000000, 1.000000, 0.000000, 0.000000), t4.yzxw, s3
sample_indexable(texture2d)(float,float,float,float) r0.w, l(1.000000, 1.000000, 0.000000, 0.000000), t6.xzwy, s4
sample_indexable(texture2d)(float,float,float,float) r1.x, l(0.000000, 1.000000, 0.000000, 0.000000), t6.yxzw, s4
mov x1[0].x, r0.x
mov x1[1].x, r0.y
mov x1[2].x, r0.z
mov x1[3].x, l(1.000000)
mov x1[4].x, r0.w
mov x1[5].x, r1.x
mul r0.x, v1.y, l(6.000000)
round_ni r0.x, r0.x
mul r0.y, r0.x, l(0.166667)
frc r0.y, |r0.y|
mul r0.y, r0.y, l(6.000000)
lt r0.x, r0.x, l(0.000000)
movc r0.x, r0.x, -r0.y, r0.y
sample_l_indexable(texture2d)(float,float,float,float) r3.w, v1.xyxx, t4.xzwy, s3, l(0.000000)
ftoi r0.x, r0.x
mov r3.z, x1[r0.x + 0].x
mov o0.xyzw, r3.xyzw
ret 
// Approximately 365 instruction slots used
