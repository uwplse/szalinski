/*
 * Candlestick, v0.42
 *
 * by Alex Franke (CodeCreations), Feb 2014
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, and render. 
 * 
 * v1.00, Feb 8, 2014: Initial Release.
 */
 
/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////
 
/* [Global] */

// Diameter of the candle
candleDiameter = 25;

// Height of the tube that holds the candle
height = 15;

// Thickness of the tube material 
thickness = 1.2;

// Number of candle legs
legs = 3;

// Length of candle legs
legLength = 35;

// Thickness of candle legs
legThickness = 20;

// Total height of candle legs
legHeight = 10;  

// Height of tube above the surface. 
holderHeight = 5; 

// Curve quality 
$fn=30;

/* [Hidden] */

r = candleDiameter/2 + thickness;
s = legThickness/2;  

// how far in do we move the legs so the edges meet the edge of the cylinder?
x = r - sqrt(  pow(r,2) - pow(s,2) );

/////////////////////////////////////////////////////////////////////////////
// Modules 
/////////////////////////////////////////////////////////////////////////////


difference() {
	union() {
		cylinder(h=height, r=candleDiameter/2+thickness);
		for(i=[0:legs-1]) {
			rotate([0,0,360/legs*i]) 
			translate([candleDiameter/2+thickness-x,0,0]) 
				leg();
		}
	}
	translate([0,0,thickness]) 
	cylinder(h=height, r=candleDiameter/2);
}

module leg() {
	translate([0,legThickness/2,0]) 
	rotate([90,0,0])
	linear_extrude( height=legThickness )
	polygon(points=[
		[0,0],
		[0,legHeight],
		[legLength,-holderHeight],
		[holderHeight,-holderHeight]
	]); 
}

