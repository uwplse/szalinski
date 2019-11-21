/* [General] */

height = 15; // [1:50]


/* [Grip hole] */

diameter = 37.7; // [5:0.1:100]
border = 2.5; // [1:0.1:20]


/* [Teeth] */

teeth_number = 30; // [1:500]
teeth_height = 2; // [0.1:0.1:50]
teeth_width = 2; // [0.1:0.1:50]


/* [Handle] */

handle_width = 25; // [5:50]
handle_length = 90; // [50: 500]
handle_border = 2; // [1:0.1:25]


/* [Test] */

test = "false"; // [true, false]


/* [Hidden] */

subtract_safe = 1;
$fa = 0.1;
$fs = 1;


module oval(length, width, height) {
     translate([length / 2 - width / 2, 0, 0])
	  cylinder(r = width / 2, h = height);
     translate([-length / 2 + width / 2, 0, 0])
	  cylinder(r = width / 2, h = height);
     translate([0, 0, height / 2])
	  cube([length - width, width, height], center = true);
}

module solid() {
     union() {
	  translate([handle_length + diameter / 2 + border, 0, 0])
	       cylinder(d = diameter + border * 2, h = height);

	  if (test == "false") {
	       hull() {
		    translate([handle_length + diameter / 2 + border, 0, 0])
			 cylinder(d = diameter + border * 2, h = height);
		    translate([handle_length - handle_border, 0, 0])
			 cylinder(d = handle_width + handle_border, h = height);
	       }
	       
	       hull() {
		    translate([handle_length - handle_border, 0, 0])
			 cylinder(d = handle_width + handle_border, h = height);
		    translate([handle_length - handle_width, 0, 0])
			 cylinder(d = handle_width / 2 + handle_border * 3, h = height);
	       }
	       
	       hull() {
		    translate([handle_length - handle_width, 0, 0])
			 cylinder(d = handle_width / 2 + handle_border * 3, h = height);
		    translate([handle_length / 2, 0, 0])
			 cylinder(d = handle_width / 2 + handle_border * 2, h = height);
	       }
	       
	       hull() {
		    translate([handle_length - handle_width, 0, 0])
			 cylinder(d = handle_width / 2 + handle_border * 2, h = height);
		    translate([handle_width , 0, 0])
			 cylinder(d = handle_width / 2 + handle_border * 3, h = height);
	       }
	       
	       hull() {
		    translate([handle_length / 2, 0, 0])
			 cylinder(d = handle_width / 2 + handle_border * 2, h = height);
		    translate([handle_width / 2, 0, 0])
			 cylinder(r = handle_width / 2, h = height);
	       }
	       
	       translate([handle_width / 2, 0, 0])
		    cylinder(r = handle_width / 2, h = height);
	  }
     }
}

module holes() {
     union() {
	  translate([handle_length + diameter / 2 + border, 0, -subtract_safe])
	       cylinder(d = diameter, h = height + subtract_safe * 2);

	  if (test == "false") {
	       translate([handle_length / 2 + handle_width / 2, 0, -subtract_safe])
		    oval(handle_length - handle_width - handle_border * 2, handle_width * 5 / 12, height + subtract_safe * 2);
	       
	       translate([handle_width / 2, 0, -subtract_safe])
		    cylinder(r = handle_width / 2 - handle_border, h = height + subtract_safe * 2);
	  }
     }
}

module teeth() {
     translate([handle_length + diameter / 2 + border, 0, 0])
     union() {
	  for(i = [0:teeth_number]) {
	       rotate([0, 0, i * 360 / teeth_number])
		    translate([diameter / 2, 0, 0])
		    linear_extrude(height = height, convexity = 10, twist = 0)
		    polygon(points=[[-teeth_height, 0],[0, -teeth_width / 2],[0, teeth_width / 2]], paths=[[0, 1, 2]]);
	  }
     }
}

union() {
     difference() {
	  solid();
	  holes();
     }
     teeth();
}
