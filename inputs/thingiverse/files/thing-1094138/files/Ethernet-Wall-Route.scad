channel_count = 4;
screw_whole_diameter = 3;
ethernet_cable_diameter = 5.5;

// These should not require change under normal uses.
height = 8;
thickness = 2.5;
chamfer_size = 2;

function channel_width() = ethernet_cable_diameter + thickness*2;
function tab_length() = screw_whole_diameter + thickness*2;

module mount_tab() {
    translate([0,0,thickness/2]) difference() {
        cube([height, tab_length(), thickness], true);
        cylinder(r=screw_whole_diameter/2, h=thickness, $fn=45, center=true);
    }
}

module ethernet_channel() {
    translate([0,0,height/2]) difference() {
        cube([channel_width(), channel_width(), height], true);
        cylinder(r=ethernet_cable_diameter/2, h=height, $fn=45, center=true);
        translate([channel_width()/2,0,0]) cube([channel_width(), ethernet_cable_diameter, height], true);
    }
}


module ethernet_wall_route() {
    union() {
        translate([0,0,height/2]) rotate([0,90,0]) mount_tab();

        difference() {
            union() {
                for (i = [1:channel_count]) {
                    translate([-channel_width()/2 + thickness,i * (tab_length()/2 + channel_width()/2),0])
                        ethernet_channel();
                }
            }

            translate([-channel_width(),-channel_width()/2,0]) rotate([0,0,45])
                cube([channel_width(), channel_width(), height]);

            translate([-channel_width(),channel_count * (tab_length()/2 + channel_width()/2),0]) rotate([0,0,45])
                cube([channel_width(), channel_width(), height]);
        }

        translate([0, (1 + channel_count) * (tab_length()/2 + channel_width()/2),height/2])
            rotate([0,90,0])
                mount_tab();
    }
}

ethernet_wall_route();
