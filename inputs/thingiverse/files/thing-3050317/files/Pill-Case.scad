// - Outer diameter of body
D = 60;

// - inside height of body
H = 25;

// - wall thickness 
t = 2;

// - Show as packed or assembled?
print = "false"; //[true:Print version, false:Assembled]




/* [hidden] */
$fn=80;
c = 0.4;
R = D/2;
unitVol = (3.14159*pow(R-t,2) - (R-t)*t )*H /1000;
echo(unitVol, "cm^3");

//Body();
//Lid();
//if(print="true") 
PrintConfig(); 
//else FitConfig();

module Body() {
    //body polygon
    pBody = [
        [0,         0],
        [D/2,       0],
        [D/2,       H/2-t/2],
        [D/2-t/2,   H/2],
        [D/2,       H/2+t/2],
        [D/2,       H],
        [D/2-t,     H],
        [D/2-t,     t],
        [0,         t]];
    rotate_extrude(angle=360, convexity=50) {
        polygon(pBody);
    }
    //walls
    for(i=[45:45:180]) {
        rotate(i) translate([-D/2+t/2, -t/2, 0]) {
            cube([D-t, t, H]);
        }
    } 
    //filled segment. E-NE
    intersection() {
        linear_extrude(H) polygon([[0,0],[0,D],[D,D]]); 
        cylinder(d=D-t,H);
    }
    //notches at E & NE
    rotate(0) translate([R-t/2,0,0]) {
        cylinder(d=t,H);
    }
    rotate(45) translate([R-t/2,0,0]) {
        cylinder(d=t,H);
    }
}


module Lid() {
    //lid polygon
    pLid = [
        [0,         H+c],
        [D/2+c,     H+c],
        [D/2+c,     H/2+t/2+c],
        [D/2-t/2,   H/2],
        [D/2+t,     H/2],
        [D/2+t,     H+c+t],
        [0,         H+c+t]];
    
    difference() {
        //body
        rotate_extrude(angle=45) {
            polygon(pLid);
        }
        //splits
        for(a=[45:45:360]) {
            rotate(a) translate([D/4, -c/2]) {
                cube([D,c,H*2]);
            }
        }
        //opening
        difference() {
            //triangular wedge
            linear_extrude(H*2) polygon([[0,0],[0,D],[D,D]]);
            //central cylinder
            cylinder(d=D/2,H*2);
        }
        
    }    
}

module PrintConfig() {
    Body();
    rotate([180,0,0]) translate([D+t*2, 0, -H-t-c]) {
        Lid();
    }
}


module FitConfig() {    
    intersection() {
        union() {
            Body();
            Lid();
        }
        rotate(-45/2) cube(D);
    }
}
