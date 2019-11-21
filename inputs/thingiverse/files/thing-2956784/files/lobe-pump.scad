/*
This is a lobe pump for compressing fluids in hydraulics or pneumatics.

It can also be used as a motor, or a flow metering device.

To put this thing to practical use, you would need a top and a bottom, as well 
as a pair of same-sized gears to connect the lobes to one another and to your drive mechanism.

As usual, 3D printed parts may or may not hold up under pressure, so take adequate safety precautions.

Licensed under creative commons+attribution.

To fulfill the attribution requirement, please provide a link to on or both of:
https://www.thingiverse.com/thing:2956784
or 
https://theheadlesssourceman.wordpress.com/2018/06/11/customizeable-lobe-pump/
*/

// what to do
show=0; // [0:assembled,1:single lobe,2:housing]

// outside radius of lobes
major_r=50;

// length of lobes
length=50;

// used to calculate how thick the center of the lobes are
shaft_r=10;

// the wall of the housing
housing_thickness=2;

// how much the housing conforms to the rotor sweep
housing_conform=0.15; // [0..1]

// size of the inlet hole
inlet_dia=10;

// size of the outlet hole
outlet_dia=10;

// tightness of the seal fit
seal_fit=0.3;

// resolution 1=low(aka 1x) 2=mid 3=high
resfactor=2;

/* [hidden] */

min_lobe=shaft_r;
minor_r=major_r/2-min_lobe/2;
shaft_offs=major_r+min_lobe;

// make $fn more automatic
function myfn(r)=max(3*r,12)*resfactor;
module circ(r=undef){circle(r=r,$fn=myfn(r));}

module lobe2D(){
	difference(){
		hull(){
			translate([-major_r+minor_r+seal_fit/2,0]) circ(r=minor_r);
			translate([+major_r-minor_r-seal_fit/2,0]) circ(r=minor_r);
		}
		translate([0,-shaft_offs]) circ(r=major_r);
		translate([0, shaft_offs]) circ(r=major_r);
	}
}

module lobe(){
	linear_extrude(length-seal_fit*2) lobe2D();
}

module housingSides2D(){
	difference(){
		square([major_r*2+housing_thickness*2,shaft_offs+major_r*2+housing_thickness*2],center=true);
		hull(){
			translate([0,-shaft_offs/2]) circ(r=major_r*(1-housing_conform));
			translate([0, shaft_offs/2]) circ(r=major_r*(1-housing_conform));
		}
		translate([0,-shaft_offs/2]) circ(r=major_r);
		translate([0, shaft_offs/2]) circ(r=major_r);
	}
}

module housingSides(){
	difference(){
		linear_extrude(length) housingSides2D();
		translate([0,0,length/2]) rotate([0,90,0]) linear_extrude(major_r*2) circ(r=inlet_dia/2);
		translate([0,0,length/2]) rotate([0,-90,0]) linear_extrude(major_r*2) circ(r=outlet_dia/2);
	}
}

module sampleShaft(){
	linear_extrude(length+2) circ(r=shaft_r);
}

if(show==0){
	translate([0,-shaft_offs/2]) sampleShaft();
	translate([0, shaft_offs/2]) sampleShaft();
	translate([0, shaft_offs/2]) lobe();
	translate([0,-shaft_offs/2]) rotate([0,0,90]) lobe();
	housingSides();
} else if (show==1) {
	lobe();
} else if (show==2) {
	housingSides();
}