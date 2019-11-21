tolerance = 0.1;
captive_nut = 1; //Set to something else if you'd rather screw directly into plastic
$fn = 60;

difference() {

	union() {
		//Main wheel and tapered faces
		cylinder(r=30, h=20, center=true);
		translate([0,0,-20/2-7/2]) cylinder(r1=24, r2=26, h=7, center=true);
		translate([0,0,20/2+7/2]) cylinder(r1=26, r2=24, h=7, center=true);
		//This should probably just be mirriored, but I'm too lazy.

		//The base
		translate([15,0,0]) rotate([0,90,0]) cylinder(r=25/2, h=30, center=true);
	}

	union(){
		translate([0,0,19/2+7]) cylinder(r=19/2, h=4, center=true);
		translate([0,0,-19/2-7]) cylinder(r=19/2, h=4, center=true);

		if(captive_nut==1){
			rotate([90,0,0]) translate([tolerance, 0, 0]) rotate([0,90,0]) cylinder(r=15/2+tolerance, h=32+tolerance, $fn=6);
		} else {
			translate([-tolerance, 0, 0]) rotate([0,90,0]) cylinder(r=7/2+tolerance,h=32+tolerance);
		}
	}
}