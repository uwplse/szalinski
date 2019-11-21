// Which one would you like to see?
part = "both"; // [both:Entire Pen Holder,colorA:bottom and half of the helixes,colorB:top and other half of the helixes]

h= 110; // [30:1000]
r = 35; // [14:500]

spiralTwist = 1; // [0:0.05:4]
spiral_r = 3; // [1:0.5:5]

/* [Hidden] */
spiralDivision = 2*(round(r/10)+1);
i = 360/r;
j = 360/spiralDivision;


////Image engraving on bottom plate?
//engrave = "no";
//
//image = "zia_200x200.png";
//
//logox = 500;
//logoy = 500;

module spiralA(){
	union(){
		translate([0,0,-4]) cylinder(r=r+3,h=4,$fn=2*spiralDivision);
		for (x = [0:j:360]) {
			rotate ([0,0,x]) linear_extrude(height = h, center = false, convexity = 10, twist = spiralTwist*h, slices = h) translate([r, 0, 0]) rotate([0,0,0]) circle(r = spiral_r, $fn=5);
		}
	}
}

module spiralB(){
	union(){
		for (x = [180/spiralDivision:j:360]) {
			rotate ([0,0,x]) linear_extrude(height = h, center = false, convexity = 10, twist = -spiralTwist*h, slices = h) translate([r, 0, 0]) rotate([0,0,0]) circle(r = spiral_r, $fn=5);
		}
		difference() {
			translate([0,0,h]) cylinder(r=r+3,h=4,$fn=2*spiralDivision);
			translate([0,0,h]) cylinder(r=r-3,h=4,$fn=2*spiralDivision);
		}
	}
}

module print_part() {
	if (part == "colorA") {
		spiralA();
	} else if (part == "colorB") {
		difference(){
			spiralB();
			spiralA();
		}
	} else {
		union(){
			spiralA();
			spiralB();
		}
	}
}

//if (engrave == "yes") {
//	difference(){
//		translate([0,0,4]) print_part();
//		translate([0,0,4])	
//			scale([1.6*r/logox,1.6*r/logoy,0.01])
//				rotate([0,0,-j/4])
//					#surface(file = image, center=true,invert=true);
//	}
//} else {
	translate([0,0,4]) print_part();
//}