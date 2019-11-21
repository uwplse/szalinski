// variables
length = 20; // [10:400]
width = 10; // [10:400]
height = 30; // [1:400]
radius = 2; // [2:31]
wallthickness = 1; // [1:30]
// model
difference(){
	hull(){
		translate([(length-2*radius)/2,(width-2*radius)/2,0]) cylinder(h=height,d=2*radius,center=true,$fn=100);
		translate([-(length-2*radius)/2,(width-2*radius)/2,0]) cylinder(h=height,d=2*radius,center=true,$fn=100);
		translate([(length-2*radius)/2,-(width-2*radius)/2,0]) cylinder(h=height,d=2*radius,center=true,$fn=100);
		translate([-(length-2*radius)/2,-(width-2*radius)/2,0]) cylinder(h=height,d=2*radius,center=true,$fn=100);
	}
	hull(){
		translate([(length-2*radius)/2,(width-2*radius)/2,0]) cylinder(h=height,d=2*(radius-wallthickness),center=true,$fn=100);
		translate([-(length-2*radius)/2,(width-2*radius)/2,0]) cylinder(h=height,d=2*(radius-wallthickness),center=true,$fn=100);
		translate([(length-2*radius)/2,-(width-2*radius)/2,0]) cylinder(h=height,d=2*(radius-wallthickness),center=true,$fn=100);
		translate([-(length-2*radius)/2,-(width-2*radius)/2,0]) cylinder(h=height,d=2*(radius-wallthickness),center=true,$fn=100);
	}
}
