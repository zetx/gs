#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SuperDepth3D_VR+.fx"
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
#line 36 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\SuperDepth3D_VR+.fx"
#line 223
uniform int IPD <
#line 227
ui_type = "slider";
#line 229
ui_min = 0; ui_max = 100;
ui_label = "·Interpupillary Distance·";
ui_tooltip = "Determines the distance between your eyes.\n"
"Default is 0.";
ui_category = "Eye Focus Adjustment";
> = 0;
#line 240
uniform float Divergence <
ui_type = "drag";
ui_min = 10.0; ui_max =  75.0; ui_step = 0.5;
ui_label = "·Divergence Slider·";
ui_tooltip = "Divergence increases differences between the left and right retinal images and allows you to experience depth.\n"
"The process of deriving binocular depth information is called stereopsis.";
ui_category = "Divergence & Convergence";
> =  37.5;
#line 249
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
#line 271
uniform int Auto_Balance_Ex <
ui_type = "slider";
ui_min = 0; ui_max = 5;
ui_label = " Auto Balance";
ui_tooltip = "Automatically Balance between ZPD Depth and Scene Depth.\n"
"Default is Off.";
ui_category = "Divergence & Convergence";
> =  Auto_Balance_D;
#line 280
uniform int ZPD_Boundary <
ui_type = "combo";
ui_items = "BD0 Off\0BD1 Full\0BD2 Narrow\0BD3 Wide\0BD4 FPS Center\0BD5 FPS Right\0";
ui_label = " ZPD Boundary Detection";
ui_tooltip = "This selection menu gives extra boundary conditions to ZPD.\n"
"This treats your screen as a virtual wall.\n"
"Default is Off.";
ui_category = "Divergence & Convergence";
> =  ZPD_Boundary_Type_D;
#line 290
uniform float2 ZPD_Boundary_n_Fade <
ui_type = "slider";
ui_min = 0.0; ui_max = 0.5;
ui_label = " ZPD Boundary & Fade Time";
ui_tooltip = "This selection menu gives extra boundary conditions to scale ZPD & lets you adjust Fade time.";
ui_category = "Divergence & Convergence";
> = float2( ZPD_Boundary_Scaling_D, ZPD_Boundary_Fade_Time_D);
#line 298
uniform int View_Mode <
ui_type = "combo";
ui_items = "VM0 Normal \0VM1 Mixed \0VM2 Reiteration \0VM3 Stamped \0VM4 Adaptive \0";
ui_label = "·View Mode·";
ui_tooltip = "Changes the way the shader fills in the occlude sections in the image.\n"
"Normal      | Normal output used for most games with it's streched look.\n"
"Mixed       | is used for higher amounts of Semi-Transparent objects like foliage.\n"
"Reiteration | Same thing as Stamped but with brakeage points.\n"
"Stamped     | Stamps out a transparent area on the occluded area.\n"
"Adaptive    | is a scene adapting infilling that uses disruptive reiterative sampling.\n"
"\n"
"Warning: Also Make sure you turn on Performance Mode before you close this menu.\n"
"\n"
"Default is Normal.";
ui_category = "Occlusion Masking";
> = 0;
#line 315
uniform int Custom_Sidebars <
ui_type = "combo";
ui_items = "Mirrored Edges\0Black Edges\0Stretched Edges\0";
ui_label = " Edge Handling";
ui_tooltip = "Edges selection for your screen output.";
ui_category = "Occlusion Masking";
> = 1;
#line 323
uniform float Max_Depth <
#line 327
ui_type = "slider";
#line 329
ui_min = 0.5; ui_max = 1.0;
ui_label = " Max Depth";
ui_tooltip = "Max Depth lets you clamp the max depth range of your scene.\n"
"So it's not hard on your eyes looking off in to the distance .\n"
"Default and starts at One and it's Off.";
ui_category = "Occlusion Masking";
> = 1.0;
#line 337
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
#line 364
uniform float DLSS_FSR_Offset <
#line 368
ui_type = "slider";
#line 370
ui_min = 0.0; ui_max = 4.0;
ui_label = " Upscailer Offset";
ui_tooltip = "This Offset is for non conforming ZBuffer Postion witch is normaly 1 pixel wide.\n"
"This issue only happens sometimes when using things like DLSS or FSR.\n"
"This does not solve for TAA artifacts like Jittering or smearing.\n"
"Default and starts at Zero and it's Off. With a max offset of 4pixels Wide.";
ui_category = "Occlusion Masking";
> = 0;
#line 388
uniform int Depth_Map <
ui_type = "combo";
ui_items = "DM0 Normal\0DM1 Reversed\0";
ui_label = "·Depth Map Selection·";
ui_tooltip = "Linearization for the zBuffer also known as Depth Map.\n"
"DM0 is Z-Normal and DM1 is Z-Reversed.\n";
ui_category = "Depth Map";
> =  Depth_Linearization_D;
#line 397
uniform float Depth_Map_Adjust <
ui_type = "drag";
ui_min = 1.0; ui_max = 250.0; ui_step = 0.125;
ui_label = " Depth Map Adjustment";
ui_tooltip = "This allows for you to adjust the DM precision.\n"
"Adjust this to keep it as low as possible.\n"
"Default is 7.5";
ui_category = "Depth Map";
> =  Depth_Adjust_D;
#line 407
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
#line 418
uniform float Auto_Depth_Adjust <
ui_type = "drag";
ui_min = 0.0; ui_max = 0.625;
ui_label = " Auto Depth Adjust";
ui_tooltip = "The Map Automaticly scales to outdoor and indoor areas.\n"
"Default is 0.1f, Zero is off.";
ui_category = "Depth Map";
> =  Auto_Depth_D;
#line 427
uniform bool Depth_Map_View <
ui_label = " Depth Map View";
ui_tooltip = "Display the Depth Map.";
ui_category = "Depth Map";
> = false;
#line 433
uniform bool Depth_Detection <
ui_label = " Depth Detection";
ui_tooltip = "Use this to dissable/enable in game Depth Detection.";
ui_category = "Depth Map";
> = true;
#line 439
uniform bool Depth_Map_Flip <
ui_label = " Depth Map Flip";
ui_tooltip = "Flip the depth map if it is upside down.";
ui_category = "Depth Map";
> =  Depth_Flip_D;
#line 491
static const bool Alinement_View = false;
static const float2 Horizontal_and_Vertical = float2( HVS_X_D, HVS_Y_D);
static const float2 Image_Position_Adjust = float2( HVP_X_D, HVP_Y_D);
#line 495
static const bool LB_Correction_Switch = true;
static const float2 H_V_Offset = float2( LB_Depth_Size_Offset_X_D, LB_Depth_Size_Offset_Y_D);
static const float2 Image_Pos_Offset  = float2( LB_Depth_Pos_Offset_X_D, LB_Depth_Pos_Offset_Y_D);
#line 500
uniform int WP <
ui_type = "combo";
ui_items =  "WP Off\0Custom WP\0WP 0\0WP 1\0WP 2\0WP 3\0WP 4\0WP 5\0WP 6\0WP 7\0WP 8\0WP 9\0WP 10\0WP 11\0WP 12\0WP 13\0WP 14\0WP 15\0WP 16\0WP 17\0WP 18\0WP 19\0WP 20\0WP 21\0WP 22\0WP 23\0WP 24\0WP 25\0WP 26\0WP 27\0WP 28\0WP 29\0WP 30\0WP 31\0WP 32\0WP 33\0WP 34\0WP 35\0WP 36\0WP 37\0WP 38\0WP 39\0WP 40\0WP 41\0WP 42\0WP 43\0WP 44\0WP 45\0WP 46\0WP 47\0WP 48\0WP 49\0WP 50\0WP 51\0WP 52\0WP 53\0WP 54\0WP 55\0WP 56\0WP 57\0WP 58\0WP 59\0WP 60\0WP 61\0WP 62\0WP 63\0WP 64\0WP 65\0WP 66\0WP 67\0WP 68\0WP 69\0WP 70\0WP 71\0WP 72\0WP 73\0WP 74\0";
ui_label = "·Weapon Profiles·";
ui_tooltip = "Pick Weapon Profile for your game or make your own.";
ui_category = "Weapon Hand Adjust";
> =  Weapon_Hand_D;
#line 508
uniform float4 Weapon_Adjust <
ui_type = "drag";
ui_min = 0.0; ui_max = 250.0;
ui_label = " Weapon Hand Adjust";
ui_tooltip = "Adjust Weapon depth map for your games.\n"
"X, CutOff Point used to set a different scale for first person hand apart from world scale.\n"
"Y, Precision is used to adjust the first person hand in world scale.\n"
"W, Scale is used to compress or rescale the weapon.\n"
"Default is float2(X 0.0, Y 0.0, Z 0.0, W 0.0)";
ui_category = "Weapon Hand Adjust";
> = float4(0.0,0.0,0.0,0.0);
#line 520
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
#line 532
uniform int FPSDFIO <
ui_type = "combo";
ui_items = "Off\0Press\0Hold Down\0";
ui_label = " FPS Focus Depth";
ui_tooltip = "This lets the shader handle real time depth reduction for aiming down your sights.\n"
"This may induce Eye Strain so take this as an Warning.";
ui_category = "Weapon Hand Adjust";
> = 0;
#line 541
uniform int3 Eye_Fade_Reduction_n_Power <
#line 545
ui_type = "slider";
#line 547
ui_min = 0; ui_max = 2;
ui_label = " Eye Fade Options";
ui_tooltip ="X, Eye Selection: One is Right Eye only, Two is Left Eye Only, and Zero Both Eyes.\n"
"Y, Fade Reduction: Decreases the depth amount by a current percentage.\n"
"Z, Fade Speed: Decreases or Incresses how fast it changes.\n"
"Default is X[ 0 ] Y[ 0 ] Z[ 1 ].";
ui_category = "Weapon Hand Adjust";
> = int3(0,0,0);
#line 556
uniform float Weapon_ZPD_Boundary <
ui_type = "slider";
ui_min = 0.0; ui_max = 0.5;
ui_label = " Weapon Screen Boundary Detection";
ui_tooltip = "This selection menu gives extra boundary conditions to WZPD.";
ui_category = "Weapon Hand Adjust";
> =  ZPD_Weapon_Boundary_Adjust_D;
#line 578
uniform int Cursor_Type <
ui_type = "combo";
ui_items = "Off\0FPS\0ALL\0RTS\0";
ui_label = "·Cursor Selection·";
ui_tooltip = "Choose the cursor type you like to use.\n"
"Default is Zero.";
ui_category = "Cursor Adjustments";
> = 0;
#line 587
uniform int2 Cursor_SC <
ui_type = "drag";
ui_min = 0; ui_max = 10;
ui_label = " Cursor Adjustments";
ui_tooltip = "This controls the Size & Color.\n"
"Defaults are ( X 1, Y 2 ).";
ui_category = "Cursor Adjustments";
> = int2(1,0);
#line 596
uniform bool Cursor_Lock <
ui_label = " Cursor Lock";
ui_tooltip = "Screen Cursor to Screen Crosshair Lock.";
ui_category = "Cursor Adjustments";
> = false;
#line 637
static const int BD_Options = 1;
#line 639
static const float3 Colors_K1_K2_K3 = float3( BD_K1_D, BD_K2_D, BD_K3_D);
static const float Zoom =  BD_Zoom_D;
#line 644
uniform int Barrel_Distortion <
ui_type = "combo";
ui_items = "Off\0Blinders A\0Blinders B\0";
ui_label = "·Barrel Distortion·";
ui_tooltip = "Use this to disable or enable Barrel Distortion A & B.\n"
"This also lets you select from two different Blinders.\n"
"Default is Blinders A.\n";
ui_category = "Image Adjustment";
> = 0;
#line 654
uniform float FoV <
ui_type = "slider";
ui_min = 0; ui_max = 0.5;
ui_label = " Field of View";
ui_tooltip = "Lets you adjust the FoV of the Image.\n"
"Default is 0.0.";
ui_category = "Image Adjustment";
> = 0;
#line 663
uniform float3 Polynomial_Colors_K1 <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = " Polynomial Distortion K1";
ui_tooltip = "Adjust the Polynomial Distortion K1_Red, K1_Green, & K1_Blue.\n"
"Default is (R 0.22, G 0.22, B 0.22)";
ui_category = "Image Adjustment";
> = float3(0.22, 0.22, 0.22);
#line 672
uniform float3 Polynomial_Colors_K2 <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = " Polynomial Distortion K2";
ui_tooltip = "Adjust the Polynomial Distortion K2_Red, K2_Green, & K2_Blue.\n"
"Default is (R 0.24, G 0.24, B 0.24)";
ui_category = "Image Adjustment";
> = float3(0.24, 0.24, 0.24);
#line 681
uniform bool Theater_Mode <
ui_label = " Theater Mode";
ui_tooltip = "Sets the VR Shader into Theater mode.";
ui_category = "Image Adjustment";
> = false;
#line 694
uniform float Blinders <
ui_type = "slider";
ui_min = 0.0; ui_max = 1.0;
ui_label = "·Blinders·";
ui_tooltip = "Lets you adjust blinders sensitivity.\n"
"Default is Zero, Off.";
ui_category = "Image Effects";
> = 0;
#line 703
uniform float Adjust_Vignette <
ui_type = "slider";
ui_min = 0; ui_max = 1;
ui_label = " Vignette";
ui_tooltip = "Soft edge effect around the image.";
ui_category = "Image Effects";
> = 0.0;
#line 711
uniform float Sharpen_Power <
ui_type = "slider";
ui_min = 0.0; ui_max = 5.0;
ui_label = " SmartSharp";
ui_tooltip = "Adjust this to clear up the image the game, movie picture & etc.\n"
"This is Smart Sharp Jr code based on the Main Smart Sharp shader.\n"
"It can be pushed more and looks better then the basic USM.";
ui_category = "Image Effects";
> = 0;
#line 723
uniform float Saturation <
ui_type = "slider";
ui_min = 0; ui_max = 1;
ui_label = " Saturation";
ui_tooltip = "Lets you saturate image, basically adds more color.";
ui_category = "Image Effects";
> = 0;
#line 732
uniform bool NCAOC < 
ui_label = " Alternative Overlay Mode";
ui_tooltip = "Sets the VR Shader to Non Companion App Overlay Compatibility.\n"
"This lets the overlay work in other Desktop Mirroring software.";
ui_category = "Extra Options";
> = false;
#line 742
uniform bool Cancel_Depth < source = "key"; keycode =  0 ; toggle = true; mode = "toggle";>;
uniform bool Mask_Cycle < source = "key"; keycode =   0 ; toggle = true; >;
uniform bool Text_Info < source = "key"; keycode =  93; toggle = true; mode = "toggle";>;
uniform bool CLK < source = "mousebutton"; keycode =  4 ; toggle = true; mode = "toggle";>;
uniform bool Trigger_Fade_A < source = "mousebutton"; keycode =  1 ; toggle = true; mode = "toggle";>;
uniform bool Trigger_Fade_B < source = "mousebutton"; keycode =  1 ;>;
uniform bool overlay_open < source = "overlay_open"; >;
uniform float2 Mousecoords < source = "mousepoint"; > ;
uniform float frametime < source = "frametime";>;
uniform float timer < source = "timer"; >;
#line 753
static const float Auto_Balance_Clamp = 0.5; 
#line 756
uniform bool DepthCheck < source = "bufready_depth"; >;
#line 764
float fmod(float a, float b)
{
float c = frac(abs(a / b)) * abs(b);
return a < 0 ? -c : c;
}
#line 770
float3 RGBtoYCbCr(float3 rgb) 
{   float TCoRF[1];
float Y  =  .299 * rgb.x + .587 * rgb.y + .114 * rgb.z; 
float Cb = -.169 * rgb.x - .331 * rgb.y + .500 * rgb.z; 
float Cr =  .500 * rgb.x - .419 * rgb.y - .081 * rgb.z; 
return float3(Y,Cb + 128./255.,Cr + 128./255.);
}
#line 787
texture DepthBufferTex : DEPTH;
sampler DepthBuffer
{
Texture = DepthBufferTex;
AddressU = BORDER;
AddressV = BORDER;
AddressW = BORDER;
#line 795
MagFilter = POINT;
MinFilter = POINT;
MipFilter = POINT;
};
#line 800
texture BackBufferTex : COLOR;
#line 802
sampler BackBuffer
{
Texture = BackBufferTex;
AddressU = BORDER;
AddressV = BORDER;
AddressW = BORDER;
};
#line 810
sampler BackBufferCLAMP
{
Texture = BackBufferTex;
AddressU = CLAMP;
AddressV = CLAMP;
AddressW = CLAMP;
};
#line 832
texture texDMVR  { Width = 5360; Height = 1440; Format = RGBA16F; MipLevels = 6;};
#line 834
sampler SamplerDMVR
{
Texture = texDMVR;
};
#line 839
texture texzBufferVR_P  { Width = 5360; Height = 1440; Format = RG16F; };
#line 841
sampler SamplerzBufferVR_P
{
Texture = texzBufferVR_P;
AddressU = MIRROR;
AddressV = MIRROR;
AddressW = MIRROR;
MagFilter = POINT;
MinFilter = POINT;
MipFilter = POINT;
#line 851
};
#line 853
texture texzBufferVR_L  { Width = 5360; Height = 1440; Format = R16F; MipLevels = 2; };
#line 855
sampler SamplerzBufferVR_L
{
Texture = texzBufferVR_L;
AddressU = MIRROR;
AddressV = MIRROR;
AddressW = MIRROR;
};
#line 869
texture texPBVR  { Width = 5360; Height = 1440; Format = R8; };
#line 871
sampler SamplerPBBVR
{
Texture = texPBVR;
AddressU = BORDER;
AddressV = BORDER;
AddressW = BORDER;
};
#line 902
texture LeftTex  { Width = 5360; Height = 1440; Format =  RGB10A2; };
#line 904
sampler SamplerLeft
{
Texture = LeftTex;
AddressU = BORDER;
AddressV = BORDER;
AddressW = BORDER;
};
#line 912
texture RightTex  { Width = 5360; Height = 1440; Format =  RGB10A2; };
#line 914
sampler SamplerRight
{
Texture = RightTex;
AddressU = BORDER;
AddressV = BORDER;
AddressW = BORDER;
};
#line 924
texture texLumVR {Width = 5360 *  160 / 5360; Height = 1440 *  160 / 5360; Format = RGBA16F; MipLevels = 8;};
#line 926
sampler SamplerLumVR
{
Texture = texLumVR;
};
#line 931
texture texOtherVR {Width = 5360 *  160 / 5360; Height = 1440 *  160 / 5360; Format = R16F; MipLevels = 8;};
#line 933
sampler SamplerOtherVR
{
Texture = texOtherVR;
};
#line 939
float2 Lum(float2 texcoord)
{   
return saturate(tex2Dlod(SamplerLumVR,float4(texcoord,0,11)).xy);
}
#line 984
float4 CSB(float2 texcoords)
{   
float2 TC = -texcoords * texcoords*32 + texcoords*32;
float WTF_Fable = 0.00000000000001;
if(!Depth_Map_View)
return tex2Dlod(BackBuffer,float4(texcoords,0,0)) * smoothstep(WTF_Fable,(WTF_Fable+Adjust_Vignette)*27.0f,TC.x * TC.y) ;
else
return tex2Dlod(SamplerzBufferVR_P,float4(texcoords,0,0)).xxxx;
}
#line 1020
float4 MouseCursor(float2 texcoord )
{   float4 Out = CSB(texcoord),Color;
float A = 0.959375, TCoRF = 1-A, Cursor;
if(Cursor_Type > 0)
{
float CCA = 0.005, CCB = 0.00025, CCC = 0.25, CCD = 0.00125, Arrow_Size_A = 0.7, Arrow_Size_B = 1.3, Arrow_Size_C = 4.0;
float2 MousecoordsXY = Mousecoords *  float2((1.0 / 5360), (1.0 / 1440)), center = texcoord, Screen_Ratio = float2(1.75,1.0), Size_Color = float2(1+Cursor_SC.x,Cursor_SC.y);
float THICC = (2.0+Size_Color.x) * CCB, Size = Size_Color.x * CCA, Size_Cubed = (Size_Color.x*Size_Color.x) * CCD;
#line 1029
if (Cursor_Lock && !CLK)
MousecoordsXY = float2(0.5,0.5);
if (Cursor_Type == 3)
Screen_Ratio = float2(1.6,1.0);
#line 1034
float4 Dist_from_Hori_Vert = float4( abs((center.x - (Size* Arrow_Size_B) / Screen_Ratio.x) - MousecoordsXY.x) * Screen_Ratio.x, 
abs(center.x - MousecoordsXY.x) * Screen_Ratio.x, 										  
abs((center.y - (Size* Arrow_Size_B)) - MousecoordsXY.y),								   
abs(center.y - MousecoordsXY.y));														   
#line 1040
float B = min(max(THICC - Dist_from_Hori_Vert.y,0),max(Size-Dist_from_Hori_Vert.w,0)), A = min(max(THICC - Dist_from_Hori_Vert.w,0),max(Size-Dist_from_Hori_Vert.y,0));
float CC = A+B; 
#line 1044
float SSC = min(max(Size_Cubed - Dist_from_Hori_Vert.y,0),max(Size_Cubed-Dist_from_Hori_Vert.w,0)); 
#line 1046
if (Cursor_Type == 3)
{
Dist_from_Hori_Vert.y = abs((center.x - Size / Screen_Ratio.x) - MousecoordsXY.x) * Screen_Ratio.x ;
Dist_from_Hori_Vert.w = abs(center.y - Size - MousecoordsXY.y);
}
#line 1052
float C = all(min(max(Size - Dist_from_Hori_Vert.y,0),max(Size - Dist_from_Hori_Vert.w,0)));
C -= all(min(max(Size - Dist_from_Hori_Vert.y * Arrow_Size_C,0),max(Size - Dist_from_Hori_Vert.w * Arrow_Size_C,0)));
C -= all(min(max((Size * Arrow_Size_A) - Dist_from_Hori_Vert.x,0),max((Size * Arrow_Size_A)-Dist_from_Hori_Vert.z,0)));			
#line 1056
if(Cursor_Type == 1)
Cursor = CC;
else if (Cursor_Type == 2)
Cursor = SSC;
else if (Cursor_Type == 3)
Cursor = C;
#line 1064
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
#line 1081
return Cursor ? Color : Out;
}
#line 1084
float DMA() 
{ float DMA = Depth_Map_Adjust;
#line 1092
return DMA;
}
#line 1095
float2 TC_SP(float2 texcoord)
{
#line 1126
return texcoord;
}
#line 1136
float Depth(float2 texcoord)
{
#line 1139
float zBuffer = tex2Dlod(DepthBuffer, float4(texcoord,0,0)).x, Far = 1.0, Near = 0.125/DMA(); 
#line 1142
float2 C = float2( Far / Near, 1.0 - Far / Near ), Z = Offset < 0 ? min( 1.0, zBuffer * ( 1.0 + abs(Offset) ) ) : float2( zBuffer, 1.0 - zBuffer );
#line 1144
if(Offset > 0 || Offset < 0)
Z = Offset < 0 ? float2( Z.x, 1.0 - Z.y ) : min( 1.0, float2( Z.x * (1.0 + Offset) , Z.y / (1.0 - Offset) ) );
#line 1147
if (Depth_Map == 0) 
zBuffer = rcp(Z.x * C.y + C.x);
else if (Depth_Map == 1) 
zBuffer = rcp(Z.y * C.y + C.x);
return saturate(zBuffer);
}
#line 1154
float4 WA_XYZW()
{
float4 WeaponSettings_XYZW = Weapon_Adjust;
#line 1158
WeaponSettings_XYZW = Weapon_Profiles(WP, Weapon_Adjust);
#line 1164
return float4(WeaponSettings_XYZW.xyz,-WeaponSettings_XYZW.w + 1);
}
#line 1167
float2 WeaponDepth(float2 texcoord)
{   
float zBufferWH = tex2Dlod(DepthBuffer, float4(texcoord,0,0)).x, Far = 1.0, Near = 0.125/(0.00000001 + WA_XYZW().y);  
#line 1171
float2 Offsets = float2(1 + WA_XYZW().z,1 - WA_XYZW().z), Z = float2( zBufferWH, 1-zBufferWH );
#line 1173
if (WA_XYZW().z > 0)
Z = min( 1, float2( Z.x * Offsets.x , Z.y / Offsets.y  ));
#line 1176
[branch] if (Depth_Map == 0)
zBufferWH = Far * Near / (Far + Z.x * (Near - Far));
else if (Depth_Map == 1)
zBufferWH = Far * Near / (Far + Z.y * (Near - Far));
#line 1181
return float2(saturate(zBufferWH), WA_XYZW().x);
}
#line 1184
float3x3 PrepDepth(float2 texcoord)
{   int Flip_Depth =  0 ? !Depth_Map_Flip : Depth_Map_Flip;
#line 1187
if (Flip_Depth)
texcoord.y =  1 - texcoord.y;
#line 1190
texcoord.xy -= DLSS_FSR_Offset.x *  float2((1.0 / 5360), (1.0 / 1440));
#line 1192
float4 DM = Depth(TC_SP(texcoord)).xxxx;
float R, G, B, A, WD = WeaponDepth(TC_SP(texcoord)).x, CoP = WeaponDepth(TC_SP(texcoord)).y, CutOFFCal = (CoP/DMA()) * 0.5; 
CutOFFCal = step(DM.x,CutOFFCal);
#line 1196
[branch] if (WP == 0)
DM.x = DM.x;
else
{
DM.x = lerp(DM.x,WD,CutOFFCal);
DM.y = lerp(0.0,WD,CutOFFCal);
DM.z = lerp(0.5,WD,CutOFFCal);
}
#line 1205
R = DM.x; 
G = DM.y > saturate(smoothstep(0,2.5,DM.w)); 
B = DM.z; 
A = ZPD_Boundary >= 4 ? max( G, R) : R; 
#line 1210
return float3x3( saturate(float3(R, G, B)) , saturate(float3(A,Depth( Specialized_Depth_Trigger_D     ||  0  ? texcoord : TC_SP(texcoord)).x,DM.w)) , float3(0,0,0) );
}
#line 1225
float Fade_in_out(float2 texcoord)
{ float TCoRF[1], Trigger_Fade, AA =  0.5625 , PStoredfade = tex2D(SamplerLumVR,float2(0,0.083)).z;
if(Eye_Fade_Reduction_n_Power.z == 0)
AA *= 0.5;
else if(Eye_Fade_Reduction_n_Power.z == 2)
AA *= 1.5;
#line 1232
if(FPSDFIO == 1)
Trigger_Fade = Trigger_Fade_A;
else if(FPSDFIO == 2)
Trigger_Fade = Trigger_Fade_B;
#line 1237
return PStoredfade + (Trigger_Fade - PStoredfade) * (1.0 - exp(-frametime/((1-AA)*1000))); 
}
#line 1240
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
#line 1252
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
#line 1267
float ZPD_I = ZPD_Boundary == 3 ?  CDArrayZPD_C[iX] : (ZPD_Boundary == 2 || ZPD_Boundary == 5  ? CDArrayZPD_B[iX] : CDArrayZPD_A[iX]);
#line 1269
if(ZPD_Boundary >= 4)
{
if ( PrepDepth(GridXY)[1][0] == 1 )
ZPD_I = 0;
}
#line 1275
CD = 1 - ZPD_I / PrepDepth(GridXY)[1][0];
#line 1280
if ( CD < - Check_Depth_Limit_D )
Detect = 1;
#line 1283
if( Resident_Evil_Fix_D             ||  0 )
{
if ( CD < - REF_Check_Depth_Limit_D )
Detect_Out_of_Range = 1;
}
}
}
}
float Trigger_Fade_A = Detect, Trigger_Fade_B = Detect_Out_of_Range, AA = (1-(ZPD_Boundary_n_Fade.y*2.))*1000,
PStoredfade_A = tex2D(SamplerLumVR,float2(0, 0.250)).z, PStoredfade_B = tex2D(SamplerLumVR,float2(0, 0.416)).z;
#line 1294
return float2( PStoredfade_A + (Trigger_Fade_A - PStoredfade_A) * (1.0 - exp(-frametime/AA)), PStoredfade_B + (Trigger_Fade_B - PStoredfade_B) * (1.0 - exp(-frametime/AA)) ); 
}
#line 1297
float Motion_Blinders(float2 texcoord)
{   float Trigger_Fade = tex2Dlod(SamplerOtherVR,float4(texcoord,0,11)).x * lerp(0.0,25.0,Blinders), AA = (1- 0.5625 )*1000, PStoredfade = tex2D(SamplerLumVR,float2(0,0.583)).z;
return PStoredfade + (Trigger_Fade - PStoredfade) * (1.0 - exp2(-frametime/AA)); 
}
#line 1302
float AltWeapon_Fade()
{
float  ExAd = (1-( 0.25 * 2.0))*1000, Current =  min(0.75f,smoothstep(0,0.25f,PrepDepth(0.5f)[0][0])), Past = tex2D(SamplerLumVR,float2(0,0.750)).z;
return Past + (Current - Past) * (1.0 - exp(-frametime/ExAd));
}
#line 1308
float Weapon_ZPD_Fade(float Weapon_Con)
{
float  ExAd = (1-( 0.25 * 2.0))*1000, Current =  Weapon_Con, Past = tex2D(SamplerLumVR,float2(0,0.916)).z;
return Past + (Current - Past) * (1.0 - exp(-frametime/ExAd));
}
#line 1315
float4 DepthMap(in float4 position : SV_Position,in float2 texcoord : TEXCOORD) : SV_Target
{
float4 DM = float4(PrepDepth(texcoord)[0][0],PrepDepth(texcoord)[0][1],PrepDepth(texcoord)[0][2],PrepDepth(texcoord)[1][1]);
float R = DM.x, G = DM.y, B = DM.z, Auto_Scale =  WZPD_and_WND.y > 0.0 ? tex2D(SamplerLumVR,float2(0,0.750)).z : 1;
#line 1321
float ScaleND = saturate(lerp(R,1.0f,smoothstep(min(-WZPD_and_WND.y,-WZPD_and_WND.z * Auto_Scale),1.0f,R)));
#line 1323
if (WZPD_and_WND.y > 0)
R = saturate(lerp(ScaleND,R,smoothstep(0, Weapon_Near_Depth_Trim_D       ,ScaleND)));
#line 1326
if(texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
R = Fade_in_out(texcoord);
if(1-texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
R = Fade(texcoord).x;
if(texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
R = Fade(texcoord).y;
if(1-texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
R = Motion_Blinders(texcoord);
#line 1335
float Luma_Map = dot(0.333, tex2D(BackBufferCLAMP,texcoord).rgb);
#line 1337
return saturate(float4(R,G,B,Luma_Map));
}
#line 1340
float AutoDepthRange(float d, float2 texcoord )
{ float LumAdjust_ADR = smoothstep(-0.0175,Auto_Depth_Adjust,Lum(texcoord).y);
return min(1,( d - 0 ) / ( LumAdjust_ADR - 0));
}
#line 1345
float3 Conv(float2 MD_WHD,float2 texcoord)
{	float D = MD_WHD.x, Z = ZPD_Separation.x, WZP = 0.5, ZP = 0.5, ALC = abs(Lum(texcoord).x), W_Convergence = WZPD_and_WND.x, WZPDB, Distance_From_Bottom = 0.9375, ZPD_Boundary = ZPD_Boundary_n_Fade.x, Store_WC;
#line 1348
if (abs(Weapon_ZPD_Boundary) > 0)
{   float WArray[8] = { 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375};
float MWArray[8] = { 0.4375, 0.46875, 0.5, 0.53125, 0.625, 0.75, 0.875, 0.9375};
float WZDPArray[8] = { 1.0, 0.5, 0.75, 0.5, 0.625, 0.5, 0.55, 0.5};
[unroll] 
for( int i = 0 ; i < 8; i++ )
{
if((WP == 22 || WP == 4) &&  1  == 1)
WZPDB = 1 - (WZPD_and_WND.x * WZDPArray[i]) / tex2Dlod(SamplerDMVR,float4(float2(WArray[i],0.9375),0,0)).z;
else
{
if (Weapon_ZPD_Boundary < 0) 
WZPDB = 1 - WZPD_and_WND.x / tex2Dlod(SamplerDMVR,float4(float2(MWArray[i],Distance_From_Bottom),0,0)).z;
else 
WZPDB = 1 - WZPD_and_WND.x / tex2Dlod(SamplerDMVR,float4(float2(WArray[i],Distance_From_Bottom),0,0)).z;
}
#line 1365
if (WZPDB < - Check_Depth_Limit_Weapon_D) 
W_Convergence *= 1.0-abs(Weapon_ZPD_Boundary);
}
}
#line 1370
Store_WC = W_Convergence;
#line 1372
W_Convergence = 1 - tex2D(SamplerLumVR,float2(0,0.916)).z / MD_WHD.y;
float WD = MD_WHD.y; 
#line 1375
if (Auto_Depth_Adjust > 0)
D = AutoDepthRange(D,texcoord);
#line 1381
if(Auto_Balance_Ex > 0 )
ZP = saturate(ALC);
#line 1384
float DOoR = smoothstep(0,1,tex2D(SamplerLumVR,float2(0, 0.416)).z), ZDP_Array[16] = { 0.0, 0.0125, 0.025, 0.0375, 0.04375, 0.05, 0.0625, 0.075, 0.0875, 0.09375, 0.1, 0.125, 0.150, 0.175, 0.20, 0.225};
#line 1386
if( Resident_Evil_Fix_D             ||  0 )
{
if( 0 )
ZPD_Boundary = lerp(ZPD_Boundary,ZDP_Array[ 0 ],DOoR);
else
ZPD_Boundary = lerp(ZPD_Boundary,ZDP_Array[ Resident_Evil_Fix_D            ],DOoR);
}
#line 1394
Z *= lerp( 1, ZPD_Boundary, smoothstep(0,1,tex2D(SamplerLumVR,float2(0, 0.250)).z));
float Convergence = 1 - Z / D;
if (ZPD_Separation.x == 0)
ZP = 1;
#line 1399
if (WZPD_and_WND.x <= 0)
WZP = 1;
#line 1402
if (ALC <= 0.025)
WZP = 1;
#line 1405
ZP = min(ZP,Auto_Balance_Clamp);
#line 1407
float Separation = lerp(1.0,5.0,ZPD_Separation.y);
return float3( lerp(Separation * Convergence,min(saturate(Max_Depth),D), ZP), lerp(W_Convergence,WD,WZP), Store_WC);
}
#line 1411
float3 DB( float2 texcoord)
{
#line 1414
float4 DM = float4(tex2Dlod(SamplerDMVR,float4(texcoord,0,0)).xyz,PrepDepth(texcoord)[1][1]);
#line 1416
if(texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
DM = PrepDepth(texcoord)[0][0];
if(1-texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
DM = PrepDepth(texcoord)[0][0];
if(texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
DM = PrepDepth(texcoord)[0][0];
if(1-texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
DM = PrepDepth(texcoord)[0][0];
#line 1425
if (WP == 0 || WZPD_and_WND.x <= 0)
DM.y = 0;
#line 1428
float3 HandleConvergence = Conv(DM.xz,texcoord).xyz;
DM.y = lerp( HandleConvergence.x, HandleConvergence.y * WA_XYZW().w, DM.y);
#line 1431
DM.z = DM.y;
DM.y += lerp(DM.y,DM.x,DM.w);
DM.y *= 0.5f;
DM.y = lerp(DM.y,DM.z,0.9375f);
#line 1436
if (Depth_Detection == 1)
{
if (!DepthCheck)
DM = 0.0625;
}
#line 1442
if (Cancel_Depth)
DM = 0.0625;
#line 1453
if( Auto_Letter_Box_Masking_D       ||  0 )
{
float storeDM = DM.y;
#line 1457
DM.y = texcoord.y >  LB_Masking_Offset_Y_D && texcoord.y <  LB_Masking_Offset_X_D ? storeDM : 0.0125;
#line 1463
}
#line 1465
return float3(DM.y,DM.w,HandleConvergence.z);
}
#line 1468
void zBuffer(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float2 Point_Out : SV_Target0 , out float Linear_Out : SV_Target1)
{
float3 Set_Depth = DB( texcoord.xy ).xyz;
#line 1472
if(1-texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2)
Set_Depth.y = AltWeapon_Fade();
if(  texcoord.x <  float2((1.0 / 5360), (1.0 / 1440)).x * 2 && 1-texcoord.y <  float2((1.0 / 5360), (1.0 / 1440)).y * 2) 
Set_Depth.y = Weapon_ZPD_Fade(Set_Depth.z);
#line 1477
Point_Out = Set_Depth.xy;
Linear_Out = Set_Depth.x;
}
#line 1481
float2 GetDB(float2 texcoord)
{
float2 DepthBuffer_LP = float2(tex2Dlod(SamplerzBufferVR_L, float4(texcoord,0, 0) ).x,tex2Dlod(SamplerzBufferVR_P, float4(texcoord,0, 0) ).x);
#line 1485
if(View_Mode == 0 || View_Mode == 3)
DepthBuffer_LP = tex2Dlod(SamplerzBufferVR_L, float4(texcoord,0, 0) ).x;
#line 1488
return DepthBuffer_LP; 
}
#line 1491
static const float4 Performance_LvL[2] = { float4( 0.5, 0.5095, 0.679, 0.5 ), float4( 1.0, 1.019, 1.425, 1.0) };
#line 1493
float2 Parallax(float Diverge, float2 Coordinates) 
{   float MS = Diverge *  float2((1.0 / 5360), (1.0 / 1440)).x, GetDepth = smoothstep(0,1,tex2Dlod(SamplerzBufferVR_P, float4(Coordinates,0, 0) ).y),
Details = 0.5,
Perf = Performance_LvL[Performance_Level].x;
float2 ParallaxCoord = Coordinates, CBxy = floor( float2(Coordinates.x * 5360, Coordinates.y * 1440));
#line 1499
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
#line 1516
float D = abs(Diverge), Cal_Steps = D * Perf, Steps = clamp( Cal_Steps, Performance_Level ? 20 : lerp(20,D,saturate(GetDepth > 0.998) ), 200 );
#line 1518
float LayerDepth = rcp(Steps), TP = View_Mode > 0 ? 0.05 : 0.025;
D = Diverge < 0 ? -75 : 75;
#line 1522
float deltaCoordinates = MS * LayerDepth, CurrentDepthMapValue = GetDB(ParallaxCoord).x, CurrentLayerDepth = 0.0f,
Offset_Switch = View_Mode > 0 ? 0.0 : 1.0, DB_Offset = D * TP *  float2((1.0 / 5360), (1.0 / 1440)).x;
#line 1525
[loop] 
while ( CurrentDepthMapValue > CurrentLayerDepth )
{   
ParallaxCoord.x -= deltaCoordinates;
#line 1530
CurrentDepthMapValue = GetDB(float2(ParallaxCoord.x - (DB_Offset * 2 * Offset_Switch),ParallaxCoord.y) ).x;
#line 1532
CurrentLayerDepth += LayerDepth;
continue;
}
#line 1536
float2 PrevParallaxCoord = float2(ParallaxCoord.x + deltaCoordinates, ParallaxCoord.y);
#line 1538
float Weapon_Mask = tex2Dlod(SamplerDMVR,float4(Coordinates,0,0)).y, ZFighting_Mask = 1.0-(1.0-tex2Dlod(SamplerLumVR,float4(Coordinates,0,1.400)).w - Weapon_Mask);
ZFighting_Mask = ZFighting_Mask * (1.0-Weapon_Mask);
float PCoord = (View_Mode > 0 ? ParallaxCoord.x : lerp(ParallaxCoord.x, lerp(ParallaxCoord.x,PrevParallaxCoord.x,0.5), saturate(GetDepth * 5.0)));
float Get_DB = GetDB(float2( PCoord, PrevParallaxCoord.y ) ).y, Get_DB_ZDP = WP > 0 ? lerp(Get_DB, abs(Get_DB), ZFighting_Mask) : Get_DB;
#line 1543
float beforeDepthValue = Get_DB_ZDP, afterDepthValue = CurrentDepthMapValue - CurrentLayerDepth;
beforeDepthValue += LayerDepth - CurrentLayerDepth;
#line 1546
float DepthDiffrence = afterDepthValue - beforeDepthValue;
float weight = afterDepthValue / min(-0.0125,DepthDiffrence);
#line 1549
ParallaxCoord.x = PrevParallaxCoord.x * abs(weight) + ParallaxCoord.x * (1 - weight);
#line 1552
if(View_Mode > 0)
{
ParallaxCoord.x += DB_Offset.x * Details;
#line 1556
if(Diverge < 0)
ParallaxCoord.x += DepthDiffrence * 1.5 *  float2((1.0 / 5360), (1.0 / 1440)).x;
else
ParallaxCoord.x -= DepthDiffrence * 1.5 *  float2((1.0 / 5360), (1.0 / 1440)).x;
}
return ParallaxCoord;
}
#line 1586
float4 saturation(float4 C)
{
float greyscale = dot(C.rgb, float3(0.2125, 0.7154, 0.0721));
return lerp(greyscale.xxxx, C, (Saturation + 1.0));
}
#line 1595
void LR_Out(float4 position : SV_Position, float2 texcoord : TEXCOORD, out float4 Left : SV_Target0, out float4 Right : SV_Target1)
#line 1597
{   float2 StoreTC = texcoord; 
#line 1599
float fov = FoV-(FoV*0.2), F = -fov + 1,HA = (F - 1)*(5360*0.5)* float2((1.0 / 5360), (1.0 / 1440)).x;
#line 1601
float2 Z_A = float2(1.0,1.0); 
if(!Theater_Mode)
{
Z_A = float2(1.0,0.5); 
texcoord.x = (texcoord.x*F)-HA;
}
#line 1608
float X = Z_A.x;
float Y = Z_A.y * Z_A.x * 2;
float midW = (X - 1)*(5360*0.5)* float2((1.0 / 5360), (1.0 / 1440)).x;
float midH = (Y - 1)*(1440*0.5)* float2((1.0 / 5360), (1.0 / 1440)).y;
#line 1613
texcoord = float2((texcoord.x*X)-midW,(texcoord.y*Y)-midH);
#line 1615
float2 TCL = texcoord,TCR = texcoord;
#line 1617
TCL.x -=  IPD *  float2((1.0 / 5360), (1.0 / 1440)).x*0.5f;
TCR.x +=  IPD *  float2((1.0 / 5360), (1.0 / 1440)).x*0.5f;
#line 1620
float D = Divergence;
#line 1622
float FadeIO = smoothstep(0,1,1-Fade_in_out(texcoord).x), FD = D, FD_Adjust = 0.1;
#line 1624
if( Eye_Fade_Reduction_n_Power.y == 1)
FD_Adjust = 0.2;
else if( Eye_Fade_Reduction_n_Power.y == 2)
FD_Adjust = 0.3;
#line 1629
if (FPSDFIO == 1 || FPSDFIO == 2)
FD = lerp(FD * FD_Adjust,FD,FadeIO);
#line 1632
float2 DLR = float2(FD,FD);
if( Eye_Fade_Reduction_n_Power.x == 1)
DLR = float2(D,FD);
else if( Eye_Fade_Reduction_n_Power.x == 2)
DLR = float2(FD,D);
#line 1651
Left =  saturation(float4(MouseCursor( Parallax(-DLR.x, TCL)).rgb,1.0)) ; 
Right = saturation(float4(MouseCursor( Parallax( DLR.y, TCR)).rgb,1.0)) ;
#line 1658
}
#line 1660
float4 Circle(float4 C, float2 TC)
{
if(Barrel_Distortion == 2)
discard;
#line 1665
float2 C_A = float2(1.0f,1.1375f), midHV = (C_A-1) * float2(5360 * 0.5,1440 * 0.5) *  float2((1.0 / 5360), (1.0 / 1440));
#line 1667
float2 uv = float2(TC.x,TC.y);
#line 1669
uv = float2((TC.x*C_A.x)-midHV.x,(TC.y*C_A.y)-midHV.y);
#line 1671
float borderA = 2.5; 
float borderB = 0.003;
float circle_radius = 0.55; 
float4 circle_color = 0; 
float2 circle_center = 0.5; 
#line 1677
uv -= circle_center;
#line 1679
float dist =  sqrt(dot(uv, uv));
#line 1681
float t = 1.0 + smoothstep(circle_radius, circle_radius+borderA, dist)
- smoothstep(circle_radius-borderB, circle_radius, dist);
#line 1684
return lerp(circle_color, C,t);
}
#line 1687
float Vignette(float2 TC)
{   float CalculateV = lerp(1.0,0.25,smoothstep(0,1, Motion_Blinders(TC) ));
float2 IOVig = float2(CalculateV * 0.75,CalculateV),center = float2(0.5,0.5); 
float distance = length(center-TC),Out = 0;
#line 1692
if(Blinders > 0)
Out = 1-saturate((IOVig.x-distance) / (IOVig.y-IOVig.x));
return Out;
}
#line 1697
float3 L(float2 texcoord)
{
#line 1702
float3 Left = tex2D(SamplerLeft,texcoord).rgb;
#line 1704
return lerp(Left,0,Vignette(texcoord));
}
#line 1707
float3 R(float2 texcoord)
{
#line 1712
float3 Right = tex2D(SamplerRight,texcoord).rgb;
#line 1714
return lerp(Right,0,Vignette(texcoord));
}
#line 1717
float2 BD(float2 p, float k1, float k2) 
{
if(!Barrel_Distortion)
discard;
#line 1722
p = (2.0f * p - 1.0f) / 1.0f;
#line 1724
if(!Theater_Mode)
p *= 0.83;
else
p *= 0.8;
#line 1729
float r2 = p.x*p.x + p.y*p.y;
float r4 = pow(r2,2);
#line 1732
float x2 = p.x * (1.0 + k1 * r2 + k2 * r4);
float y2 = p.y * (1.0 + k1 * r2 + k2 * r4);
#line 1735
p.x = (x2 + 1.0) * 1.0 / 2.0;
p.y = (y2 + 1.0) * 1.0 / 2.0;
#line 1738
if(!Theater_Mode)
{
#line 1741
float C_A1 = 0.45f, C_A2 = C_A1 * 0.5f, C_B1 = 0.375f, C_B2 = C_B1 * 0.5f, C_C1 = 0.9375f, C_C2 = C_C1 * 0.5f;
if(length(p.xy*float2(C_A1,1.0f)-float2(C_A2,0.5f)) > 0.5f)
p = 1000;
else if(length(p.xy*float2(1.0f,C_B1)-float2(0.5f,C_B2)) > 0.5f)
p = 1000;
else if(length(p.xy*float2(C_C1,1.0f)-float2(C_C2,0.5f)) > 0.625f)
p = 1000;
}
#line 1750
return p;
}
#line 1753
float3 YCbCrLeft(float2 texcoord)
{
return RGBtoYCbCr(L(texcoord));
}
#line 1758
float3 YCbCrRight(float2 texcoord)
{
return RGBtoYCbCr(R(texcoord));
}
#line 1763
float3 PS_calcLR(float2 texcoord)
{
float2 gridxy = floor(float2(texcoord.x * 5360, texcoord.y * 1440)), TCL = float2(texcoord.x * 2,texcoord.y), TCR = float2(texcoord.x * 2 - 1,texcoord.y), uv_redL, uv_greenL, uv_blueL, uv_redR, uv_greenR, uv_blueR;
float4 color, Left, Right, color_redL, color_greenL, color_blueL, color_redR, color_greenR, color_blueR;
float K1_Red = Polynomial_Colors_K1.x, K1_Green = Polynomial_Colors_K1.y, K1_Blue = Polynomial_Colors_K1.z;
float K2_Red = Polynomial_Colors_K2.x, K2_Green = Polynomial_Colors_K2.y, K2_Blue = Polynomial_Colors_K2.z;
float Y_Left, Y_Right, CbCr_Left, CbCr_Right, CbCr;
#line 1771
if(Barrel_Distortion == 0 ||   0 == 1)
{   if(!  0)
{   
if(  0)
{
Left.rgb = tex2D(BackBufferCLAMP,texcoord).rgb;
#line 1778
}
else
{
Left.rgb = L(TCL).rgb;
Right.rgb = R(TCR).rgb;
}
}
else 
{
Y_Left = YCbCrLeft(texcoord).x;
Y_Right = YCbCrRight(texcoord).x;
#line 1790
CbCr_Left = texcoord.x < 0.5 ? YCbCrLeft(texcoord * 2).y : YCbCrLeft(texcoord * 2 - float2(1,0)).z;
CbCr_Right = texcoord.x < 0.5 ? YCbCrRight(texcoord * 2 - float2(0,1)).y : YCbCrRight(texcoord * 2 - 1 ).z;
#line 1793
CbCr = texcoord.y < 0.5 ? CbCr_Left : CbCr_Right;
}
}
else
{
uv_redL = BD(TCL.xy,K1_Red,K2_Red);
uv_greenL = BD(TCL.xy,K1_Green,K2_Green);
uv_blueL = BD(TCL.xy,K1_Blue,K2_Blue);
#line 1802
color_redL = L(uv_redL).r;
color_greenL = L(uv_greenL).g;
color_blueL = L(uv_blueL).b;
#line 1806
Left = float4(color_redL.x, color_greenL.y, color_blueL.z, 1.0);
#line 1808
uv_redR = BD(TCR.xy,K1_Red,K2_Red);
uv_greenR = BD(TCR.xy,K1_Green,K2_Green);
uv_blueR = BD(TCR.xy,K1_Blue,K2_Blue);
#line 1812
color_redR = R(uv_redR).r;
color_greenR = R(uv_greenR).g;
color_blueR = R(uv_blueR).b;
#line 1816
Right = float4(color_redR.x, color_greenR.y, color_blueR.z, 1.0);
}
#line 1819
if(!overlay_open || NCAOC)
{
if(!  0)
{
if(Barrel_Distortion == 1) 
color = texcoord.x < 0.5 ? Circle(Left,float2(texcoord.x*2,texcoord.y)) : Circle(Right,float2(texcoord.x*2-1,texcoord.y));
else
color =    0 ? Left : texcoord.x < 0.5 ? Left : Right;
}
else
{	
color.rgb = float3(Y_Left,Y_Right,CbCr);
}
}
else
{
color.rgb =   0 ? Left.rgb : fmod(gridxy.x+gridxy.y,2) ? R(texcoord) : L(texcoord);
}
#line 1838
if (BD_Options == 2 || Alinement_View)
color.rgb = dot(0.5-tex2D(BackBuffer,texcoord).rgb,0.333) / float3(1,tex2D(SamplerzBufferVR_L,texcoord).x,1);
#line 1841
return color.rgb;
}
#line 1844
float Past_BufferVR(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
return tex2D(SamplerDMVR,texcoord).w;
}
#line 1849
void Average_Luminance(float4 position : SV_Position, float2 texcoord : TEXCOORD, out float4 AL : SV_Target0, out float Other : SV_Target1)
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
#line 1861
float Average_Lum_ZPD = PrepDepth(float2(ABEA.x + texcoord.x * ABEA.y, ABEA.z + texcoord.y * ABEA.w))[0][0], Average_Lum_Bottom = PrepDepth( texcoord )[0][0];
#line 1863
const int Num_of_Values = 6; 
float Storage__Array[Num_of_Values] = { tex2D(SamplerDMVR,0).x,                
tex2D(SamplerDMVR,1).x,                
tex2D(SamplerDMVR,int2(0,1)).x,        
tex2D(SamplerDMVR,int2(1,0)).x,        
tex2D(SamplerzBufferVR_P,1).y,         
tex2D(SamplerzBufferVR_P,int2(0,1)).y};
#line 1871
float Grid = floor(texcoord.y * 1440 * (1.0 / 1440) * Num_of_Values);
#line 1873
AL = float4(Average_Lum_ZPD,Average_Lum_Bottom,Storage__Array[int(fmod(Grid,Num_of_Values))],tex2Dlod(SamplerDMVR,float4(texcoord,0,0)).y);
Other = length(tex2D(SamplerDMVR,texcoord).w - tex2D(SamplerPBBVR,texcoord).x);
}
#line 1878
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
#line 1899
float getBit( float map, float index )
{   
return fmod( floor( map * exp2(-index) ), 2.0 );
}
#line 1904
float drawChar( float Char, float2 pos, float2 size, float2 TC )
{   
TC -= pos;
#line 1908
TC /= size;
#line 1910
float res = step(0.0,min(TC.x,TC.y)) - step(1.0,max(TC.x,TC.y));
#line 1912
TC *=  float2(4,5);
#line 1914
res*=getBit( Char, 4.0*floor(TC.y) + floor(TC.x) );
return saturate(res);
}
#line 1918
float3 Out(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
float2 TC = float2(texcoord.x,1-texcoord.y);
float Menu_Open = overlay_open ? 1 : 0 , Text_Timer = 25000, BT = smoothstep(0,1,sin(timer*(3.75/1000))), Size = 1.1, Depth3D, Read_Help, Supported, SetFoV, FoV, Post, Effect, NoPro, NotCom, Mod, Needs, Net, Over, Set, AA, Emu, Not, No, Help, Fix, Need, State, SetAA, SetWP, Work;
float3 Color = PS_calcLR(texcoord).rgb, SBS_3D = float3(1,0,0), Super3D = float3(0,0,1);
#line 1924
float3 Format = !  0 ? SBS_3D : Super3D;
#line 1926
float2 ScreenPos = float2(1-texcoord.x,1-texcoord.y) *  float2(5360, 1440);
float Debug_Y = 1.0;
if(all(abs(float2(1.0,1440)-ScreenPos.xy) < float2(1.0,Debug_Y)))
Color = Menu_Open ? Format : 0;
if(all(abs(float2(3.0,1440)-ScreenPos.xy) < float2(1.0,Debug_Y)))
Color = Menu_Open ? 0 : Format;
if(all(abs(float2(5.0,1440)-ScreenPos.xy) < float2(1.0,Debug_Y)))
Color = Menu_Open ? Format : 0;
#line 1935
if( Read_Help_Warning_D             ||  Not_Compatible_Warning_D        ||  1  ||  Needs_Fix_Mod_D                 ||  Disable_Post_Effects_Warning_D  ||  Depth_Selection_Warning_D       ||  0 ||  Disable_Anti_Aliasing_D         ||  Network_Warning_D               ||  Weapon_Profile_Warning_D        ||  Set_Game_FoV_D                  ||  Emulator_Detected_Warning_D    )
Text_Timer = 30000;
#line 1938
[branch] if(timer <= Text_Timer || Text_Info)
{ 
float2 charSize = float2(.00875, .0125) * Size;
#line 1942
float2 charPos = float2( 0.009, 0.9725);
#line 1944
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
#line 1984
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
#line 2018
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
#line 2047
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
#line 2072
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
#line 2105
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
#line 2125
charPos = float2( 0.009, 0.8675);
SetFoV += drawChar( CH_S, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_E, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_T, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_BLNK, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_F, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_O, charPos, charSize, TC); charPos.x += .01 * Size;
SetFoV += drawChar( CH_V, charPos, charSize, TC);
#line 2134
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
#line 2145
charPos = float2( 0.009, 0.018);
#line 2147
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
#line 2158
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
#line 2172
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
#line 2186
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
#line 2208
float D3D_Size_A = 1.375,D3D_Size_B = 0.75;
float2 charSize_A = float2(.00875, .0125) * D3D_Size_A, charSize_B = float2(.00875, .0125) * D3D_Size_B;
#line 2211
charPos = float2( 0.862, 0.018);
#line 2213
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
#line 2227
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
#line 2244
if( 1 )
No = NoPro * BT;
if( Not_Compatible_Warning_D       )
Not = NotCom * BT;
if( Needs_Fix_Mod_D                )
Fix = Mod * BT;
if( 0)
Over = State * BT;
#line 2253
float3 WebInfo = Depth3D+Help+Post+No+Not+Net+Fix+Need+Over+AA+Set+FoV+Emu;
return (  0 ? float3(WebInfo.rg,0) : WebInfo) ? (1-texcoord.y*50.0+48.85)*texcoord.y-0.500 : Color;
}
else
return Color;
}
#line 2263
float normpdf3(in float3 v, in float sigma)
{
return 0.39894*exp(-0.5*dot(v,v)/(sigma*sigma))/sigma;
}
#line 2268
float LI(float3 RGB)
{
return dot(RGB,float3(0.2126, 0.7152, 0.0722));
}
#line 2273
float3 SmartSharp(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{   float Sharp_This = overlay_open ? 0 : Sharpen_Power,mx, mn;
float2 tex_offset =  float2((1.0 / 5360), (1.0 / 1440)); 
float3 c = tex2D(BackBuffer, texcoord).rgb;
if(Sharp_This > 0)
{
#line 2280
const int kSize =  3 * 0.5; 
#line 2282
float3 final_color, cc;
float2 RPC_WS =  float2((1.0 / 5360), (1.0 / 1440)) * 1.5;
float Z, factor;
#line 2286
[loop]
for (int i=-kSize; i <= kSize; ++i)
{
for (int j=-kSize; j <= kSize; ++j)
{
cc = tex2Dlod(BackBuffer, float4(texcoord.xy + float2(i,j) * RPC_WS * rcp(kSize * 2.0f),0,0)).rgb;
factor = normpdf3(cc-c,  0.25);
Z += factor;
final_color += factor * cc;
}
}
#line 2298
final_color = saturate(final_color/Z);
#line 2300
mn = min( min( LI(c), LI(final_color)), LI(cc));
mx = max( max( LI(c), LI(final_color)), LI(cc));
#line 2304
float rcpM = rcp(mx), CAS_Mask;
#line 2307
CAS_Mask = saturate(min(mn, 2.0 - mx) * rcpM);
#line 2309
float3 Sharp_Out = c + (c - final_color) * Sharp_This;
#line 2311
c =   0 ? lerp(c,float3(Sharp_Out.rg,c.b),CAS_Mask) : lerp(c,Sharp_Out,CAS_Mask);
}
#line 2314
return c;
}
#line 2317
void PostProcessVS(in uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD)
{
texcoord.x = (id == 2) ? 2.0 : 0.0;
texcoord.y = (id == 1) ? 2.0 : 0.0;
position = float4(texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 2325
technique SuperDepth3D_VR
< ui_tooltip = "Suggestion : Please enable 'Performance Mode Checkbox,' in the lower bottom right of the ReShade's Main UI.\n"
"             Do this once you set your 3D settings of course."; >
{
#line 2343
pass DepthBuffer
{
VertexShader = PostProcessVS;
PixelShader = DepthMap;
RenderTarget0 = texDMVR;
}
pass zbufferVR
{
VertexShader = PostProcessVS;
PixelShader = zBuffer;
RenderTarget0 = texzBufferVR_P;
RenderTarget1 = texzBufferVR_L;
}
pass StereoBuffers
{
VertexShader = PostProcessVS;
PixelShader = LR_Out;
#line 2363
RenderTarget0 = LeftTex;
RenderTarget1 = RightTex;
#line 2366
}
pass StereoOut
{
VertexShader = PostProcessVS;
PixelShader = Out;
}
#line 2373
pass USMOut
{
VertexShader = PostProcessVS;
PixelShader = SmartSharp;
}
#line 2379
pass AverageLuminance
{
VertexShader = PostProcessVS;
PixelShader = Average_Luminance;
RenderTarget0 = texLumVR;
RenderTarget1 = texOtherVR;
}
pass PastBBVR
{
VertexShader = PostProcessVS;
PixelShader = Past_BufferVR;
RenderTarget = texPBVR;
}
}

