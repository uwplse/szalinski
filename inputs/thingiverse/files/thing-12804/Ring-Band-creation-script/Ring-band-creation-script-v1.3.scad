/*!
@brief Ring Band creation script
@details This OpenSCAD script will generate a plain wedding band style ring.
Most parameters are user selectable such as the ring profile shapes.
This would be ideal as the basis for a wedding ring...

@author Mark Gaffney
@version 1.3
@date 2013-02-09

@todo
implement engraving

@warning
Let the right one in

@note
Changes from previous versions:
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
a_bit=0.01;//something I use to help ensure manifoldness etc. do not change please!

//*******User*Variables*******
$fn=50; //how smooth and round is it? Bigger numbers mean smoother shapes but take a lot longer to render! Setting this value will also cause how the jewel is rendered to be changed from a proper 57/58 facet round brilliant cut.

//choose colo(u)rs
	colour_RGBA_metal=[0.65,0.65,0.65,1];//colour of the metal in Red, Green, Blue, Opacity where the values can be anything from 0-1

//choose ring size
	ring_size_us_can=6.5;//enter US numerical ring size
//	ring_size_uk_ie_aus_nz=12.5;//Enter UK numerical ring size, make sure to convert from letters to numbers i.e. a=1, b1/2=2.5, z=26
//	ring_size_ind_chn_jpn=11;//Enter India numerical ring size
//	ring_size_switz=12.75;//Enter Swiss numerical ring size

//choose ring sizing system, comment in one of the lines below depending on which sizing system you are using
//	main_internal_diameter=50;//(mm)the diameter of the wearers finger in mm
	main_internal_diameter=(ring_size_us_can+14.312)/1.2308;//(US, Canada size to mm ID)the diameter of the wearers finger in mm
//	main_internal_diameter=(ring_size_uk_ie_aus_nz+29.549)/2.5352;//(UK, Ireland, Australia, New Zealand size to mm ID)
//	main_internal_diameter=(ring_size_ind_chn_jpn+34.749)/2.7924;//(India, China, Japan size to mm ID)the diameter of the wearers finger in mm
//	main_internal_diameter=(ring_size_switz+39.561)/3.1314;//(Swiss to mm ID)

//choose ring band dimensions
	main_wall=2;//difference between ring inner and outer radius
	main_depth=4.34;//how wide the band of the ring is
	main_feature=0.5;//this is the 3rd variable for the cross section, it is not used in simple shapes like rectangular but controls features for other shapes including scallop depth, chamfer length, fillet radius, make sure it is less than half of the smallest of the 2 previous parameters

//Choose cross section shape for ring band, set one of these lines to 1 the rest to 0 to choose the cross section for the ring band
	cs_ellipse=0;
	cs_rectangle=0;
	cs_pill=0;
	cs_hemi_ellipse=0;
	cs_scallopped_rectangle=0;
	cs_rounded_scallopped_rectangle=0;
	cs_rounded_hemi_ellipse=1;
	cs_rounded_rectangle=0;
	cs_chamfered_rectangle=0;
	cs_half_pill=0;
	cs_reverse_hemi_ellipse=0;
	cs_reverse_rounded_hemi_ellipse=0;
	cs_half_chamfered_rectangle=0;


//********User*Feedback****

echo("main_internal_diameter ", main_internal_diameter);


//**********Calls************

color(colour_RGBA_metal) ring_shape(main_internal_diameter, main_depth, main_wall, main_feature);

//ring_engraving();
//ring_compartment();

//*******Modules************

module ring_shape(ring_internal_diameter, ring_depth, ring_wall, ring_feature){
	rotate_extrude (convexity = 20) translate([(ring_internal_diameter)/2, 0, 0]){
		if(cs_pill==1){
			echo("Pill Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			pill_shape (ring_depth, ring_wall);
		}
		if(cs_ellipse==1){
			echo("Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			ellipse_shape (ring_depth, ring_wall);
		}
		if(cs_hemi_ellipse==1){
			echo("Hemi Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			hemi_ellipse_shape (ring_depth, ring_wall);
		}
		if (cs_rounded_hemi_ellipse==1){
			echo("Rounded Hemi Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_hemi_ellipse_shape (ring_depth, ring_wall, ring_feature);
		}
		if(cs_rectangle==1){
			echo("Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			rectangle_shape (ring_depth, ring_wall);
		}
		if(cs_scallopped_rectangle==1){
			echo("Scallopped Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			scallopped_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		if(cs_rounded_scallopped_rectangle==1){
			echo("Rounded Scallopped Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_scallopped_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		if(cs_rounded_rectangle==1){
			echo("Rounded Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		if(cs_chamfered_rectangle==1){
			echo("Chamfered Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			chamfered_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		if(cs_half_pill==1){
			echo("Half Pill Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			half_pill_shape (ring_depth, ring_wall);
		}
		if(cs_reverse_hemi_ellipse==1){
			translate (v=[ring_wall,0,0]) rotate(a=[0,0,180]) hemi_ellipse_shape (ring_depth, ring_wall);	
		}
		if(cs_reverse_rounded_hemi_ellipse==1){
			translate (v=[ring_wall,0,0]) rotate(a=[0,0,180]) rounded_hemi_ellipse_shape (ring_depth, ring_wall, ring_feature);
		}

		if(cs_half_chamfered_rectangle==1){
			echo("Chamfered Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			half_chamfered_rectangle_shape (ring_depth, ring_wall+(sin(45)*ring_feature), ring_feature);
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