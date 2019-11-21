///////////////
// Variables //
///////////////

clearance = 0.4;

// wall width
wall_width = 2;

// Camera module x
module_x = 24.9;

// Camera module y
module_y = 24;

// Camera module y
module_z = 7.8;

// Inner depth
shell_width = 1.2;

// Lip thickness
lip_width = 1.2;

// Lip height
lip_height = 1.2;

// Ribbon cable slot offset
ribbon_offset_x = 5;

// Ribbon cable slot height
ribbon_z = 1.2;

// Hole diameter for the lens
lens_diameter = 8;

// Move lens hole a little bit off the middle
lens_y_offset = 1.6;

// Borders for the lense module
lens_cube = 9;

// Border thickness for the lens module
lens_cube_wall = 0.9;

// Module spacer x
module_stand_x = 4.2;

// Module spacer y
module_stand_y = 4.6;

// Module spacer z
module_stand_z = 3;

// Move two spacers to the middle
module_stand_offset = 9;

// Lid thickness
lid_height = 1;


///////////////////////
// Calculated values //
///////////////////////

case_top_x = module_x+2*wall_width+2*clearance;
case_top_y = module_y+2*wall_width+2*clearance;
case_top_z = module_z - clearance;

////////////////
// Draw parts //
////////////////

case_top();
translate([case_top_x+5, 0, 0]) {
    lid();
}

/////////////
// Modules //
/////////////

module case_top() {
    
    difference() {
        
        // Outer cube
        cube ([case_top_x, case_top_y, case_top_z]);
        
        // Inner cube
        inner_cube_x = case_top_x - 2*wall_width;
        inner_cube_y = case_top_y - 2*wall_width;
        inner_cube_z = case_top_z-shell_width+clearance;
        
        translate([wall_width, wall_width, shell_width]) {
            cube ([inner_cube_x, inner_cube_y, inner_cube_z]);
        }

        // Lip cube
        lip_cube_x = case_top_x - 2*(wall_width-lip_width);
        lip_cube_y = case_top_y - 2*(wall_width-lip_width);
        lip_cube_z = case_top_z-shell_width+clearance;

        translate([wall_width-lip_width, wall_width-lip_width, case_top_z-lip_height]) {
            cube ([lip_cube_x, lip_cube_y, lip_cube_z]);
        }

        // Ribbon cut
        ribbon_cube_x = case_top_x - 2*ribbon_offset_x;
        ribbon_cube_y = wall_width+2*clearance;
        ribbon_cube_z = ribbon_z+clearance;

        translate([ribbon_offset_x, -clearance, case_top_z - ribbon_z]) {
            cube ([ribbon_cube_x, ribbon_cube_y, ribbon_cube_z]);
        }
        
        // Lens
        translate([case_top_x/2, case_top_y/2-lens_y_offset, -clearance]) {
            cylinder (d=lens_diameter, h=shell_width+2*clearance, $fn=96);
        }
    }

    // Module stand
    translate([wall_width, case_top_y-wall_width-module_stand_y, shell_width]) {
        cube ([module_stand_x, module_stand_y, module_stand_z]);
    }
    translate([case_top_x-wall_width-module_stand_x, case_top_y-wall_width-module_stand_y, shell_width]) {
        cube ([module_stand_x, module_stand_y, module_stand_z]);
    }
    translate([wall_width, wall_width+module_stand_offset, shell_width]) {
        cube ([module_stand_x, module_stand_y, module_stand_z]);
    }
    translate([case_top_x-wall_width-module_stand_x, wall_width+module_stand_offset, shell_width]) {
        cube ([module_stand_x, module_stand_y, module_stand_z]);
    }

    // Lense cube
    translate_x = case_top_x/2 - lens_cube/2 - lens_cube_wall;
    translate_y = case_top_y/2 - lens_cube/2 - lens_cube_wall - lens_y_offset;

    translate([translate_x, translate_y, shell_width]) {
        difference() {
            cube ([lens_cube+2*lens_cube_wall, lens_cube+2*lens_cube_wall, lens_cube_wall]);
            translate([lens_cube_wall,lens_cube_wall,0]) {
                cube ([lens_cube, lens_cube, lens_cube_wall+clearance]);
            }
            translate([lens_cube/2+lens_cube_wall, lens_cube/2+lens_cube_wall, -clearance]) {
            cylinder (d=lens_diameter, h=shell_width+2*clearance, $fn=96);
        }

        }
    }
}

module lid() {
    
    cube([case_top_x, case_top_y, lid_height]);

    translate([
        wall_width-lip_width+clearance,
        wall_width-lip_width+clearance,
        lid_height]) {

        outer_lip_cube_x = case_top_x-2*wall_width+lip_width+clearance;
        outer_lip_cube_y = case_top_y-2*wall_width+lip_width+clearance;
        outer_lip_cube_z = lip_height;

        inner_lip_cube_x = case_top_x-2*wall_width-lip_width;
        inner_lip_cube_y = case_top_y-2*wall_width-lip_width;
        inner_lip_cube_z = lip_height + 2*clearance;

        difference() {
            
            // Lip cubes
            cube([outer_lip_cube_x, outer_lip_cube_y, outer_lip_cube_z]);
            translate([lip_width, lip_width, -clearance]) {
                cube([inner_lip_cube_x, inner_lip_cube_y, inner_lip_cube_z]);
            }
            
            // Ribbon cut
            ribbon_cube_x = case_top_x - 2*ribbon_offset_x;
            ribbon_cube_y = wall_width+2*clearance;
            ribbon_cube_z = ribbon_z+clearance;

            translate([ribbon_offset_x-(wall_width-lip_width+clearance), -clearance, 0]) {
                cube ([ribbon_cube_x, ribbon_cube_y, ribbon_cube_z]);
            }
        }
    }
    // Module stand
    translate([wall_width, case_top_y-wall_width-module_stand_y, shell_width]) {
        cube ([module_stand_x, module_stand_y, lid_height]);
    }
    translate([case_top_x-wall_width-module_stand_x, case_top_y-wall_width-module_stand_y, shell_width]) {
        cube ([module_stand_x, module_stand_y, lid_height]);
    }
    translate([wall_width, wall_width+module_stand_offset, shell_width]) {
        cube ([module_stand_x, module_stand_y, lid_height]);
    }
    translate([case_top_x-wall_width-module_stand_x, wall_width+module_stand_offset, shell_width]) {
        cube ([module_stand_x, module_stand_y, lid_height]);
    }
}
