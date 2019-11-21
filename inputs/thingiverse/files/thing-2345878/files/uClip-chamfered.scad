// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, 7th July, 2012
//
// Modified by Thomas Kircher, May 25, 2017
//
// U Clip, to clip sheeting to PVC piping

quantity = 1;

insideDiameter = 25.4;
thickness = 2.25;
length = 20;
flangeDistanceMult = 0.75;
flangeTerminateMult = 0.5;
manifoldCorrection = 0.04;
extra_chamfer = 0;

$fn = 120;

cubeSize = insideDiameter + thickness * 2;
distanceBetween = insideDiameter + thickness * 2 + 3;

 // Generate clips
 if(quantity > 0) {
     // Find the size of the smallest square that fits the quantity
     grid_size = ceil(sqrt(quantity));
     
     // Fill the square in row order
     for(n = [0 : quantity - 1]) {
         translate( [floor(n % grid_size) * distanceBetween,
                     floor(n / grid_size) * distanceBetween, 0] )
         pvcClip();
     }
 }
 
// Creates a Pvc Clip
module pvcClip()
{
	difference()
	{
		union()
		{
            // Clip ends
			hollowCylinder( insideDiameter / 2 + thickness, length, thickness );
		
            // Clip body
			translate( [0, flangeDistanceMult * insideDiameter, 0] )
				hollowCylinder( insideDiameter / 2 + thickness, length, thickness );
		}

        // Cutouts for clip body interior
		translate( [0, 0, -manifoldCorrection] )
			cylinder( r = insideDiameter / 2, h = length + manifoldCorrection * 2 );

		translate( [0, flangeDistanceMult * insideDiameter, -manifoldCorrection] )
			cylinder( r = insideDiameter / 2, h = length + manifoldCorrection * 2 );

        // Cutout for clip ends
		translate( [-cubeSize / 2, -cubeSize / 2 - insideDiameter * flangeTerminateMult, -manifoldCorrection] )
			cube( [cubeSize, cubeSize, length + manifoldCorrection * 2] );
        
        // Smoothing stabby bits
        chamfer_stabby_bits();
	}
}

// Chamfer the inner edge of a cylinder
module torus_chamfer()
{
    difference() {
        rotate_extrude($fn = 80)
            translate([insideDiameter / 2 - 1, 0, 0])
                square([2, 2]);
    
        rotate_extrude($fn = 80)
            translate([insideDiameter / 2 + 1, 2, 0])
                circle(r = 1, $fn = 60);
        }
}

// Put a slight chamfer on the sharp inside bits, to keep garden fabric from ripping
module chamfer_stabby_bits()
{
    // Chamfer the inner top and bottom parts of the cylinders.
    if(extra_chamfer == 1) {
        // Bottom of clip handle
        translate( [0, 0, -1] )
            torus_chamfer();

        // Top of clip handle
        translate( [0, 0, length + 1] )
            rotate( [0, 180, 0] )
                torus_chamfer();

        // Bottom of clip body
        translate( [0, flangeDistanceMult * insideDiameter, -1] )
            torus_chamfer();

        // Top of clip body
        translate( [0, flangeDistanceMult * insideDiameter, length + 1] )
            rotate([0, 180, 0])
                torus_chamfer();
    }
    
    chamfer_diameter = 2.5;
    cube_side = chamfer_diameter * 2 + manifoldCorrection;

    y_offset = flangeDistanceMult * insideDiameter / 2;
    x_offset = insideDiameter / 2 * sqrt(1 - flangeDistanceMult * flangeDistanceMult);
    
    difference() {
        union() {
            translate([x_offset + chamfer_diameter * 0.85, y_offset, -manifoldCorrection])
                hollowCylinder(chamfer_diameter, length + manifoldCorrection * 2, 1.0);
    
            translate([-x_offset - chamfer_diameter * 0.85, y_offset, -manifoldCorrection])
                hollowCylinder(chamfer_diameter, length + manifoldCorrection * 2, 1.0);
        }
        
        union() {
            translate([x_offset + 1.0, y_offset - cube_side / 2, -manifoldCorrection * 2])
                cube( [cube_side, cube_side, length + manifoldCorrection * 4]);
            
            translate([-x_offset - cube_side - 1.0, y_offset - cube_side / 2, -manifoldCorrection * 2])
                cube([cube_side, cube_side, length + manifoldCorrection * 4]);
        }
    }
}

// Creates a hollow cylinder
module hollowCylinder(radius, height, thickness)
{
	difference()
	{
		cylinder( r = radius, h = height );
		translate( [0, 0, -manifoldCorrection] )
			cylinder( r = radius - thickness, h = height + manifoldCorrection * 2 );
	}
}