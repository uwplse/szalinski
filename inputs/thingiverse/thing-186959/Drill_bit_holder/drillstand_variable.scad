bit_angle = 45; // [10:90]
bit_diameter = 5; // [1.0:14.0]
module holder(diameter, angle){
	$fn=64;
	module notch(){
		rotate([0,0,45])
		translate([-.5,-.5,-200])
		cube([1,1,500]);
	}
	difference(){
		difference(){
			union(){
				difference(){
					translate([0,-30,0])
					cube([15,60,15]);
					translate([7.5,-30,0])
					notch();
					translate([7.5,30,0])
					notch();	
				}
				rotate([90-angle,0,0])
				cube([15,15,40]);
			}
			rotate([90-angle,0,0])
			translate([7.5,7.5,-50])
			cylinder(h=200,r=diameter/2);
		}
		translate([0,7.5/cos(90-angle),0])
		notch();
		translate([15,7.5/cos(90-angle),0])
		notch();
	}
}
holder(bit_diameter,bit_angle);