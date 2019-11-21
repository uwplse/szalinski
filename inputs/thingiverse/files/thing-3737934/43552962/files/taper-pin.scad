/* 
A taper pin is a pin used in mechanical engineering to precisely align two parts.
https://en.wikipedia.org/wiki/Taper_pin

These normally have to work with a tapered reamer of a precise angle, but this
also lets you create a pin to fit whatever reamer you have.

A sample is provided for $3 harbor freight reamer.
SKU 66936
https://www.harborfreight.com/t-handle-reamer-66936.html

Licensed under Creative Commons + Attribution License

To fulfil the attribution requirement, please provide a link back to:
https://theheadlesssourceman.wordpress.com/2019/07/09/taper-pins/
*/

/* [main] */

// resolution 1=low(aka 1x) 2=mid 3=high
resfactor=4;

// diameter of starting hole
min_dia=6.35; // 1/4 inch

// length of the pin
length=25.4; // 1 inch

// MUST fill out the appropriate section below corresponding to your selection
calculate_taper_by=0; // [0:angle,1:reamer measurements,2:taper ratio]


/* [angle] */

angle=12;


/* [reamer measurements] */

// reamer diameter at one point
reamer_d1=11.18;

// reamer diameter at another point
reamer_d2=12.87;

// distance between two points (linear, not along taper)
reamer_dist=14.69;


/* [taper ratio] */

// common taper ratios are 1:48 (imperial) or 1:50 (metric)
taper_ratio_1_to=48;


/* [optional lanyard string attachment (so you don't lose your pin)] */

// Extend the pin and add a hole for a lanyard string so you don't lose the thing
lanyard=true;

// how big a hole for the string
lanyard_hole_dia=1.75;

// minimum amount of material around lanyard
lanyard_margin=1;

// add a gutter between the lanyard attachment and pin to discourage dust accumulation
lanyard_dust_gutter=1.89;


/* [hidden] */

// make $fn more automatic
function myfn(r)=max(3*r*resfactor,12);
module cyl(r=undef,h=undef,r1=undef,r2=undef){cylinder(r=r,h=h,r1=r1,r2=r2,$fn=myfn(r!=undef?r:max(r1,r2)));}
module circ(r=undef){circle(r=r,$fn=myfn(r));}
module ball(r=undef){sphere(r=r,$fn=myfn(r));}
module rotExt(r=undef){rotate_extrude(r,$fn=myfn(r)) children();}

taper_angle=calculate_taper_by==0?angle:calculate_taper_by==1?atan(abs(reamer_d1-reamer_d2)/2/reamer_dist):(atan(1/taper_ratio_1_to)/2);
max_dia=min_dia+2*length*tan(taper_angle);

lanyard_knob_dia=max(max_dia+1,lanyard_margin*2+lanyard_hole_dia);
lanyard_knob_h=lanyard_margin+lanyard_hole_dia;

cyl(r1=max_dia/2,r2=min_dia/2,h=length);
if(lanyard==true&&lanyard_hole_dia>0) difference(){
	translate([0,0,-(lanyard_knob_h+lanyard_dust_gutter)]) cyl(r=lanyard_knob_dia/2,h=lanyard_knob_h+lanyard_dust_gutter);
	translate([0,0,-lanyard_dust_gutter/2]) rotExt() { // dust gullet
		hull(){ 
			translate([max_dia/2-lanyard_dust_gutter/2,0])circ(r=lanyard_dust_gutter/2,$fn);
			translate([lanyard_knob_dia,0]) circle(r=lanyard_dust_gutter/2,$fn=4); // square
		}
		translate([max_dia/2,0]) square([lanyard_knob_dia,lanyard_dust_gutter]);
	}
	translate([0,lanyard_knob_dia,-lanyard_dust_gutter-lanyard_hole_dia/2]) rotate([90,0,0]) cyl(r=lanyard_hole_dia/2,h=lanyard_knob_dia*2,$fn=12);
}


