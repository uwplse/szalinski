/* Lightweight photo stand */

// Part to display
part = "first"; // [first:Main part,second:Leg]

// Picture height in milimeters, may require some tweaking to obtain a good fit
photo_height=127;
/* Examples values:
 * - for 10x15: 102, 152.5
 * - for 13x19: 127, 192.5 */

// Angle made by the two main branches of the "A", in degrees. Examples: 50 for landscape orientation, 25 for portrait
branches_angle=50;

/* [Hidden] */

 /* Paper thickness */
photo_t=0.25;

/* Inclination w.r.t. vertical */
photo_angle=10;

/* Inclination of the leg w.r.t. the photo */
leg_angle=30;

hook_angle=50;
segment_l=2;
segment_l2=3;
segment_l3=4;
segment_t=3;
segment_t2=2;
hook_t=1;
hook_h=1;
triangle_h=photo_height*0.5;

branch_rotation=90-branches_angle/2;

/* Half-spaces */

module y_le(d)
     translate([-500,d-1000,-500])cube([1000,1000,1000]);
module y_ge(d)
     translate([-500,d,-500])cube([1000,1000,1000]);
module z_le(d)
     translate([-500,-500,d-1000])cube([1000,1000,1000]);

module base()
     translate([0,-photo_height-hook_h,0]) rotate([photo_angle,0,0]) y_le(0);

/* "A"-shaped part */
module A() {
     difference() {
	  /* Main two segments */
	  intersection() {
	       translate([0,hook_h,0]) {
		    rotate([0,0,-branch_rotation]) translate([-10,-segment_l/2,-segment_t])
			 cube([1000,segment_l,segment_t+hook_t]);
		    rotate([0,0,branch_rotation]) translate([-1000+10,-segment_l/2,-segment_t])
			 cube([1000,segment_l,segment_t+hook_t]);
	       }
	       translate([-500,-photo_height-1*hook_h,-segment_t-1])
		    cube([1000,photo_height+2*hook_h,10]);
	  }
	  /* Room for the picture */
	  difference(){
	       translate([-500,-photo_height,0]) cube([1000,photo_height,10]);
	       translate([0,-photo_height,photo_t]) rotate([-hook_angle,0,0]) y_le(0);
	       translate([0,0,photo_t]) rotate([hook_angle,0,0]) y_ge(0);
	  }
	  base();
     }
     /* Horizontal segment with hole to connect the leg */
     translate([0,-triangle_h,-segment_t/2])
	  difference() {
	  cube([2*triangle_h*tan(branches_angle/2),segment_l2,segment_t],center=true);
	  cube([4,1.5,segment_t+1],center=true);
     }
}

/* Supporting leg */
module leg() {
     difference() {
	  translate([0,-triangle_h,0])
	       intersection() {
	       translate([0,-segment_l2/2,-segment_t])
		    rotate([-180+leg_angle,0,0])
		    translate([-segment_l3/2,-500,0]) cube([segment_l3,1000,segment_t2]);
	       y_le(segment_l2/2);
	       z_le(-segment_t);
	  }
	  base();
     }
     translate([0,-triangle_h,0])
	  difference() {
	  translate([0,0,-segment_t/2]) cube([4-0.5,1.5-0.3,segment_t],center=true);
  	  rotate([-20,0,0])
	       translate([-2,-2-0.3,-5]) cube([4,2,10]);
	       // y_le(-0.3); // preview does not work
	  rotate([20,0,0])
	       translate([-2,0.3,-5]) cube([4,2,10]);
	       // y_ge(0.3); // preview does not work
     }
}

/* The two parts to be rendered, laid flat and roughly centered */
if (part == "first") {
     translate([0,photo_height/2,segment_t]) A();
} else if (part == "second") {
     translate([0,(photo_height-triangle_h)/2,segment_t2])
     rotate([-leg_angle,0,0]) translate([0,triangle_h+segment_l2/2,segment_t]) leg();
}

use <utils/build_plate.scad>;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
