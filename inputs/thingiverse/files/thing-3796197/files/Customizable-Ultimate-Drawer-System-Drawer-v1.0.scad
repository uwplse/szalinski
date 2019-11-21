// Customizable Ultimate Drawer System Drawer
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
*/

/* [Size] */
// units wide (actual drawer width is 131*U_wide - 10)
U_wide=1; // [1, 1.5]
// units deep (actual drawer depth is 130*U_deep - 10)
U_deep=1; // [1, 1.5]
// units high (actual drawer height is 20*U_high - 1)
U_high=3; // [1:15]

/* [Features] */
// What kind of drawer pull?
pull_style = "original"; // [original, ergonomic]
// modify the flange to allow for the drawer catch on the shelf?
drawer_catch = "no"; // [yes, no]
// include slots on the back of the drawer for the locking mechanism
rear_lock_slot = "no"; // [yes, no]

/* [Hidden] */
drawerUnit=[120, 120, 19];
shelfPadding=[11, 10, 1];

wallThickness = 1;
shelfUnit = [131, 130, 30];
shelf = [shelfUnit.x * U_wide, shelfUnit.y * U_deep, (shelfUnit.z - wallThickness*2) * U_high - wallThickness*2]; // reference dimension from shelf .scad file.
drawer = [shelf.x - shelfPadding.x, shelf.y - shelfPadding.y, shelf.z - shelfPadding.z];

cornerR = 4;
cornerD = cornerR * 2;
flangeR = 3;
flangeD = flangeR * 2;
flange = [3, d_to_y(U_deep)-10, 1];
pullD = 24.38;
pull = [2, pullD/2 + 2.8, 16];
label = [51, 2, 16];
labelSlot = [49, 1, 15];
labelWindow = [46, 1, 14];
catch = [flange.x * 0.4, d_to_y(U_deep) - 4, flange.z];
rearLockSlot = [26, 3.5, 8];

// utility variables
epsilon = 0.01;

// the spacing between drawings is 20, or drawerUnit.z + 1. so a 1U drawer is 19, a 2U drawer is 39, etc.
//FIXME replace with drawer[]
//FIXME put lock on bottom, not top.
function u_to_z(u) = (drawerUnit.z + shelfPadding.z) * u - shelfPadding.z;
function w_to_x(w) = (drawerUnit.x + shelfPadding.x) * w - shelfPadding.x;
function d_to_y(d) = (drawerUnit.y + shelfPadding.y) * d - shelfPadding.y;

module drawer() {
    module add() {
        // main body
        linear_extrude(u_to_z(U_high))
            roundtangle(width=w_to_x(U_wide), length=d_to_y(U_deep), radius=cornerR);
        // flanges
        linear_extrude(flange.z) 
            for (i = [1, -1]) {
                translate([w_to_x(U_wide)/2*i, -d_to_y(U_deep)/2] ) {
                    translate([-flange.x, 0]) square([flange.x*2, flange.y - flangeR]);
                    translate([0, flange.y - flangeR]) circle(r=flangeR);
                }
            }
        // pull
        translate([0, d_to_y(U_deep)/2, pull.z/2]) pull(style=pull_style);
        // label holders (positive part)
        for (i = [1, -1]) {
            translate([w_to_x(U_wide)/4*i, (d_to_y(U_deep) + label.y)/2 - epsilon, label.z/2]) cube([label.x, label.y + epsilon, label.z], center=true);
        }
        // rear lock pockets
        if (rear_lock_slot == "yes")
            for(j = [1:U_high])
                translate([0, -d_to_y(U_deep)/2, u_to_z(j)]) 
                    rearLockSlot();
    }
    
    module subtract() {
        // main cut, minus fillets
        cut = [w_to_x(U_wide) - wallThickness*2, d_to_y(U_deep) - wallThickness*2, u_to_z(U_high) - wallThickness - cornerR];
        translate([0, 0, u_to_z(U_high) - cut.z + epsilon]) 
            linear_extrude(cut.z + epsilon) roundtangle(cut.x, cut.y, cornerR);
        // fillet cut
       translate([0, 0, u_to_z(U_high) - cut.z]) 
            minkowski() {
                cube([cut.x - cornerD, cut.y - cornerD, epsilon], center=true);
                sphere(d=cornerD);
            }
        for (i=[1, -1]) {
            // label cuts
            translate([w_to_x(U_wide)/4*i, d_to_y(U_deep)/2 + labelSlot.y/2, labelSlot.z/2 + (label.z - labelSlot.z) + epsilon])
                cube(labelSlot, center=true);
            translate([w_to_x(U_wide)/4*i, d_to_y(U_deep)/2 + label.y - wallThickness/2, labelWindow.z/2 + (label.z - labelWindow.z) + epsilon])
                cube(labelWindow, center=true);
            // drawer catch cutout
            if (drawer_catch == "yes") {
               translate([(w_to_x(U_wide)/2 + flange.x - catch.x/2 + epsilon)*i, 
                d_to_y(U_deep)/2 - catch.y/2, 
                catch.z/2 - epsilon])
                    cube([catch.x + epsilon, catch.y, catch.z + 2*epsilon], center=true);
            }
        }
    }
     
    difference() {
        add();  
        subtract();
    }
}

module pull(style) {
    // drawer pull
    module original() {
        intersection() {
           translate([0, pull.y/2 - epsilon]) cube([pull.x, pull.y + epsilon, pull.z], center = true);
           translate([0, pull.y - pullD/2]) rotate([0, 90, 0]) cylinder(d=pullD, h=pull.x, center = true);
        }
    }

    module ergonomic() {
        difference() {
            original();
            translate([0, pull.y - pullD/2]) rotate([0, 90, 0]) {
                intersection() {
                    cylinder(d=pullD/2, h=pull.x+epsilon*4, center = true);
                    translate([0, pullD/3]) cylinder(d=pullD/2, h=pull.x+epsilon*4, center = true);
                }
            }
        }
        scale([3, 1, 1]) difference() {
            original();
            translate([0, pull.y - pullD/2]) rotate([0, 90, 0]) cylinder(d=pullD-pull.x*2, h=pull.x+epsilon*2, center = true);
        }
    }

    if (style == "original") original();
    if (style == "ergonomic") ergonomic();
}

module rearLockSlot() {    
    module half() {
        translate([rearLockSlot.x/2, -rearLockSlot.y, -drawerUnit.z + rearLockSlot.z/2]) 
        {
            cube([wallThickness, rearLockSlot.y, rearLockSlot.z/2]);
            rotate([0, 90, 0])
                linear_extrude(wallThickness) 
                polygon([[0, 0], [rearLockSlot.y, rearLockSlot.y], [0, rearLockSlot.y]]);
        }
        translate([0, -rearLockSlot.y, -drawerUnit.z + rearLockSlot.z/2]) 
            cube([rearLockSlot.x/2, wallThickness, rearLockSlot.z/2]);
    }
    
    module add() {
        for(i=[0, 1]) 
            mirror([i, 0, 0]) half();
    }
    add();
//    half();
}

module roundtangle(width, length, radius) {
    minkowski() {
                square([width - radius*2, length - radius*2], center=true);
                circle(r=radius);
            }
}
drawer();
//pull(style="ergonomic");
//rear_lock();