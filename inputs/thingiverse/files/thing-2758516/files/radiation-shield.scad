///////////////////////////////////////////////////////////////////////////////////
//
// weather station radiation shield
//
///////////////////////////////////////////////////////////////////////////////////
$fs=1;
$fa=1;

fudge = 0.1;

shield_layer_d1 = 90;
shield_layer_d2 = 70;
shield_layer_h = 10;
shield_layer_t = 2;

number_of_mounts = 3;
number_of_middle_layers = 6; //This is used when rendering the full radiation shield

mount_guide_id = 6.85;
mount_guide_od = mount_guide_id+(shield_layer_t*2);

center_opening_d = 30;

base_t = 3;

sensor_mount_lock_screw_d = 2.95;
sensor_mount_lock_screw_holder_h = 4;

mounting_pipe_l = 30;
//A standard 3/4" PVC pipe inside diameter is 0.824 in or 20.93 mm, so I made this 
//slightly smaller so it would fit inside the 3/4" pipe
mounting_pipe_od = 20.25; 
//This will give us a 6.25 mm or ~1/4 in wall thickness for the attachment nipple
//which will give it good strength.
mounting_pipe_id = 14;

pcb_shroud_h = 45;

pcb_mount_peg_h = 15;
pcb_mount_peg_d = 4;
pcb_screw_hole_d = 1;

bottom_cover_screw_post_d = 7;
bottom_cover_screw_post_h = 17;
bottom_cover_screw_hole_d = 3;
bottom_cover_screw_head_d = 8;
bottom_cover_screw_head_t = 2.75;
bottom_cover_t = 4;

sensor_mount_peg_height = 15;
sensor_l = 16;
sensor_w = 8;
sensor_h = 25;
sensor_mount_hole_h = 22.5;
sensor_connector_dist = 2; //Distance from the sensor edge to the connection pins
sensor_connector_pin_h = 8;
sensor_connector_pin_w = 10;
tier_1_h = 15;
tier_2_h = 25;
wire_strap_hole_h = 4;
wire_strap_hole_w = 9;

//Here we define what we want to view
// available options are: top_layer, middle_layer, sensor_mount, base, bottom_cover, dht22_mount, all
view = "dht22_mount";

module top_layer() {
    difference() {
        union() {
            difference() {
                cylinder(h=shield_layer_h, d1=shield_layer_d1, d2=shield_layer_d2);
                translate([0, 0, -(fudge/2)]) {
                    cylinder(h=shield_layer_h-shield_layer_t+(fudge/2), d1=shield_layer_d1-(shield_layer_t/2), d2=shield_layer_d2-(shield_layer_t/2));
                }
            } 
            for(i=[1:number_of_mounts]) {
                rotate(a=(i*360/number_of_mounts), v=[0, 0, 1]) {
                    translate([(shield_layer_d2/2)-(mount_guide_od/1.25), 0, 0]) {
                        cylinder(h=shield_layer_h, d=mount_guide_od);
                    }
                }
            }
        }
        for(i=[1:number_of_mounts]) {
            rotate(a=(i*360/number_of_mounts), v=[0, 0, 1]) {
                translate([(shield_layer_d2/2)-(mount_guide_od/1.25), 0, -(fudge/2)]) {
                    cylinder(h=shield_layer_h-shield_layer_t, d=mount_guide_id-2);
                }
            }
        }
    }
}

module middle_layer() {
    difference() {
        top_layer();
        cylinder(h=shield_layer_h+fudge, d=center_opening_d);
        for(i=[1:number_of_mounts]) {
            rotate(a=(i*360/number_of_mounts), v=[0, 0, 1]) {
                translate([(shield_layer_d2/2)-(mount_guide_od/1.25), 0, -(fudge/2)]) {
                    cylinder(h=shield_layer_h+fudge, d=mount_guide_id);
                }
            }
        }
    }
}

module sensor_mount() {
    difference() {
        union() {
            translate([0, 0, shield_layer_h-shield_layer_t]) {
                cylinder(h=shield_layer_t, d=shield_layer_d2);
            }
            for(i=[1:number_of_mounts]) {
                rotate(a=(i*360/number_of_mounts), v=[0, 0, 1]) {
                    translate([(shield_layer_d2/2)-(mount_guide_od/1.25), 0, 0]) {
                        cylinder(h=shield_layer_h, d=mount_guide_od);
                    }
                }
            }
            translate([0, 0, -base_t]) {
                cylinder(h=shield_layer_h+base_t, d=center_opening_d);
            }
            translate([-(center_opening_d/2)+shield_layer_t-sensor_mount_lock_screw_holder_h, 0, (sensor_mount_lock_screw_d*2.5)/2]) {
                rotate([0, 90, 0]) {
                    cylinder(h=sensor_mount_lock_screw_holder_h, d=sensor_mount_lock_screw_d*2.5);
                }
            }
        }
        translate([0, 0, -base_t-(fudge/2)]) {
            cylinder(h=shield_layer_h+base_t+fudge, d=center_opening_d-(shield_layer_t*2));
        }
        translate([-(center_opening_d/2)+shield_layer_t-sensor_mount_lock_screw_holder_h-(fudge*2), 0, (sensor_mount_lock_screw_d*2.5)/2]) {
            rotate([0, 90, 0]) {
                cylinder(h=sensor_mount_lock_screw_holder_h+1+(fudge*2), d=sensor_mount_lock_screw_d);
            }
        }
        for(i=[1:number_of_mounts]) {
            rotate(a=(i*360/number_of_mounts), v=[0, 0, 1]) {
                translate([(shield_layer_d2/2)-(mount_guide_od/1.25), 0, -(fudge/2)]) {
                    cylinder(h=shield_layer_h+fudge, d=mount_guide_id);
                }
            }
        }
    }
}

module dht22_mount() {
    difference() {
        union() {
            translate([0, 0, -base_t]) {
                cylinder(h=sensor_mount_peg_height, d=center_opening_d-(shield_layer_t*2)-0.65);
            }
            translate([0, 0, sensor_mount_peg_height-base_t]) {
                difference() {
                    union() {
                        translate([0, 0, (tier_1_h/2)]) {
                            cube([sensor_l, sensor_w, tier_1_h], center=true);
                        }
                        translate([0, 1.5, tier_1_h+(tier_2_h/2)]) {
                            cube([sensor_l, sensor_w-3, tier_2_h], center=true);
                        }
                        translate([0, 2.65, tier_1_h+tier_2_h+(sensor_h/2)]) {
                            cube([sensor_l, sensor_w-5.25, sensor_h], center=true);
                        }
                    }
                    translate([0, -1, tier_1_h+tier_2_h+(sensor_connector_pin_h/2)-sensor_connector_pin_h]) {
                        cube([sensor_connector_pin_w, 1, sensor_connector_pin_h], center=true);
                    }
                    translate([0, 5, tier_1_h+tier_2_h+sensor_mount_hole_h]) {
                        rotate([90, 0, 0]) {
                            cylinder(h=sensor_w, d=sensor_mount_hole_d);
                        }
                    }
                    translate([-(wire_strap_hole_w/2), 5, tier_1_h+wire_strap_hole_h]) {
                        rotate([90, 0, 0]) {
                            cylinder(h=sensor_w, d=wire_strap_hole_h);
                        }
                    }
                    translate([(wire_strap_hole_w/2), 5, tier_1_h+wire_strap_hole_h]) {
                        rotate([90, 0, 0]) {
                            cylinder(h=sensor_w, d=wire_strap_hole_h);
                        }
                    }
                }
            }
        }
        translate([0, -(sensor_w/2)+0.5, -base_t-(fudge/2)]) {
            cylinder(h=sensor_mount_peg_height+tier_1_h+fudge, d=5);
        }
    }
}

module base() {
    difference() {
        union() {
            translate([0, 0, -base_t]) {
                cylinder(h=base_t, d=shield_layer_d1);
                translate([0, 0, -pcb_shroud_h]) {
                    cylinder(h=pcb_shroud_h, d=shield_layer_d1);
                }
            }
            translate([-shield_layer_d2+(base_t*2), 0, -(pcb_shroud_h/2)]) {
                rotate([0, 90, 0]) {
                    cylinder(h=mounting_pipe_l, d=mounting_pipe_od);
                }
            }
            translate([-(shield_layer_d2/2)-4, 0, -(pcb_shroud_h/2)]) {
                rotate([0, 90, 0]) {
                    cylinder(h=6, d=mounting_pipe_od+(mounting_pipe_od-mounting_pipe_id));
                }
            }
        }
        translate([0, 0, -base_t-(fudge/2)]) {
            cylinder(h=base_t+fudge, d=center_opening_d+(shield_layer_t*1.5));
            translate([0, 0, -pcb_shroud_h]) {
                cylinder(h=pcb_shroud_h+fudge, d=shield_layer_d1-(shield_layer_t*2));
            }
        }
        translate([-shield_layer_d2+(base_t*2)-(fudge/2), 0, -(pcb_shroud_h/2)]) {
            rotate([0, 90, 0]) {
                cylinder(h=mounting_pipe_l, d=mounting_pipe_id);
            }
        }
        
        for(i=[1:number_of_mounts]) {
            rotate(a=(i*360/number_of_mounts), v=[0, 0, 1]) {
                translate([(shield_layer_d2/2)-(mount_guide_od/1.25), 0, -base_t-(fudge/2)]) {
                    cylinder(h=base_t+fudge, d=mount_guide_id);
                }
            }
        }
    }
    difference() {
        for(x=[-1, 1], y=[-1, 1]) {
            translate([x*23.25, y*22.75, -pcb_mount_peg_h]) {
                cylinder(h=pcb_mount_peg_h, d=pcb_mount_peg_d);
            }
            translate([x*28, y*28, -pcb_shroud_h-(base_t/2)]) {
                cylinder(h=bottom_cover_screw_post_h, d=bottom_cover_screw_post_d);
            }
        }
        for(x=[-1, 1], y=[-1, 1]) {
            translate([x*23.25, y*22.75, -pcb_mount_peg_h]) {
                cylinder(h=pcb_mount_peg_h+fudge, d=pcb_screw_hole_d);
            }
            translate([x*28, y*28, -pcb_shroud_h-(base_t/2)-(fudge/2)]) {
                cylinder(h=bottom_cover_screw_post_h, d=bottom_cover_screw_hole_d);
            }
        }
    }
}
module bottom_cover() {
    difference() {
        union() {
            cylinder(h=bottom_cover_t, d=shield_layer_d1);
            translate([0, 0, bottom_cover_t]) {
                cylinder(h=(bottom_cover_t/2), d1=shield_layer_d1-(shield_layer_t*2), d2=shield_layer_d1-(shield_layer_t*2.25));
            }
        }
        for(x=[-1, 1], y=[-1, 1]) {//bottom_cover_screw_head_d
            translate([x*28, y*28, -(fudge/2)]) {
                cylinder(h=bottom_cover_t+(bottom_cover_t/2)+fudge, d=bottom_cover_screw_hole_d+0.75);
                cylinder(h=bottom_cover_screw_head_t, d=bottom_cover_screw_head_d);
            }
        }
        translate([0, 0, -(fudge/2)]) {
            cylinder(h=bottom_cover_t+fudge, d=2);
        }
        translate([0, 0, bottom_cover_t]) {
            cylinder(h=(bottom_cover_t/2)+fudge, d1=2, d2=shield_layer_d1-(bottom_cover_screw_head_d*1.5));
        }
    }
}

module full_shield() {
    base();
    translate([0, 0, -pcb_shroud_h-(base_t*2)]) {
        bottom_cover();
    }
    sensor_mount();
    dht22_mount();
    for(i=[1:number_of_middle_layers]) {
        translate([0, 0, i*shield_layer_h]) {
            middle_layer();
        }
    }
    translate([0, 0, (number_of_middle_layers+1)*shield_layer_h]) {
        top_layer();
    }
}


if (view == "top_layer") {
    top_layer();
} else if (view == "middle_layer") {
    middle_layer();
} else if (view == "sensor_mount") {
    sensor_mount();
} else if (view == "bottom_cover") {
    bottom_cover();
} else if (view == "base") {
    base();
} else if (view == "dht22_mount") {
    dht22_mount();
} else if (view == "all") {
    full_shield();
} else {
    echo("UNKNOWN VIEW SELECTED. Set the view variable to define the view");
}