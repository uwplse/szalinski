// Created in 2016 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// http://www.thingiverse.com/thing:1686372


clearance = 0.5;
belt_width = 6.7;
thick = 8.7;
bore_diam = 5.4;
bore_ring = 0.90;
rim_diam = 18;
contact_diam = 14;
contact_min_thick = 1;
bearing_angle = 55;

smoothfactor = 96;


sloped_clearance = clearance / cos(bearing_angle);
rim_thick = (thick - belt_width)/2;
inner_ring_rad = bore_diam/2 + bore_ring;
outer_ring_rad = inner_ring_rad + sloped_clearance;
inner_sloped_rad = inner_ring_rad + (1.001*thick/2) * tan(bearing_angle);
outer_sloped_rad = outer_ring_rad + (1.001*thick/2) * tan(bearing_angle);
outer_limit_rad = contact_diam/2 - contact_min_thick;
inner_limit_rad = outer_limit_rad - clearance;
amount_holding_it_in =
  ((inner_limit_rad < inner_sloped_rad) ? inner_limit_rad : inner_sloped_rad)
  - outer_ring_rad;
if (amount_holding_it_in < 0.1) {
  echo ("**********   WARNING!!  Likely to fall apart!  ************");
}
echo("Held in place by ", amount_holding_it_in);
echo("Axial looseness ", (clearance / sin(bearing_angle)));


module InnerRing() {
  difference() {
    difference() {
      intersection() {
        union() {
          translate([0,0,+thick/4])
            cylinder(h=1.001*thick/2, r1=inner_sloped_rad, r2=inner_ring_rad,
            center=true, $fn=smoothfactor*inner_sloped_rad);
          translate([0,0,-thick/4])
            cylinder(h=1.001*thick/2, r1=inner_ring_rad, r2=inner_sloped_rad,
            center=true, $fn=smoothfactor*inner_sloped_rad);
        }
        cylinder(h=thick, r=inner_limit_rad, $fn=smoothfactor*inner_limit_rad,
          center=true);
      }
      cylinder(h=2*thick, r=bore_diam/2, center=true, $fn=smoothfactor*bore_diam/2);
    }
  }
}

module OuterRing() {
  difference() {
    union() {
      translate([0,0,thick/2-rim_thick])
        cylinder(h=rim_thick, r=rim_diam/2, $fn=smoothfactor*rim_diam/2);
      translate([0,0,-thick/2])
        cylinder(h=rim_thick, r=rim_diam/2, $fn=smoothfactor*rim_diam/2);
      cylinder(h=thick-rim_thick, r=contact_diam/2, center=true,
        $fn=smoothfactor*contact_diam/2);
    }
    intersection() {
      union() {
        translate([0,0,+thick/4])
          cylinder(h=1.001*thick/2, r1=outer_sloped_rad, r2=outer_ring_rad,
          center=true, $fn=smoothfactor*outer_sloped_rad);
        translate([0,0,-thick/4])
          cylinder(h=1.001*thick/2, r1=outer_ring_rad, r2=outer_sloped_rad,
          center=true, $fn=smoothfactor*outer_sloped_rad);
      }
      cylinder(h=2*thick, r=outer_limit_rad, $fn=smoothfactor*outer_limit_rad,
        center=true);
    }
  }
}

InnerRing();
OuterRing();
//translate([0,0,15]) OuterRing();

