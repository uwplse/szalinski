hole_diameter = 8;
diameter = 50.4;
resolution = 180;
friction_fit = false;


difference(){
    union(){
        cylinder(r = diameter/2, h = 15, $fn = resolution);
        cylinder(r = (diameter/2)+3, h = 3, $fn = resolution);
    }
    union(){
        translate([0, 0, 3]){
            cylinder(r = (diameter/2)-3, h = 15, $fn = resolution);
        }
        cylinder(r = hole_diameter/2, h = 3, $fn = resolution);
        translate([11.1, 0, 0]){
            tiehole();
        }
        translate([-11.1, 0, 0]){
            tiehole();
        }
        translate([0, 11.1, 0]){
            tiehole();
        }
        translate([0, -11.1, 0]){
            tiehole();
        }
		rotate([0, 0, 45]){
			translate([0, sqrt(61.605), 0.75]){
				tieslot();
			}
			translate([0, -sqrt(61.605), 0.75]){
				tieslot();
			}
		}
    }
}
module tiehole(){
	if(friction_fit == false){
		cylinder(r = 1.5, h = 3, $fn = resolution);
	}
}
module tieslot(){
	if(friction_fit == false){
		cube([sqrt(246.42), 3, 1.5], center = true);
	}
}