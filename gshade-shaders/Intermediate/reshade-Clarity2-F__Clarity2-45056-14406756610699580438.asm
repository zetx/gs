//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// __s1                              sampler      NA          NA             s1      1 
// __V__Clarity2Tex                  texture  float4          2d             t4      1 
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
dcl_sampler s1, mode_default
dcl_resource_texture2d (float,float,float,float) t4
dcl_input_ps linear v1.xy
dcl_output o0.x
dcl_temps 2
dcl_indexableTemp x0[15], 4
dcl_indexableTemp x1[15], 4
dcl_indexableTemp x2[15], 4
sample_indexable(texture2d)(float,float,float,float) r0.x, v1.xyxx, t4.xyzw, s1
mul r0.x, r0.x, l(0.044327)
mov r1.x, l(0)
mov r0.y, r0.x
mov r0.zw, l(0,0,1,-1)
loop 
  breakc_z r0.w
  mov x0[1].x, l(0.001038)
  mov x0[2].x, l(0.002423)
  mov x0[3].x, l(0.003808)
  mov x0[4].x, l(0.005192)
  mov x0[5].x, l(0.006577)
  mov x0[6].x, l(0.007962)
  mov x0[7].x, l(0.009346)
  mov x0[8].x, l(0.010731)
  mov x0[9].x, l(0.012115)
  mov x0[10].x, l(0.013500)
  mov x0[11].x, l(0.014885)
  mov x0[12].x, l(0.016269)
  mov x0[13].x, l(0.017654)
  mov x0[14].x, l(0.019039)
  mov r1.y, x0[r0.z + 0].x
  add r1.zw, r1.xxxy, v1.xxxy
  sample_l_indexable(texture2d)(float,float,float,float) r1.z, r1.zwzz, t4.yzxw, s1, l(0.000000)
  mov x1[1].x, l(0.087299)
  mov x1[2].x, l(0.082089)
  mov x1[3].x, l(0.073482)
  mov x1[4].x, l(0.062617)
  mov x1[5].x, l(0.050796)
  mov x1[6].x, l(0.039226)
  mov x1[7].x, l(0.028837)
  mov x1[8].x, l(0.020181)
  mov x1[9].x, l(0.013445)
  mov x1[10].x, l(0.008527)
  mov x1[11].x, l(0.005148)
  mov x1[12].x, l(0.002959)
  mov x1[13].x, l(0.001619)
  mov x1[14].x, l(0.000843)
  mov r1.w, x1[r0.z + 0].x
  mad r1.z, r1.z, r1.w, r0.y
  add r1.yw, -r1.xxxy, v1.xxxy
  sample_l_indexable(texture2d)(float,float,float,float) r1.y, r1.ywyy, t4.yxzw, s1, l(0.000000)
  mov x2[1].x, l(0.087299)
  mov x2[2].x, l(0.082089)
  mov x2[3].x, l(0.073482)
  mov x2[4].x, l(0.062617)
  mov x2[5].x, l(0.050796)
  mov x2[6].x, l(0.039226)
  mov x2[7].x, l(0.028837)
  mov x2[8].x, l(0.020181)
  mov x2[9].x, l(0.013445)
  mov x2[10].x, l(0.008527)
  mov x2[11].x, l(0.005148)
  mov x2[12].x, l(0.002959)
  mov x2[13].x, l(0.001619)
  mov x2[14].x, l(0.000843)
  mov r1.w, x2[r0.z + 0].x
  mad r0.y, r1.y, r1.w, r1.z
  iadd r0.z, r0.z, l(1)
  ilt r0.w, r0.z, l(15)
endloop 
mov o0.x, r0.y
ret 
// Approximately 63 instruction slots used
