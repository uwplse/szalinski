/*
 * module_support_frame.scad
 * v1.0.1 6th April 2017
 * Written by landie @ Thingiverse (Dave White)
 *
 * This script is licensed under the Creative Commons - Attribution - Non-Commercial license.
 *
 * http://www.thingiverse.com/thing:2147533
 *
 * This library/project allows you to create 1, 2 and 3 module size support frames,
 * suitable for use with CBE covers and CBE and C-Link modules.
 * This can then be customised to support your own modules or printed
 * in whatever colour suits your installation. The standard CBE covers fit over the module
 * and optionally it can take CBE and/or C-Link modules.
 * Please read the hull_layer_thickness instructions CAREFULLY !
 */

// Variables you may want to adjust...

// The size of the frame when used standalone
numberOfCells = 1; //[1:Single,2:Double,3:Triple]

// Should cutout module panels
cutoutModules = 1; // [1:Yes,0:No]

// This should probably be set to the layer height you intend to print with or higher. The stepping effect is 
// completely hidden by the CBE cover so  it's up to you really how long you want to wait for it to render !
// Setting it to a high value (2, for example) will make rendering MUCH quicker but reduce quality
// Setting it to a finer value than your printer layer height will make it look prettier on screen but take a LONG time to render
// 1 is a good compromise while working on your design in OpenScad, 0.2 is good for printing to give a pleasing finish
// even if nobody ever sees it !
// Smaller value gives a smoother finish but will take much longer to process, not visible when the frame is on.
hull_layer_thickness = 1; //[0.1,0.2,0.4,0.6,0.8,1]

/* [Hidden] */

// The following variables probably won't need adjusting unless you want to adapt the frame for use with a different vendor's cover.
corner_rad = 8; // the radious of the outer corner of the frame
end_rad = 200; // the curve used at each end of the frame
thickness = 8; // the overall depth of the frame

end_thickness = 13; // used to calculate the overall width of the frame, added on to the cell width for each end
end_corner_inset = 10; // how far in form the end of the frame do the outer corner centres sit

hull_wall_thickness = 3; // the wall thickness of the basic frame

cell_width = 54; // the total width allowed for each module
cell_height = 54; // the total height allowed for each module

height = 72; // The overall height of the frame base

cell_corner_radius = 8; // The corner radius for the module cutouts
cell_plate_width = 47; // the width of the module cutouts
cell_plate_height = 47; // the height of the module cutouts

mounting_bolt_support_dia = 7; // the diameter of the tube that the mounting screws/bolts go through
mounting_bolt_dia = 3.5; // the diameter of the hole for the screws to go through
mounting_bolt_cutout_dia = 6; // the diameter of the cutout for the screw head
mounting_hole_inset = 4; // How far in from the edge should the screw centre be ?

end_locator_spacing = 50; // the space between centres of the two round cutouts at each end of the frame

// These are all used for the creation of the clips that are cut into the top/bottom of the frame
clip_cutout_top = 20; // The width of the main cutout at the top of the frame
clip_cutout_bottom = 16; // The width of the main cutout at the bottom of the frame
clip_cutout_depth = 4; // The depth of the main cutout in the frame
clip_extra_bottom = 12.5; // The bottom width of the additional cutout below the clip "tooth"
clip_extra_top = 10; // The top width of the additional cutout below the clip "tooth"
clip_extra_height = 6; // The height of the additional cutout for the clip "tooth"
clip_extra_depth = 1; // The depth of the additional cutout for the clip "tooth"
clip_backing_width = 22; // the width of the additional material that is added to form the back of the clip
clip_backing_depth = 7; // the depth of the additional material that is added to form the back of the clip
clip_tooth_width = 10; // The width of the tooth in the clip
clip_tooth_depth = 2; // The thickness of teh tooth
clip_tooth_inset = 2; // The gap between the edge of the tooth and teh edge of the frame
clip_tooth_height = 4; // The hight of the bottom of the tooth

// these variables are used to build the small locating rectangles that stick out at each end of the frame
location_tooth_width = 9; // the width of the rectangle
location_tooth_height = 1.5; // the height of the rectangle
location_tooth_outset = 3; // How far out the rectangle sticks from the frame

// These variables are used to create the locating pegs and supports for the modules
module_location_distance = 46; // The spacing between each peg position
module_location_peg_dia = 3; // The diameter of the actual peg
module_location_peg_depth = 4; // How hight the peg sticks above the face
module_location_standoff_depth = 1; // The height of the small rectangular supports
module_location_standoff_width = 1; // The width of the small rectangular supports
module_location_standoff_height = 7; // The length of the small rectangular supports

// These variables are used to space out the clips when more than one per side are used
clip_spacing_3 = 107; // Spacing between the clips when there are 3 module positions
clip_spacing_2 = 78; // Spacing between the clips when there are 2 module positions

// the default smoothing for round surfaces
$fn = 65;

// You should really comment this out if using as an included library
// you can then call it from your source code
// This call creates the frame with the first parameter being the number of cells (1,2 or 3)
// The second parameter (true or false) determines if the frame should include module positions or just be blank
support_frame(numberOfCells, (cutoutModules == 1));

module support_frame(cells = numberOfCells, with_modules = (cutoutModules == 1), hull_resolution = hull_layer_thickness) {
    if (cells > 0 && cells < 4) {
        difference() {
            union() {
                basic_hull(cells, hull_resolution);
                addons(cells);
                if (with_modules)
                    cell_addons(cells);
            }
            cutouts(cells);
            if (with_modules)
                cell_cutouts(cells);
        }        
    }
}

module basic_hull(cells = 1, hull_resolution = hull_layer_thickness) {
    //render() {
        difference() {
            basic_3d_hull(cells, hull_resolution, 0);
            basic_3d_hull(cells, hull_resolution, hull_wall_thickness, hull_wall_thickness);
            plate_cutout(cells);
        }
    //}
}

module basic_3d_hull(cells = 1, step = 1, extra_inset = 0, cap = 0) {
    //hull() {
        for (x = [0:step:thickness - step - cap]) {
            if (x == 0) {
                linear_extrude(step) basic_2d_hull(cells, extra_inset);
            } else if (x == thickness - step) {
                translate([0,0,thickness - step])
                linear_extrude(step) basic_2d_hull(cells, thickness / 2 + extra_inset);
            } else {
                angle = (90 / thickness) * x;
                hypotenuse = thickness;
                inset = (thickness - (hypotenuse * cos(angle))) / 2;
                translate([0,0,x])
                linear_extrude(step) basic_2d_hull(cells, inset + extra_inset);
            }
        }
    //}
}

module basic_2d_hull(cells = 2, inset = 0) {
    $fn = 100;
    corner_centre_width = cell_width * cells + (end_thickness - end_corner_inset) * 2;
    corner_centre_height = height - corner_rad * 2;
    overall_width = cell_width * cells + end_thickness * 2;
    offset(delta = inset * -1)
    hull() {
        translate([-corner_centre_width / 2, corner_centre_height / 2]) circle(r = corner_rad, center = true);
        translate([corner_centre_width / 2, corner_centre_height / 2]) circle(r = corner_rad, center = true);
        translate([-corner_centre_width / 2, -corner_centre_height / 2]) circle(r = corner_rad, center = true);
        translate([corner_centre_width / 2, -corner_centre_height / 2]) circle(r = corner_rad, center = true);
        intersection() {
            color("red") translate([end_rad - overall_width / 2,0,0]) circle(r = end_rad, centre = true);
            color("blue") translate([-end_rad + overall_width / 2,0,0]) circle(r = end_rad, centre = true);
            translate([0,0,0])square([overall_width + 50, height - corner_rad * 2], center = true);
        }
    }
}

module plate_cutout(depth = thickness + 1, offset = 0) {
    $fn = 100;
    actual_plate_width = cell_plate_width + offset;
    actual_plate_height = cell_plate_height + offset;
    hull() {
        translate([actual_plate_width / 2 - cell_corner_radius, actual_plate_height / 2 - cell_corner_radius, depth / 2])
            cylinder(r = cell_corner_radius, h = depth, center = true);
        translate([-actual_plate_width / 2 + cell_corner_radius, actual_plate_height / 2 - cell_corner_radius, depth / 2])
            cylinder(r = cell_corner_radius, h = depth, center = true);
        translate([actual_plate_width / 2 - cell_corner_radius, -actual_plate_height / 2 + cell_corner_radius, depth / 2])
            cylinder(r = cell_corner_radius, h = depth, center = true);
        translate([-actual_plate_width / 2 + cell_corner_radius, -actual_plate_height / 2 + cell_corner_radius, depth / 2])
            cylinder(r = cell_corner_radius, h = depth, center = true);
    }
}

module location_pegs() {
    translate([module_location_distance / 2, module_location_distance / 2, thickness - hull_wall_thickness])
        location_peg();
    translate([-module_location_distance / 2, -module_location_distance / 2, thickness - hull_wall_thickness])
        location_peg();
    translate([-module_location_distance / 2, module_location_distance / 2, thickness - hull_wall_thickness])
        rotate([0,0,90])
        location_peg(false);
    translate([module_location_distance / 2, -module_location_distance / 2, thickness - hull_wall_thickness])
        rotate([0,0,90])
        location_peg(false);
}

module location_peg(with_peg = true) {
    if (with_peg) {
        translate([0,0,-module_location_peg_depth / 2])
        cylinder(d = module_location_peg_dia, h = module_location_peg_depth, center = true);
    }
    rotate([0,0,45])
    translate([0,0,-module_location_standoff_depth / 2])
    cube([module_location_standoff_width, module_location_standoff_height, module_location_standoff_depth], center = true);
}

module clip_cutout() {
    difference() {
        union() {
            // larger cutout
            hull() {
                translate([-clip_cutout_bottom / 2, -clip_cutout_depth, 0])
                cube([clip_cutout_bottom, clip_cutout_depth, 0.1], center = false);
                translate([-clip_cutout_top / 2, -clip_cutout_depth, thickness])
                cube([clip_cutout_top, clip_cutout_depth, 0.1], center = false);
            }
            // smaller cutout for clip
            hull() {
                translate([-clip_extra_bottom / 2, -clip_cutout_depth - clip_extra_depth, 0])
                cube([clip_extra_bottom, clip_cutout_depth, 0.1], center = false);
                translate([-clip_extra_top / 2, -clip_cutout_depth - clip_extra_depth, clip_extra_height])
                cube([clip_extra_top, clip_cutout_depth, 0.1], center = false);
            }
        }
        // clip peg
        hull() {
            peg_height = clip_cutout_depth + clip_extra_depth - clip_tooth_inset;
            translate([0,-peg_height/2 - clip_tooth_inset,0.05 + clip_tooth_height]) cube([clip_tooth_width, peg_height, 0.1], center = true);
            translate([0,-peg_height/2 - clip_tooth_inset * 2,0.05 + clip_tooth_height + clip_tooth_depth]) cube([clip_tooth_width, peg_height - clip_tooth_inset, 0.1], center = true);
        }
    }
}

module addons(cells = 1) {
    overall_width = cell_width * cells + end_thickness * 2;
    intersection() {
        basic_3d_hull(cells, hull_layer_thickness, 0);
        translate([overall_width / 2 - mounting_hole_inset, 0, thickness / 2])
            cylinder(d = mounting_bolt_support_dia, h = thickness, center = true);
    }
    intersection() {
        basic_3d_hull(cells, hull_layer_thickness, 0);
        translate([-overall_width / 2 + mounting_hole_inset, 0, thickness / 2])
            cylinder(d = mounting_bolt_support_dia, h = thickness, center = true);
    }
    
    if (cells == 3) {
        // add supports for center screw mounts
        intersection() {
            basic_3d_hull(cells, hull_layer_thickness, 0);
            translate([0, height / 2 - mounting_hole_inset, thickness / 2])
                cylinder(d = mounting_bolt_support_dia, h = thickness, center = true);
        }
        intersection() {
            basic_3d_hull(cells, hull_layer_thickness, 0);
            translate([0, -height / 2 + mounting_hole_inset, thickness / 2])
                cylinder(d = mounting_bolt_support_dia, h = thickness, center = true);
        }
    }
    
    clip_addons(cells);
    
    // location pegs
    translate([location_tooth_outset / 2 + overall_width / 2 - 1, 0, location_tooth_height / 2])
    cube([location_tooth_outset, location_tooth_width, location_tooth_height], center = true);
    translate([-location_tooth_outset / 2 - overall_width / 2 + 1, 0, location_tooth_height / 2])
    cube([location_tooth_outset, location_tooth_width, location_tooth_height], center = true);
}

module cutouts(cells = 1) {
    overall_width = cell_width * cells + end_thickness * 2;
    translate([overall_width / 2 - mounting_hole_inset, 0, thickness / 2])
            cylinder(d = mounting_bolt_dia, h = thickness, center = true);
    translate([-overall_width / 2 + mounting_hole_inset, 0, thickness / 2])
            cylinder(d = mounting_bolt_dia, h = thickness, center = true);
    
    translate([overall_width / 2 - mounting_hole_inset, 0, thickness / 2 + 3])
            cylinder(d = mounting_bolt_cutout_dia, h = thickness, center = true);
    translate([-overall_width / 2 + mounting_hole_inset, 0, thickness / 2 + 3])
            cylinder(d = mounting_bolt_cutout_dia, h = thickness, center = true);
    
   if (cells == 3) {
    // cutouts for center screw mounts
        translate([0, height / 2 - mounting_hole_inset, thickness / 2])
            cylinder(d = mounting_bolt_dia, h = thickness, center = true);
        translate([0, -height / 2 + mounting_hole_inset, thickness / 2])
            cylinder(d = mounting_bolt_dia, h = thickness, center = true);
       
       translate([0, height / 2 - mounting_hole_inset, thickness / 2 + 3])
            cylinder(d = mounting_bolt_cutout_dia, h = thickness, center = true);
        translate([0, -height / 2 + mounting_hole_inset, thickness / 2 + 3])
            cylinder(d = mounting_bolt_cutout_dia, h = thickness, center = true);
    }
    
    // small end cutouts
    translate([overall_width / 2, end_locator_spacing / 2, thickness / 2])
            cylinder(d = mounting_bolt_cutout_dia, h = thickness, center = true);
    translate([-overall_width / 2, -end_locator_spacing / 2, thickness / 2])
            cylinder(d = mounting_bolt_cutout_dia, h = thickness, center = true);
    translate([overall_width / 2, -end_locator_spacing / 2, thickness / 2])
            cylinder(d = mounting_bolt_cutout_dia, h = thickness, center = true);
    translate([-overall_width / 2, end_locator_spacing / 2, thickness / 2])
            cylinder(d = mounting_bolt_cutout_dia, h = thickness, center = true);
    
    clip_cutouts(cells);
}

module cell_cutouts(cells = 1) {
    if (cells == 1)
        plate_cutout();
    else if (cells == 2) {
        translate([cell_width / 2,0,0])
            plate_cutout();
        translate([-cell_width / 2,0,0])
            plate_cutout();
    } else if (cells == 3) {
        plate_cutout();
        translate([cell_width,0,0])
            plate_cutout();
        translate([-cell_width,0,0])
            plate_cutout();
    }
}

module cell_addons(cells = 1) {
    if (cells == 1)
        location_pegs();
    else if (cells == 2) {
        translate([cell_width / 2,0,0])
            location_pegs();
        translate([-cell_width / 2,0,0])
            location_pegs();
    } else if (cells == 3) {
        location_pegs();
        translate([cell_width,0,0])
            location_pegs();
        translate([-cell_width,0,0])
            location_pegs();
    }
}

module clip_addons(cells = 1) {
    if (cells == 1) {
        clip_addon_pair(cells);
    } else if (cells == 2) {
        translate([clip_spacing_2 / 2, 0, 0]) 
            clip_addon_pair(cells);
        translate([-clip_spacing_2 / 2, 0, 0]) 
            clip_addon_pair(cells);
    } else if (cells == 3) {
        translate([clip_spacing_3 / 2, 0, 0]) 
            clip_addon_pair(cells);
        translate([-clip_spacing_3 / 2, 0, 0]) 
            clip_addon_pair(cells);
    }
}

module clip_addon_pair(cells) {
    // clip hole backings
    intersection() {
        basic_3d_hull(cells, hull_layer_thickness, 0);
        translate([0, height / 2 - clip_backing_depth / 2, thickness / 2])
            cube([clip_backing_width,clip_backing_depth,thickness], center = true);
    }
    intersection() {
        basic_3d_hull(cells, hull_layer_thickness, 0);
        translate([0, -height / 2 + clip_backing_depth / 2, thickness / 2])
            cube([clip_backing_width,clip_backing_depth,thickness], center = true);
    }
}

module clip_cutouts(cells = 1) {
    if (cells == 1) {
        clip_pair();
    } else if (cells == 2) {
        translate([clip_spacing_2 / 2, 0, 0]) 
            clip_pair();
        translate([-clip_spacing_2 / 2, 0, 0]) 
            clip_pair();
    } else if (cells == 3) {
        translate([clip_spacing_3 / 2, 0, 0]) 
            clip_pair();
        translate([-clip_spacing_3 / 2, 0, 0]) 
            clip_pair();
    }
}

module clip_pair() {
    // clip cutouts/formers
    translate([0,height /2, 0])
    clip_cutout();
    translate([0,-height /2, 0])
    rotate([0,0,180])
    clip_cutout();
}