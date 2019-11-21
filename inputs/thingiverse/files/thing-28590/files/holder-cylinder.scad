/* Cylinder with a hole

To slide onto a horizontal bar of a retort stand (aka "chemistry"
stand) so that the filament roll will turn more easily.  You also can
use this to augment various filament holders and stands made from
filament.

Made by Daniel K. Schneider, TECFA, University of Geneva, August 2012, revised Feb 2016
Licence: Freeware

A hollow cylinder is defined by 5 parameters. It's length, the
diameter of the hole, the outside diameter, extra space added to the
hole diameter and extraspace substracted from the outer diameter.

Measure the diameter of the bar (typically 12mm for a retort stand)
and of the holes of your filament rools.  Use these measures as such,
but you can ajust "extraspace_diameter = 0.25;" and "extra_space" inner.

Adapt parameters if needed.

Hole diameter is 1.2 for a typical retort stand

Filament roll hole diameters seem to vary from 19 to 74 mm. Frequent
ones are 31mm, 39mm and 52mm. Outersize diameter ranges from 12.5cm
(e.g. Taulman T-glase) to 30cm. Typical outer width (length of the
cylinder to print) is from 6cm to 12.5cm. Below the ones that I
printed.

// cylinder_diameter = 31.6; // 
// cylinder_diameter = 38.3; // 
// cylinder_diameter = 50.9; // 

Adjust the length. Add extraspace, e.g. 4cm.

*/


// Diameter of the hole 
hole_diameter = 17; // 

// Extra inner space added to hole diameter
extraspace_hole = 1;

// Diameter of the cylinder (hole of filament roll)
cylinder_diameter = 38.3;

// Outer extra space subtracted from diameter
extraspace_diameter = 0.2;

// Cylinder length
length = 120;


translate ([0,0,length/2]) {
  difference() {
    cylinder (h = length, r=cylinder_diameter / 2 - extraspace_diameter, center = true, $fn=100);
    # cylinder (h = length+2, r=hole_diameter / 2 + extraspace_hole, center = true, $fn=100);
  }
}
