/*
 * Customizable drawers for use in empty filament spools.
 *
 * Features:
 *  * Supply spool dimensions to make drawer sizing and preview easy
 *  * Allows 2 to 5 equal sized drawers per layer
 *  * Can have 1 or 2 layers, with different drawer heights per layer.
 *  * Allows adjusting the drawer wall and bottom thickness
 *  * Has an assembly preview option to get an idea of the final assembly.
 *  * Can simulate opening one drawer for visual help, or to test clearances -
 *    with equal sized drawers, 5 per layer is about as much as is possible
 *    before drawers starts interfering.
 *  * With multi layer option selected and drawers of different height, both
 *    drawers will be drawn in print mode.
 *  * Can generate a thin tester outline of the drawer to test fit the spool
 *    before final print.
 *  * Can generate a template for exact drilling of the hinge holes in the
 *    spool. See notes below.
 *
 * -----------
 * Note on the template option:
 * The SVG and DFX exports in the current nightly build of OpenSCAD I'm using
 * does not seem to be working, so the only way to use the template from here
 * is to export as STL and then import into some 3D CAD program, like FreeCAD,
 * generate a solid from the STL, and then a top view drawing. This drawing can
 * then be exported to PDF and printed on paper. Hope this would be easier in a
 * future version of OpenSCAD :-)
 * -----------
 *
 *
 * Thanks to keynes87 (https://www.thingiverse.com/keynes87) for his excellent
 * modules to draw the drawers in his thing here: https://www.thingiverse.com/thing:2142608
 * This thing grew out of his design!
 *
 * Author : Tom Coetser (Fitzterra) <fitzterra@icave.net>
 *
 * License:
 * This work is licensed under the Creative Commons Attribution 3.0 Unported
 * License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by/3.0/ or send a letter to Creative
 * Commons, PO Box 1866, Mountain View, CA 94042, USA.
 *
 *
 * ToDo:
 *  - Allow different size drawers around the circumference. The current
 *    customizer componets for variable definition is a bit limiting, so maybe
 *    another day.
 *
 * Releases:
 *  v1.0 - Initial release, but did not contain version numberthen
 *  v1.1 - Fixed bug in generating the hinge holes and add option for finger
 *         notch instead of handle. With the changes in the hinge hole
 *         generation, drawers created with the same parameters in v1.0 will
 *         **not** align with v1.1 and later drawers!
 */

/* [Hidden] */
version = "v1.1";

/* [ General parameters ] */
// Granularity for mainly hinge chamber cylinder and handle rounded edge.
$fn = 120;
// What to generate? The template can be used to drill holes for the hinge shafts.
mode = "assembly"; // [assembly, print, tester, template1, template2, template3]
// Show the spool in assembly mode?
showSpool = true;
// Project templates in 2D to enable export as SVG or DXF?
template2D = false;

/* [ Spool dimensions ] */
// Spool inner diameter.
spoolID = 60;
spoolIR = spoolID/2;
// Spool outer diameter.
spoolOD = 200;
spoolOR = spoolOD/2;
// Spool inner height between walls - max drawer height. Always measure height at spool inner hub!
spoolIH = 60;
// Spool wall width.
spoolWW = 4;
// Spool hub inner diameter - diameter of hole in spool center.
spoolHubID = 54;
// Spool color - See OpenSCAD color transformation for color names.
spoolColor = "DimGray";
// Spool color alpha - For transparent spool holders (does not render 100% as expected :-( )
spoolColorAlpha = 1.0; // [0.0:0.05:1.0]

/* [ Drawer Base ] */
// Drawer height - leave 0 to use spoolIH and 1mm clearance.
drawHeight = 0;
// Drawer wall width.
drawWW = 3;
// Drawer bottom thickness.
drawBT = 3;
// Drawer hinge pin outer diameter.
hingePinOD = 5;
// Hinge pin housing outer diameter.
hingeHousingOD = hingePinOD+3;
// Drawers Color - See OpenSCAD color transformation for color names.
drawColor = "RoyalBlue";

/* [ Drawer Configuration ] */
// Number of drawers around circumference. Min 2, max 5.
numDrawers = 4; // [2:1:5]
// Add another layer of drawers if drawHeight < spoolIH?
dualLayer = true;
// Gap between dual layers
layersGap = 1;
// Handle or finger notch to open drawer with
handle = false;
// Angle to open one drawer for testing in assembly mode
openAngle = 10; // [0:5:90]


// Full height or drawer height
dHeight = drawHeight==0 ? spoolIH-1 : drawHeight;
// Height for 2nd layer of drawers if dualLayer is true and there is enough
// space in the spool inner height after subtracting the base drawer height and
// the fill gap.
d2Height = dualLayer ? ( (dHeight+layersGap)<spoolIH ? spoolIH-(dHeight+layersGap) : 0) : 0;
if(d2Height) {
    echo("Bottom layer drawers height: ", dHeight);
    echo("Second layer drawers height: ", d2Height);
} else {
    echo("Drawer height: ", dHeight);
}

// Angle per drawer
drawerAngel = 360/numDrawers;

module arc(spoolOR, spoolIR, angle) {
    points_outer= [
        for(a = [0:1:angle]) [spoolOR * cos(a), spoolOR * sin(a)]
    ];
    points_inner= [
        for(b = [0:1:angle]) [spoolIR * cos(b), spoolIR * sin(b)]
    ];
    difference() {
        polygon(concat([[0, 0]], points_outer));
        polygon(concat([[0, 0]], points_inner));
        translate([spoolOR-hingeHousingOD/2,hingeHousingOD/2,0])
            circle(hingePinOD/2);
        translate([spoolOR-hingeHousingOD/2,0,0])
            square(hingeHousingOD/2);
    }
}

module shell(angle) {
    difference() {
        arc(spoolOR, spoolIR, angle);
        offset(-drawWW)
            arc(spoolOR, spoolIR, angle);
    }
}

module handle(angle) {
    translate([spoolOR*cos(angle)+drawWW*2*cos(angle-90),
               spoolOR*sin(angle)+drawWW*2*sin(angle-90),
               1])
        rotate(angle)
            offset(drawWW)
                square([10,drawWW]);
}

module screw(){
    difference() {
        circle(d=hingeHousingOD);
        circle(d=hingePinOD);
    }    
}

module drawer(angle, height) {

    fnd = 25;
    difference() {
        union() {
            // The floor
            linear_extrude(drawBT)
                arc(spoolOR, spoolIR, angle);
            // Walls
            linear_extrude(height)
                shell(angle);
            // Rounded screw chamber
            translate([spoolOR-hingeHousingOD/2,hingeHousingOD/2,0])
                linear_extrude(height)
                    screw();
            // Drawer handle
            if(handle)
                linear_extrude(height)
                    handle(angle);
        }
        // Finger notch if no handle
        if(!handle && height>(fnd/2))
            rotate([0, 0, drawerAngel-12])
            translate([spoolOR+spoolWW/2, 0, height+fnd/10])
                rotate([0, -90, 0])
                    cylinder(d=fnd, h=spoolWW*2);
    }
}


module spool() {
    color(spoolColor, spoolColorAlpha)
    difference() {
        union() {
            // Center cylinder
            cylinder(d=spoolID, h=spoolIH);
            // Walls
            for(z=[-spoolWW, spoolIH])
                translate([0, 0, z])
                    cylinder(d=spoolOD, h=spoolWW);
        }
        translate([0, 0, -spoolWW-0.1])
            cylinder(d=spoolHubID, h=spoolIH+spoolWW*2+0.2);
    }
    // Hinge holes
    color("silver")
    for (n=[0:drawerAngel:359])
        rotate([0, 0, n])
            translate([spoolOR-hingeHousingOD/2, hingeHousingOD/2, -spoolWW-0.1])
                cylinder(d=hingePinOD, h=spoolIH+spoolWW*2+0.2);
}

module holesTemplate() {
    difference() {
        // Wall
        cylinder(d=spoolOD, h=1);
        // Center hole
        translate([0, 0, -0.1])
            cylinder(d=spoolHubID, h=1.2);
        // Hinge holes
        for (n=[0:drawerAngel:359])
            rotate([0, 0, n])
                translate([spoolOR-hingeHousingOD/2, hingeHousingOD/2, -0.1])
                    cylinder(d=hingePinOD, h=1.2);
    }
}

module holesTemplate2() {
    th = 1.2;
    for (n=[0:drawerAngel:359])
        rotate([0, 0, n])
            difference() {
                hull() {
                    cylinder(d=3, h=th);
                    translate([spoolOR-hingeHousingOD/2, hingeHousingOD/2, 0])
                        cylinder(d=hingePinOD+3, h=th);
                }
                translate([spoolOR-hingeHousingOD/2, hingeHousingOD/2, -0.1])
                    cylinder(d=2, h=th+0.2);
            }
    difference() {
        cylinder(d=spoolHubID+4, h=th);
        translate([0, 0, -0.1])
            cylinder(d=spoolHubID, h=th+0.2);
    }
    difference() {
        cylinder(d=spoolOD/1.5+4, h=th);
        translate([0, 0, -0.1])
            cylinder(d=spoolOD/1.5, h=th+0.2);
    }
}

module holesTemplate3() {
    difference() {
        holesTemplate();
        translate([0, 0, -0.1])
            cylinder(r=spoolOR-hingeHousingOD, h=2);
    }
}

module drawersLayer(height) {
    for (n=[drawerAngel:drawerAngel:359])
        rotate([0, 0, n])
            drawer(drawerAngel-1, height);
    
    translate([spoolOR-hingeHousingOD/2, hingeHousingOD/2, 0])
        rotate([0, 0, -openAngle])
            translate([-spoolOR+hingeHousingOD/2, -hingeHousingOD/2, 0])
                drawer(drawerAngel-1, height);
}


// Only show the spool in assembly mode if required
if(showSpool && mode=="assembly")
    spool();

if(mode=="assembly") {
    // Base layer of drawers
    color(drawColor)
    drawersLayer(dHeight);
    if (d2Height)
        translate([0, 0, dHeight+layersGap])
            color(drawColor)
            drawersLayer(d2Height);
} else if(mode=="print") {
    translate([0, -spoolIR*cos(drawerAngel/2), 0])
        rotate([0, 0, 90-drawerAngel/2])
            drawer(drawerAngel-1, dHeight);
    if (d2Height)
        translate([0, -spoolOR, 0])
            rotate([0, 0, 90-drawerAngel/2])
                drawer(drawerAngel-1, d2Height);
} else if(mode=="template1") {
    if (template2D==true) {
        projection()
            holesTemplate();
    } else {
       holesTemplate();
    }
} else if(mode=="template2") {
    if (template2D==true) {
        projection()
            holesTemplate2();
    } else {
       holesTemplate2();
    }
} else if(mode=="template3") {
    if (template2D==true) {
        projection()
            holesTemplate3();
    } else {
       holesTemplate3();
    }
} else if(mode=="tester") {
    difference() {
        translate([0, -spoolIR*cos(drawerAngel/2), -drawBT-0.1])
            rotate([0, 0, 90-drawerAngel/2])
                drawer(drawerAngel-1, drawBT+1.1);
        translate([0, 0, -drawBT-1])
            cylinder(d=spoolOD*1.5, h=drawBT+1.1);
    }
}
