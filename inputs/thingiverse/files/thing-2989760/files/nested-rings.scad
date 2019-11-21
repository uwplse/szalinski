// Variables' comments formatted for Thingiverse Customizer.

// Cut a notch out of the rings to preview how the interior fits. Disable before printing!
preview_cut = false;

// Style of rings. Biconical rings can slide axially as well as tumbling; spherical rings are close-fitting and more likely to jam.
type = "biconical";  // [biconical:Biconical, spherical:Spherical, spherical_one_hole:Spherical (closed on top)]


// Number of rings to generate. The size is determined starting from the center, so more rings is larger.
ring_count = 6;

// Width of the rings (z axis height as printed), in millimeters.
ring_width = 20;

// Thickness of each ring, in millimeters. Setting this too low will result in rings which pop apart too easily.
ring_thickness = 1.4;

// Radius of the midline of the largest ring, in millimeters.
outer_radius = 33;

// For biconical rings, the faces of the rings will have a radius this many millimeters smaller than the center. Ignored for spherical rings.
bicone_opening_reduction = 3.1;

// For biconical rings, the amount of space between adjacent rings (when they are concentric), in millimeters. Must be smaller than Bicone Opening Reduction to prevent the rings from just falling apart.
bicone_gap = 2;

// For spherical rings, the width of a centered thinner band of each ring, in millimeters. This is intended for rings printed with transparent material in that band. Set to zero to disable.
spherical_thin_band_width = 0;

// For spherical rings, the thickness of a centered thinner band of each ring, in millimeters. This is intended for rings printed with transparent material in that band. Cannot be larger than the ring thickness. Ignored if thin band width is zero.
spherical_thin_band_thickness = 0.6;

// For spherical rings, the amount of space between adjacent rings, in millimeters. Set this as low as you can without the surfaces fusing when printed.
spherical_gap = 0.6;

/* [Hidden] */

spherical = type == "spherical" || type == "spherical_one_hole";

// Chosen constants and not-exposed calculations
SMOOTH_FACETS = 240;
gap = spherical ? spherical_gap : bicone_gap;
facets = spherical ? SMOOTH_FACETS / 2 : SMOOTH_FACETS;  // make spheres somewhat less super-expensive

// Derived values / aliases
zradius = ring_width / 2;
step = gap + ring_thickness;


difference() {
    main();
    
    if (preview_cut)
    translate([0, 0, -500])
    cube([1000, 1000, 1000]);
}


module main() {
    for (i = [0:ring_count - 1]) {
        radius = outer_radius - i * step;
        unit(radius);
    }
}

module unit(r2) {
    if (spherical) {
        rotate_extrude($fn = facets)
        intersection() {
            difference() {
                circle(r = r2, $fn = facets);
                circle(r = r2 - ring_thickness, $fn = facets);
                
                if (spherical_thin_band_width > 0) {
                    minkowski() {
                        intersection() {
                            circle(r = r2 - ring_thickness, $fn = facets);

                            translate([0, -spherical_thin_band_width / 2])
                            square([r2 * 1.5, spherical_thin_band_width]);
                        }
                        
                        // diamond shape to create 45° overhangs
                        circle(r=ring_thickness - spherical_thin_band_thickness, $fn=4);
                    }
                }
            }
            
            translate([0, -zradius])
            square([r2 * 1.5, type == "spherical_one_hole" ? 1000 : zradius * 2]);
        }
        
    } else if (type == "biconical") {
        r1 = r2 - bicone_opening_reduction;
        //linear_extrude(2)
        rotate_extrude($fn = facets)
        polygon([
            [r1, zradius],
            [r2, 0],
            [r1, -zradius],
            [r1 - ring_thickness, -zradius],
            [r2 - ring_thickness, 0],
            [r1 - ring_thickness, zradius],
        ]);
        
    } else {
        echo("Error: ring type not valid");
    }
}