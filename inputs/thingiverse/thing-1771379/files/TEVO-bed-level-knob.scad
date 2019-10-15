$fn = 128;

//****************************************************************
// PARAMETERS
//****************************************************************

// diameter of the first hole in the top
FIRST_HOLE_DIAMETER     = 11;
// diameger of the second hole in the bottom
SECOND_HOLE_DIAMETER    = 4;

// knob diameter (how big)
KNOB_DIAMETER           = 40;
// total height of the knob (how thick)
KNOB_HEIGHT             = 5;
// height of the metallic knob that will fit into the first hole
METALLIC_KNOB_HEIGHT    = 3;

// radius of the small cylinders that decorate the outside
HANDLE_RADIUS           = 2;

//****************************************************************
// calculations
//****************************************************************
knobRadius  = KNOB_DIAMETER / 2;
holeRadius  = FIRST_HOLE_DIAMETER / 2;
hole2Radius = SECOND_HOLE_DIAMETER / 2;
floorHeight = KNOB_HEIGHT - METALLIC_KNOB_HEIGHT;

//****************************************************************
// ENTRY POINT
//****************************************************************

knob();

//****************************************************************
// modules
//****************************************************************

module knob() {
    difference() {
        cylinder( r = knobRadius, h = KNOB_HEIGHT);
        translate([0,0,-10]) {
            cylinder( r = hole2Radius, h = KNOB_HEIGHT +20);
        }
        translate([0,0,floorHeight]) {
            cylinder( r = holeRadius, h = KNOB_HEIGHT +20);
        }
    }
    cross( 0 );
    cross( 45 );
    cross( 30 );
    cross( 15 );
    cross( 60 );
    cross( 75 );
}

module cross( angle ) {
    _distance = knobRadius - 1;
    rotate([0,0,angle]) {
        translate([_distance, 0, 0]) {
            cylinder( r = HANDLE_RADIUS, h = KNOB_HEIGHT );
        }
        translate([-_distance, 0, 0]) {
            cylinder( r = HANDLE_RADIUS, h = KNOB_HEIGHT );
        }
        translate([0, _distance, 0]) {
            cylinder( r = HANDLE_RADIUS, h = KNOB_HEIGHT );
        }
        translate([0, -_distance, 0]) {
            cylinder( r = HANDLE_RADIUS, h = KNOB_HEIGHT );
        }
    }
}
