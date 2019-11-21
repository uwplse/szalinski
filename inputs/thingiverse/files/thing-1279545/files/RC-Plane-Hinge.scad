plate_width=15;
plate_length=15;
plate_thickness=1.5;
pin_diameter=1;
pin_surround=2.5;
glue_hole_diameter=3;
hinge_radius=(pin_diameter+(pin_surround*2))/2;
hinge_thickness=plate_width/3;

$fa=.5;
$fs=.5;

module base(){
	cube([plate_width,plate_length,plate_thickness]);}
module glue_holes(){
	translate([plate_width/4,plate_length/4,-0.1]){
		#cylinder(r=glue_hole_diameter/2,h=plate_thickness+2);
	}
	translate([plate_width/4*3,plate_length/4,-0.1]){
		#cylinder(r=glue_hole_diameter/2,h=plate_thickness+2);
	}
	translate([plate_width/4*3,plate_length/4*3,-0.1]){
		#cylinder(r=glue_hole_diameter/2,h=plate_thickness+2);
	}
	translate([plate_width/4,plate_length/4*3,-0.1]){
		#cylinder(r=glue_hole_diameter/2,h=plate_thickness+2);
	}
}
module hinge(){
	translate([hinge_thickness,-hinge_radius,hinge_radius]){
		rotate([0,90,0]){
			difference(){
				union(){
					cylinder(r=hinge_radius,h=hinge_thickness);
					difference(){
						rotate([0,0,45]){
							translate([0,-hinge_radius,0]){
							cube([hinge_radius*4.5,hinge_radius*2,hinge_thickness]);
							}
						}
						translate([hinge_radius,-hinge_radius,-hinge_thickness]){
							#cube([30,30,30]);
						}
					}
				}
				translate([-.1,0,0]){
					#cylinder(r=pin_diameter/2,h=hinge_thickness+.2);
				}
			}
		}
	}
}

difference(){
	union(){
		difference(){
			cube([plate_width,plate_length,plate_thickness]);
			rotate([45,0,0]){
				cube(plate_width,30,-30);
			}
		}	
		hinge();
	}
	glue_holes();
}

translate([plate_width+2,0,0]){
	difference(){
		union(){
			difference(){
			cube([plate_width,plate_length,plate_thickness]);
			rotate([45,0,0]){
				cube(plate_width,30,-30);
			}
		}
			translate([-plate_width/3,0,0]){
				hinge();
			}
			translate([plate_width/3,0,0]){
				hinge();
			}
		}
		glue_holes();
	}
	
}