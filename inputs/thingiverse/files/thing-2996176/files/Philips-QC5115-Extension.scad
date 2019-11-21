/**
 * Extension for Philips QC5115
 * The QC5115 only supports a length of 21mm
 * Using this Extension you can set your desired length through the customizer.
 * Use a nail or something to fixate the desired length using the holes.
 * Print it with brim!
 *
 * This file includes the mod_multicube which is available at thingiverse (https://www.thingiverse.com/thing:2782146)
 * @param author Robert Schrenk
 * @
**/
// Desired hair length at maximum
desired_maximum = 40;
// How often should be a step?
desired_steps = 5; // [3:10]

// These values should not be changed
connector_length = desired_maximum + 12;
connector_strength = 2.2 + 0;
cutter_diameter = 37 + 0;


// This is the exact angle to get it plain on the heatbed
rotate([155.224859,0,0]) {
    difference(){
        cylinder(h=connector_length, d=cutter_diameter + 2*connector_strength);
        translate([0,0,-1])
            cylinder(h=connector_length + 2, d=cutter_diameter);
        translate([-(cutter_diameter/2 + 2*connector_strength - 1),0,-1])
            cube([cutter_diameter + 2*connector_strength + 2, cutter_diameter, connector_length + 2]);
        // Let 16.5mm stay in the middle, cut off 5.5mm left and right of it
        translate([8.25,-20,0])
            cube([6,20,20]);
        translate([-8.25-6,-20,0])
            cube([6,20,20]);
        holes();
    }
    difference() {
        slides();
        holes();
    }

    /*
    translate([-cutter_diameter/2 - connector_strength,0,0]) {
        difference(){
            cube([cutter_diameter + 2*connector_strength, 1.3, connector_length]);
            translate([5,0,0])
                cube([cutter_diameter + 2*connector_strength - 10, 1.3, connector_length]);
        }
    }
    */
    distances();
}

module holes(){
    for(i = [desired_steps:desired_steps:desired_maximum]) {
        translate([0,0,-i])
            hole();

    }
}

module slides(){
    base_z = connector_strength + 0;
    base_y = 2*connector_strength + 0;
    base_xL = cutter_diameter/2 + 0;
    base_xR = -cutter_diameter/2 + 0;

    multicube([
        [base_xL,base_y,base_z,connector_strength],
        [base_xL + connector_strength,base_y,base_z,connector_strength],
        [base_xL + connector_strength,base_y,base_z + connector_length,connector_strength],
        [base_xL,base_y,base_z + connector_length - 10,connector_strength],
    ]);

    multicube([
        [base_xR,base_y,base_z,connector_strength],
        [base_xR + connector_strength,base_y,base_z,connector_strength],
        [base_xR + connector_strength,base_y,base_z + connector_length - 10,connector_strength],
        [base_xR,base_y,base_z + connector_length,connector_strength],
    ]);

    translate([cutter_diameter/2,0,0])
        cube([connector_strength, 1.5*connector_strength, connector_length]);
    translate([-cutter_diameter/2 - connector_strength,0,0])
        cube([connector_strength, 1.5*connector_strength, connector_length]);
}

module distances(){
    difference() {
        union() {
            for (i = [0:6.5:42]) {
                translate([i-cutter_diameter/2-0.25,-cutter_diameter/2,connector_length+2])
                    distance();
            }
        }
        translate([0,0,20]) {
            difference() {
                cylinder(h=connector_length, d=cutter_diameter + 2*connector_strength + 20);
                cylinder(h=connector_length, d=cutter_diameter + 2*connector_strength);
                translate([-250,0,0])
                    cube([500,500,connector_length]);
            }
        }
    }
}

module distance() {
    multicube([
        [0,1,-7,2],
        [0,1,0,2],
        [0,20,-4,2],
        [0,45,20,2],
        [0,45,20,1],
    ]);
    multicube([
        [0,40,10,2],
        [0,40,18,2],
        [0,45,20,2],
    ]);
    /*
    multicube([
        [0,0,-5,2],
        [0,16,4,2],
        [0,16,-15,2],
    ]);
    */
    //cube([2,65,5]);
}

module hole(){
    translate([-cutter_diameter/2 - connector_strength - 2, -1,connector_length]) {
        /*
        translate([connector_strength/2,-connector_strength/2,-connector_strength/2])
            cube([cutter_diameter + 2*connector_strength + 2,4* connector_strength,connector_strength]);
        */
        rotate([0,90,0])
            cylinder(h=cutter_diameter + 2*connector_strength + 2 + 2, r=1);
    }
}


/**
 * Creates the multicube by making a hull around all points given.
 * @param points vector of vectors containg the dimensions x,y,z and radius
 * @param offset vector specifying the offset, with that you can fix the multicube to start at point 0,0,0 (or whatever you want). This can't be done automagically, as the radii may differ.
**/
module multicube(points,offset=[0,0,0]){
    translate(offset)
        hull(){
            for(point = points){
                // Ensure we have 4 digits for this point
                point = fixpoint(point);
                x = point[0];
                y = point[1];
                z = point[2];
                d = point[3];
                r = d/2;
                translate([x-r,y-r,z-r])
                        sphere(r);
            }
        }
}
function fixpoint(point) = 
    [
        (point[0]!=undef)?point[0]:0,
        (point[1]!=undef)?point[1]:0,
        (point[2]!=undef)?point[2]:0,
        (point[3]!=undef)?point[3]:1,
    ];