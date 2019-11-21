// ParametricGeodesic.scad - an implementation of parametric dome connectors in SCAD
// This consists of a set of modules which can be instantiated to represent differrent types of connectors for domes.
// All sizes are in metric
// Developed by Jason Nelson (authorjcnelson@gmail.com) with much patience from Tara Flannery.
//
use <MCAD/regular_shapes.scad>    

// Chose a part to customize?
part = "all"; // [hubs:Center Hubs,bottoms:Bottom Connectors,all:Hubs and Connectors]

// What type of dome are you building?
dome_type = "1v"; // [1v, 2v]

/* [Custom Materials Settings] */

// Height of strut material
lumber_height = 38; // [1:1000]

// width of strut material
lumber_width = 19; // [1:1000]

// How deep the strut socket is
inset_depth = 12; // [1:200]

// What shape are your struts?
bracket_type = "rectangular"; // [rectangular, circular]

// How thick should the walls be?
wall_thickness = 4; // [2:10]

/* [Hidden] */
// For cutouts, you do not want a face with zero depth - so a cutout needs to overextend - this 
// is used to do that, and shouldn't need to be modified.
cutout_overlap = 5;

// This is again, magic, and should be removed, since it doesn't work
// for hexagons. The intent is to make the center infill work, but that could be fixed in a number
// of ways. This is what causes the minor lines on the 4 way connectors - the hull angles aren't straight.
base_polygon_rotation = 36;

// One linear extruded polygon for the center piece
module scaled_polygon(
                      sides, // number of sides for the polygon
                      radius, // radius of polygon
                      height) // height for it.
{
    linear_extrude(height = height)
    {
        reg_polygon(sides = sides, radius = radius);
    }
}

// This makes the center polygon
// Which has a hollow center.
// Negative shape is used to call twice, once for positive,
// once for negative.
module center_polygon(
                      sides, // number of sides for center polygon
                      radius, // radius of polygon
                      height, // height of polygon
                      wallThickness, // wall thickness for inset/hollow parts
                      negative_shape) // true if outputing the negative or cutout shapes
{
    inset_height = height + wallThickness + cutout_overlap; // The overlap is so we have a clean face cut
    inset_radius = radius - wallThickness;
    if (negative_shape)
    {
        translate([/*x*/ 0, /*y*/ 0, /*z*/ wallThickness])
        {
            scaled_polygon(sides = sides, radius = inset_radius, height = inset_height);
        }
    }
    else
    {
        scaled_polygon(sides = sides, radius = radius, height = height);
    }
}

// This is a single round bracket
// Outputing ONE of these produces a bracket.
module round_bracket(
                diameter, // diameter of the lumber/material
                inset_depth, // How deep the bracket inset is
                wall_thickness, // wall thickness
                negative_shape, // true if we're outputing the negative shapes
                bracket_label)
{
    difference()
    {
        // Calculate how large the exterior bracket needs to be based on
        // the connector diameters.
        outer_radius = (diameter / 2) + (wall_thickness);
        outer_depth = inset_depth + (wall_thickness);
        
         // This is the bracket frame
        // Warning - this breaks non hull configuration brackets
        // but the hull version has better strength.
        if (!negative_shape)
        {
            cylinder(r = outer_radius, h = outer_depth, center = true);
        }
        
        if (negative_shape)
        {
            translate([/*x*/ 0, /*y*/ 0, /*z*/ wall_thickness / 2])
            {                    
                translate([wall_thickness, -wall_thickness, -(inset_depth + 2)])
                rotate([0, 0, 90])
                {
                    linear_extrude(height = 5)
                    {
                        text(bracket_label);   
                    }
                }
                
                // This is the actual inset
                cylinder(r = diameter / 2, h = inset_depth + cutout_overlap * 3, center = true);
                
                // Here be black magic I should refactor and remove - this creates the bolt/screw insets.
                // BUT, this should take a parameter for the radius.
                // The "magic" numbers for rotating 90 degrees aren't evil, that's practically an operation.
                // But the r = 3 below, for 3 mm, is laziness. Fix this at some point whent he brackets actually work.
                rotate([0, 90, 0], center = true)
                translate([0, 0, 0 - (outer_depth + wall_thickness)])
                {
                    cylinder(r = 3, h = outer_depth * 5.5);
                }
            }
        }
    }
}

// This is a single rectangular bracket
// Outputing ONE of these produces a bracket.
// This can be changed to implement a round bracket for PVC by factoring this out into round_bracket
// and rectangle_bracket and so on.
module rectangular_bracket(
                width, // Width of the lumber/material
                height, // height of the lumber/material
                inset_depth, // How deep the bracket inset is
                wall_thickness, // wall thickness
                negative_shape, // true if we're outputing the negative shapes
                bracket_label /*lable for bracket */)
{
    translate([0, 0, inset_depth - (wall_thickness / 2)])
    //difference()
    {
        // Calculate how large the exterior bracket needs to be based on
        // the connector height and width. For round connectors, width and 
        // height would be the same (effectively the radius * 2.
        outer_width = width + (wall_thickness * 2);
        outer_height = height + (wall_thickness * 2);
        outer_depth = inset_depth + (wall_thickness * 2);
        
         // This is the bracket frame
        // Warning - this breaks non hull configuration brackets
        // but the hull version has better strength.
        if (!negative_shape)
        {
            cube(size = [/*x*/ outer_width, /*y*/ outer_height, /*z*/ outer_depth], center = true);
        }
        
        if (negative_shape)
        {
            // Label the brackets
            translate([wall_thickness, -wall_thickness, -inset_depth])
            rotate([0, 0, 90])
            {
                linear_extrude(height = 3)
                {
                    text(bracket_label);   
                }
            }
            
            translate([/*x*/ 0, /*y*/ 0, /*z*/ wall_thickness / 2])
            {                    
                // This is the actual inset
                cube(size = [/*x*/ width, /*y*/ height, /*z*/ inset_depth + cutout_overlap*3], center = true);
                
                // Here be black magic I should refactor and remove - this creates the bolt/screw insets.
                // BUT, this should take a parameter for the radius.
                // The "magic" numbers for rotating 90 degrees aren't evil, that's practically an operation.
                // But the r = 3 below, for 3 mm, is laziness. Fix this at some point whent he brackets actually work.
                rotate([0, 90, 0], center = true)
                translate([0, 0, 0 - (outer_height + wall_thickness*3)])
                {
                    cylinder(r = 3, h = outer_height * 2.5);
                }
            }
        }
    }
}

// This is a single bracket
module bracket(
                width, // Width of the lumber/material
                height, // height of the lumber/material
                inset_depth, // How deep the bracket inset is
                wall_thickness, // wall thickness
                bracket_type, // Round or rectangular
                negative_shape, // true if we're outputing the negative shapes
                bracket_lable /* label for bracket */)
{
    if (bracket_type == "rectangular")
    {
        rectangular_bracket(
                width = lumber_height, 
                height = lumber_width, 
                inset_depth = inset_depth, 
                wall_thickness = wall_thickness,
                negative_shape = negative_shape,
                bracket_label = bracket_lable);        
    }
    else
    {
        round_bracket(
                diameter = lumber_height, 
                inset_depth = inset_depth, 
                wall_thickness = wall_thickness,
                negative_shape = negative_shape,
                bracket_label = bracket_lable);        
    }
}
    
// This outputs a rotated bracket based on the 
// center polygon, rotated and aligned.
module rotated_bracket(
                        center_polygon_radius, // radius of the center polygon
                        center_polygon_height, // height of center polygon
                        number_of_sides, // number of sides to the center polygon - BUGBUG unused???
                        lumber_height, // Height of the lumber for connector (radius *2) for circle
                        lumber_width,  // Width of the lumber. See above for comment about radius. :)
                        wall_thickness,  // Thickness of walls
                        inset_depth, // inset depth for socket
                        rotation_angle, // rotation angle for this one bracket
                        offset_angle, // This is the offset which rotates the bracket to face the polygon's face
                        bracket_type, // the bracket type to output
                        negative_shape, // true of we're outputing a negative shape
                        bracket_label) /* label for bracket */
{
    // Transforms are read from inside out, which confuses the hell out of me.
    // But you want to read from the "bracket" below, up to here to see what's done.
    
    rotated_calculated_height = (sin(rotation_angle) * lumber_height) + wall_thickness * 2;

    // Next, follow the offset angle
    rotate([0, 0, offset_angle])
    // First bend it to the right degree degrees
    // Move it outward
    translate([/*x*/ center_polygon_radius + wall_thickness * 2, /*y*/ 0, /*z*/ 0])
    // Move it up
    translate([/*x*/ 0, /*y*/ 0, rotated_calculated_height - (center_polygon_height /2) /*center_polygon_height - (inset_depth + wall_thickness * 2)*/])
    {
        rotate([0,rotation_angle,0])
        
        bracket(
                width = lumber_height, 
                height = lumber_width, 
                inset_depth = inset_depth, 
                wall_thickness = wall_thickness,
                bracket_type = bracket_type,
                negative_shape = negative_shape,
                bracket_lable = bracket_label);
    }    
}

// Finally the actual connectors.
// This is the hull connector, which is a set of brackets hulled with the center polygon.
// It is probably more effective to design a bracket base which does not need this.
// add a filler to the bracket before rotation, then trim the bottom flat - that would
// get rid of the need to have a set of hulls here and also ditch the supports on the underside.
module center_connector(
                       number_of_sides, /*number of sides to the connector */
                       center_polygon_radius, /*radius of connector*/
                       center_polygon_height, /*height of center connector*/
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       rotation_angle, /*rotation angle for brackets */
                       bracket_type, /*rectangular for rectangle, round for round*/
                       solid_center, /* solid center or hollow */
                       bracket_count, /* to pass fewer brackets if needed */
                       bracket_angles, /* array of bracket angles */
                       bracket_labels /*labels for brackets */)
{
    // We build the center in three passes - baseplate hexagaon
    // followed by bracket solids
    // followed by negative (inset) shapes
    if (bracket_count == 0)
    { 
        bracket_count = number_of_sides;
    }
        
    if (solid_center == false)
    {
        // First, the baseplate
        rotate([0, 0, base_polygon_rotation])
        {
            center_polygon(
                       sides = number_of_sides,
                       radius = center_polygon_radius- wall_thickness, 
                       height = wall_thickness, 
                       wallThickness = wall_thickness, 
                       negative_shape = false);    
        }
    }

    // We're going to difference out the negative shapes
    difference()
    {
        union()
        {
            for (i=[0:(bracket_count - 1)])
            {
                // Disable for angle troubleshooting
                hull()
                {
                    rotated_bracket(
                                    center_polygon_radius = center_polygon_radius,
                                    center_polygon_height = center_polygon_height,
                                    number_of_sides = number_of_sides, 
                                    lumber_height = lumber_height, 
                                    lumber_width = lumber_width, 
                                    wall_thickness = wall_thickness, 
                                    inset_depth = inset_depth, 
                                    rotation_angle = bracket_angles[i],
                                    offset_angle = (360 / number_of_sides) * i,
                                    bracket_type = bracket_type,
                                    negative_shape = false,
                                    bracket_label = bracket_labels[i]);
                    
                    // This is needed to form the underside, but again, 
                    // if we switch to chopping off the base, not needed.
                    // and the hull operations can be removed
                    rotate([0, 0, base_polygon_rotation])
                    {
                    center_polygon(
                               sides = number_of_sides,
                               radius = center_polygon_radius, 
                               height = center_polygon_height, 
                               wallThickness = wall_thickness, 
                               negative_shape = false);
                    }
                }
            }
        }
        // Everything after this will be cut out of the object we've created.
        // If we want a solid center (for strength) this would need to be
        // conditional
        if (solid_center == false)
        {
            rotate([0, 0, base_polygon_rotation])
            {
                center_polygon(
                           sides = number_of_sides,
                           radius = center_polygon_radius- wall_thickness, 
                           height = center_polygon_height * 2, 
                           wallThickness = wall_thickness, 
                           negative_shape = true);          
            }
        }
        for (i=[0:(bracket_count - 1)])
        {
            rotated_bracket(
                            center_polygon_radius = center_polygon_radius,
                            center_polygon_height = center_polygon_height,
                            number_of_sides = number_of_sides, 
                            lumber_height = lumber_height, 
                            lumber_width = lumber_width, 
                            wall_thickness = wall_thickness, 
                            inset_depth = inset_depth, 
                            rotation_angle = bracket_angles[i],
                            offset_angle = (360 / number_of_sides) * i,
                            bracket_type = bracket_type,   
                            negative_shape = true,
                            bracket_label = bracket_labels[i]);    
        }
    }
}

// This is the 1v centerpiece
module onev_center_hexagon(
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       bracket_type /*rectangular for rectangle, round for round*/)
{
    number_of_sides = 5;
    rotation_angle = 90 - 31.73; /*rotation angle for brackets */
    
    calculated_height = (sin(rotation_angle) * lumber_height);
    
    // Calculate radius from our connector + # of sides for a regular polygon
    center_polygon_radius = (lumber_width + wall_thickness / 2) / (2 * sin(180/number_of_sides));
    one_vbracket_angles = 
                         [
                            rotation_angle, 
                            rotation_angle, 
                            rotation_angle, 
                            rotation_angle, 
                            rotation_angle, 
                            rotation_angle
                        ];

    one_vbracket_labels = 
                         [
                            "A", 
                            "A", 
                            "A", 
                            "A", 
                            "A", 
                            "A"
                        ];
                        
    center_connector(
                   number_of_sides = number_of_sides, 
                   center_polygon_radius = center_polygon_radius,
                   center_polygon_height = calculated_height,
                   wall_thickness = wall_thickness,
                   lumber_height = lumber_height,
                   lumber_width = lumber_width,
                   inset_depth = inset_depth,
                   rotation_angle = rotation_angle,
                   bracket_type = bracket_type,
                   bracket_count = number_of_sides,
                   bracket_angles = one_vbracket_angles,
                   bracket_labels = one_vbracket_labels);        
}

// This is the ground piece
module ground_piece(
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       bracket_type, /*rectangular for rectangle, round for round*/
                       number_of_sides, /*number of sides*/
                       bracket_count, /*count of brackets */
                       bracket_angles, /*angles to rotate individual brackets */
                       bracket_labels /* labels for bracket */)
{
    calculated_height = (sin(rotation_angle) * lumber_height) + wall_thickness * 2;
    
    // Calculate radius from our connector + # of sides for a regular polygon
    center_polygon_radius = (lumber_width + wall_thickness / 2) / (2 * sin(180/number_of_sides));

    difference()
    {
        rotate([90, 0, 0]) 
        {   
            center_connector(
                           number_of_sides = number_of_sides, 
                           center_polygon_radius = center_polygon_radius,
                           center_polygon_height = calculated_height,
                           wall_thickness = wall_thickness,
                           lumber_height = lumber_height,
                           lumber_width = lumber_width,
                           inset_depth = inset_depth,
                           rotation_angle = rotation_angle,
                           bracket_type = bracket_type,
                           bracket_count = bracket_count,
                           bracket_angles = bracket_angles,
                           bracket_labels = bracket_labels);
        }    
        
        // This slices the bottom half off, yielding a four star connector
        bracket_extension = (sin(rotation_angle) * calculated_height) + wall_thickness * 2;

        translate(
                   [
                       -(bracket_extension + center_polygon_radius), 
                       -(calculated_height + (wall_thickness * 2) + cutout_overlap * 1.5), 
                       -(center_polygon_radius + lumber_width/2 + wall_thickness)
                   ])
        {
             cube(
                    [
                      center_polygon_radius * 2 + bracket_extension * 2, 
                      calculated_height + (wall_thickness * 2) + cutout_overlap * 2, 
                      center_polygon_radius
                     ]);
        }
     }
}

// This is the 1v Ground
module onev_ground_piece(
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       bracket_type /*rectangular for rectangle, round for round*/)
{
    number_of_sides = 6;
    rotation_angle = 90 - 31.73; /*rotation angle for brackets */
        
    // Calculate radius from our connector + # of sides for a regular polygon
    center_polygon_radius = (lumber_width + wall_thickness / 2) / (2 * sin(180/number_of_sides));
    bracket_angles = [rotation_angle, rotation_angle, rotation_angle, rotation_angle];
    one_vbracket_labels = 
                         [
                            "A", 
                            "A", 
                            "A", 
                            "A", 
                            "A", 
                            "A"
                        ];
    
    ground_piece(
                 rotation_angle = rotation_angle, /*rotation angle for height calculation */
                 wall_thickness = wall_thickness, /*wall thickness */
                 lumber_height = lumber_height, /*height of lumber/connector */
                 lumber_width = lumber_width, /* width of lumber/connector */
                 inset_depth = inset_depth, /*inset depth for brackets */
                 bracket_type = bracket_type, /*rectangular for rectangle, round for round*/
                 number_of_sides = number_of_sides, /*number of sides*/
                 bracket_count = 4, /*count of brackets */
                 bracket_angles = bracket_angles, /*angles to rotate individual brackets */
                 bracket_labels = one_vbracket_labels);
}

// This is the 2v centerpiece
module twov_center_pentagon_piece(
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       bracket_type /*rectangular for rectangle, round for round*/)
{
    number_of_sides = 5;
    rotation_angle = 90 - 15.86; /* 15.86 rotation angle for brackets */
    calculated_height = (sin(rotation_angle) * lumber_height) + wall_thickness * 2;
    
    // Calculate radius from our connector + # of sides for a regular polygon
    center_polygon_radius = (lumber_width + wall_thickness / 2) / (2 * sin(180/number_of_sides));
    two_vbracket_angles = [rotation_angle, rotation_angle, rotation_angle, rotation_angle, rotation_angle, rotation_angle]; 

    two_vbracket_labels = 
                         [
                            "A", 
                            "A", 
                            "A", 
                            "A", 
                            "A", 
                            "A"
                        ];
    
    center_connector(
                   number_of_sides = number_of_sides, 
                   center_polygon_radius = center_polygon_radius,
                   center_polygon_height = calculated_height,
                   wall_thickness = wall_thickness,
                   lumber_height = lumber_height,
                   lumber_width = lumber_width,
                   inset_depth = inset_depth,
                   rotation_angle = rotation_angle,
                   bracket_type = bracket_type,
                   bracket_count = number_of_sides,
                   bracket_angles = two_vbracket_angles,
                   bracket_labels = two_vbracket_labels);    
}

// This is the 2v hexagon centerpiece
module twov_center_hexagon_piece(
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       bracket_type /*rectangular for rectangle, round for round*/)
{
    number_of_sides = 6;
    rotation_angle = 90 - 15.86; /* 15.86 rotation angle for brackets */
    twov_angle_a = 90 - 15.86; /*rotation angle for brackets */
    twov_angle_b = 90 - 18; /*rotation angle for brackets */

    calculated_height = (sin(rotation_angle) * lumber_height) + wall_thickness * 2;
    
    // Calculate radius from our connector + # of sides for a regular polygon
    center_polygon_radius = (lumber_width + wall_thickness / 2) / (2 * sin(180/number_of_sides));
    two_vbracket_angles = [twov_angle_a, twov_angle_b, twov_angle_b, twov_angle_a, twov_angle_b, twov_angle_b]; 
    two_vbracket_labels = 
                         [
                            "A", 
                            "B", 
                            "B", 
                            "A", 
                            "B", 
                            "B"
                        ];
    
    center_connector(
                   number_of_sides = number_of_sides, 
                   center_polygon_radius = center_polygon_radius,
                   center_polygon_height = calculated_height,
                   wall_thickness = wall_thickness,
                   lumber_height = lumber_height,
                   lumber_width = lumber_width,
                   inset_depth = inset_depth,
                   rotation_angle = rotation_angle,
                   bracket_type = bracket_type,
                   bracket_count = number_of_sides,
                   bracket_angles = two_vbracket_angles,
                   bracket_labels = two_vbracket_labels);    
}

// This is the 2v Ground
module twov_ground_piece(
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       bracket_type, /*rectangular for rectangle, round for round*/
                       twov_bracket_angles, /*bracket angles for this round */
                       twov_bracket_lables)
{
    number_of_sides = 6;
    height_rotation_angle = 90 - 31.73; /*rotation angle for brackets */
        
    // Calculate radius from our connector + # of sides for a regular polygon
    center_polygon_radius = (lumber_width + wall_thickness / 2) / (2 * sin(180/number_of_sides));
    ground_piece(
                 rotation_angle = height_rotation_angle, /*rotation angle for height calculation */
                 wall_thickness = wall_thickness, /*wall thickness */
                 lumber_height = lumber_height, /*height of lumber/connector */
                 lumber_width = lumber_width, /* width of lumber/connector */
                 inset_depth = inset_depth, /*inset depth for brackets */
                 bracket_type = bracket_type, /*rectangular for rectangle, round for round*/
                 number_of_sides = number_of_sides, /*number of sides*/
                 bracket_count = 4, /*count of brackets */
                 bracket_angles = twov_bracket_angles, /*angles to rotate individual brackets */
                 bracket_labels = twov_bracket_labels /* labels for brackets */);
}

// This is the 2v Ground
module twov_babb_ground_piece(
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       bracket_type /*rectangular for rectangle, round for round*/)
{
    twov_angle_a = 90 - 15.86; /*rotation angle for brackets */
    twov_angle_b = 90 - 18; /*rotation angle for brackets */
        
    twov_babb_bracket_angles = [twov_angle_b, twov_angle_a, twov_angle_b, twov_angle_b];
    two_vbracket_labels = 
                         [
                            "B", 
                            "A", 
                            "B", 
                            "B", 
                        ];
    
    twov_ground_piece(
                 wall_thickness = wall_thickness, /*wall thickness */
                 lumber_height = lumber_height, /*height of lumber/connector */
                 lumber_width = lumber_width, /* width of lumber/connector */
                 inset_depth = inset_depth, /*inset depth for brackets */
                 bracket_type = bracket_type, /*rectangular for rectangle, round for round*/
                 twov_bracket_angles = twov_babb_bracket_angles, /*angles to rotate individual brackets */
                 twov_bracket_labels = two_vbracket_labels /* labels for brackets */);
}

// This is the 2v Ground
module twov_bbab_ground_piece(
                       wall_thickness, /*wall thickness */
                       lumber_height, /*height of lumber/connector */
                       lumber_width, /* width of lumber/connector */
                       inset_depth, /*inset depth for brackets */
                       bracket_type /*rectangular for rectangle, round for round*/)
{
    twov_angle_a = 90 - 15.86; /*rotation angle for brackets */
    twov_angle_b = 90 - 18; /*rotation angle for brackets */
        
    twov_babb_bracket_angles = [twov_angle_b, twov_angle_b, twov_angle_a, twov_angle_b];
    two_vbracket_labels = 
                         [
                            "B", 
                            "B", 
                            "A", 
                            "B", 
                        ];

    twov_ground_piece(
                 wall_thickness = wall_thickness, /*wall thickness */
                 lumber_height = lumber_height, /*height of lumber/connector */
                 lumber_width = lumber_width, /* width of lumber/connector */
                 inset_depth = inset_depth, /*inset depth for brackets */
                 bracket_type = bracket_type, /*rectangular for rectangle, round for round*/
                 twov_bracket_angles = twov_babb_bracket_angles, /*angles to rotate individual brackets */
                 twov_bracket_labels = two_vbracket_labels /* labels for brackets */);
}

if (dome_type == "1v")
{
    // [hubs:Center Hubs,bottoms:Bottom Connectors,all:Hubs and Connectors]
   
    if (part == "hubs" || part == "all")
    {
        onev_center_hexagon(
                       wall_thickness = wall_thickness,
                       lumber_height = lumber_height,
                       lumber_width = lumber_width,
                       inset_depth = inset_depth,
                       bracket_type = bracket_type);
    }

    if (part == "bottoms" || part == "all")
    {    
        translate([250,0,0])
        onev_ground_piece(
                       wall_thickness = wall_thickness,
                       lumber_height = lumber_height,
                       lumber_width = lumber_width,
                       inset_depth = inset_depth,
                       bracket_type = bracket_type);    
    }   
}
else if (dome_type == "2v")
{
    if (part == "hubs" || part == "all")
    {    
        twov_center_pentagon_piece(
                       wall_thickness = wall_thickness,
                       lumber_height = lumber_height,
                       lumber_width = lumber_width,
                       inset_depth = inset_depth,
                       bracket_type = bracket_type);

        translate([250,0,0])
        twov_center_hexagon_piece(
                       wall_thickness = wall_thickness,
                       lumber_height = lumber_height,
                       lumber_width = lumber_width,
                       inset_depth = inset_depth,
                       bracket_type = bracket_type);
    }
    
    if (part == "bottoms" || part == "all")
    {     
        translate([250,250,0])
        twov_babb_ground_piece(
                       wall_thickness = wall_thickness,
                       lumber_height = lumber_height,
                       lumber_width = lumber_width,
                       inset_depth = inset_depth,
                       bracket_type = bracket_type);
        
         translate([0,250,0])   
        twov_bbab_ground_piece(
                       wall_thickness = wall_thickness,
                       lumber_height = lumber_height,
                       lumber_width = lumber_width,
                       inset_depth = inset_depth,
                       bracket_type = bracket_type);    
    }
}               
               