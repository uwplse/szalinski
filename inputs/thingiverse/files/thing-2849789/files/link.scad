LINK_LENGTH = 30;

module link() {
    BEARING_HEIGHT = 7;
    BEARING_OUTER_DIAMETER = 22;
    BEARING_INNER_DIAMETER = 7.9;

    TOLERANCE = .2;
    ADD_HEIGHT = 1;
    LINK_WIDTH = BEARING_INNER_DIAMETER + 2 * ADD_HEIGHT;
    FEMALE_HEIGHT = BEARING_HEIGHT + 2 * (ADD_HEIGHT + TOLERANCE);
    FEMALE_LENGTH = 11;
    MALE_TIP_SUB = 1.5;
    TIP_HEIGHT = BEARING_INNER_DIAMETER / 2 + ADD_HEIGHT - MALE_TIP_SUB;
    MALE_LENGTH = TIP_HEIGHT * 2 - ADD_HEIGHT;
    MALE_INNER = ADD_HEIGHT*2;

    function getConstants() = [
      FEMALE_HEIGHT,
      LINK_WIDTH,
    ];

    module bearing(
        extraOuterDiameter=0, 
        extraInnerDiameter=0, 
        extraHeight=0
    ) {
        difference() {
            cylinder(
                d=BEARING_OUTER_DIAMETER + extraOuterDiameter, 
                h=BEARING_HEIGHT + extraHeight
            );
            
            translate([0, 0, -.5])
            cylinder(
                d=BEARING_INNER_DIAMETER + extraInnerDiameter, 
                h=BEARING_HEIGHT + extraHeight +1
            );
        }
    }
        
    module femaleTop() {
        bearing(
            extraOuterDiameter=(ADD_HEIGHT + TOLERANCE)*2,
            extraHeight=ADD_HEIGHT-BEARING_HEIGHT,
            extraInnerDiameter=(BEARING_OUTER_DIAMETER -
                BEARING_INNER_DIAMETER - 2*ADD_HEIGHT)
        );
    }

    function femaleAlignment() = [
        0, 
        FEMALE_LENGTH + BEARING_INNER_DIAMETER / 2,
        ADD_HEIGHT + TOLERANCE
    ];

    module female(align=false, withBearing=false) {
        translate(align ? femaleAlignment() : [0, 0, 0]) {
            if (withBearing) %bearing();
            difference() {
                union() {
                    translate([0,0,-1*(ADD_HEIGHT+TOLERANCE)])
                    bearing(
                        extraOuterDiameter= 2 * (
                            ADD_HEIGHT + 
                            TOLERANCE
                        ), 
                        extraInnerDiameter=
                            BEARING_OUTER_DIAMETER -
                            BEARING_INNER_DIAMETER +
                            TOLERANCE * 2,
                        extraHeight= 2 * (
                            ADD_HEIGHT + 
                            TOLERANCE
                        )
                    );
                    
                    translate([0,0,-1*(ADD_HEIGHT+TOLERANCE)])
                    femaleTop();
                    
                    translate([0,0,BEARING_HEIGHT+TOLERANCE])
                    femaleTop();
                }
               
                translate([0, -3, -50])
                rotate([0, 0, 45])
                cube(100, 100, 100);
            }
            
            // link
            difference() {
                translate([
                    0, 
                    -BEARING_INNER_DIAMETER / 2, 
                    (
                        BEARING_HEIGHT + 
                        2 * (ADD_HEIGHT + TOLERANCE)
                    ) / 2 - 
                    (ADD_HEIGHT + TOLERANCE)
                ])
                cube([
                  LINK_WIDTH, 
                  FEMALE_LENGTH * 2,
                  FEMALE_HEIGHT,
                ], center=true);
                
                translate([0, 0, -50])
                cylinder(h=BEARING_HEIGHT + 100, d=BEARING_OUTER_DIAMETER + TOLERANCE*2);
            }
        }
    }

    function maleAlignment() = [0, 0, ADD_HEIGHT + MALE_LENGTH + TOLERANCE];

    module male(align=false, withBearing=false) {
        translate(align ? maleAlignment() : [0,0,0]) {
            if (withBearing) %bearing();
            difference() {
                union() {
                    translate([0, 0, -1 * (TOLERANCE + ADD_HEIGHT) - MALE_LENGTH])
                    cylinder(
                        d=BEARING_INNER_DIAMETER - 2 * TOLERANCE, 
                        h=BEARING_HEIGHT + 2 * (ADD_HEIGHT + TOLERANCE) + MALE_LENGTH
                    );
                    
                    // tip
                    translate([0, 0, BEARING_HEIGHT + TOLERANCE])
                    difference() {
                        sphere(
                            d=BEARING_INNER_DIAMETER + 2 * ADD_HEIGHT, 
                            h=ADD_HEIGHT
                        );
                    
                        translate([0,0,-50])
                        cube([100, 100, 100], center=true);
                    }
                    
                    // base
                    translate([0, 0, -1*(ADD_HEIGHT + TOLERANCE) - MALE_LENGTH])
                    cylinder(
                        d=LINK_WIDTH, 
                        h=ADD_HEIGHT + MALE_LENGTH
                    );
                }
            
                union() {
                    translate([0, 0, 50 - TOLERANCE]) {
                        cube([MALE_INNER, 100, 100], center=true);
                        cube([100, MALE_INNER, 100], center=true);
                        cylinder(h=100, r=MALE_INNER, center=true);
                    }
                    
                    translate([0, 0, 
                      BEARING_HEIGHT + TOLERANCE + TIP_HEIGHT
                    ])
                    translate([0, 0, 50])
                    cube([100, 100, 100], center=true);
                }
            }
        }
    }

    module fmLink(n, withBearing=false, showMates=false) {
        // female
        translate([0, -1, 0]) // make sure it's inside the link
        translate(femaleAlignment()) {
            female(withBearing=withBearing);

            if (showMates) {
                rotate([0, 0, $t * 360])
                male();
            }
        }
        
        // link
        length = LINK_LENGTH * n;
        translate([0, -length/2, FEMALE_HEIGHT/2])
        cube([LINK_WIDTH, length, FEMALE_HEIGHT], center=true);
        
        // curved end for male link
        translate([0, -length, 0])
        cylinder(d=LINK_WIDTH, h=FEMALE_HEIGHT);
        
        // male
        translate([0, 0, -1]) // make sure it's inside the link
        translate([0, -length, FEMALE_HEIGHT]) 
        translate(maleAlignment()) {
            male(withBearing=withBearing);
            
            if (showMates) {
                rotate([0, 0, $t * 360])
                female();
            }
        }
    }
    
    fmLink(1);
}

link();