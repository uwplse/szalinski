/*
A reader for player piano rolls.

More similar designs are archived here:
	https://web.archive.org/web/20161029053154/http://iammp.org/designfiles.php
	
This is licensed under CreativeCommons + Attribution + ShareAlike

For the attribution requirement, please provide a link to one or both of:

https://www.thingiverse.com/thing:2958365
https://theheadlesssourceman.wordpress.com/2018/06/22/piano-roll-reader

*/


/* [general settings] */

goal=0; // [0:assembled,1:reader bar,2:box,3:round half roller,4:tabbed half roller]

// inches.  distance from either spool to the reader bar
spool_distance=3;

// resolution 1=low(aka 1x) 2=mid 3=high
resfactor=1;


/* [piano roll settings] */

// 88 is standard for 1911 and onward, 65 before that
notes=88; 

// in inches 11.25 is the 1911 standard
paper_width=11.25; 

// (on center) 9 is the 1911 standard 6 is pre-1911
holes_per_inch=9;

// inches
hole_size=0.0625;

// inches
hole_spacing=0.25;

// additional perforations to work the pedals
accenting_perfs=0; // [0:no,1:yes]

/* [reader bar settings] */

// inches
reader_height=1;

// inches
reader_min_thick=0.25;
	
// inches
reader_max_thick=0.375;

/* [takeup spool settings] */

// inches
takeup_spool_dia=1.5;

// inches
takeup_spool_end_thick=0.25;

// inches
takeup_spool_hole_dia=0.25;

// inches
takeup_spool_pin_dia=0.25;

// inches
takeup_spool_pin_flat_w=1.0;

// inches
takeup_spool_pin_flat_d=0.25;

// in inches. standard sizes are 2, 2.5, 2.825, and 2.625
spool_size=2.5;


/* [case] */

// mm
box_wall_thickness=3;

// mm.  usually used to make the box sides thicker to accommodate bearings. (hint: 608 skate bearing is 7mm)
box_side_thickness=7;

// mm
screw_head_dia=5;

// mm
screw_hole_dia=3;

// mm.  inset from edge of player
keyhole_inset=5;

// mm.  hole for the shafts (hint: 608 skate bearing is 22mm)
box_hole_dia=22;


/* [hidden] */

function in2mm(in)=in*25.4;

// make $fn more automatic
function myfn(r)=max(3*r,12)*resfactor;
module cyl(r=undef,h=undef,r1=undef,r2=undef){cylinder(r=r,h=h,r1=r1,r2=r2,$fn=myfn(r!=undef?r:max(r1,r2)));}
module circ(r=undef){circle(r=r,$fn=myfn(r));}
module ball(r=undef){sphere(r=r,$fn=myfn(r));}

module perfBar(){
	// NOTE: children are assumed to be a connector, and will be added for each port
	height=in2mm(reader_height);
	min_thick=in2mm(reader_min_thick);
	max_thick=in2mm(reader_max_thick);
	length=in2mm(paper_width);
	chamfer=1;
	hole_r=in2mm(hole_size)/2;
	hole_inc=in2mm(hole_spacing);
	hole_area_w=in2mm(notes/holes_per_inch);
	holes_end=hole_area_w/2;
	holes_start=-hole_area_w/2;
	roundover=height*1.66;
	difference(){
		rotate([0,90,0]) translate([0,0,-length/2]) rotate([0,0,-90]) linear_extrude(length) hull(){
			// profile
			translate([0,-height/2]) square([min_thick,height]);
			intersection(){
				translate([max_thick-roundover,0]) circ(r=roundover);
				translate([0,-height/2+chamfer]) square([max_thick,height-chamfer*2]);
			}
		}
		// holes going in
		for(x=[holes_start:hole_inc:holes_end-0.01]){
			translate([x,-min_thick/2,0]) rotate([90,0,0]) cyl(r2=hole_r,r1=hole_r*2,h=max_thick-min_thick/2);
			translate([x,-min_thick/2,0]) ball(r=hole_r*2);
		}
		// holes going to connectors
		for(x=[holes_start:hole_inc:holes_end-0.01]){
			if(x>holes_start&&((x-holes_start)/hole_inc)%2<1){
				translate([x,-min_thick/2,-hole_r]) cyl(r=hole_r*2,h=height);
			}else{
				mirror([0,0,1]) translate([x,-min_thick/2,-hole_r]) cyl(r=hole_r*2,h=height);
			}
		}
	}
	// connectors
	for(x=[holes_start:hole_inc:holes_end-0.01]){
		if(x>holes_start&&((x-holes_start)/hole_inc)%2<1){
			translate([x,-min_thick/2,height/2]) children();
		}else{
			mirror([0,0,1]) translate([x,-min_thick/2,height/2]) children();
		}
	}
}

module sample_spool(){
	// stand-in for a player piano spool
	r=in2mm(takeup_spool_dia)/2;
	end_r1=in2mm(takeup_spool_end_thick)/2;
	end_r2=in2mm(spool_size)/2;
	hole_r=in2mm(takeup_spool_hole_dia)/2;
	extra_gap=2; // to accommodate differences in paper width
	l=in2mm(paper_width+extra_gap);
	rotate([0,90,0]) translate([0,0,-l/2-end_r1*2]){
		// basic spool shape
		translate([0,0,end_r1]) rotate_extrude() { // end cap
			translate([hole_r,-end_r1]) square([end_r2-end_r1-hole_r,end_r1*2]);
			translate([end_r2-end_r1,0]) circ(r=end_r1);
		}
		linear_extrude(l+end_r1*4) difference() {
			circ(r=r);
			circ(r=hole_r);
		}
		translate([0,0,l+end_r1*3]) rotate_extrude() { // end cap
			translate([hole_r,-end_r1]) square([end_r2-end_r1-hole_r,end_r1*2]);
			translate([end_r2-end_r1,0]) circ(r=end_r1);
		}
	}
}

module takeup_spool(){
	r=in2mm(takeup_spool_dia)/2;
	end_r1=in2mm(takeup_spool_end_thick)/2;
	end_r2=in2mm(spool_size)/2;
	hole_r=in2mm(takeup_spool_hole_dia)/2;
	pin_r=in2mm(takeup_spool_pin_dia)/2;
	pin_w=in2mm(takeup_spool_pin_flat_w);
	pin_d=in2mm(takeup_spool_pin_flat_d);
	extra_gap=2; // to accommodate differences in paper width
	l=in2mm(paper_width+extra_gap);
	difference(){
		rotate([0,90,0]) translate([0,0,-l/2-end_r1*2]){
			// basic spool shape
			translate([0,0,end_r1]) rotate_extrude() { // end cap
				translate([hole_r,-end_r1]) square([end_r2-end_r1-hole_r,end_r1*2]);
				translate([end_r2-end_r1,0]) circ(r=end_r1);
			}
			linear_extrude(l+end_r1*4) difference() {
				circ(r=r);
				circ(r=hole_r);
			}
			translate([0,0,l+end_r1*3]) rotate_extrude() { // end cap
				translate([hole_r,-end_r1]) square([end_r2-end_r1-hole_r,end_r1*2]);
				translate([end_r2-end_r1,0]) circ(r=end_r1);
			}
		}
		// cutout the pin
		translate([0,-r+pin_d]) rotate([90,0,0]) linear_extrude(r*2) difference(){
			square([pin_w,r*2],center=true);
			circle(pin_r);
		}
	}
}


module keyhole(screw_head_dia,screw_hole_dia){
	circ(screw_hole_dia/2);
	translate([0,-screw_head_dia]) circ(screw_head_dia/2);
	translate([-screw_hole_dia/2,-screw_head_dia]) square([screw_hole_dia,screw_head_dia]);
}


module aquariumTubingConnector(support_thickness=0,support_angle=0,support_size=0) {
	od_dia=5.3;
	length=10;
	wall_thickness=1;
	id_dia=od_dia-wall_thickness*2;
	barb_size=0.5;
	barb_offset=4;
	support_size=max(support_size,od_dia/2+barb_size);
	difference(){
		union(){
			cyl(r=od_dia/2,h=length-barb_offset);
			translate([0,0,length-barb_offset]) cyl(r1=od_dia/2+barb_size,r2=id_dia/2,h=barb_offset);
			if(support_thickness>0){
				rotate([0,0,support_angle]) translate([0,-support_thickness/2,0]) cube([support_size,support_thickness,length]);
			}
		}
		translate([0,0,-1]) cyl(r=id_dia/2,h=length+2);
	}
}


module readerBox(){
	wall_thickness=box_wall_thickness;
	r=in2mm(takeup_spool_dia)/2;
	end_r1=in2mm(takeup_spool_end_thick)/2;
	end_r2=in2mm(spool_size)/2;
	r2=end_r2;
	dist=in2mm(spool_distance);
	min_thick=in2mm(0.25);
	max_thick=min_thick+in2mm(0.125);
	extra_gap=2; // to accommodate differences in paper width
	roller_gap=1; // to give the roller room to run
	l=in2mm(paper_width+extra_gap);
	total_box_w=l+end_r1*2+roller_gap*2+box_side_thickness*2;
	total_box_h=(dist+r2+max_thick)*2;
	screwX=total_box_w/2-box_side_thickness-keyhole_inset-screw_head_dia/2;
	screwY=total_box_h/2-wall_thickness-keyhole_inset-screw_head_dia;
	access_hole_dia=in2mm(1.5);
	incAcc=access_hole_dia*1.33;
	access_hole_end=(floor(total_box_w/incAcc)*access_hole_dia)/2;
	difference(){
		rotate([0,90,0]) translate([0,0,-total_box_w/2]) rotate([0,0,90]) linear_extrude(total_box_w) difference(){
			hull(){
				// side profile
				translate([r,-dist]) circ(r2+roller_gap);
				translate([r, dist]) circ(r2+roller_gap);
				translate([r+r2+wall_thickness,-(dist+r2+max_thick)]) square([1,total_box_h]); // flat bottom
			}
			// shaft holes
			translate([r,-dist]) circ(box_hole_dia/2);
			translate([r, dist]) circ(box_hole_dia/2);
			// TODO: side access holes
			//translate([0, access_hole_dia/2]) circ(r=access_hole_dia/2,h=100);
			//translate([0,-access_hole_dia/2]) circ(r=access_hole_dia/2,h=100);
		}
		// cut out the inside
		translate([-(total_box_w-box_side_thickness*2)/2,-r2*3,-(total_box_h-wall_thickness*2)/2]) cube([total_box_w-box_side_thickness*2,r+r2*4,total_box_h-wall_thickness*2]);
		// access holes in the back
		for(xAcc=[-access_hole_end:incAcc:access_hole_end]){
			translate([xAcc,0,0]) rotate([-90,0,0]) cylinder(r=access_hole_dia/2,h=100);
		}
		// vertical mounting holes
		translate([0,-wall_thickness*2+r2*2,0]) rotate([90,0,0]) linear_extrude(wall_thickness*3) {
			translate([ screwX, screwY]) keyhole(screw_head_dia,screw_hole_dia);
			translate([-screwX, screwY]) keyhole(screw_head_dia,screw_hole_dia);
			translate([-screwX,-screwY]) keyhole(screw_head_dia,screw_hole_dia);
			translate([ screwX,-screwY]) keyhole(screw_head_dia,screw_hole_dia);
		}
	}
	// reader support pedestal
	difference(){
		translate([-(total_box_w-box_side_thickness*2)/2,-in2mm(reader_height)/2+in2mm(reader_max_thick)+box_wall_thickness,-in2mm(reader_height)/2]) cube([total_box_w-box_side_thickness*2,r+r2-in2mm(reader_min_thick)+box_wall_thickness*2,in2mm(reader_height)]);
		for(xAcc=[-access_hole_end:incAcc:access_hole_end]){
			translate([xAcc,in2mm(reader_height)*2,-access_hole_dia]) cylinder(r=access_hole_dia/2,h=100);
		}
	}
}

if(goal==0){
	translate([0,in2mm(takeup_spool_dia)/2,in2mm(spool_distance)]) sample_spool();
	perfBar() {
		aquariumTubingConnector();
	}
	translate([0,in2mm(takeup_spool_dia)/2,-in2mm(spool_distance)]) takeup_spool();
	readerBox();
} else if(goal==1){
	rotate([-90,0,0]) perfBar() {
		min_thick=in2mm(0.25);
		aquariumTubingConnector(support_angle=90,support_thickness=0.1,support_size=min_thick/2);
	}
} else if(goal==2){
	rotate([-90,0,0]) readerBox();
} else if(goal==3){
	difference() {
		rotate([90,0,0]) takeup_spool();
		translate([-400,-50,-100]) cube([800,100,100]);
	}
} else if(goal==4){
	difference() {
		rotate([-90,0,0]) takeup_spool();
		translate([-400,-50,-100]) cube([800,100,100]);
	}
}
	
