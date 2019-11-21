/*
 * Tripod Mount Plate
 * @model SLIK 618-330
 *
 * @author Ivan Mihov
 * @email ivan@imihov.com
 * @web imihov.com
 * @date 05/11/2018
 */

// Hole
$fn=50;

// Pin head hole
pin_head_height=4;
pin_head_radius=22/2;

// Countersink Pin head - optional
pin_head_countersink_height=1;
pin_head_countersink_radius=12/2;

pin_hole_radius=5.5/2;

// Camera lock washer - optional
pin_lock_height=0.5;
pin_lock_radius=10/2;

/*
 * The model is a custom octagon, made up of 4 trapezoids + 1 square
 * the variables below are are used to set the dimentions
 * All Trapezoids are the same
 */
trapezoid_top_base = 25;
trapezoid_bottom_base = 50;
trapezoid_angle = 45;
trapezoid_height = 12.5;
cube_size = trapezoid_top_base;

// The model thicknes - height
thicknes = 10;

// The angle for the slanted sided
cutoff_deg=31;

/*
 * Create 4 cubes, rotate them, and subtract them 
 * from the base to get the slanted sides
 */
difference()
{
    // Get the custome octagonal base
    base();
    
    // Left slanted side
    translate([0,trapezoid_bottom_base,1])
        rotate([cutoff_deg,0,0])
            cube([trapezoid_top_base*2,thicknes*2,thicknes*2]);
    // Right slanted side
    translate([0,0,1]) mirror([0,1,0])
        rotate([cutoff_deg,0,0])
            cube([trapezoid_top_base*2,thicknes*2,thicknes*2]);
    // Top slanted side
    translate([trapezoid_bottom_base,0,1])
        rotate([0,-cutoff_deg,0])
            cube([thicknes*2,trapezoid_top_base*2,thicknes*2]);
    // Bottom slanted side
    translate([0,0,1]) mirror([1,0,0])
        rotate([0,-cutoff_deg,0])
            cube([thicknes*2,trapezoid_top_base*2,thicknes*2]);
    
    // Pin head hole
    translate([trapezoid_bottom_base/2,trapezoid_bottom_base/2,0])
        cylinder(h=pin_head_height, r=pin_head_radius);
        
    // Countersink Pin head - optional
    //translate([trapezoid_bottom_base/2,trapezoid_bottom_base/2,pin_height])
    //    cylinder(h=pin_head_countersink_height, r1=pin_head_countersink_radius+2, r2=pin_head_countersink_radius);
    
    // Pin hole
    translate([trapezoid_bottom_base/2,trapezoid_bottom_base/2,0])
        cylinder(h=thicknes, r=pin_hole_radius);
    
    // Camera Lock washer - optional
    //translate([trapezoid_bottom_base/2,trapezoid_bottom_base/2,thicknes-pin_lock_height])
    //    cylinder(h=pin_lock_height, r=pin_lock_radius); 
}

// The base is build from 4 trapezoids and a cube
module base() {

    translate([trapezoid_top_base,trapezoid_top_base,0]) {
        // Cube
        translate([0,0,thicknes/2])
        cube([cube_size, cube_size, thicknes], true);
        
        // Top Part
        translate([0,cube_size/2,thicknes/2]) 
            trapezoid(b=trapezoid_bottom_base, angle=trapezoid_angle, H=trapezoid_height, height=thicknes);
            
        // Bottom part
        translate([0,-cube_size/2,thicknes/2])
            rotate(180)
                trapezoid(b=trapezoid_bottom_base, angle=trapezoid_angle, H=trapezoid_height, height=thicknes);
            
        // Left Part
        translate([-cube_size/2,0,thicknes/2]) 
            rotate(90)
            trapezoid(b=trapezoid_bottom_base, angle=trapezoid_angle, H=trapezoid_height, height=thicknes);
            
        // Right part
        translate([cube_size/2,0,thicknes/2])
            rotate(-90)
                trapezoid(b=trapezoid_bottom_base, angle=trapezoid_angle, H=trapezoid_height, height=thicknes);
    } 
}


/*
trapezoid
	Create a Basic Trapezoid (Based on Isosceles_Triangle)
            d
          /----\
         /  |   \
     a  /   H    \ c
       /    |     \
 angle ------------ angle
            b
	b: Length of side b
	angle: Angle at points angleAB & angleBC
	H: The 2D height at which the triangle should be cut to create the trapezoid
	heights: If vector of size 3 (Standard for triangles) both cd & da will be the same height, if vector have 4 values [ab,bc,cd,da] than each point can have different heights.
*/
module trapezoid(
			b, angle=60, H, height=1, heights=undef,
			center=undef, centerXYZ=[true,false,true])
{
	validAngle = (angle < 90);
	adX = H / tan(angle);

	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCD = ((heights==undef) ? height : heights[2])/2;
	heightDA = ((heights==undef) ? height : ((len(heights) > 3)?heights[3]:heights[2]))/2;

	// Centers
	centerX = (center || (center==undef && centerXYZ[0]))?0:b/2;
	centerY = (center || (center==undef && centerXYZ[1]))?0:H/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCD,heightDA);

	// Points
	y = H/2;
	bx = b/2;
	dx = (b-(adX*2))/2;

	pointAB1 = [centerX-bx, centerY-y, centerZ-heightAB];
	pointAB2 = [centerX-bx, centerY-y, centerZ+heightAB];
	pointBC1 = [centerX+bx, centerY-y, centerZ-heightBC];
	pointBC2 = [centerX+bx, centerY-y, centerZ+heightBC];
	pointCD1 = [centerX+dx, centerY+y, centerZ-heightCD];
	pointCD2 = [centerX+dx, centerY+y, centerZ+heightCD];
	pointDA1 = [centerX-dx, centerY+y, centerZ-heightDA];
	pointDA2 = [centerX-dx, centerY+y, centerZ+heightDA];

	validH = (adX < b/2);

	if (validAngle && validH)
	{
		polyhedron(
			points=[	pointAB1, pointBC1, pointCD1, pointDA1,
						pointAB2, pointBC2, pointCD2, pointDA2 ],
			triangles=[	
				[0, 1, 2],
				[0, 2, 3],
				[4, 6, 5],
				[4, 7, 6],
				[0, 4, 1],
				[1, 4, 5],
				[1, 5, 2],
				[2, 5, 6],
				[2, 6, 3],
				[3, 6, 7],
				[3, 7, 0],
				[0, 7, 4]	] );
	} else {
		if (!validAngle) echo("Trapezoid invalid, angle must be less than 90");
		else echo("Trapezoid invalid, H is larger than triangle");
	}
}


//-----------------------