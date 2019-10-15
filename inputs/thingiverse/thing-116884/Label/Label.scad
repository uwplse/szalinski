use <write/Write.scad>

// Which part for Two Color Prints?
part = "both"; // [top:top,bottom:bottom,both:both]

width=180;
height=45;
baseThick=3;
letterThick=4;
letterHeight = 30;
text="label";

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
		cube([width, height, baseThick]);
}

module topcolor(){
	translate([width/2,height/2,letterThick/2 + baseThick])write(text, t=letterThick, h=letterHeight,font=fontName, center=true);
}


