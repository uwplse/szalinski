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
Width=59; // [8:0.1:249]
// Outside depth in mm (1U drawer is 118 mm inside, 1.5U is 182 mm, 2U is 248 mm)
Depth=59; // [8:0.1:248]
// Outside height in mm (1U drawer is 18 mm inside, 2U is 38 mm, 3U is 58 mm, etc.)
Height= 18; // [8:398]
// This amount is subtracted from each of the six sides to provide some wiggle room. Half your nozzle diameter is a safe place to start if you're not sure.
Tolerance=0.2; // [0.00:0.02:1.00]

/* [Island] */
Island_Shape="none"; //[none,round,square]
// Size of center insert-within-insert. Must be smaller than depth
Island = 27;
Island_Offset = 0;

/* [Pliers] */
// Set the outside width of a divider conforming to a general plier handle. 0 to disable.
Plier_Width=0;
// Set the outside height of a divider conforming to a general plier handle. 
Plier_Height=0;
Plier_Offset=0;

/* [Hidden] */
drawerWallThickness = 1; // assumed
drawerCornerRadius = 4; // assumed
insertWallThickness = 1;
insertCornerRadius = drawerCornerRadius; 
insertSize = [Width - Tolerance*2, Depth - Tolerance*2, Height - Tolerance*2];
X=[1, 0, 0];
Y=[0, 1, 0];
Z=[0, 0, 1];

// utility variables
epsilon = 0.01;
$fa=4;
$fs=0.5;

    
module double_fillet_profile(thickness, r) {
    module add() {
        translate([0, +r/2]) square([thickness+2*r, r], center=true);
    }
    
    module subtract() {
        reflect(X) translate([r+thickness/2, r]) circle(r);
    }
    
    difference() {
        add();
        subtract();
    }
}

module insert(size) {
    module add() {
        // main body
       translate([0, 0, insertCornerRadius])
            linear_extrude(size.z - insertCornerRadius)
            roundtangle([size.x, size.y], radius=insertCornerRadius);
        // filleted bottom
       translate([0, 0, insertCornerRadius])
            roundtangle3d([size.x, size.y], insertCornerRadius);
    }
    
    module subtract() {
        insideRadius = insertCornerRadius - insertWallThickness;
        // main cut, minus fillets
        cut = [size.x - insertWallThickness*2, 
            size.y - insertWallThickness*2, 
            size.z - insertWallThickness];
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

module island(size) {
    maxSize=min(size, Depth-insertCornerRadius*2-insertWallThickness);
    island=[maxSize*Width/Depth, maxSize];
    
    module side() {
        side=[island.x-insertCornerRadius*2, island.y-insertCornerRadius*2];
        reflect(X) 
            translate([(island.x-insertWallThickness)/2, 0]) rotate(X*90)
            linear_extrude(side.y, center=true) 
            double_fillet_profile(insertWallThickness, insertCornerRadius);
        reflect(Y) 
            translate([0, (island.y-insertWallThickness)/2]) rotate([90, 0, 90])
            linear_extrude(side.x, center=true) 
            double_fillet_profile(insertWallThickness, insertCornerRadius);  
    }
    
    module round() {
        scale([Width/Depth, 1]) 
            rotate_extrude() 
            translate([(island.y-insertWallThickness)/2, 0])
            double_fillet_profile(insertWallThickness, insertCornerRadius);
    }
    
    module add() {
        // corners
        reflect(X) reflect(Y) 
            translate([island.x/2 - insertCornerRadius, island.y/2 - insertCornerRadius]) 
            rotate_extrude(angle=90) 
            intersection() {
            translate([(insertCornerRadius-insertWallThickness/2), 0, 0]) double_fillet_profile(insertWallThickness, insertCornerRadius);
            square(insertCornerRadius*2);
        }
        
        // sides
        side();
    }
    
    translate([0, Island_Offset, insertWallThickness]) 
        if (Island_Shape=="round") {
            round();
        } else {
            add();
        }
    
}

module pliers(width, height, offset) {
    step=width/20;
    yFactor= height/y(0);
//    Height=19;
    
    function y(x) = -(pow(x/(width/2)-0.5,2))+2.25;
    
    module add() {
        translate([0, offset]) for(x=[-width/2:step:0]) {
            x0=x-step; // used to get angle0
            y0=y(x0)*yFactor; // used to get angle0
            y=y(x)*yFactor; // equation is normalized to -1<x<1, 0<y<1
            x2=x+step;
            y2=y(x2)*yFactor; 
            angle0=atan((y-y0)/(x-x0));
            angle1=atan((y2-y)/(x2-x));
            echo("x,y,x2,y2, angle", x, y, x2, y2,angle1);
            hull() 
            {
                translate([x, y, Height/4]) rotate([0, 0, 90+angle0]) cube([insertWallThickness, epsilon, Height/2], center=true); //double_fillet_profile();
                translate([x2, y2, Height/4]) rotate([0, 0, 90+angle1]) cube([insertWallThickness, epsilon,  Height/2], center=true);// double_fillet_profile();
            }
        }
    }
    
    reflect(X) intersection() {
        add();  
        translate([-width/2, offset]) cube([width/2, height, Height]);
    }
        
}

module reflect(vector) {
    children();
    mirror(vector) children();
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

//difference() {
    union() {
        insert(insertSize);
        if (Island_Shape != "none") island(Island);
        if (Plier_Width != 0) pliers(Plier_Width, Plier_Height, Plier_Offset);
    }
//    cube(100);
//}
