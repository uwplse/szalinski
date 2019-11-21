// BNC dust cap

// Adjust this for reasonable diameter fitness.
inner_d = 10.3;

inner_h  = 12;

wall_thickness = 1.75;
outer_d = inner_d + 2*wall_thickness;
slot_offset = 4;
slot_depth = 0.75;
slot_width = 2.5;

base_h  = 1;

angle_step = 3;
$fn=90;

// Tweak 1 
k1=1.2;

// Tweak 2
k2=1.2;

eps1 = 0.01;
eps2 = eps1 + eps1;

// Angle in degrees.
module cross_bar(d, l, z, a) {
  translate([0, 0, z]) rotate([0, 0, a]) rotate([90, 0, 0]) 
      cylinder(d=d, h=l, center=true, $fn=16);
}

module slot() {
  a1 = 30;
  a2 = 90;
  d = slot_width;
  z0 = slot_offset;
  l = inner_d + 2*slot_depth;
  hull() {
    //for (z = [d/2: 0.2: d]) {
      cross_bar(d, l, z0+d/2-eps1, -a1);
      cross_bar(d, l, z0+d*k1, -a1);
   // }
  }
  hull() {
    for (a = [-a1+angle_step: angle_step: 0]) {
      cross_bar(d*k2, l, z0+d/2-eps1, a);
    }
  }
  for (a = [angle_step: angle_step: a2]) {
    cross_bar(d, l,  d/2 + z0+((inner_h-d/2)*a/a2), a);
  }
}
  
module main() {
  difference() {
    cylinder(h=inner_h, d=outer_d);
    translate([0, 0, -eps1]) cylinder(h=inner_h+eps2, d=inner_d);
    
    slot();
  }
  
  translate([0, 0, -base_h]) cylinder(d1=outer_d-2*base_h, d2=outer_d, h=base_h+eps1);
}

main();

//slot();


