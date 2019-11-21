//****************************************************
//****************************************************
//Thumbwheel Combination Lock
//by Marc Sulfridge
//****************************************************
//****************************************************

use <write/Write.scad>

//****************************************************
//Start of user defined parameters.
//****************************************************
/* [Global] */
// Module to build. "Base" = the piece that contains all the wheels. "Clasp" = the piece that grabs the wheel cams.  "Rosette" = the bumped portion of the wheel.  "Numbers" = the numbered polygon portion of the wheel.  "Full" = a pretty display of all the pieces put together.  "Full" is not for printing.
part = "Full"; // [Full, Base, Clasp, Rosette, Numbers]
// Number of possible values for each digit of the combination.
n = 10; // [3,4,5,6,7,8,9,10]
// Clearance between parts to ensure slip fit.
clear = 0.4; // 
//****************************************************

/* [Base] */
// Number of digits in the combination
N=3; // [1,2,3,4,5,6,7,8,9,10]

// Thickness of the walls and tabs in the base.
base_t = 2; // 

// Thickness of the flag springs that lock the wheels in position. Should be as thin as possible without breaking
flag_t = 0.6; // 
// Width of the flag springs that lock the wheels in position.
flag_w_exact = 2; // 
// Length of the screw hole tabs on the base.
tab_l = 6; // 
//****************************************************

/* [Wheels] */
// Radius of the thumbwheels.
wheel_r = 20/2; // 
// Height that the thumbwheel bumps stick out beyond the wheel radius.
bump_h = 1; // 
// Thickness of the bumped wheel.
wheel_t = 2; // 
// Thickness of the numbered polygon on the thumbwheel.
wheel_nums_out_t = 6; // 
// Radius of the axle that the wheels turn on.
exact_axle_r = 3/2; // 
// Radius of the cylinder that the locking cam is made from. Must be smaller than wheel_r and larger than axle_r.
cam_r = 6; // 
// Thickness of the loocking cam. Must be thicker than the clasp thickness.
cam_t = 3.5; // 
// Thickness that the bummped thumbwheel extends beyond the locking polygon that mates it to the number wheel.
wheel_lock_t = 1.5;
// Amount that the numbers extend out of the faces of the polygon.
wheel_nums_t = 2; // 
// Which number to use for the combination.  Make one for each digit of the combination.  Must be between 0 and the number of possible values for each digit minus one.
combo_num = 0; // [0,1,2,3,4,5,6,7,8,9]
//****************************************************

/* [Clasp] */
// Thickness of the clasp arms that grab the thumbwheel cams. Make as thick as possible for strength.
clasp_t = 2.5; // 
// Large radius of the counter-sunk screw holes
clasp_hole_r1 = 2; // 
// Small radius of the counter-sunk screw holes
clasp_hole_r2 = 1; // 
//****************************************************

/* [Hidden] */
// Pi = circumference/diameter for any circle.
pi = 3.1415926535;
// Fudge factor to ensure overalps.
wig=0.01;
// Large clearance between parts.
gap = 1; //

//****************************************************
// Calculated parameters
//****************************************************
alpha = 360/n;
axle_r = exact_axle_r+clear;
wheel_lock_r = wheel_r - wheel_lock_t;
clasp_r = cam_r+3;
clasp_w = 2*clasp_r;
flag_w = flag_w_exact-clear;
a = wheel_r*cos(alpha/2);
bump_r1 = wheel_r-a+bump_h;
bump_r2 = wheel_r*sin(alpha/2);
flat_gap = (cam_r-axle_r)/3;
base1_h = base_t+wheel_nums_out_t+wheel_t+cam_t+clear;
base_off = wheel_r+bump_h+base_t/2+gap;
base_w = 2*clasp_r+gap;
base_h = 2*(wheel_r+bump_h+base_t);
clasp_off = wheel_r+bump_h+base_t/2+gap;
clasp_h = 2*(wheel_r+bump_h+clasp_t);
tab_w = max((base_h - clasp_w)/2 - gap,tab_l);
tab_clear_w = 2*max(clasp_r+gap,wheel_r+bump_h+clear);

//****************************************************

// preview[view:south east, tilt:top diagonal]

//****************************************************
// Modules
//****************************************************

// Thumbwheel Rosette
module thumb_wheel() {
  difference() {
    union() {
      cylinder(r=wheel_r, h= wheel_t,center=false);

      for (i=[0:(n-1)]) {
        rotate([0,0,alpha*i+90-alpha/2]) translate([a,0,0]) scale([bump_r1/bump_r2,1,1])
          cylinder(r=bump_r2, h=wheel_t, center=false,$fn=20);
      }
    }
  translate([0,0,-wig]) 
    cylinder(r=axle_r,h=wheel_t+cam_t+2*wig,center=false,$fn=20);
  rotate([0,0,alpha/2]) translate([0,0,-wig]) 
    cylinder(r=wheel_lock_r+clear, h=wheel_t+2*wig, center=false, $fn=n);
  }
}

// Numbered Polygon
module wheel_nums_out(num=0) {
  difference() {
    union() {
      rotate([0,0,alpha/2]) 
        cylinder(r=wheel_r,h=wheel_nums_out_t,center=false,$fn=n);
      for (i=[0:(n-1)]) {
        rotate([0,0,(i-num)*alpha])
        translate ([a-wheel_nums_t/2,0,(wheel_nums_out_t+gap/2)/2]) rotate([180,-90,0]) 
          write(str(i),t=2*wheel_nums_t,h=2*pi*wheel_r/n-1.5*gap,center=true);
      }
      intersection() {
        cylinder(r=cam_r, h= wheel_t+cam_t+wheel_nums_out_t, center=false,$fn=20);
        translate([0,flat_gap/2,(wheel_t+cam_t+wheel_nums_out_t)/2]) 
          cube([2*cam_r,2*cam_r-3*flat_gap,wheel_t+cam_t+wheel_nums_out_t],center=true);
      }
      rotate([0,0,alpha/2]) cylinder(r=wheel_lock_r,h=wheel_nums_out_t+wheel_t,center=false,$fn=n);
    }
    translate([0,0,-wig])
      cylinder(r=axle_r,h=wheel_t+cam_t+wheel_nums_out_t+2*wig,center=false,$fn=20);
  }
}

// Single wheel section of the base.
module base1() {
  union() {
    difference() {
      translate([-base_off-base_t/2,-base_h/2-gap,0])
        cube([base_w/2+base_off+base_t/2,base_h,base_t],center=false);
      translate([0,0,-wig])
        cylinder(r=axle_r,h=base_t+2*wig,center=false,$fn=20);
    }
    translate([-base_off+base_t/2,-base_off-base_t/2,0])
      cube([base_w/2+base_off-base_t/2,base_t,base1_h+wig],center=false);
    hull() {
      translate([-flag_t/2,wheel_r+clear,0])
        cube([flag_t,flag_w,base1_h],center=false);
      translate([-flag_t/2,wheel_r+flag_w,0])
        cube([2*flag_t,clear,base1_h],center=false);
    }
    translate([base_w/2-base_t,wheel_r,0])
      cube([base_t,base_t,base1_h+base_t],center=false);
    translate([base_w/2-gap,-wheel_r-bump_h-gap-base_t,base_t+clear+wheel_nums_out_t+wheel_t])
      cube([gap,2*(wheel_r+base_t)+bump_h+gap,cam_t+base_t],center=false);
  }
}

// Tabs on the base.
module tab(num=N, w=tab_w) {
  difference() {
    cube([base_t+wig,w,2*tab_l+num*base1_h+base_t],center=false);
    translate([base_t/2+wig,w/2,tab_l/2]) rotate([0,90,0])
      cylinder(r1=clasp_hole_r1, r2=clasp_hole_r2, h=base_t+3*wig, center=true, $fn=20);
    translate([base_t/2+wig,w/2,3*tab_l/2+base_t+num*base1_h]) rotate([0,90,0])
      cylinder(r1=clasp_hole_r1, r2=clasp_hole_r2, h=base_t+3*wig, center=true, $fn=20);
  }
}

// Full base.
module base(num=N) {
  difference() {
    union() {
      translate([-base_off-base_t/2,-base_h/2-gap,-tab_l])
        tab(num);
      translate([-base_off-base_t/2,base_h/2+gap-tab_w,-tab_l])
        tab(num,tab_w-base_t/2);
      for (i=[0:(num-1)]) {
        translate([0,0,i*base1_h]) base1();
      }
      translate([0,0,num*base1_h])
        difference() {
          translate([-base_off-base_t/2,-base_h/2-gap,0])
            cube([base_w/2+base_off+base_t/2,base_h,base_t],center=false);
          translate([0,0,-wig])
            cylinder(r=axle_r,h=base_t+2*wig,center=false,$fn=20);
        }
    }
      translate([-base_off-base_t/2-wig,-tab_clear_w/2,base_t-wig])
        cube([base_t+3*wig,tab_clear_w,num*base1_h-base_t], center=false);
  }
}

// Single wheel section of the clasp.
module clasp1() {
  union() {
    difference() {
      hull() {
        cylinder(r=clasp_r,h=clasp_t,center=false,$fn=20);
        translate([0,-clasp_off,clasp_t/2])
          cube([clasp_w,base_t,clasp_t],center=true);
      }
      translate([0,0,-wig])
        cylinder(r=cam_r+clear,h=clasp_t+2*wig,center=false,$fn=20);
      translate([-flat_gap/2,clasp_r,(wheel_t+cam_t)/2-wig]) 
        cube([2*cam_r-3*flat_gap+clear,2*clasp_r,wheel_t+cam_t+2*wig],center=true);
    }
    difference() {
      translate([0,-clasp_off,base1_h/2])
        cube([clasp_w,base_t,base1_h+wig],center=true);
      translate([0,-clasp_off,base1_h/2+clasp_t/2]) rotate([90,0,0]) 
        cylinder(r1=clasp_hole_r1, r2=clasp_hole_r2, h=base_t+2*wig, center=true, $fn=20);
    }
  }
}

// Full clasp.
module clasp(num=N) {
  union() {
    for (i=[0:(num-2)]) {
      translate([0,0,i*base1_h]) clasp1();
    }
    translate([0,0,(num-1)*base1_h])
      difference() {
        hull() {
          cylinder(r=clasp_r,h=clasp_t,center=false,$fn=20);
          translate([0,-clasp_off,clasp_t/2])
            cube([clasp_w,base_t,clasp_t],center=true);
        }
        translate([0,0,-wig])
          cylinder(r=cam_r+clear,h=clasp_t+2*wig,center=false,$fn=20);
        translate([-flat_gap/2,clasp_r,(wheel_t+cam_t)/2-wig]) 
          cube([2*cam_r-3*flat_gap+clear,2*clasp_r,wheel_t+cam_t+2*wig],center=true);
      }
  }
}

// Full combination lock.
module full_lock(num=N) {
  translate([0,0,-base_t-clear/2]) color("green") base(num);
  translate([0,0,wheel_nums_out_t+wheel_t+clear]) rotate([0,0,-90]) color("red") clasp(num);
  for (i=[0:(num-1)]) {
    translate([0,0,i*base1_h]) {
      color("gold") wheel_nums_out(i);
      translate([0,0,wheel_nums_out_t]) color("blue") thumb_wheel();
    }
  }
}

module show_part() {
  if (part=="Full") {
    rotate([-90,0,0]) full_lock();
  }
  else if (part=="Rosette") {
    thumb_wheel();
  }
  else if (part=="Numbers") {
    wheel_nums_out(combo_num);
  }
  else if (part=="Base") {
    rotate([90,-90,0]) base();
  }
  else if (part=="Clasp") {
    rotate([90,0,0]) clasp();
  }
  else {
    rotate([-90,0,0]) full_lock();
  }
}

show_part();
