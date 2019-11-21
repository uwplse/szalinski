/*
 * Customizable Orchid Pot + Saucer - https://www.thingiverse.com/thing:3132496
 * by ASP3D - https://www.thingiverse.com/asp3d/about
 * created 2018-10-02
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0 - 2018-09-23:
 *  - [new] Initial release
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */


/* [Pot params] */

// Height of the pot
pot_height = 100;
// Bottom diameter of the pot
pot_bottom_diameter = 90;
// Bottom height
pot_bottom = 3;
// Wall width
pot_wall = 2;
// Pot side decoration
pot_decoration = 3; // [0:None (Solid pot),1:Squares,2:Curves,3:Double squares]
// What to render
render = 1; // [1:Assembly,2:Pot,3:Saucer,4:All parts]


/* [Saucer params] */
// Saucer height
saucer_height = 20;
// Saucer diameter will be larger by this value
saucer_bottom_diameter_addon = 10;
// Bottom height
saucer_bottom = 3;
// Wall width
saucer_wall = 2;
// Height of pot over saucer
saucer_to_pot_gap = 5;


/* [Additional params] */
// Top of the pot will be larger than bottom by this value
pot_top_diameter_addon = 25;
// Width of pot bottom holes
pot_bottom_holes_size = 5;
// Top of the saucer will be larger than bottom by this value
saucer_top_diameter_addon = 10;
// Count of stands for pot
saucer_pot_stands = 5;


/* [Hidden] */

saucer_bottom_diameter = pot_bottom_diameter + saucer_bottom_diameter_addon;

saucer_bottom_radius = saucer_bottom_diameter/2;
saucer_top_radius_addon = saucer_top_diameter_addon/2;
saucer_stand_wall = saucer_wall*4;

pot_bottom_radius = pot_bottom_diameter/2;
pot_top_radius_addon = pot_top_diameter_addon/2;
pot_bottom_holes_r1 = pot_bottom_radius * 0.4;
pot_bottom_holes_r2 = pot_bottom_radius * 0.8;
pot_bottom_holes_count = floor((3.14*(pot_bottom_holes_r1*2) / pot_bottom_holes_size)*0.5);



if (render == 1) {
    saucer_3d();
    translate([0, 0, saucer_bottom + saucer_to_pot_gap])
        pot_3d();
} else if (render == 2) {
    saucer_3d();
} else if (render == 3) {
    pot_3d();
} else if (render == 4) {
    saucer_3d();
    translate([saucer_bottom_radius * 3, 0, 0])
        pot_3d();
}


module saucer_3d() {
    difference() {
        saucer_cut_outer_3d();
        saucer_cut_inner_3d();        
    }
    difference() {
        intersection() {
            union() {
                for (i = [0:saucer_pot_stands-1]) {
                    rotate([0, 0, i*360/saucer_pot_stands])
                        saucer_stand_3d();   
                }
            }
            saucer_cut_outer_3d();
        }
        k = pot_bottom_diameter/saucer_bottom_diameter * 1.02;
        translate([0, 0, saucer_bottom + saucer_to_pot_gap])
            scale([k, k, 1])
                saucer_cut_outer_3d();
        translate([0, 0, saucer_bottom])
            scale([0.5, 0.5, 1])
                saucer_cut_outer_3d();
    }
}

module saucer_stand_3d() {
    translate([0, -saucer_stand_wall/2, 0])
        linear_extrude(saucer_height)
            square([saucer_bottom_diameter + saucer_top_diameter_addon, saucer_stand_wall]);
}

module saucer_cut_outer_3d() {
    cylinder(h=saucer_height, r1 = saucer_bottom_radius, r2 = saucer_bottom_radius + saucer_top_radius_addon, $fa=1);
}

module saucer_cut_inner_3d() {
    translate([0, 0, pot_bottom])
        cylinder(h=saucer_height, r1 = saucer_bottom_radius - saucer_wall, r2 = saucer_bottom_radius + saucer_top_radius_addon - saucer_wall, $fa=1);
}

module pot_3d() {
    difference() {
        pot_base_3d();
        if (pot_decoration == 1) {
            pot_decor_1_3d();
        } else if (pot_decoration == 2) {
            pot_decor_2_3d();
        } else if (pot_decoration == 3) {
            pot_decor_3_3d();
        }
    }
}

module pot_decor_1_3d() {
    n = 10;
    h = (pot_height - saucer_height) * 0.5;
    for (i = [0:n-1]) {
        translate([0, 0, saucer_height])
            rotate([0, 0, i*360/n])
                rotate([45, 0, 0])
                    translate([0, -saucer_stand_wall/2, 0])
                        linear_extrude(h)
                            square([saucer_bottom_diameter + saucer_top_diameter_addon, 4]);  
    }
}

module pot_decor_2_3d() {
    n = 10;
    h = (pot_height - saucer_height) * 0.90;
    for (i = [0:n-1]) {
        translate([0, 0, saucer_height])
            rotate([0, 0, i*360/n])
                rotate([-45, 0, 0])
                    translate([0, -saucer_stand_wall/2, 0])
                        linear_extrude(h)
                            square([saucer_bottom_diameter + saucer_top_diameter_addon, 4]);  
    }
}

module pot_decor_3_3d() {
    n = 10;
    h = (pot_height - saucer_height) * 0.5;
    for (i = [0:n-1]) {
        translate([0, 0, saucer_height])
            rotate([0, 0, i*360/n])
                rotate([45, 0, 0])
                    translate([0, -saucer_stand_wall/2, 0])
                        linear_extrude(h)
                            square([saucer_bottom_diameter + saucer_top_diameter_addon, 4]);
        translate([0, 0, saucer_height + h*0.8])
            rotate([0, 0, (i+0.65)*360/n])
                rotate([-45, 0, 0])
                    translate([0, -saucer_stand_wall/2, 0])
                        linear_extrude(h)
                            square([saucer_bottom_diameter + saucer_top_diameter_addon, 4]);  
    }
}

module pot_base_3d() {
    holes_r1 = pot_bottom_holes_r1;
    holes_r2 = pot_bottom_holes_r2;
    difference() {
        cylinder(h=pot_height, r1 = pot_bottom_radius, r2 = pot_bottom_radius + pot_top_radius_addon, $fa=1);
        translate([0, 0, pot_bottom])
            cylinder(h=pot_height, r1 = pot_bottom_radius - pot_wall, r2 = pot_bottom_radius + pot_top_radius_addon - pot_wall, $fa=1);
        for (i = [0:pot_bottom_holes_count-1]) {
            rotate([0, 0, i*360/pot_bottom_holes_count])
                translate([holes_r1, -pot_bottom_holes_size/2, -1])
                    linear_extrude(pot_bottom + 2)
                        union() {
                            square([holes_r2-holes_r1, pot_bottom_holes_size]);
                            translate([0, pot_bottom_holes_size/2, 0])
                                circle(pot_bottom_holes_size/2, $fn=30);
                            translate([holes_r2 - holes_r1, pot_bottom_holes_size/2, 0])
                                circle(pot_bottom_holes_size/2, $fn=30);
                        }
        }
    }
}
