// ArbiColumn v1_0
// GPLv2
// (c) 2012 TakeItAndRun

// Demo of how to make cylinders with varying radius in OpenSCAD

// a small number
// every sub-cylinder overlapps the next one by a distance 0.02mm
// this will avoid slicer errors

//segment height
e=0.02;

// height of horn
h=100;

//radius at top of horn
r0=1;
//radius at bottom of horn
r1=10;

//thinness (Between 0-.999; the higher the number, the thinner it is.
thinness=.9;

/* [hidden] */
// vertical resolution
nh=32;
//nh=128;

// height of each sub-cylinder (actually, they are really sub-cones)
dh=h/nh;

// make circles look nice and smooth
// smallesd size of every radial facet, this should be way sufficient for 3D-printing
$fs=1;		
// total number of radial facets
//$fn=128;		//makes the column real smooth
//$fn=4;			// makes square colums
//$fn=6;			// makes hexagonal colums

// loop over 0 to 1 in steps of 1/nh
// (this will actually make a column of height h+e=10+0.02
for(i=[0:1/nh:1-1/nh]){
// pick a color for every column,
// move every column along the x-axis and
// move every cone up to the hight i*h
// make a cone of hight dh+e, so such every cone overlapps the next
// do this for 5 different funktions of r
	color("cyan")translate([0,0,i*h])
    difference()
    {
        cylinder(h=dh+e,r1=rad(i),r2=rad(i+1/nh));
        translate([0,0,-.001])
        cylinder(h=dh+e+.002,r1=thinness*rad(i),r2=thinness*rad(i+1/nh));
    }
}

// a quadratic or parabel column: concave
// (the zero point of the modulation function is at i=0.5 
//function r1(i)=r0*(1+2*a*(i-1)*(i-1));//between 1 and 1+2a
function rad(i)=r0+(1+2*((r1-1)/2)*(i-1)*(i-1));//between 1 and 1+2a
//we want r1=r2=1+2a when i=0
//a = (r2-1)/2

