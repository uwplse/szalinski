// title: Customizable Circular Motor Mount
// project: 3D Models - Physics 12
// author: Ben Zhang
// license: Creative Commons CC BY-SA 3.0
// URL: http://www.thingiverse.com/thing:707732
// Repository: https://github.com/ben-z/3D-Models-Physics-12
// revision: 0.1
// tags: Motor_Mount, Customizable, OpenSCAD, SU-34

/* [General] */

// Radius of the motor mount (mm) [Default: 44]
radius = 22;

// Thickness of the motor mount (mm) [Default: 3]
thickness = 3;

// Resolution of the model (mm) [Default: 50]
resolution = 50;

/* [Inner Circle] */

// Radius of the inner circle (mm) [Default: 4.5]
inner_radius = 4.5;

/* [Outer Holes] */

outer_hole_1_radius = 1;
outer_hole_1_offset = 16;
outer_hole_1_angle = 45;
outer_hole_2_radius = 1;
outer_hole_2_offset = 16;
outer_hole_2_angle = 135;
outer_hole_3_radius = 1;
outer_hole_3_offset = 16;
outer_hole_3_angle = 225;
outer_hole_4_radius = 1;
outer_hole_4_offset = 16;
outer_hole_4_angle = 315;

/* [Inner Holes] */

inner_hole_1_radius = 2;
inner_hole_1_offset = 10;
inner_hole_1_angle = 45;
inner_hole_2_radius = 2;
inner_hole_2_offset = 9;
inner_hole_2_angle = 135;
inner_hole_3_radius = 2;
inner_hole_3_offset = 10;
inner_hole_3_angle = 225;
inner_hole_4_radius = 2;
inner_hole_4_offset = 9;
inner_hole_4_angle = 315;

/* [Side Cuts] */

cut_1_width = 5.6;
cut_1_depth = 6.2;
cut_1_angle = 0;
cut_2_width = 5.6;
cut_2_depth = 6.2;
cut_2_angle = 90;
cut_3_width = 5.6;
cut_3_depth = 6.2;
cut_3_angle = 180;
cut_4_width = 5.6;
cut_4_depth = 6.2;
cut_4_angle = 270;

/* [Hidden] */
$fn=resolution;
thickness_diff_obj = thickness + 1;

motor_mount();

//inner_circle();

//outer_holes();

//inner_holes();

//side_cuts();

module motor_mount(){
  difference(){
    cylinder(r=radius, h=thickness, center=true);
    inner_circle();
    outer_holes();
    inner_holes();
  side_cuts();
  }
}

module inner_circle(){
  cylinder(r=inner_radius, h=thickness_diff_obj, center=true);
}

module outer_holes(){
  rotate([0,0,outer_hole_1_angle]){
    translate([outer_hole_1_offset,0,0]){
      cylinder(r=outer_hole_1_radius, h=thickness_diff_obj, center=true);
    }
  }  
  rotate([0,0,outer_hole_2_angle]){
    translate([outer_hole_2_offset,0,0]){
      cylinder(r=outer_hole_2_radius, h=thickness_diff_obj, center=true);
    }
  }
  rotate([0,0,outer_hole_3_angle]){
    translate([outer_hole_3_offset,0,0]){
      cylinder(r=outer_hole_3_radius, h=thickness_diff_obj, center=true);
    }
  }
  rotate([0,0,outer_hole_4_angle]){
    translate([outer_hole_4_offset,0,0]){
      cylinder(r=outer_hole_4_radius, h=thickness_diff_obj, center=true);
    }
  }
}

module inner_holes(){
  rotate([0,0,inner_hole_1_angle]){
    translate([inner_hole_1_offset,0,0]){
      cylinder(r=inner_hole_1_radius, h=thickness_diff_obj, center=true);
    }
  }  
  rotate([0,0,inner_hole_2_angle]){
    translate([inner_hole_2_offset,0,0]){
      cylinder(r=inner_hole_2_radius, h=thickness_diff_obj, center=true);
    }
  }
  rotate([0,0,inner_hole_3_angle]){
    translate([inner_hole_3_offset,0,0]){
      cylinder(r=inner_hole_3_radius, h=thickness_diff_obj, center=true);
    }
  }
  rotate([0,0,inner_hole_4_angle]){
    translate([inner_hole_4_offset,0,0]){
      cylinder(r=inner_hole_4_radius, h=thickness_diff_obj, center=true);
    }
  }
}

module side_cuts(){
  rotate([0,0,cut_1_angle]){
    translate([radius - cut_1_depth / 4,0,0]){
      cube(size=[cut_1_depth*2, cut_1_width, thickness_diff_obj], center=true);
    }
  }
  rotate([0,0,cut_2_angle]){
    translate([radius - cut_2_depth / 4,0,0]){
      cube(size=[cut_2_depth*2, cut_2_width, thickness_diff_obj], center=true);
    }
  }
  rotate([0,0,cut_3_angle]){
    translate([radius - cut_3_depth / 4,0,0]){
      cube(size=[cut_3_depth*2, cut_3_width, thickness_diff_obj], center=true);
    }
  }
  rotate([0,0,cut_4_angle]){
    translate([radius - cut_4_depth / 4,0,0]){
      cube(size=[cut_4_depth*2, cut_4_width, thickness_diff_obj], center=true);
    }
  }
}
