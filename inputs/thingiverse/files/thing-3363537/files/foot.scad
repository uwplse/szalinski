

// diameter (mm) of the hole for the crutch/cane/walker/leg including any desired tolerance
d_hole   = 28.575;
// Thickness of the foot added to diameter of the crutch at the top 
t_foot   = 3;
// height of the foot.
h_foot   = 30;
// percentage larger diameter the bottom should be than the top.
p_taper  = 10;
// number of treads on the bottom. (concentric circles) affects the height of the treads.
n_treads = 3;

$fs = 1;
$fa = 1;


d1       = d_hole + t_foot * 2;
d2       = d1 * ( 1 + p_taper/100 );
r_tread  = d2/4/n_treads;

function ncircles(r,R) =
  let(a = asin(r/R)*2)
  floor(360 / a);

module body() {
  difference() {
    cylinder(d1=d2, d2=d1, h=h_foot);
    translate([0,0,h_foot * 0.2]) cylinder(d1=d_hole * 0.99, d2=d_hole, h=h_foot);
  }
}

module traction() {
  r = r_tread;
  difference() {
    rotate_extrude(angle=360) 
      for (o=[1:n_treads])
        translate([r*o*2 - r,0]) circle(r-0.001); // -0.001 to avoid gcal error

    translate([0,0,-r*1.85]) cylinder(d=d2, h=r);
  }
}

module slicer_support_pin() {
  cylinder(d=0.2, h=h_foot*0.21);
}

module slicer_reinforce_1() {
  for (a=[0:30:360]) {
    rotate(a) {
      for(o=[1:2:7]) translate([d2/2 - r_tread*o,0,0]) slicer_support_pin();
    }
  }
}

module slicer_reinforce_2() { 
  linear_extrude(h_foot * 0.2 - 0.2) {
    for (tread = [1:n_treads ]) {
      n = ncircles(r_tread/2,r_tread * tread * 2);
      for (a = [1:n] )
        rotate(360/n * a)
        translate([r_tread * (tread * 2 - 1),0]) circle(0.1);
    }
    circle(0.1);
  }
}

module foot() {
  difference() {
    union() {
      body() ;
      traction();
    }
    // force a slicer to add more walls, by putting little holes in.
    slicer_reinforce_2();
  }
}

foot();
