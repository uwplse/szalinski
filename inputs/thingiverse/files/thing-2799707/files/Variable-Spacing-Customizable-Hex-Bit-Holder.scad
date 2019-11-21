/*
* Variable Spacing Customizable Hex Bit Holder
* by Wesley T. Honeycutt
* http://wesleythoneycutt.com
* Remixed from Customisable hex bit holder by Mykhaylo Lytvynyuk
* License changed to include derivatives so I could publish.
* Inherits CC-BY-NC-SA 3.0 license from original
*
* Version history:
*    v1 - Feb. 19, 2018
*      Summary of changes:
*      Initial publication.  This file allows the user to make
*      custom hex bit holders for parts with variable tool
*      radii.  While the hex bit size stays the same, some 
*      tools such as hex sockets have variable widths depending
*      on the size of the socket.  This design incorporates a
*      recursive function which calculates a new spacing for 
*      each individual part, such that there is enough room
*      on the holder to include all of the parts.  This design
*      currently only works in 1 dimension for the purpose of 
*      spacing the parts.  It cannot, at this time, create 
*      multiple rows of parts like the original.
*/

/**
	Customisable hex bit holder 
	Copyring Mykhaylo Lytvynyuk March 2015
	http://mobilemodding.info
	Released under 
	Attribution - Non-Commercial - No Derivatives License

	*** March 16, 2015 Initial Version
*/
 	
// Hex Socket sizes (in mm)
// This must be an array [brackets,and,commas] of widths.
_sizes = [
  12.7000,
  11.1125,
   9.5250,
   8.7313,
   7.9375,
   7.1438,
   6.3500,
   5.5563,
   4.7625,
   3.9688
   ];

// Wall thickness of socket
// This is extra padding for the thickness of the socket material.
// For example, if the socket says it is 1/2", the width of the
// tool is 1/2" + some metal thickness.
_sock = 2;
 					
// mm, base height
_height = 15; //default 15

// mm, printer tolerance, can be negative, required to compensate specific printer contraction/expansion during print.
_tolerance = 0.33;

//mm, between sides and bit
_extraPadding = 2;

// Rounded corners
_rounded = 1;//[1:Yes,0:No]

// Determines if hole goes compeltely through the base
_holeThrough = 1;	//[1:Yes,0:No]	

// Make slot to add flex to the walls
_slotted = 1;//[1:Yes,0:No]

// mm, defines bit size ( 6.35 is 1/4" )
_bitSize = 6.35;

/* [Hidden] */
// local vars
outerRadius = outRadius(_bitSize + _tolerance/2,6);
delta = outerRadius + _extraPadding;
minkowskiCylinderHeight = 1;
// calculates total length of object
eachLength = [ for (i = [0:(len(_sizes)-1)]) (((_sizes[i])/2) + _sock + delta )];  
function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));
totalLength = (sumv(eachLength,(len(eachLength)-1),0)) + max(eachLength);
depth = max(_sizes);
width = (outerRadius + _extraPadding);

module assembly() {

difference() {
	base();
    for(i = [0:(len(_sizes)-1)]) {
        if(i == 0) {
            translate([(eachLength[i]),(max(_sizes)/2),_holeThrough?0:1]) hexBit();
            if(_slotted){
                translate([(eachLength[i])+1,-2,minkowskiCylinderHeight + _height - _height * 0.75]) rotate([0,0,90]) cube([width + 8,2,_height*0.75],center=false);
            }
        }
        else {
            translate([(eachLength[i]+sumv(eachLength,i-1,0)),(max(_sizes)/2),_holeThrough?0:1]) hexBit();
            if(_slotted){
                translate([(eachLength[i]+sumv(eachLength,i-1,0))+1,-2,minkowskiCylinderHeight + _height - _height * 0.75]) rotate([0,0,90]) cube([width + 8,2,_height*0.75],center=false);
		}
        }
    }
}

}

module hexBit() {
	cylinder(h=_height+minkowskiCylinderHeight,r=outRadius(_bitSize/2 + _tolerance/2,6),$fn=6, center = false);
}

module base() {
	minkowski() {
		cube([totalLength,depth,_height]);
		if(_rounded) cylinder(r=1,h=minkowskiCylinderHeight,$fn=32,center = false);
	}
}

// calculates outradious by given inradius
function outRadius(inradius, sides) = inradius / ( cos (180 / sides));

assembly();