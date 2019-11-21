/*
 * Simple key-spanner for tightening retaining bolt.
 */

$fa = 1;
$fs = 1;

// Needs to be at least 2 for a very snug fit, and higher to give some leeway
Fudge = 6;
Wall = 5;

in = 25.4;
Depth = 5;
Width = 7/16*in;
Diameter = Width / cos(30);
R = Diameter * (1 + Fudge/100) / 2;

// Nut holder
difference() {
  cylinder(r=R+Wall, h=Depth);
  cylinder(r=R, h=Depth, $fn=6);
}

// Wings
translate([0,-1*Wall/2,0]){
    intersection(){
        cube([25,Wall,7]);
        translate([10,0,-3.4]){
            rotate(a=-10, v=[0,1,0]){
                cube([25,Wall, 8]);
            }
        }
    }
    translate([-25, 0, 0]) {
        intersection(){
                cube([25,Wall, 7]);
                translate([-10,0,1]){
                rotate(a=10, v=[0,1,0]){
                  cube([25, Wall, 8]);
                }
            }
        }
    }
}
