
use <write/Write.scad>

/* [Clasp Options] */
// Choose your customisation
type = "text"; // [text, image]
// Size of the inner circle of the clasp
innerRadius = 15; 
// The thickness of the whole thing
innerHeight = 3; 
// Thickness of the outer ring
ringWidth = 5; 
// How deep to make the design
designHeight = 1;
// Rotate the design
rotation = 0;

/* [Image options] */
// Intended for black and white images
file = "file.dat"; //[image_surface:100x100]
// Make this smaller to shrink the image
imageScale = 1;

/* [Text Options] */
claspText = "A";
// Choose a font.
font = 1;// [0:BlackRose, 1:Letters, 2:orbitron, 3:knewave]

// Most of the fonts don't center nicely. You can add a manual adjustment here.
fontOffsetX = 1;
fontOffsetY = 1;
// How big to make the text
textScale = 1.4; 

/* [Hidden] */
// All done. Customizer doesn't need to see all this

/* Simple Cloak Clasp
By mrbenbritton CC BY
Enjoy
1/10/13
Text added and made ready for Customizer.
21/6/15
*/

font_array = ["BlackRose.dxf", "Letters.dxf", "orbitron.dxf", "knewave.dxf"];

textSize = innerRadius*textScale;

outerRadius = innerRadius + ringWidth + 1;
barLength = innerRadius + ringWidth + 1;
barWidth = innerRadius/3;

translate([0,-outerRadius,innerHeight]){
translate([0, 2*outerRadius,0])
male();
color("green") female();
};
//stitchPlate();

module male(){
cylinder(r = innerRadius, h = innerHeight);
translate([0,-barWidth/2,-innerHeight])cube([barLength, barWidth, innerHeight]);
translate([barLength,0,0])stitchPlate();
    rotate([0,0,rotation]){
	if (type == "text"){
        translate([fontOffsetX,fontOffsetY,(innerHeight+designHeight)/2])color("red")write(claspText,t=innerHeight + designHeight,h=textSize, font = font_array[font],center = true);
	}else if (type == "image"){
	color("red")translate([0,0,(innerHeight - 0.01)])
        intersection(){
            resize([innerRadius*1.9*imageScale,innerRadius*1.9*imageScale,designHeight*2]) surface(file, center=true, convexity=5);
            cylinder(r = innerRadius, h = designHeight*20);
        }
    }
}
}

module female(){
scale = 0.1;
fbarLength = barLength*(1+scale);
fbarWidth = barWidth*(1+scale*2.5);
fbarH = innerHeight*(1+scale);
slotWidth = (innerHeight + designHeight)*(1+scale)*1.5; 
slotThick = innerRadius*2*(1+scale);
slotDepth = innerHeight*2*(1+scale);
difference(){
union(){
translate([-barLength,-barWidth/2,-innerHeight])cube([barLength, barWidth, innerHeight]);
translate([0,0,-innerHeight])cylinder(r = outerRadius, h = innerHeight*2);
}
union(){
translate([0,0,-innerHeight/2])cylinder(r = innerRadius+1, h = innerHeight*2);
translate([0,-fbarWidth/2,-fbarH*(1+scale/2)])cube([fbarLength, fbarWidth, fbarH]);
translate([-slotWidth/2,-slotThick/2,-slotDepth])cube([slotWidth, slotThick, slotDepth]);
translate([-fbarWidth/2,0,-slotDepth])cylinder(r = fbarWidth, h = slotDepth);
}
}
translate([-barLength,0,0])rotate([0,0,180])stitchPlate();
}
module stitchPlate(){
long = outerRadius;
holeH = innerHeight*2;
holeR = long/20;
short = outerRadius/1.61;

difference(){
	translate([0, -long/2, -innerHeight])cube([short, long, innerHeight]);
union(){
	for (i = [1:4]){
		for (j = [1, 3]){
			translate([short*j/4,-(long/2 + holeR)+ (long+2*holeR)*i/5,-holeH*.9])cylinder(r = holeR, h = holeH);
		}
	}
}
}
}

