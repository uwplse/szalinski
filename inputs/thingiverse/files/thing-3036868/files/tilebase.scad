$fn=80;

// Diameter of the base. 
base_diameter = 50; // [10:200]

// Taper ratio of the base. 0.0 means fully rounded top, 1.0 means straight up.
base_taper = 0.8; // [0.0:0.05:1.0]

// Height of the base
base_height = 4; // [1:0.5:10]

// Width of the tile.
tile_width = 19; // [4:.05:60]

// Thickness of the tile.
tile_tickness = 3.5; // [.25:.05:10]

// Clearance around the tile. Use this when you intend to wrap the tile with a piece of paper.
tile_clearance = 0.25; // [0.0:0.01:1]

// Tile placement
tile_placement = "back to back"; // [single, side by side, back to back]

// Angle at which the tile is tilted.
tile_tilt = 15; // [0:45]

// Vertial offset for tile (from bottom.)
tile_v_offset = 0.4; // [0:0.1:4]

tile_h_offset = sin(tile_tilt) * tile_width * .5;

r_bot = base_diameter / 2;
r_top = (base_diameter * base_taper) / 2;
z_offset = (r_bot * r_bot - 
            r_top * r_top - 
            base_height * base_height) / (2 * base_height);
sphere_radius = sqrt(r_bot * r_bot + z_offset * z_offset);

module tile() {
    translate([0, 0, 500])
    cube([tile_width + tile_clearance * 2, 
          tile_tickness  + tile_clearance * 2, 
          1000], center=true);
}


difference() {
    intersection() { 
        translate([0, 0, base_height/2])
        cylinder(r=r_bot, h=base_height, center=true);

        translate([0,0,-z_offset])
        sphere(r=sphere_radius);
    };
    
    translate([0, 0, tile_v_offset]) {
        if (tile_placement == "single") {
            translate([0, tile_h_offset, 0])
            rotate([tile_tilt, 0, 0]) 
            tile();
        }
        else if (tile_placement == "side by side") {
            translate([-19/2-.5, tile_h_offset, 0]) rotate([tile_tilt,0,0]) tile(19,27,3.5);
            translate([ 19/2+.5, tile_h_offset, 0]) rotate([tile_tilt,0,0]) tile(19,27,3.5);
        }
        else if (tile_placement == "back to back") {
            translate([0, -r_top/2 + tile_h_offset, 0]) rotate([tile_tilt, 0, 0]) tile(19,27,3.5);
            translate([0,  r_top/2 + tile_h_offset, 0]) rotate([tile_tilt, 0, 0]) tile(19,27,3.5);
        }
    }
}

