use <write/Write.scad>

// Which part for Two Color Prints?
part = "both"; // [top:top,bottom:bottom,both:both]

width=175;
height=40;
baseThick=3;
letterThick=4;
text="THOR 3D";
holeRadius=5.2;
holeX=155;
holeY=20;
holeX2=20;
holeY2=20;
fontName="write/Letters.dxf"; //["write/Letters.dxf":Letters, "write/BlackRose.dxf":BlackRose, "write/orbitron.dxf":orbitron, "write/knewave.dxf":knewave, "write/braille.dxf":braille]

	if (part == "top") {
		topcolor();
	} else if (part == "both") {
		maincolor();
		topcolor();
	} else if (part == "bottom") {
		maincolor();
	} else  {
		maincolor();
		topcolor();
	} 



module maincolor(){
	difference(){
		cube([width, height, baseThick]);
		translate([holeX, holeY, 0]) cylinder(r=holeRadius, h = baseThick+letterThick-1);
		translate([holeX2, holeY2, 0]) cylinder(r=holeRadius, h = baseThick+letterThick-1);
		}
}

module topcolor(){
	difference(){
		translate([width/2,height/2,letterThick/2 + baseThick])write(text, t=letterThick, h=height-height/5,font=fontName, center=true);
		translate([holeX, holeY, 0]) cylinder(r=holeRadius, h = baseThick+letterThick-1);
		translate([holeX2, holeY2, 0]) cylinder(r=holeRadius, h = baseThick+letterThick-1);
		}
}

