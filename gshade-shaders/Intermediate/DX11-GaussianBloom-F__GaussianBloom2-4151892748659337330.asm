//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int GaussianBloomRadius;           // Offset:    0 Size:     4
//   float GaussianBloomOffset;         // Offset:    4 Size:     4 [unused]
//   float Threshold;                   // Offset:    8 Size:     4 [unused]
//   float3 BloomTint;                  // Offset:   16 Size:    12 [unused]
//   float Exposure;                    // Offset:   28 Size:     4 [unused]
//   float GaussianBloomSaturation;     // Offset:   32 Size:     4 [unused]
//   float DitherStrength;              // Offset:   36 Size:     4 [unused]
//   float GaussianBloomStrength;       // Offset:   40 Size:     4 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s1                              sampler      NA          NA             s1      1 
// __V__GaussianBloomTex2            texture  float4          2d             t6      1 
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
dcl_constantbuffer CB0[1], immediateIndexed
dcl_sampler s1, mode_default
dcl_resource_texture2d (float,float,float,float) t6
dcl_input_ps linear v1.xy
dcl_output o0.xyz
dcl_temps 6
dcl_indexableTemp x0[6], 4
dcl_indexableTemp x1[6], 4
dcl_indexableTemp x2[6], 4
dcl_indexableTemp x3[6], 4
dcl_indexableTemp x4[11], 4
dcl_indexableTemp x5[11], 4
dcl_indexableTemp x6[11], 4
dcl_indexableTemp x7[11], 4
dcl_indexableTemp x8[15], 4
dcl_indexableTemp x9[15], 4
dcl_indexableTemp x10[15], 4
dcl_indexableTemp x11[15], 4
dcl_indexableTemp x12[18], 4
dcl_indexableTemp x13[18], 4
dcl_indexableTemp x14[18], 4
dcl_indexableTemp x15[18], 4
sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t6.xyzw, s1
ieq r1.xyzw, cb0[0].xxxx, l(1, 2, 3, 4)
if_nz r1.x
  mul r2.xyz, r0.xyzx, l(0.132980, 0.132980, 0.132980, 0.000000)
  mov r3.yw, l(0,0,0,0)
  mov r0.xyz, r2.xyzx
  mov r0.w, l(1)
  mov r1.x, l(-1)
  loop 
    breakc_z r1.x
    mov x0[1].x, l(1.458430)
    mov x0[2].x, l(3.403985)
    mov x0[3].x, l(5.351806)
    mov x0[4].x, l(7.302941)
    mov x0[5].x, l(9.258160)
    mov r2.w, x0[r0.w + 0].x
    mul r3.x, r2.w, l(0.000291)
    add r4.xy, r3.xyxx, v1.xyxx
    sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r4.xyxx, t6.xyzw, s1, l(0.000000)
    mov x1[1].x, l(0.232276)
    mov x1[2].x, l(0.135326)
    mov x1[3].x, l(0.051156)
    mov x1[4].x, l(0.012539)
    mov x1[5].x, l(0.001991)
    mov r2.w, x1[r0.w + 0].x
    mad r4.xyz, r4.xyzx, r2.wwww, r0.xyzx
    mov x2[1].x, l(1.458430)
    mov x2[2].x, l(3.403985)
    mov x2[3].x, l(5.351806)
    mov x2[4].x, l(7.302941)
    mov x2[5].x, l(9.258160)
    mov r2.w, x2[r0.w + 0].x
    mul r3.z, r2.w, l(0.000291)
    add r3.xz, -r3.zzwz, v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r5.xyz, r3.xzxx, t6.xyzw, s1, l(0.000000)
    mov x3[1].x, l(0.232276)
    mov x3[2].x, l(0.135326)
    mov x3[3].x, l(0.051156)
    mov x3[4].x, l(0.012539)
    mov x3[5].x, l(0.001991)
    mov r2.w, x3[r0.w + 0].x
    mad r0.xyz, r5.xyzx, r2.wwww, r4.xyzx
    iadd r0.w, r0.w, l(1)
    ilt r1.x, r0.w, l(6)
  endloop 
endif 
if_nz r1.y
  mul r2.xyz, r0.xyzx, l(0.066490, 0.066490, 0.066490, 0.000000)
  mov r3.yw, l(0,0,0,0)
  mov r0.xyz, r2.xyzx
  mov r0.w, l(1)
  mov r1.x, l(-1)
  loop 
    breakc_z r1.x
    mov x4[1].x, l(1.489585)
    mov x4[2].x, l(3.475714)
    mov x4[3].x, l(5.461880)
    mov x4[4].x, l(7.448104)
    mov x4[5].x, l(9.434408)
    mov x4[6].x, l(11.420812)
    mov x4[7].x, l(13.407333)
    mov x4[8].x, l(15.393993)
    mov x4[9].x, l(17.380812)
    mov x4[10].x, l(19.367800)
    mov r1.y, x4[r0.w + 0].x
    mul r3.x, r1.y, l(0.000291)
    add r4.xy, r3.xyxx, v1.xyxx
    sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r4.xyxx, t6.xyzw, s1, l(0.000000)
    mov x5[1].x, l(0.128470)
    mov x5[2].x, l(0.111918)
    mov x5[3].x, l(0.087313)
    mov x5[4].x, l(0.061001)
    mov x5[5].x, l(0.038166)
    mov x5[6].x, l(0.021384)
    mov x5[7].x, l(0.010729)
    mov x5[8].x, l(0.004821)
    mov x5[9].x, l(0.001940)
    mov x5[10].x, l(0.000699)
    mov r1.y, x5[r0.w + 0].x
    mad r4.xyz, r4.xyzx, r1.yyyy, r0.xyzx
    mov x6[1].x, l(1.489585)
    mov x6[2].x, l(3.475714)
    mov x6[3].x, l(5.461880)
    mov x6[4].x, l(7.448104)
    mov x6[5].x, l(9.434408)
    mov x6[6].x, l(11.420812)
    mov x6[7].x, l(13.407333)
    mov x6[8].x, l(15.393993)
    mov x6[9].x, l(17.380812)
    mov x6[10].x, l(19.367800)
    mov r1.y, x6[r0.w + 0].x
    mul r3.z, r1.y, l(0.000291)
    add r3.xz, -r3.zzwz, v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r5.xyz, r3.xzxx, t6.xyzw, s1, l(0.000000)
    mov x7[1].x, l(0.128470)
    mov x7[2].x, l(0.111918)
    mov x7[3].x, l(0.087313)
    mov x7[4].x, l(0.061001)
    mov x7[5].x, l(0.038166)
    mov x7[6].x, l(0.021384)
    mov x7[7].x, l(0.010729)
    mov x7[8].x, l(0.004821)
    mov x7[9].x, l(0.001940)
    mov x7[10].x, l(0.000699)
    mov r1.y, x7[r0.w + 0].x
    mad r0.xyz, r5.xyzx, r1.yyyy, r4.xyzx
    iadd r0.w, r0.w, l(1)
    ilt r1.x, r0.w, l(11)
  endloop 
endif 
if_nz r1.z
  mul r1.xyz, r0.xyzx, l(0.044327, 0.044327, 0.044327, 0.000000)
  mov r2.yw, l(0,0,0,0)
  mov r0.xyz, r1.xyzx
  mov r0.w, l(1)
  mov r3.x, l(-1)
  loop 
    breakc_z r3.x
    mov x8[1].x, l(1.495371)
    mov x8[2].x, l(3.489199)
    mov x8[3].x, l(5.483031)
    mov x8[4].x, l(7.476869)
    mov x8[5].x, l(9.470713)
    mov x8[6].x, l(11.464565)
    mov x8[7].x, l(13.458429)
    mov x8[8].x, l(15.452306)
    mov x8[9].x, l(17.446196)
    mov x8[10].x, l(19.440104)
    mov x8[11].x, l(21.434029)
    mov x8[12].x, l(23.427973)
    mov x8[13].x, l(25.421940)
    mov x8[14].x, l(27.415928)
    mov r3.y, x8[r0.w + 0].x
    mul r2.x, r3.y, l(0.000291)
    add r3.yz, r2.xxyx, v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r3.yzw, r3.yzyy, t6.wxyz, s1, l(0.000000)
    mov x9[1].x, l(0.087299)
    mov x9[2].x, l(0.082089)
    mov x9[3].x, l(0.073482)
    mov x9[4].x, l(0.062617)
    mov x9[5].x, l(0.050796)
    mov x9[6].x, l(0.039226)
    mov x9[7].x, l(0.028837)
    mov x9[8].x, l(0.020181)
    mov x9[9].x, l(0.013445)
    mov x9[10].x, l(0.008527)
    mov x9[11].x, l(0.005148)
    mov x9[12].x, l(0.002959)
    mov x9[13].x, l(0.001619)
    mov x9[14].x, l(0.000843)
    mov r2.x, x9[r0.w + 0].x
    mad r3.yzw, r3.yyzw, r2.xxxx, r0.xxyz
    mov x10[1].x, l(1.495371)
    mov x10[2].x, l(3.489199)
    mov x10[3].x, l(5.483031)
    mov x10[4].x, l(7.476869)
    mov x10[5].x, l(9.470713)
    mov x10[6].x, l(11.464565)
    mov x10[7].x, l(13.458429)
    mov x10[8].x, l(15.452306)
    mov x10[9].x, l(17.446196)
    mov x10[10].x, l(19.440104)
    mov x10[11].x, l(21.434029)
    mov x10[12].x, l(23.427973)
    mov x10[13].x, l(25.421940)
    mov x10[14].x, l(27.415928)
    mov r2.x, x10[r0.w + 0].x
    mul r2.z, r2.x, l(0.000291)
    add r2.xz, -r2.zzwz, v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r2.xzxx, t6.xyzw, s1, l(0.000000)
    mov x11[1].x, l(0.087299)
    mov x11[2].x, l(0.082089)
    mov x11[3].x, l(0.073482)
    mov x11[4].x, l(0.062617)
    mov x11[5].x, l(0.050796)
    mov x11[6].x, l(0.039226)
    mov x11[7].x, l(0.028837)
    mov x11[8].x, l(0.020181)
    mov x11[9].x, l(0.013445)
    mov x11[10].x, l(0.008527)
    mov x11[11].x, l(0.005148)
    mov x11[12].x, l(0.002959)
    mov x11[13].x, l(0.001619)
    mov x11[14].x, l(0.000843)
    mov r2.x, x11[r0.w + 0].x
    mad r0.xyz, r4.xyzx, r2.xxxx, r3.yzwy
    iadd r0.w, r0.w, l(1)
    ilt r3.x, r0.w, l(15)
  endloop 
endif 
if_nz r1.w
  mul r1.xyz, r0.xyzx, l(0.033245, 0.033245, 0.033245, 0.000000)
  mov r2.yw, l(0,0,0,0)
  mov r3.xyz, r1.xyzx
  mov r0.w, l(1)
  mov r1.w, l(-1)
  loop 
    breakc_z r1.w
    mov x12[1].x, l(1.495371)
    mov x12[2].x, l(3.489199)
    mov x12[3].x, l(5.483031)
    mov x12[4].x, l(7.476869)
    mov x12[5].x, l(9.470713)
    mov x12[6].x, l(11.464565)
    mov x12[7].x, l(13.458429)
    mov x12[8].x, l(15.452306)
    mov x12[9].x, l(17.446196)
    mov x12[10].x, l(19.466198)
    mov x12[11].x, l(21.462744)
    mov x12[12].x, l(23.459291)
    mov x12[13].x, l(25.455845)
    mov x12[14].x, l(27.452402)
    mov x12[15].x, l(29.448961)
    mov x12[16].x, l(31.445528)
    mov x12[17].x, l(33.442101)
    mov r3.w, x12[r0.w + 0].x
    mul r2.x, r3.w, l(0.000291)
    add r4.xy, r2.xyxx, v1.xyxx
    sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r4.xyxx, t6.xyzw, s1, l(0.000000)
    mov x13[1].x, l(0.065916)
    mov x13[2].x, l(0.063671)
    mov x13[3].x, l(0.059819)
    mov x13[4].x, l(0.054664)
    mov x13[5].x, l(0.048587)
    mov x13[6].x, l(0.042005)
    mov x13[7].x, l(0.035321)
    mov x13[8].x, l(0.028888)
    mov x13[9].x, l(0.022981)
    mov x13[10].x, l(0.017782)
    mov x13[11].x, l(0.013382)
    mov x13[12].x, l(0.009796)
    mov x13[13].x, l(0.006975)
    mov x13[14].x, l(0.004830)
    mov x13[15].x, l(0.003253)
    mov x13[16].x, l(0.002132)
    mov x13[17].x, l(0.001358)
    mov r2.x, x13[r0.w + 0].x
    mad r4.xyz, r4.xyzx, r2.xxxx, r3.xyzx
    mov x14[1].x, l(1.495371)
    mov x14[2].x, l(3.489199)
    mov x14[3].x, l(5.483031)
    mov x14[4].x, l(7.476869)
    mov x14[5].x, l(9.470713)
    mov x14[6].x, l(11.464565)
    mov x14[7].x, l(13.458429)
    mov x14[8].x, l(15.452306)
    mov x14[9].x, l(17.446196)
    mov x14[10].x, l(19.466198)
    mov x14[11].x, l(21.462744)
    mov x14[12].x, l(23.459291)
    mov x14[13].x, l(25.455845)
    mov x14[14].x, l(27.452402)
    mov x14[15].x, l(29.448961)
    mov x14[16].x, l(31.445528)
    mov x14[17].x, l(33.442101)
    mov r2.x, x14[r0.w + 0].x
    mul r2.z, r2.x, l(0.000291)
    add r2.xz, -r2.zzwz, v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r5.xyz, r2.xzxx, t6.xyzw, s1, l(0.000000)
    mov x15[1].x, l(0.065916)
    mov x15[2].x, l(0.063671)
    mov x15[3].x, l(0.059819)
    mov x15[4].x, l(0.054664)
    mov x15[5].x, l(0.048587)
    mov x15[6].x, l(0.042005)
    mov x15[7].x, l(0.035321)
    mov x15[8].x, l(0.028888)
    mov x15[9].x, l(0.022981)
    mov x15[10].x, l(0.017782)
    mov x15[11].x, l(0.013382)
    mov x15[12].x, l(0.009796)
    mov x15[13].x, l(0.006975)
    mov x15[14].x, l(0.004830)
    mov x15[15].x, l(0.003253)
    mov x15[16].x, l(0.002132)
    mov x15[17].x, l(0.001358)
    mov r2.x, x15[r0.w + 0].x
    mad r3.xyz, r5.xyzx, r2.xxxx, r4.xyzx
    iadd r0.w, r0.w, l(1)
    ilt r1.w, r0.w, l(18)
  endloop 
  mov o0.xyz, r3.xyzx
else 
  mov o0.xyz, r0.xyzx
endif 
ret 
// Approximately 286 instruction slots used
