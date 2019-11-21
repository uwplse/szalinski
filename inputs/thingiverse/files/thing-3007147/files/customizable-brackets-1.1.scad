/*
* Ultimate Customizable Corner Brackets
* https://www.thingiverse.com/thing:3007147
* Version 1.1
* 2019-11-07
*/


// The width of your aluminium extrusion
extrusion_width = 20;

// The side length of the bracket
side_length = 20;
// The thickness of the parts you screw into
side_thickness = 4;

// How many screws should be used to fasten this to the extrusions. Should be even.
screw_count = 2;
// Screw diameter (4 for M4, 5 for M5 and so on)
screw_hole_size = 5;
// Screw head diameter
screw_head_size = 10;
// How deep screw heads should be recessed. Obviously don't make this larger than side_thickness.
recessed_screw_depth = 0;

// The part which goes into your extrusion. Generally this should be slightly smaller than the actual hole, but YMMV.
extrusion_insert_width = 6;

// Use this when you want multiple connected brackets, for 4020 and similar. 20 for 2020 extrusions, 30 for 3030 and so on.
extrusion_base = 20;

// Set to true if you only want a single wall. Not compatible with multiple bracket mode
single_wall_mode = false;

// Set lower if you think the side walls are too thick
max_wall_thickness = 8;

// Set this if you want to use these above your existing brackets. Typical 2020 brackets have a size of 20 and side thickness of 3
cutout_size = 0;
cutout_side_thickness = 0;
cutout_margin = 0.3;





/**********************************
   End of config, here be dragons
**********************************/








// This works for typical hammer nuts, increase if needed
bottom_nut_space = screw_hole_size + 4;

// You might want to decrease this if you don't use hammer nuts
extrusion_insert_height = 3;

screw_head_margin = 0.5;
e = 0.05;
screw_distance_from_edge = max(screw_head_size / 2 + 1.5, min(6.5, side_length/3)) + screw_head_margin/2;
bridge_size = screw_count > 2
    ? (side_length - side_thickness - 2*screw_head_size + cutout_size + cutout_margin) / (side_length/20)
    : side_length - screw_distance_from_edge - screw_head_size / 2 - side_thickness - screw_head_margin;

main();

module main() {
    bracket_count = floor(extrusion_width / extrusion_base);
    extrusion_width = extrusion_width/bracket_count;
    wall_thickness = min([max_wall_thickness, (extrusion_width - screw_head_size - screw_head_margin) / 2]);
    union() {
        for(i=[0:bracket_count-1]) {
            translate([i*extrusion_width, 0, 0]) bracket(extrusion_width, wall_thickness);
        }
    }
}

module bracket(width, wall_thickness, is_first) {
    screw_total_distance = side_length - screw_distance_from_edge - bridge_size - side_thickness - screw_head_size/2 - screw_head_margin;
    screw_distance = screw_total_distance/(max(1, screw_count/2-1));
    
    difference() {
        union() {
            translate([-width/2, 0, 0]) cube([width, side_length, side_thickness]); // Bottom wall
            translate([-width/2, side_thickness, 0]) rotate([90, 0, 0]) cube([width, side_length, side_thickness]); // Top wall
            translate([width/2 - wall_thickness, 0, 0]) rotate([90, 0, 90]) wall(width, side_length, wall_thickness); // Left wall
            if(!single_wall_mode) {
                translate([-width/2, 0, 0]) rotate([90, 0, 90]) wall(width, side_length, wall_thickness); // Right wall
            }
            
            // Make the parts which go into the extrusions, with chamfers
            difference() {
                union() {
                    extrusion_insert();
                    translate([0, 0, 0]) rotate([90, 0, 180]) extrusion_insert();
                }
                extrusion_chamfer();
                translate([0, 0, 0]) rotate([90, 0, 180]) extrusion_chamfer();
            }
            bridge(bridge_size, width, wall_thickness);
        };
        translate([-width/2 - e, side_length + side_thickness*0.6, 0]) rotate([45, 0, 0]) cube([width + e * 2, side_length, side_length*2]); // Cutoff for better printing
        
        // Make screw holes
        for(i=[0:screw_count/2-1]) {
            translate([0, side_length - screw_distance_from_edge - i*screw_distance, -e]) screw(screw_hole_size, screw_head_size); // Bottom screw
            translate([0, -e, side_length - screw_distance_from_edge - i*screw_distance]) rotate([270, 0, 0]) screw(screw_hole_size, screw_head_size); // Top screw
        }
        cutout();
    }
}

module cutout() {
    zero = -e-extrusion_insert_height;
    full_width = cutout_size+cutout_margin;
    if (cutout_size > 0) translate([extrusion_width/2+e, 0, 0]) rotate([0, -90, 0]) linear_extrude(height = extrusion_width+2*e, convexity = 2) polygon(points = [
        [zero, zero],
        [zero, full_width],
        [cutout_side_thickness+cutout_margin, full_width],
        [full_width, cutout_side_thickness+cutout_margin],
        [full_width, zero]]);
}

module wall(w, l, wall_thickness) {
    linear_extrude(height = wall_thickness, convexity = 2) polygon(points = [[side_thickness, side_thickness], [side_length, side_thickness], [side_thickness, side_length]]);
}

module screw(hole_size, head_size) {
    translate([0,0,-0.5]) cylinder(h = side_thickness + 1, r = hole_size / 2 + 0.4, $fn = 32); // Screw hole
    if(recessed_screw_depth > 0){
        translate([0, 0, side_thickness - recessed_screw_depth]) cylinder(h = recessed_screw_depth+1, r = (head_size + screw_head_margin)/2, $fn = 32);
    }
    translate([-extrusion_insert_width/2-e, -bottom_nut_space/2, -extrusion_insert_height-e]) cube([extrusion_insert_width + 2*e, bottom_nut_space,extrusion_insert_height+2*e]); // Remove extrusion insert below screw
    #translate([0, 0, side_thickness+2*e]) cylinder(h = 3, r = head_size / 2, $fn = 32); // Screw head, to make sure they don't hit each other
}

module bridge(size, width, wall_thickness) {
    right = width - 2*wall_thickness + 2;
    c = screw_head_size / 3;
    top = size + c;
    x = width/2-wall_thickness-c;
    union() {
        translate([width/2 - e, 0, 0])
            rotate([0, 270, 0])
            linear_extrude(height = width - 2*e, convexity = 2)
            polygon([[side_thickness, side_thickness], [side_thickness + size, side_thickness], [side_thickness, side_thickness + size]]); // Main bridge
        translate([width/2-wall_thickness-c, 0, 0])
            bridge_side(size, [[0, 0], [c, 0], [c, c]]); // Left
        if(!single_wall_mode) {
            translate([-width/2+wall_thickness, 0, 0])
                bridge_side(size, [[0, 0], [c, 0], [0, c]]); // Right
        }
    }
}

module bridge_side(size, polygon_points){
    hull() {
        translate([0, size+side_thickness, side_thickness]) linear_extrude(height = e, convexity = 2) polygon(points = polygon_points);
        translate([0, side_thickness, size+side_thickness]) rotate([90,0,0]) linear_extrude(height = e, convexity = 2) polygon(points = polygon_points);
    }
}

module extrusion_insert() {
    translate([-extrusion_insert_width/2, -extrusion_insert_height, -extrusion_insert_height]) cube([extrusion_insert_width, extrusion_insert_height, side_length + extrusion_insert_height]);
}

module extrusion_chamfer(height = .5) {
    x = extrusion_insert_width;
    z = side_length + extrusion_insert_height;
    length = sqrt(height * height * 2);
    translate([-extrusion_insert_width/2, -extrusion_insert_height, -extrusion_insert_height]) union() {
        translate([0, -height, -e]) rotate([0, 0, 45]) cube([length, length, z+2*e]);
        translate([x, -height, -e]) rotate([0, 0, 45]) cube([length, length, z+2*e]);
    }
}