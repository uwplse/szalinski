///////////////////////////////////////////////////////////////////////////////////
// 
// Tipping bucket rain gauge
//
// Designed by: Dan Bemowski
// Website    : http://dan.bemowski.info
// 
// This is for building a weather station rain gauge to connect to an arduino 
// microcontroller to measure rainfall amounts. The US standard diameter for a rain
// gauge is 8 in or 20.32 cm.  This was the measurement used to make the funnel.  I 
// use a height of 5 cm for the side wall as a splash guard and larger catchment 
// volume for heavier rainfalls.
//
// This project uses the standard tipping bucket method for measuring the rainfall.
// The tipping bucket is designed to hold a 4.25 mm neodymium disc magnet that will
// pass by a magnetic reed switch that will be attached to the arduino to measure
// the tipping bucket pulses.
//
// For calibrating the gauge, I am using the information from an instructables page
// that deals with connecting a small commercial tipping bucket rain sensor unit to
// an arduino.  The same information applies to this gauge which I am hoping will 
// be slightly more accurate than the small commercial versions.
// http://www.instructables.com/id/Arduino-Rain-Gauge-Calibration/
//
///////////////////////////////////////////////////////////////////////////////////

$fa=1;
$fs=1;

//I always use a fudge factor to fix an issue that happens in preview mode when
//difference is used. The issue is that hashed lines are shown at edges when
//hollowing out an area. Adding a small distance to the area being removed will
//prevent that hashing from showing.
fudge = 0.1;

//Here we define what we want to view
// available options are: base, funnel, tipping_bucket, base_bucket, base_support, all
view = "base_support";

//---------------------------------------------------------------------------------
//**** Funnel dimensions ****
//---------------------------------------------------------------------------------
bowl_h=40; //Funnel bowl height
bowl_r=101.6; //Funnel bowl radius
stem_h=10; //funnel stem height
stem_d=6; //Funnel stem diameter
funnel_wall_t=3; //Funnel wall thickness
splash_guard_d = 209.3; //Raised splash guard diameter
splash_guard_h = 50; //Raised splash guard height
funnel_offset_h = 30; //Funnel offset height

//---------------------------------------------------------------------------------
//**** Funnel cover case dimensions for the tipping bucket assembly ****
//---------------------------------------------------------------------------------
case_w = 60; //Case width
case_l = 140; //Case depth
case_h = 80; //Case height

case_t = 3; //Case wall thickness

//These values are to shave off the top part of the case that sticks into the funnel
//after it is drawn. The values are derived from the defined funnel dimensions. When 
//the funnel is drawn, the inside will then be smooth.
funnel_clearance_h = bowl_h; 
funnel_clearance_bottom_r = stem_d-funnel_wall_t;
funnel_clearance_top_r = bowl_r;

mount_hole_d = 8; //Mounting screw post diameter
screw_hole_d = 3; //Screw

//---------------------------------------------------------------------------------
//**** Tipping bucket ****
//---------------------------------------------------------------------------------
platform_w = 30; //Platform width
platform_l = 106.4; //Platform length 96.4
platform_z_offset = 0; //The offset distance of the platform in the Z direction
bucket_wall_t = 3;  //Thickness of the bucket walls

bucket_divider_h = 17; //Bucket divider height
bucket_divider_v_distance = 32; //Bucket divider height

pivot_arm_support_w = 7; //Pivot arm support_block width
pivot_arm_support_l = 8; //Pivot arm support_block length
pivot_arm_support_h = 5; //Pivot arm support_block height
pivot_peg_d = 3.8; //Pivot peg diameter
pivot_peg_l = 3; //Pivot peg length

magnet_holder_h = 2;
magnet_holder_outer_d = 6.2;
magnet_holder_inner_d = 4.4;

adjustment_standoff_h = 3.5;
adjustment_standoff_d = 10;
adjustment_standoff_spacing = 80;

//---------------------------------------------------------------------------------
//**** Base to hold the tipping bucket assembly ****
//---------------------------------------------------------------------------------
bucket_standoff_w = 4;
bucket_standoff_l = 12;
bucket_standoff_h = 18;

standoff_spacing = platform_w+0.7;

angled_support_w = 5;
angled_support_h = bucket_standoff_h/2;

reed_switch_board_w = 6.5;
reed_switch_board_h = 31;
reed_switch_board_d = 3;
reed_switch_board_offset_x = -4.2;
reed_switch_board_screw_hole_h = 8;

reed_switch_board_holder_offset_z = pivot_arm_support_h+1;
reed_switch_board_holder_h = 30;

reed_switch_board_top_slot_h = 7;
reed_switch_board_top_slot_d = reed_switch_board_d+1;

tipping_bucket_peg_hole_d = 4.5;
tipping_bucket_peg_hole_slot_h = 6;
tipping_bucket_peg_hole_slot_slide_h = 8;

main_base_w = 60;
main_base_l = 140;
main_base_t = 3;

platform_lip_w = 52;
platform_lip_l = 132;
platform_lip_t = 1;

main_base_offset_h = -16;

base_adjustment_standoff_h = 1.32;
base_adjustment_standoff_spacing = 77.7;
base_adjustment_screw_hole_d = 2.9;

side_wall_h = 28;

mounting_pipe_l = 30;
//A standard 3/4" PVC pipe inside diameter is 0.824 in or 20.93 mm, so I made this 
//slightly smaller so it would fit inside the 3/4" pipe
mounting_pipe_od = 20.25; 
//This will give us a 6.25 mm or ~1/4 in wall thickness for the attachment nipple
//which will give it good strength.
mounting_pipe_id = 14;

mounting_screw_head_t = 2;
mounting_screw_head_d = 6;

bucket_drain_w = 30;
bucket_drain_l = 19;
bucket_drain_recess = 2;
bucket_drain_edge_offset = 1;
bucket_drain_hole_w = 4.3;
bucket_drain_hole_l = 6;
//---------------------------------------------------------------------------------

/**
 * funnel_cover - This is the rain catchment funnel with the attached cover for the
 *                tipping bucket assembly.  
 */
module funnel_cover() {
    difference() {
        //Create the funnel cover case
        case();
        //Shave the top for smoothing the inside of the funnel
        translate([0, 0, funnel_clearance_h-1]) cylindrical_coupling(h=funnel_clearance_h,r1=funnel_clearance_bottom_r,r2=funnel_clearance_top_r);
    }
    //Create the top splash guard
    translate([0, 0, funnel_offset_h+splash_guard_h]) pipe(od=splash_guard_d, id=splash_guard_d-(funnel_wall_t*2), height=splash_guard_h);
    //Add the main funnel
    translate([0, 0, funnel_offset_h]) funnel();
}

/**
 * funnel - Used to create a funnel
 */
module funnel() {
    translate([0, 0, stem_h]) {
        difference() {
            cylindrical_coupling(h=bowl_h,r1=(stem_d/2)+funnel_wall_t,r2=bowl_r+funnel_wall_t);
            cylindrical_coupling(h=bowl_h+1,r1=(stem_d/2),r2=bowl_r);
        }
    }
    pipe(od=stem_d+(funnel_wall_t*2), id=stem_d, height=stem_h);
}

/**
 * pipe - Used to create a pipe with a defined outside and inside diameter and 
 *        height/length
 */
module pipe(od=10, id=7, height=10) {
    difference() {
        cylinder(d=od, h=height);
        translate([0,0,-1]) cylinder(d=id, h=height+2);
    }
}

/**
 * case - Used to create the box shroud for the tipping bucket assembly with 
 *        mounting screw standoffs
 */
module case() {
    difference() {
        translate([-(case_w/2), -(case_l/2), -16]) cube([case_w, case_l, case_h]);
        translate([-(case_w/2)+case_t, -(case_l/2)+case_t, -17]) cube([case_w-(case_t*2), case_l-(case_t*2), 82]);
    }
    for(x=[-1, 1], y=[-1, 1]) {
        difference() {
            translate([x*((case_w/2)-(mount_hole_d/1.35)), y*((case_l/2)-(mount_hole_d/1.35)), -14.75]) cylinder(case_h, d=mount_hole_d);
            translate([x*((case_w/2)-(mount_hole_d/1.35)), y*((case_l/2)-(mount_hole_d/1.35)), -14.75]) cylinder(case_h, d=screw_hole_d);
        }
    }
}

/**
 * bucket - Used to create the tipping bucket
 */
module bucket() {
    translate([0, 0, pivot_arm_support_h]) {
        difference() {
            union() {
                //main bucket platform
                translate([-(platform_w/2), -(platform_l/2), platform_z_offset]) cube([platform_w, platform_l, bucket_wall_t]);

                //pivot 1
                translate([(platform_w/2)-pivot_arm_support_w, -4, platform_z_offset-pivot_arm_support_h]) cube([pivot_arm_support_w, pivot_arm_support_l, pivot_arm_support_h]);
                translate([(platform_w/2)-pivot_arm_support_w, 0, platform_z_offset-pivot_arm_support_h]) rotate([90, 0, 90]) cylinder(d=pivot_arm_support_l, h=pivot_arm_support_w);
                translate([(platform_w/2), 0, platform_z_offset-pivot_arm_support_h]) rotate([90, 0, 90]) cylinder(d=pivot_peg_d, h=pivot_peg_l);

                //pivot 2
                translate([-(platform_w/2), -4, platform_z_offset-pivot_arm_support_h]) cube([pivot_arm_support_w, pivot_arm_support_l, pivot_arm_support_h]);
                translate([-(platform_w/2), 0, platform_z_offset-pivot_arm_support_h]) rotate([90, 0, 90]) cylinder(d=pivot_arm_support_l, h=pivot_arm_support_w);
                translate([-(platform_w/2)-pivot_peg_l, 0, platform_z_offset-pivot_arm_support_h]) rotate([90, 0, 90])  cylinder(d=pivot_peg_d, h=pivot_peg_l);

                //bucket divider
                translate([(platform_w/2), 0, platform_z_offset+bucket_wall_t]) rotate([0, 270, 0]) Triangle(a=(bucket_divider_v_distance/2), b=bucket_divider_h, angle=90, height=platform_w);
                translate([-(platform_w/2), 0, platform_z_offset+bucket_wall_t]) rotate([180, 270, 0]) Triangle(a=(bucket_divider_v_distance/2), b=bucket_divider_h, angle=90, height=platform_w);

                //bucket sides
                translate([(platform_w/2), 0, platform_z_offset+bucket_wall_t]) rotate([0, 270, 0]) Triangle(a=platform_l/2, b=bucket_divider_h, angle=90, height=3);
                translate([-(platform_w/2)+bucket_wall_t, 0, platform_z_offset+bucket_wall_t]) rotate([0, 270, 0]) Triangle(a=platform_l/2, b=bucket_divider_h, angle=90, height=3);
                translate([(platform_w/2)-bucket_wall_t, 0, platform_z_offset+bucket_wall_t]) rotate([180, 270, 0]) Triangle(a=platform_l/2, b=bucket_divider_h, angle=90, height=3);
                translate([-(platform_w/2), 0, platform_z_offset+bucket_wall_t]) rotate([180, 270, 0]) Triangle(a=platform_l/2, b=bucket_divider_h, angle=90, height=3);

                //round magnet holder for
                difference() {
                    translate([-(platform_w/2)-magnet_holder_h, 0, platform_z_offset+16.5]) rotate([90, 0, 90]) cylinder(d=magnet_holder_outer_d, h=magnet_holder_h);
                    translate([-(platform_w/2)-magnet_holder_h-(fudge/2), 0, platform_z_offset+16.5]) rotate([90, 0, 90]) cylinder(d=magnet_holder_inner_d, h=magnet_holder_h);
                }
                //offset weight to balance the other side
                translate([(platform_w/2), 0, platform_z_offset+16.5]) rotate([90, 0, 90]) cylinder(d=magnet_holder_outer_d, h=magnet_holder_h);
                //adjustment standoffs
                difference() {
                    translate([0, adjustment_standoff_spacing/2, platform_z_offset-(adjustment_standoff_h/2)]) rotate([20, 0, 0]) cylinder(d=adjustment_standoff_d, h=adjustment_standoff_h);
                    translate([-4, adjustment_standoff_spacing/2, platform_z_offset+3]) cube([8, 8, 1]);
                }
                difference() {
                    translate([0, -(adjustment_standoff_spacing/2), platform_z_offset-(adjustment_standoff_h/2)]) rotate([-20, 0, 0]) cylinder(d=adjustment_standoff_d, h=adjustment_standoff_h);
                    translate([-4, -48, platform_z_offset+bucket_wall_t]) cube([8, 8, 1]);
                }
            }
            //hollow out the bucket divider
            translate([(platform_w-(pivot_arm_support_w*2))/2, -(fudge/2), platform_z_offset-(fudge/2)]) rotate([0, 270, 0]) Triangle(a=(bucket_divider_v_distance/2), b=bucket_divider_h, angle=90, height=platform_w-(pivot_arm_support_w*2));
            translate([-(platform_w-(pivot_arm_support_w*2))/2, (fudge/2), platform_z_offset-(fudge/2)]) rotate([180, 270, 0]) Triangle(a=(bucket_divider_v_distance/2), b=bucket_divider_h, angle=90, height=platform_w-(pivot_arm_support_w*2));
            
            //shave off the corners to the same angle as the standoffs
            translate([0, adjustment_standoff_spacing/2-(fudge/2), platform_z_offset-adjustment_standoff_h-(fudge*1.31)]) rotate([20, 0, 0]) cube([platform_w+fudge, adjustment_standoff_d*4, adjustment_standoff_h], center=true);
            translate([0, -(adjustment_standoff_spacing/2)-(fudge/2), platform_z_offset-adjustment_standoff_h-(fudge*1.31)]) rotate([-20, 0, 0]) cube([platform_w+fudge, adjustment_standoff_d*4, adjustment_standoff_h], center=true);
        }
    }
}

/**
 * base - Used to create the base mounting platform that holds the tipping bucket
 *        and the magnetic reed switch.  It also has a side mounting nipple to 
 *        attach to a standard PVC pipe.
 */
module base() {
    // uprights for holding tipping bucket
    difference() {
        union() {
            translate([standoff_spacing/2, -(bucket_standoff_l/2), main_base_offset_h+main_base_t+platform_lip_t]) cube([bucket_standoff_w, bucket_standoff_l, bucket_standoff_h]);
            translate([-(standoff_spacing/2)-bucket_standoff_w, -(bucket_standoff_l/2), main_base_offset_h+main_base_t+platform_lip_t]) cube([bucket_standoff_w, bucket_standoff_l, bucket_standoff_h]);
            translate([-(standoff_spacing/2)-bucket_standoff_w, -(bucket_standoff_l/2), angled_support_w]) rotate([0, 90, 90]) Triangle(a=angled_support_w, b=angled_support_h, angle=90, height=bucket_standoff_l);
            translate([-(standoff_spacing/2)-bucket_standoff_w-angled_support_w, -(bucket_standoff_l/2), angled_support_w]) cube([angled_support_w, bucket_standoff_l, reed_switch_board_holder_h]);
            translate([-(standoff_spacing/2)-bucket_standoff_w-angled_support_w, 0, reed_switch_board_holder_h+angled_support_w]) rotate([0, 90, 0]) cylinder(d=bucket_standoff_l, h=angled_support_w);
        }
        // slot for magnetic reed switch
        translate([-((standoff_spacing/2)+bucket_standoff_w+reed_switch_board_d)-(fudge/2), reed_switch_board_offset_x, reed_switch_board_holder_offset_z]) cube([reed_switch_board_d+fudge, reed_switch_board_w, reed_switch_board_h]);
        //slightly deeper slot space at top for wire connection on reed switch board
        translate([-((standoff_spacing/2)+bucket_standoff_w+reed_switch_board_d+1), reed_switch_board_offset_x, reed_switch_board_h]) cube([reed_switch_board_top_slot_d, reed_switch_board_w, reed_switch_board_top_slot_h]);
        // screw mounting hole for reed switch
        translate([-(standoff_spacing/2)-bucket_standoff_w-angled_support_w-(fudge/2), (reed_switch_board_w/2)+reed_switch_board_offset_x, reed_switch_board_screw_hole_h]) rotate([0, 90, 0]) cylinder(d=1.25, h=8+fudge);
        // hole for wire
        translate([-(standoff_spacing/2)-bucket_standoff_w-angled_support_w-(fudge/2), (reed_switch_board_w/2)+reed_switch_board_offset_x, 36.5]) rotate([0, 90, 0]) cylinder(d=3.25, h=3+fudge);
        //slots for the tipping bucket pegs to rest in
        translate([-((standoff_spacing/2)+(bucket_standoff_w/3)), -(tipping_bucket_peg_hole_d/2), 0]) cube([standoff_spacing+((bucket_standoff_w/3)*2), tipping_bucket_peg_hole_d, tipping_bucket_peg_hole_slot_h]);
        translate([-((standoff_spacing/2)+((bucket_standoff_w/3)*2)), 0, 0]) rotate([0, 90, 0]) cylinder(d=tipping_bucket_peg_hole_d, h=(standoff_spacing+((bucket_standoff_w/3)*2)*2));
        translate([-((standoff_spacing/2)+0.25), -(tipping_bucket_peg_hole_d/2), tipping_bucket_peg_hole_slot_slide_h+fudge]) rotate([0, 90, 90]) Triangle(a=bucket_standoff_w+(fudge/2), b=tipping_bucket_peg_hole_slot_slide_h, angle=90, height=tipping_bucket_peg_hole_d);
        translate([((standoff_spacing/2)+0.25), (tipping_bucket_peg_hole_d/2), tipping_bucket_peg_hole_slot_slide_h+fudge]) rotate([0, 90, 270]) Triangle(a=bucket_standoff_w+(fudge/2), b=tipping_bucket_peg_hole_slot_slide_h, angle=90, height=tipping_bucket_peg_hole_d);
    }

    // main base
    difference() {
        union() {
            // base platform
            translate([-(main_base_w/2), -(main_base_l/2), main_base_offset_h]) cube([main_base_w, main_base_l, main_base_t]);
            // platform lip
            translate([-(platform_lip_w/2), -(platform_lip_l/2), main_base_offset_h+main_base_t]) cube([platform_lip_w, platform_lip_l, platform_lip_t]);
            // bucket tipping adjustment stands
            translate([0, -(base_adjustment_standoff_spacing/2), main_base_offset_h+main_base_t+platform_lip_t]) cylinder(d=adjustment_standoff_d, h=base_adjustment_standoff_h);
            translate([0, (base_adjustment_standoff_spacing/2), main_base_offset_h+main_base_t+platform_lip_t]) cylinder(d=adjustment_standoff_d, h=base_adjustment_standoff_h);
        }
        //hole for wire to drop through to mounting pipe
        translate([-(standoff_spacing/2)-bucket_standoff_w-((angled_support_w*2)/3), 0, main_base_offset_h-(fudge/2)]) cylinder(d=4, h=main_base_t+platform_lip_t+fudge);
        
        //screw holes to attach to the funnel
        for(x=[-1, 1], y=[-1, 1]) {
            translate([x*((case_w/2)-(mount_hole_d/1.35)), y*((case_l/2)-(mount_hole_d/1.35)), main_base_offset_h-(fudge/2)]) cylinder(d=screw_hole_d+0.75, h=base_adjustment_standoff_h+platform_lip_t+main_base_t+fudge);
            //translate([x*((case_w/2)-(mount_hole_d/1.35)), y*((case_l/2)-(mount_hole_d/1.35)), main_base_offset_h-(fudge/2)]) cylinder(d=mounting_screw_head_d, h=mounting_screw_head_t+(fudge/2));
        }
        // bucket adjustment screw holes
        translate([0, -(base_adjustment_standoff_spacing/2), main_base_offset_h-(fudge/2)]) cylinder(d=base_adjustment_screw_hole_d, h=base_adjustment_standoff_h+platform_lip_t+main_base_t+fudge);
        translate([0, (base_adjustment_standoff_spacing/2), main_base_offset_h-(fudge/2)]) cylinder(d=base_adjustment_screw_hole_d, h=base_adjustment_standoff_h+platform_lip_t+main_base_t+fudge);
        
        // left bucket drain
        translate([-(bucket_drain_w/2), -(platform_lip_l/2)+bucket_drain_edge_offset, main_base_offset_h+main_base_t+platform_lip_t-bucket_drain_recess]) cube([bucket_drain_w, bucket_drain_l, bucket_drain_recess+(fudge/2)]);
        
        for(x=[-15, -9.9, -4.7, 0.60, 5.7, 10.7]) {
            for(y=[-65, -58.5, -52]) {
                translate([x, y, main_base_offset_h-(fudge/2)]) cube([bucket_drain_hole_w, bucket_drain_hole_l, main_base_t+platform_lip_t+fudge]);
            }
        }
        
        // right bucket drain
        translate([-(bucket_drain_w/2), (platform_lip_l/2)-bucket_drain_edge_offset-bucket_drain_l, main_base_offset_h+main_base_t+platform_lip_t-bucket_drain_recess]) cube([bucket_drain_w, bucket_drain_l, bucket_drain_recess+(fudge/2)]);
        
        for(x=[-15, -9.9, -4.7, 0.60, 5.7, 10.7]) {
            for(y=[59, 52.5, 46]) {
                translate([x, y, main_base_offset_h-(fudge/2)]) cube([bucket_drain_hole_w, bucket_drain_hole_l, main_base_t+platform_lip_t+fudge]);
            }
        }
    }
}

/**
 * basesupport - Used to create the base mounting platform that holds the tipping bucket
 *               and the magnetic reed switch.  It also has a side mounting nipple to 
 *               attach to a standard PVC pipe.
 */
module base_support() {
    // main base
    difference() {
        union() {
            // base platform
            translate([-(main_base_w/2), -(main_base_l/2), main_base_offset_h]) cube([main_base_w, main_base_l, main_base_t]);
            
            //sides for mounting
            translate([-(main_base_w/2), -(main_base_l/2), main_base_offset_h-side_wall_h]) cube([main_base_t, main_base_l, side_wall_h]);
            translate([-(main_base_w/2)+main_base_t, -(main_base_l/2), main_base_offset_h]) rotate([270, 0, 0]) Triangle(a=side_wall_h, b=main_base_w-main_base_t, angle=90, height=main_base_t);
            translate([-(main_base_w/2)+main_base_t, (main_base_l/2)-main_base_t, main_base_offset_h]) rotate([270, 0, 0]) Triangle(a=side_wall_h, b=main_base_w-main_base_t, angle=90, height=main_base_t);
            translate([-(main_base_w/2)+main_base_t, -((mounting_pipe_od/2)+main_base_t), main_base_offset_h]) rotate([270, 0, 0]) Triangle(a=side_wall_h, b=main_base_w-main_base_t, angle=90, height=main_base_t);
            translate([-(main_base_w/2)+main_base_t, (mounting_pipe_od/2), main_base_offset_h]) rotate([270, 0, 0]) Triangle(a=side_wall_h, b=main_base_w-main_base_t, angle=90, height=main_base_t);
            
            //mounting pipe
            translate([-((main_base_w/2)+mounting_pipe_l), 0, main_base_offset_h-(side_wall_h/2)]) rotate([0, 90, 0]) cylinder(d=mounting_pipe_od, h=mounting_pipe_l);
        }
        //hole for wire to drop through to mounting pipe
        translate([-(standoff_spacing/2)-bucket_standoff_w-((angled_support_w*2)/3), 0, main_base_offset_h-(fudge/2)]) cylinder(d=4, h=main_base_t+platform_lip_t+fudge);
        
        //hollow out the mounting pipe
        translate([-((main_base_w/2)+mounting_pipe_l)-(fudge/2), 0, main_base_offset_h-(side_wall_h/2)]) rotate([0, 90, 0]) cylinder(d=mounting_pipe_id, h=mounting_pipe_l+main_base_t+fudge);
        
        //screw holes to attach to the funnel
        for(x=[-1, 1], y=[-1, 1]) {
            translate([x*((case_w/2)-(mount_hole_d/1.35)), y*((case_l/2)-(mount_hole_d/1.35)), main_base_offset_h-(fudge/2)]) cylinder(d=screw_hole_d+0.75, h=base_adjustment_standoff_h+platform_lip_t+main_base_t+fudge);
            translate([x*((case_w/2)-(mount_hole_d/1.35)), y*((case_l/2)-(mount_hole_d/1.35)), main_base_offset_h-(fudge/2)]) cylinder(d=mounting_screw_head_d, h=mounting_screw_head_t+(fudge/2));
        }
        // bucket adjustment screw holes
        translate([0, -(base_adjustment_standoff_spacing/2), main_base_offset_h-(fudge/2)]) cylinder(d=base_adjustment_screw_hole_d+4, h=base_adjustment_standoff_h+platform_lip_t+main_base_t+fudge);
        translate([0, (base_adjustment_standoff_spacing/2), main_base_offset_h-(fudge/2)]) cylinder(d=base_adjustment_screw_hole_d+4, h=base_adjustment_standoff_h+platform_lip_t+main_base_t+fudge);
        
        // left bucket drain
        translate([-(bucket_drain_w/2), -(platform_lip_l/2)+bucket_drain_edge_offset, main_base_offset_h+main_base_t+platform_lip_t-bucket_drain_recess-3]) cube([bucket_drain_w, bucket_drain_l, bucket_drain_recess+3+(fudge/2)]);
        
        // right bucket drain
        translate([-(bucket_drain_w/2), (platform_lip_l/2)-bucket_drain_edge_offset-bucket_drain_l, main_base_offset_h+main_base_t+platform_lip_t-bucket_drain_recess-3]) cube([bucket_drain_w, bucket_drain_l, bucket_drain_recess+3+(fudge/2)]);
        
    }
}

/**
 * cylindrical_coupling - This is the module used to create the sweeping funnel design 
 */
module cylindrical_coupling(h,r1,r2,shape=0.5, kernel="sigmoid", slices=100) {
    // Method:
    //  1. Calculate transition polygon using the selected kernel function
    //  2. Scale to desired size
    
    // Kernels
    function sigmoid(a,x) =-0.5+ 1 / (1+exp(-a*x));
    function tanh(a,x) = (1-exp(-2*a*x)) /(1+exp(-2*a*x));
    function nonlinear1(a,x) = a*x/sqrt(1+pow(a*x,2));
    function nonlinear2(a,x) = a*x/(1+abs(a*x));
    function linear(a,x) = a*x;
    
    // Select kernel
    function shape_func(a,x) = 
        (kernel=="sigmoid") ? sigmoid(a,x) : 
            (kernel=="tanh") ? tanh(a,x) : 
                (kernel=="linear") ? linear(a,x)  :
                    (kernel=="nonlinear1") ? nonlinear1(a,x) :
                        (kernel=="nonlinear2") ? nonlinear2(a,x) :
                            sigmoid(a,x); echo("WARNING: Unknown kernel. Using sigmoid");
              
    // Draw relative to x=[-10,10]
    x_min = -10;
    x_max = 10;
    x_span = x_max - x_min;
    x_step = x_span / slices;
    x = [for (i=[x_min:x_step:x_max+x_step]) i];

    // Derive y range
    y_max = shape_func(shape, x_max+x_step);
    y_min = shape_func(shape, x_min);
    y_span = y_max - y_min;
    
    // Calc scaling parameters
    y_scale = 1/y_span; 
    h_scale = h/x_span;
    L = r2-r1;
    
    // Generate polygon
    reducer_points = [for (i = [0:slices]) [r1+0.5*L+L*y_scale*shape_func(shape,x[i]),x[i]]];
    points = concat(reducer_points, [[0,x_max],[0,x_min]]);

    // Draw
    rotate_extrude()
    scale([1,h_scale,1])
    translate([0,x_max,0])polygon(points);
             
}

/* 
 * Triangle - module for making triangles and prisms
 *	 a: Length of side a
 *	 b: Length of side b
 *	 angle: angle at point angleAB
 */
module Triangle(
			a, b, angle, height=1, heights=undef,
			center=undef, centerXYZ=[false,false,false])
{
	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCA = ((heights==undef) ? height : heights[2])/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCA);

	// Calculate Offsets for centering
	offsetX = (center || (center==undef && centerXYZ[0]))?((cos(angle)*a)+b)/3:0;
	offsetY = (center || (center==undef && centerXYZ[1]))?(sin(angle)*a)/3:0;
	
	pointAB1 = [-offsetX,-offsetY, centerZ-heightAB];
	pointAB2 = [-offsetX,-offsetY, centerZ+heightAB];
	pointBC1 = [b-offsetX,-offsetY, centerZ-heightBC];
	pointBC2 = [b-offsetX,-offsetY, centerZ+heightBC];
	pointCA1 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ-heightCA];
	pointCA2 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ+heightCA];

	polyhedron(
		points=[	pointAB1, pointBC1, pointCA1,
					pointAB2, pointBC2, pointCA2 ],
		faces=[	
			[0, 1, 2],
			[3, 5, 4],
			[0, 3, 1],
			[1, 3, 4],
			[1, 4, 2],
			[2, 4, 5],
			[2, 5, 0],
			[0, 5, 3] ] );
}


// available options are: base, funnel, tipping_bucket, base_bucket, all

if (view == "base") {
    base();
} else if (view == "funnel") {
    translate([0, 0, 130]) {
        rotate([180, 0, 0]) {
            funnel_cover();
        }
    }
} else if (view == "tipping_bucket") {
    bucket();
} else if (view == "base_support") {
    base_support();
} else if (view == "base_bucket") {
    base();
    rotate([-20, 0, 0]) bucket();
} else if (view == "all") {
    base();
    rotate([-20, 0, 0]) bucket();
    funnel_cover();
} else {
    echo("UNKNOWN VIEW SELECTED. Set the view variable to define the view");
}
