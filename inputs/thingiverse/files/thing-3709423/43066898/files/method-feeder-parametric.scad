
// EDIT THESE FREELY :-)
/* [Main Dimensions] */
// Overall feeder length (mm)
l = 75; // [10:1000]
// Feeder width. We recommend half of length. (mm)
w = l / 2;

// STOP EDITING BELOW HERE
// Or you will probably be tweaking a while...
/* [Hidden] */

// Gap and bridges together make up the chum holder side
// Gap is the space between the bridges. We assume 4 gaps
gap_l = l / 5;
gap_w = w;
bridge_l = l / 5 / 5;

module oval_shape() {
  // Large radius ensures we have plenty of edges in the transform 
  resize(newsize=[w,l,w]) 
  sphere(r=50);
}

module gap() { cube([gap_w, gap_l, gap_w]); }

module chum_side() {
  // Cut off the lower half
  difference() {
    // Union the oval shape, gaps, and center spine
    translate([-w/2, 0, 0]) 
    union() {
      difference() {
        translate([w/2, 0, 0]) oval_shape();
        translate([0, bridge_l / 2, 1]) gap();
        translate([0, gap_l + 1.5*bridge_l, 1]) gap();
        translate([0, -gap_l - bridge_l/2, 1]) gap();
        translate([0, -2*gap_l - 1.5*bridge_l, 1]) gap();
      }
      
      translate([w/2, 0, 0]) 
        resize(newsize=[w/6, l-1 ,0.65* w]) 
          sphere(r=5);
    }
    
    translate([0,0,-w/2 - 3]) 
      cube([w, l, w], center=true);
  }
}

module line_holders() {
  difference() {
    tip_l = l*1.15;
    hole_r = min(2.5, w/6/4);
    translate([0,0,-1.5]) cube([w/6, tip_l, 3], center=true);
    translate([0, -tip_l/2*.925, -5]) cylinder(r=hole_r,h=30, $fn=30);
    translate([0, tip_l/2*.925, -5]) cylinder(r=hole_r,h=30, $fn=30);
  }
}

module do_it() {
  union() {
    chum_side();
    line_holders();
  }
}

do_it();