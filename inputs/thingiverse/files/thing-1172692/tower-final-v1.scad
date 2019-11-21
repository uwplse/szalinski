/**
OpenSCAD Vertical Plant Tower

Feel free to customize the settings.  Debug flag provides you with cross section of project.  Use "food safe" plastic if growing edibles.  Have Fun!  
**/

// 3 Stems, 4 inches diameter, 0.3 thickness
// 5 Stems, 5 inches diameter, 0.4 thickness
// 7 Stems, 6 inches diameter, 0.4 thickness
// 9 Stems, 7 inches diameter, 0.4 thickness

// General
thickness = 0.4;

// Tree
tree_height = 6;
tree_diameter = 4;
tree_bottom_height = 1.0;

// Stems
stems = 3;
stem_diameter = 2;
stem_width = 4;
stem_height = 5;

// Drainage holes
drainage_hole_spacing = 0.6;
drainage_hole_size = 0.15;
drainage_hole_center_size = 1.0;

// Top
tree_top_height = 1;
tree_top_hole_size = 0.5;

// Bottom
tree_bottom_height = 1;
tree_bottom_hole_size = 1;

// Debug
debug = false;

// Drainage Holes
drainage = true;

// Resolution
$fn = 360;

// echo(smooth)

/**
Creates a series of holes in a circular pattern.  Used to create the 
drainage holes at the bottom of each tower level.
**/
module ring_holes(quantity = 5, diameter = 1.4, thickness = 23, hole_size = 0.15, hole_spacing) {
    for (i = [ 0 : quantity - 1 ]) {
        translate([sin(360*i/quantity) * diameter, 
            cos(360*i/quantity)*diameter, 0 ])
        cylinder(
            thickness, hole_size, hole_size, true    
        ); 
    }
}

/**
Creates a series of holes in a circular pattern.  Used to create the 
drainage holes at the bottom of each tower level.
**/
module drainage_holes(thickness = 23, diameter = 3, hole_size, hole_spacing) {
    for (i = [1.4 : hole_spacing : diameter]) {
        ring_holes(2 * PI * i * (2.1 - hole_spacing), i, thickness, hole_size, hole_spacing);
    }
}

module stem(quantity = 5, diameter = 2, tree_size = 4, height = 5) {
    for (i = [ 0 : quantity - 1 ]) {
        translate([sin(360 * i / quantity) * tree_size, 
            cos(360 * i / quantity) * tree_size, 0 ])
        rotate(a=[45,180,360 * -(i / quantity)])
        cylinder(
            height, diameter, diameter, true    
        ); 
    }
}

/**
Define the main structure with the stems.
**/
module tree_middle() {
    difference() {
        // Body
        union() {
            // Central Tree
            cylinder(tree_height, tree_diameter, tree_diameter, true); 
            
            // Stems
            stem(stems, stem_diameter, tree_diameter, stem_height);
            
            // Tree Floor
            translate([0,0,-3]) {
                cylinder(thickness, tree_diameter, tree_diameter, true); 
            } 
            
            // Tree Bottom Insert Section (must fit in next tree)
            translate([0,0,-3.6]) {
                cylinder(tree_bottom_height, tree_diameter - thickness, 
                tree_diameter - thickness, true); 
            }
        }
        // Remove
        union() {
            // Central Tree
            translate([0,0,thickness]) {
                cylinder(tree_height - 0.1, tree_diameter - thickness, 
                    tree_diameter - thickness, true);
            }
            
            // Stems holes.
            stem(stems, stem_diameter - thickness, tree_diameter, stem_height + 0.1);
            
            // Bottom
            translate([0,0,-3.3 + thickness]) {
                cylinder(tree_bottom_height + thickness + thickness, 
                tree_diameter - thickness - thickness, 
                tree_diameter - thickness - thickness, true); 
            }
    
            // Drainage holes (disable for faster rendering)
            if (drainage) {
                translate([0,0,-tree_height]) {
                    drainage_holes(5, tree_diameter - 1, 
                        drainage_hole_size, drainage_hole_spacing);
                }
            }
            
            // Center hole
            if (drainage) {
                translate([0,0,-tree_height]) {
                    cylinder(
                        5, 
                        drainage_hole_center_size, drainage_hole_center_size, true
                    ); 
                }
            }

            // Use for debugging purposes.
            if (debug) {
                translate([10,10,0]) {
                    cube(size = [20,20,20], center = true);
                }
            }
    
        }  
    }
}

/**
Define a top for the structure.
**/
module tree_top() {
    difference() {
        // Body
        union() {
            // Central Tree
            cylinder(tree_top_height, tree_diameter, tree_diameter, true); 
            
            // Tree Floor
            translate([0,0, - tree_top_height + thickness + thickness]) {
                cylinder(thickness, tree_diameter, tree_diameter, true); 
            } 
            
            // Tree Bottom Insert Section (must fit in next tree)
            translate([0,0, - tree_top_height]) {
                cylinder(tree_bottom_height, 
                    tree_diameter - thickness, 
                    tree_diameter - thickness, true); 
            }

            // Graduated Top
            translate([0,0,tree_top_height]) {
            cylinder(tree_top_height, 
                tree_diameter,
                tree_top_hole_size, true); 
            }
            
            // Top cylinder
            translate([0,0,tree_top_height + tree_top_height]) {
            cylinder(tree_top_height * 3, 
                tree_top_hole_size,
                tree_top_hole_size, true); 
            }

            translate([0,0,tree_top_height * 3 + thickness]) {
            cylinder(thickness, 
                tree_top_hole_size * 1.2,
                tree_top_hole_size, true); 
            }
            
            translate([0,0,tree_top_height * 3]) {
            cylinder(thickness, 
                tree_top_hole_size * 1.2,
                tree_top_hole_size, true); 
            }
            
            translate([0,0,tree_top_height * 3 - thickness]) {
            cylinder(thickness, 
                tree_top_hole_size * 1.2,
                tree_top_hole_size, true); 
            }
            
        }
        // Remove
        
        union() {

            // Central Tree
            //translate([0,0,0]) {
            //cylinder(tree_top_height - thickness, tree_diameter - thickness, 
            //    tree_diameter - thickness, true);
            //}

            // Bottom
            translate([0,0, - tree_top_height + thickness + thickness / 2]) {
                cylinder(tree_bottom_height + thickness, 
                tree_diameter - thickness - thickness, 
                tree_diameter - thickness - thickness, true); 
            }
            
            // Graduated Top
            translate([0,0,tree_top_height - thickness]) {
            cylinder(tree_top_height - thickness, 
                tree_diameter - thickness - thickness,
                tree_top_hole_size, true); 
            }

            // Top Hole
            translate([0,0,tree_top_height + tree_top_height]) {
            cylinder(tree_top_height * 3 + thickness, 
                tree_top_hole_size - thickness / 2,
                tree_top_hole_size - thickness / 2, true); 
            }

            // Drainage holes (disable for faster rendering)
            if (drainage) {
                translate([0,0,-1]) {
                    drainage_holes(1, tree_diameter - 1, 
                        drainage_hole_size, drainage_hole_spacing);
                }
            }
           
            // Use for debugging purposes.
            if (debug) {
                translate([4,4,0]) {
                    cube(size = [8,8,8], center = true);
                }
            }
    
        }
    }
}

/**
Define a bottom for the structure.
**/
module tree_bottom() {
    difference() {
        // Body
        union() {
            // Central Tree
            cylinder(tree_bottom_height + thickness, tree_diameter, 
            tree_diameter, true); 
            
            // Tree Floor
            translate([0,0, - tree_bottom_height + thickness + thickness]) {
                cylinder(thickness, tree_diameter, tree_diameter, true); 
            } 
            
            // Tree Bottom Insert Section (must fit in next tree)
            translate([0,0, - tree_bottom_height]) {
                cylinder(tree_bottom_height, 
                    tree_diameter - thickness, 
                    tree_diameter - thickness, true); 
            }

            // Top cylinder
            translate([0,0,-tree_bottom_height - tree_bottom_height]) {
            cylinder(tree_bottom_height, 
                tree_bottom_hole_size,
                tree_bottom_hole_size, true); 
            }
            
        }
        // Remove
        
        union() {

            // Central Tree
            translate([0,0,thickness]) {
                cylinder(tree_bottom_height, tree_diameter - thickness, 
                    tree_diameter - thickness, true);
            }
            
            // Bottom
            translate([0,0, - tree_bottom_height + thickness + thickness]) {
                cylinder(tree_bottom_height + thickness + thickness, 
                tree_diameter - thickness - thickness, 
                tree_diameter - thickness - thickness, true); 
            }

            // Bottom Hole
            translate([0,0,-tree_bottom_height - tree_bottom_height]) {
            cylinder(tree_bottom_height + tree_bottom_height, 
                tree_bottom_hole_size - thickness,
                tree_bottom_hole_size - thickness, true); 
            }

            // Drainage holes (disable for faster rendering)
            /**
            translate([0,0,-1]) {
                drainage_holes(1, tree_diameter - 1, 
                    drainage_hole_size, drainage_hole_spacing);
            }
            **/
            
            // Use for debugging purposes.
            if (debug) {
                translate([4,4,0]) {
                    cube(size = [8,8,8], center = true);
                }
            }
    
        }
    }
}

translate([0,0,7]) {
    // tree_top();
}

translate([0,0,0]) {
    tree_middle();
}

translate([0,0,-7]) {
    // tree_bottom();
}

