/* [Global] */

part = "tube"; //[beads:Print beads,tube:Tube segment,tubecapbot:Tube cap bottom,tubecaptop:Tube cap top]

/* ---------------------------------------------------- */
/* [Beads] */
/* ---------------------------------------------------- */
//Beads radius (mm)
bead_r=2;

// How many beads
bead_count=64;  //[1,4,9,25,36,49,64]

//Space between beads (mm)
bead_space=5;

/* ---------------------------------------------------- */
/* [Tube setings] */
/* ---------------------------------------------------- */
// Tube outer radius (mm)
tube_outer_r = 30;
// Tube thickess (mm)
tube_thickness = 1;

// Tube height (mm)
tube_height=100;

// Connector height (mm)
connector_height=20;
// Connector thickness (mm)
connector_thickness=1;

// Twist (in angular degree) of the helix inside the tube (the higher the better, but twist is limited by printer)
twist=270; // [180:450]

/* ---------------------------------------------------- */
/* [Tube caps] */
/* ---------------------------------------------------- */
// Tube cap height (mm)
tube_end_height=1; //[1:5]

/* ---------------------------------------------------- */
/* [Hidden] */
/* ---------------------------------------------------- */
$fn=50;
epsilon=0.1;

bead_count_per_row=sqrt(bead_count);

tube_inner_r = tube_outer_r-tube_thickness;

connector_outer_r=tube_inner_r-epsilon;
connector_inner_r=connector_outer_r-connector_thickness;

tube_end_r=tube_outer_r+1;
minkowski_r=1;


/* ---------------------------------------------------- */
/* Main */
/* ---------------------------------------------------- */

if(part=="beads" ) {
  beads();
}

if(part=="tube" ) {
  rainmaker_tube();
}

if(part=="tubecapbot" ) {
  tube_cap_bottom();
}

if(part=="tubecaptop" ) {
  tube_cap_top();
}


module beads() {
  for (x=[0:bead_count_per_row-1]) {
    for (y=[0:bead_count_per_row-1]) {
      translate([x*(bead_r*2+bead_space),y*(bead_r*2+bead_space),0])
        sphere (r=bead_r,center=true,$fn=10);
    }
  }
}


module rainmaker_tube() {
  // outer tube
  translate([0,0,connector_height])
    _tube(tube_height,
      tube_outer_r,
      tube_inner_r-epsilon*3);

  // inner tube
  difference(){
  color("red") _tube(tube_height,
    connector_outer_r,
    connector_inner_r);

    translate([0, 0, connector_height/2-epsilon]) {
      cube([(connector_outer_r+2*epsilon)*2,2,connector_height+2*epsilon],center=true);
      cube([2,(connector_outer_r+2*epsilon)*2,connector_height+2*epsilon],center=true);
    }
  }
  rotate([0,0,80])
    linear_extrude(height = tube_height, center = false, convexity = 10, twist = twist,$fn=360)
      translate([2*epsilon, 0, 0])
        square([connector_outer_r-3*epsilon,2]);

  rotate([0,0,-100])
    linear_extrude(height = tube_height, center = false, convexity = 10, twist = twist,$fn=360)
      translate([2*epsilon, 0, 0])
        square([connector_outer_r-3*epsilon,2]);

  cylinder(h=tube_height,r1=2,r2=2);
}

module tube_cap_bottom() {
  minkowski() {
    cylinder(h = tube_end_height, r1 = tube_end_r, r2 = tube_outer_r, center = false,$fn=100);
    sphere(r=minkowski_r,$fn=100);
  }

  difference() {
    translate ([0,0,tube_end_height+minkowski_r]) {
        _tube(connector_height,
            connector_outer_r,
            connector_inner_r);
    }
    translate ([0,0,connector_height/2+tube_end_height+minkowski_r]) {
      cube([(connector_outer_r+2*epsilon)*2,2,connector_height+2*epsilon],center=true);
      cube([2,(connector_outer_r+2*epsilon)*2,connector_height+2*epsilon],center=true);
    }
  }
}

module tube_cap_top() {
  minkowski() {
    cylinder(h = tube_end_height, r1 = tube_end_r, r2 = tube_outer_r, center = false,$fn=100);
    sphere(r=minkowski_r,$fn=100);
  }

  translate ([0,0,tube_end_height+minkowski_r]) {
      _tube(connector_height+epsilon,
          tube_outer_r,
          tube_inner_r);
  }
}

module _tube(height,r1,r2) {
  difference() {
    cylinder(h = height, r1 = r1, r2 = r1, center = false,$fn=100);
    translate([0,0,-0.5]) cylinder(h = height+1, r1 = r2, r2 = r2, center = false,$fn=100);
  }
}
