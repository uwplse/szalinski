include <Path2Polygon.scad>

$fa=0.2;
$fs=$fa;
tol=0.15;

module arm() {
  difference() {
    linear_extrude(15) translate([-10,10]) offset(1) offset(-1) union() {
      translate([-10,40]) difference() {
        translate([0,-40]) square([8,50]);
        rotate([0,0,-15]) translate([-50,0]) square(100);
      }
      translate([10,-10]) difference() {
          rotate([0,0,-30-15/2]) hull() {
          circle(r=8);
          translate([-35,-3]) square([1,6]);
        }
        translate([-120,-20]) square(100);
      }
    }
    translate([0,0,-1]) cylinder(r=6+tol, h=20);
    translate([0,0,9]) cylinder(r=8+tol,h=10);
    rotate([0,0,-30-15/2]) translate([-20,0,2]) cylinder(r=1.3,h=50);
  }
}

module mirrorkeep(v) {
  children();
  mirror(v) children();
}

module lock(h=12) {
  linear_extrude(h) offset(0.75) offset(-0.75) 
  difference() {
    rotate([0,0,-30]) translate([-20,0]) mirrorkeep([0,1]) path2polygon( [
      line(20),
      line(14,a=60),
      line(8,90)
    ], 512);
    offset(tol) projection() {
      arm();
      rotate([0,0,15]) arm();
    }
    translate([-1.5,-30]) square([3,30]);
    rotate([0,0,120]) translate([-1.5,-30]) square([3,30]);
    circle(7);
  }
}


module base() {
  difference() {
    union() {
      translate([-2,0,-5]) difference() {
        linear_extrude(5) offset(5) offset(-5) hull() {
          square([20,30], center=true);
          translate([0, 20]) circle(5);
          translate([0,-20]) circle(5);
        }
        mirrorkeep([0,1,0]) translate([0, 20]) cylinder(r=1.5+tol,h=50, center=true);
        //translate([0, 20]) cylinder(r=2,h=50, center=true);
      }
      cylinder(r=6-tol,h=14);
      cylinder(r=8,h=0.4);
    }
    translate([0,0,2]) cylinder(r=1.3, h=50);
  }
  lock(12);
  hull() {
    linear_extrude(0.01) intersection() {
      projection() lock();
      translate([-50+18,0]) square([50,30]);
    }
    translate([0,0,-4]) linear_extrude(0.01)
    intersection() {
      projection() lock();
      translate([-50+8,0]) square([50,30]);
    }
  }
}

module cap0 () {
  offset(0.75) offset(-0.75-0.5) offset(0.5) {
    circle(r=8);
    translate([7,-1.5]) square([14,3]);
  }
}

module cap() {
  difference() {
    translate([0,0,-6]) union() {
      linear_extrude(9) cap0();
      translate([0,0,9]) linear_extrude(3) offset(-10) offset(10) cap0();
    }
    translate([0,0,-1]) cylinder(r=6+tol,h=5);
    translate([0,0,-10]) cylinder(r=8.5,h=10);
    cylinder(r=1.5+tol, h=50);
    translate([8,0,1]) cylinder(r=1.3, h=50);    
  }
}

module mounted() {
  base();
  rotate([0,0,15])
  translate([0,0,0.4]) 
  arm();
  translate([0,0,9.6]) 
  cap();
}
module exploded() {
  translate([0,0,5]) base();
  rotate([0,0,0]) translate([35,-20]) arm();
  translate([35,5,6]) rotate([180,0,90]) cap();
}

//mounted();
exploded();