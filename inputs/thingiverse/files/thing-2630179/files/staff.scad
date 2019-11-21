// Written in 2017 by Max Esser <max@ghost.coffee>

//Variables//

// preview[view:top diagonal]

/* [Global] */
/* [Staff] */
//Base Size (mm)
Base_Size = 20 ; // [10:5:100]

//Differance between shells from bottom to top
Grow = 1.3; // [1.3:0.1:2]

//Largest outside diameter (mm)
Outside_Max = 100; // [20:10:200]

//wall thickness (mm)
Wall_Thickness = 1; // [0.5,1,1.5,2]

//How many turns (°)
Twist = 180; // [0:45:720]

//Height (mm)
Section_Height_Size = 140; //[100:10:400]

/* [Hidden] */
$fn = 45;
base = (Base_Size/10)/2;
outsidemax = (Outside_Max/10)/2;
section_height = (Section_Height_Size/10);
wall = (Wall_Thickness/10);
increment = wall*5;

// Modules //
module tri(d) {
    rotate([0,0,0]) {
        translate([d/2, 0, 0]) {
            circle(d=d);
        }
    }
    rotate([0,0,120]) {
        translate([d/2, 0, 0]) {
            circle(d=d);
        }
    }
    rotate([0,0,240]) {
        translate([d/2, 0, 0]) {
            circle(d=d);
        }
    }
}

module tri2(d) {
    rotate([0,0,0]) {
        translate([d/2, 0, 0]) {
            circle(d=(d-wall));
        }
    }
    rotate([0,0,120]) {
        translate([d/2, 0, 0]) {
            circle(d=(d-wall));
        }
    }
    rotate([0,0,240]) {
        translate([d/2, 0, 0]) {
            circle(d=(d-wall));
        }
    }
    circle(d=(d-wall));
}


module section(size) {
    linear_extrude(height=section_height, center=false, convexity=10, twist=Twist, scale=Grow) {
        difference() {
        tri(size);
        tri2(size);
        }
    }
}

// Part //

linear_extrude(height=wall, center=false, convexity=10, twist=7) {
    tri(base);
}
for(a = [base : increment : outsidemax]) {
    section(a);
    echo(a);
}

//(size•scale)+wall+1