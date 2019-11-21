/////////////////////////////////////////////////////////////////////////////////
/// FlyPiScope... v0.97; 2016 10  ///
/// Collaboration Tom Baden, Lucia Prieto Godino and Andre Maia Chagas
/// 3D model by Tom Baden (thingyverse ID: badenlab) ///
/// t.baden@sussex.ac.uk ///
/// www.badenlab.org ///
/////////////////////////////////////////////////////////////////////////////////
//// SWITCHES //////////
PartA = 	1; // Base
PartB= 	1; // Wall
PartC= 	1; // Lid
PartD= 	1; // Cam Mount Cogwheels

PartB3=1; // fritzing holder
PartF1=1; // stick
PartJ1=1; // mini petri dish holder
PartK=1; // diffusor mount

Orient_flat = 0;

/////////////////////////////////////////////////////////////////////////////////
///// KEY VARIABLES ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
sep = 40; // How far apart do pieces "float" in the model
Walls = 5; // Global thickness of all walls
Tol = 0.15; // Global gap between all parts that need to slide

// Base and mainwall details
T_cableZ = 4; // Module A, height of thermistor cable slid
T_cableY = 12; // Module A,width of thermistor cable slid
T_cable_offset = 8; // Module A, lateral displacement of thermistor cable slid
MarkerLED_R = 3+Tol; // Module A, radius of RGB LED hole in base
MarkerLED_Z = 2; // Module A, depth beneath surface
MarkerLED_XY = 4; // Module A, viewhole size
Sidestand = 70; // Module A, extension in X dimension at the back of the base
Sidestand_thickness = Walls; // Module A, thickness of extension at back of base
Borders = 15; // Module B, thickness of borders on the back (saves plastic)
Walls_thinning = 4; // Module B, how much thinner than "Walls" is thin part (saves plastic)

//Peltier dimensions
P_XY = 40+1; // Size of the Peltier
P_Z = 3; // Thickness of the Peltier
P_border = 12; // Extension in X dimension of base next to Peltier
P_ridge = 2; // below Peltier, width of ridge
P_cable = 3; // thickness of Peltier cable slid

//Raspberry Pi type (mounting parameters)
RPi_Width = 56+Walls*2; // Dimensions of the RPi 2 (below also for RPi 2)
RPi_groundZ = 17; // 65; for RPi B (not RPi B+)
RPi_holedist_Y = 49/2; // 15.5; // for RPi B (not RPi B+)
RPi_holedist_Yb = 49/2; //-10; // for RPi B (not RPi B+)
RPi_holedist_Z = 58; //54.5; // for RPi B (not RPi B+)
Tube_wall = 1.5;
S_hole_R = 1.5;
S_mount_R = 4;
Mount_h = 19; // RPi2 mount

// RPi Camera Type
Cam_X = 32.2;//24 for "classic RPi Cam. i.e the one without the adjustable focus lens";
Cam_Y = 32.2;//25 for "classic RPi Cam";
Cam_X_offset = 0;// 2.5 for "classic RPi Cam";
C_Z = 2; // thickness of camera mount
C_Z2 = 5; // thickness of cmaera mount walls
C_ridge = 2; // width of ridge for camera mount
CamGroove_X = 20;
CamGroove_Y = 16;
CamGroove2_Y = 24;


/////////////////////////////////////////////////////////////////////////////////
/// MODULE A - base   //////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

A_Base_X = P_XY+P_border*2 + Walls + Sidestand;
A_Base_Y = RPi_Width;
Extension_Y = 6;
Sidecut_Extra = 5;
A_Base_Z = 40;
A_Wall_X = Walls;
A_Wall_Y = A_Base_Y;
A_Wall_Y_long = 10;
A_Wall_Z = RPi_groundZ+RPi_holedist_Z+25;
A_Wall_Z_long = 115+Walls;
A_extramount_Z = 100;
Stabiliser_R = 12;
Airhole_R = 6;
Airhole_spacing = 13;
A1_screw_R = 1.5;
A1_offset = 3;

Servo_Y = 12.2;
Servo_X = 23.7;
Servo_X_offset = 5.5;
Servo_Z=12; // the total height under the ledges is 15 mm

SaveMat = 9;

module A(){
	translate([-A_Base_X/2+P_XY/2+P_border,0,-A_Base_Z/2]){cube([A_Base_X,A_Base_Y,A_Base_Z], center = true );} // BASE
	translate([-A_Base_Y/2+P_XY/2+P_border,-Extension_Y/2,-A_Base_Z/2]){cube([A_Base_Y,A_Base_Y+Extension_Y,A_Base_Z], center = true );} // BASE extension
}
module A_sub(){
	translate([0,-Walls/2+Servo_Y/2+2,-A_Base_Z/2+Walls+1.5+5]){cube([A_Base_Y-Walls*2,A_Base_Y-Walls-Servo_Y-2,A_Base_Z], center = true );} // Main hole
	translate([0,-Extension_Y/2,-A_Base_Z/2+Walls+Servo_Z]){cube([A_Base_Y-Walls*2,A_Base_Y-Walls*2+Extension_Y,A_Base_Z], center = true );} // Main high

	translate([-A_Base_Y/2+SaveMat/2+Walls,-Extension_Y/2,-A_Base_Z/2+Walls/2]){cube([SaveMat,A_Base_Y-Walls*2+Extension_Y,A_Base_Z], center = true );} // Save material 1
	translate([+A_Base_Y/2-SaveMat/2-Walls,-Extension_Y/2,-A_Base_Z/2+Walls/2]){cube([SaveMat,A_Base_Y-Walls*2+Extension_Y,A_Base_Z], center = true );} // Save material 2
	translate([0,+A_Base_Y/2-SaveMat/2-Walls+1,-A_Base_Z/2+Walls/2]){cube([A_Base_Y-Walls*2,SaveMat,A_Base_Z], center = true );} // Save material 3

	translate([-A_Base_X/2-Walls,0,-A_Base_Z/2]){cube([Sidestand-Walls*3,A_Base_Y-Walls*2,A_Base_Z], center = true );} // Sidestand Hole
	translate([-A_Base_X/2-Walls/2-Walls+Sidecut_Extra/2,0,-A_Base_Z/2+Sidestand_thickness]){cube([Sidestand-Walls*2+Sidecut_Extra,A_Base_Y,A_Base_Z], center = true );} // Sidestand Hole shallow
	translate([-P_XY/2-P_border-Walls/2,0,-A_Base_Z/2]){cube([Walls+Tol*2,A_Base_Y-Walls*4,A_Base_Z], center = true );} // Wall_linkhole
	
      translate([Airhole_spacing,35,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R, h = 20, center = true );}} // Air holes
	translate([0,35,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R, h = 20, center = true );}} // Air holes
	translate([-Airhole_spacing,35,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R, h = 20, center = true );}} // Air holes
	translate([35,0,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([0,90,0]) {cylinder(r = Airhole_R, h = 20, center = true );}} // Air holes
	translate([35,-Airhole_spacing,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([0,90,0]) {cylinder(r = Airhole_R, h = 20, center = true );}} // Air holes
	translate([35,Airhole_spacing,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([0,90,0]) {cylinder(r = Airhole_R, h = 20, center = true );}} // Air holes

	translate([Cam_X_offset,0,0]){cube([Cam_X-C_ridge*2,Cam_Y-C_ridge*2,100], center = true );} // Cam_hole
      translate([Cam_X_offset,0,-A_Base_Z+C_Z/2+Walls+5]){cube([Cam_X+Tol*2,Cam_Y+Tol*2,C_Z], center = true );} // Cam_hole_ridge

 	translate([-30,0,-A_Base_Z+C_Z/2+Walls*2+5]){cube([50,20,C_Z], center = true );} // Cam cable hole

      translate([+Cam_X_offset+Servo_X_offset,-Servo_Y/2-Cam_Y/2-Walls,0]){cube([Servo_X+Tol,Servo_Y+Tol,100], center = true );} // Servo_hole
      translate([+Cam_X_offset+Servo_X_offset-Servo_X/2,-Servo_Y/2-Cam_Y/2-Walls,0]){cylinder( $fn=50, r = 4, h = 100, center = true );} // Servo_cablegroove
translate([+Cam_X_offset+Servo_X_offset-Servo_X/2-4,-Servo_Y/2-Cam_Y/2-Walls,0]){cylinder( $fn=50, r = 4, h = 100, center = true );} // Servo_cablegroove2

translate([-50,-Servo_Y/2-Cam_Y/2-Walls,-17])rotate([0,90,0]){{cylinder( $fn=50, r = 3, h = 100, center = true );}} // Servo_cablegroove3

   translate([+Cam_X_offset,-Servo_Y/2-Cam_Y/2-Walls,-6]){cylinder( $fn=50, r = 20, h = 30, center = true );} // Cogwheel sidecut

}




if (PartA==1){
	difference(){A();A_sub();}
	translate([0,0,-A_Base_Z/2]){difference(){A2();A2_sub();}}
}


/////////////////////////////////////////////////////////////////////////////////
///// MODULE B - main wall //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

module B(){
	translate([-P_XY/2-P_border-A_Wall_X/2,0,A_Wall_Z/2+sep]){cube([A_Wall_X,A_Wall_Y,A_Wall_Z], center = true );} // WALL
	translate([-P_XY/2-P_border-A_Wall_X/2,0,0.5+sep-A_Base_Z/6]){cube([Walls,A_Base_Y-Walls*4-Tol*2,A_Base_Z/3], center = true );} // WALL_link

	
	translate([-P_XY/2-P_border-A_Wall_X/2,0,A_Wall_Z_long/2+sep]){cube([A_Wall_X,A_Wall_Y,A_Wall_Z_long], center = true );} // WALL_extra

}
module B2(){
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h,RPi_holedist_Yb,RPi_groundZ+sep]){rotate ([0,90,0]) {cylinder(r = S_mount_R, h = Mount_h, center = true );}} // m hole_bottom
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h,RPi_holedist_Y,RPi_groundZ+RPi_holedist_Z+sep]){rotate ([0,90,0]) {cylinder(r = S_mount_R, h = Mount_h, center = true );}} // m hole_top
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h,-RPi_holedist_Yb,RPi_groundZ+sep]){rotate ([0,90,0]) {cylinder(r = S_mount_R, h = Mount_h, center = true );}} // m hole_bottom
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h,-RPi_holedist_Y,RPi_groundZ+RPi_holedist_Z+sep]){rotate ([0,90,0]) {cylinder(r = S_mount_R, h = Mount_h, center = true );}} // m hole_top
}
module B_sub(){

	translate([-P_XY/2-P_border-A_Wall_X/2,A_Wall_Y_long+Tol,A_Wall_Z_long/2+A_Wall_Z/2+sep]){cube([A_Wall_X,A_Wall_Y_long,A_Wall_Z_long-A_Wall_Z], center = true );} // WALL_topcut1
	translate([-P_XY/2-P_border-A_Wall_X/2,-A_Wall_Y_long-Tol,A_Wall_Z_long/2+A_Wall_Z/2+sep]){cube([A_Wall_X,A_Wall_Y_long,A_Wall_Z_long-A_Wall_Z], center = true );} // WALL_topcut2



	translate([-P_XY/2-P_border-A_Wall_X/2-(Walls-Walls_thinning)/2,0,A_Wall_Z/2+sep]){cube([Walls_thinning,A_Wall_Y-Borders,A_Wall_Z-Borders], center = true );} // Save Material	


}
module B2_sub(){
	translate([-P_XY/2-P_border+Walls-Mount_h,RPi_holedist_Yb,RPi_groundZ+sep]){rotate ([0,90,0]) {cylinder($fn = 50, r = S_hole_R, h = Mount_h+Walls, center = true );}} // m hole_bottom
	translate([-P_XY/2-P_border+Walls-Mount_h,RPi_holedist_Y,RPi_groundZ+RPi_holedist_Z+sep]){rotate ([0,90,0]) {cylinder($fn = 50, r = S_hole_R, h = Mount_h+Walls, center = true );}} // 
	translate([-P_XY/2-P_border+Walls-Mount_h,-RPi_holedist_Yb,RPi_groundZ+sep]){rotate ([0,90,0]) {cylinder($fn = 50, r = S_hole_R, h = Mount_h+Walls, center = true );}} // m hole_bottom
	translate([-P_XY/2-P_border+Walls-Mount_h,-RPi_holedist_Y,RPi_groundZ+RPi_holedist_Z+sep]){rotate ([0,90,0]) {cylinder($fn = 50, r = S_hole_R, h = Mount_h+Walls, center = true );}} // 
}
if (PartB==1){rotate([0,90*Orient_flat,0]){difference(){B();B_sub();}}}
if (PartB==1){rotate([0,90*Orient_flat,0]){difference(){B2();B2_sub();}}}

/////////////////////////////////////////////////////////////////////////////////
/// MODULE C - LID   //////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

R_Mainhole = 15;
H_coglink = 6;
R_coglink = 1.5;


Emiss_pivot_hole_R = 3;
Emiss_pivot_hole_offset = 15;


module C(){
	translate([-A_Base_Y/2+P_XY/2+P_border+1,-Extension_Y/2,sep+Walls/4]){cube([A_Base_Y-2,A_Base_Y+Extension_Y,Walls/2], center = true );} // LID
      translate([0,-Extension_Y/2,sep-Walls/4]){cube([A_Base_Y-Walls*2,A_Base_Y-Walls*2+Extension_Y,Walls/2], center = true );} // LID inner
	translate([+Cam_X_offset,-Servo_Y/2-Cam_Y/2-Walls,sep-Walls/4-H_coglink/2-Walls/4]){cylinder( $fn=50, r = R_coglink, h = H_coglink, center = true );} // CogLink
}
module C_sub(){
      translate([0,0,0]){cylinder( $fn=100, r = R_Mainhole, h = 100, center = true );} // Hole
 	//translate([-P_XY/2-P_border-A_Wall_X/2,0,sep]){cube([A_Wall_X+Tol,A_Wall_Y+Tol,7], center = true );} // wallcut
	translate([+Cam_X_offset,-Servo_Y/2-Cam_Y/2-Walls,sep-Walls/4-H_coglink/2-Walls/4]){cylinder( $fn=50, r = 1, h = 50, center = true );} // CogLink
	translate([0,-Emiss_pivot_hole_offset-1,sep]){rotate ([0,0,0]) {cylinder($fn = 50, r = Emiss_pivot_hole_R, h = 50, center = true );}} // Wheel_peg		

}

if (PartC==1){
	translate([sep,0,0]){rotate([0,Orient_flat*180,0]){difference(){C();C_sub();}}}
}






/////////////////////////////////////////////////////////////////////////////////
///// MODULE D - cogs ////
/////////////////////////////////////////////////////////////////////////////////

// height of Servo is 29 in total, which is counted from the bottom
cogwheel_R = 14.1;
cogwheel_R2 = 10.5;
cogwheel_Z = 10;
cogwheel_Z2 = 4;
cogwheel_nteeth = 30; // should be divisible by 3
cogwheel_R_inner1 = 7+Tol; // camera radius
cogwheel_R_inner2 = 3.7+Tol/2; // servo axis radius
cogwheel_cross_Z = 3;
cogwheel_cross_Width = 4.5+Tol;
cogwheel_cross_Length = cogwheel_R2*2-1;
cogwheel_Zoffset = 13;



module D(){
      for (i = [0 : cogwheel_nteeth/3]) {
		translate([Cam_X_offset,0,cogwheel_Zoffset-2*sep]){rotate ([0,0,(i+0.5)*360/cogwheel_nteeth]) {cylinder($fn = 3, r = cogwheel_R, h = cogwheel_Z, center = true );}} // cogs wheel 1
		translate([Cam_X_offset,-Servo_Y/2-Cam_Y/2-Walls,cogwheel_Zoffset-2*sep]){rotate ([0,0,i*360/cogwheel_nteeth]) {cylinder($fn = 3, r = cogwheel_R, h = cogwheel_Z, center = true );}} // cogs wheel 2
	}
}
module D_sub(){
	translate([Cam_X_offset,0,cogwheel_Zoffset-2*sep]){rotate ([0,0,0]) {cylinder($fn = 50, r = cogwheel_R_inner1, h = cogwheel_Z+1, center = true );}} // Cam_cog Lens hole 
	translate([Cam_X_offset,0,cogwheel_Zoffset-2*sep+cogwheel_Z2/2+1]){rotate ([0,0,0]) {cylinder($fn = 50, r = cogwheel_R2, h = cogwheel_Z-cogwheel_Z2+1, center = true );}} // Cam_cog main hole
	
	translate([Cam_X_offset,-Servo_Y/2-Cam_Y/2-Walls,cogwheel_Zoffset-2*sep+cogwheel_Z2/2+1]){rotate ([0,0,0]) {cylinder($fn = 50, r = cogwheel_R2, h = cogwheel_Z - cogwheel_Z2+1, center = true );}} // Servo_cog main hole
	translate([Cam_X_offset,-Servo_Y/2-Cam_Y/2-Walls,cogwheel_Zoffset-2*sep]){rotate ([0,0,0]) {cylinder($fn = 12, r = cogwheel_R_inner2, h = cogwheel_Z+1, center = true );}} // Servo_cog mount hole
	translate([Cam_X_offset,-Servo_Y/2-Cam_Y/2-Walls,cogwheel_Zoffset-2*sep-cogwheel_cross_Z/2]){cube([cogwheel_cross_Length,cogwheel_cross_Width,cogwheel_cross_Z], center = true);} // Servo_cog cross1
	translate([Cam_X_offset,-Servo_Y/2-Cam_Y/2-Walls,cogwheel_Zoffset-2*sep-cogwheel_cross_Z/2]){cube([cogwheel_cross_Width,cogwheel_cross_Length,cogwheel_cross_Z], center = true);} // Servo_cog cross2

}
if (PartD==1){rotate([0,180*(1-Orient_flat),0]){difference(){D();D_sub();}}}

/////////////////////////////////////////////////////////////////////////////////
///// MODULE B3 - Arduino/Fritzing holder ////////
/////////////////////////////////////////////////////////////////////////////////

Fritzing_X = 1.65;
Fritzing_Y = 76.75;
Fritzing_Z_depth = 3;
Mount2_h = 25;
Mount2_Z = 4;
Ard_holder_X = Walls*2 + Fritzing_X;
Ard_holder_Y = Fritzing_Y + 2*Walls;
Ard_z_extra = 5;
Ard_holder_Z = 2*S_mount_R+Ard_z_extra;
Foot_Z_extra = 2;
LShape_Length = 6;
LShape_Width = 3;

module B3(){
	translate([-P_XY/2-P_border-Ard_holder_X/2-2*sep,0,RPi_groundZ+sep+Ard_z_extra/2]){cube([Ard_holder_X,Ard_holder_Y,Ard_holder_Z], center = true );} // Holder
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h-2*sep+Mount2_h/2,RPi_holedist_Yb,RPi_groundZ+sep-S_mount_R/2+Foot_Z_extra/2]){cube([Mount2_h,S_mount_R*2,S_mount_R+Foot_Z_extra], center = true );} // foot
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h-2*sep+Mount2_h/2,-RPi_holedist_Yb,RPi_groundZ+sep-S_mount_R/2+Foot_Z_extra/2]){cube([Mount2_h,S_mount_R*2,S_mount_R+Foot_Z_extra], center = true );} // foot
}
module B3_sub(){
	translate([-P_XY/2-P_border-Ard_holder_X/2-2*sep,0,RPi_groundZ+Ard_holder_Z/2-Fritzing_Z_depth/2+sep]){cube([Fritzing_X+Tol,Fritzing_Y+2*Tol,Fritzing_Z_depth+Ard_z_extra], center = true );} // slot
	translate([-P_XY/2-P_border-Ard_holder_X/2-2*sep,0,RPi_groundZ+sep+Ard_holder_Z/2]){cube([Ard_holder_X,Fritzing_Y-2,Ard_z_extra], center = true );} // Holder
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h-2*sep+Mount2_h/2,RPi_holedist_Yb,RPi_groundZ+sep]){rotate ([0,90,0]) {cylinder(r = S_hole_R, h = Mount2_h+5, center = true );}} // m hole_bottom
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h-2*sep+Mount2_h/2,-RPi_holedist_Yb,RPi_groundZ+sep]){rotate ([0,90,0]) {cylinder(r = S_hole_R, h = Mount2_h+5, center = true );}} // m hole_bottom
    translate([-P_XY/2-P_border+1.7*Walls-Mount_h-2*sep+Mount2_h-LShape_Length/2,RPi_holedist_Yb-S_mount_R+LShape_Width/2,RPi_groundZ+sep-S_mount_R/2+Foot_Z_extra/2]){cube([LShape_Length,LShape_Width,S_mount_R+Foot_Z_extra], center = true );} // L-Shape
	translate([-P_XY/2-P_border+1.7*Walls-Mount_h-2*sep+Mount2_h-LShape_Length/2,-RPi_holedist_Yb+S_mount_R-LShape_Width/2,RPi_groundZ+sep-S_mount_R/2+Foot_Z_extra/2]){cube([LShape_Length,LShape_Width,S_mount_R+Foot_Z_extra], center = true );} // L-Shape    
}
if (PartB3==1){rotate([0,0,0]){difference(){B3();B3_sub();}}}

/////////////////////////////////////////////////////////////////////////////////
///// MODULE F1 - extra pillar stick 1 //////////////////
/////////////////////////////////////////////////////////////////////////////////

F_Plug_X = 15;
Airhole_R2 = 4;



module F1(){
	translate([0,-A_Base_Y/2-A_Wall_X/2-sep,A_extramount_Z/2+10-A_Base_Z/2]){cube([A_Wall_Y_long,A_Wall_X,A_extramount_Z+20+A_Base_Z], center = true );} // low_mount
	translate([0,-A_Base_Y/2-A_Wall_X/2-sep,-A_Base_Z/2-(A_Base_Z-19)/2]){cube([A_Wall_Y_long*4,A_Wall_X,A_Base_Z-19], center = true );} // low_mount
	translate([Airhole_spacing,-A_Base_Y/2-A_Wall_X/2-sep+F_Plug_X/2,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R-Tol, h = F_Plug_X, center = true );}} // Plug hole1
	translate([0,-A_Base_Y/2-A_Wall_X/2-sep+F_Plug_X/2,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R-Tol, h = F_Plug_X, center = true );}} // Plug hole2
	translate([-Airhole_spacing,-A_Base_Y/2-A_Wall_X/2-sep+F_Plug_X/2,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R-Tol, h = F_Plug_X, center = true );}} // Plug hole3
}
module F1_sub(){
	translate([Airhole_spacing,-A_Base_Y/2-A_Wall_X/2-sep+F_Plug_X/2,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R-Tube_wall, h = F_Plug_X*2, center = true );}} // Air holes
	translate([0,-A_Base_Y/2-A_Wall_X/2-sep+F_Plug_X/2,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R-Tube_wall, h = F_Plug_X*2, center = true );}} // Air holes
	translate([-Airhole_spacing,-A_Base_Y/2-A_Wall_X/2-sep+F_Plug_X/2,-A_Base_Z/2-(A_Base_Z-19)/2]){rotate ([90,90,0]) {cylinder(r = Airhole_R-Tube_wall, h = F_Plug_X*2, center = true );}} // Air holes
}
if (PartF1==1){rotate([90*Orient_flat,0,0]){difference(){F1();F1_sub();}}}

/////////////////////////////////////////////////////////////////////////////////
///// MODULE J - mini petri dish mount ///////////////
/////////////////////////////////////////////////////////////////////////////////

Petri_R = 35/2; // 
Petri_R_outer = 39/2; // for lid

module J(){
	translate([sep+Cam_X_offset,0,3*sep]){cube([Cam_X+Walls*2,Cam_Y+Walls*2,Walls], center = true );} // Main
	translate([sep-P_XY/4-P_border/2-Walls,0,3*sep]){cube([P_XY/2+P_border+2*Walls,A_Wall_Y_long+2*Walls,Walls], center = true );} // LINK
}
module J_sub(){
	translate([sep,0,3*sep]){rotate ([0,0,0]) {cylinder(r = Petri_R_outer+Tol, h = Walls, center = true );}} // Main hole
	translate([sep-P_XY/2-P_border-Walls/2,0,3*sep]){cube([Walls+Tol*2,A_Wall_Y_long+2*Tol,Walls*1.5], center = true );} // link_hole
	translate([sep-Cam_X/2-CamGroove_X-15,0,3*sep]){rotate ([0,90,0]) {cylinder(r = S_hole_R, h = 20, center = true );}} // link_screwhole
}
if (PartJ1==1){rotate([0,0,0]){difference(){J();J_sub();}}}

/////////////////////////////////////////////////////////////////////////////////
///// MODULE K - diffuser mount /////////////////////////
/////////////////////////////////////////////////////////////////////////////////

Link_Opening = 1;
Diffuser_XY = 45;
Diffuser_XY_inner = 38.5+2*Tol;

module K(){
	translate([sep+Cam_X_offset,0,2*sep]){cube([Diffuser_XY,Diffuser_XY,Walls], center = true );} // Main
	translate([sep-P_XY/4-P_border/2-Walls,0,2*sep]){cube([P_XY/2+P_border+2*Walls,A_Wall_Y_long+2*Walls,Walls], center = true );} // LINK
}
module K_sub(){
	translate([sep+Cam_X_offset,0,2*sep]){cube([Diffuser_XY_inner,Diffuser_XY_inner,Walls], center = true );} // Main_hole
	translate([sep-P_XY/2-P_border-Walls/2,-5*Link_Opening,2*sep]){cube([Walls+Tol*2,A_Wall_Y_long+2*Tol+10*Link_Opening,Walls*1.5], center = true );} // link_hole
	translate([sep-Cam_X/2-CamGroove_X-15,0,2*sep]){rotate ([0,90,0]) {cylinder(r = S_hole_R, h = 20, center = true );}} // link_screwhole
}
if (PartK==1){rotate([0,0,0]){difference(){K();K_sub();}}}
