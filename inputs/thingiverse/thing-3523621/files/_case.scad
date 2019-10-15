/****************************************************************
 * File                : case.scad
 *
 * Author              : Roel Drost
 * Date                : March 28th 2019
 * Version             : 1.0
 * License             : This file and artifacts created using
 *                       this file are for non comercial use
 *                       only.
 *
 * DO NOT CHANGE OR USE THIS FILE DIRECTLY.
 *
 ***************************************************************/

/****************************************************************
 * Includes / uses
 ***************************************************************/

use <_shapes.scad>
use <_functions.scad>

/****************************************************************
 * Version control
 ***************************************************************/
 
CASE_VERSION = [1, 0]; // [major, minor]
if ((CONFIGURATION_COMPAT_VERSION[0] != CASE_VERSION[0]) ||
    (CONFIGURATION_COMPAT_VERSION[1] >  CASE_VERSION[1]))
{
    echo();
    echo("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    echo("WARNING! CONFIGURATION MIGHT BE INCOMPATIBLE WITH CASE");
    echo(str("Configuration file has version ", 
         CONFIGURATION_COMPAT_VERSION[0], ".", 
         CONFIGURATION_COMPAT_VERSION[1], " case has version ", 
         CASE_VERSION[0], ".", 
         CASE_VERSION[1]));
    echo("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    echo();
}

/****************************************************************
 * Some calculations
 ***************************************************************/

bevel               = 2;
wall_thickness      = 2 * case_wall_seam_thickness + case_wall_seam_clearance;
wall_radius_outer   = wall_thickness;
pcb_board_thicknes  = pcb_board_dim[2];
case_wall_thickness = 2*case_wall_seam_thickness + case_wall_seam_clearance;
h_top_pcb           = case_thickness_bottom + pcb_clearance_bottom
                      + pcb_board_thicknes;
seam_height         = case_thickness_bottom + pcb_clearance_bottom
                      + pcb_board_thicknes + pcb_seam_height;
case_height         = case_thickness_bottom + pcb_clearance_bottom
                      + pcb_board_thicknes + pcb_clearance_top
                      + case_thickness_top;
outer_wall_size     = [pcb_board_dim[0] + 2 * case_wall_thickness,
                       pcb_board_dim[1] + 2 * case_wall_thickness];
strut_with          = inner_circle(screw_head_size) + 2 
                      * (strut_wall_thickness + strut_clearance[0]);
components_origin   = [
    components_alignment[0] * pcb_board_dim[0] / 2,
    components_alignment[1] * pcb_board_dim[1] / 2,
    h_top_pcb];

/****************************************************************
 * Public modules
 ***************************************************************/

module top() {
    difference() {
        union() {
            top_without_components();
            translate(components_origin) components_positive_top();
        }
        translate(components_origin) components_negative();
    }
}

module bottom() {
    difference() {
        union() {
            bottom_without_components();
            translate(components_origin) components_positive_bottom();
        }
        translate(components_origin) components_negative();
    }
}

/****************************************************************
 * Private modules
 ***************************************************************/

module top_without_components() {
    difference() {
        top_outer_wall();
        difference() {
            top_board_clearance();
            top_nuts_and_bolts_pos();
        }
        top_nuts_and_bolts_neg();
    }
}

module bottom_without_components() {
    difference() {
        union() {
            bottom_outer_wall();
            bottom_montage_struts();
        }
        difference() {
            bottom_board_clearance();
            bottom_nuts_and_bolts_pos();
        }
        bottom_nuts_and_bolts_neg();
    }
}

module top_outer_wall() {
    union() {
        difference() {
            translate([0,0,seam_height]) {
                top_shape(outer_wall_size, wall_radius_outer, bevel, 
                          case_height - seam_height);
            }
            linear_extrude(seam_height + case_wall_seam_height + 
                           case_wall_seam_clearance)
            {
                substract = case_wall_seam_thickness;
                rounded_square([outer_wall_size[0] - 2 * substract,
                                outer_wall_size[1] - 2 * substract], 
                               wall_radius_outer - substract, true);
            }
        }
        translate([0, 0, case_thickness_bottom]) {
            linear_extrude(case_height - bevel - case_thickness_bottom) {
                substract= 2 *(case_wall_seam_thickness + case_wall_seam_clearance);
                rounded_square([
                    outer_wall_size[0] - 2 * substract,
                    outer_wall_size[1] - 2 * substract],
                    1, true);
            }
        }
    }
}

module bottom_outer_wall() {
    union() {
        linear_extrude(seam_height) {
            rounded_square(outer_wall_size, wall_radius_outer, true);
        }
        linear_extrude(case_height) {
            substract= 2 * ( case_wall_seam_thickness + case_wall_seam_clearance);
            rounded_square(
                   [ outer_wall_size[0] - 2 * substract, 
                     outer_wall_size[1] - 2 * substract],
                   wall_radius_outer - substract,
                   true);
        }
        translate([0,0,case_wall_seam_height]) {
            linear_extrude(seam_height) {
                substract= (case_wall_seam_thickness + case_wall_seam_clearance);
                rounded_square([
                    outer_wall_size[0] - 2 * substract,
                    outer_wall_size[1] - 2 * substract],
                    wall_radius_outer - substract, true);
            }
        }
    }
}

module top_board_clearance() {
    substract= 2 * ( case_wall_seam_thickness + case_wall_seam_clearance);
    top_shape([pcb_board_dim[0], pcb_board_dim[1]], 0, 1, 
              case_height - case_thickness_top);
}

module bottom_board_clearance() {
    difference() {
        translate([0, 0, case_thickness_bottom]) {
            pcb_clearance_total = case_height;
            linear_extrude(pcb_clearance_total) {
                square([pcb_board_dim[0], pcb_board_dim[1]], true);
            }
        }
    }
}

module top_nuts_and_bolts_pos() {
    for (pcb_hole = pcb_holes) {
        pos        = pcb_hole[0];
        touch_wall = pcb_hole[1];
        top        = pcb_hole[3];
        if (top) {
            translate(pos) {
                top_nut_and_bolt_pos(touch_wall);
            }
        }
    }
}

module bottom_nuts_and_bolts_pos() {
    for (pcb_hole = pcb_holes) {
        pos        = pcb_hole[0];
        touch_wall = pcb_hole[1];
        bottom     = pcb_hole[2];
        if (bottom) {
            translate(pos) {
                bottom_nut_and_bolt_pos(touch_wall);
            }
        }
    }
}

module top_nuts_and_bolts_neg() {
    for (pcb_hole = pcb_holes) {
        pos        = pcb_hole[0];
        top        = pcb_hole[3];
        if (top) {
            translate(pos) {
                top_nut_and_bolt_neg();
            }
        }
    }
}

module top_nut_and_bolt_neg() {
    head_r  = inner_circle(bolt_head_size + bolt_head_size_toterance) / 2;
    shaft_r = inner_circle(bolt_shaft_size + bolt_shaft_size_tolerance) / 2;
    rotate_extrude() polygon([
        [0,       case_height + 1], 
        [head_r , case_height + 1],
        [head_r , case_height - bolt_depth], 
        [shaft_r, case_height - bolt_depth + (shaft_r-head_r)], 
        [shaft_r, -1], 
        [0,   -1]]);
}

module bottom_nuts_and_bolts_neg() {
    for (pcb_hole = pcb_holes) {
        pos        = pcb_hole[0];
        bottom     = pcb_hole[2];
        if (bottom) {
            translate(pos) {
                bottom_nut_and_bolt_neg();
            }
        }
    }
}

module top_nut_and_bolt_pos(touch_wall) {
    r = inner_circle(bolt_shaft_size + bolt_shaft_size_tolerance) / 2 
                + pilar_wall_thickness;
    h = 10;
    translate([0,0, h_top_pcb]) linear_extrude(case_height - h_top_pcb) {
        nut_and_bolt_pos(touch_wall, r, h);
    }
    head_r  = inner_circle(bolt_head_size + bolt_head_size_toterance) / 2 + pilar_wall_thickness;
    shaft_r = inner_circle(bolt_shaft_size + bolt_shaft_size_tolerance) / 2 + pilar_wall_thickness;
    rotate_extrude() polygon([
        [0,       case_height + 1], 
        [head_r , case_height + 1],
        [head_r , case_height - bolt_depth - sin(22.5) * pilar_wall_thickness], 
        [shaft_r, case_height - bolt_depth - sin(22.5) * pilar_wall_thickness + (shaft_r-head_r)], 
        [shaft_r, h_top_pcb], 
        [0,   h_top_pcb]]);
}

module bottom_nut_and_bolt_pos(touch_wall) {
    r = ((nut_type == NUT_TYPE_HEX)
        ? (nut_size+nut_size_tolerance_nut_type_hex) / cos(30) 
        : (nut_type == NUT_TYPE_INSERT) 
        ? (nut_size+nut_size_tolerance_nut_type_insert)
        : bolt_shaft_size) / 2 + pilar_wall_thickness;
    h=2 * (pcb_clearance_bottom + case_thickness_bottom);
    linear_extrude(h, center=true) {
        nut_and_bolt_pos(touch_wall, r, h);
    }
}

module nut_and_bolt_pos(touch_wall, r, h) {
    
    north = (floor(touch_wall / NORTH) % 2);
    east  = (floor(touch_wall / EAST ) % 2);
    south = (floor(touch_wall / SOUTH) % 2);
    west  = (floor(touch_wall / WEST ) % 2);

    hull() {
        circle(r);
        
        if (north) {
            translate([0, pcb_board_dim[1] *  2]) square(2*r, true);
        }
        if (east) {
            translate([pcb_board_dim[0] *  2, 0]) square(2*r, true);
        }
        if (south) {
            translate([0, pcb_board_dim[1] * -2]) square(2*r, true);
        }
        if (west) {
            translate([pcb_board_dim[0] * -2, 0]) square(2*r, true);
        }
    }
}

module bottom_nut_and_bolt_neg() {
    d=inner_circle(bolt_shaft_size+bolt_shaft_size_tolerance);
    if (nut_type != NUT_TYPE_NONE) {
        translate([0,0, nut_depth]) {
            if (nut_type == NUT_TYPE_HEX) {
                hull() {
                    eff_nut_size = nut_size
                        + nut_size_tolerance_nut_type_hex;
                    linear_extrude(2*nut_height, center=true) {
                        hex(size=eff_nut_size);
                    }
                    cylinder(d=d,
                         h=2*nut_height + (eff_nut_size - d) / 2, 
                         center=true);
                }
            } else if (nut_type == NUT_TYPE_INSERT) {
                hull() {
                    eff_nut_size = nut_size
                        + nut_size_tolerance_nut_type_insert;
                    linear_extrude(2*nut_height, center=true) {
                        circle(d=eff_nut_size);
                    }
                    cylinder(d=d,
                         h=2*nut_height + (eff_nut_size - d) / 2, 
                         center=true);
                }
            }
        }
    }
    translate([0,0,-.5])cylinder(
        d=(nut_type == NUT_TYPE_NONE)
           ? inner_circle(bolt_shaft_size+nut_size_tolerance_nut_type_none)
           : d,
        h=pcb_clearance_bottom + case_thickness_bottom + 1
    );
}

module bottom_montage_struts() {
    for (a = [0, 1], b = [0, 1]) mirror([a, 0]) mirror([0, b]) {
        translate([
             outer_wall_size[0] / 2 - strut_with / 2,
            -outer_wall_size[1] / 2 - inner_circle(screw_head_size) / 2 - strut_clearance[1]]
        ) bottom_montage_strut();
    }
}

module bottom_montage_strut() {
    difference() {
        hull() {
            translate([-strut_with/2,-inner_circle(screw_head_size) 
                / 2 - strut_clearance[1]]) 
            {
                cube([strut_with,20, 2]);
            }
            translate([-strut_with/2,inner_circle(screw_head_size) 
                / 2 - strut_clearance[1]]) 
            {
                cube([strut_with,20-strut_with, 6]);
            }
        }
        a = inner_circle(screw_head_size) + 2 * strut_clearance[0];
        translate([-a/2,-21/2,strut_bottom_thickness]) cube([a, 21,5]);
        translate([0,0,-.5]) {
            cylinder(d=inner_circle(screw_shaft_size),h=4);
        }
        translate([0,0,-1]) {
            cylinder(d1=0,
                     d2=inner_circle(screw_shaft_size) * 2,
                     h=strut_bottom_thickness + 1.1);
        }
    }
}

module top_shape(dim, r, bevel, h) {
    hull() {
        linear_extrude(h-bevel) {
            rounded_square(dim, r, true);
        }
        linear_extrude(h) {
            rounded_square([dim[0]-2*bevel, dim[1]-2*bevel], r, true);
        }
    }
}
