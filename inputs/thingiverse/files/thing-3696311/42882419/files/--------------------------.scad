$fn=180;
$fa=10;

module roring(rr1, rr2) {
    rotate_extrude() {
        translate([rr1,0,0])
            circle(r=rr2);
    }
}

module faska(in1, ud1, rd1) {
    translate([0,0,rd1*-1]) {
        if (ud1>0) {
            if (in1>0)
        // in up
                rotate_extrude()
                    translate([rd1,0,0]) 
                        polygon([[0,rd1],[1,rd1+1],[0,rd1+1]]);
            else
        // out up
            rotate_extrude()
                translate([rd1,0,0]) 
                    polygon([[1,rd1],[1,rd1+1],[0,rd1+1]]);
        } else {
            if (in1>0)
        // in down
                rotate_extrude()
                    translate([rd1,0,0])
                        polygon([[0,rd1],[0,rd1+1],[1,rd1]]);
            else
        // out down
            rotate_extrude()
                translate([rd1,0,0]) 
                    polygon([[0,rd1],[1,rd1],[1,rd1+1]]);
        }
    }
}

module mainbody() {
    difference() {
        union() {
            cylinder(h=14, r=9.5, center=false);
            translate([0,0,14]) 
                cylinder(h=3, r=12.5, center=false);
        }
            translate([0,0,2])
                roring(9.7, 0.8);
            translate([0,0,11])
                roring(9.7, 0.8);    
            translate([0,0,13.9])
                roring(10.3, 0.8);    
    }
}

module inerhole() {
    union () {
        translate([0,0,-0.1])
            cylinder(h=10.1, r=6.25);
        translate([0,0,9])
            cylinder(h=5.1, r=4.25);
        translate([0,0,12]) 
           cylinder(h=5.1, r1=5.1, r2=9); 
    }
}

 difference() {
    mainbody();
    translate([0,0,16.4]) faska(0, 1, 11.6);
    translate([0,0,-0.3]) faska(0, 0, 8.7);
    //translate([30,0,0])
    inerhole();
}