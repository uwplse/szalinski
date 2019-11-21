/* Cupboard or Drawer Handle
   by Lyl3

Create a simple circular arc shaped handle for drawers and cupboards

This code is published at:
https://www.thingiverse.com/thing:3911914
licensed under the Creative Commons - Attribution - Share Alike license (CC BY-SA 3.0)

V0.1 - basic working prototype with math worked out
V0.2 - filleted edges
V0.3 - added screw hole and nut hole
V0.4 - fine-tuning, set sane ranges for parameters
V0.5 - added tolerance parameters for the holes
V0.6 - fine-tuned ranges
V0.7 - added parameter and code to create test piece instead of whole handle.
V0.8 - added parameter and code to create nut hole plugs
V1.0 - removed the brim from the nut hole plugs
       ready for release
*/

/* [Handle parameters] */

// Resolution of arcs and circles. Set this to a low value to speed up processing while adjusting parameters and previewing them. Set to 1 or higher for creating an STL mesh to be printed.
resolution = 0.5; // [0.2:0.1:1.5]
$fn = 200*resolution;

// Distance between the center of the screw holes (mm)
screwDistance = 95; // [40:0.1:250]

// Height of the handle (oriented as it would be on a drawer) (mm)
handleHeight = 15; //[5:0.1:40]

// Thickness of the handle (in the middle where you would grab it) (mm)
handleThickness = 5; // [3:0.1:15]

// Depth of the handle (amount it protudes from the drawer or cupboard) (mm)
handleClearance = 25; // [20:0.1:50]

// Width of mounting area on each side of the handle (oriented as it would be on a drawer) (mm)
mountWidth = 20; // [10:0.1:80]

// Radius of filleted edge (0 for no fillet) (mm)
fillet = 2; // [0:0.1:5]

// Part to create: whole handle, test piece for testing dimensions of holes, or nut hole plugs (to cover holes if handle will be mounted vertically)
createPart = "handle"; // [handle,test piece,nut hole plugs]
createTestPiece = (createPart=="test piece") ? true : false;
createNutHolePlugs = (createPart=="nut hole plugs") ? true : false;

/* [Screw Hole Parameters] */

// Distance from screw hole center to inside edge of mount area (mm)
screwHoleOffset = 5.5; // [2:0.1:60]

// Diameter of screw (mm). An M4 screw has a nominal diameter of 4 mm.
screwDiameter = 4; // [1:0.01:10]

// Length of screw hole (mm)
screwHoleLength = 8; // [2:0.1:25]

// Tolerance added to walls for the screw hole (mm). This is added to all sides of the hole: a screw diameter of 3 mm with tolerance of 0.05 mm would make the hole diameter 3.1 mm. 
screwHoleTolerance = 0.05;  // [0:0.01:0.2]

screwHoleDiameter = screwDiameter + 2*screwHoleTolerance;
screwHoleDepth = screwHoleLength + 2*screwHoleTolerance;

/* [Nut Hole Parameters] */

// Create holes for inserting nuts?
withNutHoles = "yes"; // [yes,no]
createNutHoles = (withNutHoles=="yes") ? true : false;

// Distance from back of handle to the hole for inserting a nut (mm)
nutHoleOffset = 2.2; // [1:0.1:25]

// Width of nut across flats (between parallel sides) (mm). The ANSI M4 nut specification maximum is 7.00 mm and the minimum is 6.78 mm. The default of 6.89 is the average. 
nutWidth = 6.89; // [3:0.01:16]

// Thickness of nut (mm). The ANSI M4 nut specification maximum is 3.20 mm and the minimum is 2.90 mm. The default of 3.05 is the average. 
nutThickness = 3.05; // [1:0.01:12]

// Tolerance added to walls for the nut hole (mm). This is added to all sides of the hole: a nut width of 6 mm with a tolerance of 0.15 mm would make the nut hole width 6.3 mm. It doesn't have to be a tight fit, so the tolerance can be a bit loose.
nutHoleTolerance = 0.15;  // [0:0.01:0.2]

nutHoleWidth = nutWidth + 2*nutHoleTolerance;
nutHoleHeight = nutThickness + 2*nutHoleTolerance;
nutHoleDepth = handleHeight/2+nutHoleWidth/sqrt(3)+nutHoleTolerance;

/* [Advanced] */

/* [Hidden] */
fudge = 0.001; // Value added or subtracted to various values to ensure each part is a single manifold mesh 

// Math reference: https://en.wikipedia.org/wiki/Circular_segment
outerChord = screwDistance + 2*mountWidth - 2*screwHoleOffset;
mountChord = screwDistance - 2*screwHoleOffset;

outerRadius = (handleClearance/2) + (outerChord*outerChord/8/handleClearance) - 2*fillet;
mountRadius = sqrt(outerRadius*outerRadius - outerChord/2*outerChord/2 + mountChord/2*mountChord/2) + 2*fillet;
echo(outerChord,mountChord,outerRadius,mountRadius);

innerRadius = outerRadius - handleThickness + 2*fillet; 
cutterCube = 3 * outerRadius; // Make cut cube large enough 

/*
Create the part(s)
*/
if (createNutHolePlugs) {
  translate([-nutWidth-1,-nutThickness/2,0]) cube([nutWidth,nutThickness,2]);
  translate([1,-nutThickness/2,0]) cube([nutWidth,nutThickness,2]);
}
else
{
  translate([0,-outerRadius+handleClearance/2-fillet,fillet]) difference() {
    minkowski() {
      union()  {
        difference() {  // Create the handle arc
          linear_extrude(handleHeight - 2*fillet) circle(outerRadius);
          translate ([0,0,-fudge/2]) linear_extrude(handleHeight- 2*fillet + fudge) circle(innerRadius);
          translate([-cutterCube/2,-cutterCube+outerRadius-handleClearance,-cutterCube/2]) cube(cutterCube);
        }

        difference() {  // Create the mount area
          linear_extrude(handleHeight - 2*fillet) circle(outerRadius);
          translate ([0,0,-fudge/2]) linear_extrude(handleHeight - 2*fillet + fudge) circle(mountRadius);
          translate([-mountChord/2-fillet,0,-fudge/2]) cube([mountChord+2*fillet,outerRadius,handleHeight-2*fillet + fudge]);
          translate([-cutterCube/2,-cutterCube+outerRadius-handleClearance,-cutterCube/2]) cube(cutterCube);
        }
      }
      sphere(fillet,$fn=30*resolution);
    }
    // cut away material added by fillet to the mount area at the back of the handle
    translate([-cutterCube/2,-cutterCube+outerRadius-handleClearance+fillet,-cutterCube/2]) cube(cutterCube);
    // cut out the screw holes
    translate([-screwDistance/2,outerRadius-handleClearance+fillet,handleHeight/2-fillet]) rotate([-90,0,0]) cylinder(h=screwHoleDepth+fudge, d=screwHoleDiameter);
    translate([screwDistance/2,outerRadius-handleClearance+fillet-fudge,handleHeight/2-fillet]) rotate([-90,0,0]) cylinder(h=screwHoleDepth+fudge, d=screwHoleDiameter);
    // cut out the nut holes
    if (createNutHoles) {
      translate([-screwDistance/2-nutHoleWidth/2,outerRadius-handleClearance+nutHoleOffset+fillet,-fillet-fudge]) cube([nutHoleWidth,nutHoleHeight,nutHoleDepth]);
      translate([screwDistance/2-nutHoleWidth/2,outerRadius-handleClearance+nutHoleOffset+fillet,-fillet-fudge]) cube([nutHoleWidth,nutHoleHeight,nutHoleDepth]);
    }
    // create test piece: cut away all other volume
    if (createTestPiece) {
      translate([-screwDistance/2+screwHoleOffset+6,-cutterCube/2,-cutterCube/2]) cube(cutterCube);
    }
  }
}