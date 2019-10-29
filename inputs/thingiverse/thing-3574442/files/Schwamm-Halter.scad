// -----------------------------------------------------
// Schwamm-Halter
//
//  Detlev Ahlgrimm, 19.04.2019
// -----------------------------------------------------

sponge_x=70;              // [10:150]
sponge_y=50;              // [10:150]
sponge_z=60;              // [10:150]

faucet_diameter=23;       // [10:0.1:50]
wallthickness=1.6;        // [0.4:0.05:5]

radius_bottom_openings=3; // [1:0.1:5]

openings_vertical=1;      // [0:False, 1:True]
split_faucet=1;           // [0:False, 1:True]

/* [Hidden] */
$fn=50;
schwamm=[sponge_x, sponge_y, sponge_z];
rohr_d=faucet_diameter;
ws=wallthickness;


// -----------------------------------------------------
//  wie cube() - nur abgerundet gemaess "r"
// -----------------------------------------------------
module cubeR(v, r=1) {
  assert(r<=v.x/2 && r<=v.y/2 && r<=v.z/2);   // Requires version "nightly build"
  hull() {
    translate([    r,     r,     r]) sphere(r=r);
    translate([v.x-r,     r,     r]) sphere(r=r);
    translate([    r, v.y-r,     r]) sphere(r=r);
    translate([v.x-r, v.y-r,     r]) sphere(r=r);

    translate([    r,     r, v.z-r]) sphere(r=r);
    translate([v.x-r,     r, v.z-r]) sphere(r=r);
    translate([    r, v.y-r, v.z-r]) sphere(r=r);
    translate([v.x-r, v.y-r, v.z-r]) sphere(r=r);
  }
}

difference() {
  union() {
    cubeR([schwamm.x+2*ws, schwamm.y+2*ws, schwamm.z+ws], ws);
    hull() {
      translate([ws+schwamm.x/2-rohr_d/2-5, schwamm.y+ws, 0]) cube([rohr_d+10, ws, schwamm.z+ws]);
      translate([ws+schwamm.x/2, schwamm.y+2*ws+rohr_d/2, 0]) cylinder(d=rohr_d+2*ws, h=schwamm.z+ws);
    }
  }
  translate([ws, ws, ws]) cubeR([schwamm.x, schwamm.y, schwamm.z+2*ws], ws);
  r=radius_bottom_openings;
  cnt=floor(schwamm.x/(4*r));   // Anzahl
  bdr=schwamm.x-(2*cnt-1)*2*r;  // Rand gesamt
  for(x=[ws+r+bdr/2:4*r:schwamm.x-r]) {
    hull() {
      translate([x, 2*ws+r, -0.1]) cylinder(r=r, h=ws+0.2);
      translate([x, schwamm.y-r, -0.1]) cylinder(r=r, h=ws+0.2);
    }
  }
  if(openings_vertical) {
    translate([-0.1, ws+schwamm.y/2, ws+schwamm.z/2]) scale([1, schwamm.y-10, schwamm.z-10]) rotate([0, 90, 0]) cylinder(d=1, h=schwamm.x+2*ws+0.2);
    translate([ws+schwamm.x/4, -0.1, ws+schwamm.z/2]) scale([schwamm.x/2-10, 1, schwamm.z-10]) rotate([-90, 0, 0]) cylinder(d=1, h=ws+0.2);
    translate([ws+schwamm.x/4*3, -0.1, ws+schwamm.z/2]) scale([schwamm.x/2-10, 1, schwamm.z-10]) rotate([-90, 0, 0]) cylinder(d=1, h=ws+0.2);
  }

  translate([ws+schwamm.x/2, schwamm.y+2*ws+rohr_d/2, -0.1]) cylinder(d=rohr_d, h=schwamm.z+ws+0.2);
  translate([ws+schwamm.x/2-rohr_d, schwamm.y+2*ws+rohr_d/4*3, -0.1]) cube([2*rohr_d, rohr_d, schwamm.z+ws+0.2]);

  if(split_faucet && rohr_d<schwamm.z*2/3) {
    translate([0, schwamm.y+2*ws+schwamm.z/2+ws, (ws+schwamm.z)/2]) rotate([0, 90, 0]) cylinder(d=schwamm.z, h=schwamm.x);
  }
}
