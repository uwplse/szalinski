/* Simple Customizer example.
 * See http://customizer.makerbot.com/docs for more info on making a customizer-compatible SCAD file.
 * See https://www.thingiverse.com/thing:2812634 for instructions on using customizer inside the latest OpenSCAD builds. */

// Diameter of the disk
diameter = 20;

// Height of the disk
height = 10;

// Segments in the outer surface
segments = 64; //[3:128]

// Make a hole in the middle?
hole = "yes"; //[yes,no]

/* [Hidden] */
r = diameter / 2;
segments2 = segments > 6 ? round(segments/2) : 3;
// Boolean options work in the OpenSCAD customizer: they will show up as a checkbox. They don't work in the Thingiverse customizer however at the time of this writing. Therefore either compare with "yes" every time, or convert the value to a boolean for cleaner code:
bHole = (hole == "yes");

difference() {
    cylinder(r=r, height, $fn=segments);

    if(bHole) {
        translate([0, 0, -height/2]) cylinder(r=r/2, height*2, $fn=segments2);
    }
}
