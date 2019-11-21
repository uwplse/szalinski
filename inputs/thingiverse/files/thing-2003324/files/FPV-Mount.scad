diameter = 9.5;
wall_size = 2;
screw_size = 3.1;
srew_tap_size = 2.6;
mount_width = diameter + (2 * wall_size);
mount_height = mount_width + screw_size + wall_size;
cut_width = diameter - 2;
width = 40;
depth = 75;
center_width = 12;
center_offset = 5;
top_width = 39;
top_height = 49;

$fn = 20;

module single_mount() {
    translate([mount_width, mount_height, 0])
    rotate([0, -90, 90])
    difference() {
        cube([mount_width, mount_width, mount_height]);
        
        translate([mount_width / 2, mount_width + 1, mount_height - (diameter / 2) - wall_size])
            rotate([90, 0, 0])
            cylinder(d = diameter, h = mount_width + 2);
        
        translate([(mount_width - cut_width) / 2, -1, -1])
            cube([cut_width, mount_width + 2, diameter + wall_size + 1]);
        
        translate([-1, mount_width / 2, wall_size + (screw_size / 2)])
            rotate([0, 90, 0])
            cylinder(d = screw_size, h = mount_width + 2);
    }
}

module single_holder() {
    single_mount();
    
    difference() {
        translate([0, -(depth - mount_height), 0])
            cube([mount_width, depth - mount_height, mount_width]);
        
        translate([-1, wall_size + (screw_size / 2) - (depth - mount_height), mount_width / 2])
            rotate([0, 90, 0])
            cylinder(d = screw_size, h = mount_width + 2);
    }
}

module holders() {
    single_holder();
    
    translate([width - mount_width, 0, 0])
        single_holder();
}

module center() {
    translate([(width - center_width) / 2, -center_offset - (depth - mount_height), 0])
    difference() {
        cube([center_width, screw_size + (2 * wall_size) + center_offset, mount_width]);
        
        translate([-1, center_offset + wall_size + (screw_size / 2), mount_width / 2])
            rotate([0, 90, 0])
            cylinder(d = srew_tap_size, h = center_width + 2);
    }
    
    translate([(width - top_width) / 2, -wall_size - center_offset - (depth - mount_height), -(top_height - mount_width) / 2])
        cube([top_width, wall_size, top_height]);
}

translate([0, depth - mount_height + wall_size + center_offset, -mount_width / 2])
union() {
    //single_holder();
    
    //holders();
    center();
}
