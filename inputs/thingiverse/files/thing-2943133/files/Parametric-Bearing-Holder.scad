//-----------------------------------------------------------------------------
//
// Parameter Based Bearing Holder Template v1.0 by Matt Kidd
// I was inspired to create this by stories from comments about
// tweaks made to my past holder models by others to suit their projects.
// Dimensions in mm unless otherwise specified.
//
//-----------------------------------------------------------------------------

//
// Holder Dimensions
//

// The width of the holder (dimension perpendicular to bearing direction).
h_width = 31;
// The depth of the holder (dimension parallel to the bearing direction).
h_depth = 30;
// The thickness of the holder (as a rough guide this should be half the bearing diameter plus 1mm plus the thickness of the material under the bearing.
h_thickness = 10.6;
// Adds a little extra material above the mid point of the bearing for added hold. This should not be set more than 1mm unless you want to risk being unable to insert the bearing.
h_raise_ctr = 1;

//
// Bearing Dimensions
//

// The length of the bearing
b_length = 25.4;
// The outer diameter of the bearing
b_out_d = 16;

//
// Screw Dimensions
//

// The diameter of the hole for the screw. Set undersize to be able to screw directly into the plastic or oversize for it to slide through unhindered if using nuts.
s_hole_d = 4.6;
// The distance between centers of screw holes along the depth of the holder.
s_dist = 18;
// The distance between the centers of screw holes along the width of the holder.
s_sepa = 23.5;
// Bevel for the bottom edge of the hole for easier tapping.
s_h_bevel = 0.6;

//
// Cable Tie Dimensions
//

// Thickness of the cable tie
ct_thick = 1.8;
// Width of the cable tie
ct_width = 2.6;
// The distance between cable ties
ct_dist = 11;

//
// Nut Slot Dimensions
//

// The diameter of the nut
n_dia = 8;
// The thickness of the nut
n_thick = 4;
// The distance the nut is inset into the part. Low values will result in a part that is likely to fail as the nut may simply be pulled through the plastic.
n_inset = 2.5;

//
// Rod Dimensions
//

// The diameter of the rod that will go through the bearing plus a suitable extra amount to give the rod clearance to not rub against the holder.
r_out_cl = 8.6;

//
// Detail Settings
//

// Increase to stretch the curved profile down the part. Decrease to do the opposite.
curve_str = 1; 
// the higher this value, the smoother the curves and the longer the processing time.
detail = 32; 

//
// Tolerance Settings
//

// Larger tolerance value added to the cable tie features to allow the user to use observed measurements for cable tie parameters.
fit_1 = 1;
// Tweak this to (hopefully) clear any face fighting in the rendered view.
f_fight = 0.01;

//
// Overlap Prevention
//

// Minimum flat surface between edge of bearing recess and start of profile curves.
b_2_holder_curve = 1;
// Ensures we don't end up with a negative value for our cut out.
max_b_2_holder = (h_width-b_out_d-b_2_holder_curve*2) <= 0 ? 0 : (h_width-b_out_d-b_2_holder_curve*2); 

module holder(){
    
    s_trans_x = s_sepa/2;
    
    difference(){
        // Our holder volume
        union(){
            translate([0,0,h_thickness/2]) cube([h_width, h_depth, h_thickness],center=true);
            translate([0,0,h_thickness+h_raise_ctr/2]) cube([b_out_d+b_2_holder_curve*2, h_depth, h_raise_ctr],center=true);
        }
        union(){
            // Our bearing volume
            translate([0,0,h_thickness]) rotate([90,0,0]) cylinder(h=b_length, d=b_out_d, $fn=detail*4, center=true);
            // Our smooth rod clearance volume
            translate([0,0,h_thickness]) rotate([90,0,0]) cylinder(h=h_depth+f_fight, d=r_out_cl, $fn=detail*4, center=true);
        translate([(h_width-max_b_2_holder)/2,0,h_thickness]) smoo_corn();
        rotate([0,0,180]) translate([(h_width-max_b_2_holder)/2,0,h_thickness]) smoo_corn();
            translate([s_trans_x,s_dist/2,0]) screw_hole();
            translate([s_trans_x,s_dist/2,0]) nut_slot();
            translate([s_trans_x,-s_dist/2,0]) screw_hole();
            translate([s_trans_x,-s_dist/2,0]) nut_slot();
            translate([-s_trans_x,s_dist/2,0]) screw_hole();
            translate([-s_trans_x,s_dist/2,0]) rotate([0,0,180]) nut_slot();
            translate([-s_trans_x,-s_dist/2,0]) screw_hole();
            translate([-s_trans_x,-s_dist/2,0]) rotate([0,0,180]) nut_slot();
            translate([0,ct_dist/2,0]) cable_ties();
            translate([0,-ct_dist/2,0]) cable_ties();
        }
        translate([b_out_d/2+b_2_holder_curve,0,h_thickness+h_raise_ctr]) rotate([90,0,0]) cylinder(h=h_depth+f_fight, d=b_2_holder_curve, $fn = 4, center=true);
        rotate([0,0,180]) translate([b_out_d/2+b_2_holder_curve,0,h_thickness+h_raise_ctr]) rotate([90,0,0]) cylinder(h=h_depth+f_fight, d=b_2_holder_curve, $fn = 4, center=true);
    }
}

module smoo_corn(){
    // A smoothed corner - essentially a cube with a quarter cylinder subtracted from it! This could be improved by making a module that has parametric features instead.
    
    dist2play = h_thickness-max_b_2_holder;
    dist2play_perc = h_thickness/max_b_2_holder;
    
    translate([0,0,0]) scale([1,1,dist2play_perc*curve_str]) translate([0,0,0]) difference(){
        translate([max_b_2_holder/4+f_fight/2,0,-max_b_2_holder/4+f_fight/2]) cube([max_b_2_holder/2+f_fight,h_depth+f_fight/2,max_b_2_holder/2+f_fight], center=true);
        translate([0,0,-max_b_2_holder/2+f_fight/2])rotate([90,0,0]) cylinder(h=h_depth+f_fight, d=max_b_2_holder, $fn=detail*4, center=true);
    }
}

module screw_hole(){
    // A hole for a screw with optional chamfered edge for easeier threading.
    translate([0,0,(h_thickness/2)+s_h_bevel/2]) cylinder(h=h_thickness+f_fight-s_h_bevel,d=s_hole_d, $fn=detail*2, center=true);
    translate([0,0,s_h_bevel/2]) cylinder(h=s_h_bevel+f_fight,d2=s_hole_d, d1=s_hole_d+s_h_bevel, $fn=detail*2, center=true);
}

module cable_ties(){
    // A cutout for the cable tie.
    difference(){
            // Our outer volume
            translate([0,0,h_thickness]) rotate([90,0,0]) cylinder(h=ct_width+fit_1, d=b_out_d+b_2_holder_curve*2+ct_thick+fit_1+0.5, $fn=detail*4, center=true);            
            // Our inner volume
            translate([0,0,h_thickness]) rotate([90,0,0]) cylinder(h=ct_width+f_fight+fit_1, d=b_out_d+b_2_holder_curve*2+0.5, $fn=detail*4, center=true);
    }
            // Cutaway for cable tie routing
            translate([0,0,(h_thickness-(b_out_d+b_2_holder_curve*2+0.5)/2-f_fight)/2]) cube([b_out_d/2,ct_width+f_fight+fit_1,h_thickness-(b_out_d+b_2_holder_curve*2+0.5)/2+f_fight],center=true);
}

module nut_slot(){
    translate([0,0,n_inset+n_thick/2]) cube([n_dia, n_dia, n_thick],center=true);
}

// Draw the holder
holder();