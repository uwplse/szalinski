//Make housing for pogo spring pins for programming, test etc.
//Change parameters to below to suit, either in header, or as parameters to PogoHousing() in examples below.
// Makes an NxM grid of holes for pogos, with zig-zag rows possible.
// Can also add holes for mechanical index pins.
// main module is  PogoHousing()
//module PogoHousing(pogor,Ncols,Nrows=1,L=25, colpitch=2.54,rowpitch=2.54,coloffset=0,IndexPins=[])

//colpitch=2.54; //pitch
//rowpitch=colpitch;
// 
//coloffset=0; // for zig zag connectors, in units of colpitch, ie notmally +/-0.5 for zigzag
//
//pogor=1.37/2;  //radius of pogos
////pogor=1.67/2;  //radius of pogos (Nat's random 1.67dia pogos)
//Ncols=3;  //number of pogos inline
//Nrows=1;
//L=33-8; //total length

//---other control vars ---
tightL=4; //length of tight part
wallt=1.5;
hSolderPocket=5; //elongated part at top for soldering
wSolderPocket=1; //top hole is widened by this each side of pin

//adjust these numbers for your printer. +ve if holes are smaller than designed
holeos1=0.4 /2; //full length (tight) holes
holeos2=0.7 /2; //mid part (loose) holes

//Index Pins are mechanical only pins to locate the pogos over the PCB. It is an array of [X,Y,R] for each pin.
IndexL=10; //depth of holes for Index Pins

//----------------- Examples  --------------------------------------

//For 2mm pitch SMD pin header solder pads in CLOG, with 2x 1.2mm index pins
//FEINMETALL - F07515B120G180 - PROBE,1.02x33, SPRING CONTACT
//farnell 2009278

PogoHousing(pogor=1.02/2, Ncols=3, Nrows=2, L=33-8, colpitch=2.250,rowpitch=4.5,
                             IndexPins=[ [-4, -1.455, 1.2/2], [4, -1.455, 1.2/2]]);



translate([20,0,0])
 
PogoHousing(pogor=1.37/2, Ncols=3, Nrows=1, L=33-8, colpitch=2.54,rowpitch=2.54);
 

// 3x2 2mm CLOG without index pins.
//FEINMETALL - F58506B150G200 - PROBE, 1.37x33mm SPRING CONTACT Element4 1313709
//http://www.farnell.com/datasheets/24038.pdf

translate([40,0,0])
PogoHousing(pogor=1.37/2, Ncols=3, Nrows=2, L=33-8, colpitch=2.250,rowpitch=4.5);


// TC2030-MCP_NL Programming Port ww.tagconnect.com (6pin micro programming header) - haven't found pogos yet...
// this was suposed to be standard ex-stock header, but never avail when needed.

translate([60,0,0])
PogoHousing(pogor=0.6/2, Ncols=3, Nrows=2, L=25-8, colpitch=1.27,rowpitch=1.27,IndexPins=[ [-2.54, -(0.381+1.27/2), 0.9/2], [-2.54, 0.381+1.27/2, 0.9/2] ,  [2.54, 0, 0.9/2]]);


//6 way micromatch NOT FINISHED Top view

translate([80,0,0])
PogoHousing(pogor=1.37/2, Ncols=3, Nrows=2, L=25-8, colpitch=2.54, coloffset=-0.5, rowpitch=2.54,IndexPins=[ [-2.54*2, -1.27, 1.6/2]]);

//----------------- modules -------------------------------------------
module IH(IndexPins,IndexL,OS) { //Make index pin cylinders. OS sets the oversize of the pins
for (IP=IndexPins) {
    translate([IP[0],IP[1],IndexL/2])
    cylinder(h=IndexL, r=IP[2]+OS,center=true,$fn=10);
    } //for
}

module BS(X,Y,L,wallt,wSolderPocket,xofs,IndexPins,IndexL) { //make the tapered body
	hull() {
          translate([xofs,0,0.5])
		cube([X-wallt,Y-wallt,1],center=true); //narrow bottom
		translate([xofs,0,5+L/2])
			cube([X,Y + 2*wSolderPocket ,L-5],center=true); //mid part
        IH(IndexPins,IndexL,wallt);
	
	}
}

function Odd(N) = floor(N/2); //1 for odd nms, 0 for evens

//----------------- Main Module -------------------------------------
module PogoHousing(pogor,Ncols,Nrows=1,L=25, colpitch=2.54,rowpitch=2.54,coloffset=0,IndexPins=[]) {  //main module
   assign( X=colpitch*(Ncols-1+ abs(coloffset)) + 2*pogor+ 2*wallt,
				Y= rowpitch*(Nrows-1) +  (pogor+wallt) *2)
	difference () {
		BS(X,Y,L,wallt,wSolderPocket,coloffset*colpitch/2,IndexPins,IndexL);  //make tapered body
		translate([0,0,L/2])
			for (row=[1:Nrows]) {
				for( col=[1:Ncols]) {
				  translate([(col-Ncols/2 -0.5)*colpitch + Odd(row)*coloffset*colpitch, (row-Nrows/2 -0.5) *rowpitch,0]) {
					  cylinder(r=pogor+holeos1,h=L+2,center=true,$fn=10); //tight at the bottom
				  translate([0,0,tightL])
					  cylinder(r=pogor+holeos2,h=L,center=true,$fn=10); //loose in the middle
				  for (dy=[-wSolderPocket,wSolderPocket])  //wide solder pockets at the top
				      translate([0,dy,L/2+0.1]) cylinder(r=pogor+holeos2,h=hSolderPocket,center=true,$fn=10);
				  }//for
				}//for
			}//for
    IH(IndexPins,IndexL+0.2,holeos1); //put holes for index pins
	} //diff
}
