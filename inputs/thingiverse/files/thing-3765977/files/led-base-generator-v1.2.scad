/*
 Generates LED backlighting bases for etched acrylic signs.
 v1.0 released in 2019 by Jeff Eaton (bonsai@angrylittletree.com)
 v1.1 released to fix Customizer bugs, add chamfering
 v1.2 Embarassing typo that broke Customizer again
*/


// Generate one part, multiple parts, or an assembled example
MODE = "set"; // ["base", "halfbase", "plugcap", "endcap", "set", "demo"]
// Rounded or angled base
BASE_SHAPE = "A"; // ["D", "A"]
// How are you supplying power to the LED strip?
CONNECTOR_STYLE = 1; //[1:"Soldered wire", 2:"Strip clip", 3:"Hollow with space for wiring", 4:"Micro-RF Remote"]

// Thickness of the acrylic sheet you're lighting
ACRYLIC_DEPTH = 3.2;
// Width of the acrylic sheet you're lighting
ACRYLIC_WIDTH = 200;
// How high the base should 'grip' the acrylic sheet for stability
SUPPORTED_HEIGHT = 25; // [10:5:50]
// How deep the base should be (deeper == more stable)
BASE_DEPTH = 60; // [20:5:100]
// Add a convenience slot in he base for a small remote control
BASE_REMOTE_HOLDER = false; // [true,false]
// Add a tray for business cards to the sign's base
BASE_CARD_TRAY = false; // [true,false]

// How far out from the sign should the base's endcaps protrude?
BASE_CAP_WIDTH = 20; // [10:5:60]
// How far should the sign's endcaps overlap the main base?
BASE_CAP_OVERLAP = 10; // [5:5:20]


/* [Hidden] */
LED_ELEVATION = 5;
LED_HEIGHT = 3;
LED_WIDTH = 11;
REMOTE_SIZE = [40,8,87];
CARD_TRAY_SIZE = [90,60];
CARD_TRAY_HEIGHT = 20;
BASE_HEIGHT = LED_ELEVATION + LED_HEIGHT + SUPPORTED_HEIGHT;

build(MODE);

module build(m=MODE) {
    if (m == "base") base();
    if (m == "halfbase") base(ACRYLIC_WIDTH/2);
    if (m == "endcap") endcap();
    if (m == "plugcap") plugcap();
    if (m == "set") {
        base();
        translate([BASE_DEPTH*2,BASE_DEPTH/2+5]) rotate([0,0,-90]) plugcap();
        translate([BASE_DEPTH/2+5,BASE_DEPTH/2+5]) rotate([0,0,-90]) endcap();
    }
    if (m == "demo") {
        base();
        translate([-BASE_CAP_OVERLAP*2,0,0])rotate([0,90,0]) endcap();
        translate([ACRYLIC_WIDTH + BASE_CAP_OVERLAP*2,0,0]) rotate([0,90,180]) plugcap();
        #cube([ACRYLIC_WIDTH, ACRYLIC_DEPTH, 200+SUPPORTED_HEIGHT]);
    }
}


module endcap() {
    difference() {
        cap_blank();
        translate([0,0,BASE_CAP_WIDTH-5]) linear_extrude(5.1) led_channel();
    }
}

module plugcap() {
    difference() {
        cap_blank();
        if (CONNECTOR_STYLE == 1) {
            // Hole for a soldered-on cord. Must be threaded through endcap before soldering.
            translate([-LED_ELEVATION,0,-.1]) linear_extrude(BASE_CAP_WIDTH+1) circle(r=2.5, $fn=12);
        }
        else if (CONNECTOR_STYLE == 2) {
            // Hole for a a 15x5mm solderless LED clip.
            translate([-LED_ELEVATION,0,-.1]) linear_extrude(BASE_CAP_WIDTH+1) square([5,15], center=true);
        }
        else if (CONNECTOR_STYLE == 3) {
            translate([0,0,2.4]) union() {
                linear_extrude(BASE_CAP_OVERLAP+BASE_CAP_WIDTH+1) offset(-2, $fn=12) base_profile();
                rotate([90,-90,0]) translate([15,4.5,15]) {
                    translate([0,-2.5,0]) cube([BASE_CAP_WIDTH+BASE_CAP_OVERLAP,5,20]);
                    cylinder(r=2.5, h=20, $fn=24);
                }
            }
        }
        else if (CONNECTOR_STYLE == 4) {
            // Hole for a a 15x5mm solderless LED clip.
            translate([-18,0,-.1]) linear_extrude(BASE_CAP_WIDTH+1) rotate([0,0,180]) scale([1.5,1.15]) led_channel();
        }

    }
}

module cap_blank() {
    difference() {
        linear_extrude(BASE_CAP_WIDTH+BASE_CAP_OVERLAP) offset(1.8, $fn=12) base_profile();
        translate([0,0,BASE_CAP_WIDTH]) linear_extrude(BASE_CAP_OVERLAP+1) union() {
            offset(.2, $fn=12) base_profile();
            acrylic_channel();
        }
    }
}

module base(length=ACRYLIC_WIDTH) {
    ROUNDING = (BASE_SHAPE == "A" ? 4 : 24);
    
    difference() {
        union() {
            rotate([0,90,0])linear_extrude(length) base_profile();
                if (BASE_CARD_TRAY) {
                    translate([ACRYLIC_WIDTH/2,-CARD_TRAY_SIZE[1]+BASE_DEPTH/3,0]) linear_extrude(LED_ELEVATION + CARD_TRAY_HEIGHT) offset(3.2, $fn=ROUNDING) square(CARD_TRAY_SIZE, center=true);
                }
        }

        union() {
            rotate([0,90,0]) {
                translate([0,0,-.5]) union() {
                    linear_extrude(length+1) union() {
                        led_channel();
                        acrylic_channel();
                    }
                }
                if (BASE_REMOTE_HOLDER) {
                    translate([-REMOTE_SIZE[0]/2 - LED_ELEVATION, 15, ACRYLIC_WIDTH/2]) cube(REMOTE_SIZE, center=true);
                }
            }
            if (BASE_CARD_TRAY) {
                translate([ACRYLIC_WIDTH/2,-CARD_TRAY_SIZE[1]+BASE_DEPTH/3,LED_ELEVATION]) linear_extrude(LED_ELEVATION + CARD_TRAY_HEIGHT*2) square(CARD_TRAY_SIZE, center=true);
            }
       }
    }

}

module base_profile() {
    if (BASE_SHAPE == "A") {
        offset(.5, $fn=6) offset(-.5)
        polygon(
            [[0,BASE_DEPTH/2],
            [-BASE_HEIGHT,ACRYLIC_DEPTH/2 + 2],
            [-BASE_HEIGHT,-ACRYLIC_DEPTH/2 - 2],
            [0,-BASE_DEPTH/2]]
        );
    }
    else if (BASE_SHAPE == "D") {
        intersection() {
            scale([BASE_HEIGHT*2, BASE_DEPTH]) circle(r=.5, center=true, $fn=72);
            translate([-BASE_HEIGHT/2,0]) square([BASE_HEIGHT,BASE_DEPTH], center=true);
        }
    }
}

module led_channel() {
    // Channel for the LED strip
    polygon(
        [[-LED_ELEVATION,-LED_WIDTH/2],
        [-LED_ELEVATION-LED_HEIGHT,-LED_WIDTH/2],
        [-LED_ELEVATION-LED_HEIGHT-3,0],
        [-LED_ELEVATION-LED_HEIGHT,LED_WIDTH/2],
        [-LED_ELEVATION,LED_WIDTH/2]]
    );
}


module acrylic_channel() {
    // Channel for theacrylic plate
    translate([-BASE_HEIGHT/2-LED_ELEVATION-LED_HEIGHT,0]) square([BASE_HEIGHT, ACRYLIC_DEPTH], center=true);
}