bearing_diameter = 22.4;

bearing_height = 7.5;

bearing_base_height = 1;

//hole diameter below bearing (bigger than nut size)
bottom_hole_diameter = 18;

//thickness of plastic around bearing
bearing_perimeter = 2.5;

//number of legs
legs = 3; // [3,4,5]

//width of each leg
leg_width = 17;

//length of each leg (from center point)
leg_length = 35;

minimum_leg_height = 6;

maximum_leg_height = 10;

//diameter of threaded rod
threaded_rod_size = 5; // [3:M3, 4:M4, 5:M5, 6:M6]

//nut groove width
nut_width = 8.2;

//nut groove thickness
nut_thickness = 4.3;

/* [Hidden] */
bearing_hole_extend = 2;
//minimum material behind nut
nut_support = 3;
//minimum material on each side of nut hole
nut_minimum_walls = 1;
//Calculations
rod_thickness = threaded_rod_size + 0.2;

$fn=100;

difference(){
	union(){
		cylinder(h=bearing_height+bearing_base_height, d=bearing_diameter+bearing_perimeter*2);
		//Leg
		if((leg_length-leg_width/2-nut_thickness-nut_support >= bearing_diameter/2+bearing_perimeter) && (nut_width+nut_minimum_walls*2 <= leg_width) && (maximum_leg_height > rod_thickness) && (nut_support > 0) && (bearing_perimeter > 0)){
			difference(){	
				for (i = [0:360/legs:359]){
					rotate(i){
						difference(){
							union(){
								translate([-leg_width/2, 0, 0])
									cube([leg_width, leg_length-leg_width/2, maximum_leg_height]);
								translate([0, leg_length-leg_width/2, 0])
									cylinder(h=maximum_leg_height, d=leg_width);
							}
							//groove
							if(leg_length-bearing_diameter/2-bearing_perimeter-leg_width/2-nut_thickness-nut_support > maximum_leg_height-minimum_leg_height){
								if(minimum_leg_height>0){
									translate([-leg_width/2-1, 0, minimum_leg_height])
										cube([leg_width+2, leg_length-leg_width/2-(maximum_leg_height-minimum_leg_height)-nut_thickness-nut_support, maximum_leg_height-minimum_leg_height+1]);
									translate([-leg_width/2-1, leg_length-leg_width/2-(maximum_leg_height-minimum_leg_height)-nut_thickness-nut_support, maximum_leg_height])
										rotate([0, 90, 0])
											cylinder(h=leg_width+2, r=maximum_leg_height-minimum_leg_height);
								}
							}
							//nut
							translate([-nut_width/2, leg_length-leg_width/2-nut_thickness ,0])
								cube([nut_width, nut_thickness, maximum_leg_height]);
							//rod
							translate([0, leg_length-leg_width/2-nut_thickness, (maximum_leg_height)/2])
								rotate([-90, 0, 0])
									cylinder(h=leg_width/2+nut_thickness, d=rod_thickness);
						}
					}
				}
				if(maximum_leg_height > bearing_height+bearing_base_height){
					translate([0, 0, bearing_height+bearing_base_height]) cylinder(h=maximum_leg_height-bearing_height-bearing_base_height, d=bearing_diameter+bearing_hole_extend);
				}
			}
		}
	}
	//Bearing
	translate([0, 0, bearing_base_height]){
		cylinder(h=bearing_height, d=bearing_diameter);
		translate([0, 0, bearing_height-1]) cylinder(h=1, d1=bearing_diameter, d2=bearing_diameter+bearing_hole_extend);
	}
	//bottom hole
	cylinder(h=bearing_base_height, d=bottom_hole_diameter);
}