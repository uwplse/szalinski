/**** Settings ****/

handlebar_diameter = 23;
light_diameter = 26;

// The width of the handlebar mount
width = 26;

// The thickness of the walls (e.g. between the mounting brackets and the strap tunnels)
wall = 2.5;

// The amount of "snap" for the flashlight mount
snap = 4.5;

// Any extra height you want to add between the two strap tunnels
extra_height = 0;

// Angle the flashlight snap mount to compensate for an angle in your handlebars
light_angle = 0;

// Set this to the thickness of your straps, plus some wiggle room
strap_gap = 3;

// Set this to the width of your straps, plus some wiggle room
strap_width = 21;

quality = 2; // [1:5]


/**** Computed values ****/

/*
Notes:

The thing is made lying down. In the settings, "height" means y and "width" means x.
In the computed values, "height" means z, whereas y is called "length".

The handlebar mount is half a radius high. `block_height` is a simple `a^2 + b^2 = c^2`,
`a` being the unknown (the cross section of the circle at half a radius from the top)
*/

hb_r = handlebar_diameter / 2;
light_r = light_diameter / 2;

block_average_width = (width + light_diameter + 2*wall) / 2;
block_length = hb_r/2 + 3*wall + 2*strap_gap + extra_height + light_r + snap;
block_height = 2 * sqrt(pow(hb_r + wall, 2) - pow(hb_r / 2, 2));

$fn = quality * 30;


/**** Code! :D ****/

mount();

module mount() {
  difference() {
    body();
    handlebar_strap();
    light_strap();
  }
}

module body() {
  difference() {
    trimmed_body_hull();
    handlebar(extra=0, width=2*width);
    light(extra=0);
  }
}

module trimmed_body_hull() {
  difference() {
    body_hull();
    body_trim(1);
    body_trim(-1);
  }
}

module body_hull() {
  hull() {
    handlebar(extra=wall, width=width);
    light(extra=wall);
  }
}

module body_trim(direction=1) {
  translate([-block_average_width, 0, direction * block_height])
    cube([block_average_width*2, block_length, block_height]);
}

module handlebar(extra, width) {
  translate([-width/2, 0, block_height / 2])
    rotate([0, 90, 0])
    linear_extrude(height=width)
    handlebar2D(wall=extra);
}

module light(extra) {
  rotate([0, light_angle, 0])
    translate([0, block_length - snap, -block_height/2])
    linear_extrude(height=block_height*2)
    light2D(wall=extra);
}

module handlebar2D(wall=0) {
  difference() {
    translate([0, -hb_r/2])
      circle(r=hb_r + wall);
    translate([-handlebar_diameter, -handlebar_diameter])
      square([2*handlebar_diameter, handlebar_diameter]);
  }
}

module light2D(wall=0) {
  difference() {
    circle(r=light_r + wall);
    translate([-light_diameter, snap])
      square([2*light_diameter, 2*light_diameter]);
  }
}

module handlebar_strap() {
  translate([-strap_width/2, hb_r/2 + wall, hb_r + wall])
    rotate([0, 90, 0])
    linear_extrude(height=strap_width, convexity=2)
    strap_slot2D(block_average_width);
}

module light_strap() {
  translate([0, block_length - snap - light_r - wall, strap_width/2 + (block_height - strap_width)/2])
    rotate([0, -light_angle, 180])
    translate([0, 0, -strap_width/2])
    linear_extrude(height=strap_width, convexity=2)
    strap_slot2D(light_diameter);
}

module strap_slot2D(width) {
  translate([0, strap_gap - width/2])
  difference() {
    scale([1, 0.5])
    circle(r=width);
    translate([0, -strap_gap])
      scale([0.7, 0.5])
      circle(r=width);
    translate([-width, -width])
      square([2*width, width]);
  }
}
