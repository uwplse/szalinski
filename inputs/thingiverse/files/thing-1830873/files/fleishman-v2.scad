// Width, height of the piece (millimeters)
size = 27; // [1:1:200]

// Material thickness
t = 1.85; // [0.2:0.05:20]

// Extra width of gaps w.r.t thickness
tolerance = 0.15; // [0:0.01:1]

// Distance between panels
w = 1.25; // [0.7:0.05:2.0]

/* [Hidden] */
rsize=size/10;
tol=tolerance/rsize;
tr=t/rsize;

//generate printable model
scale([rsize,rsize,rsize]) bit(); 

//example of animating the assembly
//anime=-10+$t*10; scale([rsize,rsize,rsize]) part();

//example of projection for exporting dxf
//projection(cut = false) scale([rsize,rsize,rsize]) bit();

module bit() {
	difference() {
		cube([10,10,tr], center=true);
		
#		translate([w,2,0])cube([tr+tol,10+tol*2,2], center=true);
#		translate([-w,2,0])cube([tr+tol,10+tol*2,2], center=true);
#		translate([8,w,0]) slot();
#		mirror([1,0,0]) translate([8,-w,0]) slot();
	}
}

module slot() {
	hull() {
		cube([10+tol*2,tr+tol,2], center=true);
		mirror([0,0,1])translate([-3.4,1.2,0])rotate([0,0,55]) cube([3,1,2], center=true);
		
	}
}

module part() {
	translate([0,anime,w]) bit();
	rotate([0,0,180]) translate([0,anime,-w]) bit();
	translate([anime,-w,0]) rotate([-90,-90,0]) bit();
	rotate([0,0,180]) translate([anime,-w,0]) rotate([90,90,0]) bit();
	rotate([-90,0,90]) translate([0,anime,-w]) bit();
    rotate([90,0,0]) rotate([0,-90,0]) translate([0,anime,w]) bit();
}


