barrel_diameter=33;
depth=30;
arm_length=100;

rotate([0,90,0]) intersection(){
	cube([depth+1,arm_length*2,barrel_diameter+14],center=true);
	difference(){
		union(){
			rotate([0,90,0]) cylinder(d=barrel_diameter+6,h=depth,center=true,$fa=5);
			rotate([-135,0,0]) translate([0,barrel_diameter/2,barrel_diameter/2]) cube([depth,barrel_diameter,barrel_diameter],center=true);
			//translate([-depth/2,0,-barrel_diameter/2-7]) cube([depth,arm_length,barrel_diameter/2+4]);
			translate([-depth/2,0,-barrel_diameter/2-7]) cube([depth,arm_length,7]);
			translate([-depth/2,0,-barrel_diameter/2]) cube([depth,barrel_diameter+3,barrel_diameter/2]);
		}
		union(){
			rotate([0,90,0]) cylinder(d=barrel_diameter,h=depth+1,center=true,$fa=5);
			translate([0,barrel_diameter+3,0]) rotate([0,90,0]) cylinder(d=barrel_diameter,h=depth+1,center=true,$fa=5);
			translate([0,0,barrel_diameter/2]) rotate([0,90,0]) cylinder(d=barrel_diameter,h=depth+1,center=true,$fa=5);
			rotate([135,0,0]) translate([0,0,barrel_diameter+3]) rotate([0,90,0]) cylinder(d=barrel_diameter,h=depth+1,center=true,$fa=5);
			//rotate([-135,0,0]) translate([0,0,barrel_diameter+3]) rotate([0,90,0]) cylinder(d=barrel_diameter,h=depth+1,center=true,$fa=5);
			translate([0,barrel_diameter+3,-barrel_diameter/2-3]) cylinder(h=10, d=6.35, center=true, $fn=32);
			translate([0,barrel_diameter+3,-barrel_diameter/2-5]) cylinder(h=10, d=12.4, $fa=60);
		}
	}
}