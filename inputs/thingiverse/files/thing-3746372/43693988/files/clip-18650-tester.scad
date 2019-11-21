module xhole(radius, length) {
	rotate(a=[0,90,0]) cylinder(r=radius,h=length+1,center=true, $fn=100);
}

module batteryClip(width, length, thickness,end_thickness) {
	difference() {
		union() {
			rotate([0,90,0]) cylinder(r=thickness+width/2,h=2*end_thickness+length,$fn=30,center=true,,$fn=100);
			translate([0,0,-thickness/2-width/4]) cube([2*end_thickness+length,2*thickness+width,thickness+width/2], center=true);
		}
		#rotate([0,90,0]) cylinder(r=width/2,h=length,$fn=30,center=true,$fn=100);
		translate([0,0,width/1.9]) cube([length,width+2*thickness+1,width],center=true);

		translate([0,0,0]) xhole(12/2,length+2*end_thickness+1);
		//translate([0,-1.5,0]) xhole(.75,length+2*thickness+1);
        translate([length/2.37,0,0]) rotate([90,-5,0])cylinder(d=width-7,h=width+2*thickness+1,center=true, $fn=4);
        translate([-length/2.37,0,0]) rotate([90,5,0])cylinder(d=width-7,h=width+2*thickness+1,center=true, $fn=4);
		translate([length/3.5,0,0]) cube([length/3.5,width+2*thickness+1,width-7], center=true);
		translate([-length/3.5,0,0]) cube([length/3.5,width+2*thickness+1,width-7], center=true);
	}
}
//18650 (tester, 9mm at +, 15mm at -
batteryClip(18.2,65+9+15,2,4);