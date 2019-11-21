// Created in 2016 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// http://www.thingiverse.com/thing:1695879



quantity = 8;

nail_diam = 4;
nail_len = 40;
nail_sides = 6;
nail_tip_angle = 30;

head_diam = 8;
head_thick = 2;


nail_tiplen = (nail_diam/2) / tan(nail_tip_angle);
nail_straightlen = nail_len - nail_tiplen;
nail_zoff = (nail_diam/2) * cos(180/nail_sides);
nail_width = (nail_diam > head_diam) ? nail_diam : head_diam;


module Nail() {
  render() {
    // Head
    difference() {
      translate([0, 0, nail_diam/2])
        rotate([-90, 0, 0])
        cylinder(h=head_thick, r=head_diam/2, $fn=12*head_diam);
      translate([0, 0, -2*head_diam])
        cube([4*head_diam, 4*head_diam, 4*head_diam], center=true);
    }

    // Rod
    translate([0, head_thick - 0.01, nail_zoff])
      rotate([-90, 0, 0])
      rotate([0, 0, 180/nail_sides+90])
      cylinder(h=nail_straightlen + 0.01, r=nail_diam/2, $fn=nail_sides);

    // Tip
    translate([0, head_thick + nail_straightlen - 0.01, nail_zoff])
      rotate([-90, 0, 0])
      rotate([0, 0, 180/nail_sides+90])
      cylinder(h=nail_tiplen + 0.01, r1=nail_diam/2, r2=0.001, $fn=nail_sides);
  }
}


module NailSet(quantity=1) {
  colmax_1 = floor(sqrt(quantity*2*nail_width*1.5*(nail_len + head_thick))
    / (2*nail_width*1.35));
  rowmax = ceil(quantity / colmax_1);
  colmax = ceil(quantity / rowmax);

  for (i=[1:quantity]) {
    translate([2*nail_width*((i-1)%colmax),
      1.5*(nail_len+head_thick)*floor((i-1)/colmax), 0])
      Nail();
  }
}


NailSet(quantity);




