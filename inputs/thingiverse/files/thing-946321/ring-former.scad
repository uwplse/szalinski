// Former height
height = 20;
// Outer radius
radius = 100;
// Material thickness
thickness = 2;
// Maximal bed width
maxWidth = 200;
// Maximal bed length
maxLength = 200;
// The padding of the parts
padding = 15;
// space between the parts, added to thickness
space = 3;

/* [Hidden] */
$fn = 360;

// calculated
radiusInner = radius - thickness;
segmentHeight = radiusInner - sqrt((radiusInner * radiusInner) - (radiusInner/2) * (radiusInner/2));

intersection() {
    union() {
        // The U shaped part
        difference() {
            translate([-radiusInner / 2, 0, height / 2])
                cube([radiusInner, radiusInner, height], center=true);

            translate([thickness + padding, 0, -1])
                cylinder(r=radius, h=height + 2);
        }

        // The D shaped part
        intersection() {
            translate([thickness + padding + space, 0, 0])
                cylinder(r=radiusInner, h=height);
            
            translate([-segmentHeight / 2 + padding / 2- radiusInner + segmentHeight + padding + thickness + space, 0, height / 2])
                cube([segmentHeight + padding
            , radiusInner, height], center=true);
            
        }
    }
    
    translate([-radiusInner + padding *2, 0, 0])
        cube([maxWidth, maxLength, height], center=true);
}