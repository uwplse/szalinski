// Which one would you like to see?
part = "both"; // [both:Entire Pen Holder,colorA:bottom and half of the helixes,colorB:top and other half of the helixes]

//Do you want to print supporting spirals?
print_supports = "yes"; // [yes,no]

h=110; // [30:1000]
r = 35; // [14:500]

/* [Hidden] */
i = 360/r;
j = (360/r);
supportTwist = 3;
supportDivision = round(r/10)-1;



//Image engraving on bottom plate?
//engrave = "yes";
//
//image = "zia_500x500.png";
//
//logox = 500;
//logoy = 500;

module doubleHelix(){
	linear_extrude(height = h, center = false, convexity = 10, twist = 18*h, slices = 2*h) translate([2, 0, 0]) circle(r = 1, $fn=5);
	rotate ([0,0,180]) linear_extrude(height = h, center = false, convexity = 10, twist = 18*h, slices = 2*h) translate([2, 0, 0]) circle(r = 1, $fn=5);
}

module helixA(){
	linear_extrude(height = h, center = false, convexity = 10, twist = 18*h, slices = 2*h) translate([2, 0, 0]) circle(r = 1, $fn=5);
//	rotate ([0,0,180]) linear_extrude(height = h, center = false, convexity = 10, twist = 18*h, slices = 2*h) translate([2, 0, 0]) circle(r = 1, $fn=5);
}

module helixB(){
//	linear_extrude(height = h, center = false, convexity = 10, twist = 18*h, slices = 2*h) translate([2, 0, 0]) circle(r = 1, $fn=5);
	rotate ([0,0,180]) linear_extrude(height = h, center = false, convexity = 10, twist = 18*h, slices = 2*h) translate([2, 0, 0]) circle(r = 1, $fn=5);
}

module colorA(){
	union(){
		translate([0,0,-4]) cylinder(r=r+3,h=4,$fn=360/i);
		for (x =[0:i:360]) {
			translate([r*cos(x),r*sin(x),0]) rotate([0,0,x]) helixA();
			}
	}
}

module colorB(){
	union(){
		for (x =[0:i:360]) {
			translate([r*cos(x),r*sin(x),0]) rotate([0,0,x]) helixB();
			}
		difference() {
			translate([0,0,h]) cylinder(r=r+3,h=4,$fn=360/i);
			translate([0,0,h]) cylinder(r=r-3,h=4,$fn=360/i);
		}
	}
}

module support_spiralA(){
	for (x = [0:360/supportDivision:360-j]) {
		rotate ([0,0,x]) linear_extrude(height = h, center = false, convexity = 10, twist = supportTwist*h, slices = h) translate([r, 0, 0]) rotate([0,0,0]) circle(r = 3, $fn=5);
	}
}

module support_spiralB(){
	for (x = [180/supportDivision:360/supportDivision:360-j]) {
		rotate ([0,0,x]) linear_extrude(height = h, center = false, convexity = 10, twist = supportTwist*h, slices = h) translate([r, 0, 0]) rotate([0,0,0]) circle(r = 3, $fn=5);
	}
}

module print_part() {
		if (part == "colorA") {
			union(){
				colorA();
				if (print_supports == "yes") support_spiralA();
			}
		} else if (part == "colorB") {
			difference(){
				union(){
					colorB();
					if (print_supports == "yes") support_spiralB();
				}
				colorA();
				if (print_supports == "yes") support_spiralA();
			}
		} else {
			union(){
				colorA();
				colorB();
				if (print_supports == "yes") support_spiralA();
				if (print_supports == "yes") support_spiralB();
			}
		}
}

//if (engrave == "yes") {
//	difference(){
//		translate([0,0,4]) print_part();
//		translate([0,0,4])	
//			scale([1.6*r/logox,1.6*r/logoy,0.01])
//				surface(file = image, center=true,invert=true);
//	}
//} else {
	translate([0,0,4]) print_part();
//}