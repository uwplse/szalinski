//Pattern jewelry collection by Growthobjects (2014)
//Licensed under the Creative Commons - Attribution - Non-Commercial license.
//Remixed from "Customizable iPhone Case" by MakerBot

use <utils/build_plate.scad>

//preview[view:south,tilt:top]

/*Customizer Variables*/

/*[All]*/

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 140; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 140; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/*[Shape]*/
frame_shape = 3; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),36:Circle (36-sided)]
//in mm: 
frame_shape_radius = 20; //[12.5:30]
frame_shape_orientation =  270; //[0:0degrees,10:10 degrees (9-sided),22.5:22.5degrees (8-sided),45:45degrees (4-sided),90:90degrees,190:190degrees (9-sided), 270:270(degrees)]
frame_hole_position =  0; //[0:bracelet or brooch (except triangle),0.5:necklace]

/*[Pattern]*/
pattern_shape = 6; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),36:Circle (36-sided)]
//in mm:
pattern_radius = 4; //[4:22]
pattern_overlap = 0; //[0:100]
//in degrees:
pattern_rotation = 90; //[0:180]
//in .4 mm increments:
pattern_line_thickness = 1.5; //[0.8:12]

/*[Hidden]*/

preview_tab = "Final";

pattern_shape_sides = pattern_shape;

pattern_base_thickness = 2;

pattern_canvas_width = 69.3;
pattern_canvas_length = 60;
pattern_canvas_height = 8;

circle_resolution = 24;

fudge = .05;

translate([0,0,-.1])
build_plate(build_plate_selector);

module patterncanvas(	w,		//width
					l,		//length
					h)		//height
					{
		cube([w,l,h],center = true);
	}

module patterncanvas2D(	w,		//width
						l,)		//length
{
		square([w,l],center = true);
}

module jewel_shape(){

	if(preview_tab == "Final" || preview_tab == "All" || preview_tab == "Shape" || preview_tab == "Pattern"){

		if(preview_tab == "Final"){
intersection(){
translate ([0,0,-25])
rotate([0,0,frame_shape_orientation])
cylinder(h=50,r=frame_shape_radius-2, $fn = frame_shape);
			difference(){
				union(){
					intersection(){
						translate([0,0,pattern_base_thickness/2])
							patterncanvas(pattern_canvas_width,pattern_canvas_length,pattern_base_thickness);

							scale([1,1,5])
								linear_extrude(height = pattern_canvas_height, center = true, convexity = 10)
									pattern(pattern_canvas_width,pattern_canvas_length,pattern_canvas_height,pattern_radius,pattern_overlap,pattern_line_thickness,pattern_shape_sides,pattern_rotation);
							}
				}
			}}
		}

		if(preview_tab == "All" || preview_tab == "Pattern"){
intersection (){
translate ([0,0,-25])
rotate([0,0,frame_shape_orientation])
cylinder(h=50,r=frame_shape_radius-2, $fn = frame_shape);
					intersection(){
						patterncanvas2D(pattern_canvas_width,pattern_canvas_length);
						scale([1,1,5])
						pattern(pattern_canvas_width,pattern_canvas_length,pattern_base_thickness,pattern_radius,pattern_overlap,pattern_line_thickness,pattern_shape_sides,pattern_rotation);
	}	
}
}
	}	
}

//color([.5,0,0])
jewel_shape();

module pattern(w,l,h,r,rmod,th,sides,rot){
	
	columns = l/(r*3)+1;
	rows = w/(r*sqrt(3)/2*2);

	translate([-w/2,l/2,0])
		rotate([0,0,-90])
			
			for(i = [-1:rows+1]){
				
				translate([0,r*sqrt(3)/2*i*2,0])
				//scale([1*(1+(i/10)),1,1])
					for(i = [0:columns]){
						translate([r*i*3,0,0])
							for(i = [0:1]){
								translate([r*i*1.5,r*sqrt(3)/2*i,0])
									rotate([0,0,rot])
									difference(){
										if(sides < 5){
											circle(r = r+th+(r*rmod/50), center = true, $fn = sides);
											//cylinder(height = h, r = r+th+(r*rmod/50), center = true, $fn = sides);
										} else {
											circle(r = r+(r*rmod/50)+fudge, center = true, $fn = sides);
											//cylinder(height = h, r = r+(r*rmod/50), center = true, $fn = sides);
										}
										circle(r = r-th+(r*rmod/50)+fudge, center = true, $fn = sides);
										//cylinder(height = h+1, r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
							}
					}
			}
}

module frame_shape(){
difference (){
difference (){
rotate([0,0,frame_shape_orientation])
cylinder(h=7,r=frame_shape_radius, $fn = frame_shape);
translate ([0,0,-25])
rotate([0,0,frame_shape_orientation])
cylinder(h=50,r=frame_shape_radius-2, $fn = frame_shape);
}
translate ([-frame_shape_radius*3/2,frame_shape_radius*frame_hole_position,4])
rotate ([0,90,0])
cylinder (h=frame_shape_radius*3, r=1.5, $fn = 30);
}
}
frame_shape();
