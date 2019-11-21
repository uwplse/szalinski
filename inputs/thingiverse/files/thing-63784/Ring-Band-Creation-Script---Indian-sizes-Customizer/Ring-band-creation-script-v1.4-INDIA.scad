/*!
@brief Ring Band creation script
@details This OpenSCAD script will generate a plain wedding band style ring.
Most parameters are user selectable such as the ring profile shapes.
This would be ideal as the basis for a wedding ring...

@author Mark Gaffney
@version 1.4
@date 2013-03-19

@todo
Implement texturing
Implement hallmarking

@warning
Let the right one in

@note
Changes from previous versions:
1.4
 - 	added ellipse_intersection.scad code for 2 new cross section shapes (cs_ellipse_intersection & cs_rounded_ellipse_intersection)
 - 	added support for write.scad on inside or outside of ring, engraved or raised
1.3
 - 	Xxxxx's wedding ring version (no stone, no mount)
1.2
 - 	Made higher resolution shapes by increasing rotate extrude $fn from 50 to 100 and shape $fn from 20 to 40
 - 	Implemented half chamfered rectangle
1.1
 - 	Fixed issue whereby rounded rectangle shape CS appeared slightly translated in Y direction
1.0
 - 	First version based on Ring_band_creation_script_v0.10.scad
 - 	Added more cross sections (cs_half_pill, cs_reverse_hemi_ellipse, cs_reverse_rounded_hemi_ellipse)

*/
//******Fixed*Variables*******

//*************includes********
use <write/Write.scad>//http://www.thingiverse.com/thing:16193  writecylinder("Text on Cylinder",[translatex,translatey,translatez],cylinderr=20,cylinderh=40,rotate=45,center=true)
//include <write/Write.scad>//http://www.thingiverse.com/thing:16193  writecylinder("Text on Cylinder",[translatex,translatey,translatez],cylinderr=20,cylinderh=40,rotate=45,center=true)


//*******User*Variables*******

/* [Size] */ //choose ring size
//Enter India numerical ring size
ring_size_ind_chn_jpn=11;//[1:27]
//difference between ring inner and outer radius [mm] (1 to 5)
main_wall=2;
//how wide the band of the ring is [mm] (1 to 10)
main_depth=4.34;
//this is the 3rd variable for the cross section, not used in some cross section shapes, read the instructions, OpenSCAD code or play around to figure out how/if it affects your ring
main_feature=0.2;

	main_internal_diameter=(ring_size_ind_chn_jpn+34.749)/2.7924;//(India, China, Japan size to mm ID)the diameter of the wearers finger in mm

/* [Cross Section] */ //Choose cross section shape for ring band, set one of these lines to 1 the rest to 0 to choose the cross section for the ring band
//Choose cross section shape
cs_shape="cs_half_pill";//"cs_rounded_ellipse_intersection";//[cs_ellipse, cs_rectangle, cs_pill, cs_hemi_ellipse, cs_scallopped_rectangle, cs_rounded_scallopped_rectangle, cs_rounded_hemi_ellipse, cs_rounded_rectangle, cs_chamfered_rectangle, cs_half_pill, cs_reverse_hemi_ellipse, cs_reverse_rounded_hemi_ellipse, cs_half_chamfered_rectangle, cs_ellipse_intersection, cs_rounded_ellipse_intersection]

/* [Text] */ //Choose to add text
//Do you want to add text?
text_enabled="false";//[true, false]
//Engraved or raised text?
text_engraved="true";//[true:engraved, false:raised]
//Where would you like the text?
text_inside="true";//[true:inside, false:outside]
//What do you want the text to say?
text_itself="Your Text Here";
//Height of each letter
text_height=2;
//Depth of engraved/raised letters
text_depth=1;
//Spacing between adjacent letters
text_spacing=1.1;
//Text Font
text_font="orbitron.dxf";//[Letters.dxf:Letter, Orbitron.dxf:Orbitron, BlackRose.dxf:BlackRose, braille.dxf:Braille]
	

/* [Hidden] */ 
//how smooth and round is it? Bigger numbers mean smoother shapes but take a lot longer to render!
smoothness=20; 
//choose colo(u)rs //colour of the metal in Red, Green, Blue, Opacity where the values can be anything from 0-1
colour_RGBA_metal=[0.65,0.65,0.65,1];
//something I use to help ensure manifoldness etc. do not change please!
a_bit=0.01*1;//[0.01]
$fn=smoothness*1;

//********User*Feedback****

echo("main_internal_diameter ", main_internal_diameter);


//**********Calls************

if (text_enabled=="true"){
	if (text_engraved=="true"){
		difference(){
			color(colour_RGBA_metal) ring_shape(main_internal_diameter, main_depth, main_wall, main_feature);
			ring_engraving(main_internal_diameter, main_wall, main_depth, text_inside, text_itself, text_height, text_depth, text_spacing);
		}
	}else{
		union(){//implies text is raised and has to be unioned
			color(colour_RGBA_metal) ring_shape(main_internal_diameter, main_depth, main_wall, main_feature);
			ring_engraving(main_internal_diameter, main_wall, main_depth, text_inside, text_itself, text_height, text_depth, text_spacing);
		}
	}
	//ring_compartment();
}else{//we don;t have text just make the ring itself
	color(colour_RGBA_metal) ring_shape(main_internal_diameter, main_depth, main_wall, main_feature);
}
//*******Modules************

module ring_engraving(internal_diameter=20, wall=5, depth=5, text_inside=false, text_itself="Some Text", text_height, text_depth=1, text_spacing=1.2, text_font="write/orbitron.dxf"){
	internal_radius=internal_diameter/2;
	external_radius=(internal_diameter/2)+wall;
	if (text_inside=="true"){
		mirror(1,0,0)rotate(a=[0,0,180])writecylinder(text_itself,[0,0,-depth/2],internal_radius,depth,rotate=0,t=text_depth,h=text_height,space=text_spacing,font=text_font);
	}else{
		writecylinder(text_itself,[0,0,-depth/2],external_radius,depth,rotate=0,t=text_depth,h=text_height,space=text_spacing,font=text_font);
	}
}

module ring_shape(ring_internal_diameter, ring_depth, ring_wall, ring_feature){
	rotate_extrude (convexity = 20) translate([(ring_internal_diameter)/2, 0, 0]){
		if(cs_shape=="cs_pill"){
			echo("Pill Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			pill_shape (ring_depth, ring_wall);
		}
		else if(cs_shape=="cs_ellipse"){
			echo("Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			ellipse_shape (ring_depth, ring_wall);
		}
		else if(cs_shape=="cs_hemi_ellipse"){
			echo("Hemi Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			hemi_ellipse_shape (ring_depth, ring_wall);
		}
		else if(cs_shape=="cs_rounded_hemi_ellipse"){
			echo("Rounded Hemi Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_hemi_ellipse_shape (ring_depth, ring_wall, ring_feature);
		}
		else if(cs_shape=="cs_rectangle"){
			echo("Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			rectangle_shape (ring_depth, ring_wall);
		}
		else if(cs_shape=="cs_scallopped_rectangle"){
			echo("Scallopped Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			scallopped_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		else if(cs_shape=="cs_rounded_scallopped_rectangle"){
			echo("Rounded Scallopped Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_scallopped_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		else if(cs_shape=="cs_rounded_rectangle"){
			echo("Rounded Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		else if(cs_shape=="cs_chamfered_rectangle"){
			echo("Chamfered Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			chamfered_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		else if(cs_shape=="cs_half_pill"){
			echo("Half Pill Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			half_pill_shape (ring_depth, ring_wall);
		}
		else if(cs_shape=="cs_reverse_hemi_ellipse"){
			echo("Reverse Hemi Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			translate (v=[ring_wall,0,0]) rotate(a=[0,0,180]) hemi_ellipse_shape (ring_depth, ring_wall);
		}
		else if(cs_shape=="cs_reverse_rounded_hemi_ellipse"){
		echo("Reverse Rounded Hemi Ellipse Shaped Cross Section, depth",  ring_depth, "wall", ring_wall, "feature", ring_feature);
			translate (v=[ring_wall,0,0]) rotate(a=[0,0,180]) rounded_hemi_ellipse_shape (ring_depth, ring_wall, ring_feature);
		}
		else if(cs_shape=="cs_half_chamfered_rectangle"){
			echo("Chamfered Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			half_chamfered_rectangle_shape (ring_depth, ring_wall+(sin(45)*ring_feature), ring_feature);
		}
		else if(cs_shape=="cs_ellipse_intersection"){
			echo("Ellipse Intercestion Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			ellipse_intersection_shape (ring_depth, ring_wall, ring_feature);
		}
		else if(cs_shape=="cs_rounded_ellipse_intersection"){
			echo("Rounded Ellipse Intercestion Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_ellipse_intersection_shape (ring_depth, ring_wall, ring_feature);
		}

//	cs_half_chamfered_rectangle=0;//not yet implemented

	}
}

//************Ring_Cross_Setion_Modules**************

module pill_shape (pill_l, pill_b){
	translate(v=[pill_b/2,0,0]){
		translate (v=[0,-(pill_l-pill_b)/2,0]) circle (r=pill_b/2, center=true);
		square (size=[pill_b, pill_l-pill_b], center=true);
		translate (v=[0,(pill_l-pill_b)/2,0]) circle(r=pill_b/2, center=true);
	}
}

module ellipse_shape (ellipse_x, ellipse_y){
	translate(v=[ellipse_y/2,0,0]) scale(v=[ellipse_y,ellipse_x]) circle(r=0.5,$fn=40, center=true);
}
module hemi_ellipse_shape(hemi_ellipse_x,hemi_ellipse_y){
	scale(v=[2*hemi_ellipse_y,hemi_ellipse_x]) difference () { 
		circle(r=0.5,$fn=40, center=true);
		translate (v=[-1.5,0,0]) square (size=3, center=true);
	}
}
module rectangle_shape (rectangle_x, rectangle_y){
	translate(v=[rectangle_y/2,0,0]) square(size=[rectangle_y, rectangle_x], center=true);
}

module scallopped_rectangle_shape (scallopped_rectangle_y, scallopped_rectangle_x, scallopped_rectangle_z){
	difference (){
		rectangle_shape (scallopped_rectangle_y, scallopped_rectangle_x);
		translate(v=[scallopped_rectangle_x,0,0]) rotate(a=[0,0,180]) hemi_ellipse_shape(scallopped_rectangle_y,scallopped_rectangle_z);
	}
}

module rounded_scallopped_rectangle_shape (rounded_scallopped_rectangle_y, rounded_scallopped_rectangle_x, rounded_scallopped_rectangle_z){
	minkowski(){
		translate(v=[rounded_scallopped_rectangle_z,0,0]) difference (){
			rectangle_shape (rounded_scallopped_rectangle_y-2*rounded_scallopped_rectangle_z, rounded_scallopped_rectangle_x-2*rounded_scallopped_rectangle_z);
			translate(v=[rounded_scallopped_rectangle_x-2*rounded_scallopped_rectangle_z,0,0]) rotate(a=[0,0,180]) hemi_ellipse_shape(rounded_scallopped_rectangle_y-2*rounded_scallopped_rectangle_z,rounded_scallopped_rectangle_z);
		}
	circle(r=rounded_scallopped_rectangle_z, $fn=40);
	}
}

module rounded_hemi_ellipse_shape(rounded_ellipse_x, rounded_ellipse_y, rounded_ellipse_z){
	translate(v=[rounded_ellipse_z,0,0]){
		minkowski(){
			hemi_ellipse_shape(rounded_ellipse_x-2*rounded_ellipse_z,rounded_ellipse_y-2*rounded_ellipse_z);
			circle(r=rounded_ellipse_z, $fn=40);
		}
	}
}

module rounded_rectangle_shape(rounded_rectangle_y, rounded_rectangle_x, rounded_rectangle_z){
	translate(v=[rounded_rectangle_x/2,0,0]){
		minkowski(){
			square(size=[rounded_rectangle_x-2*rounded_rectangle_z,rounded_rectangle_y-2*rounded_rectangle_z], center=true);
			circle(r=rounded_rectangle_z, $fn=40);
		}
	}
}

module chamfered_rectangle_shape(chamfered_rectangle_y, chamfered_rectangle_x, chamfered_rectangle_z){
	translate(v=[chamfered_rectangle_x/2,-sin(45)*chamfered_rectangle_z,0]){
		minkowski(){
			square(size=[chamfered_rectangle_x-2*sin(45)*chamfered_rectangle_z,chamfered_rectangle_y-2*sin(45)*chamfered_rectangle_z],center=true);
			rotate (a=[0,0,45]) square (size=chamfered_rectangle_z);
		}
	}
}

module half_chamfered_rectangle_shape(half_chamfered_rectangle_y, half_chamfered_rectangle_x, half_chamfered_rectangle_z){
	translate(v=[-sin(45)*half_chamfered_rectangle_z,0,0]){
		difference(){
			chamfered_rectangle_shape (half_chamfered_rectangle_y, half_chamfered_rectangle_x+(sin(45)*half_chamfered_rectangle_z), half_chamfered_rectangle_z);
			//translate(v=[+sin(45)*half_chamfered_rectangle_z/2,0,0]) rectangle_shape (half_chamfered_rectangle_y+0.1, (sin(45)*half_chamfered_rectangle_z));
			translate(v=[(-0.1+sin(45)*half_chamfered_rectangle_z)/2,0,0]) square (size=[(sin(45)*half_chamfered_rectangle_z + 0.1),half_chamfered_rectangle_y+0.1], center=true);
		}
	}
}
module half_pill_shape (pill_l, pill_b){
	translate(v=[-pill_b,0,0]) difference (){
		pill_shape(pill_l,2*pill_b);
		square (size=[2*pill_b,pill_l], center=true);
	}
}

module ellipse_intersection_shape (ellipse_inter_x, ellipse_inter_y, ellipse_inter_z,rounding_rad_m=0){
	band_width_m = ellipse_inter_x;
	band_depth_m = ellipse_inter_y;
	inner_depth_ratio_m = ellipse_inter_z;
	//else{//default aligns (0,0) with the line separating the 2 sides determiend by inner_depth_ratio
	//echo("band_width_m, band_depth_m, inner_depth_ratio_m",band_width_m, band_depth_m, inner_depth_ratio_m);
	inner_height_m=(band_depth_m)*inner_depth_ratio_m;
	outer_height_m=(band_depth_m)-inner_height_m;

	inner_rad_m=(inner_height_m/2) + (band_width_m)*(band_width_m)/(8*inner_height_m);
	outer_rad_m=(outer_height_m/2) + (band_width_m)*(band_width_m)/(8*outer_height_m);
	//echo("herp inner_depth_ratio_m",inner_depth_ratio_m);

	//inner surface centred
	//echo("inner centred");
	rotate(a=-90)translate(v=[0, (band_depth_m)*inner_depth_ratio_m ]) intersection(){//translate(v=[0, (band_depth_m-2*rounding_rad_m)*inner_depth_ratio_m+rounding_rad_m ]) intersection(){
		translate(v=[0,inner_rad_m-inner_height_m]) circle(r=inner_rad_m);
		translate(v=[0,-(outer_rad_m-outer_height_m)]) circle(r=outer_rad_m);
	}
}

module rounded_ellipse_intersection_shape (rounded_ellipse_inter_x, rounded_ellipse_inter_y, rounded_ellipse_inter_z,rounded_rounding_rad_l=0.5){
	band_width_l = rounded_ellipse_inter_x;
	band_depth_l = rounded_ellipse_inter_y;
	inner_depth_ratio_l = rounded_ellipse_inter_z;
	minkowski(){
		//echo("rounded_rounding_rad_l r=",rounded_rounding_rad_l);
		circle(r=rounded_rounding_rad_l);
		translate(v=[rounded_rounding_rad_l,0])ellipse_intersection_shape (rounded_ellipse_inter_x-2*rounded_rounding_rad_l, rounded_ellipse_inter_y-2*rounded_rounding_rad_l, rounded_ellipse_inter_z,rounded_rounding_rad_l);
	}
}