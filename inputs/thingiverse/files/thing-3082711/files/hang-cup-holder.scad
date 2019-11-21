$fn = 50;

// Variables
_overallHeight = 55;
_thickness = 2;
_hangerSpace = 22;
_hangerWidth = 25;
_cupDiameter = 75;

//Calculated
_cupPartOD = _cupDiameter+(_thickness*2);

// Hanger Back Part
translate([-_thickness,-_hangerWidth/2,0]) 
  cube([_thickness, _hangerWidth ,_overallHeight]);

// Hanger Top Part
translate([0,-_hangerWidth/2,_overallHeight-_thickness]) 
  cube([_hangerSpace,_hangerWidth,_thickness]);

// Hanger Front Part
translate([_hangerSpace,-_hangerWidth/2,0]) 
  cube([_thickness, _hangerWidth ,_overallHeight]);


// Cup Part
translate([(_cupPartOD/2)+_hangerSpace,0,0]) cupPart();

// cube([_hangerSpace, _hangerWidth/2, _thickness]);


module cupPart () 
{
  difference()
  {
    cylinder(d=_cupPartOD, h=_overallHeight);
    translate([0,0,_thickness]) cylinder(d=_cupDiameter, h=_overallHeight);
  }

}