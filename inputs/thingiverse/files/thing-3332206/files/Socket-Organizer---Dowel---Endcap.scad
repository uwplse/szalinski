// -----------------------------------------------------------
// Customizable Socket Organizers: Circular End Cap
// -----------------------------------------------------------
//
// Zemba Craftworks
// youtube.com/zembacraftworks
// thingiverse.com/zembacraftworks/about

// This is a configurable, 3D printable insert designed to
// slide onto a metal or wooden bar to create socket set
// organizers. Dimensions can be adjusted for sockets of
// all sizes and to slide onto bars/holders of any size.

// Date Created:  2018-08-15
// Last Modified: 2018-12-19

// Critical Dimensions
// -------------------
// Adjust these dimensions and verify them with a test print
// before printing holders for all of your sockets! You want a
// snug fit but not so tight that anything gets stuck. These
// values will vary depending on your sockets, the rail you're
// using, and the calibration of your printer.


rr = 4.8;           // Dowel Radius (mm)
                    // (4.8 = approximately 3/8 in * 25.4 mm/in / 2)
fn1 = 60;           // Number of Facets for Curvature 

ct = 3;             // Wall Thickness of End Cap (mm)
ch = 8;             // Height of End Cap (mm)
       
// Tolerance Value
// ---------------
// When shapes are subtracted through difference() in
// OpenSCAD, there is ambiguity if any faces of the two shapes
// occupy the same space. Adding a small value 't' to make
// the subtracted shape slightly larger prevents this.

t = 0.1;

// Create End Cap
union(){

    // Dowel Clamp
    difference(){ 
        union(){
            // Main Dowel Clamp
            cylinder(r=rr+ct,h=ch,$fn=fn1);
            // Main Dowel Cap
            translate([0,0,-ct])
                cylinder(r=rr+ct,h=ct,$fn=fn1);
        }

        // Dowel Volume
        translate([0,0,-t/2])
        cylinder(r=rr,h=ch+t,$fn=fn1);
    }
}