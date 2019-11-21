// A parametric filter wrench tool for OpenSCAD
//
// Erik Ness
// erik@nessnation.com
//
// NOTE:  All dimensions in mm except ratchet size
//
// Version 6:  2017 03 29 Added 1/4" drive, did not build or test it.
//             Not recommended, but requested by a user.
//
// version 5:  Use face-to-face measurement for even number of sides


//-------------------------------------------
//        User-entered parameters
//
//  Formatted for thingiverse customizer.
//-------------------------------------------

// Number of faces on filter body:
num_faces = 12;                     // [6:30]

// Diameter of filter body in mm.  Measure from face to face (even) or face to vertex (odd).
filter_diameter_mm = 72;

// Depth of usable portion of tool in mm.  (Height above bottom and drive).
usable_tool_depth_mm = 29;

// Ratchet drive size in inches.
drive_size_inches = 0.5;            // [0.25, 0.375, 0.5]

// Thickness of tool wall in mm.
wall_thickness_mm = 6;

// Thickness of tool bottom in mm.
bottom_thickness_mm = 4;

// Make the outside round?
round_outside = 0;                  // [0:No,1:Yes]




/* [Hidden] */

$fn=50;

// Compute the radius from center to inner corner:
angle = 180 / num_faces;
r_to_face_if_odd_mm = (cos(angle) / (1+cos(angle))) * filter_diameter_mm;
R_if_even_mm = (filter_diameter_mm / 2) / cos(angle);
is_odd = (num_faces % 2);
radius_to_corners_mm = is_odd ? filter_diameter_mm - r_to_face_if_odd_mm : R_if_even_mm;     // from center to "corner", not face
filter_slop_r_mm = 0.33;

//echo (radius_to_corners_mm);

// 1/2" drive is exactly 8.98mm radius
// 3/8" drive is exactly 6.74mm radius
// 1/4" drive is (maybe) 4.49mm radius (not recommended, not tested)
drive_hole_r_mm = (drive_size_inches < 0.3) ?  4.49 :     // 1/4" drive
                  (drive_size_inches > 0.4) ?  8.98 :     // 1/2" drive
                  6.74;                                   // 3/8" drive

// 1/2" drive is 16mm tall
// 3/8" drive is 11mm tall
// 1/4" drive is  9mm tall
drive_height_mm = (drive_size_inches < 0.3) ?  9.00 :     // 1/4" drive  
                  (drive_size_inches > 0.4) ? 16.00 :     // 1/2" drive
                  11.00;                                  // 3/8" drive

drive_hole_slop_r_mm = 0.33;
drive_thickness_r_mm = drive_hole_r_mm;

outside_faces = round_outside ? 100 : num_faces;
outside_height_mm = usable_tool_depth_mm + max(drive_height_mm,bottom_thickness_mm);



difference()
{
    union()
    {
        difference()
        {
            // Outside body:
            linear_extrude(outside_height_mm)
                my_regular_polygon(outside_faces, radius_to_corners_mm+wall_thickness_mm);
            
            // Main Polygon hole:
            translate([0,0,bottom_thickness_mm])
                linear_extrude(outside_height_mm - bottom_thickness_mm)
                    offset(filter_slop_r_mm)
                        my_regular_polygon(num_faces, radius_to_corners_mm);
        }

        // Drive body:
        linear_extrude(drive_height_mm)
            offset(drive_hole_slop_r_mm)
                my_regular_polygon(16,drive_hole_r_mm+drive_thickness_r_mm);
    }

    // Drive hole:
    linear_extrude(drive_height_mm)
        offset(drive_hole_slop_r_mm)
            my_regular_polygon(4,drive_hole_r_mm);
}





module my_regular_polygon(faces, radius)
{
    $fn = faces;
    circle(radius);
}
