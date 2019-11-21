hook_out = 25;
hook_over = 8;
wall_thickness = 2;
top_thickness = 1;
metal_thickness = 1;
gap = 1.5;
metal_gap = metal_thickness + gap;
width = 7;
lip_thickness = 1.5;
top_lip_length = wall_thickness + 1;
bot_lip_length = wall_thickness + 1.5;
wall_height = 55;
trap_width = 25;


module lip_wrap(lip_length) {
  union() {
    cube([width, metal_gap + wall_thickness, top_thickness]);

    translate([0, metal_gap + wall_thickness, 0])
      cube([width, lip_thickness, lip_length]);
  }
}

module makeCableGuard() {
  translate([wall_height / 2, 7.5, 0])
  rotate([0, -90, 0]) {
    union() {
      // main wall
      cube([width, wall_thickness, wall_height]);

      // start of hook that holds cable
      translate([0, 0 - hook_out, wall_height - width])
        cube([width, hook_out, width]);

      // bottom lip around metal
      lip_wrap(bot_lip_length);

      translate([width, 0, wall_height])
        rotate([180, 0, 180])
          // top lip around metal
          lip_wrap(top_lip_length);

          // next part of cable holder
          translate([0, - hook_out, wall_height - width])
           cube([trap_width, 4, width]);

           // hook around cable
           translate([trap_width - 3, - 21, wall_height - hook_over + 1])
             cube([3, hook_over + 3, width]);
    }
  }
}

minkowski()
{
    makeCableGuard();
    sphere(1.5);
}
