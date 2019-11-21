include <write/Write.scad>
// use <Write.scad>
// http://curriculum.makerbot.com/daily_lessons/february/openscad_write.html

elementSize = 25; // [5:50]
strength = 2; // [1:5]
markingStrength = 1; 
markingWidth = .75; 

module element(marking) {
	difference() {
 		cube(size = [elementSize, elementSize, strength+markingStrength], center = false);
		translate([markingWidth, markingWidth, strength])
			cube(size = [elementSize-2*markingWidth, elementSize-2*markingWidth, markingStrength]);
}

if(marking != "")
	writecube(text=marking, where=[elementSize/2,elementSize/2,strength], size=[elementSize, elementSize, strength], face="top", font = "orbitron.dxf", h=.7*elementSize, t=markingStrength);
}

module curvedPart(x,y) {
	translate([x,y,0])
	intersection() {
		cube(size=[x, y, strength], center=false);
		difference() {		
			cube(size=[2*x, 2*y, strength], center=false);
			translate([x,y,0])
				resize(newsize=[2*x, 2*y, strengtgh])		
					cylinder(h=strength, r=x, $fn=36);
		}
	}
}

module measureTool(aNr, bNr) {
	for ( i = [0 : aNr-1] )
	{
		translate([i*elementSize, 0, 0])
			element(str(i+1));
	}
	for ( i = [0 : bNr-1] )
	{
		translate([i*elementSize, elementSize, 0])
			element("");
	}
}

measureTool(8,4);
curvedPart(elementSize*4, elementSize*1);