//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer _Globals
// {
//
//   int BlurRadius;                    // Offset:    0 Size:     4
//   float BlurOffset;                  // Offset:    4 Size:     4
//   float BlurEdge;                    // Offset:    8 Size:     4
//   float BlurStrength;                // Offset:   12 Size:     4
//   int DebugMode;                     // Offset:   16 Size:     4
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
dcl_constantbuffer CB0[2], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 7
dcl_indexableTemp x0[13], 4
dcl_indexableTemp x1[13], 4
dcl_indexableTemp x2[13], 4
dcl_indexableTemp x3[13], 4
dcl_indexableTemp x4[13], 4
dcl_indexableTemp x5[13], 4
dcl_indexableTemp x6[13], 4
dcl_indexableTemp x7[13], 4
dcl_indexableTemp x8[25], 4
dcl_indexableTemp x9[25], 4
dcl_indexableTemp x10[25], 4
dcl_indexableTemp x11[25], 4
sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s0
ieq r0.w, cb0[0].x, l(1)
if_nz r0.w
  mad r1.xyzw, cb0[0].yyyy, l(0.000291, 0.000000, 0.000000, 0.000694), v1.xyxy
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r1.xyxx, t0.xyzw, s0, l(0.000000)
  add r3.xyz, r0.xyzx, -r2.xyzx
  dp3 r0.w, r3.xyzx, r3.xyzx
  div r0.w, r0.w, cb0[0].z
  add r0.w, r0.w, l(1.000000)
  mul r1.x, r0.w, r0.w
  mul r1.x, r1.x, r1.x
  mul r0.w, r0.w, r1.x
  rcp r0.w, r0.w
  mul r0.w, r0.w, l(0.150538)
  mad r3.xyzw, -cb0[0].yyyy, l(0.000291, 0.000000, 0.000000, 0.000694), v1.xyxy
  sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r3.xyxx, t0.xyzw, s0, l(0.000000)
  add r5.xyz, r0.xyzx, -r4.xyzx
  dp3 r1.x, r5.xyzx, r5.xyzx
  div r1.x, r1.x, cb0[0].z
  add r1.x, r1.x, l(1.000000)
  mul r1.y, r1.x, r1.x
  mul r1.y, r1.y, r1.y
  mul r1.x, r1.x, r1.y
  rcp r1.x, r1.x
  mul r1.y, r1.x, l(0.150538)
  mad r1.x, r1.x, l(0.150538), r0.w
  mul r2.xyz, r2.xyzx, r0.wwww
  mad r2.xyz, r0.xyzx, l(0.225806, 0.225806, 0.225806, 0.000000), r2.xyzx
  add r0.w, r1.x, l(0.225806)
  mad r2.xyz, r1.yyyy, r4.xyzx, r2.xyzx
  sample_l_indexable(texture2d)(float,float,float,float) r1.xyz, r1.zwzz, t0.xyzw, s0, l(0.000000)
  add r4.xyz, r0.xyzx, -r1.xyzx
  dp3 r1.w, r4.xyzx, r4.xyzx
  div r1.w, r1.w, cb0[0].z
  add r1.w, r1.w, l(1.000000)
  mul r2.w, r1.w, r1.w
  mul r2.w, r2.w, r2.w
  mul r1.w, r1.w, r2.w
  rcp r1.w, r1.w
  mul r2.w, r1.w, l(0.150538)
  sample_l_indexable(texture2d)(float,float,float,float) r3.xyz, r3.zwzz, t0.xyzw, s0, l(0.000000)
  add r4.xyz, r0.xyzx, -r3.xyzx
  dp3 r3.w, r4.xyzx, r4.xyzx
  div r3.w, r3.w, cb0[0].z
  add r3.w, r3.w, l(1.000000)
  mul r4.x, r3.w, r3.w
  mul r4.x, r4.x, r4.x
  mul r3.w, r3.w, r4.x
  rcp r3.w, r3.w
  mul r4.x, r3.w, l(0.150538)
  mad r0.w, r1.w, l(0.150538), r0.w
  mad r1.xyz, r2.wwww, r1.xyzx, r2.xyzx
  mad r0.w, r3.w, l(0.150538), r0.w
  mad r1.xyz, r4.xxxx, r3.xyzx, r1.xyzx
  mad r2.xyzw, cb0[0].yyyy, l(0.000291, 0.000694, 0.000291, -0.000694), v1.xyxy
  sample_l_indexable(texture2d)(float,float,float,float) r3.xyz, r2.xyxx, t0.xyzw, s0, l(0.000000)
  add r4.xyz, r0.xyzx, -r3.xyzx
  dp3 r1.w, r4.xyzx, r4.xyzx
  div r1.w, r1.w, cb0[0].z
  add r1.w, r1.w, l(1.000000)
  mul r2.x, r1.w, r1.w
  mul r2.x, r2.x, r2.x
  mul r1.w, r1.w, r2.x
  rcp r1.w, r1.w
  mul r2.x, r1.w, l(0.043011)
  mad r4.xyzw, -cb0[0].yyyy, l(0.000291, 0.000694, 0.000291, -0.000694), v1.xyxy
  sample_l_indexable(texture2d)(float,float,float,float) r5.xyz, r4.xyxx, t0.xyzw, s0, l(0.000000)
  add r6.xyz, r0.xyzx, -r5.xyzx
  dp3 r2.y, r6.xyzx, r6.xyzx
  div r2.y, r2.y, cb0[0].z
  add r2.y, r2.y, l(1.000000)
  mul r3.w, r2.y, r2.y
  mul r3.w, r3.w, r3.w
  mul r2.y, r2.y, r3.w
  rcp r2.y, r2.y
  mul r3.w, r2.y, l(0.043011)
  mad r0.w, r1.w, l(0.043011), r0.w
  mad r1.xyz, r2.xxxx, r3.xyzx, r1.xyzx
  mad r0.w, r2.y, l(0.043011), r0.w
  mad r1.xyz, r3.wwww, r5.xyzx, r1.xyzx
  sample_l_indexable(texture2d)(float,float,float,float) r2.xyz, r2.zwzz, t0.xyzw, s0, l(0.000000)
  add r3.xyz, r0.xyzx, -r2.xyzx
  dp3 r1.w, r3.xyzx, r3.xyzx
  div r1.w, r1.w, cb0[0].z
  add r1.w, r1.w, l(1.000000)
  mul r2.w, r1.w, r1.w
  mul r2.w, r2.w, r2.w
  mul r1.w, r1.w, r2.w
  rcp r1.w, r1.w
  mul r2.w, r1.w, l(0.043011)
  sample_l_indexable(texture2d)(float,float,float,float) r3.xyz, r4.zwzz, t0.xyzw, s0, l(0.000000)
  add r4.xyz, r0.xyzx, -r3.xyzx
  dp3 r3.w, r4.xyzx, r4.xyzx
  div r3.w, r3.w, cb0[0].z
  add r3.w, r3.w, l(1.000000)
  mul r4.x, r3.w, r3.w
  mul r4.x, r4.x, r4.x
  mul r3.w, r3.w, r4.x
  rcp r3.w, r3.w
  mul r4.x, r3.w, l(0.043011)
  mad r0.w, r1.w, l(0.043011), r0.w
  mad r1.xyz, r2.wwww, r2.xyzx, r1.xyzx
  mad r0.w, r3.w, l(0.043011), r0.w
  mad r1.xyz, r4.xxxx, r3.xyzx, r1.xyzx
else 
  ieq r1.w, cb0[0].x, l(2)
  if_nz r1.w
    mul r2.xyz, r0.xyzx, l(0.150999, 0.150999, 0.150999, 0.000000)
    mov r1.xyz, r2.xyzx
    mov r0.w, l(0.150999)
    mov r1.w, l(1)
    mov r2.w, l(-1)
    loop 
      breakc_z r2.w
      mov x0[1].x, l(0.000291)
      mov x0[2].x, l(0)
      mov x0[3].x, l(0.000291)
      mov x0[4].x, l(0.000291)
      mov x0[5].x, l(0.000581)
      mov x0[6].x, l(0)
      mov x0[7].x, l(0.000581)
      mov x0[8].x, l(0.000581)
      mov x0[9].x, l(0.000291)
      mov x0[10].x, l(0.000291)
      mov x0[11].x, l(0.000581)
      mov x0[12].x, l(0.000581)
      mov x1[1].x, l(0)
      mov x1[2].x, l(0.000694)
      mov x1[3].x, l(0.000694)
      mov x1[4].x, l(-0.000694)
      mov x1[5].x, l(0)
      mov x1[6].x, l(0.001389)
      mov x1[7].x, l(0.000694)
      mov x1[8].x, l(-0.000694)
      mov x1[9].x, l(0.001389)
      mov x1[10].x, l(-0.001389)
      mov x1[11].x, l(0.001389)
      mov x1[12].x, l(-0.001389)
      mov r3.x, x0[r1.w + 0].x
      mov r3.y, x1[r1.w + 0].x
      mad r3.zw, r3.xxxy, cb0[0].yyyy, v1.xxxy
      sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r3.zwzz, t0.xyzw, s0, l(0.000000)
      add r5.xyz, r0.xyzx, -r4.xyzx
      dp3 r3.z, r5.xyzx, r5.xyzx
      div r3.z, r3.z, cb0[0].z
      add r3.z, r3.z, l(1.000000)
      mov x2[1].x, l(0.113249)
      mov x2[2].x, l(0.113249)
      mov x2[3].x, l(0.027399)
      mov x2[4].x, l(0.027399)
      mov x2[5].x, l(0.045300)
      mov x2[6].x, l(0.045300)
      mov x2[7].x, l(0.010960)
      mov x2[8].x, l(0.010960)
      mov x2[9].x, l(0.010960)
      mov x2[10].x, l(0.010960)
      mov x2[11].x, l(0.004384)
      mov x2[12].x, l(0.004384)
      mul r3.w, r3.z, r3.z
      mul r3.w, r3.w, r3.w
      mul r3.z, r3.z, r3.w
      mov r3.w, x2[r1.w + 0].x
      div r3.z, r3.w, r3.z
      mad r3.xy, -r3.xyxx, cb0[0].yyyy, v1.xyxx
      sample_l_indexable(texture2d)(float,float,float,float) r3.xyw, r3.xyxx, t0.xywz, s0, l(0.000000)
      add r5.xyz, r0.xyzx, -r3.xywx
      dp3 r4.w, r5.xyzx, r5.xyzx
      div r4.w, r4.w, cb0[0].z
      add r4.w, r4.w, l(1.000000)
      mov x3[1].x, l(0.113249)
      mov x3[2].x, l(0.113249)
      mov x3[3].x, l(0.027399)
      mov x3[4].x, l(0.027399)
      mov x3[5].x, l(0.045300)
      mov x3[6].x, l(0.045300)
      mov x3[7].x, l(0.010960)
      mov x3[8].x, l(0.010960)
      mov x3[9].x, l(0.010960)
      mov x3[10].x, l(0.010960)
      mov x3[11].x, l(0.004384)
      mov x3[12].x, l(0.004384)
      mul r5.x, r4.w, r4.w
      mul r5.x, r5.x, r5.x
      mul r4.w, r4.w, r5.x
      mov r5.x, x3[r1.w + 0].x
      div r4.w, r5.x, r4.w
      add r5.x, r0.w, r3.z
      mad r4.xyz, r3.zzzz, r4.xyzx, r1.xyzx
      add r0.w, r4.w, r5.x
      mad r1.xyz, r4.wwww, r3.xywx, r4.xyzx
      iadd r1.w, r1.w, l(1)
      ilt r2.w, r1.w, l(13)
    endloop 
  else 
    ieq r1.w, cb0[0].x, l(3)
    if_nz r1.w
      mul r2.xyz, r0.xyzx, l(0.095773, 0.095773, 0.095773, 0.000000)
      mov r1.xyz, r2.xyzx
      mov r0.w, l(0.095773)
      mov r1.w, l(1)
      mov r2.w, l(-1)
      loop 
        breakc_z r2.w
        mov x4[1].x, l(0.000403)
        mov x4[2].x, l(0)
        mov x4[3].x, l(0.000403)
        mov x4[4].x, l(0.000403)
        mov x4[5].x, l(0.000939)
        mov x4[6].x, l(0)
        mov x4[7].x, l(0.000939)
        mov x4[8].x, l(0.000939)
        mov x4[9].x, l(0.000403)
        mov x4[10].x, l(0.000403)
        mov x4[11].x, l(0.000939)
        mov x4[12].x, l(0.000939)
        mov x5[1].x, l(0)
        mov x5[2].x, l(0.000962)
        mov x5[3].x, l(0.000962)
        mov x5[4].x, l(-0.000962)
        mov x5[5].x, l(0)
        mov x5[6].x, l(0.002244)
        mov x5[7].x, l(0.000962)
        mov x5[8].x, l(-0.000962)
        mov x5[9].x, l(0.002244)
        mov x5[10].x, l(-0.002244)
        mov x5[11].x, l(0.002244)
        mov x5[12].x, l(-0.002244)
        mov r3.x, x4[r1.w + 0].x
        mov r3.y, x5[r1.w + 0].x
        mad r3.zw, r3.xxxy, cb0[0].yyyy, v1.xxxy
        sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r3.zwzz, t0.xyzw, s0, l(0.000000)
        add r5.xyz, r0.xyzx, -r4.xyzx
        dp3 r3.z, r5.xyzx, r5.xyzx
        div r3.z, r3.z, cb0[0].z
        add r3.z, r3.z, l(1.000000)
        mov x6[1].x, l(0.133399)
        mov x6[2].x, l(0.133399)
        mov x6[3].x, l(0.042183)
        mov x6[4].x, l(0.042183)
        mov x6[5].x, l(0.029644)
        mov x6[6].x, l(0.029644)
        mov x6[7].x, l(0.009374)
        mov x6[8].x, l(0.009374)
        mov x6[9].x, l(0.009374)
        mov x6[10].x, l(0.009374)
        mov x6[11].x, l(0.002083)
        mov x6[12].x, l(0.002083)
        mul r3.w, r3.z, r3.z
        mul r3.w, r3.w, r3.w
        mul r3.z, r3.z, r3.w
        mov r3.w, x6[r1.w + 0].x
        div r3.z, r3.w, r3.z
        mad r3.xy, -r3.xyxx, cb0[0].yyyy, v1.xyxx
        sample_l_indexable(texture2d)(float,float,float,float) r3.xyw, r3.xyxx, t0.xywz, s0, l(0.000000)
        add r5.xyz, r0.xyzx, -r3.xywx
        dp3 r4.w, r5.xyzx, r5.xyzx
        div r4.w, r4.w, cb0[0].z
        add r4.w, r4.w, l(1.000000)
        mov x7[1].x, l(0.133399)
        mov x7[2].x, l(0.133399)
        mov x7[3].x, l(0.042183)
        mov x7[4].x, l(0.042183)
        mov x7[5].x, l(0.029644)
        mov x7[6].x, l(0.029644)
        mov x7[7].x, l(0.009374)
        mov x7[8].x, l(0.009374)
        mov x7[9].x, l(0.009374)
        mov x7[10].x, l(0.009374)
        mov x7[11].x, l(0.002083)
        mov x7[12].x, l(0.002083)
        mul r5.x, r4.w, r4.w
        mul r5.x, r5.x, r5.x
        mul r4.w, r4.w, r5.x
        mov r5.x, x7[r1.w + 0].x
        div r4.w, r5.x, r4.w
        add r5.x, r0.w, r3.z
        mad r4.xyz, r3.zzzz, r4.xyzx, r1.xyzx
        add r0.w, r4.w, r5.x
        mad r1.xyz, r4.wwww, r3.xywx, r4.xyzx
        iadd r1.w, r1.w, l(1)
        ilt r2.w, r1.w, l(13)
      endloop 
    else 
      ige r1.w, cb0[0].x, l(4)
      if_nz r1.w
        mul r2.xyz, r0.xyzx, l(0.052992, 0.052992, 0.052992, 0.000000)
        mov r1.xyz, r2.xyzx
        mov r0.w, l(0.052992)
        mov r1.w, l(1)
        mov r2.w, l(-1)
        loop 
          breakc_z r2.w
          mov x8[1].x, l(0.000424)
          mov x8[2].x, l(0)
          mov x8[3].x, l(0.000424)
          mov x8[4].x, l(0.000424)
          mov x8[5].x, l(0.000990)
          mov x8[6].x, l(0)
          mov x8[7].x, l(0.000990)
          mov x8[8].x, l(0.000990)
          mov x8[9].x, l(0.000424)
          mov x8[10].x, l(0.000424)
          mov x8[11].x, l(0.000990)
          mov x8[12].x, l(0.000990)
          mov x8[13].x, l(0.001556)
          mov x8[14].x, l(0)
          mov x8[15].x, l(0.001556)
          mov x8[16].x, l(0.001556)
          mov x8[17].x, l(0.001556)
          mov x8[18].x, l(0.001556)
          mov x8[19].x, l(0.000424)
          mov x8[20].x, l(0.000424)
          mov x8[21].x, l(0.000990)
          mov x8[22].x, l(0.000990)
          mov x8[23].x, l(0.001556)
          mov x8[24].x, l(0.001556)
          mov x9[1].x, l(0)
          mov x9[2].x, l(0.001013)
          mov x9[3].x, l(0.001013)
          mov x9[4].x, l(-0.001013)
          mov x9[5].x, l(0)
          mov x9[6].x, l(0.002364)
          mov x9[7].x, l(0.001013)
          mov x9[8].x, l(-0.001013)
          mov x9[9].x, l(0.002364)
          mov x9[10].x, l(-0.002364)
          mov x9[11].x, l(0.002364)
          mov x9[12].x, l(-0.002364)
          mov x9[13].x, l(0)
          mov x9[14].x, l(0.003717)
          mov x9[15].x, l(0.001013)
          mov x9[16].x, l(-0.001013)
          mov x9[17].x, l(0.002364)
          mov x9[18].x, l(-0.002364)
          mov x9[19].x, l(0.003717)
          mov x9[20].x, l(-0.003717)
          mov x9[21].x, l(0.003717)
          mov x9[22].x, l(-0.003717)
          mov x9[23].x, l(0.003717)
          mov x9[24].x, l(-0.003717)
          mov r3.x, x8[r1.w + 0].x
          mov r3.y, x9[r1.w + 0].x
          mad r3.zw, r3.xxxy, cb0[0].yyyy, v1.xxxy
          sample_l_indexable(texture2d)(float,float,float,float) r4.xyz, r3.zwzz, t0.xyzw, s0, l(0.000000)
          add r5.xyz, r0.xyzx, -r4.xyzx
          dp3 r3.z, r5.xyzx, r5.xyzx
          div r3.z, r3.z, cb0[0].z
          add r3.z, r3.z, l(1.000000)
          mov x10[1].x, l(0.092561)
          mov x10[2].x, l(0.092561)
          mov x10[3].x, l(0.021500)
          mov x10[4].x, l(0.021500)
          mov x10[5].x, l(0.053927)
          mov x10[6].x, l(0.053927)
          mov x10[7].x, l(0.012526)
          mov x10[8].x, l(0.012526)
          mov x10[9].x, l(0.012526)
          mov x10[10].x, l(0.012526)
          mov x10[11].x, l(0.007298)
          mov x10[12].x, l(0.007298)
          mov x10[13].x, l(0.020385)
          mov x10[14].x, l(0.020385)
          mov x10[15].x, l(0.004735)
          mov x10[16].x, l(0.004735)
          mov x10[17].x, l(0.002759)
          mov x10[18].x, l(0.002759)
          mov x10[19].x, l(0.004735)
          mov x10[20].x, l(0.004735)
          mov x10[21].x, l(0.002759)
          mov x10[22].x, l(0.002759)
          mov x10[23].x, l(0.001043)
          mov x10[24].x, l(0.001043)
          mul r3.w, r3.z, r3.z
          mul r3.w, r3.w, r3.w
          mul r3.z, r3.z, r3.w
          mov r3.w, x10[r1.w + 0].x
          div r3.z, r3.w, r3.z
          mad r3.xy, -r3.xyxx, cb0[0].yyyy, v1.xyxx
          sample_l_indexable(texture2d)(float,float,float,float) r3.xyw, r3.xyxx, t0.xywz, s0, l(0.000000)
          add r5.xyz, r0.xyzx, -r3.xywx
          dp3 r4.w, r5.xyzx, r5.xyzx
          div r4.w, r4.w, cb0[0].z
          add r4.w, r4.w, l(1.000000)
          mov x11[1].x, l(0.092561)
          mov x11[2].x, l(0.092561)
          mov x11[3].x, l(0.021500)
          mov x11[4].x, l(0.021500)
          mov x11[5].x, l(0.053927)
          mov x11[6].x, l(0.053927)
          mov x11[7].x, l(0.012526)
          mov x11[8].x, l(0.012526)
          mov x11[9].x, l(0.012526)
          mov x11[10].x, l(0.012526)
          mov x11[11].x, l(0.007298)
          mov x11[12].x, l(0.007298)
          mov x11[13].x, l(0.020385)
          mov x11[14].x, l(0.020385)
          mov x11[15].x, l(0.004735)
          mov x11[16].x, l(0.004735)
          mov x11[17].x, l(0.002759)
          mov x11[18].x, l(0.002759)
          mov x11[19].x, l(0.004735)
          mov x11[20].x, l(0.004735)
          mov x11[21].x, l(0.002759)
          mov x11[22].x, l(0.002759)
          mov x11[23].x, l(0.001043)
          mov x11[24].x, l(0.001043)
          mul r5.x, r4.w, r4.w
          mul r5.x, r5.x, r5.x
          mul r4.w, r4.w, r5.x
          mov r5.x, x11[r1.w + 0].x
          div r4.w, r5.x, r4.w
          add r5.x, r0.w, r3.z
          mad r4.xyz, r3.zzzz, r4.xyzx, r1.xyzx
          add r0.w, r4.w, r5.x
          mad r1.xyz, r4.wwww, r3.xywx, r4.xyzx
          iadd r1.w, r1.w, l(1)
          ilt r2.w, r1.w, l(25)
        endloop 
      else 
        mov r1.xyz, l(0,0,0,0)
        mov r0.w, l(0)
      endif 
    endif 
  endif 
endif 
ieq r1.w, cb0[1].x, l(1)
if_nz r1.w
  mov o0.xyz, r0.wwww
  mov o0.w, l(0)
  ret 
endif 
ieq r1.w, cb0[1].x, l(2)
if_nz r1.w
  div o0.xyz, r1.xyzx, r0.wwww
  mov o0.w, l(0)
  ret 
endif 
div r1.xyz, r1.xyzx, r0.wwww
add r1.xyz, -r0.xyzx, r1.xyzx
mad_sat o0.xyz, cb0[0].wwww, r1.xyzx, r0.xyzx
mov o0.w, l(0)
ret 
// Approximately 443 instruction slots used