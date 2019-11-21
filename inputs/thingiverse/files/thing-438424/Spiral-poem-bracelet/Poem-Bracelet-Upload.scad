/* [Basics] */
// Insert your poem
text = "This line is full of words that go on and on and  on and on and  on and on and  on and on and  on and on and  on and on and  on.";
// (mm)
wristDiameter = 66;
// Smaller font size makes a smaller bracelet
fontSize = 6.0;

/* [Extras] */

// (mm) Just like line spacing
bandHeight = 12;
// (mm) Big and chunky or slim and elegant
braceletThickness = 1.2;
// Choose a font.
font = 1;// [0:BlackRose, 1:Letters, 2:orbitron, 3:knewave]
// (mm) Make the letters deeper
letterDepth = 2; 

/* [Hidden] */
// All done. Customizer doesn't need to see all this
wristRadius = wristDiameter/2;
font_array = ["BlackRose.dxf", "Letters.dxf", "orbitron.dxf", "knewave.dxf"];
$fa = 1;
use <write/Write.scad>
circumference = 2*3.14159*(wristRadius+braceletThickness);

space = 1;
//fontSize=8;
wid=(.125* fontSize *5.5 * space);
tiltedTextScaleFactor = sqrt(bandHeight*bandHeight + circumference*circumference)/circumference;
lengthOfText = wid*(len(text))*tiltedTextScaleFactor;//*.99 to fudge for the diagonal
numberOfTwists = lengthOfText/circumference;
angleOffset = (((numberOfTwists)/2)*360);

length = (numberOfTwists+1)*bandHeight;
rotate([0,0,angleOffset])
difference(){
tube();
spiralcut();
};
tiltAngle = atan(bandHeight/circumference)*1.5;

color("green")writecylinder(text,[0,0,0],t = letterDepth,radius=wristRadius+braceletThickness,height=0,h=fontSize,space=space,rotate=tiltAngle,east=90,up=bandHeight*.02,font=font_array[font]);

module tube(){
difference(){
cylinder(r = wristRadius+braceletThickness, h = length,center=true);
cylinder(r = wristRadius, h = length+1,center=true);
}
}

module spiralcut(){
linear_extrude(height = length, center = true, convexity = 10, twist = length/bandHeight*360, $fn = 100)
translate([wristRadius - 2.5, 0, 0])
square([5,100]);
}

