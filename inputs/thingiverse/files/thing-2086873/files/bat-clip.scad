// Matches turnigy nano-tech 2S 460mAh 25-40C
battery_width = 30;
battery_length = 55;
battery_height = 11;

// Matches two turnigy nano-tech 1S 750mAh 35-70C back-to-back
//battery_width = 27;
//battery_length = 44;
//battery_height = 25.5;

// general 'strength' of parts
wall_size = 2;

// part A (clipping into frame)
// heightA: 6mm originally, 8mm+ for higher batteries
heightA = 6; // width of the main battery touching part
// fixed_part_length: 5mm originally, 15mm+ for longer batteries
fixed_part_length = 5; // non-angled clip part
distance_to_top = 3; // distance between battery top and frame bottom (FC screw head height)
distance_at_top = 41; // distance between clip 'prongs' on holding end
helper_width = 4.5; // triangle-guide overlap
helper_height = 4; // triangle-guide height
helper_offset = 1; // triangle-guide base height

// part B, glued to part A
heightB = 4; // width of the long support bar
small_arm_length = 9; // height of arms holding battery at long ends
cutout_length = heightA + 0.2; // heightA + some clearance
support_length = cutout_length + (2 * wall_size); // length of bar under the cutout (where glue goes)

// calculation helpers
real_height = battery_height + distance_to_top;
dynamic_part_length = real_height - fixed_part_length;
dynamic_part_width = ((distance_at_top - battery_width) / 2) - wall_size;

// print support helpers
helper_disc_diameter = 10;
helper_disc_height = 0.2;

module dynamicPart() {
    points = [
        [  0,  0,  0 ], // 0
        [ dynamic_part_length,  -dynamic_part_width,  0 ], // 1
        [ dynamic_part_length,  wall_size - dynamic_part_width,  0 ], // 2
        [  0,  wall_size,  0 ], // 3
        [  0,  0,  heightA ], // 4
        [ dynamic_part_length,  -dynamic_part_width,  heightA ], // 5
        [ dynamic_part_length,  wall_size - dynamic_part_width,  heightA ], // 6
        [  0,  wall_size,  heightA ]]; // 7
  
    faces = [
        [ 0, 1, 2, 3 ],  // bottom
        [ 4, 5, 1, 0 ],  // front
        [ 7, 6, 5, 4 ],  // top
        [ 5, 6, 2, 1 ],  // right
        [ 6, 7, 3, 2 ],  // back
        [ 7, 4, 0, 3 ]]; // left
    
    polyhedron(points, faces);
}

module helper() {
    points = [
        [  0,  0,  0 ], // 0
        [ helper_height,  helper_width,  0 ], // 1
        [ 0,  helper_width,  0 ], // 2
        [  0,  0,  heightA ], // 3
        [ helper_height,  helper_width,  heightA ], // 4
        [ 0,  helper_width,  heightA ]]; // 5
  
    faces = [
        [ 0, 1, 2 ],     // bottom
        [ 5, 4, 3 ],     // top
        [ 2, 1, 4, 5 ],  // right
        [ 0, 2, 5, 3 ],  // back
        [ 3, 4, 1, 0 ]]; // left
    
    translate([helper_offset, 0, 0])
        polyhedron(points, faces);
    
    cube([helper_offset, helper_width, heightA]);
}

module partA() {
    // central part
    cube([wall_size, battery_width + (2 * wall_size), heightA]);
    
    // fixed parts
    translate([wall_size, 0, 0])
        cube([fixed_part_length, wall_size, heightA]);
    
    translate([wall_size, battery_width + wall_size, 0])
        cube([fixed_part_length, wall_size, heightA]);
    
    // dynamic parts
    translate([wall_size + fixed_part_length, 0, 0])
        dynamicPart();
    
    translate([wall_size + fixed_part_length, battery_width + (2 * wall_size), heightA])
        rotate([180, 0, 0])
            dynamicPart();
    
    // top guides
    translate([wall_size + fixed_part_length + dynamic_part_length, -dynamic_part_width - helper_width + wall_size, 0])
    helper();
    
    translate([wall_size + fixed_part_length + dynamic_part_length, battery_width + dynamic_part_width + helper_width + wall_size, heightA])
        rotate([180, 0, 0])
        helper();
        
    cylinder(d = helper_disc_diameter, h = helper_disc_height);
    
    translate([0, battery_width + (2 * wall_size), 0])
        cylinder(d = helper_disc_diameter, h = helper_disc_height);
        
    translate([wall_size + fixed_part_length + dynamic_part_length, battery_width + dynamic_part_width + wall_size, 0])
        cylinder(d = helper_disc_diameter, h = helper_disc_height);
    
    translate([wall_size + fixed_part_length + dynamic_part_length, -dynamic_part_width + wall_size, 0])
        cylinder(d = helper_disc_diameter, h = helper_disc_height);
}

module partB() {
    // central part
    difference() {
        cube([wall_size, battery_length + (2 * wall_size), heightB]);
        
        translate([-1, wall_size + ((battery_length - cutout_length) / 2), -1])
            cube([wall_size + 2, cutout_length, heightB + 2]);
    }
    
    // support
    translate([-wall_size, wall_size + ((battery_length - support_length) / 2), 0])
        cube([wall_size, support_length, heightB]);
    
    // lower arm
    translate([wall_size, 0, 0])
        cube([small_arm_length, wall_size, heightB]);
    
    // upper arm
    translate([wall_size, battery_length + wall_size, 0])
        cube([small_arm_length, wall_size, heightB]);
    
    cylinder(d = helper_disc_diameter, h = helper_disc_height);
    
    translate([0, battery_length + (2 * wall_size), 0])
        cylinder(d = helper_disc_diameter, h = helper_disc_height);
    
    translate([small_arm_length, 0, 0])
        cylinder(d = helper_disc_diameter, h = helper_disc_height);
    
    translate([small_arm_length, battery_length + (2 * wall_size), 0])
        cylinder(d = helper_disc_diameter, h = helper_disc_height);
}

// ---------------------------------------

partA();

translate([-3 * small_arm_length, 0, 0])
    partB();

// ---------------------------------------

// Visualization:
/*
translate([0, heightB / 2, 0])
rotate([0, -90, 90])
    partA();

translate([(-battery_width + heightB) / 2 - wall_size, (-battery_length - wall_size) / 2 - wall_size, 0])
rotate([0, -90, 0])
    partB();

%translate([-(battery_width + heightB) / 2, -1, battery_height / 2 + wall_size])
    cube([battery_width, battery_length, battery_height], true);

%translate([-(battery_width + heightB) / 2, -1, battery_height + wall_size + distance_to_top - 1])
    cube([battery_width, battery_length, 1], true);
*/