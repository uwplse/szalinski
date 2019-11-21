width = 12;
length = 50;
height = 20.1;
wall = 3;
wall_back = 5;
diameter1 = 3;
diameter2 = 6.6;
clearance = 0.4;
pin_length = 5;
pin_diameter = 4;
border_radius = 1;

// back
difference() {

    union() {
        // front
        cube ([width, wall, 5]);

        // bottom
        cube ([width, length, wall]);

        // back
        translate ([0, length-wall_back, 0]) cube ([width, wall_back, height]);
    }
    
    // screw hole
    translate ([width/2, length+clearance, height/2]) {
        rotate (90, [1,0,0])
            cylinder (d1=diameter1, d2=diameter2, h=wall_back+2*clearance, $fn=64);
    }
    translate ([0, 0, 0]) {
        rotate (90, [0,1,0]) {
            hull() {
                translate ([-border_radius, length, -clearance]) {
                    cylinder (r=border_radius, h=width+2*clearance, $fn=64);
                }
                translate ([-height+border_radius, length, -clearance]) {
                    cylinder (r=border_radius, h=width+2*clearance, $fn=64);
                }
            }
        }
    }
}

// pin
/*
translate ([width/2, length, 0]) {
    rotate (-90, [1,0,0]) {
        difference() {
            cylinder (d=pin_diameter, h=pin_length, $fn=64);
            translate ([-pin_diameter/2, 0, 0])
                cube ([pin_diameter,pin_diameter,pin_length]);
        }
    }
}
*/