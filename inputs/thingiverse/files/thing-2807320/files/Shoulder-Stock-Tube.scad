// Total Length
l = 150;

// Maximum Diameter
diameter = 25.5;

// Taper (gets subtracted from Maximum Diameter to yield Diameter at Ends)
taper = 1.5;

// Length of Tapered Section (should be smaller than half the Total Length)
taper_length = 10;

// Wall Thickness
wall_thickness = 1.6;

// DOUBLE Wall Thickness
double_thickness = 2 * wall_thickness;

//Number of Facets
$fn = 128;

difference ()
{
    union ()
    {
        cylinder (d2 = diameter, d1 = diameter - taper, h = taper_length);
        
        translate ([0, 0, taper_length])
            cylinder (d = diameter, h = l - 2 * taper_length);
        
        translate ([0, 0, l - taper_length])
            cylinder (d1 = diameter, d2 = diameter - taper, h = taper_length);
    }
    
    union ()
    {
        translate ([0, 0, double_thickness/2])
            cylinder (d2 = diameter - double_thickness, d1 = diameter - taper - double_thickness, h = taper_length - double_thickness/2);
        
        translate ([0, 0, taper_length])
            cylinder (d = diameter - double_thickness, h = l - 2 * taper_length);
        
        translate ([0, 0, l - taper_length])
            cylinder (d1 = diameter - double_thickness, d2 = diameter - double_thickness, h = taper_length - double_thickness/2);
    }
}