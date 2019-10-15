// All measurements in mm
// Battery dimensions with it laying on it's short side, terminals to the left

battery_h = 26;  // height of battery
battery_w = 16.75;  // depth of battery
battery_l = 44.8;  // length of battery
shell = 2;  // thickness of box

slot = true;  // (bool) auto-centered slot alignment protrusions
slot_h = 19;  // width of "slot" protrusions
slot_w = 6;  // length of "slot" protrusions


difference() {
  union () {
    // Battery box:
    cube([battery_w + (shell * 2),
          battery_l + shell,
          battery_h + (shell * 2)]);
    // retainer clip
    translate([-.02, -1 * shell, (battery_h + shell) * .33]) 
      cube([shell * 2, shell + .02, (battery_h + shell) * .33]);
    if (slot) {
      translate([battery_w + shell * 2 - .02,
                (battery_l + shell) / 2 - (slot_w / 2),
                (battery_h + shell) / 2 - (slot_h / 2) - shell])
        cube([shell, slot_w, shell]);
      translate([battery_w + shell * 2 - .02,
                (battery_l + shell) / 2 - (slot_w / 2),
                (battery_h + shell) / 2 + (slot_h / 2)])
        cube([shell, slot_w, shell]);
    }
    
  }
    
  translate([shell, -.02, shell]) cube([battery_w, battery_l, battery_h]);
  translate([-.02, -.02, (battery_h + shell) * .33]) 
    cube([shell + .04, battery_l / 2, .5]);
  translate([-.02, -.02, (battery_h + shell) * .66]) 
    cube([shell + .04, battery_l / 2, .5]);
}
