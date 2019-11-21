/**
 * (c) Spiros Papadimitriou, 2013
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

part = "case"; // [case:Case,clip:Clips,spacer:Bottom spacer,cdbracket:CD slot bracket]

/* [Holder] */

cable = "rnd"; // [rnd:RND (6ft),apple:Apple]

// Whether front right piece should extend to the same height as the left side (cable channel box); if it does, then ambient light sensor wll be covered, so it's recommended to set this to "Yes"
low_front = 1; // [0:No,1:Yes]

// How much extra thickness the case adds on back of phone
case_back_thickness = 1.3;
// How much extra thickness the case adds on front of phone [EXPERIMENTAL]
case_front_thickness = 0;
// How much extra thickness the case adds on top and bottom sides of phone; this should be thickness of one side (not total)
case_top_and_bottom_thickness = 0.3;
// How much extra thickness the case adds on left and right sides of phone; this should be thickness of one side (not total)
case_left_and_right_thickness = 1.3;

/* [Clips] */

// Distance between back of clip (on holder) and first tooth; should be long enough so holder clear any knobs and protrusions on vents
clip_first_tooth_distance = 5.5;
// Distance between front and back tooth; should be at least as the thickness of the vent slats over which it clips
clip_teeth_distance = 15;
// Length of teeth on top arm; should be smaller than the vertical distance between vent slats, but large enough to safely wrap around the slat
clip_top_tooth_len = 3.5;
// Space between top teeth and bottom clip arm
clip_tooth_and_arm_gap = 0.75;

// Bottom spacer length; should be adjusted so it keeps holder at a comfortable viewing position
spacer_length = 12;
// Bottom spacer angle; if necessary, should be adjusted so it keeps holder at a comfortable viewing position
spacer_back_angle = 20; // [0:45]
// Height of spacer back; should be adjusted so spacer doesn't fall through between vent slats
spacer_back_height = 8;

/* [CD Slot Bracket] */
// Total width of CD slot
cd_slot_width = 130.75;
// Thickness of cd slot
cd_slot_thickness = 4.2;
// Insertion depth (maximum)
cd_insertion_depth = 23;
// Left notch width
cd_notch_width_left = 33.5;
// Right notch width
cd_notch_width_right = 44.5;
// Notch depth (insertion depth near both edges will be reduced by this much)
cd_notch_depth = 13;
// Notch height (slot thickness near left edge will be reduced by this much)
cd_notch_height_left = 1.5;
// Notch height (slot thickness near right edge will be reduced by this much)
cd_notch_height_right = 1.5;
// CD arm tilt backward (positive) or forward (negative)
cd_arm_angle = -10; // [-15:10]


/* [Hidden] */

test = false;

// iPhone sleeve measurements
sleeve_thk_d = case_back_thickness + case_front_thickness + 0.3;  // 0.3 extra slack
sleeve_thk_w = case_top_and_bottom_thickness + 0.1;  // 0.1 slack
sleeve_thk_h = case_left_and_right_thickness;

// iPhone measurements:
i_d = 7.8 + sleeve_thk_d + 0.3;  // 0.3 slack
i_w = 59.57 + sleeve_thk_w*2;
i_h = 123.83 + sleeve_thk_h*2;
i_scr_w = 53;
i_scr_h = 90.39;
i_scr_ofs = 16.72 + sleeve_thk_h;
i_home_r = 10.9 / 2;
i_home_ofs = 9.15 + sleeve_thk_h;
i_corner_r = 6.9;



// Ports
i_jack_r = 4.83 / 2;
i_l_w = 9.05;
i_l_offset = 24.75 + 8.2/2 + sleeve_thk_w;
// TODO

// Lightning cable measurements
l_w = 8.2;
l_d = 5;
l_h = 12;
l_cbl_r = 2.5 / 2;
l_strain_r = 4.1 / 2;


// Holder parameters
h_mul = 2/3;
thick = 2.5;
clip_thk = 2.5;
clip_w = 7.5;
clip_num_teeth = 2;
clip_tooth_len = clip_top_tooth_len;   // Top-arm tooth length
clip_tooth2_len = 0;  // Bottom-arm tooth length
clip_tooth_gap = clip_tooth_and_arm_gap;   // Vertical gap between tooth pair ends
clip_tooth_spc = clip_teeth_distance;   // Space between successive teeth
clip_tooth_ofs = clip_first_tooth_distance;  // Space between back and first tooth
clip_dist = 2*i_h/3;

// Note: original values: tooth_ofs = 14.5, tooth_spc = 6, num_teeth = 3

$fn=36;


module fillet_angle(h, r, angle, r1 = -1) {
  r1 = (r1 > 0) ? r1 : r*sin(angle/2)/cos(angle/2);
  sin1 = r*sin(angle/2)/r1;
  cos1 = sqrt(1-sin1*sin1);
  d = r*cos(angle/2) + r1*cos1;
  rotate([90, -angle/2, 0]) translate([0, 0, -h/2]) difference() {
    linear_extrude(height = h) polygon([[0,0], [r*cos(angle/2), r*sin(angle/2)], [r*cos(angle/2), -r*sin(angle/2)]]);
    translate([d, 0, -1]) cylinder(r=r1, h=h+2, $fn=27);
  }
}

module torus_quarter(radius, turn_radius=0, side=0) {
  diameter = radius*2;
  total_r = turn_radius+diameter+side;
  difference() {
    rotate_extrude(convexity=2) translate([diameter/2+turn_radius,0,0]) hull() {
      circle(diameter/2);
      translate([0,-side,0]) circle(diameter/2);
    }
    translate(-total_r*[1,1,1]) cube(total_r*[2,1,2]);
    translate(-[total_r,0.1,total_r]) cube(total_r*[1,1,2]);
  }
}

module cylinder_stretch(h, r, side=0) {
  linear_extrude(height=h, convexity=2) hull() {
   circle(r);
   translate([0,side,0]) circle(r);
  }
}

module fillet_neg(h, r) {
  difference() {
     cube([h,r,r]);
     translate([-0.05,r,r]) rotate([0,90,0]) cylinder(h=h+0.1,r=r);
  }
}

module fillet(h, r) {
  intersection() {
     cube([h,r,r]);
     translate([-0.05,r,r]) rotate([0,90,0]) cylinder(h=h+0.1,r=r);
  }
}


module clip_tooth(tooth_len, outer_buttress=true) {
  translate([clip_thk, 0, 0]) rotate([0,-90,0]) union() {
    hull() {  // STL has holes w/o hull
      cube([tooth_len-clip_thk/2, clip_w, clip_thk]);
      translate([tooth_len-clip_thk/2, 0, clip_thk/2])
      rotate([-90, 0, 0])
        cylinder(h=clip_w, r=clip_thk/2, $fn=36);
    }
    if (outer_buttress) {
      translate([0,clip_w,0]) rotate([-90,0,-90]) fillet_neg(r=clip_thk/2,h=clip_w);
    }
    translate([0,0,clip_thk]) rotate([90,0,90]) fillet_neg(r=clip_thk/2,h=clip_w);
  }
}

module clip_arm(tooth_ofs, tooth_spc, tooth_len, num_teeth=clip_num_teeth, last_tooth_extra=0) {
  depth = clip_tooth_ofs + clip_thk * num_teeth + clip_tooth_spc * (num_teeth-1) + (last_tooth_extra < 0 ? last_tooth_extra : 0);
  union() {
    cube([depth, clip_w, clip_thk]);
    if (tooth_len > 0) {
      for (ofs = [(tooth_ofs):(tooth_spc+clip_thk):depth]) {
        translate([ofs, 0, clip_thk-0.05]) clip_tooth(((ofs == depth-clip_thk) && (last_tooth_extra > 0)) ? tooth_len + last_tooth_extra : tooth_len, (ofs < depth-clip_thk));
      }
    }
  }
}


module plug_hole() {
  plug_hole_side = plug_channel_h/2;
  linear_extrude(height=thick+0.1) hull() {
    plug_profile();
    translate([0,plug_hole_side,0]) plug_profile();
  }
}

case_cutout_h = 4;

case_h = h_mul*i_w;

home_cutout_vofs = 2.5;

module holder() {
  difference() {
    translate(-[0, thick, thick]) 
      cube([i_h,case_h,i_d] + thick*[1,1,2]);
    translate([-0.05,0,0]) cube([i_h+0.1,i_w,i_d]);
    translate([thick+0.05,i_corner_r+case_cutout_h,0]) cube([i_h,i_w,i_d]);
    translate([i_scr_ofs,(i_w-i_scr_w)/2,0]) 
      cube([i_scr_h, i_scr_w,i_d+thick+0.05]);
    translate([i_h-0.05,i_corner_r+case_cutout_h+0.05,i_d]) rotate([0,90,-90]) fillet_neg(i_d, thick+0.1);
    // Home button cutout
    translate([i_home_ofs,i_w/2-home_cutout_vofs,i_d-0.05]) union() {
      cylinder(h=thick+0.1, r=i_home_r);
      translate([0,-i_home_r,0]) cube([3*i_home_r, i_home_r+0.05,thick+0.1]);
      translate([-i_home_r,0,0]) cube([4*i_home_r, 4*i_home_r,thick+0.1]);
      //translate([i_home_r+0.05,-i_home_r+0.05,thick+0.1]) rotate([0,90,180]) fillet_neg(h=thick+0.2,r=i_home_r/2+0.1);
      if (low_front == 1) {
        translate([i_scr_h,-i_home_r,0]) cube([i_h-i_scr_h, i_w,thick+0.1]);
      }
    }
    translate([-0.05,plug_channel_w/2+i_l_offset,-thick-0.05]) rotate([0,0,-90]) plug_hole();
  }
  // Inner corner bevels
  translate([-0.05,-.05,i_d-0.05]) rotate([0,90,0]) fillet_neg(i_d+0.1,i_corner_r);
  translate([i_h+.05,-.05,i_d-0.05]) rotate([0,90,90]) fillet_neg(i_d+0.1,i_corner_r);
}

cable_turn_radius = 3;
cable_clearance = 0.5;  // Total, for both sides

/* -------- Apple cable -------- */

apple_clearance = 0.4;
apple_w = 7.7 + 1.5*apple_clearance;
apple_h = 4.65 + apple_clearance;
apple_l = 23 + 0.75*apple_clearance;  // Measures 22(?), but that is off by one? -- TODO CHK
apple_relief_l = 9.5 + 0.75*apple_clearance;
apple_relief_r = 3.75/2 + apple_clearance;
apple_cable_r = 2.5/2 + 0.5*apple_clearance;

module apple_plug_profile() {
  translate([apple_h/2,apple_h/2,0]) hull() {
    circle(apple_h/2, $fn=16);
    translate([apple_w-apple_h,0,0]) circle(apple_h/2, $fn=16);
  }
}

module apple_plug_channel() {
  translate([0,0,apple_relief_l]) linear_extrude(height=(apple_l-apple_relief_l)) apple_plug_profile();
  translate([apple_w/2,apple_h/2,0]) cylinder(h=apple_relief_l, r=apple_relief_r);
}

/* -------- RND cable -------- */

rnd_clearance = 0.5;
rnd_fillet_r = 3;
rnd_w = 12.3 + 2*rnd_clearance;
rnd_h = 6.8 + 1.25*rnd_clearance;
rnd_l = 21 + rnd_clearance;  // Includes stress relief
rnd_relief_l = 3.5 + rnd_clearance;
rnd_relief_r = 5.8/2 + 1.5*rnd_clearance;
rnd_cable_r = 3.8/2 + 0.6*rnd_clearance;

module rnd_plug_profile() {
  translate(rnd_fillet_r*[1,1]) minkowski() {
    square([rnd_w,rnd_h] - 2*rnd_fillet_r*[1,1]);
    circle(rnd_fillet_r, $fn=16);
  }
}

module rnd_plug_channel() {
  translate([0,0,rnd_relief_l]) linear_extrude(height=(rnd_l-rnd_relief_l)) rnd_plug_profile();
  translate([rnd_w/2,rnd_h/2,0]) cylinder(h=rnd_relief_l, r=rnd_relief_r);
}

/* ---- Cable selection ---- */

plug_channel_l = (cable == "rnd") ? rnd_l : ((cable == "apple") ? apple_l : 0);
plug_channel_w = (cable == "rnd") ? rnd_w : ((cable == "apple") ? apple_w : 0);
plug_channel_h = (cable == "rnd") ? rnd_h : ((cable == "apple") ? apple_h : 0);
cable_r = (cable == "rnd") ? rnd_cable_r : ((cable == "apple") ? apple_cable_r : 0);

module plug_channel() {
  if (cable == "rnd") {
    rnd_plug_channel();
  } else if (cable == "apple") {
    apple_plug_channel();
  }
}
module plug_profile() {
  if (cable == "rnd") {
    rnd_plug_profile();
  } else if (cable == "apple") {
    apple_plug_profile();
  }
}

module cable_path() {
  side = i_d/2 + sleeve_thk_d/2 + thick - 5*cable_r/8;  // FIXME: 5/8 should vary
  rotate([-90,0,180]) torus_quarter(cable_r, cable_turn_radius,side=side);
  translate([-0.05,0,-cable_turn_radius-cable_r])rotate([0,90,0]) cylinder_stretch(h=100, r=cable_r, side=side);
  translate([-cable_turn_radius-cable_r,0,-0.05]) cylinder_stretch(h=plug_channel_l, r=cable_r, side=side);
}

module plug_and_cable_channel() {
  plug_channel();
  translate([cable_turn_radius+cable_r + plug_channel_w/2,plug_channel_h/2,0.05]) cable_path();
}

cable_box_thk = plug_channel_l + cable_turn_radius + cable_r*2 + 1.25*thick;

support_thk=0.45;
support_w = 4;
support_dist = 4;
support_dist_y = 3;


module cable_box() {
  cp_side = i_d/2 + sleeve_thk_d/2 + thick - 5*cable_r/8;  // Copied from cable_path -- FIXME
  channel_ofs = i_d/2+thick-plug_channel_h/2-sleeve_thk_d/2+case_front_thickness;
  difference() {
    cube([case_h+thick,i_d+2*thick,cable_box_thk-sleeve_thk_h]);
    translate([case_h-plug_channel_w/2-i_l_offset,channel_ofs,cable_box_thk-rnd_l+0.1]) plug_and_cable_channel();
  }

  // Cable cutout supports
  hi_z = cable_box_thk - sleeve_thk_h - support_w;
  step_z = support_w + support_dist;
  lo_z = hi_z - 2*step_z;  // FIXME: hardcoded 2*

  lo_y = channel_ofs+plug_channel_h;
  hi_y = i_d+2*thick-support_thk;
  num_y = max(2, floor((hi_y-lo_y)/support_dist_y));
  step_y = (hi_y-lo_y)/(num_y-1);

  for (sofs_y = [lo_y:step_y:hi_y]) {
    for (sofs_z = [lo_z:step_z:hi_z]) {
      translate([case_h-i_l_offset-cable_r-0.05,sofs_y,sofs_z]) cube([2*cable_r+0.1,support_thk,support_w]);  // FIXME CHK
    }
  }
}


peg_thk = 2.5;
peg_l = 6;
peg_w = 7.5; 
peg_x = 1.2;
peg_slack = 0.35;

module peg_socket(simple=false) {
  for (ofs = [0, peg_w+peg_thk+peg_slack]) {
    translate([0,peg_l+peg_thk+(simple?0:peg_x),ofs]) union() {
      translate([peg_thk,-peg_l-peg_thk-(simple?0:peg_x),0]) cube([peg_thk+peg_slack,peg_l+peg_thk+(simple?0:peg_x),peg_thk]);
      if (!simple) {
        translate([0,-peg_x,0]) cube([2*peg_thk,peg_x,peg_thk]);
        difference() {
          cube(2*peg_thk*[1,1,0.5] + peg_slack*[1,1,0]);
          translate((-sqrt(2)*peg_slack+0.05)*[0,0,0]) rotate([0,0,45]) translate([0,0,-0.05]) cube(2.5*sqrt(2)*peg_thk*[1.5,1.5,0.5]);
        }
      }
    }
  }
  cube([peg_thk,peg_l+peg_thk,peg_w+2*peg_thk+peg_slack]);
  translate([peg_thk,0,0]) cube([peg_thk+peg_slack,peg_thk,peg_w+2*peg_thk]);
}


module peg(base_l=0) {
  translate([0,peg_l,0]) cube([peg_thk,peg_thk,peg_w]);
  translate([peg_thk,0,0]) cube([peg_thk,peg_l+peg_thk+base_l,peg_w]);
}

module case() {
  difference() {
    union() {
      holder();
      translate([-cable_box_thk+sleeve_thk_h,case_h,i_d+thick]) rotate([-90,0,-90]) cable_box();

      translate([(i_h-clip_dist)/2 - (peg_w+2*peg_thk)/2, case_h, -thick-2*peg_thk]) rotate([90,-90,90]) peg_socket();
      translate([(i_h+clip_dist)/2 - (peg_w+2*peg_thk)/2, case_h, -thick-2*peg_thk]) rotate([90,-90,90]) peg_socket();
      //translate([(i_h-clip_dist)/2 - clip_w/2, case_h, -thick]) rotate([180,90,90]) clip();
      //translate([(i_h+clip_dist)/2 - clip_w/2, case_h, -thick]) rotate([180,90,90]) clip();

      translate([i_h/2 - (peg_w+2*peg_thk)/2, peg_l+peg_thk, -thick-2*peg_thk-peg_slack]) rotate([90,-90,90]) difference() {
        translate([0,-2,0]) peg_socket();  // FIXME: hardcoded 2
        translate([-0.05+peg_slack,peg_l+2*peg_thk,-0.05]) cube([2*peg_thk+0.1,2*peg_thk+2*peg_x+peg_slack+0.1,peg_w+2*peg_thk+peg_slack+0.1]);
      }
    }
    translate([-cable_box_thk+sleeve_thk_h-.05,-thick-0.05,thick+i_d+.05]) rotate([0,90,0]) fillet_neg(h=(i_d+2*thick+0.1),r=(1.5*thick+0.1));
    translate([i_h+thick+.05,-thick-0.05,-thick-0.05]) rotate([0,-90,0]) fillet_neg(h=(i_d+2*thick+0.1),r=(1.5*thick+0.1));
  }
}


module clip_assembly() {
  union() {
    clip_arm(clip_tooth_ofs, clip_tooth_spc, clip_tooth_len, clip_num_teeth, last_tooth_extra=0.5*clip_thk+clip_tooth_gap);
    translate([0,clip_w,2*clip_thk+clip_tooth_len+clip_tooth2_len+clip_tooth_gap]) rotate([180,0,0]) clip_arm(clip_tooth_ofs, clip_tooth_spc, clip_tooth2_len, clip_num_teeth, last_tooth_extra = -(clip_thk + 2*clip_tooth_gap));

    translate([0.05,(clip_w-peg_w)/2,peg_thk]) rotate([90,0,180]) translate([0,-peg_l-peg_thk,0]) peg(base_l=peg_l*2/3);
    translate([0.05,(clip_w-peg_w)/2,peg_thk+(clip_thk+clip_tooth_len+clip_tooth2_len+clip_tooth_gap)]) rotate([90,0,180]) translate([0,-peg_l-peg_thk,0]) peg(base_l=peg_l*3);
    *translate([0,0,clip_thk+clip_tooth_len])cube([50,clip_w,1]);  // Gap debug

    // Top arm butresses
    translate([-clip_thk,clip_w,clip_thk])rotate([0,0,-90]) fillet_neg(h=clip_w,r=clip_thk/2);
    translate([-clip_thk,0,0])rotate([0,180,-90]) fillet_neg(h=clip_w,r=clip_thk/2);

    // Bottom arm buttresses
    translate([-clip_thk,clip_w,clip_thk + clip_thk+clip_tooth_len+clip_tooth_gap+clip_tooth2_len])rotate([0,0,-90]) fillet_neg(h=clip_w,r=clip_thk/2);
    translate([-clip_thk,0,clip_thk+clip_tooth_len+clip_tooth_gap+clip_tooth2_len])rotate([0,180,-90]) fillet_neg(h=clip_w,r=clip_thk/2);
  }
}

spacer_l = spacer_length;
spacer_h = spacer_back_height;
spacer_angle = spacer_back_angle;

module spacer() {
  union() {
    translate([0.05,(clip_w-peg_w)/2,peg_thk]) rotate([90,0,180]) translate([0,-peg_l-peg_thk,0]) peg(0);
    translate([-.05,0,0]) cube([spacer_l+.05,peg_w,peg_thk]);
    translate([spacer_l,clip_w,0]) rotate([180,spacer_angle,0]) translate([-clip_thk,0,0]) clip_tooth(spacer_h, false);
  }
}

// CD bracket
cdb_notch = 1;
cdb_back_lip = 0;

cda_dist = clip_dist;
cda_bot_thk = 5;
cda_bot_d = 10;
cda_thk = peg_thk;
cda_w = peg_w;
cda_angle = cd_arm_angle;
cdb_screw_or = 3.4/2;  // M3 clearance drill
cdb_screw_ir = (2.5 + 0.1)/2;  // M3 tap drill
cdb_screw_cap_r = (5.5 + 0.05)/2;  // M3 cap socket
cdb_screw_cap_h = 3;
cdb_thk = cd_slot_thickness;
cda_l = case_h - 2*peg_thk - peg_l;
cdb_lip_thk = 2;
cdb_lip_h = 3;
cdb_w = cd_slot_width;
cdb_d = cd_insertion_depth + cda_bot_d + cdb_back_lip*cdb_lip_thk;
cdb_notch_wl = cd_notch_width_left;
cdb_notch_wr = cd_notch_width_right;
cdb_notch_d = cd_notch_depth;
cdb_notch_hl = cd_notch_height_left;
cdb_notch_hr = cd_notch_height_right;

module cd_base() {
  difference() {
    union() {
      translate([-cdb_w/2, 0, 0]) cube([cdb_w, cdb_d, cdb_thk]);
      for (s = [1,-1]) translate([-s*cda_dist/2, 0, cdb_thk]) union() {
        if (cdb_back_lip != 0) {
          translate([-cda_w/2 - cdb_lip_thk, cda_bot_d, 0]) cube([cda_w + cdb_lip_thk*2, cdb_lip_thk, cdb_lip_h]);
        }
        for (s = [1,-1]) translate([s*(cda_w/2+cdb_lip_thk/2)-cdb_lip_thk/2, 0, 0]) cube([cdb_lip_thk, cda_bot_d+cdb_back_lip*cdb_lip_thk, cdb_lip_h]);
      }
    }
    for (f = [0,1]) {
      translate([-(cdb_w/2-f*cdb_notch_wl+0.05), cdb_d - (1-f)*cdb_notch_d +0.05, cdb_thk+1]) rotate([0, 90, -135+45]) fillet_neg(h=cdb_thk+2, r=cdb_d/6);
      translate([(cdb_w/2-f*cdb_notch_wr+0.05), cdb_d - (1-f)*cdb_notch_d +0.05, cdb_thk+1]) rotate([0, 90, 135+45]) fillet_neg(h=cdb_thk+2, r=cdb_d/6);
    }
    translate([-(cdb_w/2 - cdb_notch_wl/2)-cdb_notch_wl/2 - 0.05, cdb_d - cdb_notch_d, -1]) cube([cdb_notch_wl+0.05, cdb_notch_d + 0.05, cdb_thk+2]);
    translate([-cdb_w/2 - 0.05, cdb_d-cd_insertion_depth + 0.05, cdb_thk-cdb_notch_hl]) cube([cdb_notch_wl+0.05, cd_insertion_depth - cd_notch_depth + 0.05, cdb_notch_hl + 0.05]);
    translate([cdb_w/2 - cdb_notch_wr, cdb_d-cd_insertion_depth + 0.05, cdb_thk-cdb_notch_hr]) cube([cdb_notch_wr+0.05, cd_insertion_depth - cd_notch_depth + 0.05, cdb_notch_hr + 0.05]);
    translate([(cdb_w/2 - cdb_notch_wr/2)-cdb_notch_wr/2 - 0.05, cdb_d - cdb_notch_d, -1]) cube([cdb_notch_wr+0.1, cdb_notch_d + 0.05, cdb_thk+2]);
    for (s = [1,-1]) translate([s*cda_dist/2, cda_bot_d/2 + max(0, 1.5*cda_bot_thk*tan(cda_angle)), -1]) cylinder(r=cdb_screw_ir, h=cdb_thk+2, $fn=18);
    if (cdb_notch != 0) {
      translate([-peg_w/2-peg_thk, -0.05, -1]) cube([peg_w+2*peg_thk, 1.5*peg_thk+0.05, cdb_thk+2]);
      translate([0, 2*peg_thk, 0]) rotate([-cda_angle, 0, 0]) translate([-peg_w/2-peg_thk, -peg_thk, -1]) cube([peg_w+2*peg_thk, peg_thk, cdb_thk+2]);
      //translate([0, 2*peg_thk+cdb_thk*tan(cda_angle)+ cda_bot_d/3, -1]) cylinder(r=cdb_screw_r, h=cdb_thk+2, $fn=18);
    }
  }
}

module cd_arm() {
  difference() {
    union() {
      //translate([-cda_w/2, 0, 0]) cube([cda_w, cda_bot_d, cda_bot_thk]);
      translate([cda_w/2, cda_bot_d, 0]) rotate([90, 0, -90]) linear_extrude(height=cda_w) polygon([[0,0], [cda_bot_d, 0], [cda_bot_d-cda_bot_thk*tan(cda_angle), cda_bot_thk], [0, cda_bot_thk]]);
echo(1/cos(cda_angle) - cos(cda_angle));
      translate([0, (cda_angle > 0) ? cda_thk*(1/cos(cda_angle) - cos(cda_angle)) : 0, max(0, cda_thk*sin(cda_angle))+0.05]) rotate([-cda_angle, 0, 0]) translate([-cda_w/2, 0, 0]) cube([cda_w, cda_thk, cda_l]);
      translate([0, cda_thk + cda_bot_thk*tan(cda_angle)-0.05, cda_bot_thk - 0.05]) rotate([0, 0, 90]) fillet_angle(h=cda_w, r = cda_thk, angle=(90-cda_angle));
    }
    translate([0, cda_bot_d/2 + max(0, 1.5*cda_bot_thk*tan(cda_angle)), -1]) union() {
      cylinder(r=cdb_screw_or, h=cda_bot_thk+2, $fn=18);
      translate([0, 0, cda_bot_thk+0.05]) cylinder(r=cdb_screw_cap_r, h=cdb_screw_cap_h, $fn=27);
    }
  }
}


module main() {
  if (part == "case") {
    rotate([0,0,45]) translate([0,0,thick]) rotate([90,0,0]) case();
  } else if (part == "clip") {
    rotate([90,0,0]) clip_assembly();
    translate([clip_tooth_ofs+(clip_tooth_spc+clip_thk)*clip_num_teeth - clip_tooth_spc,clip_thk,0]) rotate([-90,180,0])clip_assembly();
  } else if (part == "spacer") {
    rotate([90,0,0]) spacer();
  } else if (part == "cdbracket") {
    cd_base();
    for (s = [1,-1]) translate([s*2, -cda_bot_d-3, cda_w/2]) rotate([0, s*90, 0]) cd_arm();
  }
}

module test_main() {
  keep_h = 1.66*case_h/3;

  if (part == "case") {
    translate([0,0,thick]) difference() {
      rotate([90,0,0]) case();
      translate([14,-3,14.9]) cube([140,20,50]);
      translate([104,-13,14.9]) cube([50,10,50]);
    }
  } else if (part == "box") {
    intersection() {
      translate([cable_box_thk,i_d+1.5*thick,-case_h+keep_h]) rotate([90,0,0]) case();
      cube([cable_box_thk+i_scr_ofs*0.75,i_d+3*thick,keep_h+0.1]);
    }
  } else if (part == "box2") {
    intersection() {
      translate([cable_box_thk,i_d+1.5*thick+.1,-case_h+keep_h*.8]) rotate([90,0,0]) case();
      cube([cable_box_thk,i_d+thick,keep_h*.6+0.1]);
    }
  } else if (part == "peg") {
    intersection() {
      translate([-(i_h/2 - (peg_w+2*peg_thk)/2)+.5,2*thick,thick+0.1]) rotate([90,0,0]) case();
      cube([peg_w+2*peg_thk+1,i_d+3*thick+peg_thk*2.5,peg_l+2*peg_thk]);
    }
  } else if (part == "clip") {
    rotate([90,0,0]) clip_assembly();
  } else if (part == "spacer") {
    rotate([90,0,0]) spacer();
  }
}

if (test) {
  test_main();
} else {
  main();
}
