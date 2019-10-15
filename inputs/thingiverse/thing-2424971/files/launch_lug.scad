// Parametric Laungh Guide created by Nick Estes <nick@nickstoys.com>
// Released under a Creative Commons, share alike, attribution license

//rocket_diameter = 73; // pringles
rocket_diameter = 105; // mosquito
length = 150;

guide_offset = 0;

rail = false;

rail_tab_width = 10;
rail_slot_width = 6;
rail_guide_height = 4.5;
rail_guide_thickness = 1.3;
    
rod_diameter = 4/16*25.4;
//rod_guide_thickness = 1;
rod_guide_thickness = 1.5;
rod_guide_length = 12;

base_width = 20;
//base_thickness = 1.3;
base_thickness = 2;

rod_guide_slop = 1.5;

$fa=.2;
$fs=.2;

rocket_radius = rocket_diameter/2;


module base() {
    translate([-rocket_radius-base_thickness/2,0,0]) intersection() {
        difference() {
            cylinder(length, r=rocket_radius+base_thickness);
            translate([0,0,-.5]) cylinder(length+1, r=rocket_radius);
        }
        translate([0,-base_width/2,0]) cube([rocket_radius*2+5, base_width, length]);
    }
}

module rod_guides() {
    rod_guide_radius = rod_diameter/2+rod_guide_slop/2;
    rod_guide_radius_outer = rod_guide_radius+rod_guide_thickness;
    cut_length = length - rod_guide_length*2 - (guide_offset+rod_guide_radius_outer*2-rod_guide_thickness)*2;
    cut_cube_side = sqrt(cut_length*cut_length/2);

    difference() {
        union() {
            translate([0,-rod_guide_radius_outer,0]) cube([base_thickness/2+guide_offset+rod_guide_radius, rod_guide_radius_outer*2,length]);
            translate([base_thickness/2+guide_offset+rod_guide_radius,0,0]) cylinder(length, r=rod_guide_radius_outer);
        }
        translate([base_thickness/2+guide_offset+rod_guide_radius,0,-.5]) cylinder(length+1, r=rod_guide_radius);
        translate([base_thickness/2+guide_offset+rod_guide_radius_outer*2-rod_guide_thickness,0,length/2]) rotate([0,45,0]) cube(cut_cube_side, true);
    }
}

module rail_guide() {
    difference() {
        translate([0,-rail_tab_width/2,0]) cube([base_thickness/2+guide_offset+rail_guide_height+rail_guide_thickness, rail_tab_width, length]);
        
        cut_width = rail_slot_width-rail_guide_thickness*2;
        translate([base_thickness/2+cut_width/2+guide_offset,0,-.5]) cylinder(length+1, r=cut_width/2);
        translate([base_thickness/2+guide_offset+cut_width/2, -cut_width/2, -.5]) cube([rail_guide_height+rail_guide_thickness+5, cut_width, length+1]);
        edge_cut_width = (rail_tab_width-rail_slot_width)/2;
        translate([rail_guide_height/2+base_thickness/2+guide_offset,edge_cut_width/2+rail_slot_width/2+.5,length/2]) cube([rail_guide_height, edge_cut_width+1, length+1], true);
        translate([rail_guide_height/2+base_thickness/2+guide_offset,-(edge_cut_width/2+rail_slot_width/2+.5),length/2]) cube([rail_guide_height, edge_cut_width+1, length+1], true);
    }
}

union() {
    base();
    difference() {
        if (rail)
            rail_guide();
        else
            rod_guides();
        rotate([0,-45,0]) translate([0,-50, -100]) cube([100,100,100]);
        translate([0,0,length]) rotate([0,-45,0]) translate([0,-50, -100]) cube([100,100,100]);
    }
}
