/////////////////Parameters
/* [Sizes] */
// total width
tw =192; // [20:250]
// total length
tl = 154; // [20:250]
// height
owh = 40; // [10:100]
// boxes in width direction
nw=4; // [1:10]
// boxes in length direction
nl=3; // [1:10]
// outer wall width
oww = 1; // [0:3]
// inner wall width 
iww = 0.6; // [0:3]
/* [Hidden] */

//drawing

boxes(nw,nl,oww,iww,owh,(tw-2*oww+iww)/nw,(tl-2*oww+iww)/nl);

//////////////////Calculations + modules

module boxes(nbw,nbl,ow,iw,oh,boxw,boxl) {
	difference() {
		cube([nbw*boxw+ow+ow-iw,nbl*boxl+ow+ow-iw,oh]);
		for (i=[0:nbw-1])
			for (j=[0:nbl-1])
				translate([i*boxw+ow,j*boxl+ow,ow])
					#cube([boxw-iw,boxl-iw,oh]);
	}
}

