use <utils/build_plate.scad>
use <write/Write.scad>

// preview[view:south, tilt:top]

/* [Image] */

// Standard is 4:3 aspect ratio, HD is 16:9
picture_shape = "standard"; // [square:Square, standard:Standard Photo, hd:HD Wide]

picture_orientation = "horizontal"; // [horizontal, vertical]

// Chose small for a quick, less detailed print
pane_size = "large"; // [large, small]

// Simple photos with many shades of light/dark areas work best. Don't forget to click the Invert Colors checkbox!
image_file = "image-surface.dat"; // [image_surface:100x100]

/* [Adjustments] */

include_hole = "yes"; // [yes, no]
hole_diameter = 10;

// What layer height will you slice this at?  The thinner the better.
layer_height = 0.2;

// The lower the layer height, the more layers you can use.
number_of_layers = 12; // [8:20]

/* [Text] */

text_line_1 = "";
text_line_2 = "";
text_line_3 = "";
text_line_4 = "";
text_line_5 = "";

text_size = 10;
text_vertical_position = 0; // [-80:80]

// In case you like viewing the lithopane from the other side
text_reverse = "no"; // [no, yes]

/* [Hidden] */

// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
hole_radius = hole_diameter/2;
height = layer_height*number_of_layers;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2, 1:Replicator, 2:Thingomatic, 3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

preview_tab = "";

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

if (picture_shape == "square") {
  if (pane_size == "large") {
    lithopane(100, 100, 1, 1);
  } else {
    lithopane(50, 50, 0.5, 0.5);
  }
} else if (picture_shape == "standard") {
  if (picture_orientation == "horizontal") {
    if (pane_size == "large") {
      lithopane(133, 100, 4/3, 1);
    } else {
      lithopane(133/2, 100/2, (4/3)/2, 1/2);
    }
  } else {
    if (pane_size == "large") {
      rotate([0,0,90]) lithopane(100, 133, 1, 4/3);
    } else {
      rotate([0,0,90]) lithopane(100/2, 133/2, 1/2, (4/3)/2);
    }
  }
} else if (picture_shape == "hd") {
  if (picture_orientation == "horizontal") {
    if (pane_size == "large") {
      lithopane(177, 100, 16/9, 1);
    } else {
      lithopane(177/2, 100/2, (16/9)/2, 1/2);
    }
  } else {
    if (pane_size == "large") {
      rotate([0,0,90]) lithopane(100, 177, 1, 16/9);
    } else {
      rotate([0,0,90]) lithopane(100/2, 177/2, 1/2, (16/9)/2);
    }
  }
}

module lithopane(length, width, x_scale, y_scale) {
  union() {
    // take just the part of surface we want
    difference() {
      translate([0, 0, min_layer_height]) scale([x_scale,y_scale,height]) surface(file=image_file, center=true, convexity=5);
      translate([0,0,-(height+min_layer_height)]) linear_extrude(height=height+min_layer_height) square([length, width], center=true);
    }
    linear_extrude(height=layer_height*2) square([length+4, width+4], center=true);

    linear_extrude(height=height+min_layer_height) {
  	  difference() {
  		  union() {
  	      square([length+4, width+4], center=true);
  	      if (include_hole == "yes") {
            translate([0, width/2+hole_radius+2, 0]) circle(r=hole_radius+5);
          }
  		  }
        union() {
          square([length, width], center=true);
  	      if (include_hole == "yes") {
            translate([0, width/2+hole_radius+2, 0]) circle(r=hole_radius);
          }
        }
  	  }
    }
    
    // add optional text
    rotate_text() translate([0, text_vertical_position, height/2]) union() {
      translate([0, 30, 0])  write(text_line_1, t=height, h=text_size, center=true);
      translate([0, 15, 0])  write(text_line_2, t=height, h=text_size, center=true);
      translate([0, 0, 0])   write(text_line_3, t=height, h=text_size, center=true);
      translate([0, -15, 0]) write(text_line_4, t=height, h=text_size, center=true);
      translate([0, -30, 0]) write(text_line_5, t=height, h=text_size, center=true);
    }
  }
}

module rotate_text() {
  if (text_reverse == "yes") {
    translate([0, 0, height]) rotate([0, 180, 0]) child(0);
  } else {
    translate([0, 0, 0]) rotate([0, 0, 0]) child(0);
  }
}
