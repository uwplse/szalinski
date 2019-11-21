/* Spool parts storage organizer
   Based on https://www.thingiverse.com/thing:2793548 by hirez99

    Frank van der Hulst drifter.frank@gmail.com
    24 Feb 2018
    This generates a drawer that can be fitted into an empty filament spool to
    provide storage for small parts.
    Holes need to be drilled in the sides of the spool for axles
    A drill guide is provided to get the axle holes in the right places on the spool.
    Axles are provided using tbuser's Pin Connectors V2 library https://www.thingiverse.com/thing:10541

Requires v2016.XX of OpenScad

8 Sep 2018: Increase Spool Inner, Outer, and Hole Diameter maximum values

Still to do:

A latch to make it stay closed... I'm thinking a magnet glued into a corner
A stacker thing to stack multiple spools on top of each other
*******************************************************************************************************/

// Customizer User configuration settings...

$fn = 64;
// Outer diameter of the spool
Spool_Outer_Diam = 160; // [100:10:250]
// Inner diameter of the spool
Spool_Inner_Diam = 85; // [50:100]
// Diameter of the hole in the middle of the spool
Spool_Hole_Diam = 33; // [30:90]
// Width of spool between the sides
Spool_Width = 82; // [30:5:100]
// Thickness of spool wall
Spool_Wall_Thickness = 1; // [1:.5:3]

// Axle diameter (mm)
Axle_Diam = 8; // [2:20]
// Axle protrusion (mm) to link stacked drawers, and to go through one side of the spool
Axle_Height = 10; // [5:5:20]

// Number of organizer sections around the spool
Num_Drawers = 4; // [2:10]
// Number of drawers to stack in spool width
Drawer_Stack = 2; // [1, 2, 3, 4]

// Clearance between parts (mm)
Clearance = 0.3; // [0.2:0.1:2]

// Thickness of outer wall of organizer (mm)
Bottom_Thickness = 1.2; // [1.0:.25:3]
// Thickness of outer wall of organizer (mm)
Wall_Thickness = 1.6; // [1.6:.1:3]

// Type of internal divider
Divider_Type = "equal area"; // ["radial", "equal area"]
// Thickness of dividers inside the organizer (mm)
Divider_Thickness = 0.8; // [0.4:0.1:1.6]
// Height of dividers as percentage of drawer height
Divider_Height = 33; // [10:5:100]
// Number of rings of compartments
Num_Rings = 3; // [1,2,3]
// Number of compartments. If "radial is selected, there are the same number of compartments in every ring. If "equal area" is selected, there will be fewer compartments in inner rings, so that all compartments are approxiamtely the same area.
Num_Compartments = 10; // [1:20]

// [Hidden]
pi = 3.141592;
outerRad = Spool_Outer_Diam/2;
innerRad = Spool_Inner_Diam/2;
axleRad = Axle_Diam/2;
drawerAngle = 360/Num_Drawers;
axlePoint = [outerRad - axleRad - Wall_Thickness, axleRad + Wall_Thickness];
ringSize = (outerRad - innerRad - Wall_Thickness)/Num_Rings;


drawer((Spool_Width / Drawer_Stack) - Clearance, Spool_Wall_Thickness);
// Axle between drawers
if (Drawer_Stack > 1) 
    translate([axleRad+Wall_Thickness + 5, Axle_Height])
        pinpeg(h = Axle_Height * 2, r = axleRad, lh=3, lt=1);
// Axle pin -- print 2 per drawer
pintack(h=Axle_Height+Spool_Wall_Thickness, r=axleRad, lh=3, lt=1, bh=1.2, br = axleRad+Wall_Thickness);

// Guide
//translate([0, outerRad+Spool_Hole_Diam]) guide();


// The actual drawer, divided into compartments
module drawer(h, axleHeight) {
    difference() {
        union() {
            // floor
            linear_extrude(Bottom_Thickness) plan();
            linear_extrude(h) union() {
                // outer walls
                shell(Wall_Thickness) plan();
                // axle gusset
                tangentPoint=[axlePoint[0]+cos(135)*(axleRad+Wall_Thickness), 
                              axlePoint[1]+sin(135)*(axleRad+Wall_Thickness)];
                depth = sqrt(pow(tangentPoint[0]-(outerRad-Wall_Thickness), 2) + pow(tangentPoint[1]-Wall_Thickness, 2));
                outerGusset([outerRad-Wall_Thickness, Wall_Thickness], depth, outerRad);
                // outer corner gusset
                rotate(drawerAngle) 
                    outerGusset([outerRad, -Wall_Thickness], Wall_Thickness*2, outerRad, a=-45);
                // bottom inner corner gusset
                innerGusset([innerRad, Wall_Thickness], Wall_Thickness*2, innerRad, a=135);
                // top inner corner gusset
                rotate(drawerAngle) 
                    innerGusset([innerRad, -Wall_Thickness], Wall_Thickness*2, innerRad, a=225);
            }
            // Inner compartment divider
            divider(h * Divider_Height/100);
 
            // Handle
            linear_extrude(h/4) 
                rotate(drawerAngle)
                    translate([outerRad - Wall_Thickness, 0]) 
                            difference() {
                                translate([0, -10]) circle(r=10); 
                                translate([0, -10 - Wall_Thickness]) circle(r=10);              
                                translate([-20, -20]) square(20);
                                translate([10, -15]) rotate(45) square(10);
                            }

            }  
        // axle hole in top of drawer
        rotate([180, 0, 0]) translate([axlePoint[0], - axlePoint[1], -h])
            pinhole(h=Axle_Height, r=axleRad, lh=3, lt=1, t=Clearance, tight = false);
        // axle hole in bottom of drawer
        translate(axlePoint)
            pinhole(h=Axle_Height, r=axleRad, lh=3, lt=1, t=Clearance, tight = false);
    }
}


// The innder divider, to divide one drawer into multiple compartments
module divider(h) {
    linear_extrude(h) {
        // Concentric rings
        if (Num_Rings > 1) {
            for (i = [innerRad+ringSize+Divider_Thickness: ringSize: outerRad-ringSize]) {
                intersection() {
                    plan();
                    shell(Wall_Thickness = Divider_Thickness) circle(r=i);
                } 
            }
        }
        
        // Radial dividers
        if (Divider_Type == "radial") {
            // Equal number of dividers, irrespective of which ring they are in
            // Inner compartments will be smaller than outer compartments
            numRadials = round(Num_Compartments/Num_Rings);
            if (numRadials > 1) {
                divAngle = (drawerAngle - 2)/numRadials;
                for (a = [divAngle:divAngle:drawerAngle-12]) {
                    intersection() {
                        plan();
                        rotate(a) translate([innerRad2+1, 0]) square([ringSize, Divider_Thickness]);
                    } 
                }
            }
        } else if (Divider_Type == "equal area") {
            // Compartments of approximately equal area. There will be fewer dividers
            // on the inner rings than outer. Compartments on a ring will all be
            // the same size, but may differ a little from compartments on other
            // rings
            // Calculate the length of each ring, relative to the total length of all the rings
            ringLen = [for (r = [innerRad+ringSize: ringSize: outerRad]) r/outerRad];
            totalRingLen = sumv(ringLen, len(ringLen)-1);
            ringRelLen = [for (r = ringLen) r/totalRingLen];
            // Calculate how many divider for each ring    
            numDividers = [for (r = [0: Num_Rings-1]) round(ringRelLen[r]*Num_Compartments)];
            // Draw the dividers, equally spaced around the drawer
            for (r = [0:Num_Rings-1]) {
                divAngle = drawerAngle/numDividers[r];
                for (d = [1:numDividers[r]-1]) {
                    rotate(d * divAngle) 
                        translate([innerRad+r*ringSize, 0]) 
                            square([ringSize, Divider_Thickness]);
                }
            }
        }
    }
}


// Draw a 2D plan view of the drawer
// This is extruded for the floor, and used to mask other parts
module plan() {
    difference() {
        intersection() {
            difference() {
                circle(r= outerRad);
                circle(r = innerRad);
            }
            
            // NB: Use of diameter instead of radius in calculating polygon, so
            // the polygon is twice as big as the circle and its 2nd and 3rd sides don't
            // intersect with the circle
            if (Num_Drawers == 2) 
                // Handle special case for 2 sections
               polygon([[-Spool_Outer_Diam, 0], [Spool_Outer_Diam, 0], 
                        [Spool_Outer_Diam, Spool_Outer_Diam], [-outerRad, Spool_Outer_Diam]]);
            else
                polygon(points= [[0,0], 
                                [Spool_Outer_Diam, 0], 
                                [Spool_Outer_Diam, sin(drawerAngle)*Spool_Outer_Diam],
                                [cos(drawerAngle)*Spool_Outer_Diam, sin(drawerAngle)*Spool_Outer_Diam]
                               ]);
        
        }
        // Round off the corner at the axle to stop it interfering with the
        // next section when turning
        translate(axlePoint) round(axleRad + Wall_Thickness);     
    }
}


// The drill guide
module guide() {
    angleAxle = atan2(axlePoint[1]+axleRad, axlePoint[0]);
    
    linear_extrude(3) {
        for (a=[0:drawerAngle:drawerAngle]) 
            rotate(a) {
                translate(axlePoint) 
                    shell(3) circle(r=axleRad+3);
                polygon(points=[[Spool_Hole_Diam/2-Wall_Thickness, 0], 
                                [axlePoint[0]-axleRad, axlePoint[1]-3], 
                                [axlePoint[0]-axleRad, axlePoint[1]+ 3], 
                                [Spool_Hole_Diam/2-Wall_Thickness, 3]]);
            }
    }
    rotate_extrude(angle=drawerAngle+angleAxle)
            translate([Spool_Hole_Diam/2 - Wall_Thickness, 0]) 
                    square([Wall_Thickness, 6]); 
 }


// Gusset the inside of an outer corner
// point = point to apply guuset to
// depth = depth of gusset = minimum dispance from point to gusset edge
// r = radius of circle that this gu
module outerGusset(point, depth, r, a = 45) {
    points=[point, 
            [point[0], point[1] + depth*sin(a)*2], 
            [point[0]-depth*cos(a)*2, point[1]]];
    intersection() {
        circle(r);
        polygon(points = points);
    }
}


// Gusset the inside of an inner corner
// point = point to apply guuset to
// depth = depth of gusset = minimum dispance from point to gusset edge
// r = radius of circle that this gu
module innerGusset(point, depth, r, a = 45) {
    points=[point, [point[0]-Wall_Thickness, point[1] + depth*sin(a)*2], [point[0]-depth*cos(a)*2, point[1]]];
    difference() {
        polygon(points = points);
        circle(r);
    }
}


// Round the outside of a corner
module round(r, a = 90) {
        difference() {
            translate([0, -r]) 
                square(r);
            circle(r= r);
        }
}


// Shell of a 2D object to get an outline which can be extruded for a wall
module shell(thickness = 1) {
    difference() {
        children(0);
        offset(r=-thickness, chamfer=true) children(0);
    }
}


// Find the sum of the values in a vector from the start (or s'th element) to the i'th element
function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));

include <pins.scad>
