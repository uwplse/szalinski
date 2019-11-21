// Magic Wand Handle (Thingiverse Customizer supported)
// Increase resolution (*1 to hide)
$fn=(100 * 1);

// Following variables are visible in Customizer
// (.5 mm will be added as a buffer)
opening_diameter = 10.8;
handle_length = 100;
twist_factor = 2; // [1:15]
endcap_thickness = 2; // [1:5]

// Hidden from Customizer
handle_od = (opening_diameter + 1.5);
endcap_overhang = (2 * 1);
buff = (.5 * 1);

module vertical_cylinder(dia)
{
    translate([0, 0, endcap_thickness])
        cylinder(h=(handle_length + endcap_thickness), r=(dia / 2), center=true);
}

module twist_texture(twist)
{
    linear_extrude(height = handle_length, center = true, twist = twist)
        square((handle_od - 2), center=true);
}

module end_rim(offset)
{
    translate([0, 0, offset])
        cylinder(h=endcap_thickness, r=((handle_od + endcap_overhang) / 2), center=true);
}

difference()
{
    union()
    {
        // Hollow out center
        cylinder(h=handle_length, r=(handle_od / 2), center=true);
        
        // Render Handle
        twist_texture((twist_factor * 100));
        twist_texture(-((twist_factor * 100) + ((twist_factor * 100) / 4)));

        // Top rim
        end_rim((handle_length / 2));  

        // Bottom rim
        end_rim(-(handle_length / 2));
    }
    
    // Hollow out center
    vertical_cylinder((opening_diameter + buff));
}