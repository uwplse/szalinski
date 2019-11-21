// Magic Wand Handle (Thingiverse Customizer supported)
// Increase resolution (*1 to hide)
$fn=(100 * 1);

// Following variables are visible in Customizer
// Outer diameter of the handle
handle_outer_diameter = 15;
handle_length = 90;
twist_factor = 5; // [1:15]
endcap_thickness = 2; // [1:5]
// Diameter of the hollow bore.
bore_diameter = 5.3;
// Length of the hollow bore
bore_length = 60;

// Hidden from Customizer
endcap_overhang = (2 * 1);

module vertical_cylinder(dia)
{
    translate([0, 0, endcap_thickness])
        cylinder(h=(handle_length + endcap_thickness), r=(dia / 2), center=true);
}

module hollow_cylinder(dia)
{
    translate([0, 0, ((handle_length / 2) - (bore_length / 2) + (endcap_thickness /2))])
        cylinder(h=bore_length, r=(dia / 2), center=true);
}

module twist_texture(twist)
{
    linear_extrude(height = handle_length, center = true, twist = twist)
        square((handle_outer_diameter - 2), center=true);
}

module end_rim(offset)
{
    translate([0, 0, offset])
        cylinder(h=endcap_thickness, r=((handle_outer_diameter + endcap_overhang) / 2), center=true);
}

difference()
{
    union()
    {
        // Hollow out center
        cylinder(h=handle_length, r=(handle_outer_diameter / 2), center=true);
        
        // Render Handle
        twist_texture((twist_factor * 100));
        twist_texture(-((twist_factor * 100) + ((twist_factor * 100) / 4)));

        // Top rim
        end_rim((handle_length / 2));  

        // Bottom rim
        end_rim(-(handle_length / 2));
    }
    
    // Hollow out center
    hollow_cylinder(bore_diameter);
}