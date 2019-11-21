// Thickness of the arms.
arm_width = 6;
// Diameter of the pully wheel
pully_diameter = 30;
// Width of the pully wheel (should be larger than your rope/string)
pully_width = 6;
// space, or slop, between the wheel and the arms.  Make this smaller for better printers
space = 1.5;
// Diameter of both the pin/shieve hole and the hole at the top of the arms 
hole_diameter = 3;
// Diameter of a rope that would lay perfectly in the groove in the pully (should probably be bigger than your actual rope
rope = 7;

// minimum fragment size when making a circle - smaller = smoother
$fs = 0.5;
// number of fragments in a circle - bigger = smoother
$fn = 0;

ropeu = rope < pully_width ? pully_width : rope; 

echo(ropeu);

rope_xtra = sqrt(pow(ropeu/2,2)-pow(pully_width/2,2)); 

echo(rope_xtra);

rope_dist = pully_diameter/2 + rope_xtra;
echo("Rope Dist ",rope_dist);

b_arm_len = (pully_diameter/2)+space+arm_width*2;
b_arm_spread = arm_width*2 + space + pully_width;
b_x_mid = arm_width + space/2 +(pully_width/2);

module hole (v=[-space,(arm_width/2),arm_width/2],r=[0,90,0]) {
    difference (x) {
        children();
        #translate(v) rotate(r)
        cylinder(h=arm_width+space*2,d=hole_diameter);
    }
}

module armu () {
    hole() cube([arm_width,arm_width,b_arm_len]);
}

translate([-b_arm_spread/2,pully_diameter/2+5+b_arm_len+arm_width,0]) rotate([90,0,0]) {
    armu();
    translate ([arm_width + space + pully_width,0,0]) armu();
    hole([b_x_mid,arm_width/2,b_arm_len-space],[0,0,0]) translate ( [0,0,b_arm_len] ) cube( [b_arm_spread, arm_width, arm_width ] );
}


 translate([0,0,0]) rotate([0,0,0]) difference () {
  cylinder(h=pully_width, d=pully_diameter);
  translate([0,0,-space]) cylinder(h=pully_width+space*2,d=hole_diameter);  
  translate([0,0,(pully_width/2)]) rotate_extrude() { 
    translate([rope_dist,0,0]) circle(d=ropeu);
  }
}