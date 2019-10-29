bearing_catcher_id = 8.5;
bearing_catcher_od = 12;
bearing_catcher_height = 5;
tunnel_id = 22.5;
tunnel_height = 12;
wall_width = 5;
cable_channel_width = 9;
bottom = 1.2;

$fn = 50;

//cylinder(r = id, h = 10);

module Ring(ir, or, h) {
    difference() {
        cylinder(r = or, h = h);
        cylinder(r = ir, h = h * 3, center = true);
    }
}

module CableChannel() {
    translate([-20, -cable_channel_width / 2, bearing_catcher_height + bottom]) {
        cube([20, cable_channel_width, 20]);
    }
}

module Body() {
    cylinder(r = (tunnel_id / 2) + wall_width, h = bottom);
    translate([0, 0, bottom]) {
        Ring(tunnel_id / 2, (tunnel_id / 2) + wall_width, tunnel_height + bearing_catcher_height);
        Ring(bearing_catcher_id / 2, bearing_catcher_od / 2, bearing_catcher_height);
    }
}

difference() {
    Body();
    CableChannel();
}