
// Choose "SINGLE" for single extruder, "TEXT" for the text-only part of a dual-extrusion and "BASE" for the base-only part of a dual extrusion.
BUILD = "SINGLE"; // [SINGLE, TEXT, BASE]
//BUILD = "TEXT";
//BUILD = "BASE";

// Each line will appear on a separate arm of the spinner
WORDS1 = "CUSTOM";
WORDS2 = "TRIPLE";
WORDS3 = "SPINNER";

// Any fonts from fonts.google.com should work, just be sure to type the name exactly
FONT = "Arial Rounded MT Bold";

// Adjust the height of the text if needed
TWEAKHEIGHT = 0;

// Adjust how much the text sticks out
TWEAKX = 0;

// Move text to the left or right
TWEAKY = 0;

// Move text up or down
TWEAKZ = 0;

// Make the holes bigger (e.g. +0.1) or smaller (e.g. -0.1)
TWEAKHOLE = 0;

/* Created by Edwin Donnelly, MD, PhD. May 6, 2017 */

if (BUILD == "BASE")
{
   difference()
   {
       spinner();
       addText();        
   }
    
}
else if (BUILD == "TEXT")
{
       addText();     
}
else
{
 spinner();
 addText();
}

module addText()
{
    caption(WORDS1);
    rotate([0,0,120]) caption(WORDS2);
    rotate([0,0,-120]) caption(WORDS3);    
}


module base()
{
  rod();
  rotate([0,0,120]) rod();
  rotate([0,0,-120]) rod();
  outers();      
}

module spinner()
{
   difference()
   { 
    base();
    holes();
   }
}

module holes()
{
    holeC();
    holeP();
    rotate([00,0,120]) holeP();
    rotate([00,0,-120]) holeP();   
}


module holeC()
{
    cylinder(d=22.5+TWEAKHOLE, h=10, $fn=200, center=true);
}

module holeP()
{
    translate([0,35,0]) holeC();
}

module outerHC()
{
    cylinder(d=29, h=7, $fn=200, center=true);
}
module outerHP()
{
    translate([0,35,0]) outerHC();
}
module outers()
{
    outerHC();
    outerHP();
    rotate([00,0,120]) outerHP();
    rotate([00,0,-120]) outerHP();   
}

module rod()
{
    difference()
    {
      translate([7,18,0]) cube([15,36,7], center=true);
      translate([10,21,0]) rotate([0,0,180]) triangle();
    }   
}

module triangle()
{
    POINT0 = [0,0,-7];
    POINT1 = [6.06,3.5,-7];
    POINT2 = [0,7,-7];

    POINT3 = [0,0,7];
    POINT4 = [6.06,3.5,7];
    POINT5 = [0,7,7];
    
    polyhedron ( 
      points = [POINT0, POINT1, POINT2, POINT3, POINT4, POINT5],
      faces = [ 
         [0, 1, 2],
         [1,3,4,2],
         [3,1,0,5],
         [2,4,5,0],
         [3, 5, 4] ] );
}

module caption(WORDS)
{
   color("red")
    translate([13+TWEAKX,1.5+TWEAKY,-3+TWEAKZ]) 
    rotate([90,0,90]) 
     linear_extrude(height=2 )     
      text(WORDS, size= 6+TWEAKHEIGHT, font=FONT);   
}
