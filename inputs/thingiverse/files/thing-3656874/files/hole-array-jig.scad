// This is an alignment tool for drilling an array of holes
//
// Licensed under Creative Commons+Attribution
//
// To fulfil the attribution requirement, please provide a link to
//  https://www.thingiverse.com/thing:3656874
//  or
//  https://theheadlesssourceman.wordpress.com/2019/05/27/hole-array-jig/
//  (the latter is preferred)


// flip the whole model upside-down for pringing
flip_for_printing=1; // [0=off,1=on]

// resolution 1=low(aka 1x) 2=mid 3=high
resfactor=2;

// Festool standard is 20mm.  Set to 19.05 for 3/4 inch hole.
hole_dia=20;

// figure on holes being +- this amount (will make posts taper for tighter fit)
hole_tolerance=0.15;

// Festool standard is 96mm on center
hole_spacing=96;

// this should be a little less than your material thickness
alignment_post_height=12;

// put a chamfer on the end of the alignment post
alignment_post_chamfer=2.5;

// put fins on the alignment posts (0 to disable)
post_num_fins=12;

// this is a ratio down:up
post_fin_percent=0.66;

// how thick the jig is
base_thickness=3;

// raised outset for drilling area.  (this could make printing more difficult, so a better way is to increase base thickness)
drill_raised_outset=0;

// margin around jig (and more importantly, around the drilling hole)
jig_margin=2;

// puts dust reliefs on stuff
dust_relief_dia=1.5;

/* [warp deterrent texture] */

// texture num sides (0=no texture)
texture_num_sides=4;

// mm
texture_cell_w=2;

// mm
texture_cell_h=3;

// mm
texture_deapth=0.5;

// mm
texture_cell_spacing=2.5;


/* [hidden] */

jigsize=hole_spacing+hole_dia+jig_margin;
maxHoleR=hole_dia/2+hole_tolerance;
minHoleR=hole_dia/2-hole_tolerance;

// chord math
// crd() is a common function used in chord math (compare sin, cos, etc...)
function crd(theta)=2*sin(theta/2.0);

// the short straight line length between ends of the chord
function chord_shortcut_len(r,theta)=r*crd(theta);

// make $fn more automatic
function myfn(r)=max(3*r,12)*resfactor;
module cyl(r=undef,h=undef,r1=undef,r2=undef){cylinder(r=r,h=h,r1=r1,r2=r2,$fn=myfn(r!=undef?r:max(r1,r2)));}
module circ(r=undef){circle(r=r,$fn=myfn(r));}
module rotExt(r=undef){rotate_extrude(r,$fn=resfactor);}

/*
Creates an array of objects laid out on a hexagon plan.
useage:
	hex_array([24,24,24],6) sphere(3);
	hex_array([30,40],8) rotate([0,0,30]) circle(r=4,$fn=6); // honeycomb (note: gap between cells is due to difference between inradius and circumradius.  If $fn was higher, there would be no gap!)
where:
	1) child items should be centered
	2) spacing does not account for child iems width.  You'll need to add that manually.
	3) size can be for a 1d, 2d, or 3d array
	4) unlike array(), spacing MUST BE a single number
Resulting array is centered.
*/
module hex_array(size,spacing){
	size=len(size)==undef?[size,0,0]:
		len(size)<2?[size[0],0,0]:
		len(size)<3?[size[0],size[1],0]:
		size;
	//echo(size);
	spacing=spacing==undef?[0,0,0]:
		[spacing,spacing*sin(60),spacing*sin(60)*sin(60)];
	//echo(spacing);
	n=[
		spacing[0]<=0?1:max(floor(size[0]/spacing[0]),1),
		spacing[1]<=0?1:max(floor(size[1]/spacing[1]),1),
		spacing[2]<=0?1:max(floor(size[2]/spacing[2]),1),
		];
	//echo(n);
	for(z=[0:n[2]-1])
	for(y=[0:n[1]-1-z%2])
	for(x=[0:n[0]-1-y%2]) {
		translate([
			spacing[0]*(x-(n[0]-y%2)/2),
			spacing[1]*(y-(n[1]-z%2)/2),
			spacing[2]*(z-(n[2]    )/2),
			]) children();
	}
}

module expansion_pattern(size,micro_size,margin=0.5,nsides=4){
	linear_extrude(size[2]) hex_array([size[0],size[1]],micro_size[1]+margin){
		scale([1,micro_size[1],micro_size[0]]) circle(r=micro_size[1]/2,$fn=nsides);
	}
}

module drop_post(xy){
	cut_width=chord_shortcut_len(maxHoleR,360/post_num_fins)*post_fin_percent;
	center_r=maxHoleR/3;
	inside_cut_width=chord_shortcut_len(center_r,360/post_num_fins)*post_fin_percent;
	translate([xy[0],xy[1],-alignment_post_height]) difference(){
		union(){
			translate([0,0,alignment_post_chamfer]) cyl(r1=minHoleR,r2=maxHoleR,h=alignment_post_height-alignment_post_chamfer);
			cyl(r2=minHoleR,r1=minHoleR-alignment_post_chamfer,h=alignment_post_chamfer);
		}
		// dust relief
		translate([0,0,alignment_post_height]) rotExt() translate([maxHoleR,0]) circ(r=dust_relief_dia/2);
		// fins
		for(a=[0:360/post_num_fins:359.999]){
			rotate([0,0,a]) hull() {
				translate([maxHoleR,-cut_width/2,0]) cube([1,cut_width,alignment_post_height]);
				translate([center_r,-inside_cut_width/2,0]) cube([1,inside_cut_width,alignment_post_height]);
			}
		}
	}
}

module alignment_star_cyl(r,h,star_w=1.5,star_l=3,numPoints=4){
	// cyl with alignment marks to line up for drawing circs
	linear_extrude(h){
		for(a=[0:360/numPoints:359.999]){
			rotate([0,0,a]) translate([0,r-star_l]) scale([1,star_l/star_w]) rotate([0,0,45]) square([star_w,star_w]);
		}
		circ(r=r);
	}
}

module main_plate(){
	corner_r=maxHoleR+jig_margin;
	size=corner_r*4+hole_spacing;
	d=hole_spacing/2;
	texture_deapth=texture_num_sides<3?0:texture_deapth;
	// texture overlay
	if(texture_deapth>0) translate([d,d,base_thickness-texture_deapth]) intersection(){
		expansion_pattern([size,size,texture_deapth],[texture_cell_w,texture_cell_h],texture_cell_spacing,texture_num_sides);
		// shape
		hull(){
			translate([-d,-d]) cyl(r=corner_r,h=base_thickness);
			translate([ d,-d]) cyl(r=corner_r,h=base_thickness);
			translate([-d, d]) cyl(r=corner_r,h=base_thickness);
			translate([ d, d]) cyl(r=corner_r,h=base_thickness);
		}
	}

	// substrait
	hull(){
		translate([0,0]) cyl(r=corner_r,h=base_thickness-texture_deapth);
		translate([hole_spacing,0]) cyl(r=corner_r,h=base_thickness-texture_deapth);
		translate([0,hole_spacing]) cyl(r=corner_r,h=base_thickness-texture_deapth);
		translate([hole_spacing,hole_spacing]) cyl(r=corner_r,h=base_thickness);
	}

}

module mft_template(){
	// body with drill hole
	difference() {
		union(){
			// main plate
			main_plate();
			// upright post
			translate([hole_spacing,hole_spacing,0]) cyl(r=maxHoleR+jig_margin,h=drill_raised_outset+base_thickness);
		}
		// drill hole
		translate([hole_spacing,hole_spacing,-base_thickness/2]) alignment_star_cyl(r=minHoleR,h=drill_raised_outset+base_thickness*2);
	}

	// drop-posts
	difference(){
		union(){
			drop_post([0,0]);
			drop_post([hole_spacing,0]);
			drop_post([0,hole_spacing]);
		}
		// cutout for edge alignment
		translate([0,0,-alignment_post_height*1.5]) cube([hole_spacing+hole_dia,hole_spacing+hole_dia,alignment_post_height*2]);
		// dust relief
		translate([-dust_relief_dia/2,-dust_relief_dia/2,-dust_relief_dia/2]) cube([hole_spacing+hole_dia+dust_relief_dia,hole_spacing+hole_dia+dust_relief_dia,dust_relief_dia]);
		translate([0,0,-alignment_post_height*1.5]) cyl(r=dust_relief_dia/2,h=alignment_post_height*2);
	}
}


// alignment thingy
//translate([0,0,20]) color([1,0,0,0.5]) square([hole_spacing,hole_spacing]);

mirror([0,0,flip_for_printing])	translate([-hole_spacing/2,-hole_spacing/2,-base_thickness]) mft_template();

//drop_post([0,0]);