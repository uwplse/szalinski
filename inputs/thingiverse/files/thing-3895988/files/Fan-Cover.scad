
/* [Main Plate] */
// Plate Thickness (mm)
plate_thickness       = 1;
// Plate Length (mm)
plate_size            = 40;
// Plate Fillet Radius (mm)
plate_corner_radius   = 1.5;
// Mounting Hole Offset
hole_offset           = 4;
// Mounting Hole Diameter (mm)
hole_diameter         = 3;
// Mounting Hole Rim Offset (radius) (mm)
mounting_rim_offset   = 1;
// Mounting Hole Rim Height Off Plate (radius) (mm
mounting_rim_height   = 1;
// Diameter of Opening (mm)
fan_major_diameter    = 38;

/* [Fan Grid] */
// Grid Hole Opening Diameter [arc length between supports for "cyclone" styles]
fan_minor_diameter    = 10;
// Width of Grid Supports
grid_width            = 1;
grid_style            = "honey_comb";  //[honey_comb, bulls_eye, bulls_eye_square, triangular, cyclone_cw, cyclone_ccw]

/* [Hidden] */
cull_height           = plate_thickness + mounting_rim_height * 5;



// Error Checking:
assert( hole_offset > hole_diameter/2 ,
        "ERROR: Radius of mounting holes is greater than the hole offset");

assert( hole_offset > hole_diameter/2 + mounting_rim_offset,
        "ERROR: Mounting rim extends over plate edge");

assert(sqrt( 2 * pow((plate_size/2) - (hole_offset + hole_diameter/2), 2))  >= fan_major_diameter /2,
        "ERROR: Mounting holes extend over fan opening");



difference(){
    union(){
        difference(){
            // Base Plate
            base_plate(plate_size, plate_thickness, plate_corner_radius);

            //fan opening
            cylinder (d=fan_major_diameter, h=cull_height,$fn=50, center=true);
        }
        union() {
            // Mounting Rims
            mounting_rims(plate_size, plate_thickness, hole_offset, hole_diameter, mounting_rim_offset);
            
            // Fan Grid
            center_grid(plate_thickness, grid_style, grid_width, fan_major_diameter, fan_minor_diameter, cull_height);
        }
    }   
    //mounting holes
    mounting_holes(plate_size, hole_offset, hole_diameter, cull_height);
}



module base_plate(plate_w, plate_h, corner_radius)
{
    width = (plate_w / 2) - corner_radius;
    d     = corner_radius * 2;
    // Base Plate
    hull(){
        translate([-1 * width, -1 * width,0]) cylinder (d=d,h=plate_h,$fn=50);
        translate([     width, -1 * width,0]) cylinder (d=d,h=plate_h,$fn=50);
        translate([-1 * width,      width,0]) cylinder (d=d,h=plate_h,$fn=50);
        translate([     width,      width,0]) cylinder (d=d,h=plate_h,$fn=50);
    }
}


module mounting_rims(plate_w, plate_h, hole_offset, hole_d, r_offset)
{
    diameter = hole_d + 2 * r_offset;
    height   = plate_h + mounting_rim_height;
    coord    = (plate_w / 2) - hole_offset;
    //mounting rims
    translate([-1*coord, -1*coord,0]) cylinder(d=diameter,h=height,$fn=50);   
    translate([   coord, -1*coord,0]) cylinder(d=diameter,h=height,$fn=50);
    translate([-1*coord,    coord,0]) cylinder(d=diameter,h=height,$fn=50);
    translate([   coord,    coord,0]) cylinder(d=diameter,h=height,$fn=50);
}

module mounting_holes(plate_w, hole_offset, hole_d, hole_h)
{
    coord    = (plate_w / 2) - hole_offset;
    union()
    {
        translate([-1*coord, -1*coord,0]) cylinder(d=hole_d,h=hole_h,$fn=50,center=true);   
        translate([   coord, -1*coord,0]) cylinder(d=hole_d,h=hole_h,$fn=50,center=true);
        translate([-1*coord,    coord,0]) cylinder(d=hole_d,h=hole_h,$fn=50,center=true);
        translate([   coord,    coord,0]) cylinder(d=hole_d,h=hole_h,$fn=50,center=true);
    }
}



// Center Grid
module center_grid(plate_h, style, width, major_d, opening_d, cull_height)
{
    if (style == "honey_comb")
    {
        echo("Grid Style - honey_comb");
        hex_grid(plate_h, width, major_d, opening_d, cull_height);
    }
    else if ( style == "bulls_eye")
    {
        echo("Grid Style - bulls_eye");
        bulls_eye_grid(plate_h, width, major_d, opening_d, cull_height);
    }
    else if ( style == "bulls_eye_square")
    {
        echo("Grid Style - bulls_eye_square");
        square_bulls_eye_grid(plate_h, width, major_d, opening_d, cull_height);
    }
    else if ( style == "triangular")
    {
        echo("Grid Style - triangular");
        triangle_grid(plate_h, width, major_d, opening_d, cull_height);
    }
    else if ( style == "cyclone_cw" )
    {
        echo("Grid Style - cyclone_cw");
        cyclone_grid(plate_h, width, major_d, opening_d, cull_height, is_cw=true);
    }
    else if ( style == "cyclone_ccw" )
    {
        echo("Grid Style - cyclone_ccw");
        cyclone_grid(plate_h, width, major_d, opening_d, cull_height, is_cw=false);
    }
    else
    {
      assert( false, str("Undefined 'grid_style': ", grid_style));
    }
}


module cyclone_grid(plate_h, width, major_d, arc_length, cull_height, is_cw=true)
{
    /**
    **  Find theata:
    **    angle where the calcuated arc length <= the request 
    **    arc length
    **/
    // angle for requested arc length
    theta_tmp = (180 * (arc_length + width)) / (major_d/2 * 3.14159);
    // angle that that evenly divides 360
    theta     = 360.0 / ceil(360.0 / theta_tmp);
    
    intersection()
    {
        cylinder (d=major_d, h=plate_h,$fn=50);
        union()
        {
            for ( i = [0:360/theta] )
            {
                rotate([0, 0, theta * i])
                translate([major_d/2 - width/2, 0, 0])
                difference()
                {
                    cylinder(d=major_d, h=cull_height, $fn=100, center=true);
                    cylinder(d=major_d - (width*2), h=cull_height + 1, $fn=100, center=true);
                    
                    if (is_cw)
                    {
                        translate([major_d/2, major_d/2, 0])
                            cube([major_d, major_d, cull_height + 1], center=true);
                        translate([0, major_d/-2, 0])
                            cube([major_d, major_d, cull_height + 1], center=true);
                    }
                    else
                    {
                        translate([major_d/2, 0, 0])
                            cube([major_d, major_d, cull_height + 1], center=true);
                        translate([0, major_d/2, 0])
                            cube([major_d, major_d, cull_height + 1], center=true);
                    }
                    
                    
                }
            }
        }
    }
}

module triangle_grid(plate_h, width, major_d, opening_d, cull_height)
{
    num_nodes = ceil(major_d / opening_d) + 1;
    x_offset  = opening_d;
    y_offset  = sqrt(pow(x_offset, 2) - pow(x_offset / 2.0, 2));
    
    intersection(){
        cylinder (d=major_d, h=plate_h,$fn=50);
        union()
        {
            for (y = [0:num_nodes])
            {
                for (x = [0:num_nodes])
                {
                    x_coord = x%2 == 0 ? x/2 * x_offset : (x+1)/-2 * x_offset;
                    translate([x_coord, 0, 0])
                        triangel_supports(plate_h, width, major_d * 2);
                }
                
                y_coord = y%2 == 0 ? y/2 * y_offset : (y+1)/-2 * y_offset;;
                translate([0, y_coord, width/2])
                    cube([major_d, width, cull_height], center=true);
            }
        }
    }
}

module triangel_supports(plate_h, width, major_d)
{
    union()
    {
        rotate([0, 0, 0])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
        
        rotate([0, 0, 60])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
        
        rotate([0, 0, 120])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
    }
    
}

module square_bulls_eye_grid(plate_h, width, major_d, opening_d, cull_height)
{
    num_rings = ceil(major_d / opening_d) + 1;
    
    union(){
        difference(){
            cylinder (d=major_d, h=plate_h,$fn=50);
            union()
            {
                for (i = [1:num_rings])
                {
                    rotate([0, 0, 45])
                    difference()
                    {
                        d1 = opening_d*i;
                        d2 = (opening_d * (i-1)) + (2*width);
                        cube([d1, d1,cull_height], center=true);
                        cube([d2, d2, cull_height], center=true);
                    }
                }
            }
        }
        
        rotate([0, 0, -45])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
        
        rotate([0, 0, 0])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
        
        rotate([0, 0, 45])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
        
        rotate([0, 0, 90])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
    }
}

module bulls_eye_grid(plate_h, width, major_d, opening_d, cull_height)
{
    num_rings = ceil(major_d / opening_d) + 1;
    
    union(){
        difference(){
            cylinder (d=major_d, h=plate_h,$fn=50);
            union()
            {
                for (i = [1:num_rings])
                {
                    difference()
                    {
                        d1 = opening_d*i;
                        d2 = (opening_d * (i-1)) + (2*width);
                        cylinder (d=d1, h=cull_height,$fn=50, center=true);
                        cylinder (d=d2, h=cull_height,$fn=50, center=true);
                    }
                }
            }
        }
        
        rotate([0, 0, 0])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
        
        rotate([0, 0, 120])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
        
        rotate([0, 0, 240])
            translate([major_d/-2, width/-2, 0])
            cube([major_d, width, plate_h]);
    }
}

module hex_grid(plate_h, width, major_d, opening_d, cull_height)
{
    num_hexes = ceil(major_d/opening_d) + 1;
    y_offset  = (opening_d/2) * sqrt(3) + width;
    x_offset  = sqrt(pow(y_offset, 2) - pow(y_offset / 2.0, 2));
    
    difference(){
        cylinder (d=major_d, h=plate_h,$fn=50);
        
        //grid hexagons
        union()
        { 
            for ( i = [0:num_hexes] )
            {
                if ( i%2 == 0 )
                {
                    if (i%4 == 0)
                    {
                        translate([ceil(i/2) * x_offset, 0, 0])
                        hex_row(num_hexes, y_offset, opening_d, cull_height);
                    }
                    else
                    {
                        translate([ceil(i/2) * x_offset, y_offset / 2, 0])
                        hex_row(num_hexes, y_offset, opening_d, cull_height);
                    }                        
                }
                else
                {
                    if (i%4 == 1)
                    {
                        translate([ceil((i+1)/-2) * x_offset, y_offset / 2, 0])
                        hex_row(num_hexes, y_offset, opening_d, cull_height);
                    }
                    else
                    {
                        translate([ceil((i+1)/-2) * x_offset,0, 0])
                        hex_row(num_hexes, y_offset, opening_d, cull_height);
                    }    
                }
            }
        }
    }
}

module hex_row(num_hexes, hex_offset, diameter, height)
{
    union()
    {
        for (i=[0:num_hexes])
        {
            if ( i%2 == 0)
            {
                translate ([0, ceil(i/2) * hex_offset,0])
                hex(diameter, height);
            }
            else
            {
                translate ([0, ceil((i + 1) * -1/2) * hex_offset, 0])
                hex(diameter, height);
            }      
        }
        
    }
}

module hex(diameter, height)
{
    length = diameter/2;
    y_offset = (length/2) * sqrt(3) - 0.01;
    hull(){
        union()
        {
            for (i = [0:5])
            {
                rotate([0, 0, 60*i])
                translate([0, y_offset, 0])
                cube([length, 0.02, height], center = true);
            }
        }
    }
}
