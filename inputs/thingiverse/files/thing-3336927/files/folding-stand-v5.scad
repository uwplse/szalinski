//=== Dimensions (Customizable) ===============================================

// Base dimensions
baseX    = 45;				// Overall base length in x-direction (min. 8*frameWidth + gaps)
baseY    = 100;				// Overall width
baseZ    = 5.0;				// Overall height (min. ~4.0)
cornerR  = 2.5;				// Radius of the 4 corners

// Arm rests
armRests         = 1;		// 1 = Style #1, 2 = Style #2, anything else = no arm rests
armRestThickness = 1.6;		// Arm rest thickness (only for Style #2, min. 1.2)

// Phone holder area
stopperZ         = 9;		// Height of the stopper
holderY          = 13;		// Width of the phone holder area
holderHole       = true;	// Whether to have a hole at the bottom of the holder area
holderHoleXFrame = 5;		// If there is a hole, this is the frame width in x-direction
holderHoleYFrame = 1;		// If there is a hole, this is the frame width in y-direction

// Others
frameWidth = 4;				// Width of the edges and support arms
gapWidth   = 0.4;			// Gap between parts (increase if parts fuse together)
frontGap   = 8;				// Gap between the phone holder and the front arms (increase to incline more)
$fn        = 180;			// Number of segments to approximate circles


//=== Internal Variables (Do Not Modify) ======================================

// Dimensions of the hinges
hingeR1 = baseZ / 2;
hingeR2 = 0.5;
hingeH  = min(3.3, frameWidth - 0.5);

// Support rod and slot radii
rodR  = baseZ / 2;
slotR = rodR + gapWidth;
slotW = 2 * slotR;

// Phone holder locations
y0PhoneHolder = cornerR;
y1PhoneHolder = y0PhoneHolder + holderY;

// Front & back arms positions
x0BackArms  = 2*frameWidth + gapWidth;
x1BackArms  = baseX - x0BackArms;
x0FrontArms = 3*frameWidth + 2*gapWidth;
x1FrontArms = baseX - x0FrontArms;

y0FrontArms = cornerR + holderY + frontGap + 2*gapWidth;
y0BackArms  = y0FrontArms + 2*gapWidth + baseZ;
y1BackArms  = baseY - frameWidth - slotR - 2*gapWidth;
y1FrontArms = y1BackArms - baseZ - 2*gapWidth;


//=== Rendering ===============================================================

frame();
frontArms();
backArms();

if (armRests == 1) {
	backArmRests1();
} else if (armRests == 2) {
	backArmRests2();
}


//=== Modules =================================================================

/**
 * This module assembles the frame.
 */
module frame()
{
    difference() {
        frameBase();
        holderCutout();
        midSectionCutout1();
        midSectionCutout2();
        frontArms(true);
        backArms(true);
        slots();
    }
}

/**
 * This is the base of the frame, with the stopper, which can be higher to stopper the phone from
 * sliding off.
 */
module frameBase(z0 = 0, dz = baseZ, addStopper = true)
{
    // Dimensions & Coordinates
    dr = cornerR;
    x0 = dr;
    y0 = dr;
    x1 = baseX - dr;
    y1 = baseY - dr;
    
    // Main base
    hull() {
        translate([x0, y0, z0]) cylinder(dz, dr, dr);
        translate([x1, y0, z0]) cylinder(dz, dr, dr);
        translate([x0, y1, z0]) cylinder(dz, dr, dr);
        translate([x1, y1, z0]) cylinder(dz, dr, dr);
    }
    
    // The Stopper, which needs to be higher
	if (addStopper) {
		hull() {
			translate([x0, y0, z0]) cylinder(stopperZ, dr, dr);
			translate([x1, y0, z0]) cylinder(stopperZ, dr, dr);
		}
	}
}

/**
 * Cutout for the phone holder area.
 */
module holderCutout()
{
    // This is the main cutout from the base
	y0 = y0PhoneHolder;
	dy = abs(y1PhoneHolder - y0PhoneHolder);
    translate([-1, y0, 2]) cube([baseX + 2, dy, stopperZ]);
    
    // This is to make a hole
    if (holderHole) {
        wx = holderHoleXFrame;
        wy = holderHoleYFrame;
        translate([wx, y0 + wy, -10]) cube([baseX - 2*wx, dy - 2*wy, stopperZ + 20]);
    }
}

/**
 * Cutout in the middle section, where the slots are.
 */
module midSectionCutout1()
{
    // Dimensions & cutout under the slots
    x0 = 2 * frameWidth;
    y0 = y1PhoneHolder + frontGap + gapWidth + 2*rodR + 1;
    dx = baseX - 2*x0;
    dy = baseY - y0 - frameWidth - slotR;
    dz = baseZ + 20;
    
    // Cutout object
    translate([x0, y0, -10]) cube([dx, dy, dz]);    
}

/**
 * Cutout of the area between the hinges that hold the front support piece.
 */
module midSectionCutout2()
{
    // Dimensions & cutout under the front support
    x0 = x0FrontArms - gapWidth;
    y0 = y1PhoneHolder + frontGap;
    dx = baseX - 2*x0;
    dy = gapWidth + baseZ + 2;
    dz = baseZ + 20;
    
    // Cutout object
    translate([x0, y0, -10]) cube([dx, dy, dz]);
}

/**
 * Cutouts for the slots.
 *
 * The slots are spread out between the end of the frame and the arms. The last slot is calculated
 * so that the back arm always lean forward slightly. 
 */
module slots()
{
	// Calculate the last slot's position. 
	// When the back arm is straignt vertical, it forms a right triangle with the front arm. 
	// Hence we can calculate the position of the last slot.
	c0 = abs((y1FrontArms - rodR) - (y0FrontArms + rodR));
	b0 = abs((y1FrontArms - rodR) - (y0BackArms + rodR));
	a0 = sqrt(c0*c0 - b0*b0);
	
	// Slot dimensions & positions.
	dr = slotR;
	y0 = y0FrontArms + rodR + a0 + 1;	// Add a little to make sure back arms always lean forward
	y1 = baseY - frameWidth - dr;
	dy = y1 - y0 + 2*slotR;
    x0 = frameWidth;
    x1 = baseX - frameWidth;
    z0 = baseZ/2 + 1.6;
    z1 = baseZ + 5;
    dx = baseX - 2*frameWidth;
	
	// Debug
	//echo("module slots(): ", a0=a0, b0=b0, c0=c0);
	//%translate([x0, y0FrontArms, -10]) cube([dx, rodR+a, 20]);
	//%translate([x0, y0-slotR, -10]) cube([dx, dy, 20]);
	
    // Calculate number of slots and the stub (part between slots) width.
	// First, calculate the number of slots & stubs that will fit assuming a mininum stub width, then
	// spread the slots (wider stubs) to fill the entire allotted area. Also, the calculation is made
	// to fit n slots and (n-1) stubs.
    minStub   = 1;
    nSlots    = floor((dy + minStub) / (slotW + minStub));
	stubWidth = (dy - nSlots * slotW) / (nSlots - 1);
    w         = slotW + stubWidth;
	
	// These are used for calculating approximate incline angles
	y00   = y0PhoneHolder;
	a1    = a0 + rodR + y0FrontArms - y00;		// From y00 to where the back arm is vertical
	b1    = y1BackArms - y0BackArms - rodR;		// Basically the back arm's length
	c1    = sqrt(a1*a1 + b1*b1);				// Top of back arm to y00
	b2c2  = b1*b1 * c1*c1;
	b2pc2 = b1*b1 + c1*c1;
	echo("module slots(): ", a1=a1, b1=b1, c1=c1);
	
    // Cutouts to make the slots
    for (n = [0 : nSlots - 1]) {
		
		// Calculate the approximate incline angle.
		y11   = y1 - n*w;						// Middle of the slot
		s     = y11 - y00;						// Distance between slot and y00
		k     = (s*s - b2pc2) / 2;
		h     = sqrt( (b2c2 - k*k) / (s*s) );
		angle = asin(h / c1);					// Incline angle in degrees
		echo("module slots(): angle = asin(h/c1) ", n=n, s=s, h=h, c1=c1, angle=angle);
		
		// Make the slot cutout
        translate([0, y1 - n * w, 0]) hull() {
            translate([x0, 0, z0]) rotate([0,90,0]) cylinder(dx, dr, dr);
            translate([x0, 0, z1]) rotate([0,90,0]) cylinder(dx, dr, dr);
        }
    }
}

/**
 * This module makes the front (smaller, inside) support.
 *
 * @param hingeCutoutsOnly Set this to true in order to product only the cutouts for the hinges. If it is
 * false (default), then it produces the full support.
 */
module frontArms(hingeCutoutsOnly = false)
{
    // Dimensions for the main part
    dr = rodR;
    x0 = x0FrontArms;
    x1 = x1FrontArms;
    y0 = y0FrontArms;
    y1 = y1FrontArms;
    dx = abs(x1 - x0);
    dy = abs(y1 - y0);
    z0 = dr;
    
    if (hingeCutoutsOnly) {
        
        // Make the hinge cutouts only.
        frontArmsHinges(x0, y0, x1, y1, z0, dr, true);
        
    } else {
        
        // This will generate the main body and the hinges
        difference() {
            // The main arms body and the hinges
            union() {
                hull() {
                    translate([x0, y0 + dr, z0]) rotate([0, 90, 0]) cylinder(dx, dr, dr);
                    translate([x0, y1 - dr, z0]) rotate([0, 90, 0]) cylinder(dx, dr, dr);
                }
                frontArmsHinges(x0, y0, x1, y1, z0, dr, false);
            }
            
            // Cutout in the middle
			frontArmsCutout();
        }
    }
}

/**
 * Cut out in the middle of the front arms.
 */
module frontArmsCutout()
{
	x0 = x0FrontArms + frameWidth;
	dx = x1FrontArms - frameWidth - x0;
	y0 = y0FrontArms + 2*rodR;
	dy = y1FrontArms - 2*rodR - y0;
	dz = baseZ + 2;
	
	translate([x0, y0, -1]) cube([dx, dy, dz]);
}

/**
 * This module makes the hinges of the front arms.
 */
module frontArmsHinges(x0, y0, x1, y1, z0, dr, isCutOut = false)
{
    // For cutouts, we make the hinges as it. For real hinges, we reccess a little bit into the parent
    // structure so that there is a gap between itself and the corresponding cutout.
    xOffset = isCutOut ? 0 : 0.5;
    
    // Make the hinges...
    hinge(x0 + xOffset, y0 + dr, z0, -1);
    hinge(x0 + xOffset, y1 - dr, z0, -1);
    hinge(x1 - xOffset, y0 + dr, z0,  1);
    hinge(x1 - xOffset, y1 - dr, z0,  1);      
}

/**
 * This module generates the back (outside) support.
 *
 * @param rodCutOutOnly If true, this module only generates the cutout of the rod area, which is used
 * to cut out the frame base. Otherwise (default), it generates the support itself.
 */
module backArms(rodCutOutOnly = false)
{
    // Dimensions & locations of the base
    dr = rodR;
    x0 = x0BackArms;
    y0 = y0BackArms;
    y1 = y1BackArms;
    dx = x1BackArms - x0;
    dy = y1 - y0;
    z0 = dr;
    
    if (rodCutOutOnly) {
        
        // Generate only the cutouts for the rods
        backArmsRod(true);
        
    } else {
        
        // Generate the support itself
        difference() {
            
            // The main arm body and the rod (that goes into the slots)
            union() {
                hull() {
                    translate([x0, y0 + dr, z0]) rotate([0, 90, 0]) cylinder(dx, dr, dr);
                    translate([x0, y1 - dr, z0]) rotate([0, 90, 0]) cylinder(dx, dr, dr);
                }
                backArmsRod();
            }
            
			// Cutouts
            backArmsCutout();								// Cutout in the middle
            frontArms(true);								// Hinges from the front support
            if (armRests == 1) { backArmRests1(true); }		// Cutout for the arm rests
        }
    }
}

/**
 * The rod that goes into the slots.
 */
module backArmsRod(isCutout = false)
{
    // Dimensions & locations of the rod
    x0 = x0BackArms - frameWidth + gapWidth;
	y0 = y0BackArms + rodR;
    dx = baseX - 2*x0;
    dr = slotR - gapWidth;
	z0 = rodR;
    
    // Dimensions & locations for the cutout for the rod
    x2  = x0 - gapWidth;
    y2  = y0BackArms - gapWidth;
    dx2 = dx + 2*gapWidth;
    dy2 = slotW;
    dz2 = baseZ + 20;
    
    if (isCutout) {
        // Cutout area for the rod
        translate([x2, y2, -10]) cube([dx2, dy2, dz2]);
    } else {
        // The rod body
        translate([x0, y0, z0]) rotate([0, 90, 0]) cylinder(dx, dr, dr);
    }
}

/**
 * Middle cutout for the back arms.
 */
module backArmsCutout()
{
    // Dimensions & locations of the cutout
    x0 = x0BackArms + frameWidth;
    y1 = y1BackArms - 2*rodR;
    dx = (x1BackArms - x0BackArms) - 2*frameWidth;
    dy = y1 + 1;
    dz = baseZ + 2;

    // Cutout body
    translate([x0, -1, -1]) cube([dx, dy, dz]);
}

/**
 * Arm rests style #1 and their cutouts.
 *
 * The arm rests are little stubs that keep the arms from falling through the other side.
 *
 * @param isCutout If true, then it only generates the cutouts for the arm rests. If false (default), it
 * generates the arm rests themselves.
 */
module backArmRests1(isCutout = false)
{
    // Base dimensions
    x0 = x0BackArms - 2*gapWidth;
    x1 = x1BackArms + 2*gapWidth;
    y0 = y0BackArms - gapWidth + 2*slotR;
    y1 = y1BackArms;
    dx = frameWidth + gapWidth;
    dy = abs(y1 - y0) / 3;
    dz = 1.2;
    
    // Dimensions of the arm rests
    xl = x0;
    xr = x1 - dx;
    y2 = y0 + abs(y1 - y0) / 4;
    
    if (isCutout) {
        // Make the cutouts for the arm rests
        translate([xl - 1, y2 - 2*gapWidth, -1]) cube([dx + 2, dy + 4*gapWidth, dz + 0.4 + 1]);
        translate([xr - 1, y2 - 2*gapWidth, -1]) cube([dx + 2, dy + 4*gapWidth, dz + 0.4 + 1]);        
    } else {
        // Make the arm rests
        translate([xl, y2, 0]) cube([dx, dy, dz]);
        translate([xr, y2, 0]) cube([dx, dy, dz]);
    }
}

/**
 * Arm rests style #2.
 *
 * This style does not require any cutouts.
 */
module backArmRests2()
{
	// This is to mold to the same shape as the frame, basically with all the same cutouts.
	x0 = x0BackArms;
	x1 = x1BackArms;
	y0 = y0BackArms;
	y1 = y1BackArms;
	dz = max(1.2, armRestThickness);
	z0 = -dz;
	
	difference() {
		frameBase(z0, dz, false);
		holderCutout();
		midSectionCutout1();
		midSectionCutout2();
		backArms(true);
	}
	
	// This is the part that goes underneath the arms to provide support.
	x2 = x0 - frameWidth;
	dx = abs(x1 - x0) + 2*frameWidth;
	dy = abs(y1 - y0) / 2;
	y2 = y0 + abs(y1 - y0)/2 - dy/2;
	z2 = z0;
	
	translate([x2, y2, z2]) cube([dx, dy, dz - 0.4]);
}

/**
 * This module produces a hinge.
 *
 * @param x0 X-location, be sure there is a gap between the hing itself and the cutout
 * @param y0 y-location, this is the center of a cylinder
 * @param z0 z-location, this is the center of a cylinder
 * @param rs The rotation sign (either +1 or -1)
 */
module hinge(x0, y0, z0, rs)
{
    s0 = (rs > 0) ? 1 : -1;
    translate([x0, y0, z0]) rotate([0, s0 * 90, 0]) cylinder(hingeH, hingeR1, hingeR2);
}

