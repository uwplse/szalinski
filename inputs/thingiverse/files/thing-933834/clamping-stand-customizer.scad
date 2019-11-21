/**
 * (c) Spiros Papadimitriou, 2015
 *
 * This design is made available under a
 * Creative Commons Attribution Share-Alike license.
 * http://creativecommons.org/licenses/by-sa/3.0/
 * You can share and remix this work, provided that
 * you keep the attribution to the original author intact,
 * and that, f you alter, transform, or build upon
 * this work, you may distribute the resulting work
 * only under the same or similar license to this one.
 */

/* [Main parameters] */

part = "all"; // [all:All,clamp:Clamp,hook:Hook]


// Thickness of both pieces (at least 4, unless fastener parameters are tweaked)
thickness = 5;
// Width of both pieces
width = 21;

// Inner diameter of clamp piece; see also slack (advanced)
clamp_inner_diameter = 33.5;
// Distance between clamp tabs (measured at inner diameter); see also angle adjustment factor (advanced)
clamp_tab_gap = 3;

// Length of hook piece's back (at least clamp outer diameter)
hook_length = 120;
// Depth of hook piece
hook_depth = 22;
// Length of hook piece's front lip
hook_lip_length = 15;

// Offset of screw hole (relative to point that makes hook bottom flush with clamp ring bottom)
hook_screw_offset = 0;

/* [Advanced] */

// Added to inner radius (not diameter!); could have been incorporated into clamp diameter, but separate so user's don't forget some slack
clamp_slack = 0.35;
// Must be between 0 and 1, adjusts orientation of clamp tabs from parallel (1) to collinear to cutout (0); depending on tab gap and flexibility of material used, you may want to adjust this so the tabs are approximately parallel when the clamp is tightened (smaller gaps might require larger factor and vice versa)
clamp_tab_angle_adjustment_factor = 0.5;

// Main diameter of screw (default: M3)
screw_diameter = 3.2;
// Hex nut diameter (corner to corner)
screw_nut_diameter = 6;
// Hex nut thickness
screw_nut_height = 2.4;
// Screw head diameter (also determines clamp tab length)
screw_head_diameter = 5.5;
// Screw head thickness
screw_head_height = 3.1;

// Separate screw head thickness for clamp tab screw (where it's acceptable for head to protrude, so we can allow for thicker/stronger wall)
clamp_tab_screw_head_height = 2;
// Deepens hole for hex nut that attaches clamp to hook; if wall thickness is large enough, can be adjusted so a longer screw does not stick out into clamp when fully tightened
clamp_ring_screw_nut_extra_height = 0.6;


/* [Hidden] */

r = clamp_inner_diameter/2 + clamp_slack; //+ 0.75;
thk = thickness;
w = width;
l = hook_length;
d = hook_depth;
lip = hook_lip_length;

//screw_r = 3.2/2; // M3
//screw_nut_r = 6/2 + 0.1;  // M3
//screw_nut_h = 2.4;  // M3
//screw_nut_hadj = 0.6; // Extra sink adjustment for attachment nut
//screw_cap_r = 5.5/2 + 0.15; // M3
//screw_cap_sink = 2;  // only sink portion, not full
//screw_cap_h = 3.1;
screw_r = screw_diameter/2;
screw_nut_r = screw_nut_diameter/2 + 0.1;
screw_nut_h = screw_nut_height;
screw_nut_hadj = clamp_ring_screw_nut_extra_height; // Extra sink adjustment for attachment nut
screw_cap_r = screw_head_diameter/2 + 0.15;
screw_cap_sink = clamp_tab_screw_head_height;  // only sink portion, not full
screw_cap_h = screw_head_height;


clamp_radial = true;  // FIXME: Remove option, false is same as tab_angle_adj_factor == 1

clamp_gap = clamp_tab_gap;  // 2;                // (parallel)
clamp_angle = 2*atan(0.5*clamp_gap/r); // (radial)
clamp_angle_adj = clamp_tab_angle_adjustment_factor*clamp_angle;
clamp_l = 3*screw_cap_r;


//tilt = 40;  // degrees (outward => inward correction)

//include <util.scad>

/********************* include util.scad - begin ***************************/

module fillet(h, r) {
  difference() {
     cube([h, r, r]);
     translate([-0.1, r, r]) rotate([0, 90, 0]) cylinder(h = h+.2, r = r);
  }
}

module fillet_theta(h, r, theta) {
  rotate([90, 0, 90])
    difference() {
      linear_extrude(h)
        polygon([[0, 0], [r, 0], [r*cos(theta), r*sin(theta)]]);
      translate([r, r*tan(theta/2), -1])
        cylinder(r = r*tan(theta/2), h=h+2);
    }
}

module roundedCube4(dim, r, center=false) {
  width = dim[0];
  height = dim[1];
  depth = dim[2];
  centerx = (center[0] == undef ? center : center[0]);
  centery = (center[1] == undef ? center : center[1]);
  centerz = (center[2] == undef ? center : center[2]);
  translate([centerx ? -width/2 : 0, centery ? -height/2 : 0, centerz ? -depth/2 : 0]) union() {
    translate([0, r, 0]) cube([width, height-2*r, depth]);
    translate([r, 0, 0]) cube([width-2*r, height, depth]);
    for (xy = [[r, r],
               [r, height-r],
               [width-r, r],
               [width-r, height-r]]) {
      translate([xy[0], xy[1], 0]) cylinder(r = r, h = depth);
    }
  }
}

/********************** include util.scad - end ****************************/


module clamp() {
  clamp_theta = clamp_angle/2; // atan(clamp_gap/(2*r));
  clamp_dx = r*cos(clamp_theta);
  //clamp_fillet_dx = (clamp_dx+thk)*cos(atan(thk/(clamp_dx+thk)))-1.2;  // FIXME: -1.2 empirical
  difference() {
    union() {
      // Clamp ring
      cylinder(r = r+thk, h = w, $fn=72);
      
      // Clamp (radial)
      if (clamp_radial) {
        rotate([0, 0, -clamp_angle/2])
          translate([-r, 0, 0]) 
            rotate([0, 0, clamp_angle_adj/2])
              translate([-clamp_l-thk, 0, 0]) 
                cube([clamp_l+thk, thk, w]);
        rotate([0, 0, clamp_angle/2])
          translate([-r, 0, 0])
            rotate([0, 0, -clamp_angle_adj/2])
              translate([-clamp_l-thk, -thk, 0])
                cube([clamp_l+thk, thk, w]);
      }
        
      // Clamp (translation / parallel)
      if (!clamp_radial) {
        translate([-clamp_l-thk-clamp_dx, clamp_gap/2, 0])
          cube([clamp_l+thk, thk, w]);
        translate([-clamp_l-thk-clamp_dx, -thk-clamp_gap/2, 0])
          cube([clamp_l+thk, thk, w]);
        // TODO: Next two fillets cause non-manifold mesh
        //*translate([-clamp_fillet_dx, -clamp_gap/2-thk+0.05, 0])
        //  rotate([0, -90, 90])
        //    fillet_theta(r=thk/2, h=w, theta=90+clamp_angle/2, $fn=24);
        //*translate([-clamp_fillet_dx, clamp_gap/2+thk-0.05, 0])
        //  rotate([0, -90, -clamp_theta])
        //    fillet_theta(r=thk/2, h=w, theta=90+clamp_angle/2, $fn=24);
      }
      
      // Attachment shoulder
      roundedCube4([r+thk, 1.25*r, w], r=thk/2, center=[false, true, false], $fn=32);
    }
    
    // Ring negative
    translate([0, 0, -1]) 
      cylinder(r = r, h = w+2, $fn=36*4);

    // Clamp negative (radial)
    if (clamp_radial) {
      rr = thk + clamp_l + 1;
      translate([0, 0, -1]) linear_extrude(w+2)
        polygon([ [0, 0], 
                  [-r*cos(clamp_angle/2), -r*sin(clamp_angle/2)], 
                  [-r*cos(clamp_angle/2)-rr*cos((clamp_angle-clamp_angle_adj)/2), 
                   -r*sin(clamp_angle/2)-rr*sin((clamp_angle-clamp_angle_adj)/2)], 
                  [-r*cos(clamp_angle/2)-rr*cos((clamp_angle-clamp_angle_adj)/2), 
                    r*sin(clamp_angle/2)+rr*sin((clamp_angle-clamp_angle_adj)/2)],
                  [-r*cos(clamp_angle/2), r*sin(clamp_angle/2)] ]);
      
      // Screw/nut holes
      rotate([0, 0, -clamp_angle/2]) {
        translate([-r-thk-clamp_l/2+(r-clamp_dx)/2, -1, w/2])
          rotate([-90, 0, 0])
            cylinder(r=screw_r, h=thk+2, center=false, $fn=18);
        translate([-r-thk-clamp_l/2+(r-clamp_dx)/2, thk+1, w/2])
          rotate([90, 0, 0])
            cylinder(r=screw_cap_r, h=screw_cap_sink+1, $fn=18);
      }
      rotate([0, 0, clamp_angle/2]) {
        translate([-r-thk-clamp_l/2+(r-clamp_dx)/2, 1, w/2])
          rotate([90, 0, 0])
            cylinder(r=screw_r, h=thk+2, center=false, $fn=18);
        translate([-r-thk-clamp_l/2+(r-clamp_dx)/2, -thk-1, w/2])
          rotate([-90, 30, 0])
            cylinder(r=screw_nut_r, h=screw_nut_h+1, $fn=6);
      }
      
      //echo(clamp_angle/4);
      //echo(atan(thk/(3*r))/2);
      theta_slack = atan(thk/(3*r))/2; // Account for one side of the fillet being against curved (not straight) surface (the inner circle of the clamp)
      rotate([0, 0, -clamp_angle/2+0.05])
        translate([-r+0.05, 0, -1])
          rotate([0, -90, -clamp_angle/2+2*clamp_angle_adj/2-theta_slack])
            fillet_theta(r=thk/3, h=w+2, theta=90+clamp_angle/2-clamp_angle_adj/2+theta_slack, $fn=36);
      rotate([0, 0, clamp_angle/2-0.05])
        translate([-r+0.05, 0, -1])
          rotate([0, -90, 90-clamp_angle_adj/2+0])
            fillet_theta(r=thk/3, h=w+2, theta=90+clamp_angle/2-clamp_angle_adj/2+theta_slack, $fn=36);
    }
    
    // Clamp negative (translation / parallel)
    if (!clamp_radial) {
      translate([-r-thk-clamp_l-1, -clamp_gap/2, -1])
        cube([r+thk+clamp_l+1, clamp_gap, w+2]);
      translate([-r-thk-clamp_l/2+(r-clamp_dx)/2, 0, w/2])
        rotate([90, 0, 0])
          cylinder(r=screw_r, h=2*thk+clamp_gap+2, center=true, $fn=18);
      translate([-r-thk-clamp_l/2, 0, w/2])
        rotate([90, 0, 0])
          cylinder(r=screw_r, h=2*thk+clamp_gap+2, center=true, $fn=18);
      translate([-r-thk-clamp_l/2+(r-clamp_dx)/2, -clamp_gap/2-thk-1, w/2])
        rotate([-90, 0, 0])
          cylinder(r=screw_nut_r, h=screw_nut_h+1, $fn=6);
      translate([-r-thk-clamp_l/2+(r-clamp_dx)/2, clamp_gap/2+thk+1, w/2])
        rotate([90, 0, 0])
          cylinder(r=screw_cap_r, h=screw_cap_sink+1, $fn=18);
      translate([-clamp_dx+0.05, clamp_gap/2-0.05, -1])
        rotate([0, -90, -clamp_theta-1])
          fillet_theta(r=thk/3, h=w+2, theta=90+clamp_theta+1, $fn=24);
      translate([-clamp_dx+0.05, -clamp_gap/2+0.05, -1])
        rotate([0, -90, 90])
          fillet_theta(r=thk/3, h=w+2, theta=90+clamp_theta+1, $fn=20);
    }
        
    // Attachment screw/nut
    translate([0, 0, w/2])
      rotate([0, 90, 0]) {
        cylinder(r=screw_r, h=r+thk+1, $fn=18);
        cylinder(r=screw_nut_r, h=r+screw_nut_h+screw_nut_hadj, $fn=6);
      }
  }
}


module hook() {
  cr = min(thk, d/2);
  difference() {
    union() {
      // Hook
      translate([0, -r-thk, 0])
        roundedCube4([d+2*thk, 2*(thk+cr), w], r=cr+thk, $fn=36);
      translate([thk+d, -r+thk, 0])
        cube([thk, lip-thk, w]);

      // Backing
      translate([0, -r+thk, 0]) {
        // Half-rounded cube (only top)
        roundedCube4([thk, l-r+r-thk, w], r=thk/2, $fn=24);
        cube([thk, thk, w]);
      }
    }
    
    // Hook negative
    translate([thk, -r, -1])
      roundedCube4([d, l, w+2], r=cr, $fn=36);
    translate([thk+d-1, -r+lip, -1])
      cube([thk+2, r-lip+2*thk+1, w+2]);
    translate([2*thk+d+0.05, -r+lip+0.05, -1])
      rotate([0, -90, 90]) 
        fillet(r=thk/2, h=w+2, $fn=24);
    translate([thk+d-0.05, -r+lip+0.05, -1])
      rotate([0, -90, 180]) 
        fillet(r=thk/2, h=w+2, $fn=24);
    
    // Attachment screw
    translate([-1, hook_screw_offset, w/2])
      rotate([0, 90, 0]) {
        cylinder(r=screw_r, h=thk+2, $fn=18);
        translate([0, 0, thk+2-screw_cap_h-1])
          cylinder(r=screw_cap_r, h=screw_cap_h+1, $fn=18);
      }
  }
}

if (part == "all" || part == "clamp")
  clamp();
if (part == "all" || part == "hook")
  translate([r+2*thk, 0, 0]) hook();