//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int ClarityRadiusTwo;              // Offset:    0 Size:     4
//   float ClarityOffsetTwo;            // Offset:    4 Size:     4 [unused]
//   int ClarityBlendModeTwo;           // Offset:    8 Size:     4 [unused]
//   int ClarityBlendIfDarkTwo;         // Offset:   12 Size:     4 [unused]
//   int ClarityBlendIfLightTwo;        // Offset:   16 Size:     4 [unused]
//   float BlendIfRange;                // Offset:   20 Size:     4 [unused]
//   float ClarityStrengthTwo;          // Offset:   24 Size:     4 [unused]
//   float MaskContrast;                // Offset:   28 Size:     4 [unused]
//   float ClarityDarkIntensityTwo;     // Offset:   32 Size:     4 [unused]
//   float ClarityLightIntensityTwo;    // Offset:   36 Size:     4 [unused]
//   float DitherStrength;              // Offset:   40 Size:     4 [unused]
//   int PreprocessorDefinitions;       // Offset:   44 Size:     4 [unused]
//   float DitherTimer;                 // Offset:   48 Size:     4 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s1                              sampler      NA          NA             s1      1 
// __V__Clarity2Tex                  texture  float4          2d             t4      1 
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
dcl_sampler s1, mode_default
dcl_resource_texture2d (float,float,float,float) t4
dcl_input_ps linear v1.xy
dcl_output o0.x
dcl_temps 3
dcl_indexableTemp x0[11], 4
dcl_indexableTemp x1[11], 4
dcl_indexableTemp x2[11], 4
dcl_indexableTemp x3[15], 4
dcl_indexableTemp x4[15], 4
dcl_indexableTemp x5[15], 4
dcl_indexableTemp x6[18], 4
dcl_indexableTemp x7[18], 4
dcl_indexableTemp x8[18], 4
dcl_indexableTemp x9[6], 4
dcl_indexableTemp x10[6], 4
dcl_indexableTemp x11[6], 4
dcl_indexableTemp x12[4], 4
dcl_indexableTemp x13[4], 4
dcl_indexableTemp x14[4], 4
sample_indexable(texture2d)(float,float,float,float) r0.x, v1.xyxx, t4.xyzw, s1
ieq r0.y, cb0[0].x, l(2)
if_nz r0.y
  mul r0.y, r0.x, l(0.066490)
  mov r1.x, l(0)
  mov r0.z, r0.y
  mov r0.w, l(1)
  mov r1.z, l(-1)
  loop 
    breakc_z r1.z
    mov x0[1].x, l(0.001940)
    mov x0[2].x, l(0.004526)
    mov x0[3].x, l(0.007112)
    mov x0[4].x, l(0.009698)
    mov x0[5].x, l(0.012284)
    mov x0[6].x, l(0.014871)
    mov x0[7].x, l(0.017457)
    mov x0[8].x, l(0.020044)
    mov x0[9].x, l(0.022631)
    mov x0[10].x, l(0.025218)
    mov r1.y, x0[r0.w + 0].x
    add r2.xy, r1.xyxx, v1.xyxx
    sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.xyxx, t4.yzwx, s1, l(0.000000)
    mov x1[1].x, l(0.128470)
    mov x1[2].x, l(0.111918)
    mov x1[3].x, l(0.087313)
    mov x1[4].x, l(0.061001)
    mov x1[5].x, l(0.038166)
    mov x1[6].x, l(0.021384)
    mov x1[7].x, l(0.010729)
    mov x1[8].x, l(0.004821)
    mov x1[9].x, l(0.001940)
    mov x1[10].x, l(0.000699)
    mov r2.x, x1[r0.w + 0].x
    mad r1.w, r1.w, r2.x, r0.z
    add r2.xy, -r1.xyxx, v1.xyxx
    sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.xyxx, t4.yxzw, s1, l(0.000000)
    mov x2[1].x, l(0.128470)
    mov x2[2].x, l(0.111918)
    mov x2[3].x, l(0.087313)
    mov x2[4].x, l(0.061001)
    mov x2[5].x, l(0.038166)
    mov x2[6].x, l(0.021384)
    mov x2[7].x, l(0.010729)
    mov x2[8].x, l(0.004821)
    mov x2[9].x, l(0.001940)
    mov x2[10].x, l(0.000699)
    mov r2.x, x2[r0.w + 0].x
    mad r0.z, r1.y, r2.x, r1.w
    iadd r0.w, r0.w, l(1)
    ilt r1.z, r0.w, l(11)
  endloop 
  mov o0.x, r0.z
else 
  ieq r0.y, cb0[0].x, l(3)
  if_nz r0.y
    mul r0.y, r0.x, l(0.044327)
    mov r1.x, l(0)
    mov r0.z, r0.y
    mov r0.w, l(1)
    mov r1.z, l(-1)
    loop 
      breakc_z r1.z
      mov x3[1].x, l(0.001947)
      mov x3[2].x, l(0.004543)
      mov x3[3].x, l(0.007139)
      mov x3[4].x, l(0.009736)
      mov x3[5].x, l(0.012332)
      mov x3[6].x, l(0.014928)
      mov x3[7].x, l(0.017524)
      mov x3[8].x, l(0.020120)
      mov x3[9].x, l(0.022716)
      mov x3[10].x, l(0.025313)
      mov x3[11].x, l(0.027909)
      mov x3[12].x, l(0.030505)
      mov x3[13].x, l(0.033101)
      mov x3[14].x, l(0.035698)
      mov r1.y, x3[r0.w + 0].x
      add r2.xy, r1.xyxx, v1.xyxx
      sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.xyxx, t4.yzwx, s1, l(0.000000)
      mov x4[1].x, l(0.087299)
      mov x4[2].x, l(0.082089)
      mov x4[3].x, l(0.073482)
      mov x4[4].x, l(0.062617)
      mov x4[5].x, l(0.050796)
      mov x4[6].x, l(0.039226)
      mov x4[7].x, l(0.028837)
      mov x4[8].x, l(0.020181)
      mov x4[9].x, l(0.013445)
      mov x4[10].x, l(0.008527)
      mov x4[11].x, l(0.005148)
      mov x4[12].x, l(0.002959)
      mov x4[13].x, l(0.001619)
      mov x4[14].x, l(0.000843)
      mov r2.x, x4[r0.w + 0].x
      mad r1.w, r1.w, r2.x, r0.z
      add r2.xy, -r1.xyxx, v1.xyxx
      sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.xyxx, t4.yxzw, s1, l(0.000000)
      mov x5[1].x, l(0.087299)
      mov x5[2].x, l(0.082089)
      mov x5[3].x, l(0.073482)
      mov x5[4].x, l(0.062617)
      mov x5[5].x, l(0.050796)
      mov x5[6].x, l(0.039226)
      mov x5[7].x, l(0.028837)
      mov x5[8].x, l(0.020181)
      mov x5[9].x, l(0.013445)
      mov x5[10].x, l(0.008527)
      mov x5[11].x, l(0.005148)
      mov x5[12].x, l(0.002959)
      mov x5[13].x, l(0.001619)
      mov x5[14].x, l(0.000843)
      mov r2.x, x5[r0.w + 0].x
      mad r0.z, r1.y, r2.x, r1.w
      iadd r0.w, r0.w, l(1)
      ilt r1.z, r0.w, l(15)
    endloop 
    mov o0.x, r0.z
  else 
    ieq r0.y, cb0[0].x, l(4)
    if_nz r0.y
      mul r0.y, r0.x, l(0.033245)
      mov r1.x, l(0)
      mov r0.z, r0.y
      mov r0.w, l(1)
      mov r1.z, l(-1)
      loop 
        breakc_z r1.z
        mov x6[1].x, l(0.001947)
        mov x6[2].x, l(0.004543)
        mov x6[3].x, l(0.007139)
        mov x6[4].x, l(0.009736)
        mov x6[5].x, l(0.012332)
        mov x6[6].x, l(0.014928)
        mov x6[7].x, l(0.017524)
        mov x6[8].x, l(0.020120)
        mov x6[9].x, l(0.022716)
        mov x6[10].x, l(0.025347)
        mov x6[11].x, l(0.027946)
        mov x6[12].x, l(0.030546)
        mov x6[13].x, l(0.033146)
        mov x6[14].x, l(0.035745)
        mov x6[15].x, l(0.038345)
        mov x6[16].x, l(0.040945)
        mov x6[17].x, l(0.043544)
        mov r1.y, x6[r0.w + 0].x
        add r2.xy, r1.xyxx, v1.xyxx
        sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.xyxx, t4.yzwx, s1, l(0.000000)
        mov x7[1].x, l(0.065916)
        mov x7[2].x, l(0.063671)
        mov x7[3].x, l(0.059819)
        mov x7[4].x, l(0.054664)
        mov x7[5].x, l(0.048587)
        mov x7[6].x, l(0.042005)
        mov x7[7].x, l(0.035321)
        mov x7[8].x, l(0.028888)
        mov x7[9].x, l(0.022981)
        mov x7[10].x, l(0.017782)
        mov x7[11].x, l(0.013382)
        mov x7[12].x, l(0.009796)
        mov x7[13].x, l(0.006975)
        mov x7[14].x, l(0.004830)
        mov x7[15].x, l(0.003253)
        mov x7[16].x, l(0.002132)
        mov x7[17].x, l(0.001358)
        mov r2.x, x7[r0.w + 0].x
        mad r1.w, r1.w, r2.x, r0.z
        add r2.xy, -r1.xyxx, v1.xyxx
        sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.xyxx, t4.yxzw, s1, l(0.000000)
        mov x8[1].x, l(0.065916)
        mov x8[2].x, l(0.063671)
        mov x8[3].x, l(0.059819)
        mov x8[4].x, l(0.054664)
        mov x8[5].x, l(0.048587)
        mov x8[6].x, l(0.042005)
        mov x8[7].x, l(0.035321)
        mov x8[8].x, l(0.028888)
        mov x8[9].x, l(0.022981)
        mov x8[10].x, l(0.017782)
        mov x8[11].x, l(0.013382)
        mov x8[12].x, l(0.009796)
        mov x8[13].x, l(0.006975)
        mov x8[14].x, l(0.004830)
        mov x8[15].x, l(0.003253)
        mov x8[16].x, l(0.002132)
        mov x8[17].x, l(0.001358)
        mov r2.x, x8[r0.w + 0].x
        mad r0.z, r1.y, r2.x, r1.w
        iadd r0.w, r0.w, l(1)
        ilt r1.z, r0.w, l(18)
      endloop 
      mov o0.x, r0.z
    else 
      ieq r0.y, cb0[0].x, l(1)
      if_nz r0.y
        mul r0.y, r0.x, l(0.132980)
        mov r1.x, l(0)
        mov r0.z, r0.y
        mov r0.w, l(1)
        mov r1.z, l(-1)
        loop 
          breakc_z r1.z
          mov x9[1].x, l(0.001899)
          mov x9[2].x, l(0.004432)
          mov x9[3].x, l(0.006968)
          mov x9[4].x, l(0.009509)
          mov x9[5].x, l(0.012055)
          mov r1.y, x9[r0.w + 0].x
          add r2.xy, r1.xyxx, v1.xyxx
          sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.xyxx, t4.yzwx, s1, l(0.000000)
          mov x10[1].x, l(0.232276)
          mov x10[2].x, l(0.135326)
          mov x10[3].x, l(0.051156)
          mov x10[4].x, l(0.012539)
          mov x10[5].x, l(0.001991)
          mov r2.x, x10[r0.w + 0].x
          mad r1.w, r1.w, r2.x, r0.z
          add r2.xy, -r1.xyxx, v1.xyxx
          sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.xyxx, t4.yxzw, s1, l(0.000000)
          mov x11[1].x, l(0.232276)
          mov x11[2].x, l(0.135326)
          mov x11[3].x, l(0.051156)
          mov x11[4].x, l(0.012539)
          mov x11[5].x, l(0.001991)
          mov r2.x, x11[r0.w + 0].x
          mad r0.z, r1.y, r2.x, r1.w
          iadd r0.w, r0.w, l(1)
          ilt r1.z, r0.w, l(6)
        endloop 
        mov o0.x, r0.z
      else 
        if_z cb0[0].x
          mul r0.y, r0.x, l(0.398940)
          mov r1.x, l(0)
          mov r0.z, r0.y
          mov r0.w, l(1)
          mov r1.z, l(-1)
          loop 
            breakc_z r1.z
            mov x12[1].x, l(0.001540)
            mov x12[2].x, l(0.003944)
            mov x12[3].x, l(0.006516)
            mov r1.y, x12[r0.w + 0].x
            add r2.xy, r1.xyxx, v1.xyxx
            sample_l_indexable(texture2d)(float,float,float,float) r1.w, r2.xyxx, t4.yzwx, s1, l(0.000000)
            mov x13[1].x, l(0.295960)
            mov x13[2].x, l(0.004566)
            mov x13[3].x, l(0.000001)
            mov r2.x, x13[r0.w + 0].x
            mad r1.w, r1.w, r2.x, r0.z
            add r2.xy, -r1.xyxx, v1.xyxx
            sample_l_indexable(texture2d)(float,float,float,float) r1.y, r2.xyxx, t4.yxzw, s1, l(0.000000)
            mov x14[1].x, l(0.295960)
            mov x14[2].x, l(0.004566)
            mov x14[3].x, l(0.000001)
            mov r2.x, x14[r0.w + 0].x
            mad r0.z, r1.y, r2.x, r1.w
            iadd r0.w, r0.w, l(1)
            ilt r1.z, r0.w, l(4)
          endloop 
          mov o0.x, r0.z
        else 
          mov o0.x, r0.x
        endif 
      endif 
    endif 
  endif 
endif 
ret 
// Approximately 269 instruction slots used
