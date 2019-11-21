
/* [Base] */

// Base height (mm)
base_height=2;

// Fan body size (mm)
fan_size=60;

// Diameter of the helice hole
fan_hole_diameter=70;



/* [Fixation] */

// Screw diameter (mm)
base_screw_diameter=4.3;

// Margin with border (mm)
base_screw_margin=3;



/* [Duct] */

// Duct shape
duct_shape = "squared"; // [rounded, squared, heart]

// Duct height
duct_height=20;

// Scale over X (% of fan_hole_diameter)
duct_width=.80;
// Scale over Y (% of fan_hole_diameter)
duct_length=.50;

// Hole orientation over X
duct_rotation_x=20; // [-30:30]
// Hole orientation over Y
duct_rotation_y=0; // [-30:30]
// Hole orientation over Z
duct_rotation_z=0; // [-30:30]

// Distance from center X
duct_delta_x=0;
// Distance from center X
duct_delta_y=5;

// Border thickness
duct_border_width=2;



/* [Hidden] */

// Main Object

//difference() {
union() {
  base();
  duct();
}
/*translate([0, -100, -50])
cube([100, 100, 100]);
}*/

//translate([0, 0, 50]) _duct_top_form_heart();



// build the duct base
module base() {
  difference() {
    _base_form();
    _fan_hole_form(base_height+1, duct_border_width);
    _screw();
  }
}



module _screw() {
  $fn=12;
  // holes Position var
  s_hole=fan_size/2-base_screw_margin;

  translate([s_hole, s_hole, 0])
    cylinder(r=base_screw_diameter/2, h=base_height+2, center=true);
  translate([-s_hole, -s_hole, 0])
    cylinder(r=base_screw_diameter/2, h=base_height+2, center=true);
  translate([s_hole, -s_hole, 0])
    cylinder(r=base_screw_diameter/2, h=base_height+2, center=true);
  translate([-s_hole, s_hole, 0])
    cylinder(r=base_screw_diameter/2, h=base_height+2, center=true);
}



// build the duct
module duct() {
  difference() {
    // outter
    _duct();
    // inner
    _duct(duct_border_width);

    //top hole
      _duct_top_form(2,duct_border_width);

    // bottom hole
    translate([0, 0, -1])
      _fan_hole_form(2, duct_border_width);
  }
}



module _duct(margin=0) {
    hull() {
      // top
      _duct_top_form(0.1, margin);
      // bottom
      _fan_hole_form(base_height, margin);
    }
}



module _duct_top_form(height=0.1, margin=0) {
  translate([duct_delta_x, duct_delta_y, duct_height])
    rotate([duct_rotation_x, duct_rotation_y, duct_rotation_z])
      scale([
      duct_width-(margin/fan_hole_diameter),
      duct_length-(margin/fan_hole_diameter),
       1])

    if (duct_shape == "rounded") {
      _duct_top_form_rounded(height, margin);
    } else if 	(duct_shape == "squared") {
      _duct_top_form_squared(height, margin);
    } else if 	(duct_shape == "heart") {
      _duct_top_form_heart(height, margin);
    }
}



module _duct_top_form_rounded(height=0.1, margin=0) {
      cylinder(r=(fan_hole_diameter-margin)/2, h=height, center=true);
}



module _duct_top_form_squared(height=0.1, margin=0) {
      cube([(fan_hole_diameter-margin), (fan_hole_diameter-margin), height], center=true);
}



module _duct_top_form_heart(height=0.1, margin=0) {
  rotate([0, 0, -45])
    union () {
      cube([(fan_hole_diameter-margin)/2, (fan_hole_diameter-margin)/2, height], center=true);
      translate([-(fan_hole_diameter-margin)/4, 0, 0])
        cylinder(r=(fan_hole_diameter-margin)/4, h=height, center=true);
      translate([0, (fan_hole_diameter-margin)/4, 0])
        cylinder(r=(fan_hole_diameter-margin)/4, h=height, center=true);
    }
}



// get the hole form
module _fan_hole_form(height=base_height, margin=0) {
  intersection() {
    _base_form(height, margin);
    cylinder(r=(fan_hole_diameter)/2-margin, h=height, center=true);
  }
  
}



// get the base form
module _base_form(height=base_height, margin=0) {
  intersection() {
    cube([fan_size-margin, fan_size-margin, height], center=true);
    cylinder(r=sqrt(2*fan_size/2*fan_size/2)-duct_border_width/2, h=height, center=true);
  }
}

















