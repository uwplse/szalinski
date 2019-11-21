// Module for proper sized holes
module ccylinder_outer(radius1,radius2,height,fn){
	fudge = 1/cos(180/fn);
	cylinder(r1=radius1*fudge,r2=radius2*fudge,h=height,$fn=fn, center=true);
}

// Module for cubes with rounded corners
module crcc(cr_rs,cr_ht,cr_fn,ce_x,ce_y,ce_z) {
	module corner() {
		translate([((ce_x/2)-cr_rs)/0.999,((ce_y/2)-cr_rs)/0.999,0]) {
			difference() {
				translate([0,0,-cr_ht/2]) cube([cr_rs,cr_rs,cr_ht]);
				cylinder(r=cr_rs,h=cr_ht,$fn=cr_fn, center=true);
			}
		}
	}

   difference() {
		cube([ce_x,ce_y,ce_z], true);
		corner();
	   mirror()  corner();
	   rotate([0,0,180]) corner();
	   mirror() rotate([0,0,180]) corner();
	}
}

// Module for drawing the box
module SMDHolder(tapesize, extwidth, screwholes)
difference() {
	union() {
		difference() {
			crcc(extwidth/10, tapesize+3, 128, extwidth, extwidth, tapesize+2);
			translate([extwidth/2, (extwidth/4)-2, 0.8]) cube([extwidth, extwidth/2, tapesize+2], true);
		}
		translate([2, -2, 0]) crcc(extwidth/10, tapesize+3, 128, extwidth-4, extwidth-4, tapesize+2);
	}
	translate([extwidth/5, extwidth/2, ((-(tapesize+2)/2)+(tapesize-1)/2)+0.8]) rotate([0, 0, -45]) cube([1.5, extwidth/2, tapesize-1], true);
	translate([0, 0, -0.9+0.8]) ccylinder_outer((extwidth-4)/2, (extwidth-4)/2, tapesize+0.2, 128);
	translate([0, 0, (extwidth/2)-((tapesize+2)/2)+0.799+(tapesize+.2)]) ccylinder_outer((extwidth-4)/2, 1/2, extwidth, 128);
	//Center hole for winding
	ccylinder_outer(11/2, 11/2, 50, 128);
	//Screwholes
	translate([extwidth*0.4, -extwidth*0.4, 0]) ccylinder_outer((screwholes-0.2)/2, (screwholes-0.2)/2, 50, 128);
	translate([-extwidth*0.4, -extwidth*0.4, 0]) ccylinder_outer((screwholes-0.2)/2, (screwholes-0.2)/2, 50, 128);
	translate([-extwidth*0.4, extwidth*0.4, 0]) ccylinder_outer((screwholes-0.2)/2, (screwholes-0.2)/2, 50, 128);
}

// This is the bit you want to change
// Syntax
// SMDHolder(Tape Size  (8 / 12 /  16 / 24, Total width you want the holder to be, Diameter of the 3 corner holes)

SMDHolder(12, 50, 3);