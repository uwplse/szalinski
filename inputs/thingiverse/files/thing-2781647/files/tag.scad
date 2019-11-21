HEIGHT=40;
WIDTH=30;
HOLE=5;
THICKNESS=2;
FILLET=2;
LOOP_PAD=3;
CENTER_PIECE=2; // 0 for none
TAG="4";


hideTheNoneParameters();
module hideTheNoneParameters() {
    $fn=50;
    cornerFilletXOffset = WIDTH/2-FILLET;
    cornerFilletYOffset = HEIGHT-FILLET;
    holePad=HOLE+LOOP_PAD;

    difference() {
        union() {
            // Corner fillets
            translate([-cornerFilletXOffset, FILLET, 0])
                cylinder(h=THICKNESS, r=FILLET, center=true);
            translate([cornerFilletXOffset, FILLET, 0])
                cylinder(h=THICKNESS, r=FILLET, center=true);
            translate([-cornerFilletXOffset, cornerFilletYOffset, 0])
                cylinder(h=THICKNESS, r=FILLET, center=true);
            translate([cornerFilletXOffset, cornerFilletYOffset, 0])
                cylinder(h=THICKNESS, r=FILLET, center=true);
            // Base fillings
            translate([0, HEIGHT/2, 0]) {
                cube([WIDTH-2*FILLET, HEIGHT, THICKNESS], center=true);
                cube([WIDTH, HEIGHT-2*FILLET, THICKNESS], center=true);
            }
            // Loop
            translate([0, HEIGHT+HOLE, 0]) {
                cylinder(r=holePad, h=THICKNESS, center=true);
                translate([0, -holePad/2, 0])
                    cube([2*holePad, holePad, 2], center=true);
            }
            // Loop fillet - the block
            translate([holePad+LOOP_PAD/2, HEIGHT+LOOP_PAD/2, 0])
                cube([LOOP_PAD, LOOP_PAD, THICKNESS],  center=true);
            translate([-(holePad+LOOP_PAD/2), HEIGHT+LOOP_PAD/2, 0])
                cube([LOOP_PAD, LOOP_PAD, THICKNESS],  center=true);
        }
        // Loop fillet 
        translate([holePad+LOOP_PAD, HEIGHT+LOOP_PAD, 0])
            cylinder(r=LOOP_PAD, h=THICKNESS+1,  center=true);
        translate([-(holePad+LOOP_PAD), HEIGHT+LOOP_PAD, 0])
            cylinder(r=LOOP_PAD, h=THICKNESS+1,  center=true);
        
        // Loop hole
        translate([0, HEIGHT+HOLE, 0])
            cylinder(r=HOLE, h=THICKNESS+1, center=true);

        // Text
        translate([0, HEIGHT/2, 0]) {
            linear_extrude(height=THICKNESS+1, center=true) {
                text(TAG, font = "Liberation Sans:style=Bold", size=30, halign="center", valign="center");
            }
        }
    }

    translate([0, HEIGHT/2])
        cube([CENTER_PIECE, HEIGHT-2, THICKNESS], center=true);
}