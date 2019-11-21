length = 110;
width = 20;
height = 40;
boltHoleDiameter = 5.5;
boltCounterboreDiameter = 12;
bottomThickness = 5;
filletRadius = 5;
$fn=200;

rHandle = 2 * (width/2);

module side() {
  difference() {
    translate([-width/2,-width,0]) {
      cube([width,width*2,height]);
    }
    translate([0, 0, -1]) cylinder(d=boltHoleDiameter, h=height+2);
    translate([0, 0, bottomThickness])cylinder(d=boltCounterboreDiameter, h=height);
  }
}

module topCurve() {
  difference() {
    translate([0,-width-rHandle]) cube([length*2, width*2+rHandle*2, height+rHandle*2]);
    rotate([0,90,0]) cylinder(r=rHandle, h=length*2);
  }
}

module sideCuts() {
  translate([-width/2,0,height-width]) 
    rotate([0, -45, 0]) 
      translate([-10,0,-rHandle]) topCurve();
}

rotate([90,0,0])
difference() {
  union() {
    side();
    translate([length-width,0,0]) rotate([0,0,180]) side();
    translate([width/2-0.01,0,height+rHandle/2]) rotate([0,90,0]) {
       cylinder(r=rHandle, h=length-width*2+0.02);
       translate([0,0,filletRadius]) fil_polar_i(R = rHandle+filletRadius-0.02, r=filletRadius);
       translate([0,0,length-width*2+0.02-filletRadius]) rotate([180,0,0]) fil_polar_i(R = rHandle+filletRadius-0.02, r=filletRadius);
    }
  }
  sideCuts();
  translate([length-width,0,0]) rotate([0,0,180]) sideCuts();
  translate([-length,-width-width/2,-1]) cube([length*3,width, height*2]);
  translate([-length,width/2,-1]) cube([length*3,width, height*2]);
  translate([-width, 0, height-rHandle]) topCurve();
}





/* 
  openscad-fillets by jfhbrook 
  https://github.com/jfhbrook/openscad-fillets

  fillets.scad contents included below
*/ 

// 2d primitive for outside fillets.
module fil_2d_o(r, angle=90) {
  intersection() {
    circle(r=r);
    polygon([
      [0, 0],
      [0, r],
      [r * tan(angle/2), r],
      [r * sin(angle), r * cos(angle)]
    ]);
  }
}

// 2d primitive for inside fillets.
module fil_2d_i(r, angle=90) {
  difference() {
    polygon([
      [0, 0],
      [0, -r],
      [-r * tan(angle/2), -r],
      [-r * sin(angle), -r * cos(angle)]
    ]);
    circle(r=r);
  }
}

// 3d polar outside fillet.
module fil_polar_o(R, r, angle=90) {
  rotate_extrude(convexity=10) {
    translate([R, 0, 0]) {
      fil_2d_o(r, angle);
    }
  }
}

// 3d polar inside fillet.
module fil_polar_i(R, r, angle=90) {
  rotate_extrude(convexity=10) {
    translate([R, 0, 0]) {
      fil_2d_i(r, angle);
    }
  }
}

// 3d linear outside fillet.
module fil_linear_o(l, r, angle=90) {
  rotate([0, -90, 180]) {
    linear_extrude(height=l, center=false) {
      fil_2d_o(r, angle);
    }
  }
}

// 3d linear inside fillet.
module fil_linear_o(l, r, angle=90) {
  rotate([0, -90, 180]) {
    linear_extrude(height=l, center=false) {
      fil_2d_i(r, angle);
    }
  }
}