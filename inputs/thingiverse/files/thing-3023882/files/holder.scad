length = 235;
thickness = 2;
depth = 3;
inner_height = 7;

grooves = 16;
groove_height = 0.40;
groove_length = 3;

module flat_bar(length, thickness, depth, grooves, groove_depth, groove_length, groove_height) {
    linear_extrude(height = thickness, slices=0, convexity = 0) {
        polygon([
            [0,0], [0, thickness], [depth, depth + thickness],
            [length - depth, depth + thickness], [length, thickness], [length, 0]
        ]);
    }
    

    for (x = [depth : (length - depth - groove_length)/grooves : length - depth]) {
        if (x + groove_length < length - depth)
          translate([x, thickness + depth - groove_depth, thickness])
            cube([groove_length, groove_depth, groove_height]);
    }

}

rotate([90,0,0])
intersection() {
    union() {
        flat_bar(length, thickness, 3, grooves, depth, groove_length, groove_height);
        translate([0,0,thickness])
          cube([length, thickness, inner_height - thickness]);
        translate([0, 0, thickness + inner_height])
          mirror([0,0,1])
            flat_bar(length, thickness, 2, grooves, depth/2, groove_length, groove_height);
    }
    
}
    
    
