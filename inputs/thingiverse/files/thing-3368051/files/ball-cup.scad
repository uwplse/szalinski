//-------------------------------------------------------------------------------------------------
// Ball-Cup Rod Ends
//
// Suggested cura settings:
//  Layer Height: 0.1,  Wall Thickness: 1.2,  Top/Bottom Thickness: 1.2,
//  Top/Bottom Pattern: Concentric, Infill Density: 20%,  Infill Pattern: Grid,
//  Generate Support, Support Pattern: Lines, Support Placement: Touching Buildplate
//
//-------------------------------------------------------------------------------------------------


ball_center_to_rod_end   = 25;    // Distance between ball center and rod end
ball_dia                 = 9.75;  // Ball diameter was measured to be 9.55 mm
ball_cup_wall            = 1.2;   // Thickness of ball cup wall
ball_cup_rim_height      = 1.4;   // Low enough to avoid contact with carriage and effector
ball_cup_bottom_hole     = 6.8;   // Set to 0 for no hole. Not accurate, adjust to liking

cone_tip_to_ball         = 4;     // Far enough to avoid contact with carriage and effector
cone_length              = 7;     // Long enough to avoid contact with carriage and effector

rod_insert_length        = 15;    // How far the rod inserts goes into the rods
rod_outer_dia            = 8;     // Rod outer diameter
rod_inner_dia            = 5.9;   // Rod inner diameter
rod_insert_width         = 1.6;   // Thickness of the rod insert cross. Or whatever you call it...

hole_dia                 = 1.5;   // Set to slightly larger than the spring mount wire diameter
hole_rim_height          = 1.2;   // How much the rim protrudes
hole_rim_wall            = 2.4;   // Hole wall thickness
hole_to_cone_base        = 3;     // Distance from center of hole to wide end of cone

bottom_shave_distance    = 4.5;   // From center of ball, 0 to disable. Purely aesthetic, adjust to liking


$fn = 100; // Set this to 20 for fast render, or 100 or more for smooth surfaces


//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
//***** calculate ball cup outer diameter
ext_dia = ball_dia + 2 * ball_cup_wall;

//***** This is where we call modules and have the parts drawn.
//***** It was rotated 180° only to make it look nice in the thingiverse rendered image :)

rotate(180, 0, 0) {
 difference() {
  body();
  cup_bottom_hole();
  shave_bottom();
 }
}


//-------------------------------------------------------------------------------------------------
//***** Here be modules


module body() {
 cup();
 section_between_cup_and_cone();
 cone();
 mid_section();
 rod_insert();
}


//***** a cube used for shaving off the bottom, in case you think it will look nice...
module shave_bottom() {
 if(bottom_shave_distance > 0) {
  translate([-(ball_center_to_rod_end + rod_insert_length)/2, 0, -ball_dia - bottom_shave_distance]) {
    cube([(ball_center_to_rod_end + rod_insert_length)*2, ball_dia*3, ball_dia*2], center = true);
  }
 }
}

//***** a cone for cutting a hole at the top of the cup
module cup_bottom_hole() {
 //translate([0, 0, -ball_dia]) { cylinder(d = ball_cup_top_hole, h = ball_dia); }
 rotate([180,0,0]) {cylinder(d1 = ball_cup_bottom_hole/2, d2 = ball_cup_bottom_hole, h = ball_dia/2 + ball_cup_wall + 0.01); }
}


//***** cup
module cup() {
 difference() {
  sphere(d = ext_dia);
  translate([-ext_dia/2, -ext_dia/2, 0]) {
   cube([ext_dia, ext_dia, ext_dia/2]);
  }
  sphere(d = ball_dia);
 }

 difference() {
  cylinder(h = (ball_cup_rim_height), r1 = ext_dia/2, r2 = ext_dia/2, center = false);
  translate([0,0,-0.001]) { 
   cylinder(h = (ball_cup_rim_height + 0.002), r1 = ball_dia/2, r2 = ball_dia/2, center = false);
  }
 }    
}


//***** section_between_cup_and_cone
module section_between_cup_and_cone() {
 difference() {
  rotate(a = [0, 270, 0]) {
   cylinder(h = (cone_length + ball_dia/2 + cone_tip_to_ball), r1 = ext_dia/2,
            r2 = rod_outer_dia/2, center = false);
  }
  translate([-(cone_length + ball_dia/2 + cone_tip_to_ball),-(ext_dia + rod_outer_dia)/2,0]) {
    cube([(cone_length + ball_dia/2 + cone_tip_to_ball), ext_dia + rod_outer_dia, ext_dia + rod_outer_dia]);
  }
  sphere(d = ext_dia);
 }
}


//***** cone
module cone() {
 translate([-(ball_dia/2 + cone_tip_to_ball),0,0]) { rotate(a = [0, 270, 0]) {
  cylinder(h = cone_length, r1 = 0, r2 = rod_outer_dia/2, center = false); } 
 }
}


//***** mid_section, between cone and rod insert
module mid_section() {
 difference() {
  mid_section_body();
  mid_section_cutout();
 }
}


module mid_section_body() {
 //***** The body
 translate([-(cone_length + ball_dia/2 + cone_tip_to_ball),0,0]) {
  rotate(a = [0, 270, 0]) {
   cylinder(h = ball_center_to_rod_end - (cone_length + ball_dia/2 + cone_tip_to_ball),
            r1 = rod_outer_dia/2, r2 = rod_outer_dia/2, center = false);
  }
 }
 //***** Spring hole walls
 translate([-(cone_length + ball_dia/2 + cone_tip_to_ball + hole_to_cone_base),
           (rod_outer_dia + hole_rim_height)/2,0]) {
  rotate(a = [90, 0, 0]) {
   cylinder(h = rod_outer_dia + hole_rim_height, r1 = (hole_dia + hole_rim_wall)/2,
            r2 = (hole_dia +  + hole_rim_wall)/2, center = false);
  }
 }
}


//***** The actual spring hole, the cutout
module mid_section_cutout() {
 translate([-(cone_length + ball_dia/2 + cone_tip_to_ball + hole_to_cone_base),rod_outer_dia,0]) {
  rotate(a = [90, 0, 0]) {
   cylinder(h = rod_outer_dia * 2, r1 = hole_dia/2, r2 = hole_dia/2, center = false);
  }
 }
}


//***** rod_insert
module rod_insert() {
 translate([-ball_center_to_rod_end,0,0]) {
  rotate(a = [0, 270, 0]) {
   difference() {
    rod_insert_flaps();      
    rod_insert_cutaway();
   }
  }
 }
}


//***** Flaps, or cross inserts, or whatever they may be called
module rod_insert_flaps() {
 translate([-rod_inner_dia/2,-rod_insert_width/2,0]) {
  cube([rod_inner_dia, rod_insert_width, rod_insert_length]);
 }
 translate([-rod_insert_width/2,-rod_inner_dia/2,0]) {
  cube([rod_insert_width, rod_inner_dia, rod_insert_length]);
 }
}


//***** Make rounded surface where a cross insert meets the inside of the rod
module rod_insert_cutaway() {
 difference() {
  cylinder(h = rod_insert_length, r1 = rod_inner_dia, r2 = rod_inner_dia, center = false);
  cylinder(h = rod_insert_length, r1 = rod_inner_dia/2, r2 = rod_inner_dia/2, center = false);
 }
}


//***** end of file
