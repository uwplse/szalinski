// Customizable Ultimate Drawer System Inserts
// Remixed from MarcElbichon's Ultimate Drawer System https://www.thingiverse.com/thing:2302575 (CC-BY 4.0)
// Copyright (C) 2019 by Brian Alano (and possibly others)
// Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 (CC-BY-NC-SA 4.0)

/* Design notes
// width is x dimension, across the face of the drawer
// depth is y dimension, front to back of the drawer
// height is z dimension
*/

/* Coding Style Guide 
 * User parameters and modules use underscores between words.
 * Other variable names use camel case.
 * Separate features into their own modules if they are more than a couple lines long.
 * All dimensions should be assigned to variables, usually global ones so they can be found easily.
 * Keep local modules local.
 * Keep local variables local.
 * Maintain Thingiverse Customizer compatibility.
 * Maintain backwards compatibility with MarcElbichon's Ultimate Drawer System 
   (https://www.thingiverse.com/thing:2302575). This means a 1Ux1Ux1U drawer 
   made with this program will work in MarcElbichon's shelf. 
   
   See README.md for more.
*/

/* [Size] */
// Outside width in mm (1U drawer is 118 mm inside, 1.5U is 182.5 mm, 2U is 249 mm)
Width=59; // [8:0.5:249]
// Outside depth in mm (1U drawer is 118 mm inside, 1.5U is 182 mm, 2U is 248 mm)
Depth=59; // [8:248]
// Outside height in mm (1U drawer is 18 mm inside, 2U is 38 mm, 3U is 58 mm, etc.)
Height= 18; // [8:398]
// This amount is subtracted from each of the six sides to provide some wiggle room. Half your nozzle diameter is a good place to start if you're not sure.
Tolerance=0.2; // [0.00:0.02:1.00]

/* [Hidden] */
drawerWallThickness = 1; // assumed
drawerCornerRadius = 4; // assumed
insertWallThickness = 1;
insertCornerRadius = drawerCornerRadius; 
insertSize = [Width - Tolerance*2, Depth - Tolerance*2, Height - Tolerance*2];

// utility variables
epsilon = 0.01;
$fn=24;

module insert() {
    module add() {
        // main body
       translate([0, 0, insertCornerRadius])
            linear_extrude(insertSize.z - insertCornerRadius)
            roundtangle([insertSize.x, insertSize.y], radius=insertCornerRadius);
        // filleted bottom
       translate([0, 0, insertCornerRadius])
            roundtangle3d([insertSize.x, insertSize.y], insertCornerRadius);
    }
    
    module subtract() {
        insideRadius = insertCornerRadius - insertWallThickness;
        // main cut, minus fillets
        cut = [insertSize.x - insertWallThickness*2, 
            insertSize.y - insertWallThickness*2, 
            insertSize.z - insertWallThickness];
        translate([0, 0, insideRadius + insertWallThickness - epsilon]) 
            linear_extrude(cut.z - insideRadius + epsilon * 2) 
            roundtangle([cut.x, cut.y], insideRadius );
        // fillet cut
       translate([0, 0, insideRadius + insertWallThickness]) 
            roundtangle3d([cut.x, cut.y], insideRadius);
    }
     
    difference() {
        add();  
        subtract();
    }
}

module roundtangle(size, radius) {
    minkowski() {
        square([max(size.x - radius*2, epsilon), max(size.y - radius*2, epsilon)], center=true);
        circle(r=radius);
    }
}

module roundtangle3d(size, r) {
    minkowski() {
        cube([max(size.x - r*2, epsilon), max(size.y - r*2, epsilon), epsilon], center=true);
        sphere(r=r );
    }
}
    
insert();
