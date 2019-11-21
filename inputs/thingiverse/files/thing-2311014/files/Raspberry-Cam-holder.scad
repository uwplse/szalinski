tolerance = 0.5;


module camholder() {
	 //color("red")cube([25,24,1],center=true);
 union(){
	 difference(){
	  union(){
	   translate([0,24/2+4/2,0])cube([29,4,4],center=true);
	   translate([25/2+4/2-1,4/2,0])cube([4,24+4,4],center=true);
	   translate([-25/2-4/2+1,4/2,0])cube([4,24+4,4],center=true);
	  }
	  color("blue")cube([25+2*tolerance,24+tolerance,1+tolerance],center=true);
	 }
	 difference() {
	  translate([0,2,7]) union() difference(){
			cube([35,28,10],center=true);
			translate([0,-2,-4]) color("red")cube([23,24+tolerance,2.1],center=true);
		 }
	translate([0,0,6.5]) group() {
		rotate([90,0,90]) translate([8,0,15.2]) cylinder(7,2,4,center=true);
		rotate([90,0,-90]) translate([-8,0,15.2]) cylinder(7,2,4,center=true);
	}
}
}
}


translate([-34,0,2])rotate([180,0,180])camholder();