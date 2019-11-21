include <MCAD/Shapes.scad> 

inner=24;
thickness=3;
feet=5;
height=20;
footLen=40;

//--------
innerRad=inner/2;

module ecigHolder(){
	difference(){
		union(){
			cylinder(r=innerRad+thickness, h=height);
			translate([0,0,-height/4])cylinder(r2=innerRad+thickness, r1=innerRad/2, h=height/2, center=true);
		}
		translate([0,0,4])cylinder(r=innerRad, h=height);
	}
	for (foot = [0 : feet-1]){
		rotate([0,0,foot*(360/feet)])translate([footLen*.7, 0, -5])minkowski(){
			difference(){
				translate([0,0,-4])rotate([0,30,0])cube([footLen, 3, 20], center=true);
				translate([0,0,15])rotate([0,0,0])cube([footLen, 3+1, 15], center=true);
				translate([8,0,-13.3])rotate([0,0,0])cube([footLen*2, 3+1, 20], center=true);
			}
			sphere(r=2);
		}
	}
}

ecigHolder();