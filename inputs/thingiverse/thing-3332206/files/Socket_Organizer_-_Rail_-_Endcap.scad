// -----------------------------------------------------------
// Customizable Socket Organizers: Rectangular End Cap
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


rx = 3.4;           // Rail Cross-Section Thickness (mm)
ry = 13;            // Rail Cross-Section Width (mm)

ct = 3;             // Wall Thickness of End Cap (mm)
ch = 8;           // Height of End Cap (mm)

// Tolerance Value
// ---------------
// When shapes are subtracted through difference() in
// OpenSCAD, there is ambiguity if any faces of the two shapes
// occupy the same space. Adding a small value 't' to make
// the subtracted shape slightly larger prevents this.

t = 0.1;

union(){        
    // Rail Clamp
    difference(){
        // Rail Clamp
        translate([-(rx+2*ct)/2, -(ry+2*ct)/2, 0]){
            cube([rx + 2*ct, ry + 2*ct, ch]);    }    
        // Rail
        translate([-rx/2, -ry/2, 0]){
            cube([rx, ry, ch+t]);    }} 

    // Rail Cap
    translate([-(rx+2*ct)/2, -(ry+2*ct)/2, -ct]){
    cube([rx + 2*ct, ry + 2*ct, ct]);    }      
}