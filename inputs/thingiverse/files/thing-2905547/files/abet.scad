// Creality Ender-3 tool tray
// by Andrew Davie - andrew@taswegian.com
// shout me a beer!

$fn=32+0;


/////////////////////////////////////////////////////////////////////////////////
// Configuration "Variables" -  MODIFY AS REQUIRED


// Letter or word
TEXT = "Dr Boo";

// height of letters (mm)
SCALE = 30;

// offset of attachment tongue from left leading edge of word
OFFSET = 0;

// length of attachment tongue
LENGTH = 130;

/////////////////////////////////////////////////////////////////////////////////

// back-right tongue joint
module tongueJoint2(L){    
    translate([2,0,0])
    linear_extrude(L)
        polygon([
            [-4.2,2.7],[-4.2,5],[-5,5],[-8,2],[-8,-2],
            [-5,-5],[-4.2,-5],[-4.2,-2.7],[-1.9,-2.7],[-2,-2.7],[-2,2.7]
        ]);
}

/////////////////////////////////////////////////////////////////////////////////
H = 10+0;

translate([OFFSET,0,0])
    rotate([90,0,90])
        tongueJoint2(LENGTH);

translate([0,0,-H/2])
    rotate([0,0,0])
        linear_extrude(H) {
            text(TEXT,size=SCALE);
        }
 