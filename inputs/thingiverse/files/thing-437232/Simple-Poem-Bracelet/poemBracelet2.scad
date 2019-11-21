/* [Basics] */
// Insert your poem
text = "Once upon a time I started a story. It went like this: ";
// (mm)
wristDiameter = 60;
// Smaller font size can fit more words
fontSize = 5.0;

/* [Extras] */

// (mm) Big and chunky or slim and elegant
braceletHeight = 15;
// (mm) Thick can hold more words
braceletThickness = 1.2;
// Choose a font.
font = 1;// [0:BlackRose, 1:Letters, 2:orbitron, 3:knewave]
// (mm) Make the letters deeper
letter_depth = 2; 


/* [Hidden] */
// All done. Customizer doesn't need to see all this
font_array = ["BlackRose.dxf", "Letters.dxf", "orbitron.dxf", "knewave.dxf"];
$fa = 1;
use <write/Write.scad>
wristR = wristDiameter/2;


difference(){
cylinder(r = braceletThickness + wristR, h = braceletHeight);
translate([0,0,-.5])cylinder(r = wristR, h = braceletHeight+1);
};
color("green")writecylinder(text,[0,0,0],t = letter_depth,radius=braceletThickness + wristR,height=braceletHeight,h=fontSize,font=font_array[font]);
