/* [Basics] */
// Insert your poem
text="This placeholder text just goes on and on and on and on and on and on and on and on and on and on and on and on and on and on...";
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
// (mm) the vertical depth of the helical cut around the cylinder. About one layer height. Adjust this until the spiral separates easily.
cutDepth = 0.4;

/* [Hidden] */
// All done. Customizer doesn't need to see all this
font_array = ["BlackRose.dxf", "Letters.dxf", "orbitron.dxf", "knewave.dxf"];
wristRadius = wristDiameter/2;
$fa = 2;
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
bottomEndCut();
topEndCut();
};
rotate([0,0,angleOffset]){
//color("pink")bottomEndCut();
//color("purple")topEndCut();
//%helix();
}

tiltAngle = atan(bandHeight/circumference)*1;
textTilt = tiltAngle*1.5;//This just works. Not sure why...

color("green")writecylinder(text,[0,0,0],t = letterDepth,radius=wristRadius+braceletThickness,height=0,h=fontSize,space=space,rotate=textTilt,east=90,up=bandHeight*.02,font=font_array[font]);

module tube(){
difference(){
cylinder(r = wristRadius+braceletThickness, h = length,center=true);
cylinder(r = wristRadius, h = length+1,center=true);
}
}

module spiralcut(){
angleRotate = ($fs/circumference)*360;
for(i = [0:ceil(circumference*(numberOfTwists+1)/$fs)]){
translate([0,0,sin(angleRotate)*$fs*i])rotate([0,0,-angleRotate*i])
translate([wristRadius,0,-length/2-cutDepth/2])rotate([-tiltAngle,0,0])cube([braceletThickness*3,$fs*1.05,cutDepth], center = true);
}
}
module bottomEndCut(){
angleRotate = ($fs/circumference)*360;
//echo ("angleRotate ",angleRotate);
for(i = [ceil(circumference/$fs):ceil(circumference/$fs)]){
translate([0,0,sin(angleRotate)*$fs*i])rotate([0,0,-angleRotate*i])
translate([wristRadius,0,-length/2-cutDepth/2])rotate([-tiltAngle,0,0])translate([0,0,-(bandHeight/2+cutDepth*1.5)])cube([braceletThickness*3,$fs*1.05,bandHeight+cutDepth*3], center = true);
}
}
module topEndCut(){
angleRotate = ($fs/circumference)*360;
//echo ("angleRotate ",angleRotate);
for(i = [ceil(circumference*(numberOfTwists+1)/$fs):ceil(circumference*(numberOfTwists+2)/$fs)-1]){
translate([0,0,sin(angleRotate)*$fs*i])rotate([0,0,-angleRotate*i])
translate([wristRadius,0,-length/2-cutDepth/2])rotate([-tiltAngle,0,0])translate([0,0,-(bandHeight/2+cutDepth*1.5)])cube([braceletThickness*3,$fs*1.05,bandHeight+cutDepth*3], center = true);
}
}

// Unused module.
module helix(){
angleRotate = ($fs/circumference)*360;
//echo ("angleRotate ",angleRotate);
for(i = [-ceil(circumference*(numberOfTwists)/$fs):ceil(circumference*(numberOfTwists)/$fs)-1]){
translate([0,0,sin(angleRotate)*$fs*i])rotate([0,0,-angleRotate*i])
translate([wristRadius,0,length/2+cutDepth/2])rotate([-tiltAngle,0,0])translate([0,0,-(bandHeight/2+cutDepth)])
	cube([braceletThickness*3,$fs*1.0,bandHeight], center = true);
}
}
echo ("tiltedTextScaleFactor",tiltedTextScaleFactor);
