part = 1; // [1:Bottom, 2:Top]
// (millimeters, length/width of interconnect grid unit)
unit_length_width = 1; // [1:100]
// (millimeters, height of interconnect grid overhang)
interlock_height = 1; // [1:100]
// (number of repeated units)
grid_length = 10; // [1:100]
// (number of repeated units)
grid_width = 10; // [1:100]
// (millimeters)
backing_height = 2; // [1:100]

interSurfaces([unit_length_width, interlock_height], [grid_length, grid_width], backing_height, part);

module interSurfaces(unit_size=[1,1], grid_size=[10,10], backing=2, only_part=0) {
    total_size = [
        grid_size[0] * (2 * unit_size[0]),
        grid_size[1] * (2 * unit_size[0]),
        backing + unit_size[0],
    ];
    
    if (only_part == 0 || only_part == 1) {
        color("red")
        interSurface(unit_size, grid_size, backing);
    }

    if (only_part == 0 || only_part == 2) {
        color("blue")
        translate([total_size[0], total_size[1], (backing * 2) + (unit_size[1] * 2)]) {
            rotate([0, 180, 90]) {
                interSurface(unit_size, grid_size, backing);
            }
        }
    }
}

module interSurface(unit_size, grid_size, backing) {
    cube([
        grid_size[0] * (2 * unit_size[0]),
        grid_size[1] * (2 * unit_size[0]),
        backing,
    ]);
    translate([0, 0, backing]) {
        interGrid(unit_size, grid_size);
    }
}

module interGrid(unit_size, grid_size) {
    for (i = [0 : grid_size[0] - 1]) {
        translate([i * (unit_size[0] * 2), 0, 0]) {
            interRow(unit_size, grid_size[1]);
        }
    }
}

module interRow(unit_size, length) {
    for (i = [0 : length - 1]) {
        translate([0, i * (unit_size[0] * 2), 0]) {
            interHook(unit_size);
        }
    }
}

module interHook(unit_size) {
    u = unit_size[0];
    
    cube([u, u, unit_size[1] * 2]);
        
    translate([u, 0, unit_size[1]]) {
        cube([u, u, unit_size[1]]);
    }
            
    translate([0, u, unit_size[1]]) {
        cube([u, u, unit_size[1]]);
    }
}