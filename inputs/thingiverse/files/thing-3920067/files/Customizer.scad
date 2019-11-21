// Juergen Steupert

// variables 
// height for cup holder
h = 30;

// base width
w = h*.5;
w2 = w*.87;

$fn = 100;

module outside(){
    hull(){
        intersection(){
            cube([1.8*w, 1.8*w, h], center = true);
            cylinder(h = h,r=w, center = true);
        }
    }
}



module inside(){
    hull(){
        intersection(){
            cube([1.8*w2, 1.8*w2, h*1.1], center = true);
            cylinder(h = h*1.1,r=w2, center = true);
        }
    }
}

module base(){
    translate([0,0,-(h/2)+(0.025*h)]){
        hull(){
            intersection(){
                cube([1.8*w2, 1.8*w2, h*0.05], center = true);
                cylinder(h = h*0.05,r=w2, center = true);
            }
        }
    }
}
base();

module cup(){
    difference(){
        outside();
        inside();
    }
}

module shell(){
    union(){
        cup();
        base();
    }
}
shell();
