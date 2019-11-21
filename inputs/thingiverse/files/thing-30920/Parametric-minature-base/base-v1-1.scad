// base v1_1
// GPLv2
// (c) 2012 TakeItAndRun
//
// v1_0: clean up code
// v1_1: make it work with customizer
// 
//

//*******************************************************
//
// basic definitions
//
//*******************************************************


// circle have $fn facets
$fn=+30;

// small displacement to avoid parallel faces with zero volume
e=+0.02;

// unit vectors
xaxis=[1,0,0];
yaxis=[0,1,0];
zaxis=[0,0,1];

//*******************************************************
//
// dimensions
//
//*******************************************************

/* [base] */
// form of base
rbfn=64;//[4:square,8:octagonal,64:round]
// diameter of the base (for square bases this is the width)
db=25;//[10:100]
// hexagonal and oktogonal a little less in width)
rb=db/2;
// width of the edge (in 1/10 units)
e=10;//[0:20]
edge=e/10;
// to calculate upper radius of the base
rb1=rb-edge;
// height of the base
hb=3;//[1:10]
/* [slit] */
// slit
slit=1;//[0:no slit,1:with slit]
// width of the slit
sx=2;//[1:10]
// offset of the slit off the center
dsx=1;//[0:10]
// length of the slit
sl=2*rb-2*edge-2;
/* [print] */
// distance between bases on the print bed
dxprint=2;//[1:10]
// number of bases in x-direction
nx=2;//[1:10]
// number of bases in y-direction
ny=3;//[1:10]

//*******************************************************
//
// routines
//
//*******************************************************

// base with n corners, set n=rbnf for a round base
module base(n,slit=1){
	difference(){
		rotate(180/n)cylinder(hb,rb/cos(180/n),rb1/cos(180/n),$fn=n);
		if(slit==1)mslit();
	}
}

// make a cubus for the slit to be cut from the base
module mslit(){
	translate(dsx*xaxis+(hb)/2*zaxis)cube([sx,sl,hb+2*e],true);
}

module printbase(n=4,slit=1,nx=5,ny=5){
	for(i=[-(nx-1)/2:(nx-1)/2])
	for(j=[-(ny-1)/2:(ny-1)/2])
		translate((dxprint+2*rb)*(i*xaxis+j*yaxis))base(n,slit);
}

// print a sampling of bases
module samplebase(){
	translate(0*(dxprint+2*rb)*yaxis)base(n=4,slit=1);
	translate(3*(dxprint+2*rb)*yaxis)rotate(30)base(n=6,slit=1);
	translate(2*(dxprint+2*rb)*yaxis)base(n=8,slit=1);
	translate(1*(dxprint+2*rb)*yaxis)base(n=rbfn,slit=1);
	translate(4*(dxprint+2*rb)*yaxis)difference(){
		rotate(30)base(n=6,slit=0);
		mslit();
	}
	
	translate(1*(dxprint+2*rb)*xaxis){
	translate(0*(dxprint+2*rb)*yaxis)base(n=4,slit=0);
	translate((3*(dxprint+2*rb)+rb)*yaxis)rotate(30)base(n=6,slit=0);
	translate(2*(dxprint+2*rb)*yaxis)base(n=8,slit=0);
	translate(1*(dxprint+2*rb)*yaxis)base(n=rbfn,slit=0);
	}
}


//*******************************************************
//
// main program
//
//*******************************************************

// one single base
// n=4 		makes it square, with r being half the diameter
// n=8 		oktogonal(sp?)
// n=rbfn 	round

//base(n=4,slit=0);

// print a sampling of bases
// color("lime")samplebase();

// print lots of bases all at once
//printbase(n=rbfn,slit=1);
printbase(n=rbfn,slit=slit,nx=nx,ny=ny);
