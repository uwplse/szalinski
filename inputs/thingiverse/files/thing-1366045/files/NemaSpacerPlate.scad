/*
 * Customizable spacer plate for NEMA motors.
 * Change the values to your needs.
 * The outer fit will not be generated, if the height is lower than 5.0mm.
 * (c) 2016 by Roman Buchert (roman.buchert@googlemail.com)
 * This file is licensed by "by-nc-sa"
 */
 
//Height of the distance plate in mm
HEIGHT= 10.0;

//Base size of the stepper motor. 42.3mm on NEMA 17.
BASE_SIZE = 42.3;

//Chamfer of the stepper motor. Something about 3mm on a NEMA 17.
BASE_CHAMFER = 3.0;

//Distance of the mounting hole of the stepper motor. 31mm on NEMA 17.
HOLE_DISTANCE = 31.0;

//Size of the mounting hole of the stepper motor. M3 on NEMA 17, so the hole should be something about 3.2mm.
HOLE_DIAMETER = 3.2;

//Size of the mounting fit. 22mm on NEMA 17.
FIT_DIAMETER = 22.0;

//Shape of the base plate.
module plate(){
    //Outline
    P = [
        0,
        BASE_CHAMFER,
        (BASE_SIZE - BASE_CHAMFER),
        BASE_SIZE,
    ];
    //Mounting holes
    H = [ 
        (BASE_SIZE - HOLE_DISTANCE) / 2.0,
        BASE_SIZE - ((BASE_SIZE - HOLE_DISTANCE) / 2.0)
    ];
    
    //Points of the base shape
    baseshape=[ 
        [P[1], P[0]],
        [P[2], P[0]],
        [P[3], P[1]],
        [P[3], P[2]],
        [P[2], P[3]],
        [P[1], P[3]],
        [P[0], P[2]],
        [P[0], P[1]],
        [P[1], P[0]]
    ];
    // cut out holes
    difference(){
        polygon(baseshape);
        translate([H[0], H[0], 0]){
            circle(d = HOLE_DIAMETER);
        }
        translate([H[1], H[0], 0]){
            circle(d = HOLE_DIAMETER);
        }
        translate([H[1], H[1], 0]){
            circle(d = HOLE_DIAMETER);
        }
        translate([H[0], H[1], 0]){
            circle(d = HOLE_DIAMETER);
        }
        translate([BASE_SIZE / 2.0, BASE_SIZE / 2.0, 0])
        {
            circle(d = FIT_DIAMETER);
        }
    }
}

module mounting_fit(){
    difference(){
        cylinder(d=FIT_DIAMETER, h = 5.0);
        translate([0, 0, -0.1]){
            cylinder(d1=FIT_DIAMETER , d2 = FIT_DIAMETER - 3.0, h = 5.2);
        }
    }
}

//build it up!
module spacer_plate(){
    union(){
        linear_extrude(HEIGHT){
            plate();
        }
        // the outer fit will not generated if height < 5.0
        if (HEIGHT >= 5.0) {
            translate([BASE_SIZE / 2.0, BASE_SIZE / 2.0, HEIGHT - 3.0]){
                mounting_fit();
            }
        }
    }
}

$fn=64;
spacer_plate();