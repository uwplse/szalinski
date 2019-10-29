// (in mm, 50 to 80)
battery_width = 66;
// (in mm, 10 to 40)
battery_thickness = 25.5;
holder_base_set = 1; // [0:1]
number_of_holder_tops = 2; // [0:10]
// (in mm)
part_spacing = 4; // [1:30]

// B Holder
/* [hidden] */

$fn = 50;  // 100 => 10 second render

// Battery specific variables
//b_w = 66; // Width (y) 
//b_th = 25.5; // thickness (z)
b_w = min(max(50,battery_width),80); // Width (y) 
b_th = min(max(10,battery_thickness),40); // thickness (z)



// Main Values
b_l = 100; // overall length (x)

hold_th = 3; // wall thickness
hold_w = 12; // overall holder width
hold_tab = 3.5; // tab grip length (45 degree tab)

bh_sh = 2.0; // battery holder screw head thickness

// Cavity Height (total space inside)
//cav_h = 71-4.5; // no idea

// left ribs
r1_h = 28; // height of rib
r1_th = 2; // thickness of rib
r1_d = 4; // diameter of rib pole
r1_y2 = 40; // distance from edge to pole location
r1_y1 = r1_y2 + 43; // distance from edge to pole location

// right ribs
r2_h = r1_h; // height of ribs (ground down)
r2_th = 2.7; // thickness of rib
r2_y = 30; // distance from edge of holder to orthog wall
r2_y2 = r2_y-11; // distance from edge of holder to interfering rib
r2_x1 = 17; // distance to edge of wall


// base
b_h = r1_h + 5; // height of base
mh_d1 = 5.5; // head opening
mh_d2 = 2.5; // thread hole diameter
//mh_dpth = -0.25*25.4+(cav_h-b_h)-hold_tab/sqrt(2)-b_th; // depth of threads
mh_y1 = 33; // mounting hole location
mh_y2 = 50; // mounting hole location

print = !!true; // 0 == print position


if (number_of_holder_tops>=1) {
  for (i=[1:number_of_holder_tops]) {
    top((hold_w+part_spacing)*(i-1));
  }
}

// Base 1 of two part holder
if (holder_base_set==1) {

translate(print ? [-part_spacing,0,b_h]:[0,0,0])
rotate(print ? [0,180,0]:[0,0,0])
difference() {
  // main outer shape
  translate([0,(mh_y1+mh_y2)/2-30,0]) cube([hold_w, 50, b_h]);
 // cube([hold_w, b_w+2*hold_th, b_h]);
  // rib
    translate([hold_w/2,b_w/2+hold_th,r1_h/2]) cube([r1_th,b_w+2*hold_th+2,r1_h+.01], center=true);
    // rib posts
    translate([hold_w/2,r1_y1,r1_h/2]) cylinder(d=r1_d, h = r1_h+.01, center = true);
    translate([hold_w/2,r1_y2,r1_h/2]) cylinder(d=r1_d, h = r1_h+.01, center = true);
  // mounting holes
  translate([hold_w/2,mh_y1,b_h/2]) cylinder(d=mh_d2, h=b_h+.01, center=true);
  translate([hold_w/2,mh_y2,b_h/2]) cylinder(d=mh_d2, h=b_h+.01, center=true);
}


// Base 2 of two part holder  
// (don't change based on battery width)
b_w2=56;  // used to isolate this part's size
translate(print ? [-1.5*hold_w-2*part_spacing,0,b_h]:[0,10,0])
rotate(print ? [0,180,0]:[0,0,0])
difference() {
  // main outer shape
  union() {
    translate([-hold_th-r2_th,0,0]) cube([hold_w+hold_th+r2_th, b_w2+2*hold_th, b_h]);
    *translate([-r2_x1-r2_th,r2_y-hold_w/2,0]) cube([r2_x1+r2_th, hold_w, b_h]);
    *translate([-r2_x1-r2_th,b_w2+-hold_w,0]) cube([r2_x1+r2_th, hold_w, b_h]);
  }
  
  translate([-20,-.01,-.01]) cube([50,r2_y2,50]);
    
  // ribs
    translate([-r2_th/2,r2_y,r2_h/2]) cube([r2_th,200,r2_h+.01], center=true);
    translate([-(r2_x1 + r2_th)/2-1,r2_y,r2_h/2]) cube([r2_x1 + r2_th + 2,r2_th,r2_h+.01], center=true);
    // rib posts
    translate([-r2_th/2,r2_y,r1_h/2]) cylinder(d=1.3*r1_d, h = r1_h+.01, center = true);
  // mounting holes
  translate([hold_w/2,mh_y1-10,b_h/2]) cylinder(d=mh_d2, h=b_h+.01, center=true);
  translate([hold_w/2,mh_y2-10,b_h/2]) cylinder(d=mh_d2, h=b_h+.01, center=true);
}
}


module top (x_off) {

// Top portion of two part holder
translate(print ? [x_off,0,0]:[0,0,b_h+1])
difference() {
  // main outer shape
  union() {
    cube([hold_w, b_w+2*hold_th, b_th+hold_th+bh_sh+hold_tab/sqrt(2)]);
    // wings on the top prtion of the battery holder
    intersection() {
      translate([hold_w/2,0,b_th+hold_th+bh_sh+hold_tab/sqrt(2)]) rotate([45,0,0]) cube([hold_w, hold_tab,hold_tab], center=true);
      translate([hold_w/2,-hold_tab/3,b_th+hold_th+bh_sh+hold_tab/sqrt(2)-hold_tab/2]) cube([hold_w, hold_tab,hold_tab], center=true);
    }

    intersection() {
      translate([hold_w/2,b_w+2*hold_th,b_th+hold_th+bh_sh+hold_tab/sqrt(2)]) rotate([45,0,0]) cube([hold_w, hold_tab,hold_tab], center=true);
      translate([hold_w/2,b_w+2*hold_th+hold_tab/3,b_th+hold_th+bh_sh+hold_tab/sqrt(2)-hold_tab/2]) cube([hold_w, hold_tab,hold_tab], center=true);
    }
  }
  // battery
  difference() {
    translate([-b_l/2,hold_th,hold_th+bh_sh])cube([b_l+1, b_w, b_th+hold_tab+.01]);
    translate([0,hold_th,b_th+hold_th+bh_sh+hold_tab/sqrt(2)]) rotate([45,0,0]) cube([b_l+2, hold_tab,hold_tab], center=true);
    translate([0,hold_th+b_w,b_th+hold_th+bh_sh+hold_tab/sqrt(2)]) rotate([45,0,0]) cube([b_l+2, hold_tab,hold_tab], center=true);
  }
  // mounting screw head holes
  translate([hold_w/2,mh_y1,hold_th+5]) cylinder(d=mh_d1, h=10, center=true);
  translate([hold_w/2,mh_y2,hold_th+5]) cylinder(d=mh_d1, h=10, center=true);

  // mounting holes for threading into
  translate([hold_w/2,mh_y1,5]) cylinder(d=mh_d2+0.5, h=10.1, center=true);
  translate([hold_w/2,mh_y2,5]) cylinder(d=mh_d2+0.5, h=10.1, center=true);
}
}