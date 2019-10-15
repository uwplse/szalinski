// Which one would you like to see?
part = "full_model"; // [full_model:iPhone+Apple Watch+Airpods,no_airpods:iPhone+Apple Watch only,airpods_only:Airpods only,cable_tester:Cable size tester,phone_tester:Phone positioning tester,puck_tester:Apple Watch charging puck tester]


/* [Phone Holder] */

// Phone charging cable plug size in the long dimension (Stock Apple cable = 8mm / Anker Powerline = 10.5mm)
phone_plug_size_long=8;

// Phone charging cable plug size in the short dimension (Stock Apple cable = 5.6mm / Anker Powerline = 6mm)
phone_plug_size_short=5.6;

// Distance from the back of the phone platform to the middle of the charging plug hole (Stock iPhone 6 Plus: 4.8mm, also works with small case)
platform_charger_from_back=4.8;

// Some cases (e.g. Otterbox) have a charging port cover which flips behind the phone. Enable this to make a cutout in the back plate for the flap. Note: I would recommend that you also increase Phone Support Thickness in the Advanced Parameters tab to add more support
enable_phone_support_cutout="no"; // [yes,no]
phone_support_cutout_width=35;
phone_support_cutout_height=20;

// Thickness of the support wall behind the phone
phone_support_thickness=10; // [5:50]


/* [Airpods Holder] */

// Airpods charging cable plug size in the long dimension (Stock Apple cable = 8mm / Anker Powerline = 10.5mm)
airpods_plug_size_long=8;

// Phone charging cable plug size in the short dimension (Stock Apple cable = 5.6mm / Anker Powerline = 6mm)
airpods_plug_size_short=5.6;


/* [Advanced Parameters - Modify if you dare] */

// Height of the base
base_height=15; // [10:20]

// Diameter of the center potion that the watch goes around
center_outside_diameter=55; // [45:65]

// Total height of the model - changes size of wall behind the phone
center_height=80; // [60:100]

// Angle of the phone platform (in degrees)
phone_platform_angle=10; // [0:20]

// Depth of the phone platform
phone_platform_depth=20; // [20:30]

// Gap above the puck/below the phone platform - measured from the height of the corner of the phone platform
phone_platform_gap=2; // [-2:10]

// How far the upper watch strap platform is raised above the lower platform
watch_strap_raised=5; // [5:8]

// Width of the channel for watch straps - increase if you have fat watch straps
watch_strap_gap=8; // [8:16]

// Width of the wall to the left and right of the watch strap - works best if this matches the Airpods wall width
watch_strap_wall_width=4; // [0:8]

// Height of the wall to the left and right of the watch strap
watch_strap_wall_height=10; // [0:20]

// Diameter for the watch charging puck
puck_diameter=28.4;

// The gap below the watch charging puck (how far the puck sits above the base)
puck_bottom_gap=5; // [5:20]

// Width of the Airpods case
airpod_case_x=44.3;

// Depth of the Airpods case
airpod_case_y=21.3;

// Height of the Airpods case. The surround will be 1/2 this height
airpod_case_z=53.5;

//
airpods_holder_base=35;

// Smoothness of curves
smoothness=100; // [30:150]


/* [Hidden] */

$fn=smoothness;

watch_strap_raised_corner_diameter=watch_strap_raised+watch_strap_wall_height;

base_outside=center_outside_diameter+watch_strap_gap*2+watch_strap_wall_width*2;

puck_hole_depth=8;
puck_cable_diameter=6;
puck_cable_gap=1; // Distance of the puck from the front of the hole
puck_cable_tunnel_width=puck_cable_diameter-2;
puck_cable_center=-center_outside_diameter/2+puck_cable_diameter/2+puck_cable_gap;

puck_small_diameter=20; // Small hole within the larger puck hole

platform_height=base_height+puck_bottom_gap+puck_diameter+phone_platform_gap;

main_cable_tunnel_x=25;
main_cable_tunnel_y=base_outside/2+2;
main_cable_tunnel_gap=3;
main_cable_tunnel_z=base_height-main_cable_tunnel_gap*2+watch_strap_raised;


// Airpods
airpods_cable_tunnel_x=15;

surround_gap=4;
surround_x=airpod_case_x+surround_gap*2;
surround_y=airpod_case_y+surround_gap*2;
surround_z=airpod_case_z/2+airpods_holder_base;

grabber_slot_width=20;
grabber_slot_depth=20;
grabber_slot_corner_radius=4;


if (part == "puck_tester") {
    puck_tester();
} else if (part == "cable_tester") {
    cable_tester();
} else if (part == "phone_tester") {
    phone_tester();
} else if (part == "no_airpods") {
    draw_stand();
} else if (part == "airpods_only") {
    draw_airpods();
} else {
    union() {
        draw_airpods_for_full();
        draw_stand();
    }
}


// Puck tester
// Used to test the fit and positioning of the Apple Watch charging puck
module puck_tester() {
    intersection() {
        translate([-puck_diameter/2-5,-center_outside_diameter/2,0]) cube([puck_diameter+10,puck_hole_depth+5,puck_diameter+10]);
        difference() {
            // Main cylinder
            cylinder(d=center_outside_diameter,h=puck_diameter+10);
            
            //  Puck hole
            translate([0,-center_outside_diameter/2+puck_hole_depth,puck_diameter/2+5]) rotate([90,0,0]) cylinder(d=puck_diameter,h=puck_hole_depth);
                
            // Puck cable hole
            translate([0,puck_cable_center,0]) cylinder(d=puck_cable_diameter,h=puck_diameter);
            
            // Watch charger small cutout
            translate([0,0,puck_small_diameter/2+5]) rotate([90,0,0]) cylinder(d=puck_small_diameter,h=base_outside);
                
            // Tunnel to watch charger cable
            translate([-puck_cable_tunnel_width/2,puck_cable_center,0]) cube([puck_cable_tunnel_width,-puck_cable_center,base_height+puck_bottom_gap]);
        }
    }
}

// Cable tester
// Used to test the cable hole size
module cable_tester() {
    plug_tester_width=phone_plug_size_long+10;
    plug_tester_back_z=20;
    plug_tester_base_z=10;
    difference() {
        translate([-plug_tester_width/2,0,0]) cube([plug_tester_width,phone_plug_size_short+10,plug_tester_base_z]);
            
        // Cable hole
        translate([(phone_plug_size_short-phone_plug_size_long)/2,phone_plug_size_short/2+5,0]) hull() {
            cylinder(d=phone_plug_size_short, h=plug_tester_base_z);
            translate([phone_plug_size_long-phone_plug_size_short,0,0]) cylinder(d=phone_plug_size_short, h=plug_tester_base_z);
        }
    }
}

// Phone tester
// Used to test the positioning of the phone on the platform
module phone_tester() {
    // If we have a cutout, need to accomodate
    phone_tester_width = (enable_phone_support_cutout == "yes")? max(phone_plug_size_long,phone_support_cutout_width)+10 : phone_plug_size_long+10;
    phone_tester_back_z = (enable_phone_support_cutout == "yes")? max(phone_support_cutout_height,10)+10 : 20;

    phone_tester_base_z=10;
    difference() {
        translate([-phone_tester_width/2,0,0]) cube([phone_tester_width,5+phone_plug_size_short/2+platform_charger_from_back+10,phone_tester_base_z+phone_tester_back_z]);
        translate([-phone_tester_width/2,0,phone_tester_base_z]) cube([phone_tester_width,5+phone_plug_size_short/2+platform_charger_from_back,phone_tester_back_z]);
            
        // Cable hole
        translate([(phone_plug_size_short-phone_plug_size_long)/2,5+phone_plug_size_short/2,0]) hull() {
            cylinder(d=phone_plug_size_short, h=phone_tester_base_z);
            translate([phone_plug_size_long-phone_plug_size_short,0,0]) cylinder(d=phone_plug_size_short, h=phone_tester_base_z);
        }
        
        // Cutout
        if (enable_phone_support_cutout == "yes") {
              translate([-phone_support_cutout_width/2,5+phone_plug_size_short/2+platform_charger_from_back,phone_tester_base_z]) cube([phone_support_cutout_width,phone_support_thickness,phone_support_cutout_height]);
        }
    }
}

// Main stand
module draw_stand() {
    difference() {
        union() {
            // Center and base
            difference() {
                union() {
                    // Base
                    cylinder(d=base_outside,h=base_height);
                    // Center
                    cylinder(d=center_outside_diameter,h=center_height+base_height);
                }
                
                // Phone platform
                translate([0,-center_outside_diameter/2+phone_platform_depth,platform_height]) rotate([-phone_platform_angle,0,0]) {
                    // Area where phone goes
                    translate([-center_outside_diameter/2,-center_outside_diameter,0]) cube([center_outside_diameter,center_outside_diameter,center_height]);
                    
                    // Area behind phone
                    translate([-center_outside_diameter/2,phone_support_thickness,0]) cube([center_outside_diameter,center_outside_diameter,center_height]);
                    
                    // Phone support cutout
                    if (enable_phone_support_cutout == "yes") {
                        translate([-phone_support_cutout_width/2,0,0]) cube([phone_support_cutout_width,phone_support_thickness,phone_support_cutout_height]);
                    }
                    
                    // Cable hole
                    translate([(phone_plug_size_short-phone_plug_size_long)/2,-platform_charger_from_back,-phone_platform_gap-puck_diameter/2]) hull() {
                        cylinder(d=phone_plug_size_short, h=phone_platform_gap+puck_diameter/2);
                        translate([phone_plug_size_long-phone_plug_size_short,0,0]) cylinder(d=phone_plug_size_short, h=phone_platform_gap+puck_diameter/2);
                    }
                }
                
            }

            // Strap wall and raised
            difference() {
                union() {
                    // Strap Wall
                    difference() {
                        cylinder(d=base_outside,h=base_height+watch_strap_raised+watch_strap_wall_height);
                        cylinder(d=base_outside-watch_strap_wall_width*2,h=base_height+watch_strap_raised+watch_strap_wall_height+1);
                    }
                    // Raised
                    cylinder(d=base_outside,h=base_height+watch_strap_raised);
                }
                
                // Front right wall curve
                translate([0,0,watch_strap_raised_corner_diameter/2+base_height]) rotate([90,0,45]) small_s(watch_strap_raised_corner_diameter);
                
                // Front left wall curve
                translate([0,0,watch_strap_raised_corner_diameter/2+base_height]) rotate([90,0,-45]) mirror([1,0,0]) small_s(watch_strap_raised_corner_diameter);
                
                // Front cutout
                translate([0,0,base_height]) rotate([0,0,-135]) cube([base_outside,base_outside,watch_strap_raised+watch_strap_wall_height+1]);
                
                // Back cutout
                translate([0,0,base_height+watch_strap_raised]) rotate([0,0,45]) cube([base_outside,base_outside,watch_strap_wall_height+1]);
                
                // Back left wall curve
                translate([0,0,watch_strap_wall_height/2+base_height+watch_strap_raised]) rotate([90,0,-135]) small_s(watch_strap_wall_height);
                
                // Back right wall curve
                translate([0,0,watch_strap_wall_height/2+base_height+watch_strap_raised]) rotate([90,0,135]) mirror([1,0,0]) small_s(watch_strap_wall_height);

            }
        }
        
                
        // Watch charger large cutout
        translate([0,-center_outside_diameter/2+puck_hole_depth,puck_diameter/2+base_height+puck_bottom_gap]) rotate([90,0,0]) cylinder(d=puck_diameter,h=base_outside);
                
        // Watch charger small cutout
        translate([0,0,puck_small_diameter/2+base_height+puck_bottom_gap]) rotate([90,0,0]) cylinder(d=puck_small_diameter,h=base_outside);
                
        // Watch charger big cable
        translate([0,puck_cable_center,main_cable_tunnel_gap]) cylinder(d=puck_cable_diameter,h=base_height+puck_bottom_gap+puck_diameter/2);
                
        // Tunnel to watch charger cable
        //translate([-puck_cable_tunnel_width/2,puck_cable_center,main_cable_tunnel_gap]) cube([puck_cable_tunnel_width,-puck_cable_center,base_height+puck_bottom_gap]);
                
        // Inner main cutout
        inner_space_x=center_outside_diameter-puck_hole_depth*2+4;//main_cable_tunnel_x*1.5;
        inner_space_y=center_outside_diameter/2-puck_hole_depth;
        inner_space_z=base_height+puck_bottom_gap+puck_small_diameter;
        translate([0,0,-1]) cylinder(d=inner_space_x,h=inner_space_z+1);
        //translate([-inner_space_x/2,-inner_space_y,2]) cube([inner_space_x,inner_space_y,inner_space_z+1]);
        
        // Main cable tunnel
        translate([-main_cable_tunnel_x/2,-1,main_cable_tunnel_gap]) cube([main_cable_tunnel_x,main_cable_tunnel_y,main_cable_tunnel_z]);
        
        // Right cable tunnel to Airpods
        rotate([0,0,-65]) translate([-airpods_cable_tunnel_x/2,-1,main_cable_tunnel_gap]) cube([airpods_cable_tunnel_x,main_cable_tunnel_y,main_cable_tunnel_z]);
    }
}

module draw_airpods_for_full() {
    rotate([0,0,25]) translate([airpod_case_x/2+base_outside/2,0,0]) draw_airpods();
}
module draw_airpods() {
    difference() {
        // Surround
        union() {
            // Square part
            //translate([-surround_y+surround_gap,-surround_y/2,0]) cube([surround_y,surround_y,base_height+watch_strap_raised+watch_strap_wall_height]);
            
            // Double cylinders
            translate([(surround_y-surround_x)/2,0,0]) hull() {
                cylinder(d=surround_y, h=surround_z);
                translate([surround_x-surround_y,0,0]) cylinder(d=surround_y, h=surround_z);
            }
        }

        // Airpod case size
        translate([-(airpod_case_x-airpod_case_y)/2,0,airpod_case_y/2+airpods_holder_base]) hull() {
            hull() {
                sphere(d=airpod_case_y);
                translate([airpod_case_x-airpod_case_y,0,0]) sphere(d=airpod_case_y);
            }
            hull() {
                translate([0,0,airpod_case_z-airpod_case_y]) sphere(d=airpod_case_y);
                translate([airpod_case_x-airpod_case_y,0,airpod_case_z-airpod_case_y]) sphere(d=airpod_case_y);
            }
        }
        
        // Grabber slot
        difference() {
            translate([-grabber_slot_width/2,-surround_y/2+-1,surround_z-grabber_slot_depth]) cube([grabber_slot_width,surround_y+2,grabber_slot_depth+1]);
            
            // Grabber slot bottom-left corner
            translate([-grabber_slot_width/2+grabber_slot_corner_radius,-surround_y/2-1,surround_z+grabber_slot_corner_radius-grabber_slot_depth]) rotate([-90,90,0]) difference() {
                cube([grabber_slot_corner_radius,grabber_slot_corner_radius,surround_y+2]);
                cylinder(d=grabber_slot_corner_radius*2,h=surround_y+2);
            }
            
            // Grabber slot bottom-right corner
            translate([+grabber_slot_width/2-grabber_slot_corner_radius,-surround_y/2-1,surround_z+grabber_slot_corner_radius-grabber_slot_depth]) rotate([-90,0,0]) difference() {
                cube([grabber_slot_corner_radius,grabber_slot_corner_radius,surround_y+2]);
                cylinder(d=grabber_slot_corner_radius*2,h=surround_y+2);
            }
        }
        
        // Grabber slot top-left corner
        translate([-grabber_slot_width/2-grabber_slot_corner_radius,surround_y/2+1,surround_z-grabber_slot_corner_radius]) rotate([90,0,0]) difference() {
            cube([grabber_slot_corner_radius+1,grabber_slot_corner_radius+1,surround_y+2]);
            cylinder(d=grabber_slot_corner_radius*2,h=surround_y+2);
        }
        
        // Grabber slot rop-right corner
        translate([+grabber_slot_width/2+grabber_slot_corner_radius,surround_y/2+1,surround_z-grabber_slot_corner_radius]) rotate([90,-90,0]) difference() {
            cube([grabber_slot_corner_radius+1,grabber_slot_corner_radius+1,surround_y+2]);
            cylinder(d=grabber_slot_corner_radius*2,h=surround_y+2);
        }
        
        // Cable hole
        translate([(airpods_plug_size_short-airpods_plug_size_long)/2,0,-1]) hull() {
            cylinder(d=airpods_plug_size_short, h=airpods_holder_base+20);
            translate([airpods_plug_size_long-airpods_plug_size_short,0,0]) cylinder(d=airpods_plug_size_short, h=airpods_holder_base+20);
        }
        
        // Cable tunnel to main body
        if (part == "airpods_only") {
            // Airpods only, cable goes out the back
            rotate([0,0,-90]) translate([-(surround_x/2+1),-airpods_cable_tunnel_x/2,main_cable_tunnel_gap]) cube([surround_x/2+1,airpods_cable_tunnel_x,main_cable_tunnel_z]);
        } else {
            // Full model, cable goes out the side
            translate([-(surround_x/2+1),-airpods_cable_tunnel_x/2,main_cable_tunnel_gap]) cube([surround_x/2+1,airpods_cable_tunnel_x,main_cable_tunnel_z]);
        }
        
        // Center cutout
        hull() {
            cylinder(d=airpod_case_y,h=main_cable_tunnel_z+main_cable_tunnel_gap);
            if (part != "airpods_only") {
                translate([-airpod_case_x/2+airpod_case_y/2,0,0]) cylinder(d=airpod_case_y,h=main_cable_tunnel_z+main_cable_tunnel_gap);
            }
        }
    }
}



// Helper to create curves
module small_s(size=5) {
    difference() {
        union() {
            cylinder(d=size,h=base_outside);
            cube([size,size,base_outside]);
        }
        translate([size,0,-1]) cylinder(d=size,h=base_outside+2);
    }
}
