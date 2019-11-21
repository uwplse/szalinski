//Coil Form Generation Scrip
//By Bryan Gatenby, Feb,2013

use<./mcad/screw.scad>
use <./mcad/curves.scad>


//resolution?
resolution = 36;//[10:100]
$fn = resolution;
//Outer Width of the Form Cylinder
outer_diameter = 30;
//Height of the Form Cylinder?
heightOfForm =60;
//How Thick should the form walls be? 
wall_thickness = 3;
//Wire Grooves?
wire_grooves = 1; //[0:No,1:Yes]
//How many turns in the coil?
turns = 15;
//How deep is the groove?
groove_depth = 1;
//Direction of grooves?
groove_direction = -1;//[-1:ccw,1:cw]

//How Wide is the base?
base_width = 50;
//How Thick is the base?
base_thickness = 2;
//How Many Holes?
hole_count = 10;
hole_radius = 2;
fine_tune_distance = 0;

//Shielding Guide?
 enable_shielding_guide=1;//[0:disabled,1:enabled]
//How wide is the inside of your shield?
shield_diameter = 34;
//How Tall is the Guide?
guide_height = 2;
//How Thick is the Guide?
guide_thickness = .4;

//Create Hole For Wire?
enable_wire_hole = 1;//[1:enabled,0:disabled]
wire_hole_diameter = 1;
wire_rotation = 15; 


main();

module main(){
	difference(){	
		union(){
			if(wire_grooves == 1){
				intersection(){
					create_form_cylinder();
					create_wire_guide();
					}
		
			}else{
				create_form_cylinder();
			}
				create_base();
			}
		if(enable_wire_hole == 1){
			create_wire_hole();
		}
		}
}

module create_base(){
	translate([0,0,-base_thickness]) difference(){
									
									cylinder(base_thickness,base_width/2,base_width/2);
									translate([0,0,-1])cylinder(base_thickness+2,(outer_diameter/2)-wall_thickness,(outer_diameter/2)-wall_thickness);
									create_base_holes();
									
									}
						if(enable_shielding_guide==1){
								create_guide();
						}

}
module create_form_cylinder(){

	difference(){
		cylinder(heightOfForm,outer_diameter/2,outer_diameter/2);
		translate([0,0,-.5])cylinder(heightOfForm+1,(outer_diameter/2)-wall_thickness,(outer_diameter/2)-wall_thickness);
	}
	
}

module create_wire_guide(){

	linear_extrude(height = heightOfForm, center = false, convexity =10, twist = turns*360*groove_direction)
	translate([groove_depth,0, 0])
	circle(r = (outer_diameter/2)-1);
	
}
module create_base_holes(){
			// creates base holes evenly spaced around base
			
			hole_spacing = 360/hole_count; //in degrees
			distance_from_center = (outer_diameter/2) +(abs((base_width/2)-(outer_diameter/2))/2)+fine_tune_distance;
			if(hole_count>0){  //check for no holes
				for(i = [1:1:hole_count]){
					translate([sin((hole_spacing*i))*distance_from_center,cos((hole_spacing*i))*distance_from_center,0]) create_base_hole();
			}
				}
			
			
}
module create_base_hole(){
	translate([0,0,-.5])cylinder(base_thickness+1,hole_radius,hole_radius);
}
module create_guide(){
	difference(){
			cylinder(guide_height,shield_diameter/2,shield_diameter/2);
			translate([0,0,-.5]) cylinder(guide_height+1,(shield_diameter/2)-guide_thickness,(shield_diameter/2)-guide_thickness); 
	}
}
module create_wire_hole(){
		rotate(wire_rotation,[0,0,1]){
			translate([0,base_width/2,0])
			
				rotate(90,[1,0,0]){
					cylinder(base_width, wire_hole_diameter,wire_hole_diameter);
				
				}
		}
	}