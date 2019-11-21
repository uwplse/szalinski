/**
 * This is a parametric version of the excellent Gyroscopic Keyring by
 * gianfranco found here: 
 * https://www.thingiverse.com/thing:1307100
 *
 * Thanks gianfranco!
 *
 * I wanted to be able to experiment with number of rings, spacing between
 * rings, sizes, etc. so created this parametric version that allows the
 * customizer in OpenSCAD or the Thingiverse customizer to be used to alter the
 * model.
 *
 * Author : Tom Coetser (Fitzterra) <fitzterra@icave.net>
 *
 * License:
 * This work is licensed under the Creative Commons Attribution 3.0 Unported
 * License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by/3.0/ or send a letter to Creative
 * Commons, PO Box 1866, Mountain View, CA 94042, USA.
 **/

/* [ Generator options ] */
// Rouded surfaces resolution.
$fn = 100;
// Create a center sliced sample view?
sliceCenter = false;

/* [ Gyro parameters ] */
// Diameter for innermost ring or ball.
innerDia = 16;
// Size for hole in inner most ring. Zero will leave it as a hollow ball.
centerHole=4.0;
// Width for ring walls at ring equators.
ringW = 2.0;
// Spacing between rings.
gap = 0.5;
// Number of rings, including center ring or ball.
rings = 6;
// Height for the gyro.
height = 18.0;
// Calculate the Outer Diameter
outerDia = (innerDia/2+ringW + (rings-1)*(gap+ringW))*2;

/* [ Key ring parameters ] */
// Add a key ring?
keyRing = true;
// Keyring orientation?
krOrient = "v"; //[v:Vertical, h:Horizontal]
// Width for keyring - also affects outer diameter
krOuterDia = 9;
// Inner diameter for keyring
krInnerDia = 5;
// Elliptical scaling
krEliptical = 0.5; //[0.1:0.1:1])
// Optional offset (+ or -) for the keyring from the outer Gyro edge.
krOffs = -3;

/**
 * Creates a ball shape with a non solid inside, or with a solid inside and
 * a vertical hole through the middle.
 *
 * param od: Outside diameter
 * param t: Wall thickness for the ball if ctr is non-zero.
 * param ctr: If non-zero, the inside is solid, but a center hole at this
 *            diameter is created in Z direction. If zero, the inside is empty
 *            or hollow.
 **/
module Ball(od, t, ctr=0) {
    difference() {
        // The main solid sphere
        sphere(d=od);
        // Hollow it out or drill a central hole?
        if (ctr==0)
            // We hollow it out like a ball
            sphere(d=od-2*t);
        else
            // We drill a central vertical hole
            cylinder(d=ctr, h=od+0.3, center=true);
    }
}

/**
 * Generates the key ring bit to attach to the outer most ring.
 *
 * @param od: The diameter for the ring used to for the key ring. This affects
 *        both the outer diameter of the ring, as well as the size of the ring
 *        - just try it :-)
 * @param id: Inner diameter of the ring - this is the inner diameter if the
 *        ring is perfectly round and not ellipsed. If it is elliptically
 *        scaled, the true inner diameter would be slightly larger.
 * @param offs: The keyring center would be placed on the outer edge of the outer
 *        gyro ring. This parameter allows it to be offset in or out from the
 *        outer edge.
 * @param fitOD: The outer diameter of the outer gyro ring the keyring will be
 *        fitted to. This is to cut the excess off for a perfect fit.
 * @param orient: Orientation of the keyring: "v" for vertical or "h" for
 *        horizontal.
 **/
module KeyRing(od=krOuterDia, id=krInnerDia, offs=krOffs, fitOD=outerDia, orient=krOrient) {
    // Rotate the final ring 90° around the x axis if needed
    rotate([orient=="v"?90:0, 0, 0])
    // Create the keyring
    difference() {
        // Move it in X if there is an offset
        translate([offs, 0, 0])
            // Use rotate extrude to create a toroid type shape from a possibly
            // elliptical circle.
            rotate_extrude(convexity=10)
                translate([od/2+id/2, 0, 0,])
                    scale([krEliptical, 1, 1])
                        circle(d=od);
        // Use a Ball() shape to cut the part that will be thrown away off the
        // keyring.
        translate([-fitOD/2, 0, 0])
            Ball(fitOD, 1, 0.1);
    }
}

/**
 * Generates the gyro fitted rings based on the parameters.
 *
 * @param id: Inner ring diameter - this is the base size determining the final
 *        object size.
 * @param wt: The width for the ring walls. This translates to the skin thickness
 *        for the ball that then gets cuts. This will be the width of the ring
 *        when cut through at the equator, but obviously would result in
 *        thicker walls when sliced horizontally further away from the center.
 * @param gap: The gap between rings.
 * @param c: The number of rings to generate
 * @param h: The final height for the gyro rings
 * @param ch: If not 0, the central ball used to form the central ring will be
 *        solid with a vertical hole through the middle with diameter of this
 *        parameter. If 0, then the central ball will be hollow with no holes
 *        (unless the height causes a cut through it) in it.
 **/
module GyroRings(id=innerDia, wt=ringW, g=gap, c=rings, h=height, ch=centerHole) {
    od = outerDia;
    difference() {
        // Combine a series of concentric balls and the keyring as one
        union() {
            for (n=[0:c-1]) {
                // Generate concentric balls for each ring
                Ball((id/2+wt + n*(g+wt))*2, wt, n==0?ch:0);
            }
            // Add the keyring if required.
            if(keyRing)
                translate([outerDia/2, 0, 0])
                    KeyRing();
        }
        // Cut the top and bottom to leave the desired height
        translate([0, 0, h/2+od/2])
            cube([od*2, od+0.1, od], center=true);
        translate([0, 0, -h/2-od/2])
            cube([od*2, od+0.1, od], center=true);
    }
}

/**
 * Generates the gyro rings object based on the global parameters.
 **/
module Generate() {
    // Make it a transparent yellow if we're showing a sliced sample
    color(sliceCenter?[255/255, 255/255, 0/255, 0.3]:false)
    difference() {
        // Generate the gyro rings
        GyroRings();
        // Slice in half if we're showing a sliced sample
        if (sliceCenter)
            translate([0, 0, height/2+1])
                cube([outerDia*2, outerDia*2, height+2], center=true);
    }
}

Generate();
