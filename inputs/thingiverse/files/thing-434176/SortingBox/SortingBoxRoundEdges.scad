/////////////////Parameters
/* [Sizes] */
// total width
tw =102;
// total length
tl = 104;
// height
owh = 40;
// boxes in width direction
nw=3; // [1:10]
// boxes in length direction
nl=3; // [1:10]
// outer wall width
oww = 1;
// inner wall width 
iww = 0.6;
// edge radius
r = 0.9;
/* [Hidden] */
$fn=12;
//drawing

if (r<=0) {
	boxes(nw,nl,oww,iww,owh,(tw-2*oww+iww)/nw,(tl-2*oww+iww)/nl);
} else {
	rboxes(nw,nl,oww,iww,owh,(tw-2*oww+iww)/nw,(tl-2*oww+iww)/nl,r);
}

//////////////////Calculations + modules

module boxes(nbw,nbl,ow,iw,oh,boxw,boxl) {
	difference() {
		cube([nbw*boxw+ow+ow-iw,nbl*boxl+ow+ow-iw,oh]);
		for (i=[0:nbw-1])
			for (j=[0:nbl-1])
				translate([i*boxw+ow,j*boxl+ow,ow])
					cube([boxw-iw,boxl-iw,oh]);
	}
}

module rboxes(nbw,nbl,ow,iw,oh,boxw,boxl,r) {
	difference() {
		rcube(nbw*boxw+ow+ow-iw,nbl*boxl+ow+ow-iw,oh,r);
		for (i=[0:nbw-1])
			for (j=[0:nbl-1])
				translate([i*boxw+ow,j*boxl+ow,ow])
					rcube(boxw-iw,boxl-iw,oh,r);
	}
}

module rcube(w,l,h,r) {
	minkowski(){
		cube([w-2*r,l-2*r,h-2*r]);
		sphere(r);
	}	
}