part = "all"; // [holder:Holder Only,ring:Ring Only,cover:Cover Only,all:Holder Ring and Cover]

// outside diameter in mm of one binocular tube
diameter=63.5;

// thickness of the walls in mm (for best results, make this a multiple of your nozzle width)
wall_thickness = 1.2;

// width of the ring of material on the holder that prevents the filter from falling through
holder_annulus_width = 10;

//width of the ring that sandwiches the filter from the inside (should be slightly smaller than holder_annulus_width)
ring_annulus_width = 9;

// depth of the filter holder that slides over the binoculars
holder_depth = 10;

// depth of the cover that slides over the holder
cover_depth = 7;

// amount of gap between the cover and the holder
cover_gap = 0.25;

// the distance between parts when printed together
part_spacing = 3;

/* [Hidden] */
cover_inner_diameter = diameter + 2 * wall_thickness + 2 * cover_gap;
cover_outer_diameter = cover_inner_diameter + 2 * wall_thickness;


module cover() {
    union() {
        translate([0, 0, wall_thickness / 2]) {
            cylinder(h = wall_thickness,
                     d = cover_outer_diameter,
                     center = true,
                     $fn=200);  
        }
        translate([0 , 0, wall_thickness + cover_depth / 2]) {
            difference() {
                cylinder(h = cover_depth,
                         d = cover_outer_diameter,
                         center = true,
                         $fn = 200);
                cylinder(h = cover_depth + 1,
                         d = cover_inner_diameter,
                         center = true,
                         $fn = 200);                    
            }
        }
    }
}

module holder() {
    union() {
        translate([0, 0, wall_thickness / 2]) {
            difference() {
                cylinder(h = wall_thickness,
                         d = diameter + 2 * wall_thickness,
                         center = true,
                         $fn = 200);
                cylinder(h = wall_thickness + 1,
                         d = diameter - 2 * holder_annulus_width,
                         center = true,
                         $fn = 200);
            }
        }
        translate([0, 0, holder_depth / 2 + wall_thickness]) {
            difference() {
                cylinder(h = holder_depth,
                         d = diameter + 2 * wall_thickness,
                         center = true,
                         $fn = 200);
                cylinder(h = holder_depth + 1,
                         d = diameter,
                         center = true,
                         $fn = 200);
            }
        }
    }
}


module ring() {
    union() {
         translate([0, 0, wall_thickness / 2]) {
            difference() {
                cylinder(h = wall_thickness, 
                         d = diameter,
                         center = true,
                         $fn = 200);                    
                cylinder(h = wall_thickness + 1, 
                         d = diameter - ring_annulus_width * 2,
                         center = true,
                         $fn = 200);                    
            }
        }
    }
}


// Create one STL file at a time
if (part == "cover") {
    cover();
} else if (part == "holder") {
    holder();
} else if (part == "ring") {
    ring();
} else if (part == "all") {
    spacing = cover_outer_diameter + part_spacing;
    
    translate([-spacing * sqrt(3) / 4, spacing / 2, 0]) cover();
    translate([-spacing * sqrt(3) / 4, -spacing / 2, 0]) holder();
    translate([spacing * sqrt(3) / 4, 0, 0]) ring();
}
