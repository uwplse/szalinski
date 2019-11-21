AMOUNT_X = 3;
AMOUNT_Y = 4;

/* [Edges] */
INNER_EDGE = 0.75;
OUTER_EDGE_PADDING = 0.75;
OUTER_RADIUS_EMBEDDING = 2;
SLANT_EDGE_PADDING = 0.75;

/* [Gap Size] */
GAP_WIDTH = 22;

/* [Hidden] */
// Perhaps calculate these
SLANT_FULL_HEIGHT = 20;
SLANT_GAP_OFFSET = 7;
SLANT_GAP_WIDTH = 11.25;
SLANT_GAP_WIDTH_INNER = 8;

module casing_rod(total_radius, pos) {
    translate(pos)
    cylinder(0.00001, total_radius, true);
    
    translate(pos + [SLANT_FULL_HEIGHT, 0, SLANT_FULL_HEIGHT])
    cylinder(0.00001, total_radius, true);
}

module casing(depth, width) {
    total_radius = OUTER_EDGE_PADDING + OUTER_RADIUS_EMBEDDING;
    
    width_inner = width;
    width_start = total_radius;
    width_end = width_inner + total_radius - OUTER_RADIUS_EMBEDDING*2;
    
    depth_inner = depth;
    depth_start = total_radius;
    depth_end = depth_inner + total_radius - OUTER_RADIUS_EMBEDDING*2;
    
    $fn = 30;
    hull() {
        casing_rod(total_radius, [depth_start, width_start, 0]);
        casing_rod(total_radius, [depth_start, width_end, 0]);
        
        casing_rod(total_radius, [depth_end, width_start, 0]);
        casing_rod(total_radius, [depth_end, width_end, 0]);
    }
}

module gap_detail_half() {
    translate([0, 0, -2.49])
        linear_extrude(5, scale=2, center=true)
        square([11, 8], true);
}

module gap_detail() {
    gap_detail_half();
    
    mirror([0, 0, 1])
        gap_detail_half();
    
    translate([8, 0, 12])
    scale([1, 1.5, 1])
        gap_detail_half();
}

module gap() {
    rotate(a = 45, v = [0, 1, 0])
        cube([SLANT_GAP_WIDTH_INNER, GAP_WIDTH, 40]);
    
    translate([2, GAP_WIDTH*0.5, 4])
        gap_detail();
}

module gaps() {
    translate([
        SLANT_GAP_OFFSET + OUTER_EDGE_PADDING + INNER_EDGE,
        OUTER_EDGE_PADDING + INNER_EDGE,
        SLANT_GAP_OFFSET
    ])
    for (x = [0:AMOUNT_X-1])
    for (y = [0:AMOUNT_Y-1])
        translate([
            (SLANT_GAP_WIDTH + INNER_EDGE + SLANT_EDGE_PADDING)*x,
            (GAP_WIDTH + INNER_EDGE)*y,
            0
        ])
        gap();
}

module main_case() {
    difference() {
        casing(
            INNER_EDGE +
            (SLANT_GAP_WIDTH + INNER_EDGE + SLANT_EDGE_PADDING)*AMOUNT_X
            - SLANT_EDGE_PADDING,
        
            INNER_EDGE +
            (GAP_WIDTH + INNER_EDGE) * AMOUNT_Y
            
        );
        gaps();
    }
}

module stand_2d() {
    size = SLANT_FULL_HEIGHT*0.75;
    
    polygon(points=[
        [0, 0],
        [1.5*size, 0],
        [SLANT_FULL_HEIGHT, SLANT_FULL_HEIGHT]
    ]);
}

module stand(offse) {
    translate([39, offse, 0])
    rotate(a = 90, v = [1, 0, 0])
        linear_extrude(3, center = true)
        stand_2d();
}

// Finally, the combined model
main_case();
stand(15);
stand(93-15);