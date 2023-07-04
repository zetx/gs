//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int ClarityRadius;                 // Offset:    0 Size:     4
//   float ClarityOffset;               // Offset:    4 Size:     4
//   int ClarityBlendMode;              // Offset:    8 Size:     4 [unused]
//   int ClarityBlendIfDark;            // Offset:   12 Size:     4 [unused]
//   int ClarityBlendIfLight;           // Offset:   16 Size:     4 [unused]
//   bool ClarityViewBlendIfMask;       // Offset:   20 Size:     4 [unused]
//   float ClarityStrength;             // Offset:   24 Size:     4 [unused]
//   float ClarityDarkIntensity;        // Offset:   28 Size:     4 [unused]
//   float ClarityLightIntensity;       // Offset:   32 Size:     4 [unused]
//   bool ClarityViewMask;              // Offset:   36 Size:     4 [unused]
//   float DitherTimer;                 // Offset:   40 Size:     4 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s0                              sampler      NA          NA             s0      1 
// __V__ClarityTex                   texture  float4          2d             t4      1 
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
// SV_TARGET                0   x           0   TARGET   float   x   
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[1], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t4
dcl_input_ps linear v1.xy
dcl_output o0.x
dcl_temps 4
dcl_indexableTemp x0[4], 4
dcl_indexableTemp x1[4], 4
dcl_indexableTemp x2[4], 4
dcl_indexableTemp x3[4], 4
dcl_indexableTemp x4[6], 4
dcl_indexableTemp x5[6], 4
dcl_indexableTemp x6[6], 4
dcl_indexableTemp x7[6], 4
dcl_indexableTemp x8[11], 4
dcl_indexableTemp x9[11], 4
dcl_indexableTemp x10[11], 4
dcl_indexableTemp x11[11], 4
dcl_indexableTemp x12[15], 4
dcl_indexableTemp x13[15], 4
dcl_indexableTemp x14[15], 4
dcl_indexableTemp x15[15], 4
dcl_indexableTemp x16[18], 4
dcl_indexableTemp x17[18], 4
dcl_indexableTemp x18[18], 4
dcl_indexableTemp x19[18], 4
sample_indexable(texture2d)(float,float,float,float) r0.x, v1.xyxx, t4.xyzw, s0
ieq r0.yzw, cb0[0].xxxx, l(0, 1, 2, 3)
if_z cb0[0].x
  mul r1.x, r0.x, l(0.398940)
  mov r2.xz, cb0[0].yyyy
  mov r0.x, r1.x
  mov r1.yz, l(0,1,-1,0)
  loop 
    breakc_z r1.z
    mov x0[1].x, l(1.182425)
    mov x0[2].x, l(3.029312)
    mov x0[3].x, l(5.004070)
    mov r1.w, x0[r1.y + 0].x
    mul r2.y, r1.w, cb0[0].y
    mad r3.xy, r2.xyxx, l(0.000000, 0.000694, 0.000000, 0.000000), v1.xyxx
    sample_l_indexable(texture2d)(float,float,float,float) r1.w, r3.xyxx, t4.yzwx, s0, l(0.000000)
    mov x1[1].x, l(0.295960)
    mov x1[2].x, l(0.004566)
    mov x1[3].x, l(0.000001)
    mov r2.y, x1[r1.y + 0].x
    mad r1.w, r1.w, r2.y, r0.x
    mov x2[1].x, l(1.182425)
    mov x2[2].x, l(3.029312)
    mov x2[3].x, l(5.004070)
    mov r2.y, x2[r1.y + 0].x
    mul r2.w, r2.y, cb0[0].y
    mad r2.yw, -r2.zzzw, l(0.000000, 0.000000, 0.000000, 0.000694), v1.xxxy
    sample_l_indexable(texture2d)(float,float,float,float) r2.y, r2.ywyy, t4.yxzw, s0, l(0.000000)
    mov x3[1].x, l(0.295960)
    mov x3[2].x, l(0.004566)
    mov x3[3].x, l(0.000001)
    mov r2.w, x3[r1.y + 0].x
    mad r0.x, r2.y, r2.w, r1.w
    iadd r1.y, r1.y, l(1)
    ilt r1.z, r1.y, l(4)
  endloop 
endif 
if_nz r0.y
  mul r0.y, r0.x, l(0.132980)
  mov r1.xz, cb0[0].yyyy
  mov r0.x, r0.y
  mov r2.xy, l(1,-1,0,0)
  loop 
    breakc_z r2.y
    mov x4[1].x, l(1.458430)
    mov x4[2].x, l(3.403985)
    mov x4[3].x, l(5.351806)
    mov x4[4].x, l(7.302941)
    mov x4[5].x, l(9.258160)
    mov r2.z, x4[r2.x + 0].x
    mul r1.y, r2.z, cb0[0].y
    mad r2.zw, r1.xxxy, l(0.000000, 0.000000, 0.000000, 0.000694), v1.xxxy
    sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.zwzz, t4.yxzw, s0, l(0.000000)
    mov x5[1].x, l(0.232276)
    mov x5[2].x, l(0.135326)
    mov x5[3].x, l(0.051156)
    mov x5[4].x, l(0.012539)
    mov x5[5].x, l(0.001991)
    mov r2.z, x5[r2.x + 0].x
    mad r1.y, r1.y, r2.z, r0.x
    mov x6[1].x, l(1.458430)
    mov x6[2].x, l(3.403985)
    mov x6[3].x, l(5.351806)
    mov x6[4].x, l(7.302941)
    mov x6[5].x, l(9.258160)
    mov r2.z, x6[r2.x + 0].x
    mul r1.w, r2.z, cb0[0].y
    mad r2.zw, -r1.zzzw, l(0.000000, 0.000000, 0.000000, 0.000694), v1.xxxy
    sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.zwzz, t4.yzwx, s0, l(0.000000)
    mov x7[1].x, l(0.232276)
    mov x7[2].x, l(0.135326)
    mov x7[3].x, l(0.051156)
    mov x7[4].x, l(0.012539)
    mov x7[5].x, l(0.001991)
    mov r2.z, x7[r2.x + 0].x
    mad r0.x, r1.w, r2.z, r1.y
    iadd r2.x, r2.x, l(1)
    ilt r2.y, r2.x, l(6)
  endloop 
endif 
if_nz r0.z
  mul r0.y, r0.x, l(0.066490)
  mov r1.xz, cb0[0].yyyy
  mov r0.x, r0.y
  mov r0.z, l(1)
  mov r2.x, l(-1)
  loop 
    breakc_z r2.x
    mov x8[1].x, l(1.489585)
    mov x8[2].x, l(3.475714)
    mov x8[3].x, l(5.461880)
    mov x8[4].x, l(7.448104)
    mov x8[5].x, l(9.434408)
    mov x8[6].x, l(11.420812)
    mov x8[7].x, l(13.407333)
    mov x8[8].x, l(15.393993)
    mov x8[9].x, l(17.380812)
    mov x8[10].x, l(19.367800)
    mov r2.y, x8[r0.z + 0].x
    mul r1.y, r2.y, cb0[0].y
    mad r2.yz, r1.xxyx, l(0.000000, 0.000000, 0.000694, 0.000000), v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.yzyy, t4.yxzw, s0, l(0.000000)
    mov x9[1].x, l(0.128470)
    mov x9[2].x, l(0.111918)
    mov x9[3].x, l(0.087313)
    mov x9[4].x, l(0.061001)
    mov x9[5].x, l(0.038166)
    mov x9[6].x, l(0.021384)
    mov x9[7].x, l(0.010729)
    mov x9[8].x, l(0.004821)
    mov x9[9].x, l(0.001940)
    mov x9[10].x, l(0.000699)
    mov r2.y, x9[r0.z + 0].x
    mad r1.y, r1.y, r2.y, r0.x
    mov x10[1].x, l(1.489585)
    mov x10[2].x, l(3.475714)
    mov x10[3].x, l(5.461880)
    mov x10[4].x, l(7.448104)
    mov x10[5].x, l(9.434408)
    mov x10[6].x, l(11.420812)
    mov x10[7].x, l(13.407333)
    mov x10[8].x, l(15.393993)
    mov x10[9].x, l(17.380812)
    mov x10[10].x, l(19.367800)
    mov r2.y, x10[r0.z + 0].x
    mul r1.w, r2.y, cb0[0].y
    mad r2.yz, -r1.zzwz, l(0.000000, 0.000000, 0.000694, 0.000000), v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.yzyy, t4.yzwx, s0, l(0.000000)
    mov x11[1].x, l(0.128470)
    mov x11[2].x, l(0.111918)
    mov x11[3].x, l(0.087313)
    mov x11[4].x, l(0.061001)
    mov x11[5].x, l(0.038166)
    mov x11[6].x, l(0.021384)
    mov x11[7].x, l(0.010729)
    mov x11[8].x, l(0.004821)
    mov x11[9].x, l(0.001940)
    mov x11[10].x, l(0.000699)
    mov r2.y, x11[r0.z + 0].x
    mad r0.x, r1.w, r2.y, r1.y
    iadd r0.z, r0.z, l(1)
    ilt r2.x, r0.z, l(11)
  endloop 
endif 
if_nz r0.w
  mul r0.y, r0.x, l(0.044327)
  mov r1.xz, cb0[0].yyyy
  mov r0.x, r0.y
  mov r0.zw, l(0,0,1,-1)
  loop 
    breakc_z r0.w
    mov x12[1].x, l(1.495371)
    mov x12[2].x, l(3.489199)
    mov x12[3].x, l(5.483031)
    mov x12[4].x, l(7.476869)
    mov x12[5].x, l(9.470713)
    mov x12[6].x, l(11.464565)
    mov x12[7].x, l(13.458429)
    mov x12[8].x, l(15.452306)
    mov x12[9].x, l(17.446196)
    mov x12[10].x, l(19.440104)
    mov x12[11].x, l(21.434029)
    mov x12[12].x, l(23.427973)
    mov x12[13].x, l(25.421940)
    mov x12[14].x, l(27.415928)
    mov r2.x, x12[r0.z + 0].x
    mul r1.y, r2.x, cb0[0].y
    mad r2.xy, r1.xyxx, l(0.000000, 0.000694, 0.000000, 0.000000), v1.xyxx
    sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.xyxx, t4.yxzw, s0, l(0.000000)
    mov x13[1].x, l(0.087299)
    mov x13[2].x, l(0.082089)
    mov x13[3].x, l(0.073482)
    mov x13[4].x, l(0.062617)
    mov x13[5].x, l(0.050796)
    mov x13[6].x, l(0.039226)
    mov x13[7].x, l(0.028837)
    mov x13[8].x, l(0.020181)
    mov x13[9].x, l(0.013445)
    mov x13[10].x, l(0.008527)
    mov x13[11].x, l(0.005148)
    mov x13[12].x, l(0.002959)
    mov x13[13].x, l(0.001619)
    mov x13[14].x, l(0.000843)
    mov r2.x, x13[r0.z + 0].x
    mad r1.y, r1.y, r2.x, r0.x
    mov x14[1].x, l(1.495371)
    mov x14[2].x, l(3.489199)
    mov x14[3].x, l(5.483031)
    mov x14[4].x, l(7.476869)
    mov x14[5].x, l(9.470713)
    mov x14[6].x, l(11.464565)
    mov x14[7].x, l(13.458429)
    mov x14[8].x, l(15.452306)
    mov x14[9].x, l(17.446196)
    mov x14[10].x, l(19.440104)
    mov x14[11].x, l(21.434029)
    mov x14[12].x, l(23.427973)
    mov x14[13].x, l(25.421940)
    mov x14[14].x, l(27.415928)
    mov r2.x, x14[r0.z + 0].x
    mul r1.w, r2.x, cb0[0].y
    mad r2.xy, -r1.zwzz, l(0.000000, 0.000694, 0.000000, 0.000000), v1.xyxx
    sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.xyxx, t4.yzwx, s0, l(0.000000)
    mov x15[1].x, l(0.087299)
    mov x15[2].x, l(0.082089)
    mov x15[3].x, l(0.073482)
    mov x15[4].x, l(0.062617)
    mov x15[5].x, l(0.050796)
    mov x15[6].x, l(0.039226)
    mov x15[7].x, l(0.028837)
    mov x15[8].x, l(0.020181)
    mov x15[9].x, l(0.013445)
    mov x15[10].x, l(0.008527)
    mov x15[11].x, l(0.005148)
    mov x15[12].x, l(0.002959)
    mov x15[13].x, l(0.001619)
    mov x15[14].x, l(0.000843)
    mov r2.x, x15[r0.z + 0].x
    mad r0.x, r1.w, r2.x, r1.y
    iadd r0.z, r0.z, l(1)
    ilt r0.w, r0.z, l(15)
  endloop 
endif 
ieq r0.y, cb0[0].x, l(4)
if_nz r0.y
  mul r0.y, r0.x, l(0.033245)
  mov r1.xz, cb0[0].yyyy
  mov r0.z, r0.y
  mov r0.w, l(1)
  mov r2.x, l(-1)
  loop 
    breakc_z r2.x
    mov x16[1].x, l(1.495371)
    mov x16[2].x, l(3.489199)
    mov x16[3].x, l(5.483031)
    mov x16[4].x, l(7.476869)
    mov x16[5].x, l(9.470713)
    mov x16[6].x, l(11.464565)
    mov x16[7].x, l(13.458429)
    mov x16[8].x, l(15.452306)
    mov x16[9].x, l(17.446196)
    mov x16[10].x, l(19.466198)
    mov x16[11].x, l(21.462744)
    mov x16[12].x, l(23.459291)
    mov x16[13].x, l(25.455845)
    mov x16[14].x, l(27.452402)
    mov x16[15].x, l(29.448961)
    mov x16[16].x, l(31.445528)
    mov x16[17].x, l(33.442101)
    mov r2.y, x16[r0.w + 0].x
    mul r1.y, r2.y, cb0[0].y
    mad r2.yz, r1.xxyx, l(0.000000, 0.000000, 0.000694, 0.000000), v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.yzyy, t4.yxzw, s0, l(0.000000)
    mov x17[1].x, l(0.065916)
    mov x17[2].x, l(0.063671)
    mov x17[3].x, l(0.059819)
    mov x17[4].x, l(0.054664)
    mov x17[5].x, l(0.048587)
    mov x17[6].x, l(0.042005)
    mov x17[7].x, l(0.035321)
    mov x17[8].x, l(0.028888)
    mov x17[9].x, l(0.022981)
    mov x17[10].x, l(0.017782)
    mov x17[11].x, l(0.013382)
    mov x17[12].x, l(0.009796)
    mov x17[13].x, l(0.006975)
    mov x17[14].x, l(0.004830)
    mov x17[15].x, l(0.003253)
    mov x17[16].x, l(0.002132)
    mov x17[17].x, l(0.001358)
    mov r2.y, x17[r0.w + 0].x
    mad r1.y, r1.y, r2.y, r0.z
    mov x18[1].x, l(1.495371)
    mov x18[2].x, l(3.489199)
    mov x18[3].x, l(5.483031)
    mov x18[4].x, l(7.476869)
    mov x18[5].x, l(9.470713)
    mov x18[6].x, l(11.464565)
    mov x18[7].x, l(13.458429)
    mov x18[8].x, l(15.452306)
    mov x18[9].x, l(17.446196)
    mov x18[10].x, l(19.466198)
    mov x18[11].x, l(21.462744)
    mov x18[12].x, l(23.459291)
    mov x18[13].x, l(25.455845)
    mov x18[14].x, l(27.452402)
    mov x18[15].x, l(29.448961)
    mov x18[16].x, l(31.445528)
    mov x18[17].x, l(33.442101)
    mov r2.y, x18[r0.w + 0].x
    mul r1.w, r2.y, cb0[0].y
    mad r2.yz, -r1.zzwz, l(0.000000, 0.000000, 0.000694, 0.000000), v1.xxyx
    sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.yzyy, t4.yzwx, s0, l(0.000000)
    mov x19[1].x, l(0.065916)
    mov x19[2].x, l(0.063671)
    mov x19[3].x, l(0.059819)
    mov x19[4].x, l(0.054664)
    mov x19[5].x, l(0.048587)
    mov x19[6].x, l(0.042005)
    mov x19[7].x, l(0.035321)
    mov x19[8].x, l(0.028888)
    mov x19[9].x, l(0.022981)
    mov x19[10].x, l(0.017782)
    mov x19[11].x, l(0.013382)
    mov x19[12].x, l(0.009796)
    mov x19[13].x, l(0.006975)
    mov x19[14].x, l(0.004830)
    mov x19[15].x, l(0.003253)
    mov x19[16].x, l(0.002132)
    mov x19[17].x, l(0.001358)
    mov r2.y, x19[r0.w + 0].x
    mad r0.z, r1.w, r2.y, r1.y
    iadd r0.w, r0.w, l(1)
    ilt r2.x, r0.w, l(18)
  endloop 
  mov o0.x, r0.z
else 
  mov o0.x, r0.x
endif 
ret 
// Approximately 320 instruction slots used
