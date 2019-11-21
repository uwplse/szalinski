$fn=128;

// Network SSID
SSID="MyRouter";
// Network Password
PASSPHRASE="SecretPassword";

// Width of the coaster
WIDTH = 100;
// Height of the coaster
HEIGHT = 100;
// Thickness of the base (white) part of the coaster
BASE_THICKNESS = 3;
// Thickness of the boarder around the edge of the coaster
BORDER = 5;
// Thickness of the QR code
QR_THICKNESS = 0.2;
// Margin around the QR Code
MARGIN = 5;
// Size of the text
TEXT_SIZE = 6.5;
// Gap between lines of text, will need tweaking for different TEXT_SIZE
LINE_GAP = 7;
// Margin around the text
TEXT_MARGIN = 3;
// Rounded corners on the edge of the coaster
ROUNDED_CORNERS = 3;
// Rounded corners on the inside of the boarder
INNER_ROUNDED_CORNERS = 3;
// Embed the WiFi logo into the QR Code?
WIRELESS_LOGO = true;
// Make a hole for placing an NFC sticker inside the coaster
NFC_SIZE = [20, 14, 2];
// QR Data, see item description for how to obtain
QR_DATA = [[1,1,1,1,1,1,1,0,0,0,1,0,1,0,1,0,1,0,0,0,1,0,1,1,1,1,1,1,1],
[1,0,0,0,0,0,1,0,1,0,1,0,0,1,0,1,1,0,1,0,1,0,1,0,0,0,0,0,1],
[1,0,1,1,1,0,1,0,0,0,0,0,1,0,0,0,1,0,1,1,0,0,1,0,1,1,1,0,1],
[1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,0,0,1,1,1,1,0,1,0,1,1,1,0,1],
[1,0,1,1,1,0,1,0,0,1,0,0,0,0,0,0,1,1,0,1,0,0,1,0,1,1,1,0,1],
[1,0,0,0,0,0,1,0,1,1,0,1,1,0,1,1,1,1,1,0,0,0,1,0,0,0,0,0,1],
[1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1],
[0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,1,0,1,1,0,0,0,0,0,0,0,0,0],
[1,1,1,1,1,0,1,1,1,1,0,1,0,1,0,1,1,0,0,0,1,1,0,1,0,1,0,1,0],
[1,1,1,0,1,0,0,0,0,0,1,0,1,1,1,0,1,0,0,1,1,0,1,0,1,0,1,1,0],
[0,0,1,0,0,1,1,0,0,0,1,0,0,1,0,1,1,1,1,0,1,1,1,1,0,1,0,0,0],
[0,0,0,1,1,0,0,1,1,0,0,0,1,0,1,0,0,0,0,0,1,1,1,0,1,0,0,1,1],
[1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,1,1,1,0,0,0,0,0,1,1,1,1,0,0],
[0,1,0,1,0,0,0,1,0,0,0,0,0,1,1,0,1,0,1,1,1,1,0,1,1,0,1,1,0],
[0,1,0,1,1,0,1,0,1,0,1,1,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,0,0],
[0,0,0,1,1,0,0,0,1,0,1,1,0,0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,0],
[0,0,1,0,0,1,1,1,1,0,0,1,0,0,0,1,1,1,0,0,1,0,0,1,0,1,0,1,1],
[1,0,0,1,0,1,0,0,1,0,1,0,1,1,0,0,1,0,1,1,1,0,1,0,1,1,0,1,0],
[1,0,0,1,1,0,1,0,1,0,1,0,0,1,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0],
[1,0,0,0,1,0,0,1,0,1,1,0,1,1,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1],
[1,0,0,0,0,1,1,0,0,1,1,0,1,0,1,1,0,1,0,0,1,1,1,1,1,1,1,0,0],
[0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,1,1,0,0,0,1,0,1,0,0],
[1,1,1,1,1,1,1,0,1,0,0,1,1,0,0,1,0,1,1,1,1,0,1,0,1,0,1,0,0],
[1,0,0,0,0,0,1,0,0,1,1,1,0,0,1,1,0,0,1,1,1,0,0,0,1,1,0,1,0],
[1,0,1,1,1,0,1,0,1,1,0,1,0,0,0,1,1,1,0,0,1,1,1,1,1,1,0,1,1],
[1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,1,1,0,1,1,1,0,0,0,1,1,0,1,1],
[1,0,1,1,1,0,1,0,1,0,0,0,0,1,1,1,0,0,0,1,1,0,0,1,1,1,1,1,0],
[1,0,0,0,0,0,1,0,1,1,0,0,1,1,0,1,1,0,0,0,1,1,0,0,1,1,0,1,0],
[1,1,1,1,1,1,1,0,1,0,0,0,1,0,1,1,1,1,0,1,0,1,1,0,1,1,0,0,0]];

QR_WIDTH = WIDTH - BORDER * 2 - MARGIN * 2 - (LINE_GAP * 2) - TEXT_MARGIN;
QR_HEIGHT = HEIGHT - BORDER * 2 - MARGIN * 2 - (LINE_GAP * 2) - TEXT_MARGIN;

color("black") {
    translate([BORDER + MARGIN + LINE_GAP + TEXT_MARGIN, BORDER + MARGIN + (LINE_GAP * 2) + TEXT_MARGIN, BASE_THICKNESS]) {
        scale([QR_WIDTH / 29, QR_HEIGHT / 29, 1.0*QR_THICKNESS]) {
            difference() {
                qr_render(QR_DATA);
                if (WIRELESS_LOGO) {
                    translate([14.5, 12.75, -1]) {
                        intersection() {
                            linear_extrude(3) circle(d=8);
                            translate([0, -0.8, -0.1]) {
                                rotate([0, 0, 45])
                                    cube(12);
                            }
                        }
                        linear_extrude(3) circle(d=2);
                    }
                }
            }
            if (WIRELESS_LOGO) {
                translate([14.5, 12.75, 0]) {
                    intersection() {
                        union() {
                            difference() {
                                linear_extrude(1) circle(d=7);
                                translate([0, 0, -1])
                                    linear_extrude(3) circle(d=6);
                            }
                            difference() {
                                linear_extrude(1) circle(d=5);
                                translate([0, 0, -1])
                                    linear_extrude(3) circle(d=4);
                            }
                            difference() {
                                linear_extrude(1) circle(d=3);
                                translate([0, 0, -1])
                                    linear_extrude(3) circle(d=2);
                            }
                        }
                        rotate([0, 0, 45])
                            cube([7, 7, 7]);
                    }
                    cylinder(d=1);
                }
            }
        }
    }
    translate([0, 0, BASE_THICKNESS]) {
        difference() {
            rcube([WIDTH, HEIGHT, QR_THICKNESS], ROUNDED_CORNERS);
            translate([BORDER, BORDER, -1])
                rcube([WIDTH-(BORDER*2), HEIGHT-(BORDER*2), QR_THICKNESS+2], INNER_ROUNDED_CORNERS);
        }
        if (TEXT_SIZE > 0) {
            translate([WIDTH/2, BORDER + TEXT_MARGIN + LINE_GAP + TEXT_MARGIN, 0]) {
                linear_extrude(QR_THICKNESS) {
                    text(SSID, size=TEXT_SIZE, halign="center", font = "Monospace:style=Bold");
                }
            }
            translate([WIDTH/2, BORDER + TEXT_MARGIN, 0]) {
                linear_extrude(QR_THICKNESS) {
                    text(PASSPHRASE, size=TEXT_SIZE, halign="center", font = "Monospace:style=Bold");
                }
            }
        }
    }
}

color("white") {
    difference() {
        rcube([WIDTH, HEIGHT, BASE_THICKNESS], ROUNDED_CORNERS);
        translate([WIDTH/2, HEIGHT/2, BASE_THICKNESS/2]) {
            cube(NFC_SIZE, center=true);
        }
    }
}

module rcube(xyz, radius) {
    if (radius > 0) {
        hull() {
            translate([radius, radius, 0])
                cylinder(r=radius, h=xyz[2]);
            translate([xyz[0]-radius, radius, 0])
                cylinder(r=radius, h=xyz[2]);
            translate([xyz[0]-radius, xyz[1]-radius, 0])
                cylinder(r=radius, h=xyz[2]);
            translate([radius, xyz[1]-radius, 0])
                cylinder(r=radius, h=xyz[2]);
        }
    } else {
        cube(xyz);
    }
}

// QR code rendering method
module qr_render(data, module_size = 1, height = 1) {
    maxmod = len(data) - 1;
    for(r = [0 : maxmod]) {
        for(c = [0 : maxmod]) {
            if(data[r][c] == 1){
                xo = c * module_size;
                yo = (maxmod - r) * module_size;
                translate([xo, yo, 0]) cube([module_size, module_size, height]);
            }
        }
    }
}