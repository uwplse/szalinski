
// "Customizer" version of https://www.thingiverse.com/thing:2848381

// how many rails? (1-4)
rails = 2; // [1:1:4]

// height (in mm, min. 25)
height = 40; // [25:150]

// which version?
version = 2; // [1:v1,2:v2]

/* [Hidden] */

l = 30;
gh = 8.5;
gw = 12.5;

rw = 15;
//rh = 22;
//rh = 37;
sth = 3;
rh = height - sth;

sp1 = 10;
sp2 = 20;

sgr = 1.25;

sr = 3.5/2;
shr = 3.75;
shh = 3.5;
/*
was (v1):
sr = 3/2;
shr = 3.2;
shh = 3.2;
*/

for (i = [1:rails]) {
  translate(v = [(rw*rails) + 5 + (rw*i), 0, 0]) guide();
}

//screw();

if (version == 1) support();
if (version == 2) support2();

module support() {
  difference() {
    cube(size = [rw*(rails + 1), l, rh+sth]);
    translate(v = [rw, -l, sth]) cube(size = [rw*(rails+1), l*3, rh+sth]);
    translate(v = [rw*0.5, sp1, rh]) rotate([180, 0, 0]) screw();
    translate(v = [rw*0.5, sp2, rh]) rotate([180, 0, 0]) screw();
    for (i = [1:rails]) {
      translate(v = [rw*(i+0.5), sp1, 0]) rotate([180, 0, 0]) screw();
      translate(v = [rw*(i+0.5), sp2, 0]) rotate([180, 0, 0]) screw();
    }
  }
}

module support2() {
  difference() {
    translate(v = [-rw, 0, 0]) cube(size = [rw*(rails + 2), l, rh+sth]);
    translate(v = [rw, -l, sth]) cube(size = [rw*(rails+2), l*3, rh+sth]);
    translate(v = [rw*0.5, sp1, rh]) rotate([180, 0, 0]) screw();
    translate(v = [rw*0.5, sp2, rh]) rotate([180, 0, 0]) screw();
    for (i = [1:rails]) {
      translate(v = [rw*(i+0.5), sp1, 0]) rotate([180, 0, 0]) screw();
      translate(v = [rw*(i+0.5), sp2, 0]) rotate([180, 0, 0]) screw();
    }
    translate(v = [-rw*0.5, sp1, rh]) rotate([180, 0, 0]) screw();
    translate(v = [-rw*0.5, sp2, rh]) rotate([180, 0, 0]) screw();
    translate(v = [-rw*4, 0, rw*0.75]) rotate([0, 58, 0]) translate(v = [0, -l/2, 0]) cube(size = [rw*3, l*2, rw*3]);
  }
  
}

module guide() {
  difference() {
    tv2485153();
    translate(v = [gw/2, sp1, -gh]) cylinder(r = sgr, h = gh*3, $fn=12);
    translate(v = [gw/2, sp2, -gh]) cylinder(r = sgr, h = gh*3, $fn=12);
  }
}

module tv2485153() {
  /* from https://www.thingiverse.com/thing:2485153 - CC BY Jesper Ekvall */
  translate(v = [57, -24.2, 0])
    import("tv2485153-IKEA_Vidga_on_the_wall_joint.stl");
}

module screw() {
  union() {
    translate(v = [0, 0, -rh*2]) cylinder(r = sr, h = rh*3, $fn=18);
    translate(v = [0, 0, -shh]) cylinder(r1 = sr, r2 = shr, h = shh, $fn=32);
    translate(v = [0, 0, 0]) cylinder(r = shr, h = rh*3, $fn=32);
  }
}
