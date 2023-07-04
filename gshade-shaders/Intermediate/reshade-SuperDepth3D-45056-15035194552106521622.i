#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SuperDepth3D.fx"
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Overwatch.fxh"
#line 31
static const float ZPD_D = 0.025;                       
static const float Depth_Adjust_D = 7.5;                
static const float Offset_D = 0.0;                      
static const int Depth_Linearization_D = 0;             
#line 36
static const int Depth_Flip_D = 0;                      
static const int Auto_Balance_D = 0;                    
static const float Auto_Depth_D = 0.1;                  
static const int Weapon_Hand_D = 0;                     
#line 42
static const int Barrel_Distortion_Fix_D = 0;           
static const float BD_K1_D = 0.0;                       
static const float BD_K2_D = 0.0;                       
static const float BD_K3_D = 0.0;                       
static const float BD_Zoom_D = 0.0;                     
#line 49
static const int Size_Position_Fix_D = 0;               
static const float HVS_X_D = 1.0;                       
static const float HVS_Y_D = 1.0;                       
static const float HVP_X_D = 0;                         
static const float HVP_Y_D = 0;                         
#line 55
static const int ZPD_Boundary_Type_D = 0;               
static const float ZPD_Boundary_Scaling_D = 0.5;        
static const float ZPD_Boundary_Fade_Time_D = 0.25;     
static const float Weapon_Near_Depth_Max_D = 0.0;       
#line 61
static const int Balance_Mode_Toggle_D = 0;             
static const float ZPD_Weapon_Boundary_Adjust_D = 0.0;  
static const float Separation_D = 0.0;                  
static const float Manual_ZPD_Balance_D = 0.5;          
static const float HUDX_D = 0.0;                        
#line 68
static const int Specialized_Depth_Trigger_D = 0;       
static const float SDC_Offset_X_D = 0.0;                
static const float SDC_Offset_Y_D = 0.0;                
static const float Weapon_Near_Depth_Min_D = 0.0;       
static const float Check_Depth_Limit_D = 0.0;           
#line 75
static const int Auto_Letter_Box_Correction_D = 0;      
static const float LB_Depth_Size_Offset_X_D = 1.0;      
static const float LB_Depth_Size_Offset_Y_D = 1.0;      
static const float LB_Depth_Pos_Offset_X_D = 0.0;       
static const float LB_Depth_Pos_Offset_Y_D = 0.0;       
#line 82
static const int Auto_Letter_Box_Masking_D = 0;         
static const float LB_Masking_Offset_X_D = 1.0;         
static const float LB_Masking_Offset_Y_D = 1.0;         
static const float Weapon_Near_Depth_Trim_D = 0.25;     
static const float REF_Check_Depth_Limit_D = 0.0;       
#line 88
static const float NULL_X_D = 0.0;                      
static const float NULL_Y_D = 0.0;                      
static const float NULL_Z_D = 0.0;                      
static const float Check_Depth_Limit_Weapon_D = -0.100; 
#line 95
static const int Resident_Evil_Fix_D = 0;               
static const int HUD_Mode_Trigger_D = 0;                
static const int Inverted_Depth_Fix_D = 0;              
static const int Delay_Frame_Workaround_D = 0;          
#line 101
static const int No_Profile_Warning_D = 0;              
static const int Needs_Fix_Mod_D = 0;                   
static const int Depth_Selection_Warning_D = 0;         
static const int Disable_Anti_Aliasing_D = 0;           
static const int Network_Warning_D = 0;                 
static const int Disable_Post_Effects_Warning_D = 0;    
static const int Weapon_Profile_Warning_D = 0;          
static const int Set_Game_FoV_D = 0;                    
#line 111
static const int Read_Help_Warning_D = 0;               
static const int Emulator_Detected_Warning_D = 0;       
static const int Not_Compatible_Warning_D = 0;          
#line 3455
float4 Weapon_Profiles(float WP ,float4 Weapon_Adjust) 
{   if (WP == 2)
Weapon_Adjust = float4(0.425,5.0,1.125,0.0);      
if (WP == 3)
Weapon_Adjust = float4(0.276,16.25,9.15,0.0);      
if (WP == 4)
Weapon_Adjust = float4(0.5,32.5,7.15,0.0);        
if (WP == 5)
Weapon_Adjust = float4(0.284,10.5,0.8725,0.0);    
if (WP == 6)
Weapon_Adjust = float4(0.253,39.0,97.5,0.0);      
if (WP == 7)
Weapon_Adjust = float4(0.276,20.0,9.5625,0.0);    
if (WP == 8)
Weapon_Adjust = float4(0.338,21.0,9.1375,0.0);    
if (WP == 9)
Weapon_Adjust = float4(0.255,177.5,63.025,0.0);   
if (WP == 10)
Weapon_Adjust = float4(0.254,100.0,0.9843,0.0);   
if (WP == 11)
Weapon_Adjust = float4(0.254,203.125,0.98435,0.0);
if (WP == 12)
Weapon_Adjust = float4(0.254,203.125,0.98433,0.0);
if (WP == 13)
Weapon_Adjust = float4(0.254,125.0,0.9843,0.0);   
if (WP == 14)
Weapon_Adjust = float4(0.255,200.0,63.0,0.0);     
if (WP == 15)
Weapon_Adjust = float4(0.510,162.5,3.975,0.0);    
if (WP == 16)
Weapon_Adjust = float4(0.254,23.75,0.98425,0.0);  
if (WP == 17)
Weapon_Adjust = float4(0.375,60.0,15.15625,0.0);  
if (WP == 18)
Weapon_Adjust = float4(0.7,14.375,2.5,0.0);       
if (WP == 19)
Weapon_Adjust = float4(0.750,30.0,1.050,0.0);     
if (WP == 20)
Weapon_Adjust = float4(0.278,62.5,9.1,0.0);       
if (WP == 21)
Weapon_Adjust = float4(0.450,12.0,23.75,0.0);     
if (WP == 22)
Weapon_Adjust = float4(0.350,12.5,2.0,0.0);       
if (WP == 23)
Weapon_Adjust = float4(0.286,1500.0,7.0,0.0);     
if (WP == 24)
Weapon_Adjust = float4(35.0,250.0,0,0.0);         
if (WP == 25)
Weapon_Adjust = float4(0.625,350.0,0.785,0.0);    
if (WP == 26)
Weapon_Adjust = float4(0.255,6.375,53.75,0.0);    
if (WP == 27)
Weapon_Adjust = float4(0.450,5.5625,0.0,0.0);     
if (WP == 28)
Weapon_Adjust = float4(0.750,30.0,1.025,0.0);     
if (WP == 29)
Weapon_Adjust = float4(0.266,30.0,14.0,0.0);      
if (WP == 30)
Weapon_Adjust = float4(3.625,20.0,0,0.0);         
if (WP == 31)
Weapon_Adjust = float4(0.7,9.0,2.3625,0.0);       
if (WP == 32)
Weapon_Adjust = float4(0.4894,62.50,0.98875,0.0); 
if (WP == 33)
Weapon_Adjust = float4(1.0,93.75,0.81875,0.0);    
if (WP == 34)
Weapon_Adjust = float4(1.150,55.0,0.9,0.0);       
if (WP == 35)
Weapon_Adjust = float4(0.278,37.50,9.1,0.0);      
if (WP == 36)
Weapon_Adjust = float4(0.277,105.0,8.8625,0.0);   
if (WP == 37)
Weapon_Adjust = float4(0.0,0.0,0.0,0.0);          
if (WP == 38)
Weapon_Adjust = float4(0.78,20.0,0.180,0.0);      
if (WP == 39)
Weapon_Adjust = float4(0.444,20.0,1.1875,0.0);    
if (WP == 40)
Weapon_Adjust = float4(0.286,80.0,7.0,0.0);       
if (WP == 41)
Weapon_Adjust = float4(0.280,18.75,9.03,0.0);     
if (WP == 42)
Weapon_Adjust = float4(0.3,17.5,0.9015,0.0);      
if (WP == 43)
Weapon_Adjust = float4(1.2,12.5,0.3,0.0);         
if (WP == 44)
Weapon_Adjust = float4(0.277,20.0,8.8,0.0);       
if (WP == 45)
Weapon_Adjust = float4(1.300,17.50,0.0,0.0);      
if (WP == 46)
Weapon_Adjust = float4(0.625,9.0,2.375,0.0);      
if (WP == 47)
Weapon_Adjust = float4(0.28,20.0,9.0,0.0);        
if (WP == 48)
Weapon_Adjust = float4(0.460,12.5,1.0,0.0);       
if (WP == 49)
Weapon_Adjust = float4(1.5,37.5,0.99875,0.0);     
if (WP == 50)
Weapon_Adjust = float4(2.0,16.25,0.09,0.0);       
if (WP == 51)
Weapon_Adjust = float4(0.485,62.5,0.9625,0.0);    
if (WP == 52)
Weapon_Adjust = float4(0.489,68.75,1.02,0.0);     
if (WP == 53)
Weapon_Adjust = float4(1.0,237.5,0.83625,0.0);    
if (WP == 54)
Weapon_Adjust = float4(13.870,50.0,0.0,0.0);      
if (WP == 55)
Weapon_Adjust = float4(0.425,15.0,99.0,0.0);      
if (WP == 56)
Weapon_Adjust = float4(0.425,21.25,99.5,0.0);     
if (WP == 57)
Weapon_Adjust = float4(0.425,5.25,1.0,0.0);       
if (WP == 58)
Weapon_Adjust = float4(0.519,31.25,8.875,0.0);    
if (WP == 59)
Weapon_Adjust = float4(0.5,8.0,0,0.0);            
if (WP == 60)
Weapon_Adjust = float4(0.350,9.0,1.8,0.0);        
if (WP == 61) 
Weapon_Adjust = float4(1.825,13.75,0,0.0);        
if (WP == 62)
Weapon_Adjust = float4(1.953,5.25,0,0.0);         
if (WP == 63)
Weapon_Adjust = float4(0.287,180.0,9.0,0.0);      
if (WP == 64)
Weapon_Adjust = float4(0.2503,55.0,1000.0,0.0);   
if (WP == 65)
Weapon_Adjust = float4(0.279,100.0,0.905,0.0);    
if (WP == 66)
Weapon_Adjust = float4(0.2503,52.5,987.5,0.0);    
if (WP == 67)
Weapon_Adjust = float4(0.251,12.5,925.0,0.0);     
if (WP == 68)
Weapon_Adjust = float4(1.035,16.0,0.185,0.0);     
if (WP == 69)
Weapon_Adjust = float4(1.553,16.875,0.0,0.0);     
if (WP == 70)
Weapon_Adjust = float4(0.251,5.6875,950.0,0.0);   
if (WP == 71)
Weapon_Adjust = float4(0.345,10.125,1.825,0.0);   
if (WP == 72)
Weapon_Adjust = float4(0.430,6.250,0.100,0.0);    
if (WP == 73)
Weapon_Adjust = float4(0.800,15.0,0.3,0.0);       
if (WP == 74)
Weapon_Adjust = float4(13.3,62.5,0.0,0.0);        
if (WP == 75)
Weapon_Adjust = float4(0.75,112.5,0.5,0.0);       
if (WP == 76) 
Weapon_Adjust = float4(0.350,17.5,2.050,0.0);     
#line 3607
return Weapon_Adjust;
}
#line 36 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SuperDepth3D.fx"
#line 197
uniform float Divergence <
ui_type = "drag";
ui_min = 1.0; ui_max =  75.0; ui_step = 0.5;
ui_label = "·Divergence Slider·";
ui_tooltip = "Divergence increases differences between the left and right retinal images and allows you to experience depth.\n"
"The process of deriving binocular depth information is called stereopsis.";
ui_category = "Divergence & Convergence";
> =  37.5;
#line 206
uniform float2 ZPD_Separation <
ui_type = "drag";
ui_min = 0.0; ui_max = 0.250;
ui_label = " ZPD & Sepration";
ui_tooltip = "Zero Parallax Distance controls the focus distance for the screen Pop-out effect also known as Convergence.\n"
"Separation is a way to increase the intensity of Divergence without a performance cost.\n"
"For FPS Games keeps this low Since you don't want your gun to pop out of screen.\n"
"Default is 0.025, Zero is off.";
ui_category = "Divergence & Convergence";
> = float2( ZPD_D, Separation_D);
#line 229
uniform int Auto_Balance_Ex <
#line 233
ui_type = "slider";
#line 235
ui_min = 0; ui_max = 5;
ui_label = " Auto Balance";
ui_tooltip = "Automatically Balance between ZPD Depth and Scene Depth.\n"
"Default is Off.";
ui_category = "Divergence & Convergence";
> =  Auto_Balance_D;
#line 242
uniform int ZPD_Boundary <
ui_type = "combo";
ui_items = "BD0 Off\0BD1 Full\0BD2 Narrow\0BD3 Wide\0BD4 FPS Center\0BD5 FPS Right\0";
ui_label = " ZPD Boundary Detection";
ui_tooltip = "This selection menu gives extra boundary conditions to ZPD.\n"
"This treats your screen as a virtual wall.\n"
"Default is Off.";
ui_category = "Divergence & Convergence";
> =  ZPD_Boundary_Type_D;
#line 252
uniform float2 ZPD_Boundary_n_Fade <
#line 256
ui_type = "slider";
#line 258
ui_min = 0.0; ui_max = 0.5;
ui_label = " ZPD Boundary & Fade Time";
ui_tooltip = "This selection menu gives extra boundary conditions to scale ZPD & lets you adjust Fade time.";
ui_category = "Divergence & Convergence";
> = float2( ZPD_Boundary_Scaling_D, ZPD_Boundary_Fade_Time_D);
#line 264
uniform int View_Mode <
ui_type = "combo";
ui_items = "VM0 Normal \0VM1 Mixed \0VM2 Reiteration \0VM3 Stamped \0VM4 Adaptive \0";
ui_label = "·View Mode·";
ui_tooltip = "Changes the way the shader fills in the occlude sections in the image.\n"
"Normal      | Normal output used for most games with it's streched look.\n"
"Mixed       | Used for higher amounts of Semi-Transparent objects like foliage.\n"
"Reiteration | Same thing as Stamped but with brakeage points.\n"
"Stamped     | Stamps out a transparent area on the occluded area.\n"
"Adaptive    | is a scene adapting infilling that uses disruptive reiterative sampling.\n"
"\n"
"Warning: Also Make sure you turn on Performance Mode before you close this menu.\n"
"\n"
"Default is Normal.";
ui_category = "Occlusion Masking";
> = 0;
#line 281
uniform int Custom_Sidebars <
ui_type = "combo";
ui_items = "Mirrored Edges\0Black Edges\0Stretched Edges\0";
ui_label = " Edge Handling";
ui_tooltip = "Edges selection for your screen output.";
ui_category = "Occlusion Masking";
> = 1;
#line 289
uniform float Max_Depth <
#line 293
ui_type = "slider";
#line 295
ui_min = 0.5; ui_max = 1.0;
ui_label = " Max Depth";
ui_tooltip = "Max Depth lets you clamp the max depth range of your scene.\n"
"So it's not hard on your eyes looking off in to the distance .\n"
"Default and starts at One and it's Off.";
ui_category = "Occlusion Masking";
> = 1.0;
#line 303
uniform int Performance_Level <
ui_type = "combo";
ui_items = "Performant\0Normal\0";
ui_label = " Performance Mode";
ui_tooltip = "Performance Mode Lowers or Raises Occlusion Quality Processing so that there is a performance is adjustable.\n"
"Please enable the 'Performance Mode Checkbox,' in ReShade's GUI.\n"
"It's located in the lower bottom right of the ReShade's Main UI.\n"
"Default is Normal.";
ui_category = "Occlusion Masking";
> = 1;
#line 329
uniform float DLSS_FSR_Offset <
#line 333
ui_type = "slider";
#line 335
ui_min = 0.0; ui_max = 4.0;
ui_label = " Upscailer Offset";
ui_tooltip = "This Offset is for non conforming ZBuffer Postion witch is normaly 1 pixel wide.\n"
"This issue only happens sometimes when using things like DLSS or FSR.\n"
"This does not solve for TAA artifacts like Jittering or smearing.\n"
"Default and starts at Zero and it's Off. With a max offset of 4pixels Wide.";
ui_category = "Occlusion Masking";
> = 0;
#line 344
uniform int Depth_Map <
ui_type = "combo";
ui_items = "DM0 Normal\0DM1 Reversed\0";
ui_label = "·Depth Map Selection·";
ui_tooltip = "Linearization for the zBuffer also known as Depth Map.\n"
"DM0 is Z-Normal and DM1 is Z-Reversed.\n";
ui_category = "Depth Map";
> =  Depth_Linearization_D;
#line 353
uniform float Depth_Map_Adjust <
ui_type = "drag";
ui_min = 1.0; ui_max = 250.0; ui_step = 0.125;
ui_label = " Depth Map Adjustment";
ui_tooltip = "This allows for you to adjust the DM precision.\n"
"Adjust this to keep it as low as possible.\n"
"Default is 7.5";
ui_category = "Depth Map";
> =  Depth_Adjust_D;
#line 363
uniform float Offset <
ui_type = "drag";
ui_min = -1.0; ui_max = 1.0;
ui_label = " Depth Map Offset";
ui_tooltip = "Depth Map Offset is for non conforming ZBuffer.\n"
"It,s rare if you need to use this in any game.\n"
"Use this to make adjustments to DM 0 or DM 1.\n"
"Default and starts at Zero and it's Off.";
ui_category = "Depth Map";
> =  Offset_D;
#line 374
uniform float Auto_Depth_Adjust <
ui_type = "drag";
ui_min = 0.0; ui_max = 0.625;
ui_label = " Auto Depth Adjust";
ui_tooltip = "Automatically scales depth so it fights out of game menu pop out.\n"
"Default is 0.1f, Zero is off.";
ui_category = "Depth Map";
> =  Auto_Depth_D;
#line 383
uniform int Depth_Detection <
ui_type = "combo";
#line 386
ui_items = "Off\0Detection +Sky\0Detection -Sky\0ReShade's Detection\0";
#line 390
ui_label = " Depth Detection";
ui_tooltip = "Use this to disable/enable in game Depth Detection.";
ui_category = "Depth Map";
#line 394
> = 3;
#line 398
uniform int Depth_Map_View <
ui_type = "combo";
ui_items = "Off\0Stereo Depth View\0Normal Depth View\0";
ui_label = " Depth Map View";
ui_tooltip = "Display the Depth Map";
ui_category = "Depth Map";
> = 0;
#line 406
uniform bool Depth_Map_Flip <
ui_label = " Depth Map Flip";
ui_tooltip = "Flip the depth map if it is upside down.";
ui_category = "Depth Map";
> =  Depth_Flip_D;
#line 458
static const bool Alinement_View = false;
static const float2 Horizontal_and_Vertical = float2( HVS_X_D, HVS_Y_D);
static const float2 Image_Position_Adjust = float2( HVP_X_D, HVP_Y_D);
#line 462
static const bool LB_Correction_Switch = true;
static const float2 H_V_Offset = float2( LB_Depth_Size_Offset_X_D, LB_Depth_Size_Offset_Y_D);
static const float2 Image_Pos_Offset  = float2( LB_Depth_Pos_Offset_X_D, LB_Depth_Pos_Offset_Y_D);
#line 467
uniform int WP <
ui_type = "combo";
ui_items =  "WP Off\0Custom WP\0WP 0\0WP 1\0WP 2\0WP 3\0WP 4\0WP 5\0WP 6\0WP 7\0WP 8\0WP 9\0WP 10\0WP 11\0WP 12\0WP 13\0WP 14\0WP 15\0WP 16\0WP 17\0WP 18\0WP 19\0WP 20\0WP 21\0WP 22\0WP 23\0WP 24\0WP 25\0WP 26\0WP 27\0WP 28\0WP 29\0WP 30\0WP 31\0WP 32\0WP 33\0WP 34\0WP 35\0WP 36\0WP 37\0WP 38\0WP 39\0WP 40\0WP 41\0WP 42\0WP 43\0WP 44\0WP 45\0WP 46\0WP 47\0WP 48\0WP 49\0WP 50\0WP 51\0WP 52\0WP 53\0WP 54\0WP 55\0WP 56\0WP 57\0WP 58\0WP 59\0WP 60\0WP 61\0WP 62\0WP 63\0WP 64\0WP 65\0WP 66\0WP 67\0WP 68\0WP 69\0WP 70\0WP 71\0WP 72\0WP 73\0WP 74\0";
ui_label = "·Weapon Profiles·";
ui_tooltip = "Pick Weapon Profile for your game or make your own.";
ui_category = "Weapon Hand Adjust";
> =  Weapon_Hand_D;
#line 475
uniform float4 Weapon_Adjust <
ui_type = "drag";
ui_min = 0.0; ui_max = 250.0;
ui_label = " Weapon Hand Adjust";
ui_tooltip = "Adjust Weapon depth map for your games.\n"
"X, CutOff Point used to set a different scale for first person hand apart from world scale.\n"
"Y, Precision is used to adjust the first person hand in world scale.\n"
"Z, Tuning is used to fine tune the precision adjustment above.\n"
"W, Scale is used to compress or rescale the weapon.\n"
"Default is float2(X 0.0, Y 0.0, Z 0.0, W 1.0)";
ui_category = "Weapon Hand Adjust";
> = float4(0.0,0.0,0.0,0.0);
#line 488
uniform float3 WZPD_and_WND <
ui_type = "drag";
ui_min = 0.0; ui_max = 0.5;
ui_label = " Weapon ZPD, Min, and Max";
ui_tooltip = "WZPD controls the focus distance for the screen Pop-out effect also known as Convergence for the weapon hand.\n"
"Weapon ZPD Is for setting a Weapon Profile Convergence, so you should most of the time leave this Default.\n"
"Weapon Min is used to adjust min weapon hand of the weapon hand when looking at the world near you.\n"
"Weapon Max is used to adjust max weapon hand when looking out at a distance.\n"
"Default is (ZPD X 0.03, Min Y 0.0, Max Z 0.0) & Zero is off.";
ui_category = "Weapon Hand Adjust";
> = float3(0.03, Weapon_Near_Depth_Min_D         , Weapon_Near_Depth_Max_D          );
#line 500
uniform int FPSDFIO <
ui_type = "combo";
ui_items = "Off\0Press\0Hold\0";
ui_label = " FPS Focus Depth";
ui_tooltip = "This lets the shader handle real time depth reduction for aiming down your sights.\n"
"This may induce Eye Strain so take this as an Warning.";
ui_category = "Weapon Hand Adjust";
> = 0;
#line 509
uniform int3 Eye_Fade_Reduction_n_Power <
#line 513
ui_type = "slider";
#line 515
ui_min = 0; ui_max = 2;
ui_label = " Eye Fade Options";
ui_tooltip ="X, Eye Selection: One is Right Eye only, Two is Left Eye Only, and Zero Both Eyes.\n"
"Y, Fade Reduction: Decreases the depth amount by a current percentage.\n"
"Z, Fade Speed: Decreases or Incresses how fast it changes.\n"
"Default is X[ 0 ] Y[ 0 ] Z[ 1 ].";
ui_category = "Weapon Hand Adjust";
> = int3(0,0,0);
#line 524
uniform float Weapon_ZPD_Boundary <
ui_type = "slider";
ui_min = 0.0; ui_max = 0.5;
ui_label = " Weapon Boundary Detection";
ui_tooltip = "This selection menu gives extra boundary conditions to WZPD.";
ui_category = "Weapon Hand Adjust";
> =  ZPD_Weapon_Boundary_Adjust_D;
#line 546
uniform int Stereoscopic_Mode <
ui_type = "combo";
ui_items = "Side by Side\0Top and Bottom\0Line Interlaced\0Column Interlaced\0Checkerboard 3D\0Autostereoscopic\0Quad Lightfield 2x2\0Anaglyph 3D Red/Cyan\0Anaglyph 3D Red/Cyan Dubois\0Anaglyph 3D Red/Cyan Anachrome\0Anaglyph 3D Green/Magenta\0Anaglyph 3D Green/Magenta Dubois\0Anaglyph 3D Green/Magenta Triochrome\0Anaglyph 3D Blue/Amber ColorCode\0";
ui_label = "·3D Display Modes·";
ui_tooltip = "Stereoscopic 3D display output selection.";
ui_category = "Stereoscopic Options";
> = 0;
#line 554
uniform float3 Interlace_Anaglyph_Calibrate <
ui_type = "drag";
ui_min = 0.0; ui_max = 1.0;
ui_label = " Interlace, Anaglyph & Calibration";
ui_tooltip = "Interlace Optimization is used to reduce aliasing in a Line or Column interlaced image. This has the side effect of softening the image.\n"
"Anaglyph Desaturation allows for removing color from an anaglyph 3D image. Zero is Black & White, One is full color.\n"
"Tobii Calibration for adjusting the Eye Tracking offset with Tobii, FreePie app, and Script.\n"
"Default for Interlace Optimization is 0.5 and for Anaglyph Desaturation is One.";
ui_category = "Stereoscopic Options";
> = float3(0.5,1.0,0.5);
#line 575
static const float Lens_Angle =  12.5625 ;
#line 578
uniform int Scaling_Support <
ui_type = "combo";
ui_items = "SR Native\0SR 2160p A\0SR 2160p B\0SR 1080p A\0SR 1080p B\0SR 1050p A\0SR 1050p B\0SR 720p A\0SR 720p B\0";
ui_label = " Downscaling Support";
ui_tooltip = "Dynamic Super Resolution scaling support for Line Interlaced, Column Interlaced, & Checkerboard 3D displays.\n"
"Set this to your native Screen Resolution A or B, DSR Smoothing must be set to 0%.\n"
"This does not work with a hardware ware scaling done by VSR.\n"
"Default is SR Native.";
ui_category = "Stereoscopic Options";
> = 0;
#line 591
uniform int Perspective <
ui_type = "drag";
ui_min = -100; ui_max = 100;
ui_label = " Perspective Slider";
ui_tooltip = "Determines the perspective point of the two images this shader produces.\n"
"For an HMD, use Polynomial Barrel Distortion shader to adjust for IPD.\n"
"Do not use this perspective adjustment slider to adjust for IPD.\n"
"Default is Zero.";
ui_category = "Stereoscopic Options";
> = 0;
#line 602
uniform bool Eye_Swap <
ui_label = " Swap Eyes";
ui_tooltip = "L/R to R/L.";
ui_category = "Stereoscopic Options";
> = false;
#line 608
uniform int Cursor_Type <
ui_type = "combo";
ui_items = "Off\0FPS\0ALL\0RTS\0";
ui_label = "·Cursor Selection·";
ui_tooltip = "Choose the cursor type you like to use.\n"
"Default is Zero.";
ui_category = "Cursor Adjustments";
> = 0;
#line 617
uniform int2 Cursor_SC <
ui_type = "drag";
ui_min = 0; ui_max = 10;
ui_label = " Cursor Adjustments";
ui_tooltip = "This controlls the Size & Color.\n"
"Defaults are ( X 1, Y 2 ).";
ui_category = "Cursor Adjustments";
> = int2(1,0);
#line 626
uniform bool Cursor_Lock <
ui_label = " Cursor Lock";
ui_tooltip = "Screen Cursor to Screen Crosshair Lock.";
ui_category = "Cursor Adjustments";
> = false;
#line 669
static const int BD_Options = 1;
#line 671
static const float3 Colors_K1_K2_K3 = float3( BD_K1_D, BD_K2_D, BD_K3_D);
static const float Zoom =  BD_Zoom_D;
#line 675
uniform bool Cancel_Depth < source = "key"; keycode =  0 ; toggle = true; mode = "toggle";>;
uniform bool Mask_Cycle < source = "key"; keycode =   0 ; toggle = true; mode = "toggle";>;
uniform bool Text_Info < source = "key"; keycode =  93; toggle = true; mode = "toggle";>;
uniform bool CLK < source = "mousebutton"; keycode =  4 ; toggle = true; mode = "toggle";>;
uniform bool Trigger_Fade_A < source = "mousebutton"; keycode =  1 ; toggle = true; mode = "toggle";>;
uniform bool Trigger_Fade_B < source = "mousebutton"; keycode =  1 ;>;
uniform float2 Mousecoords < source = "mousepoint"; > ;
uniform float frametime < source = "frametime";>;
uniform float timer < source = "timer"; >;
#line 685
uniform float3 motion[2] < source = "freepie"; index = 0; >;
#line 688
float3 FP_IO_Pos()
{
#line 694
return motion[1];
#line 696
}
#line 703
static const float Auto_Balance_Clamp = 0.5; 
#line 706
uniform bool DepthCheck < source = "bufready_depth"; >;
#line 713
float fmod(float a, float b)
{
float c = frac(abs(a / b)) * abs(b);
return a < 0 ? -c : c;
}
#line 719
float3 RGBtoYCbCr(float3 rgb) 
{   float TCoRF[1];
float Y  =  .299 * rgb.x + .587 * rgb.y + .114 * rgb.z; 
float Cb = -.169 * rgb.x - .331 * rgb.y + .500 * rgb.z; 
float Cr =  .500 * rgb.x - .419 * rgb.y - .081 * rgb.z; 
return float3(Y,Cb + 128./255.,Cr + 128./255.);
}
#line 727
texture DepthBufferTex : DEPTH;
sampler DepthBuffer
{
Texture = DepthBufferTex;
AddressU = BORDER;
AddressV = BORDER;
AddressW = BORDER;
#line 735
MagFilter = POINT;
MinFilter = POINT;
MipFilter = POINT;
};
#line 740
texture BackBufferTex : COLOR;
sampler BackBufferMIRROR
{
Texture = BackBufferTex;
AddressU = MIRROR;
AddressV = MIRROR;
AddressW = MIRROR;
};
#line 749
sampler BackBufferBORDER
{
Texture = BackBufferTex;
AddressU = BORDER;
AddressV = BORDER;
AddressW = BORDER;
};
#line 757
sampler BackBufferCLAMP
{
Texture = BackBufferTex;
AddressU = CLAMP;
AddressV = CLAMP;
AddressW = CLAMP;
};
#line 780
texture texDMN { Width = 5360 ; Height = 1440; Format = RGBA16F; };
#line 782
sampler SamplerDMN
{
Texture = texDMN;
};
#line 787
texture texzBufferN_P { Width = 5360 ; Height = 1440 ; Format = RG16F; };
#line 789
sampler SamplerzBufferN_P
{
Texture = texzBufferN_P;
MagFilter = POINT;
MinFilter = POINT;
MipFilter = POINT;
};
#line 797
texture texzBufferN_L { Width = 5360 ; Height = 1440 ; Format = R16F; MipLevels = 2; };
#line 799
sampler SamplerzBufferN_L
{
Texture = texzBufferN_L;
};
#line 813
texture texLumN {Width = 5360 *  160 / 5360; Height = 1440 *  160 / 5360; Format = RGBA16F; MipLevels = 8;};
#line 815
sampler SamplerLumN
{
Texture = texLumN;
};
#line 820
float2 Lum(float2 texcoord)
{
return saturate(tex2Dlod(SamplerLumN,float4(texcoord,0,11)).xy);
}
#line 872
float4 CSB(float2 texcoords)
{
if(Custom_Sidebars == 0 && Depth_Map_View == 0)
return tex2Dlod(BackBufferMIRROR,float4(texcoords,0,0));
else if(Custom_Sidebars == 1 && Depth_Map_View == 0)
return tex2Dlod(BackBufferBORDER,float4(texcoords,0,0));
else if(Custom_Sidebars == 2 && Depth_Map_View == 0)
return tex2Dlod(BackBufferCLAMP,float4(texcoords,0,0));
else
return tex2Dlod(SamplerzBufferN_P,float4(texcoords,0,0)).x;
}
#line 912
float4 MouseCursor(float2 texcoord )
{   float4 Out = CSB(texcoord),Color;
float A = 0.959375, TCoRF = 1-A, Cursor;
if(Cursor_Type > 0)
{
float CCA = 0.005, CCB = 0.00025, CCC = 0.25, CCD = 0.00125, Arrow_Size_A = 0.7, Arrow_Size_B = 1.3, Arrow_Size_C = 4.0;
float2 MousecoordsXY = Mousecoords *  float2((1.0 / 5360), (1.0 / 1440)), center = texcoord, Screen_Ratio = float2(1.75,1.0), Size_Color = float2(1+Cursor_SC.x,Cursor_SC.y);
float THICC = (2.0+Size_Color.x) * CCB, Size = Size_Color.x * CCA, Size_Cubed = (Size_Color.x*Size_Color.x) * CCD;
#line 921
if (Cursor_Lock && !CLK)
MousecoordsXY = float2(0.5,0.5);
if (Cursor_Type == 3)
Screen_Ratio = float2(1.6,1.0);
#line 926
float4 Dist_from_Hori_Vert = float4( abs((center.x - (Size* Arrow_Size_B) / Screen_Ratio.x) - MousecoordsXY.x) * Screen_Ratio.x, 
abs(center.x - MousecoordsXY.x) * Screen_Ratio.x, 										  
abs((center.y - (Size* Arrow_Size_B)) - MousecoordsXY.y),								   
abs(center.y - MousecoordsXY.y));														   
#line 932
float B = min(max(THICC - Dist_from_Hori_Vert.y,0),max(Size-Dist_from_Hori_Vert.w,0)), A = min(max(THICC - Dist_from_Hori_Vert.w,0),max(Size-Dist_from_Hori_Vert.y,0));
float CC = A+B; 
#line 936
float SSC = min(max(Size_Cubed - Dist_from_Hori_Vert.y,0),max(Size_Cubed-Dist_from_Hori_Vert.w,0)); 
#line 938
if (Cursor_Type == 3)
{
Dist_from_Hori_Vert.y = abs((center.x - Size / Screen_Ratio.x) - MousecoordsXY.x) * Screen_Ratio.x ;
Dist_from_Hori_Vert.w = abs(center.y - Size - MousecoordsXY.y);
}
#line 944
float C = all(min(max(Size - Dist_from_Hori_Vert.y,0),max(Size - Dist_from_Hori_Vert.w,0)));
C -= all(min(max(Size - Dist_from_Hori_Vert.y * Arrow_Size_C,0),max(Size - Dist_from_Hori_Vert.w * Arrow_Size_C,0)));
C -= all(min(max((Size * Arrow_Size_A) - Dist_from_Hori_Vert.x,0),max((Size * Arrow_Size_A)-Dist_from_Hori_Vert.z,0)));			
if(Cursor_Type == 1)
Cursor = CC;
else if (Cursor_Type == 2)
Cursor = SSC;
else if (Cursor_Type == 3)
Cursor = C;
#line 955
float3 CCArray[11] = {
float3(1,1,1),
float3(0,0,1),
float3(0,1,0),
float3(1,0,0),
float3(1,0,1),
float3(0,1,1),
float3(1,1,0),
float3(1,0.4,0.7),
float3(1,0.64,0),
float3(0.5,0,0.5),
float3(0,0,0) 
};
int CSTT = clamp(Cursor_SC.y,0,10);
Color.rgb = CCArray[CSTT];
}
#line 972
return Cursor ? Color : Out;
}
#line 975
float DMA() 
{ float DMA = Depth_Map_Adjust;
#line 983
return DMA;
}
#line 986
float2 TC_SP(float2 texcoord)
{
#line 1017
return texcoord;
}
#line 1020
float Depth(float2 texcoord)
{	
float zBuffer = tex2Dlod(DepthBuffer, float4(texcoord,0,0)).x, Far = 1.0, Near = 0.125/DMA(); 
#line 1024
float2 C = float2( Far / Near, 1.0 - Far / Near ), Z = Offset < 0 ? min( 1.0, zBuffer * ( 1.0 + abs(Offset) ) ) : float2( zBuffer, 1.0 - zBuffer );
#line 1026
if(Offset > 0 || Offset < 0)
Z = Offset < 0 ? float2( Z.x, 1.0 - Z.y ) : min( 1.0, float2( Z.x * (1.0 + Offset) , Z.y / (1.0 - Offset) ) );
#line 1029
if (Depth_Map == 0) 
zBuffer = rcp(Z.x * C.y + C.x);
else if (Depth_Map == 1) 
zBuffer = rcp(Z.y * C.y + C.x);
return saturate(zBuffer);
}
#line 1036
float4 WA_XYZW()
{
float4 WeaponSettings_XYZW = Weapon_Adjust;
#line 1040
WeaponSettings_XYZW = Weapon_Profiles(WP, Weapon_Adjust);
#line 1046
return float4(WeaponSettings_XYZW.xyz,-WeaponSettings_XYZW.w + 1);
}
#line 1049
float2 WeaponDepth(float2 texcoord)
{   
float zBufferWH = tex2Dlod(DepthBuffer, float4(texcoord,0,0)).x, Far = 1.0, Near = 0.125/(0.00000001 + WA_XYZW().y);  
#line 1053
float2 Offsets = float2(1 + WA_XYZW().z,1 - WA_XYZW().z), Z = float2( zBufferWH, 1-zBufferWH );
#line 1055
if (WA_XYZW().z > 0)
Z = min( 1, float2( Z.x * Offsets.x , Z.y / Offsets.y  ));
#line 1058
[branch] if (Depth_Map == 0)
zBufferWH = Far * Near / (Far + Z.x * (Near - Far));
else if (Depth_Map == 1)
zBufferWH = Far * Near / (Far + Z.y * (Near - Far));
#line 1063
return float2(saturate(zBufferWH), WA_XYZW().x);
}
#line 1066
float3x3 PrepDepth(float2 texcoord)
{   int Flip_Depth =  0 ? !Depth_Map_Flip : Depth_Map_Flip;
#line 1069
if (Flip_Depth)
texcoord.y =  1 - texcoord.y;
#line 1080
texcoord.xy -= DLSS_FSR_Offset.x *  float2((1.0 / 5360), (1.0 / 1440));
#line 1082
float4 DM = Depth(TC_SP(texcoord)).xxxx;
float R, G, B, A, WD = WeaponDepth(TC_SP(texcoord)).x, CoP = WeaponDepth(TC_SP(texcoord)).y, CutOFFCal = (CoP/DMA()) * 0.5; 
CutOFFCal = step(DM.x,CutOFFCal);
#line 1086
[branch] if (WP == 0)
DM.x = DM.x;
else
{
DM.x = lerp(DM.x,WD,CutOFFCal);
DM.y = lerp(0.0,WD,CutOFFCal);
DM.z = lerp(0.5,WD,CutOFFCal);
}
#line 1095
R = DM.x; 
G = DM.y > saturate(smoothstep(0,2.5,DM.w)); 
B = DM.z; 
A = ZPD_Boundary >= 4 ? max( G, R) : R; 
#line 1100
return float3x3( saturate(float3(R, G, B)) , saturate(float3(A,Depth(  Specialized_Depth_Trigger_D     ||  0  ? texcoord : TC_SP(texcoord) ).x,DM.w)) , float3(0,0,0) );
}
#line 1115
float Fade_in_out(float2 texcoord)
{ float TCoRF[1], Trigger_Fade, AA =  0.5625 , PStoredfade = tex2D(SamplerLumN,float2(0,0.083)).z;
if(Eye_Fade_Reduction_n_Power.z == 0)
AA *= 0.5;
else if(Eye_Fade_Reduction_n_Power.z == 2)
AA *= 1.5;
#line 1122
if(FPSDFIO == 1 )
Trigger_Fade = Trigger_Fade_A;
else if(FPSDFIO == 2)
Trigger_Fade = Trigger_Fade_B;
#line 1127
return PStoredfade + (Trigger_Fade - PStoredfade) * (1.0 - exp(-frametime/((1-AA)*1000))); 
}
#line 1130
float2 Fade(float2 texcoord) 
{   
float CD, Detect, Detect_Out_of_Range;
if(ZPD_Boundary > 0)
{   
float CDArray_A[7] = { 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875}, CDArray_B[7] = { 0.25, 0.375, 0.4375, 0.5, 0.5625, 0.625, 0.75}, CDArray_C[4] = { 0.875, 0.75, 0.5, 0.25};
float CDArrayZPD_A[7] = { ZPD_Separation.x * 0.625, ZPD_Separation.x * 0.75, ZPD_Separation.x * 0.875, ZPD_Separation.x, ZPD_Separation.x * 0.875, ZPD_Separation.x * 0.75, ZPD_Separation.x * 0.625 },
CDArrayZPD_B[7] = { ZPD_Separation.x * 0.3, ZPD_Separation.x * 0.5, ZPD_Separation.x * 0.75, ZPD_Separation.x, ZPD_Separation.x * 0.75, ZPD_Separation.x * 0.5, ZPD_Separation.x * 0.3},
CDArrayZPD_C[12] = { ZPD_Separation.x * 0.5, ZPD_Separation.x * 0.625, ZPD_Separation.x * 0.75, ZPD_Separation.x * 0.875, ZPD_Separation.x * 0.9375,
ZPD_Separation.x, ZPD_Separation.x,
ZPD_Separation.x * 0.9375, ZPD_Separation.x * 0.875, ZPD_Separation.x * 0.75, ZPD_Separation.x * 0.625, ZPD_Separation.x * 0.5 };
#line 1142
float2 GridXY; int2 iXY = ZPD_Boundary == 3 ? int2( 12, 4) : int2( 7, 7) ;
[loop]
for( int iX = 0 ; iX < iXY.x; iX++ )
{   [loop]
for( int iY = 0 ; iY < iXY.y; iY++ )
{
if(ZPD_Boundary == 1)
GridXY = float2( CDArray_A[iX], CDArray_A[iY]);
else if(ZPD_Boundary == 2 || ZPD_Boundary == 5)
GridXY = float2( CDArray_B[iX], CDArray_A[iY]);
else if(ZPD_Boundary == 3)
GridXY = float2( (iX + 1) * rcp(iXY.x + 2),CDArray_C[min(3,iY)]);
else if(ZPD_Boundary == 4)
GridXY = float2( CDArray_A[iX], CDArray_B[iY]);
#line 1157
float ZPD_I = ZPD_Boundary == 3 ?  CDArrayZPD_C[iX] : (ZPD_Boundary == 2 || ZPD_Boundary == 5  ? CDArrayZPD_B[iX] : CDArrayZPD_A[iX]);
#line 1159
if(ZPD_Boundary >= 4)
{
if ( PrepDepth(GridXY)[1][0] == 1 )
ZPD_I = 0;
}
#line 1165
CD = 1 - ZPD_I / PrepDepth(GridXY)[1][0];
#line 1170
if ( CD < - Check_Depth_Limit_D )
Detect = 1;
#line 1173
if( Resident_Evil_Fix_D             ||  0 )
{
if ( CD < - REF_Check_Depth_Limit_D )
Detect_Out_of_Range = 1;
}
}
}
}
float Trigger_Fade_A = Detect, Trigger_Fade_B = Detect_Out_of_Range, AA = (1-(ZPD_Boundary_n_Fade.y*2.))*1000,
PStoredfade_A = tex2D(SamplerLumN,float2(0, 0.250)).z, PStoredfade_B = tex2D(SamplerLumN,float2(0, 0.416)).z;
#line 1184
return float2( PStoredfade_A + (Trigger_Fade_A - PStoredfade_A) * (1.0 - exp(-frametime/AA)), PStoredfade_B + (Trigger_Fade_B - PStoredfade_B) * (1.0 - exp(-frametime/AA)) ); 
}
#line 1187
float AltWeapon_Fade()
{
float  ExAd = (1-( 0.25 * 2.0))*1000, Current =  min(0.75f,smoothstep(0,0.25f,PrepDepth(0.5f)[0][0])), Past = tex2D(SamplerLumN,float2(0,0.750)).z;
return Past + (Current - Past) * (1.0 - exp(-frametime/ExAd));
}
#line 1193
float Weapon_ZPD_Fade(float Weapon_Con)
{
float  ExAd = (1-( 0.25 * 2.0))*1000, Current =  Weapon_Con, Past = tex2D(SamplerLumN,float2(0,0.916)).z;
return Past + (Current - Past) * (1.0 - exp(-frametime/ExAd));
}
#line 1199
float4 DepthMap(in float4 position : SV_Position,in float2 texcoord : TEXCOORD) : SV_Target
{
float4 DM = float4(PrepDepth(texcoord)[0][0],PrepDepth(texcoord)[0][1],PrepDepth(texcoord)[0][2],PrepDepth(texcoord)[1][1]);
float R = DM.x, G = DM.y, B = DM.z, Auto_Scale =  WZPD_and_WND.y > 0.0 ? tex2D(SamplerLumN,float2(0,0.750)).z : 1;
#line 1205
float ScaleND = saturate(lerp(R,1.0f,smoothstep(min(-WZPD_and_WND.y,-WZPD_and_WND.z * Auto_Scale),1.0f,R)));
#line 1207
if (WZPD_and_WND.y > 0)
R = saturate(lerp(ScaleND,R,smoothstep(0, Weapon_Near_Depth_Trim_D       ,ScaleND)));
#line 1210
if(texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
R = Fade_in_out(texcoord);
if(1-texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
R = Fade(texcoord).x;
if(texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
R = Fade(texcoord).y;
#line 1217
float3 Color = tex2D(BackBufferCLAMP,texcoord ).rgb;
Color.x = max(Color.r, max(Color.g, Color.b));
#line 1220
return saturate(float4(R,G,B,Color.x));
}
#line 1223
float AutoDepthRange(float d, float2 texcoord )
{ float LumAdjust_ADR = smoothstep(-0.0175,Auto_Depth_Adjust,Lum(texcoord).y);
return min(1,( d - 0 ) / ( LumAdjust_ADR - 0));
}
#line 1228
float3 Conv(float2 MD_WHD,float2 texcoord)
{	float D = MD_WHD.x, Z = ZPD_Separation.x, WZP = 0.5, ZP = 0.5, ALC = abs(Lum(texcoord).x), W_Convergence = WZPD_and_WND.x, WZPDB, Distance_From_Bottom = 0.9375, ZPD_Boundary = ZPD_Boundary_n_Fade.x, Store_WC;
#line 1231
if (abs(Weapon_ZPD_Boundary) > 0)
{   float WArray[8] = { 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375},
MWArray[8] = { 0.4375, 0.46875, 0.5, 0.53125, 0.625, 0.75, 0.875, 0.9375},
WZDPArray[8] = { 1.0, 0.5, 0.75, 0.5, 0.625, 0.5, 0.55, 0.5};
[unroll] 
for( int i = 0 ; i < 8; i++ )
{
if((WP == 22 || WP == 4) &&  1  == 1)
WZPDB = 1 - (WZPD_and_WND.x * WZDPArray[i]) / tex2Dlod(SamplerDMN,float4(float2(WArray[i],0.9375),0,0)).z;
else
{
if (Weapon_ZPD_Boundary < 0) 
WZPDB = 1 - WZPD_and_WND.x / tex2Dlod(SamplerDMN,float4(float2(MWArray[i],Distance_From_Bottom),0,0)).z;
else 
WZPDB = 1 - WZPD_and_WND.x / tex2Dlod(SamplerDMN,float4(float2(WArray[i],Distance_From_Bottom),0,0)).z;
}
#line 1248
if (WZPDB < - Check_Depth_Limit_Weapon_D) 
W_Convergence *= 1.0-abs(Weapon_ZPD_Boundary);
}
}
#line 1253
Store_WC = W_Convergence;
#line 1255
W_Convergence = 1 - tex2D(SamplerLumN,float2(0,0.916)).z / MD_WHD.y;
float WD = MD_WHD.y; 
#line 1258
if (Auto_Depth_Adjust > 0)
D = AutoDepthRange(D,texcoord);
#line 1264
if(Auto_Balance_Ex > 0 )
ZP = saturate(ALC);
#line 1267
float DOoR = smoothstep(0,1,tex2D(SamplerLumN,float2(0, 0.416)).z), ZDP_Array[16] = { 0.0, 0.0125, 0.025, 0.0375, 0.04375, 0.05, 0.0625, 0.075, 0.0875, 0.09375, 0.1, 0.125, 0.150, 0.175, 0.20, 0.225};
#line 1269
if( Resident_Evil_Fix_D             ||  0 )
{
if( 0 )
ZPD_Boundary = lerp(ZPD_Boundary,ZDP_Array[ 0 ],DOoR);
else
ZPD_Boundary = lerp(ZPD_Boundary,ZDP_Array[ Resident_Evil_Fix_D            ],DOoR);
}
#line 1277
Z *= lerp( 1, ZPD_Boundary, smoothstep(0,1,tex2D(SamplerLumN,float2(0, 0.250)).z));
float Convergence = 1 - Z / D;
if (ZPD_Separation.x == 0)
ZP = 1;
#line 1282
if (WZPD_and_WND.x <= 0)
WZP = 1;
#line 1285
if (ALC <= 0.025)
WZP = 1;
#line 1288
ZP = min(ZP,Auto_Balance_Clamp);
#line 1290
float Separation = lerp(1.0,5.0,ZPD_Separation.y);
return float3( lerp(Separation * Convergence,min(saturate(Max_Depth),D), ZP), lerp(W_Convergence,WD,WZP), Store_WC);
}
#line 1294
float3 DB( float2 texcoord)
{
#line 1297
float4 DM = float4(tex2Dlod(SamplerDMN,float4(texcoord,0,0)).xyz,PrepDepth(texcoord)[1][1]);
#line 1299
if(texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
DM = PrepDepth(texcoord)[0][0];
if(1-texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
DM = PrepDepth(texcoord)[0][0];
if(texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
DM = PrepDepth(texcoord)[0][0];
#line 1306
if (WP == 0 || WZPD_and_WND.x <= 0)
DM.y = 0;
#line 1309
float3 HandleConvergence = Conv(DM.xz,texcoord).xyz;
DM.y = lerp( HandleConvergence.x, HandleConvergence.y * WA_XYZW().w, DM.y);
#line 1312
DM.z = DM.y;
DM.y += lerp(DM.y,DM.x,DM.w);
DM.y *= 0.5f;
DM.y = lerp(DM.y,DM.z,0.9375f);
#line 1317
if (Depth_Detection == 1 || Depth_Detection == 2)
{ 
float2 DA_DB = float2(tex2Dlod(SamplerDMN,float4(float2(0.5,0.0),0,0)).x, tex2Dlod(SamplerDMN,float4(float2(0.0,1.0),0,0)).x);
if(Depth_Detection == 2)
{
if (DA_DB.x == DA_DB.y)
DM = 0.0625;
}
else
{   
if (DA_DB.x != 1 && DA_DB.y != 1)
{
if (DA_DB.x == DA_DB.y)
DM = 0.0625;
}
}
}
else if (Depth_Detection == 3)
{
if (!DepthCheck)
DM = 0.0625;
}
#line 1359
if (Cancel_Depth)
DM = 0.0625;
#line 1370
if( Auto_Letter_Box_Masking_D       ||  0 )
{
float storeDM = DM.y;
#line 1374
DM.y = texcoord.y >  LB_Masking_Offset_Y_D && texcoord.y <  LB_Masking_Offset_X_D ? storeDM : 0.0125;
#line 1380
}
#line 1382
return float3(DM.y,DM.w,HandleConvergence.z);
}
#line 1386
void zBuffer(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float2 Point_Out : SV_Target0 , out float Linear_Out : SV_Target1)
{
float3 Set_Depth = DB( texcoord.xy ).xyz;
#line 1390
if(1-texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2) 
Set_Depth.y = AltWeapon_Fade();
if(  texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2) 
Set_Depth.y = Weapon_ZPD_Fade(Set_Depth.z);
#line 1395
Point_Out = Set_Depth.xy;
Linear_Out = Set_Depth.x;
}
#line 1399
float2 GetDB(float2 texcoord)
{
float2 DepthBuffer_LP = float2(tex2Dlod(SamplerzBufferN_L, float4(texcoord,0, 0) ).x,tex2Dlod(SamplerzBufferN_P, float4(texcoord,0, 0) ).x);
#line 1403
if(View_Mode == 0 || View_Mode == 3)
DepthBuffer_LP.x = DepthBuffer_LP.y;
#line 1406
return DepthBuffer_LP.xy;
}
#line 1421
static const float4 Performance_LvL[2] = { float4( 0.5, 0.5095, 0.679, 0.5 ), float4( 1.0, 1.019, 1.425, 1.0) };
#line 1423
float2 Parallax(float Diverge, float2 Coordinates, float IO) 
{   float MS = Diverge *  float2((1.0 / 5360), (1.0 / 1440)).x, GetDepth = smoothstep(0,1,tex2Dlod(SamplerzBufferN_P, float4(Coordinates,0, 0) ).y),
Details = 0.5,
Perf = Performance_LvL[Performance_Level].x;
float2 ParallaxCoord = Coordinates, CBxy = floor( float2(Coordinates.x * 5360, Coordinates.y * 1440));
#line 1429
if( View_Mode == 1)
Perf = fmod(CBxy.x*CBxy.y,2) ? Performance_LvL[Performance_Level].z : fmod(CBxy.x+CBxy.y,2) ? 1.020f : 1.025f;
if( View_Mode == 2)
Perf = Performance_LvL[Performance_Level].z;
if( View_Mode == 3)
Perf = Performance_LvL[Performance_Level].x;
if( View_Mode == 4)
{
if( GetDepth >= 0.999 )
Perf = fmod(CBxy.x+CBxy.y,2) ? 0.5 : 1.025;
else if( GetDepth >= 0.875)
Perf = fmod(CBxy.x+CBxy.y,2) ? 1.02 : 0.5;
else
Perf = fmod(CBxy.x+CBxy.y,2) ? 0.5 : 1.025;
}
#line 1446
float D = abs(Diverge), Cal_Steps = D * Perf, Steps = clamp( Cal_Steps, Performance_Level ? 20 : lerp(20,D,saturate(GetDepth > 0.998) ), 200 );
#line 1448
float LayerDepth = rcp(Steps), TP = View_Mode > 0 ? 0.05 : 0.025;
D = Diverge < 0 ? -75 : 75;
#line 1452
float deltaCoordinates = MS * LayerDepth, CurrentDepthMapValue = GetDB(ParallaxCoord).x, CurrentLayerDepth = 0.0f,
Offset_Switch = View_Mode > 0 ? 0.0 : 1.0, DB_Offset = D * TP *  float2((1.0 / 5360), (1.0 / 1440)).x;
#line 1455
[loop] 
while ( CurrentDepthMapValue > CurrentLayerDepth )
{   
ParallaxCoord.x -= deltaCoordinates;
#line 1460
CurrentDepthMapValue = GetDB(float2(ParallaxCoord.x - (DB_Offset * 2 * Offset_Switch),ParallaxCoord.y) ).x;
#line 1462
CurrentLayerDepth += LayerDepth;
continue;
}
#line 1466
float2 PrevParallaxCoord = float2(ParallaxCoord.x + deltaCoordinates, ParallaxCoord.y);
#line 1468
float Weapon_Mask = tex2Dlod(SamplerDMN,float4(Coordinates,0,0)).y, ZFighting_Mask = 1.0-(1.0-tex2Dlod(SamplerLumN,float4(Coordinates,0,1.400)).w - Weapon_Mask);
ZFighting_Mask = ZFighting_Mask * (1.0-Weapon_Mask);
float PCoord = (View_Mode > 0 ? ParallaxCoord.x : lerp(ParallaxCoord.x, lerp(ParallaxCoord.x,PrevParallaxCoord.x,0.5), saturate(GetDepth * 5.0)));
float Get_DB = GetDB(float2( PCoord, PrevParallaxCoord.y ) ).y, Get_DB_ZDP = WP > 0 ? lerp(Get_DB, abs(Get_DB), ZFighting_Mask) : Get_DB;
#line 1473
float beforeDepthValue = Get_DB_ZDP, afterDepthValue = CurrentDepthMapValue - CurrentLayerDepth;
beforeDepthValue += LayerDepth - CurrentLayerDepth;
#line 1476
float DepthDiffrence = afterDepthValue - beforeDepthValue;
float weight = afterDepthValue / min(-0.0125,DepthDiffrence);
#line 1479
ParallaxCoord.x = PrevParallaxCoord.x * abs(weight) + ParallaxCoord.x * (1 - weight);
#line 1482
if(View_Mode > 0)
{
ParallaxCoord.x += DB_Offset.x * Details;
#line 1486
if(Diverge < 0)
ParallaxCoord.x += DepthDiffrence * 1.5 *  float2((1.0 / 5360), (1.0 / 1440)).x;
else
ParallaxCoord.x -= DepthDiffrence * 1.5 *  float2((1.0 / 5360), (1.0 / 1440)).x;
}
#line 1493
if(Stereoscopic_Mode == 2)
ParallaxCoord.y += IO *  float2((1.0 / 5360), (1.0 / 1440)).y; 
else if(Stereoscopic_Mode == 3)
ParallaxCoord.x += IO *  float2((1.0 / 5360), (1.0 / 1440)).x; 
#line 1498
return ParallaxCoord;
}
#line 1523
float2 LensePitch(float2 TC)
{
#line 1543
float Degrees = radians(Lens_Angle);
#line 1545
float2 PivotPoint = 0.5;
float2 Rotationtexcoord = TC;
float sin_factor = sin(Degrees);
float cos_factor = cos(Degrees);
Rotationtexcoord = mul(Rotationtexcoord - PivotPoint, float2x2(float2(cos_factor, -sin_factor), float2(sin_factor, cos_factor)));
Rotationtexcoord += PivotPoint + PivotPoint;
#line 1552
return Rotationtexcoord.xy;
}
#line 1564
float3 PS_calcLR(float2 texcoord)
{
float2 TCL, TCR, TCL_T, TCR_T, TexCoords = texcoord, TC = texcoord;
#line 1568
[branch] if (Stereoscopic_Mode == 0)
{
TCL = float2(texcoord.x*2,texcoord.y);
TCR = float2(texcoord.x*2-1,texcoord.y);
}
else if(Stereoscopic_Mode == 1)
{
TCL = float2(texcoord.x,texcoord.y*2);
TCR = float2(texcoord.x,texcoord.y*2-1);
}
else if(Stereoscopic_Mode == 6)
{
TCL = float2(texcoord.x*2,texcoord.y*2);
TCL_T = float2(texcoord.x*2-1,texcoord.y*2);
TCR = float2(texcoord.x*2-1,texcoord.y*2-1);
TCR_T = float2(texcoord.x*2,texcoord.y*2-1);
}
else
{
TCL = float2(texcoord.x,texcoord.y);
TCR = float2(texcoord.x,texcoord.y);
}
#line 1591
TCL +=  float2( (Perspective *  float2((1.0 / 5360), (1.0 / 1440)).x) * 0.5, 0) ;
TCR -=  float2( (Perspective *  float2((1.0 / 5360), (1.0 / 1440)).x) * 0.5, 0) ;
#line 1594
float D = Eye_Swap ? -Divergence : Divergence;
#line 1596
float FadeIO = smoothstep(0,1,1-Fade_in_out(texcoord).x), FD = D, FD_Adjust = 0.1;
#line 1598
if( Eye_Fade_Reduction_n_Power.y == 1)
FD_Adjust = 0.2;
else if( Eye_Fade_Reduction_n_Power.y == 2)
FD_Adjust = 0.3;
#line 1603
if (FPSDFIO >= 1)
FD = lerp(FD * FD_Adjust,FD,FadeIO);
#line 1608
float2 DLR = float2(FD,FD);
if( Eye_Fade_Reduction_n_Power.x == 1)
DLR = float2(D,FD);
else if( Eye_Fade_Reduction_n_Power.x == 2)
DLR = float2(FD,D);
#line 1614
float4 image = 1, accum, color, Left_T, Right_T, L, R,
Left = MouseCursor(Parallax(-DLR.x, TCL,  Interlace_Anaglyph_Calibrate.x * 0.5 )),
Right= MouseCursor(Parallax(DLR.y, TCR, - Interlace_Anaglyph_Calibrate.x * 0.5 ));
#line 1618
if(Stereoscopic_Mode == 6)
{
Left_T = MouseCursor(Parallax(-DLR.x * 0.33333333, TCL_T,  Interlace_Anaglyph_Calibrate.x * 0.5 ));
Right_T= MouseCursor(Parallax(DLR.y * 0.33333333, TCR_T, - Interlace_Anaglyph_Calibrate.x * 0.5 ));
}
#line 1635
float Dist = Stereoscopic_Mode == 5 ? int(FP_IO_Pos().z) : 0, Distance_Ladder = 0.0;
#line 1637
if (Dist == 2)
Distance_Ladder = 2;
if (Dist == 3)
Distance_Ladder = 1.5; 
if (Dist == 4)
Distance_Ladder = 1.0;
if (Dist == 5 || Dist == 6)
Distance_Ladder = 0.5; 
if (Dist == 7)
Distance_Ladder = 0.0;
#line 1648
float IAC = saturate(Interlace_Anaglyph_Calibrate.z), LPI = Stereoscopic_Mode == 5 ? 1.267 + (Distance_Ladder * 0.001) : 1.0;
#line 1650
TC += float2( ( FP_IO_Pos().x * 1.225 + lerp(0,4,IAC) ) *  float2((1.0 / 5360), (1.0 / 1440)).x, 0.0);
#line 1652
TC = Stereoscopic_Mode == 5 ? LensePitch(TC) * LPI : TC;
#line 1654
float2 gridxy, GXYArray[9] = {
float2(TC.x * 5360, TC.y * 1440), 
float2(TC.x * 3840.0, TC.y * 2160.0),
float2(TC.x * 3841.0, TC.y * 2161.0),
float2(TC.x * 1920.0, TC.y * 1080.0),
float2(TC.x * 1921.0, TC.y * 1081.0),
float2(TC.x * 1680.0, TC.y * 1050.0),
float2(TC.x * 1681.0, TC.y * 1051.0),
float2(TC.x * 1280.0, TC.y * 720.0),
float2(TC.x * 1281.0, TC.y * 721.0)
};
#line 1666
gridxy = floor(GXYArray[Scaling_Support]);
float DG = 0.950, Swap_Eye = Dist== 3 || Dist == 5 || Dist == 6 ? 1 : 0;
const int Images = 4;
#line 1670
if (Swap_Eye) { L = Right; R = Left; } else	{ L = Left; R = Right; }
#line 1672
float3 Colors[Images] = {
float3(L.x     , R.y * DG, R.z     ), 
float3(L.x * DG, L.y     , R.z * DG), 
float3(R.x     , L.y * DG, L.z     ), 
float3(R.x * DG, R.y     , L.z * DG)};
#line 1678
if(Stereoscopic_Mode == 0)
color = TexCoords.x < 0.5 ? L : R;
else if(Stereoscopic_Mode == 1)
color = TexCoords.y < 0.5 ? L : R;
else if(Stereoscopic_Mode == 2)
color = fmod(gridxy.y,2) ? R : L;
else if(Stereoscopic_Mode == 3)
color = fmod(gridxy.x,2) ? R : L;
else if(Stereoscopic_Mode == 4)
color = fmod(gridxy.x+gridxy.y,2) ? R : L;
else if(Stereoscopic_Mode == 5)
color = float4(Colors[int(fmod(gridxy.x,Images))],1.0);
else if(Stereoscopic_Mode == 6)
color = TexCoords.y < 0.5 ? TexCoords.x < 0.5 ? Left : Left_T : TexCoords.x < 0.5 ? Right_T : Right;
else if(Stereoscopic_Mode >= 7)
{
float Contrast = 1.0, DeGhost = 0.06, LOne, ROne;
float3 HalfLA = dot(L.rgb,float3(0.299, 0.587, 0.114)), HalfRA = dot(R.rgb,float3(0.299, 0.587, 0.114));
float3 LMA = lerp(HalfLA,L.rgb,Interlace_Anaglyph_Calibrate.y), RMA = lerp(HalfRA,R.rgb,Interlace_Anaglyph_Calibrate.y);
#line 1698
float contrast = (Contrast*0.5)+0.5;
#line 1701
float4 cA = float4(LMA,1);
float4 cB = float4(RMA,1);
#line 1704
if (Stereoscopic_Mode == 7) 
color =  float4(cA.r,cB.g,cB.b,1.0);
else if (Stereoscopic_Mode == 8) 
{
float red = 0.437 * cA.r + 0.449 * cA.g + 0.164 * cA.b - 0.011 * cB.r - 0.032 * cB.g - 0.007 * cB.b;
#line 1710
if (red > 1) { red = 1; }   if (red < 0) { red = 0; }
#line 1712
float green = -0.062 * cA.r -0.062 * cA.g -0.024 * cA.b + 0.377 * cB.r + 0.761 * cB.g + 0.009 * cB.b;
#line 1714
if (green > 1) { green = 1; }   if (green < 0) { green = 0; }
#line 1716
float blue = -0.048 * cA.r - 0.050 * cA.g - 0.017 * cA.b -0.026 * cB.r -0.093 * cB.g + 1.234  * cB.b;
#line 1718
if (blue > 1) { blue = 1; }   if (blue < 0) { blue = 0; }
#line 1720
color = float4(red, green, blue, 0);
}
else if (Stereoscopic_Mode == 9) 
{
LOne = contrast*0.45;
ROne = contrast;
DeGhost *= 0.1;
#line 1728
accum = saturate(cA*float4(LOne,(1.0-LOne)*0.5,(1.0-LOne)*0.5,1.0));
image.r = pow(accum.r+accum.g+accum.b, 1.00);
image.a = accum.a;
#line 1732
accum = saturate(cB*float4(1.0-ROne,ROne,0.0,1.0));
image.g = pow(accum.r+accum.g+accum.b, 1.15);
image.a = image.a+accum.a;
#line 1736
accum = saturate(cB*float4(1.0-ROne,0.0,ROne,1.0));
image.b = pow(accum.r+accum.g+accum.b, 1.15);
image.a = (image.a+accum.a)/3.0;
#line 1740
accum = image;
image.r = (accum.r+(accum.r*DeGhost)+(accum.g*(DeGhost*-0.5))+(accum.b*(DeGhost*-0.5)));
image.g = (accum.g+(accum.r*(DeGhost*-0.25))+(accum.g*(DeGhost*0.5))+(accum.b*(DeGhost*-0.25)));
image.b = (accum.b+(accum.r*(DeGhost*-0.25))+(accum.g*(DeGhost*-0.25))+(accum.b*(DeGhost*0.5)));
color = image;
}
else if (Stereoscopic_Mode == 10) 
color = float4(cB.r,cA.g,cB.b,1.0);
else if (Stereoscopic_Mode == 11) 
{
#line 1751
float red = -0.062 * cA.r -0.158 * cA.g -0.039 * cA.b + 0.529 * cB.r + 0.705 * cB.g + 0.024 * cB.b;
#line 1753
if (red > 1) { red = 1; }   if (red < 0) { red = 0; }
#line 1755
float green = 0.284 * cA.r + 0.668 * cA.g + 0.143 * cA.b - 0.016 * cB.r - 0.015 * cB.g + 0.065 * cB.b;
#line 1757
if (green > 1) { green = 1; }   if (green < 0) { green = 0; }
#line 1759
float blue = -0.015 * cA.r -0.027 * cA.g + 0.021 * cA.b + 0.009 * cB.r + 0.075 * cB.g + 0.937  * cB.b;
#line 1761
if (blue > 1) { blue = 1; }   if (blue < 0) { blue = 0; }
#line 1763
color = float4(red, green, blue, 0);
}
else if (Stereoscopic_Mode == 12)
{
LOne = contrast*0.45;
ROne = contrast*0.8;
DeGhost *= 0.275;
#line 1771
accum = saturate(cB*float4(ROne,1.0-ROne,0.0,1.0));
image.r = pow(accum.r+accum.g+accum.b, 1.15);
image.a = accum.a;
#line 1775
accum = saturate(cA*float4((1.0-LOne)*0.5,LOne,(1.0-LOne)*0.5,1.0));
image.g = pow(accum.r+accum.g+accum.b, 1.05);
image.a = image.a+accum.a;
#line 1779
accum = saturate(cB*float4(0.0,1.0-ROne,ROne,1.0));
image.b = pow(accum.r+accum.g+accum.b, 1.15);
image.a = (image.a+accum.a)*0.33333333;
#line 1783
accum = image;
image.r = accum.r+(accum.r*(DeGhost*0.5))+(accum.g*(DeGhost*-0.25))+(accum.b*(DeGhost*-0.25));
image.g = accum.g+(accum.r*(DeGhost*-0.5))+(accum.g*(DeGhost*0.25))+(accum.b*(DeGhost*-0.5));
image.b = accum.b+(accum.r*(DeGhost*-0.25))+(accum.g*(DeGhost*-0.25))+(accum.b*(DeGhost*0.5));
color = image;
}
else if (Stereoscopic_Mode == 13) 
{
LOne = contrast*0.45;
ROne = contrast;
float D[1];
DeGhost *= 0.275;
#line 1796
accum = saturate(cA*float4(ROne,0.0,1.0-ROne,1.0));
image.r = pow(accum.r+accum.g+accum.b, 1.05);
image.a = accum.a;
#line 1800
accum = saturate(cA*float4(0.0,ROne,1.0-ROne,1.0));
image.g = pow(accum.r+accum.g+accum.b, 1.10);
image.a = image.a+accum.a;
#line 1804
accum = saturate(cB*float4((1.0-LOne)*0.5,(1.0-LOne)*0.5,LOne,1.0));
image.b = pow(accum.r+accum.g+accum.b, 1.0);
image.b = lerp(pow(image.b,(DeGhost*0.15)+1.0),1.0-pow(abs(1.0-image.b),(DeGhost*0.15)+1.0),image.b);
image.a = (image.a+accum.a)*0.33333333;
#line 1809
accum = image;
image.r = accum.r+(accum.r*(DeGhost*1.5))+(accum.g*(DeGhost*-0.75))+(accum.b*(DeGhost*-0.75));
image.g = accum.g+(accum.r*(DeGhost*-0.75))+(accum.g*(DeGhost*1.5))+(accum.b*(DeGhost*-0.75));
image.b = accum.b+(accum.r*(DeGhost*-1.5))+(accum.g*(DeGhost*-1.5))+(accum.b*(DeGhost*3.0));
color = saturate(image);
}
}
#line 1817
if (Depth_Map_View == 2)
color.rgb = tex2D(SamplerzBufferN_P,TexCoords).xxx;
#line 1821
float DepthBlur, Alinement_Depth = tex2Dlod(SamplerzBufferN_P,float4(TexCoords,0,0)).x, Depth = Alinement_Depth;
const float DBPower = 1.0, Con = 11, weight[11] = { 0.0,0.010,-0.010,0.020,-0.020,0.030,-0.030,0.040,-0.040,0.050,-0.050 };
if(BD_Options == 2 || Alinement_View)
{
float2 dir = 0.5 - TexCoords;
[loop]
for (int i = 0; i < 11; i++)
{
DepthBlur += tex2Dlod(SamplerzBufferN_L,float4(TexCoords + dir * weight[i] * DBPower,0,2) ).x;
}
#line 1832
Alinement_Depth = ( Alinement_Depth + DepthBlur ) * 0.08333;
}
#line 1835
if (BD_Options == 2 || Alinement_View)
color.rgb = dot(tex2D(BackBufferBORDER,TexCoords).rgb,0.333) * float3((Depth/Alinement_Depth> 0.998),1,(Depth/Alinement_Depth > 0.998));
#line 1838
return color.rgb;
}
#line 1841
float4 Average_Luminance(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
float4 ABEA, ABEArray[6] = {
float4(0.0,1.0,0.0, 1.0),           
float4(0.0,1.0,0.0, 0.750),         
float4(0.0,1.0,0.0, 0.5),           
float4(0.0,1.0, 0.15625, 0.46875),  
float4(0.375, 0.250, 0.4375, 0.125),
float4(0.375, 0.250, 0.0, 1.0)      
};
ABEA = ABEArray[Auto_Balance_Ex];
#line 1853
float Average_Lum_ZPD = PrepDepth(float2(ABEA.x + texcoord.x * ABEA.y, ABEA.z + texcoord.y * ABEA.w))[0][0], Average_Lum_Bottom = PrepDepth( texcoord )[0][0];
#line 1855
const int Num_of_Values = 6; 
float Storage__Array[Num_of_Values] = { tex2D(SamplerDMN,0).x,    
tex2D(SamplerDMN,1).x,                
tex2D(SamplerDMN,int2(0,1)).x,        
1.0,                                  
tex2D(SamplerzBufferN_P,1).y,         
tex2D(SamplerzBufferN_P,int2(0,1)).y};
#line 1864
float Grid = floor(texcoord.y * 1440 * (1.0 / 1440) * Num_of_Values);
#line 1866
return float4(Average_Lum_ZPD,Average_Lum_Bottom,Storage__Array[int(fmod(Grid,Num_of_Values))],tex2Dlod(SamplerDMN,float4(texcoord,0,0)).y);
}
#line 1870
static const  float  CH_A    =  float (0x69f99), CH_B    =  float (0x79797), CH_C    =  float (0xe111e),
CH_D    =  float (0x79997), CH_E    =  float (0xf171f), CH_F    =  float (0xf1711),
CH_G    =  float (0xe1d96), CH_H    =  float (0x99f99), CH_I    =  float (0xf444f),
CH_J    =  float (0x88996), CH_K    =  float (0x95159), CH_L    =  float (0x1111f),
CH_M    =  float (0x9fd99), CH_N    =  float (0x9bd99), CH_O    =  float (0x69996),
CH_P    =  float (0x79971), CH_Q    =  float (0x69b5a), CH_R    =  float (0x79759),
CH_S    =  float (0xe1687), CH_T    =  float (0xf4444), CH_U    =  float (0x99996),
CH_V    =  float (0x999a4), CH_W    =  float (0x999f9), CH_X    =  float (0x99699),
CH_Y    =  float (0x99e8e), CH_Z    =  float (0xf843f), CH_0    =  float (0x6bd96),
CH_1    =  float (0x46444), CH_2    =  float (0x6942f), CH_3    =  float (0x69496),
CH_4    =  float (0x99f88), CH_5    =  float (0xf1687), CH_6    =  float (0x61796),
CH_7    =  float (0xf8421), CH_8    =  float (0x69696), CH_9    =  float (0x69e84),
CH_APST =  float (0x66400), CH_PI   =  float (0x0faa9), CH_UNDS =  float (0x0000f),
CH_HYPH =  float (0x00600), CH_TILD =  float (0x0a500), CH_PLUS =  float (0x02720),
CH_EQUL =  float (0x0f0f0), CH_SLSH =  float (0x08421), CH_EXCL =  float (0x33303),
CH_QUES =  float (0x69404), CH_COMM =  float (0x00032), CH_FSTP =  float (0x00002),
CH_QUOT =  float (0x55000), CH_BLNK =  float (0x00000), CH_COLN =  float (0x00202),
CH_LPAR =  float (0x42224), CH_RPAR =  float (0x24442);
#line 1891
float getBit( float map, float index )
{   
return fmod( floor( map * exp2(-index) ), 2.0 );
}
#line 1896
float drawChar( float Char, float2 pos, float2 size, float2 TC )
{   
TC -= pos;
#line 1900
TC /= size;
#line 1902
float res = step(0.0,min(TC.x,TC.y)) - step(1.0,max(TC.x,TC.y));
#line 1904
TC *=  float2(4,5);
#line 1906
res*=getBit( Char, 4.0*floor(TC.y) + floor(TC.x) );
return saturate(res);
}
#line 1910
float3 Out(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
float2 TC = float2(texcoord.x,1-texcoord.y);
float Text_Timer = 25000, BT = smoothstep(0,1,sin(timer*(3.75/1000))), Size = 1.1, Depth3D, Read_Help, Supported, ET, ETC, ETTF, ETTC, SetFoV, FoV, Post, Effect, NoPro, NotCom, Mod, Needs, Net, Over, Set, AA, Emu, Not, No, Help, Fix, Need, State, SetAA, SetWP, Work;
float3 Color = PS_calcLR(texcoord).rgb; 
#line 1916
if( Read_Help_Warning_D             ||  Not_Compatible_Warning_D        ||  1  ||  Needs_Fix_Mod_D                 ||  Disable_Post_Effects_Warning_D  ||  Depth_Selection_Warning_D       ||  0 ||  Disable_Anti_Aliasing_D         ||  Network_Warning_D               ||  Weapon_Profile_Warning_D        ||  Set_Game_FoV_D                  ||  Emulator_Detected_Warning_D    )
Text_Timer = 30000;
#line 1919
[branch] if(timer <= Text_Timer || Text_Info)
{   
float2 charSize = float2(.00875, .0125) * Size;
#line 1923
float2 charPos = float2( 0.009, 0.9725);
#line 1925
Needs += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_C, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_Y, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_H, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_SLSH, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_H, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_C, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Needs += drawChar( CH_N, charPos, charSize, TC);
#line 1965
charPos = float2( 0.009, 0.955);
Work += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_W, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_K, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_Y, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_M, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_Y, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_M, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
Work += drawChar( CH_L, charPos, charSize, TC);
#line 1999
charPos = float2( 0.009, 0.9375);
Supported += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_U, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_M, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_U, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_C, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Supported += drawChar( CH_D, charPos, charSize, TC);
#line 2028
charPos = float2( 0.009, 0.920);
Effect += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_B, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_C, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_SLSH, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_M, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_B, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_SLSH, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_F, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_SLSH, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_G, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
Effect += drawChar( CH_N, charPos, charSize, TC);
#line 2053
charPos = float2( 0.009, 0.9025);
SetAA += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_B, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_SLSH, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_M, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_SLSH, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_SLSH, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
SetAA += drawChar( CH_S, charPos, charSize, TC);
#line 2086
charPos = float2( 0.009, 0.885);
SetWP += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_W, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_F, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
SetWP += drawChar( CH_E, charPos, charSize, TC);
#line 2106
charPos = float2( 0.009, 0.8675);
SetFoV += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_F, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_V, charPos, charSize, TC);
#line 2115
charPos = float2( 0.894, 0.9725);
Read_Help += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
Read_Help += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Read_Help += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
Read_Help += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Read_Help += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Read_Help += drawChar( CH_H, charPos, charSize, TC); charPos.x += .01 * Size;
Read_Help += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Read_Help += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
Read_Help += drawChar( CH_P, charPos, charSize, TC);
#line 2126
charPos = float2( 0.009, 0.018);
#line 2128
NoPro += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_F, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
NoPro += drawChar( CH_E, charPos, charSize, TC); charPos.x = 0.009;
#line 2139
NotCom += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_C, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_P, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_B, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
NotCom += drawChar( CH_E, charPos, charSize, TC); charPos.x = 0.009;
#line 2153
Mod += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_D, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_F, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_X, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_SLSH, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_M, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
Mod += drawChar( CH_D, charPos, charSize, TC); charPos.x = 0.009;
#line 2167
State += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_V, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_W, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_C, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_H, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_FSTP, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_F, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_X, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_H, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_M, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_N, charPos, charSize, TC); charPos.x += .01 * Size;
State += drawChar( CH_G, charPos, charSize, TC);
#line 2189
float D3D_Size_A = 1.375,D3D_Size_B = 0.75;
float2 charSize_A = float2(.00875, .0125) * D3D_Size_A, charSize_B = float2(.00875, .0125) * D3D_Size_B;
#line 2192
charPos = float2( 0.862, 0.018);
#line 2194
Depth3D += drawChar( CH_D, charPos, charSize_A, TC); charPos.x += .01 * D3D_Size_A;
Depth3D += drawChar( CH_E, charPos, charSize_A, TC); charPos.x += .01 * D3D_Size_A;
Depth3D += drawChar( CH_P, charPos, charSize_A, TC); charPos.x += .01 * D3D_Size_A;
Depth3D += drawChar( CH_T, charPos, charSize_A, TC); charPos.x += .01 * D3D_Size_A;
Depth3D += drawChar( CH_H, charPos, charSize_A, TC); charPos.x += .01 * D3D_Size_A;
Depth3D += drawChar( CH_3, charPos, charSize_A, TC); charPos.x += .01 * D3D_Size_A;
Depth3D += drawChar( CH_D, charPos, charSize_A, TC); charPos.x += 0.008 * D3D_Size_A;
Depth3D += drawChar( CH_FSTP, charPos, charSize_A, TC); charPos.x += 0.01 * D3D_Size_A;
charPos = float2( 0.963, 0.018);
Depth3D += drawChar( CH_I, charPos, charSize_B, TC); charPos.x += .01 * D3D_Size_B;
Depth3D += drawChar( CH_N, charPos, charSize_B, TC); charPos.x += .01 * D3D_Size_B;
Depth3D += drawChar( CH_F, charPos, charSize_B, TC); charPos.x += .01 * D3D_Size_B;
Depth3D += drawChar( CH_O, charPos, charSize_B, TC);
if(Stereoscopic_Mode == 5)
{
#line 2210
charPos = float2( 0.4575, 0.49375);
#line 2212
ETC += drawChar( CH_C, charPos, charSize, TC); charPos.x += .01 * Size;
ETC += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
ETC += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
ETC += drawChar( CH_I, charPos, charSize, TC); charPos.x += .01 * Size;
ETC += drawChar( CH_B, charPos, charSize, TC); charPos.x += .01 * Size;
ETC += drawChar( CH_R, charPos, charSize, TC); charPos.x += .01 * Size;
ETC += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
ETC += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
ETC += drawChar( CH_E, charPos, charSize, TC); charPos.x;
#line 2222
charPos = float2( 0.4575, 0.49375);
ETTF += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
ETTF += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
ETTF += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
ETTF += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
ETTF += drawChar( CH_F, charPos, charSize, TC); charPos.x += .01 * Size;
ETTF += drawChar( CH_A, charPos, charSize, TC); charPos.x += .01 * Size;
ETTF += drawChar( CH_R, charPos, charSize, TC); charPos.x;
#line 2231
charPos = float2( 0.445, 0.49375);
ETTC += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
ETTC += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
ETTC += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
ETTC += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
ETTC += drawChar( CH_C, charPos, charSize, TC); charPos.x += .01 * Size;
ETTC += drawChar( CH_L, charPos, charSize, TC); charPos.x += .01 * Size;
ETTC += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
ETTC += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
ETTC += drawChar( CH_E, charPos, charSize, TC); charPos.x;
#line 2243
if(FP_IO_Pos().x <= 0.5 && FP_IO_Pos().x >= -0.5)
ET = ETC;
#line 2253
}
#line 2255
if( Depth_Selection_Warning_D      )
Need = Needs;
if( Read_Help_Warning_D            )
Help = Read_Help;
if( Network_Warning_D              )
Net = Work;
if( Disable_Post_Effects_Warning_D )
Post = Effect;
if( Weapon_Profile_Warning_D       )
Set = SetWP;
if( Disable_Anti_Aliasing_D        )
AA = SetAA;
if( Set_Game_FoV_D                 )
FoV = SetFoV;
if( Emulator_Detected_Warning_D    )
Emu = Supported;
#line 2272
if( 1 )
No = NoPro * BT;
if( Not_Compatible_Warning_D       )
Not = NotCom * BT;
if( Needs_Fix_Mod_D                )
Fix = Mod * BT;
if( 0)
Over = State * BT;
#line 2281
return Depth3D+Help+Post+No+Not+Net+Fix+Need+Over+AA+Set+FoV+Emu+ET ? (1-texcoord.y*50.0+48.85)*texcoord.y-0.500: Color;
}
else
return Color;
}
#line 2287
void PostProcessVS(in uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD)
{
texcoord.x = (id == 2) ? 2.0 : 0.0;
texcoord.y = (id == 1) ? 2.0 : 0.0;
position = float4(texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 2294
technique SuperDepth3D
< ui_tooltip = "Suggestion : You Can Enable 'Performance Mode Checkbox,' in the lower bottom right of the ReShade's Main UI.\n"
"Do this once you set your 3D settings of course."; >
{
#line 2312
pass AverageLuminance
{
VertexShader = PostProcessVS;
PixelShader = Average_Luminance;
RenderTarget = texLumN;
}
#line 2319
pass DepthBuffer
{
VertexShader = PostProcessVS;
PixelShader = DepthMap;
RenderTarget = texDMN;
}
pass zbufferLM
{
VertexShader = PostProcessVS;
PixelShader = zBuffer;
RenderTarget0 = texzBufferN_P;
RenderTarget1 = texzBufferN_L;
}
pass StereoOut
{
VertexShader = PostProcessVS;
PixelShader = Out;
}
#line 2345
}

