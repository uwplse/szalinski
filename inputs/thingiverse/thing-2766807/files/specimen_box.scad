
glassThick = 2.0;
glassHeight = 100.4;
glassWidth = 100.4;
wallThick = 4.0;
boxHeight = 32;
part = "both"; // [box:box only,lid:lid only,both:box and lid]

module box1() {
    difference() {
        cube([glassWidth+wallThick, glassHeight+wallThick, wallThick+boxHeight]);
        translate([wallThick/2, wallThick/2, boxHeight+wallThick-glassThick]) {
            cube([glassWidth, glassHeight, glassThick+1]);
        }
        translate([wallThick, wallThick, wallThick]) {
            cube([glassWidth-wallThick, glassHeight-wallThick, boxHeight+1]);
        }
    }
    
    translate([(glassWidth+wallThick)/3,0,3]) {
        rotate([0,90,0]) {
            cylinder(r=0.6, h=(glassWidth+wallThick)/3, $fn=30);
        }
    }
    translate([(glassWidth+wallThick)/3,glassHeight+wallThick,3]) {
        rotate([0,90,0]) {
            cylinder(r=0.6, h=(glassWidth+wallThick)/3, $fn=30);
        }
    }
    translate([0,(glassHeight+wallThick)/3,3]) {
        rotate([-90,0,0]) {
            cylinder(r=0.6, h=(glassHeight+wallThick)/3, $fn=30);
        }
    }
    translate([glassWidth+wallThick,(glassHeight+wallThick)/3,3]) {
        rotate([-90,0,0]) {
            cylinder(r=0.6, h=(glassWidth+wallThick)/3, $fn=30);
        }
    }
}

module cover1() {
    difference() {
        cube([glassWidth+wallThick+wallThick, glassHeight+wallThick+wallThick, wallThick+boxHeight+wallThick/2]);
        translate([wallThick/2-0.4, wallThick/2-0.4, wallThick/2-0.2]) {
            cube([glassWidth+wallThick+0.4*2, glassHeight+wallThick+0.4*2, wallThick+boxHeight+wallThick/2+0.2]);
        }
        translate([wallThick/2+wallThick, wallThick/2+wallThick, -1]) {
            cube([glassWidth-wallThick, glassHeight-wallThick, wallThick+2]);
        }
        translate([(glassWidth+wallThick+wallThick)/4,wallThick/2,wallThick+boxHeight+wallThick/2-3]) {
            rotate([0,90,0]) {
                cylinder(r=0.6+0.4, h=(glassWidth+wallThick+wallThick)/2, $fn=30);
            }
        }
        translate([(glassWidth+wallThick+wallThick)/4,glassHeight+wallThick+wallThick-wallThick/2,wallThick+boxHeight+wallThick/2-3]) {
            rotate([0,90,0]) {
                cylinder(r=0.6+0.4, h=(glassWidth+wallThick+wallThick)/2, $fn=30);
            }
        }
        translate([wallThick/2,(glassHeight+wallThick+wallThick)/4,wallThick+boxHeight+wallThick/2-3]) {
            rotate([-90,0,0]) {
                cylinder(r=0.6+0.4, h=(glassHeight+wallThick)/2, $fn=30);
            }
        }
        translate([glassWidth+wallThick+wallThick-wallThick/2,(glassHeight+wallThick+wallThick)/4,wallThick+boxHeight+wallThick/2-3]) {
            rotate([-90,0,0]) {
                cylinder(r=0.6+0.4, h=(glassWidth+wallThick)/2, $fn=30);
            }
        }        
    }
    
}

if (part == "box") {
    box1();
} else if (part == "lid") {
    cover1();
} else if (part == "both") {
    translate([-glassWidth-wallThick*2-2,0,0]) {
        box1();
    }
    translate([2,0,0]) {
        cover1();
    }
}

