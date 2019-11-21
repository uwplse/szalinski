// Full object height, mm
height = 130;

// Object top diameter, mm
diameter_top = 100;

// Object bottom diameter, mm
diameter_bottom = 130;

// Inner hole diameter, mm
hole_diameter = 40;

// Wall thickness, mm
thickness = 1; // [0.1:0.1:10]

// Curve quality (number of subdivs)
subdivs = 300; // [16: Lowest poly, 32: Low poly, 100:Rough, 300:Normal, 600:Ultra]

// preview[tilt:bottom diagonal]

base_thickness = (thickness <= 2) ? thickness * 2 : thickness;

vent_space = (diameter_top - hole_diameter)/2 - thickness;
vent_offset = hole_diameter/2 + vent_space/2 + thickness/2;
vent_circumference_space = vent_offset * 2 * PI;

vents = floor(vent_circumference_space / vent_space);
vent_diameter = vent_space - base_thickness;

difference() {
    
    // Outer box
    cylinder (
        h = height, 
        d1 = diameter_top, 
        d2 = diameter_bottom, 
        center = false,
        $fn = subdivs
    );
    
    // Inner box for lamp
    translate([0,0,base_thickness]) {
        cylinder (
            h = height, 
            d1 = diameter_top-(thickness*2), 
            d2 = diameter_bottom-(thickness*2), 
            center = false,
            $fn = subdivs
        );
    }
    
    // Center hole
    cylinder (
        h = base_thickness*3, 
        d = hole_diameter, 
        center = true,
        $fn = subdivs
    );
    
    // Vent holes
    for ( i = [1 : vents] ) {
        rotate( i * 360 / vents, [0, 0, 1])
        translate([ 0, vent_offset, 0])
        cylinder( 
            h = base_thickness*3, 
            d = vent_diameter, 
            center=true,
            $fn = subdivs
        );
    }
}
