part = 0; // [0:base,1:lid]

// Bigger is smoother
corner_smoothness = 30;
// Holes for magnets?
magnets = 1; // [0:No,1:Yes]
// Magnet hole diameter (mm)
magnet_diameter = 10.11;
// Magnet hole thicknes (mm)
magnet_thickness = 3;
// Size across the flat sides of the hole (mm)
hole_diameter = 22;
// Depth of hole in base (mm)
hole_depth = 7;
// Holes in lid?
holes_in_lid = 1; // [0:No,1:Yes]
// Clearance between lid and base (mm)
lid_clearance = 0.75;
// Add thumb cutout to lid
thumb_cutout = 1; // [0:No,1:Yes]
// Number of holes in X direction
x_num = 3; //[1, 3, 5, 7, 9]
// Number of holes in Y direction
y_num = 5; //[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

/* [Hidden] */
$fn = corner_smoothness;
hex_flats_diameter = hole_diameter;
hex_points_diameter = hex_flats_diameter * (2 / sqrt(3));
hex_side_length = hex_flats_diameter / sqrt(3);
hex_spacing = 2;
hex_corner_radius = 3;
base_hex_height = hole_depth;
base_wall_thickness = 2;
base_bottom_thickness = 3;
base_corner_radius = 2;
base_height = base_bottom_thickness + base_hex_height;
lid_hex_height = hex_flats_diameter - base_hex_height;
lid_wall_thickness = base_wall_thickness;
lid_top_thickness = base_bottom_thickness;
lid_corner_radius = base_corner_radius;
lid_height = lid_top_thickness + lid_hex_height;
magnet_offset = base_wall_thickness + hex_side_length / 2 - hex_spacing / 2;
thumb_grip_width = 20;

x_long_num = ceil(x_num / 2);
x_short_num = floor(x_num / 2);

base_width = (hex_points_diameter * x_long_num) + (hex_side_length * x_short_num)  + (hex_spacing * (x_num - 1)) + (base_wall_thickness * 2);
base_length = (hex_flats_diameter * y_num) + (hex_spacing * (y_num - 1)) + (base_wall_thickness * 2);
lid_width = base_width + lid_clearance * 2 + (base_wall_thickness * 2);
lid_length = base_length + lid_clearance * 2 + (base_wall_thickness * 2);

echo("hex flats diameter", hex_flats_diameter);
echo("hex points diameter", hex_points_diameter);
echo("hex side length", hex_side_length);
echo("base width", base_width);
echo("base length", base_length);
echo("base height", base_height);
echo("lid width", lid_width);
echo("lid length", lid_length);
echo("lid height", lid_height);
echo("magnet offset", magnet_offset);
echo("x long", x_long_num);
echo("x short", x_short_num);

if (part == 0)
    {
    make_base();
    }
else
    {
    make_lid();
    }

module make_base()
    {
    difference ()
        {
        // Reposition back to [0, 0, 0]
        translate([((hex_points_diameter / 2) + base_wall_thickness), ((hex_flats_diameter / 2) + base_wall_thickness), 0])
            {
            difference()
                {
                // Combine holes with base
                translate([((hex_points_diameter / 2) + base_wall_thickness) * -1, ((hex_flats_diameter / 2) + base_wall_thickness) * -1, 0]) base(base_width, base_length, base_bottom_thickness + base_hex_height);
                
                for (x = [0:x_num - 1])
                    {
                    echo("x", x);
                    echo("rem", rem);
                    rem = x % 2;
                    if (rem == 0)
                        // long row of hex holes
                        for (y = [0:y_num - 1] )
                            {
                            translate([(hex_side_length + hex_points_diameter) * (x/2) + (hex_spacing * x), y * (hex_flats_diameter + hex_spacing), base_bottom_thickness]) hex(base_hex_height);
                            }
                    else
                        // short row of hex holes
                        for (y = [0:(y_num - 2)] )
                            {
                            translate([((hex_points_diameter + hex_side_length) * (x/2)) + (hex_spacing * x), (y * (hex_flats_diameter + hex_spacing)) + (hex_flats_diameter / 2) + hex_spacing / 2, base_bottom_thickness]) hex(base_hex_height);
                            }
                    }
                }
            }
        
        // Magnet holes
        if (magnets)
            {
            for (x = [0:x_num - 1])
                {
                echo("x", x);
                echo("rem", rem);
                rem = x % 2;
                if (rem != 0)
                    // magnets in short row
                    for (y = [0:(y_num - 2)] )
                        {
                        translate([(hex_points_diameter + hex_side_length) * (x/2) + (hex_spacing * (x + 1)) + hex_side_length, magnet_offset, base_height - magnet_thickness]) cylinder(r=magnet_diameter / 2, h=magnet_thickness + 10);
                        translate([(hex_points_diameter + hex_side_length) * (x/2) + (hex_spacing * (x + 1)) + hex_side_length, base_length - magnet_offset , base_height - magnet_thickness]) cylinder(r=magnet_diameter / 2, h=magnet_thickness + 10);
                        }
                }
            }    
        }
    }

module make_lid()
    {
    difference ()
        {
        // Reposition back to [0, 0, 0]
        translate([((hex_points_diameter / 2) + lid_wall_thickness + lid_clearance  + base_wall_thickness), ((hex_flats_diameter / 2) + lid_wall_thickness + lid_clearance  + base_wall_thickness), 0])
            {   
            difference()
                {
                // Combine holes with base
                translate([((hex_points_diameter / 2) + lid_wall_thickness + lid_clearance + base_wall_thickness) * -1, ((hex_flats_diameter / 2) + lid_wall_thickness + lid_clearance  + base_wall_thickness) * -1, 0]) lid(lid_width, lid_length, lid_height + base_height - base_bottom_thickness);
                if (holes_in_lid)
                    {                
                    for (x = [0:x_num - 1])
                        {
                        rem = x % 2;
                        if (rem == 0)
                            // long row of hex holes
                            for (y = [0:(y_num -1)] )
                                {
                                //translate([0, x * (hex_flats_diameter + hex_spacing), lid_top_thickness]) hex(lid_hex_height);
                                translate([(hex_side_length + hex_points_diameter) * (x/2) + (hex_spacing * x), y * (hex_flats_diameter + hex_spacing), lid_top_thickness]) hex(lid_hex_height);
                                }
                        else
                            // short row of hex holes
                            for (y = [0:(y_num - 2)] )
                                {
                                translate([((hex_points_diameter + hex_side_length) * (x/2)) + (hex_spacing * x), (y * (hex_flats_diameter + hex_spacing)) + (hex_flats_diameter / 2) + hex_spacing / 2, lid_top_thickness]) hex(lid_hex_height);
                               }
                            }
                        }
                    }
                }
                
            // Magnet holes        
            if (magnets)
                {
                for (x = [0:x_num - 1])
                    {
                    echo("x", x);
                    echo("rem", rem);
                    rem = x % 2;
                    if (rem != 0)
                        // magnets in short row
                        for (y = [0:(y_num - 2)] )
                            {
                            translate([lid_clearance + base_wall_thickness + (hex_points_diameter + hex_side_length) * (x/2) + (hex_spacing * (x + 1)) + hex_side_length, + lid_wall_thickness + lid_clearance + magnet_offset, lid_height - magnet_thickness]) cylinder(r=magnet_diameter / 2, h=magnet_thickness + 1);
                            translate([lid_clearance + base_wall_thickness + (hex_points_diameter + hex_side_length) * (x/2) + (hex_spacing * (x + 1)) + hex_side_length, lid_length - lid_wall_thickness - lid_clearance - magnet_offset , lid_height - magnet_thickness]) cylinder(r=magnet_diameter / 2, h=magnet_thickness + 1);
                            }
                        }
                    }

 //           // Magnet holes        
 //           if (magnets)
 //               {
//                translate([lid_width / 2, lid_wall_thickness + lid_clearance + magnet_offset, lid_height - magnet_thickness]) cylinder(r=magnet_diameter / 2, h=magnet_thickness + 1);
//            
//                translate([lid_width / 2, lid_length - lid_wall_thickness - lid_clearance - magnet_offset, lid_height - magnet_thickness]) cylinder(r=magnet_diameter / 2, h=magnet_thickness + 1);
//                }
        
             // Subtrct base
             translate([lid_wall_thickness, lid_wall_thickness, lid_hex_height + lid_top_thickness]) base_cutout(base_width + lid_clearance * 2, base_length + lid_clearance * 2, base_bottom_thickness + base_hex_height + 1);
        
             // Thumb cutout
 //            translate([-1, lid_length / 2, lid_height + base_height + 1]) thumb_cutout();
            if (thumb_cutout)
                {
                translate([0, lid_length / 2, lid_height + base_height]) thumb_grip();
                translate([lid_width, lid_length / 2, lid_height + base_height]) thumb_grip();
                }
            }
    }

// Hex shape with rounded corners
module hex(h) {
    resize([hex_points_diameter, hex_flats_diameter, h + 1]) hull() {
        for ( i = [0:5] ) {
            rotate( i*360/6, [0, 0, 1])
            translate( [(hex_corner_radius * 2) + (hex_points_diameter /2 ), 0, 0] ) cylinder(r=hex_corner_radius,h=1);;
        }
    }
}

// base with rounded corners
module base(x, y, z)
    {
    union();
        {
        resize([x, y, z])
            {
            hull()
                {
                translate([ base_corner_radius, base_corner_radius, 0]) cylinder(r = base_corner_radius, h = z);
            
                translate([ x - base_corner_radius, base_corner_radius, 0]) cylinder(r = base_corner_radius, h = z);
            
                translate([base_corner_radius, y - base_corner_radius, 0]) cylinder(r = base_corner_radius, h = z);
            
                translate([ x - base_corner_radius, y -base_corner_radius, 0]) cylinder(r = base_corner_radius, h = z);
                }   
            } 
        resize([lid_width, lid_length, base_bottom_thickness])
            {
            difference()
                {
                hull()
                    {
                    translate([ base_corner_radius - lid_wall_thickness - lid_clearance, base_corner_radius  - lid_wall_thickness - lid_clearance, base_corner_radius])
                        union() 
                            {
                            sphere(r = base_corner_radius);
                            cylinder(r = base_corner_radius, h = base_corner_radius);
                            }
                    translate([ x - base_corner_radius  + lid_wall_thickness + lid_clearance, base_corner_radius - lid_wall_thickness - lid_clearance, base_corner_radius])
                        union()
                            {
                            sphere(r = base_corner_radius);
                            cylinder(r = base_corner_radius, h = base_corner_radius);
                            }
                    translate([base_corner_radius - lid_wall_thickness - lid_clearance, y - base_corner_radius + lid_wall_thickness + lid_clearance, base_corner_radius])
                        union()
                            {
                            sphere(r = base_corner_radius);
                            cylinder(r = base_corner_radius, h = base_corner_radius);
                            }
                    translate([ x - base_corner_radius + lid_wall_thickness + lid_clearance, y - base_corner_radius + lid_wall_thickness + lid_clearance, base_corner_radius])
                        union()
                            {
                            sphere(r = base_corner_radius);
                            cylinder(r = base_corner_radius, h =  base_corner_radius);
                            }
                    }   
                    translate([(lid_wall_thickness + lid_clearance + 1) * -1, (lid_wall_thickness + lid_clearance + 1) * -1, base_bottom_thickness]) cube([base_width + (lid_wall_thickness * 2) + (lid_clearance  * 2) + 2, base_length + (lid_wall_thickness * 2) + (lid_clearance * 2) + 2, base_bottom_thickness]);
                }
            }
        }
    }

module base_cutout(x, y, z)
    {
    resize([x, y, z])
        {
        hull()
            {
            translate([ base_corner_radius, base_corner_radius, 0]) cylinder(r = base_corner_radius, h = z);
        
            translate([ x - base_corner_radius, base_corner_radius, 0]) cylinder(r = base_corner_radius, h = z);
        
            translate([base_corner_radius, y - base_corner_radius, 0]) cylinder(r = base_corner_radius, h = z);
        
            translate([ x - base_corner_radius, y -base_corner_radius, 0]) cylinder(r = base_corner_radius, h = z);
            }   
        } 
    }
    
// lid with rounded corners
module lid(x, y, z)
    {
    resize([x, y, z])
        {
        hull()
            {
            translate([ lid_corner_radius, lid_corner_radius, lid_corner_radius]) corner(lid_corner_radius, z);
        
            translate([ x - lid_corner_radius, lid_corner_radius, lid_corner_radius]) corner(lid_corner_radius, z);
        
            translate([lid_corner_radius, y - lid_corner_radius, lid_corner_radius]) corner(lid_corner_radius, z);
        
            translate([ x - lid_corner_radius, y - lid_corner_radius, lid_corner_radius]) corner(lid_corner_radius, z);
            }        
        }
    }

module corner(radius, height)
    {
    union()
        {
        sphere(r = radius);
        cylinder(r = radius, h = height);
        }
    }

module thumb_grip()
    {
    resize([lid_wall_thickness, thumb_grip_width, lid_height * 2]) sphere(r = thumb_grip_width / 2);
    }
