wall_size = 1.2;
bottom_height = 0.2;
connector_width = 8.4;
connector_length = 7.8;
connector_height = 4.4;
cutout_width = 1.6;
cutout_offset = 1.4;

difference() {
    cube([connector_width + (2 * wall_size), connector_length + wall_size, bottom_height + connector_height + (2 * wall_size)]);
    
    translate([wall_size, -1, bottom_height + wall_size])
        cube([connector_width, connector_length + 1, connector_height]);
    
    translate([wall_size + cutout_offset, -1, bottom_height + wall_size + connector_height - 1])
        cube([cutout_width, connector_length + 1, wall_size + 2]);
    
    translate([wall_size + connector_width - cutout_offset - cutout_width, -1, bottom_height + wall_size + connector_height - 1])
        cube([cutout_width, connector_length + 1, wall_size + 2]);
}
