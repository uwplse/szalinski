$fn=32;

// Length of "tongue" band
l=130;
// Length of "buckle" band
lr=70;
// Width
w=22*1;
w2=w/2;
// Thickness
t=2*1;

module left() { // strap end with holes
    difference() {
        union() {
            cube([l-w2,w,t]); // strap
            translate([0,0,t])rotate([-90,0,0]) cylinder(r=t,h=22); // around watch pin
            translate([l-w2,w2,0]) cylinder(r=w2,h=t); // round end
            }

        translate([0,-1,t]) rotate([-90,0,0]) cylinder(r=1.25, h=w+2);

        // Punch holes
        for (x=[40:10:l-1]) 
            translate([x,11,-1]) scale([1,.7,1]) cylinder(r=2.5,h=t+3);
        }
    }
    
module right() {
    difference() {
        union() {
            cube([lr,w,2]); // strap
            translate([0,0,t])rotate([-90,0,0]) cylinder(r=t,h=22); // around watch pin
            translate([lr,0,t])rotate([-90,0,0]) cylinder(r=t,h=22); // around watch pin
            }

        translate([0,-1,t]) rotate([-90,0,0]) cylinder(r=1.25, h=w+2);
        translate([lr,-1,t]) rotate([-90,0,0]) cylinder(r=1.25, h=w+2);

        // Punch holes
        translate([lr,w2,t]) scale([1,.7,1]) cube([5,5,5], center=true);//  cylinder(r=2.5,h=t+3);
        //translate([lr+t,w2,-1]) scale([1,.7,1]) cylinder(r=2.5,h=t+3);
        }
    }
    
module hold() {
    translate([0,-t-1,0]) difference() {
        cube([4*t+2,w+2*t+2,10]);
        translate([t,t,-1]) cube([2*t+2,w+2,10+2]);
        }
    }
    
module band() {
    left();
    translate([0,2*w,0]) right();
    translate([lr+w,2*w,0]) hold();
    }
    
band();