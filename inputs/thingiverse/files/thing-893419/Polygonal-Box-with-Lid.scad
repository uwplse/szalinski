// A polygonal box and lid.

// number of sides the box has
box_sides = 6; // [3:60]

// outer radius of the box
box_rad = 25; // [10:75]

// height of the base
base_height = 25; // [5:150]

// height of the lid
lid_height = 10; // [5:150]

// thickness of the walls, top, and bottom
wall_thickness = 5; // [1:25]

// thickness of the rim
rim_thickness = 2.5; // [0.0:0.5:10]

// height of the rim
rim_height = 2.5; // [0.0:0.5:10]

// vertical allowance for the rim
v_slop = 0; // [-1:0.1:1]

// horizontal allowance for the rim
h_slop = 0; // [-1:0.1:1]

translate([box_rad + 2, 0, 0]) difference() { // the box
    union() { // join the outer box form and the lip together so we can just subtract the center once
        cylinder(r = box_rad, h = base_height, $fn = box_sides); // outside of box
        cylinder(r = box_rad - wall_thickness + rim_thickness + h_slop, h = base_height + rim_height - v_slop, $fn = box_sides); // outside of lip
    }
    translate([0, 0, wall_thickness]) cylinder(r = box_rad - wall_thickness, h = base_height + rim_height, $fn = box_sides);
}

translate([-1 * box_rad - 2, 0, 0]) difference() { // the lid
    cylinder(r = box_rad, h = lid_height, $fn = box_sides); // outside of the lid
    // subtract the box void
    translate([0, 0, wall_thickness]) cylinder(r = box_rad - wall_thickness, h = lid_height, $fn = box_sides);
    // subtract where the rim goes
    translate([0, 0, lid_height - rim_height - v_slop]) cylinder(r = box_rad - wall_thickness + rim_thickness - h_slop, h = lid_height + v_slop, $fn = box_sides);
}