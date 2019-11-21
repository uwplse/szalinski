// Height of front bezel
front_left_height = 60;

// Width of front bezel
front_left_width = 15;

// Height of the bottom bezel
front_bottom_height = 15;

// Width of the bottom bezel
front_bottom_width = 60;

// Distance/thickness to mount off of wall (back place thickness)
distance_from_wall = 18;

// Thickness of wall mounts
wall_thickness = 4;

// Tablet Thickness
tablet_thickness = 11;

// Radius of screw holes
screw_head_radius = 7.5;
screw_radius = 4;
screw_head_height = 6;

// Define a screwhole (X/Y at center, z at face surface)
module sunken_screw_hole()
{  
    union()
    {
        // Head
        translate([0,0,-(screw_head_height)])
        cylinder(h = screw_head_height, 
        d1 = screw_head_radius, 
        d2 = screw_head_radius, 
        center = false);
        
        //screw thread
        translate([0,0,-distance_from_wall])
        cylinder(h = (distance_from_wall),
        d1 = screw_radius,
        d2 = screw_radius,
        center = false);
    }
}

// Back plate/triangle
difference()
{
    // Back plate
    rotate([90,0,0])
    translate([0,0,0])
    linear_extrude(height=distance_from_wall)
    {
            polygon(points=[[0,0],[front_bottom_width+(screw_head_radius*2),0],[0,front_left_height+(screw_head_radius*4)]], paths=[[0,1,2]]);
    }
    
    // Top screw hole
    rotate([90,0,0])
    translate([wall_thickness+screw_head_radius,
    front_left_height+screw_head_radius,
    distance_from_wall])
    
    #sunken_screw_hole();
    
    // Botton screw hole
    rotate([90,0,0])
    translate([front_bottom_width/2,
    front_bottom_height+screw_head_radius,
    distance_from_wall])
    
    #sunken_screw_hole();
}

// Front left
rotate([0,0,0])
translate([0,-(wall_thickness+distance_from_wall+tablet_thickness),0])
cube([front_left_width,wall_thickness,front_left_height], center=false);

// Front bottom
rotate([0,0,0])
translate([0,-(wall_thickness+distance_from_wall+tablet_thickness),0])
cube([front_bottom_width,wall_thickness,front_bottom_height], center=false);

// Left edge
rotate([0,0,0])
translate([0,-(distance_from_wall+tablet_thickness),0])
cube([wall_thickness,tablet_thickness,front_left_height], center=false);

// Bottom
rotate([0,0,0])
translate([0,-(distance_from_wall+tablet_thickness),0])
cube([front_bottom_width,tablet_thickness,wall_thickness], center=false);

