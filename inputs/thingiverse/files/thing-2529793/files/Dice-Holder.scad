NUMBER_OF_DICE = 5;
DIE_WIDTH = 15;
TOLERANCE = 1;
WALL_THICKNESS = 3;

door_lip = 1;

inner_length = (NUMBER_OF_DICE * DIE_WIDTH) 
             + (TOLERANCE * NUMBER_OF_DICE * 2)
             + (WALL_THICKNESS + door_lip);
inner_width = DIE_WIDTH + (TOLERANCE * 2);

outer_width = inner_width + (WALL_THICKNESS * 2);
outer_length = inner_length + WALL_THICKNESS;

door_width = inner_width + WALL_THICKNESS;

module container() {
    difference() {
        cube([outer_length, outer_width, outer_width], center=true);
        translate([(outer_length - inner_length), 0, 0])
        cube([inner_length, inner_width, inner_width], center=true);
    }
}

module door() {
    cube([WALL_THICKNESS, door_width, outer_width], center=true);
}

vertical_offset = outer_width / 2;

translate([0, 0, vertical_offset])
difference() {
    container();
    translate([(inner_length / 2 - door_lip), 0, (WALL_THICKNESS / 3)])
    door();
    translate([(inner_length / 2), 0, (outer_width / 2)])
    cube([WALL_THICKNESS, inner_width, (WALL_THICKNESS * 2)], center=true);
}

scale([1, 0.95, 0.8])
rotate([0, 90, 0])
translate([-(WALL_THICKNESS / 2), outer_width + WALL_THICKNESS, 0])
door();