
/*
v2 adds a 2nd and 3rd spool diameter, fa/fs instead of fn
*/

$fa = .5;
$fs = .5;

part_to_generate = 3; // 1=top, 2=bottom, 3=both

test = 0;

//CUSTOMIZER VARIABLES

spool_hole_diameter = 32 ; // inside diameter of actual spool hole
spool_hole_diameter2 = 42 ; // inside diameter of actual spool hole
spool_hole_diameter3 = 52 ; // inside diameter of actual spool hole

hub_nub_slop = .5; // how much horizontal space (tolerance) to leave between spinner and spool
support_flange_extension = 18; // how much the rim that supports the spool should overlap with the spool

bearing_diameter = 4.5; // the size of BBs/marbles/etc. that you will be using
bearing_channel_width_slop = .3; // how much wider than the bearing diameter the channel should be
bearing_channel_extra_depth = 5; // how deep to make the groove that the bearings sit in, beyond the size of the bearing
bearing_tongue_slop = .6; // how much narrower than bearing diameter the part that rides on top of the bearings should be
bearing_loading_well_depth = 1; // how much lower the inside of the base is than the outer wall so bearings are easier to load

wall_thickness = 1.2; // your slicer setting; used for parts that only need to be (double) walls

part_clearance = 1.2; // space to leave between the two pieces so they don't rub

container_height = 78; // inside height of the spool container, used for creating support stalk, if set, overall height will equal this
stalk_diameter = 8; // size of the part that sticks up solely to keep the container lid from pressing down on spool
stalk_slop = .8; // how much space to leave between stalk (which is part of the bottom base) and the edges of the hole in the spinning top part so it slips over and doesn't rub

//CUSTOMIZER VARIABLES END

// spinner brace hole is 70mm across

// GENERATED VARS -- DO NOT CHANGE THESE

// how far over to put the second piece in the drawing
separation = test == 1 ? 0 : 2.1* (spool_hole_diameter/2 + support_flange_extension); 

base_flange_radius = spool_hole_diameter/2 + support_flange_extension;
base_body_radius = spool_hole_diameter/2 - hub_nub_slop - 2*wall_thickness - part_clearance;
base_channel_inside_of_outer_wall_radius = base_body_radius - 2*wall_thickness;
base_channel_outside_of_inner_wall_radius = base_channel_inside_of_outer_wall_radius - bearing_diameter - bearing_channel_width_slop;

base_flange_height = wall_thickness*2;
base_body_height = bearing_diameter + bearing_channel_extra_depth;

spinner_flange_radius = base_flange_radius;

spinner_stalk_hole_radius = stalk_diameter/2 + stalk_slop;
spinner_body_radius = spool_hole_diameter/2 - hub_nub_slop;
spinner_body_radius2 = spool_hole_diameter2/2 - hub_nub_slop;
spinner_body_radius3 = spool_hole_diameter3/2 - hub_nub_slop;
spinner_body_inside_wall_radius = spinner_body_radius - 2*wall_thickness;

spinner_tongue_outer_wall_diameter = base_channel_inside_of_outer_wall_radius - bearing_tongue_slop;
spinner_tongue_inner_wall_diameter = base_channel_outside_of_inner_wall_radius + bearing_tongue_slop;

spinner_flange_height = base_flange_height;
spinner_top_height = spinner_flange_height;

spinner_body_height = bearing_diameter + bearing_channel_extra_depth - base_flange_height ;
spinner_tongue_height = bearing_channel_extra_depth + part_clearance;

if ( part_to_generate == 1 ) {
    spinner();
} else if ( part_to_generate == 2 ) {
    base();
} else if ( test == 1 ) {
    difference() { union() {
        translate([0,0,spinner_flange_height+spinner_body_height+spinner_top_height+base_flange_height+part_clearance]) rotate([180,0,0]) spinner();
        base(); } cube([base_flange_radius,base_flange_radius,container_height]); }
} else {
    spinner();
    base();
}

module spinner() {
    
    // SPINNER TOP PIECE -- upside down

    // top layer
    difference () {
        cylinder(h=spinner_top_height, r=spinner_body_radius);
        // hole for stalk
        cylinder(h=spinner_top_height, r=spinner_stalk_hole_radius);
    }

    translate([0,0,spinner_top_height]) {
        // outer wall
        difference () {
            union() {
                cylinder(h=spinner_body_height, r=spinner_body_radius);
                translate([0,0,spinner_body_height-2*wall_thickness]) cylinder(h=2*wall_thickness, r=spinner_body_radius2);
                translate([0,0,spinner_body_height-wall_thickness]) cylinder(h=wall_thickness, r=spinner_body_radius3);
            }
            cylinder(h=spinner_body_height, r=spinner_body_inside_wall_radius);
        }
        // tongue
        difference () {
            cylinder(h=spinner_tongue_height, r=spinner_tongue_outer_wall_diameter);
            cylinder(h=spinner_tongue_height, r=spinner_tongue_inner_wall_diameter);
        }
    }

    // flange
    translate([0,0,spinner_top_height + spinner_body_height]) {
        difference () {
            cylinder(h=spinner_flange_height, r=spinner_flange_radius);
            cylinder(h=spinner_flange_height, r=spinner_body_inside_wall_radius);
        }
    }

}

module base() {

    // BASE BOTTOM PIECE

    translate([separation,0,0]) {

        // bottom layer including flange
        cylinder(h=base_flange_height, r=base_flange_radius);

        translate([0,0,base_flange_height]) {
            difference () {
                // nub main
                cylinder(h=base_body_height, r=base_body_radius );

                // bearing channel
                cylinder(h=base_body_height, r=base_channel_inside_of_outer_wall_radius);
            }

            // inside bearing channel
            cylinder(h=base_body_height - bearing_loading_well_depth, r=base_channel_outside_of_inner_wall_radius);
        }

        // stalk
        cylinder(h=container_height, r=stalk_diameter/2);
    }

}




