/* [insulin pump clip] */

$fn=50;

pump_length=80.6; // [75:80]
pump_depth = 20;

// at the bottom of the pump what is the difference in length between the longest and shortest part?
curve_diff = 1.2; // [1:2]


clip_top_claw=3.0;
clip_opening_length=68.0;

hook_depth=7.0;
hook_length=70.0;
nubbin_depth=2.5;
nubbin_length=5.0;

wall_thickness=3.0;

// clip_width
clip_width = 17.0; // [2:25]


pump_bottom_radius = (pow(curve_diff,2) + pow((pump_depth/2),2))/(2*curve_diff);

difference(){

// the clip ready for removal of the pump cutout and opening
union(){

//create main pump clip part and move it to origin
translate([pump_length+wall_thickness-pump_bottom_radius,-(pump_depth+(2*wall_thickness))/2.0,0 ]){
  intersection(){
    translate([0,-(pump_depth+(2*wall_thickness))/2.0,0]){
      cube([pump_bottom_radius+wall_thickness, pump_depth+(2*wall_thickness), clip_width]);
    }
    cylinder(r=pump_bottom_radius+wall_thickness, h=clip_width);
  }
  translate([-(pump_length+wall_thickness-pump_bottom_radius), -(pump_depth+(2*wall_thickness))/2.0, 0]){
    cube([pump_length+wall_thickness-pump_bottom_radius, pump_depth+(2*wall_thickness), clip_width]);
  }
}

// create hook
translate([0,-(pump_depth+(2*wall_thickness)),0]){
  translate([0,-hook_depth,0]){
    difference(){
      intersection(){
        cube([wall_thickness*3,hook_depth,clip_width]);
        translate([hook_depth, hook_depth, 0]){
          cylinder(r=hook_depth, h=clip_width);
        }
      }
      translate([wall_thickness*3, wall_thickness+((hook_depth-wall_thickness)/2),0]){
        cylinder(d=hook_depth-wall_thickness, h=clip_width);
      }
    }
    translate([wall_thickness*2,0,0]){
      cube([hook_length-nubbin_length-(wall_thickness*2), wall_thickness, clip_width]);
    }
    translate([hook_length-nubbin_length, 0,0]){
      intersection(){
        translate([0,(nubbin_depth+wall_thickness)/2,0]){
          cylinder(d=nubbin_depth+wall_thickness, h=clip_width);
        }
        cube([nubbin_length, nubbin_depth+wall_thickness, clip_width]);
      }
    }
    translate([hook_length-(3*nubbin_length), hook_depth-nubbin_depth, 0]){
      cube([nubbin_length, nubbin_depth, clip_width]);
    }
  }
}

}

// pump moved to the correct location
translate([wall_thickness, -(pump_depth+wall_thickness),0]){
  // pump
  #cube([pump_length-pump_bottom_radius+0.1, pump_depth, clip_width]);
    translate([pump_length-pump_bottom_radius,0,0]){
    intersection(){
      cube([pump_bottom_radius, pump_depth, clip_width]);
      translate([0,pump_depth/2,0]){
        cylinder(r=pump_bottom_radius, h=clip_width);
      }
    }
  }
}

// opening moved to the correct location
translate([wall_thickness+clip_top_claw, -wall_thickness, 0]){
  //opening
  cube(clip_opening_length, wall_thickness, clip_width);
}
}