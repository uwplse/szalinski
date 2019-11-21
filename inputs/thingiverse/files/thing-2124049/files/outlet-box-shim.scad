/* multi-gang outlet box shim
   Russell Salerno 2017-02-18
*/

// user customizer parameters
// number of gangs in the outlet box
numGangs = 3; 
// depth of the shim you need
shimDepth = 19.0;           

// the rest of these parameters will not ordinarily be changed
gangSpacing = 46.0375;      // spacing between devices in multi-gang boxes
shimHeight = 6.0;           // height of shim
shimWidth = 44.0;           // width of one device
holeOffset = 3.0;           // distance from top of shim to center of hole
holeDia = 4.0;              // fits standard size screw
$fn=30;

module shim() {
    cube([shimWidth+((numGangs-1)*gangSpacing), shimDepth, shimHeight]);
}

module holes() {
    for (i=[0:numGangs-1]) {
        translate([shimWidth/2 + i*gangSpacing, 0, shimHeight-holeOffset]) rotate([270, 0, 0]) cylinder(d=holeDia, h=shimDepth);
    }
}


difference() {
    shim();
    holes();
}