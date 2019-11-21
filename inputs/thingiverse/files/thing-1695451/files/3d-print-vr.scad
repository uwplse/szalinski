// Programmer: Doug Melville
// Date: July 29, 2016
// Purpose: Parametric VR goggles for mobile phones a la Google Cardboard


/// Input params (millimeters)
// printer
printer_tol = 0.15; // extra space for precision fits like the lenses and phone strap

// phone
phone_height = 124; // up-down in portrait
phone_width = 58.76; // left-right in portrait
phone_thickness = 7.7; // in-out in portrait

// screws
screw_head_diam = 8;
screw_shaft_diam = 3.9;
hole_size = 4.5; // clearance hole from https://www.physics.ncsu.edu/pearl/Tap_Drill_Chart.html
socket_standoff = 4; // space to put a socket on the nut and tighten it

// lens
focal_length = 45;
lens_diam = 25;
lens_thickness = 4.65; // at center

// user
ipd = 60; // inter-pupillary distance

// material
min_wall_t = 3; // minimum thickness of a wall that you would like


/// Global vars
pad_size = screw_head_diam + socket_standoff; // size of the p


/// A pad for a screw head or nut to rest on and pass through
module screw_pad(thickness)
{
    difference()
    {
        union()
        {
            translate([pad_size/2, pad_size/2, 0]) cylinder(d=pad_size, h=thickness);
            translate([0, pad_size/2]) cube([pad_size, pad_size/2 + 0.1, thickness]);
        }
        translate([pad_size/2, pad_size/2, 0]) cylinder(d=hole_size, h=thickness);
    }
}


/// The bar which holds the phone to the cradle
module clip()
{
    // width = x
    clip_outer_width = phone_height + (2 * min_wall_t);
    clip_inner_width = phone_height + (2 * printer_tol);
    
    // height = y
    clip_height = pad_size;
    
    // thickness = z
    clip_outer_thickness = phone_thickness + printer_tol + min_wall_t;
    clip_inner_thickness = phone_thickness + printer_tol;
    
    union()
    {
        difference()
        {
            cube([clip_outer_width, clip_height, clip_outer_thickness]);
            translate([min_wall_t, 0, 0]) cube([clip_inner_width, clip_height + 1, clip_inner_thickness]);
        }
     
        // screw pads
        translate([-pad_size, pad_size, 0]) rotate([0,0,-90]) 
        screw_pad(min_wall_t);
        translate([clip_outer_width + pad_size, clip_height/2 - pad_size/2, 0]) 
        rotate([0,0, 90]) screw_pad(min_wall_t);
    }
}


/// The cradle which holds the phone to the frame
module cradle()
{
    // width = x
    outer_width = phone_height + (2 * min_wall_t); // determined by clip
    inner_width = phone_height - (2 * min_wall_t);
    
    // height = y
    outer_height = phone_width + (2 * min_wall_t);
    inner_height = phone_width - (2 * min_wall_t);
    
    // thickness = z
    thickness = min_wall_t;
    
    union()
    {
        difference()
        {
            // outer
            cube([outer_width, outer_height, thickness]);
            translate([2*min_wall_t, 2*min_wall_t, 0]) 
            // inner (hole)
            cube([inner_width, inner_height, thickness]);
        }
        
        cube([outer_width, min_wall_t, 2 * min_wall_t]); // bottom ledge
        
        // screw pads
        // left
        translate([-pad_size, outer_height/2 + pad_size/2, 0]) 
        rotate([0,0,-90]) 
        screw_pad(thickness);
        // right
        translate([outer_width + pad_size, outer_height/2 - pad_size/2, 0]) 
        rotate([0,0,90]) 
        screw_pad(thickness);
    }
}


/// A lens hole with a slight chamfer to sandwich the lenses
module half_lens_hole()
{
    cylinder(d1=lens_diam + printer_tol, d2=lens_diam - printer_tol, h=lens_thickness/2);
}


/// A shell which separates the phone from the lens
module spacer()
{
    // width = x
    outer_width_top = (2 * min_wall_t) + phone_height;
    lens_plate_diam = lens_diam + (2 * min_wall_t);
    
    // height = y
    outer_height_top = (2 * min_wall_t) + phone_width;
    
    // thickness = z
    thickness = focal_length - min_wall_t;
    
    difference()
    {
        union()
        {
            // outer hull
            x_pos_L = outer_width_top/2 - ipd/2;
            x_pos_R = outer_width_top/2 + ipd/2;
            y_pos = outer_height_top/2;
            hull()
            {
                translate([x_pos_L, y_pos, lens_thickness/4]) 
                cylinder(d=lens_plate_diam, h=lens_thickness/2, center=true);
                translate([x_pos_R, y_pos, lens_thickness/4]) 
                cylinder(d=lens_plate_diam, h=lens_thickness/2, center=true);
                translate([0, 0, thickness - min_wall_t]) 
                cube([outer_width_top, outer_height_top, min_wall_t]);
            }
            
            // screw pads
            translate([-pad_size, outer_height_top/2 + pad_size/2, thickness - min_wall_t]) 
            rotate([0,0,-90]) 
            screw_pad(min_wall_t);
            translate([outer_width_top + pad_size, outer_height_top/2 - pad_size/2, thickness - min_wall_t]) 
            rotate([0,0,90]) 
            screw_pad(min_wall_t);
            translate([-pad_size, outer_height_top/2 + pad_size/2, 0]) 
            rotate([0,0,-90]) 
            screw_pad(min_wall_t);
            translate([outer_width_top + pad_size, outer_height_top/2 - pad_size/2, 0]) 
            rotate([0,0,90]) 
            screw_pad(min_wall_t);
            
            // runners which connect the screw pads to the rest of the frame
            x_pos_l = (phone_height / 4) - min_wall_t;
            x_pos_r = (phone_height / 4) + outer_height_top + 2 * min_wall_t; // wat
            y_pos = outer_height_top / 2;
            z_pos = thickness / 2;
            translate([x_pos_l, y_pos, z_pos]) 
            cube([phone_height / 2, pad_size, thickness], center=true);
            translate([x_pos_r, y_pos, z_pos]) 
            cube([phone_height / 2, pad_size, thickness], center=true);
        }
        
        // inner hull to cut out
        x_pos_L = outer_width_top/2 - ipd/2 + min_wall_t/2;
        x_pos_R = outer_width_top/2 + ipd/2 - min_wall_t/2;
        y_pos = outer_height_top / 2;
        hull()
        {
            // left offset lens blank
            translate([x_pos_L, y_pos, lens_thickness/2]) 
            cylinder(d=lens_plate_diam - 2*min_wall_t, h=lens_thickness/2, center=true);
            // right offset lens blank
            translate([x_pos_R, y_pos, lens_thickness/2]) 
            cylinder(d=lens_plate_diam - 2*min_wall_t, h=lens_thickness/2, center=true);
            // offset phone blank
            translate([min_wall_t, min_wall_t, thickness - min_wall_t]) 
            cube([outer_width_top - 2*min_wall_t, outer_height_top - 2*min_wall_t, min_wall_t]);
        }
        
        // lens holes
        x_pos_L = (outer_width_top / 2) - (ipd / 2);
        x_pos_R = (outer_width_top / 2) + (ipd / 2);
        translate([x_pos_L, y_pos, 0]) half_lens_hole();
        translate([x_pos_R, y_pos, 0]) half_lens_hole();
        
        // nose and forehead hole
        // TODO: Parameters here aren't backed by any good science. Look up Human Factors.
        sphere_diam = 40;
        translate([outer_width_top/2, outer_height_top/8, -0]) sphere(d=sphere_diam);
        translate([outer_width_top/2, 7*outer_height_top/8, -0]) sphere(d=sphere_diam);
    }
}


/// A thin strap which holds the lenses to the spacer
module back()
{
    // width = x
    outer_width = phone_height + (2 * min_wall_t);
    lens_plate_diam = lens_diam + (2 * min_wall_t);
    
    // height = y
    full_height = (phone_width + (2 * min_wall_t))/2;
    
    // thickness = z
    thickness = lens_thickness/2;
    
    difference()
    {
        // position of the lens holes
        x_pos_L = (outer_width / 2) - (ipd / 2);
        x_pos_R = (outer_width / 2) + (ipd / 2);
        y_pos = pad_size / 2;
        
        union() // cross stick, lens hole area, and screw pads
        {
            // cross stick base to union to
            cube([outer_width, pad_size, thickness]);
            
            // two thin cylinders so that we have something to cut lens holders out of
            // left area slightly bigger than lens hole
            translate([x_pos_L, y_pos, lens_thickness/4]) // must translate along z b/c of center=true below
            cylinder(d=lens_plate_diam, h=lens_thickness/2, center=true);
            // right area slightly bigger than lens hole
            translate([x_pos_R, y_pos, lens_thickness/4]) 
            cylinder(d=lens_plate_diam, h=lens_thickness/2, center=true);
            
            // screw pads on the ends
            // left
            translate([-pad_size, pad_size, 0]) 
            rotate([0,0,-90]) 
            screw_pad(lens_thickness/2);
            // right
            translate([outer_width + pad_size, 0, 0]) 
            rotate([0,0,90]) 
            screw_pad(lens_thickness/2);
        }
        
        // lens holes
        // left
        translate([x_pos_L, y_pos, lens_thickness/2]) 
        rotate([180, 0, 0]) 
        half_lens_hole();
        // right
        translate([x_pos_R, y_pos, lens_thickness/2]) 
        rotate([180, 0, 0]) 
        half_lens_hole();
    }
}


/// The whole assembly exploded
explode_dist = 5;
center_x = (phone_height + 2 * min_wall_t) / 2;
center_y = (phone_width + 2 * min_wall_t) / 2;

translate([0, center_y - (pad_size / 2), 0])
clip();

translate([0, 0, -explode_dist])
cradle();

translate([0, 0, -(focal_length + explode_dist)])
spacer();

translate([0, center_y - (pad_size / 2), -(focal_length + (2 * min_wall_t) + explode_dist)])
back();