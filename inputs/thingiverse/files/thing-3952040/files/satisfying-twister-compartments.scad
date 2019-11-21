// Customizable twister
// Copyright (C) 2017 Lars Christensen
// Idea from Make Anything

// Which one would you like to see?
part = "both"; // [inner:Inner twister,outer:Outer twister,both:Both twisters,assembled:Assembled]

// Height of twisting part (mm)
height = 10; // [5:600]

// From top to bottom of outer part (degrees)
twist = 120; // [-1000:1000]

// Number of side of the regular polygon
sides = 6; // [2:20]

// Inner part maximum radius (mm)
radius = 16; // [1:300]

// (mm)
smoothing_radius = 10; // [0:40]

// Printing line width (typically same as nozzle size)
line_width = 0.4; // [0.05:0.01:1.0]

// Gap between parts (increase if parts are too tight)
deviation = 0.3; // [0.0:0.01:2.0]

// Twist resolution (polygon height, in mm)
vertical_resolution = 0.4; // [0.1:0.1:10.0]

// Chamfer depth
chamfer_depth = 0.4; // [0.05:0.05:2.0]

// Chamfer height (recommended 2x chamfer depth)
chamfer_height = 0.8; // [0.05:0.05:2.0]

// Set to match the bottom layers height (inner part is shortened by this amount)
bottom_height = 0.8; // [0:10]

// Set Wall thicness
wall_thickness = 0.8; //[0:10]

// Set number of Compartments
compartment_number=6; //[1:20]

total_offset = line_width + deviation;
slices = height / vertical_resolution; // vertical resolution
inner_radius = max(radius - smoothing_radius, 1);

// Base 2D shape. Only convex shapes work with this script due to the
// way the chamfers are created.
module base(r=inner_radius,w=wall_thickness) {
     if (sides > 2) {
	  difference(){
            offset(r = smoothing_radius, $fn = 64) circle($fn = sides, r = r);
            offset(r = smoothing_radius, $fn = 64) circle($fn = sides, r = r-w);
      }
     } else {
         difference(){
	  hull() {
	       translate([r/2,0,0]) circle(r = smoothing_radius);
	       translate([-r/2,0,0]) circle(r = smoothing_radius);
	  }
	  hull() {
	       translate([r/2,0,0]) circle(r = smoothing_radius-w);
	       translate([-r/2,0,0]) circle(r = smoothing_radius-w);
	  }
  }
     }
}

module hollow_chanfer(r){
    difference(){
      hull() {
        children([0:$children-1]);
     }
     translate([0,0,-chamfer_height-0.001])linear_extrude(height = chamfer_height+0.003) base(r=r-wall_thickness,w=r);
 }
}

module inner() {
     inner_height = height // twisty part
	  + chamfer_height // plus the chamfer on the bottom part
	  - bottom_height // minus the filled in layers
	  - chamfer_height; // minus the chamfer on the inner part;
     inner_twist = twist * inner_height / height;
     // twister body
     linear_extrude(height = inner_height, slices = slices, twist = inner_twist) base();
     // top chamfer
     translate([0, 0, inner_height])
	  hollow_chanfer(inner_radius) {
     rotate(-twist, [0, 0, 1])
	  translate([0, 0, chamfer_height])
	       linear_extrude(height = 0.001)
	       offset(r = -chamfer_depth) base();
     rotate(-inner_twist, [0, 0, 1])
	  linear_extrude(height = 0.001) base();
     }
     // bottom chamfer
     hollow_chanfer(inner_radius) {
        linear_extrude(height = 0.001) base();
        translate([0, 0, -chamfer_height])
            linear_extrude(height = 0.001) offset(r = chamfer_depth) base();
     }
     // base
     translate([0,0,-chamfer_height  - wall_thickness])
	  linear_extrude(height = wall_thickness) offset(r = chamfer_depth) base(w=inner_radius);
     // compartments
     compartments();
}

module compartments(){
     inner_height = height // twisty part
	  + chamfer_height // plus the chamfer on the bottom part
	  - bottom_height // minus the filled in layers
	  - chamfer_height; // minus the chamfer on the inner part;
     inner_twist = twist * inner_height / height;
    if (compartment_number > 1){
        intersection(){
            linear_extrude(height = inner_height, slices = slices, twist = inner_twist) base(r=inner_radius-wall_thickness,w=inner_radius);
            for(i = [0:360/compartment_number:360-360/compartment_number]){
                rotate([0,0,i])translate([0,-wall_thickness/2,0])cube([radius,wall_thickness,inner_height]);
            }
       }
    }
}

module outer() {
     // twister body
     linear_extrude(height = height,
		    slices = slices,
		    twist = twist)
	  base(r=inner_radius+total_offset);
     // bottom chamfer
     hull() {
	  linear_extrude(height = 0.001) offset(r = total_offset) base();
	  translate([0,0,-chamfer_height])
	       linear_extrude(height = 0.001) offset(r = total_offset - chamfer_depth) base();
     }
}

if (part == "both") {
     translate([0,0,chamfer_height+wall_thickness])color("LawnGreen") inner();
     translate([2 * radius + 10,0,chamfer_height]) color("FireBrick") outer();
} else if (part == "inner") {
     color("LawnGreen") inner();
} else if (part == "outer") {
     color("FireBrick") outer();
} else if (part == "assembled") {
     inner();
     % translate([0, 0, height])
	    rotate(180, [1, 0, 0])
	    rotate(twist, [0, 0, 1])
	    outer();
} else if (part == "animated") {
     inner();
     h = 0.5 * height + 0.5 * height * sin($t * 360);
     % translate([0,0,2 * height - h])
	    rotate(180,[1,0,0])
	    rotate(2 * twist - twist * h / height, [0,0,1])
	    outer();
}
