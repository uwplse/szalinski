/////////////////////////////////////////////////////////////////////////////////
/// ///
/// Phonescope v6; 2014 03 24 ///
/// by Tom Baden (thingyverse ID: tbaden) ///
/// thomas.baden@uni-tuebingen.de ///
/// tombaden.wordpress.com ///
/// ///
/////////////////////////////////////////////////////////////////////////////////

// CUSTOMIZABLE VARIABLES

// X Dimension of phone (short edge)
X = 58.57; 
 
// Y Dimension each part
Y = 16;

// Z Dimension of phone (thickness)
Z = 7.13;  

// Thickness of walls
Wall = 2;

// Width of the rim
rim = 4;

// Jiggle room for things that should move
tol = 0.9; 

// Jiggle room for push-fit parts
tol_S = 0.1;

// Lens radius
Lens_R = 4.4; 

// X Lens distance from edge
Lens_Xoffset = 9.23; 

// Y Lens distance from edge
Lens_Yoffset = 7.35; 

// Flash hole radius
Flash_R = 2;

// X Flash distance from edge
Flash_Xoffset = 18.73;

// Y Flash distance from edge
Flash_Yoffset = 7.35;


// Power button distance from edge
Power_Xoffset = 17;

// Power button length
Power_X = 11;

// Power button height
Power_Z = 4;


///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
/// CUSTOMIZER CUTOFF: MODIFY ANYTHING BELOW HERE AT YOUR OWN RISK! ///////////////////
/// ( Yes, I know the code is messy - it grew organically and I havent cleaned it..) //
module customizer_cutoff(){};//////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

Lens_thickness = 3;

Topstand_Y = 7; // 8

Bottomstand_wall = 3;
Bottomstand_Z = 9.5;

marker_length = 30;


Screw_X_offset = 0;
Screw_Y_offset = 2;
Screw_R_small = 1.8; // screw needs to fit snug but not engage
Screw_R_head = 2.9;; // head of screw slot for part B
Screw_X_hex = 6.05; //7.4; // how wide is the boat
Screw_Z_hex = 2.6; //3.2; // how thick is the boat

Thumbscrew_R = 3;
Thumbscrew_inner_R = 1.5;//1.5 is for screw to screw in;
Thumbscrew_Z = 5; // how much "taller" than case is the foot when fully retracted
Thumbscrew_inner_Z = 4; // how deep into foot can screw go
Thumbscrew_depth = Z+1*Wall+Lens_thickness+tol - 2* Wall - Screw_Z_hex - tol/2; // 7
Thumbscrew_Z_real = Thumbscrew_Z + Thumbscrew_depth;
Thumbscrew_R_end = 6;

Screw_R_big = Thumbscrew_R+tol/4;
Screw_Z_big = Thumbscrew_depth; // how deep does knob go in?

sep = 30; // 123.83/2;

/////////////////////////////////////

module top(){
	translate([0,Wall/2+sep,(Lens_thickness-Wall)/2]){cube([X+2*Wall+tol,Y+1*Wall+tol,Z+1*Wall+Lens_thickness+tol], center = true);} // main top

	translate([0,Wall/2+sep+(Y+1*Wall+tol)/2+Topstand_Y/2,(Lens_thickness-Wall)/2]){cube([X+2*Wall+tol,Topstand_Y,Z+1*Wall+Lens_thickness+tol], center = true);} // Top_extra

	

}
module top_sub(){
	translate([0,+sep,0]){cube([X+tol,Y+tol,Z+tol], center = true);} // mainhole_top

	translate([0,+sep-rim/2-tol_S,-Wall]){cube([X+tol-2*rim,Y+tol-rim,Z+tol], center = true);} // mainhole_top_wallcut

	translate([-(X+tol)/2+Lens_Xoffset,Wall/2+sep+(Y+1*Wall+tol)/2+Topstand_Y/2-Screw_Y_offset,(Lens_thickness-Wall)/2-(Z+1*Wall+Lens_thickness+tol)/2]){cube([1,marker_length,1], center = true);} // cam marker 1

	translate([-(X+tol)/2,(Y+tol)/2-Lens_Yoffset+sep,(Lens_thickness-Wall)/2-(Z+1*Wall+Lens_thickness+tol)/2]){cube([marker_length,1,1], center = true);} // cam marker 2

	translate([-(X+tol)/2+Lens_Xoffset,(Y+tol)/2-Lens_Yoffset+sep,Z/2+Lens_thickness/2+tol/2]){
		cylinder($fn = 50, r = Lens_R+tol_S, h = Lens_thickness, center = true);} // camerahole
	translate([-(X+tol)/2+Flash_Xoffset,(Y+tol)/2-Flash_Yoffset+sep,Z/2+Lens_thickness/2+tol/2]){
		cylinder($fn = 50, r = Flash_R+tol_S, h = Lens_thickness, center = true);} // flashhole
	
	translate([Power_Xoffset-(X+2*Wall+tol)/2,Wall/2+sep+(Y+1*Wall+tol)/2,0]){cube([Power_X,10,Power_Z], center = true);} // power button hole

	translate([Screw_X_offset,Wall/2+sep+(Y+1*Wall+tol)/2+Topstand_Y/2-Screw_Y_offset,(Lens_thickness-Wall)/2]){
		cylinder($fn = 50, r = Screw_R_small, h = Z+1*Wall+Lens_thickness+tol, center = true);} // screwhole1 - small
	translate([Screw_X_offset,Wall/2+sep+(Y+1*Wall+tol)/2+Topstand_Y/2-Screw_Y_offset,(Lens_thickness-Wall)/2-(Z+1*Wall+Lens_thickness+tol)/2+Screw_Z_big/2]){
		cylinder($fn = 50, r = Screw_R_big, h = Screw_Z_big, center = true);} // screwhole1 - big


	translate([Screw_X_offset,Wall/2+sep+(Y+1*Wall+tol)/2+Topstand_Y/2-Wall/2,(Lens_thickness-Wall)/2+(Z+1*Wall+Lens_thickness+tol)/2-Screw_Z_hex/2-Wall]){cube([Screw_X_hex,Topstand_Y+Wall+0.01,Screw_Z_hex], center = true);}

}

difference(){top();top_sub();}

/////////////////////////////////////

module bottom(){
	translate([0,-Wall/2-sep,(Lens_thickness-Wall)/2+Bottomstand_Z/2]){cube([X+2*Wall+tol+2*Bottomstand_wall,Y+1*Wall+tol+Topstand_Y,Z+1*Wall+Lens_thickness+tol+Bottomstand_Z], center = true);} // main bottom



}
module bottom_sub(){
	translate([0,-sep,0]){cube([X+tol,Y+tol+Topstand_Y,Z+tol], center = true);} // mainhole_bottom
	translate([0,-sep+rim/2+tol_S,-Wall]){cube([X+tol-2*rim,Y+tol-rim+Topstand_Y,Z+tol], center = true);} // mainhole_bottom_wallcut

	translate([-Screw_X_offset,-Wall/2-sep+(Y+1*Wall+tol)/2-Screw_Y_offset,(Lens_thickness-Wall)/2]){
		cylinder($fn = 50, r = Screw_R_head, h = Z+1*Wall+Lens_thickness+tol+0.01, center = true);} // screwhole_fit

	translate([+(X+tol)/2-Lens_Xoffset,-(Y+tol)/2+Lens_Yoffset-sep-Topstand_Y/2,Z/2+Lens_thickness/2+tol/2]){
		cylinder($fn = 50, r = Lens_R+tol, h = Lens_thickness+0.01, center = true);} // camerahole_fit

	translate([0,-Wall/2-sep,(Lens_thickness-Wall)/2+(Z+1*Wall+Lens_thickness+tol)/2+Bottomstand_Z/2]){cube([X+2*Wall+tol+tol_S,Y+1*Wall+tol+Topstand_Y,Bottomstand_Z], center = true);} // sidestands


}

difference(){bottom();bottom_sub();}


//////////////////////////////////////


module Thumbscrew(){
	translate([(X+2*Wall+tol)/2,0,0]){
		cylinder($fn = 50, r = Thumbscrew_R, h = Thumbscrew_Z_real-tol, center = true);} // shaft1
	translate([(X+2*Wall+tol)/2,0,-Thumbscrew_Z_real/2+(Thumbscrew_Z-tol)/2]){
		cylinder($fn = 12, r = Thumbscrew_R_end, h = Thumbscrew_Z-tol, center = true);} // foot1



}

module Thumbscrew_hole(){

	translate([(X+2*Wall+tol)/2,0,Thumbscrew_Z_real/2-Thumbscrew_inner_Z/2]){
		cylinder($fn = 50, r = Thumbscrew_inner_R, h = Thumbscrew_inner_Z+0.1, center = true);} // hole


}

difference (){Thumbscrew();Thumbscrew_hole();}


