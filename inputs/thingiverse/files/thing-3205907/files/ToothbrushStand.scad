use <polyround.scad>;

module prism(w=10,l=10,h=10) {
   translate([-w/2,-l/2,0]) polyhedron(
     points=[[0,0,0], [0,l,0], [w,l,0], [w,0,0], [w/2,l,h]],
     faces=[[0,3,2,1], [0,4,3], [1,4,0], [1,2,4], [4,3,2]]
   ); 
}

module bevel(w,h,l) {
  hull() {
    translate([-50,0,0]) prism(w,l);
    translate([50,0,0]) prism(w,l);
  }
}

module base() {
  hull() {
    translate([0,-20,0]) bevel(7,7,10);
    rotate([0,0,180]) translate([0,-20,0]) bevel(7,7,10);
  }
}

module post() {
  hull() {
    sphere(r=2);
    translate([0,0,30]) sphere(r=2);
  }
}

lhs = [
  [0,0,10], [1.18,5,10], [2.87,10,10], [5,13.06,5], [10,14.57,10], [15,15,1], 
  [15,-12.3,1],[10,-11.4,10],[6.15,-10,20],[5,-9.4,20],[1.14,-5,20]
];

$fn=100;
union() {
  difference() {
    base();
    translate([-30,-1.5,3]) linear_extrude(height=20) {
      hull() {
        scale([0.91, 1,1]) translate([-15,0,0]) polygon(polyRound(lhs));
        scale([0.91,1,1]) mirror([1,0,0]) translate([-15,0,0]) polygon(polyRound(lhs));
      }
    }
    translate([-30,-1.5,1]) linear_extrude(height=20) {
      hull() {
        scale(0.5) translate([-15,0,0]) polygon(polyRound(lhs));
        scale(0.5) mirror([1,0,0]) translate([-15,0,0]) polygon(polyRound(lhs));
      }
    }
  }
  translate([35,0,2]) post();
  translate([15,0,2]) post();
  translate([-5,0,2]) post();
}
