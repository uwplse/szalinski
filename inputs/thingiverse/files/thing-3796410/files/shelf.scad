// Customizable Ultimate Drawer System Shelf
// Remixed from MarcElbichon's Ultimate Drawer System https://www.thingiverse.com/thing:2302575 (CC-BY 4.0)
// Copyright (C) 2019 by Brian Alano (and possibly others)
// Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 (CC-BY-NC-SA 4.0) and
//// sharable under the GPLv3.

/* Release Notes
 * Version 1.1
 * Fixed error where hex and countersink holes were on the wrong sides (thanks, malikai!)
 * Optional front and rear snaps to hold drawers in and keep them from falling out
 * Added a foot that presses into the bottom holes
 * Fixed bug in bottom hole placement
 * Fixed rib in top interefers with top front clips at 1.5U W and 0.5U wide
 * Added 0.5U wide, and 0.5U deep, primarily for test 
 * Made screw holes optional
 * Optional top and bottom ribs (not needed if you are doing infill)
 
 * Version 1.01 - bugfix release
 * Fix bug in clips where variable was undefined
 * Remove non-functional "retaining clip" parameter
 */ 

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
 * Whereas normally an "include" file would handle parameters that are reused among code, 
   Customizer can't handle that. Instead we'll have to manually paste in the include file whenever it changes.
*/

// Walls are 5 mm (W_t). Slots are 20 mm apart. 0.5 mm gap (g) between side wall and drawer. 
// So the height of a shelf is U.z*(19+1)+W_t*2 = 20U.z+10, width is U.x*120+5*2+1, depth is U.y*120+5*2.
// A double-wide shelf (2-U.x), to stack nicely with a single wide, should be 
// 120U.z+11. With 5 mm walls, 2*(120+11)=D.x+2*W_t+2*g=D.x+11 => D.x (2U drawer width) = 262 - 11 = 251.
// A one-and-a-half wide drawer is (1.5-U.x) is 131+65.5 = 196.5-11 = 185.5.
//which part to render

//TO-DO 
// add stacking aligners
//
/* [General] */
// which part of the shelf to render. Customizer will generate one of each.
part="shelf"; //[shelf, clip, rear_lock, foot] 
//one U wide is 131 mm. Total width is 131*U.
U_Wide=1; //[0.5,1,1.5,2]
//one U high 20 mm for the drawer and 10 mm for the shelf, or 30 mm. In general, total height is 20*U + 10.
U_High=2; //[2:15]
//one U deep is 130 mm. Total depth is 130*U.
U_Deep=1; //[0.5,1,1.5,2]

/* [Shelf Features] */
// include holes for joining units together, or adding accessories like feet
holes="all"; // [all, bottom, none]
// enable using clips to hold shelves together
clips="no"; // [yes, no]
// add a drawer locking mechanism in the rear?
rear_lock="no"; // [yes, no]
// add strengthening ribs top and bottom (useful if you don't use infill)
ribs="yes"; // [yes,no]
// add rear snaps to keep drawers shut?
Rear_Drawer_Snap="no"; // [no, weak, medium, strong]
// add front snaps to keep drawers from falling out accidentally?
Front_Drawer_Snap="no"; // [no, weak, medium, strong]
/* [Rendering] */
// 3d printing layer height (optimizes some spacing)
//layer_height = 0.2; // [0.1:0.05:0.3]
// set this to printing before pressing Create Thing for best results
orientation = "printing"; // [printing, viewing]
// start at half your nozzle width. You may want different tolerances for different parts.
tolerance = 0.2;
/* [Hidden] */
epsilon = 0.01; // mainly used to avoid non-manifold surfaces
hole_diameter=5;
backThickness=2;
// hack for cutaway view of model
view=[0,0,0];

//shelfWidth = 131;
//shelfDepth = 130; //z direction
wallThickness = 5;
shelfUnit = [130, 131, 30]; //[50, 78, 30] is about as small as a test gets and still capture everything
// overall size of the shelf
shelf = [shelfUnit.x * U_Deep, shelfUnit.y * U_Wide, (shelfUnit.z - wallThickness*2) * U_High + wallThickness*2];
// Size of the major cut to hollow out the cube
shelfCut = [shelf.x, shelf.y - wallThickness*2, shelf.z - wallThickness*2];
/* We want 1 - 2W shelf to be the same dimension as 2 - 1W shelves. This means the drawer will be wider than 120*2 since there are no walls in between. Similarly, we want 2 - 1.5W shelves to be the same dimension as 3 - 1W shelves.
    so
    1W = 131 shelf, 131-10 = 121 cut, 131-11 = 120 drawer
    1.5W=131+65.5=196.5shelf,186.5cut,196.5-11=185.5drawer
    2W = 262 shelf, 262-10 = 252 cut, 262-11 = 251 drawer
    1D = 130 shelf, 130  = 130 cut, 130-10 = 120 drawer
    2D = 260 shelf, 260  = 260 cut, 260-10 = 250 drawer
    1U = (30-walls)*U+walls=30 shelf, 30-10  =  20 cut, 30-10-1=  19 drawer
    2U =  50 shelf, 50-10  =  40 cut, 50-10-1=  39 drawer
    W=
    Front to back we can do the same thing, though it's less useful.
   The same does not apply to the height. 2 - 2U shelves will be 100mm, but 1 - 4U shelf is only 90mm.
*/    

slotSpacing = shelfUnit.z - wallThickness*2;

rearLockSlot = [3.5, 26, 8]; // copied from the drawer as a reference dimension
flange = [shelfUnit.x*U_Deep-10, 3, 1]; // drawer flange copied from drawer v1.0 as a reference dimension
// size of the snap for the drawer catch. Dimension copied from drawer v1.0 as a reference dimension
catch = [
    shelf.x - wallThickness * 2 - 4, 
    flange.y * 0.4, 
    flange.z]; 

rearLockWallThickness = 1;
// tab is "tongue" part of the rear latch mechanism
tabSize = [1.5, rearLockSlot.y - rearLockWallThickness*2 - tolerance,
    rearLockSlot.z]; 
// bar is the main part of the rear_lock mechanism
barSize = [6.5 - tolerance, tabSize.y, slotSpacing];
snapHead = 4.2; // for rear lock // TEST reduced by 0.2 mm
snapInset = 3; // for rear lock

holeOffset = [20, 12.5, 16]; // positions of the holes from the outside edges of the respective sides
slotBottomWidth = 1.25;
slotSideLength = shelfCut.x - 10; // the length of the slot from front to back
slotTaperLength = 15; // how long the front slot taper is
clipCut = [10, 5, 8];
clip_bar_diameter = 2;
clipThickness = 1.2 - tolerance*2;
slotDepth = 3;

// countersink hole
counterbore_h = 0.5; 
countersink_h = 2.3; // 2.8
counterbore_d = 9;
through_d = 4.4;

// foot
padHeight = 1.6;

// Convenience definitions
X = [1, 0, 0]; // x-coordinate unit vector 
Y = [0, 1, 0]; // y-coordinate unit vector 
Z = [0, 0, 1]; // y-coordinate unit vector 

$fa=1;
$fs=.4;



// the spacing between drawings is 20, or unit.z + 1. so a 1U drawer is 19, a 2U drawer is 39, etc.
function zU(u) = slotSpacing * u - 1;

// extrude a given length of rear latch bar
module bar_stock(h) {
     reflect(Y) // double the profile half
        linear_extrude(h) 
        polygon([
            [-epsilon, epsilon], [-epsilon, -barSize.y/2],
            [1.35, -barSize.y/2],
            [barSize.x/2, -(barSize.y/2 - barSize.x/2 + 1.35)],
            [barSize.x - 1.35, -barSize.y/2],
            [barSize.x, -barSize.y/2],
            [barSize.x, epsilon]
        ]);
}

// create a foot, to be printed with flexible filament
module foot() {
    padRibHeight = 0.8;
    neckHeight = wallThickness - (counterbore_h + countersink_h) + tolerance;
    headHeight = countersink_h - tolerance * 2;
    footDiameter = counterbore_d*2;
    
    module add() {
        ringSpacing = 2;
        // put rings in the bottom for better grip
        for(d=[0:ringSpacing:footDiameter]) {
            translate([0, 0, -epsilon]) tube(od=d, id=d-ringSpacing/2, h=padRibHeight+epsilon);
        }
        // the foot pad
        translate([0, 0, padRibHeight]) cylinder(d=footDiameter, h=padHeight-padRibHeight);
        // the neck
        translate([0, 0, padHeight - epsilon]) cylinder(d=through_d - tolerance*4, h=neckHeight + epsilon);
        // the head
        translate([0, 0, padHeight + neckHeight - epsilon]) cylinder(d1=through_d - tolerance*2, d2=counterbore_d*0.75, h=headHeight + epsilon);
    }

    module subtract() {
        // remove the center of the head to make it squishable
        translate([0, 0, padHeight + neckHeight]) cylinder(d=through_d-1, h=headHeight + epsilon);
        // and put a split in it to make it more squishable
        translate([0, 0, padHeight + neckHeight + headHeight/2]) cube([1, counterbore_d+epsilon, headHeight+epsilon], center=true);
    }
    
    difference() {
        add();
        subtract();
    }
}

module shelf() {
    topSlotSpacing = 20.17; // measured from the original
    slot_w = 1.5;
    rearSnapStart = catch.x - catch.y; // distance from front
    snapMaxDepth =  shelf.x - rearSnapStart - backThickness;
    rearSnapDepth = Rear_Drawer_Snap=="weak" ? snapMaxDepth : 
                Rear_Drawer_Snap== "medium" ? snapMaxDepth :
                snapMaxDepth*2/3;
    frontSnapDepth = Front_Drawer_Snap=="weak" ?    wallThickness*4 : 
                Front_Drawer_Snap== "medium" ? wallThickness*3 :
                wallThickness * 2;
    snapWidth = wallThickness - slotDepth + 0.2; // 0.2 is a fudge factor to remove some artifacts
    snapHeight = slot_w * 4; 
    rearSnapHeadSize = flange.y * (Rear_Drawer_Snap == "weak" ? 0.2 : 0.4);
    frontSnapHeadSize = flange.y * 0.4;
    echo(rearSnapDepth, snapWidth, snapHeight);
 
 
    // h - height of inside of shelf
    // w - weidth of inside of shelf

    // make one of four wall mount plates for the back wall
    module back(mode="add") {
        r= slotSpacing;
        offset=holeOffset.z - hole_diameter/2;
        module add() {
            translate([wallThickness, wallThickness])
                rotate_extrude2(angle=90)
                square(size=[r, backThickness]);
        }
        module subtract() {
            translate([offset, offset]) 
                cylinder(d=hole_diameter, h=backThickness*4, center=true);
        }
        rotate([0, -90, 0]) // move it from the XY to YZ plane
            if (mode=="add") add(); else  subtract(); 
    }

    module countersink() {
        // counterbore
        translate([0, 0, -epsilon]) cylinder(d=counterbore_d, h=counterbore_h + epsilon*2);
        // countersink
        translate([0, 0, counterbore_h]) cylinder(d1=counterbore_d, d2=through_d, h=countersink_h);
        // through
        translate([0, 0, counterbore_h + countersink_h - epsilon]) cylinder(d=through_d, h=wallThickness);
    }

    module hex_hole() { 
        hex_w = 7.4;
       
        hex_h = 3.5;
        through_h = 1.5;
        through_d = 4.4;
        // hex head
        boxWidth = hex_w/1.75;
        translate([0, 0, hex_h/2-epsilon])
            for (r = [-60, 0, 60])
                rotate([0,0,r])
                cube([boxWidth, hex_w, hex_h+epsilon*2], true);
        // through hole
        translate([0, 0, hex_h - epsilon])
            cylinder(d=through_d, h=through_h + epsilon*2);
    }
    // make the slot and catch that the rear slot slides into
    module rear_slot(mode="add") {
        blockSize = [barSize.x, barSize.y + tabSize.y/2, shelfCut.z];
        
        // add a block of material to enclose the slot
        module add() {
            translate([-shelf.x/2 + blockSize.x/2, 0, 0])
                cube(blockSize, center=true);
        }
        
        module subtract() {
            // detents for the rear latch
            reflect(Y) {
                translate([-shelf.x/2 + blockSize.x/2 , barSize.y/2]) {
                    // one to hold it up
                    translate([0, 0, shelf.z/2 - slotSpacing/2 + snapHead/2])
                        cube([blockSize.x + epsilon *2, snapHead, snapHead], center=true);
                    // one to hold it down
                    translate([0, 0, shelf.z/2 - slotSpacing + snapHead/2])
                        cube([blockSize.x + epsilon *2, snapHead, snapHead], center=true);
                }
            }
        }

        if (mode=="add") add(); else subtract();
    }
    
    module side_slots(h, w) {
        
        // build the slot in the positive for subtraction later
        module half_side_slot() {
            w = 11.5;
            module add() {
                if (Front_Drawer_Snap == "no") {  
                    // we'll take some bites out of this to form a tapered lead-in
                    translate([- epsilon, -slotTaperLength]) square(size=[w/2+epsilon, slotTaperLength]);
                }   
                // and here is the actual slot
                translate([-epsilon, -slotSideLength]) square(size=[slot_w/2+epsilon, slotSideLength]);
            }
            
            module subtract() {
                // tapered lead-in
                r=31.86927424; // measured from original
                if (Front_Drawer_Snap == "no") translate([r + slot_w/2, -slotTaperLength]) circle(r=r);
            }
            
            translate([shelf.x/2, 0]) {
                rotate([0, 90, -90])
                    linear_extrude(slotDepth)
                        difference() {
                            add();
                            subtract();
                        }
            }

        } // half_side_slot

        module snaps(k) {
            if (Rear_Drawer_Snap != "no") {  
               // x is finger base thickness, y is width, z is length 
                translate([shelf.x/2-rearSnapStart - rearSnapDepth - tolerance, shelf.y/2 - snapWidth, -shelfCut.z/2 + slotBottomWidth + slotSpacing*k - tolerance] )        
                {
                // cut-outs for the rear snaps
                    rotate([90, 0, 90]) drawer_snap([snapWidth, snapHeight, rearSnapDepth], rearSnapHeadSize , mode="subtract");
                }
            }
            if (Front_Drawer_Snap != "no") {    
                translate([shelf.x/2 - frontSnapDepth, shelf.y/2 - (snapWidth), -shelfCut.z/2 + slotBottomWidth + slotSpacing*k - tolerance]) {
                    // cut-outs for the front snaps
                    rotate([90, 0, 90]) drawer_snap([snapWidth, snapHeight, frontSnapDepth], frontSnapHeadSize, mode="subtract");    
                }
            }
        } // snaps
        
        reflect(Y) {
            //bottom slot
            translate([epsilon, -w/2+epsilon, -shelfCut.z/2 + slotBottomWidth] )          
                mirror(Z)
                half_side_slot();
            for (k=[1:U_High-1]) {
                translate([epsilon, -w/2+epsilon, -shelfCut.z/2 + slotBottomWidth + slotSpacing*k] )          
                    reflect(Z)
                        half_side_slot();
            }
            for (k=[0:U_High-1]) {
                snaps(k);
            }
        }
    } // side_slots

    module top_slot() {
        length = shelf.x - 4; // measured from the original
        width = 1.5; // measured from the original
        cube([length, width, slotDepth], center=true);
    } 

    module add() {
        cube(shelf, center=true);
//      latch bosses. Needs work.
//        translate([(shelf.x - wallThickness)/2, yOffset, shelf.z/2]) 
//            rotate([0, 0, -90]) 
//            latch_boss();
    }

    module subtract() {
        // chamfer edges, 2mm, 45 degrees, so the chamfer face is the sqrt.
        chamfer = sqrt(2);
        reflect(Y)
            reflect(Z)
            translate([0, shelf.y/2, shelf.z/2]) 
            rotate([45, 0, 0]) 
              cube([shelf.x + epsilon *2, chamfer + epsilon, chamfer + epsilon], center=true); 
        // drawer opening
        cube([shelfCut.x + epsilon*4, shelfCut.y, shelfCut.z], center=true);
        // top slots, presumably for strengthening when infill = 0
        if (ribs == "yes") {
            reflect(Z)
                reflect(Y)
                for(y=[0 : topSlotSpacing : shelfCut.y/2 - (holeOffset.y  + wallThickness)])
                    translate([0, y, shelfCut.z/2 + slotDepth/2 - epsilon])
                    top_slot(); 
        }
        // bottom extra slot for bottom drawer
        reflect(Y)
            translate([shelf.x/2 - slotSideLength + epsilon, -shelfCut.y/2 - slotDepth + epsilon, -shelfCut.z/2])
            cube([slotSideLength, slotDepth, slotBottomWidth]);
        // side slots
        side_slots(h=shelfCut.z, w=shelfCut.y);

        // holes
        if (holes=="all" || holes=="bottom") reflect(X) {
            reflect(Y)
                // bottom holes
                translate([shelf.x/2 - holeOffset.x, shelf.y/2 - holeOffset.y, -shelfCut.z/2]) 
                rotate([180, 0, 0]) 
                countersink();
                if (holes=="all") {
                    // top holes
                    reflect(Y)
                        translate([shelf.x/2 - holeOffset.x, shelf.y/2 - holeOffset.y, shelfCut.z/2]) 
                        hex_hole();
                   reflect(Z) {
                     {
                         // left side holes
                        translate([shelf.x/2 - holeOffset.x, shelfCut.y/2, shelf.z/2 - holeOffset.z]) 
                            rotate([-90, 0, 0]) 
                            countersink();
                        // right side holes
                        translate([shelf.x/2 - holeOffset.x, -shelfCut.y/2, shelf.z/2 - holeOffset.z]) 
                            rotate([90, 0, 0]) 
                            hex_hole();
                    }
                }
            }
        }
    }
    
    module add2() {
//        retainer = [slotTaperLength/3, 1.5, 8]; // size of drawer retaining stop
//        bottom_retainer = [4, retainer.y, retainer.y]; // stop of bottom drawer retainer
        
        // material for the slot in the rear. We'll carve it up later.
        if (rear_lock=="yes") rear_slot("add");

        // back corners for wall mounting
        reflect(Y) reflect(Z)
            translate([-shelf.x/2 + backThickness, -shelf.y/2, -shelf.z/2]) 
            back("add");
        
        
        // fill in the back of the middle slot in case we need to
        // add the rear latch. If we don't we need to print with supports there.
        // "10" is the space between the drawer and the back of the shelf.
        translate([-shelf.x/2 + wallThickness/2 + 10, 0, shelf.z/2 - wallThickness/2])
            cube(wallThickness, center=true);
        
        // add the side snaps, if requested
        for (k=[0:U_High-1]) {
            reflect(Y) {
                if (Rear_Drawer_Snap != "no") {    
                    translate([0, shelf.y/2 - snapWidth, -shelfCut.z/2 + slotBottomWidth + slotSpacing*k + epsilon] )          
                    translate([shelf.x/2-rearSnapStart - rearSnapDepth - tolerance, 0])                         
                        rotate([90, 0, 90]) drawer_snap([snapWidth, snapHeight - tolerance * 2, rearSnapDepth + tolerance], rearSnapHeadSize);
                }
                if (Front_Drawer_Snap != "no") {    
                    translate([0, shelf.y/2 - snapWidth, -shelfCut.z/2 + slotBottomWidth + slotSpacing*k + epsilon] )          
                    translate([shelf.x/2 - frontSnapDepth , 0])                         
                        rotate([90, 0, 90]) drawer_snap([snapWidth, snapHeight - tolerance * 2, frontSnapDepth + tolerance], frontSnapHeadSize);
                }
            }
        }
    }
    
    module subtract2() {
 
        module clip_cut(short=false) {
            // creates a negative of the cut to be subracted
            // if short, don't make additional space to install the clip
            module add() {
               if (short) {
                    translate([clipCut.x/4, 0, 0]) cube([clipCut.x/2, clipCut.y+epsilon*2, clipCut.z], center=true);
                } else {
                    cube([clipCut.x, clipCut.y+epsilon*2, clipCut.z], center=true);
                }
            }
            module subtract() {
                translate([clipCut.x/2 - clipCut.y/2, 0, 0]) 
                    rotate([0, 0, 0]) 
                    cylinder(d=clip_bar_diameter, h=clipCut.x+epsilon*2, center=true);
            }
            difference() {
                add();
                subtract();
            }
        }       
        

       if (rear_lock == "yes") {
            // notch the rear lock slots
            if (rear_lock=="yes") rear_slot("subtract");

            // to-do: this stuff should be in rear_slot("subtract"), too
            barStockTolerance = 0.05; // 5%
            // cut the slot and grooves for the bar
            translate([-shelf.x/2 - barSize.x*barStockTolerance/2, 0, -shelfCut.z/2]) 
                scale([1+barStockTolerance, 1+barStockTolerance, 1]) 
                bar_stock(shelf.z);
            // cut a hole for the tabs
            // 10 is shelf.x - drawer.x
            tabHoleSize = [10 - barSize.x, barSize.y*(1+barStockTolerance), wallThickness + epsilon*2];       
            translate([-shelf.x/2 + barSize.x + tabHoleSize.x/2, 0, shelf.z/2 - tabHoleSize.z/2 + epsilon]) 
                cube(tabHoleSize, center=true);       
        }

        // screw holes in back corners for wall mounting
        reflect(Y) reflect(Z)
            translate([-shelf.x/2 + backThickness, -shelf.y/2, -shelf.z/2]) 
            back("subtract");
        // side clip cuts
        if (clips == "yes") {
            reflect(Y)
            {
               for(k=[0,U_High-1]) {
                    // front side clips
                   translate([(shelf.x-clipCut.x)/2+epsilon, (shelf.y-clipCut.y+epsilon)/2, -shelfCut.z/2 + slotBottomWidth + slotSpacing/2 + slotSpacing*k]) 
                   clip_cut(short=true);
                   // back side clips
                   translate([-(shelf.x-clipCut.x)/2-epsilon, (shelf.y-clipCut.y+epsilon)/2, -shelfCut.z/2 + slotBottomWidth + slotSpacing/2 + slotSpacing*k]) 
                    rotate([0, 0, 180]) clip_cut();
               }
               // top and bottom front clip cutouts
               reflect(Z) { 
                   // front
                   translate([shelf.x/2 - clipCut.x/2+epsilon, shelf.y/2-holeOffset.y, (shelf.z-clipCut.y)/2]) 
                    rotate([90, 0, 0]) 
                    clip_cut(short=true);
                   // back
                   translate([-shelf.x/2 + clipCut.x/2-epsilon, shelf.y/2-holeOffset.y, (shelf.z-clipCut.y)/2]) 
                    rotate([90, 0, 180]) 
                    clip_cut();
               }
           }
        }
    }
    difference() {
        union() {
            difference() {
                add();
                subtract();
            }
            add2();
        }
        subtract2();
    }
}


// create the bar that locks the drawers
module rear_lock() {
    tabSupportDepth = 2;
    knobHeight = 10.5;
    knobInnerDiameter = barSize.x/2;
    knobOuterDiameter = knobInnerDiameter + .4;
    
    module bar_segment() {
        // decided to face it down instead of up, there here's turning it upside down
        translate([0, 0, tabSize.z + tabSize.x + tolerance])
            mirror([0, 0, 1]) {
             // joint between tab and bar
             tabJointSize = [tabSupportDepth + tabSize.x, tabSize.y, tabSize.x];
             tabJointPosition = [barSize.x + tabSupportDepth/2 + tabSize.x/2, 0, tabSize.x/2];
             translate(tabJointPosition) 
                cube(tabJointSize, center=true);
            // tab, made from a set of points
            // TO-DO: chamfer the top in the x-axis
            tabPosition = [barSize.x + tabJointSize.x -tabSize.x, -tabSize.y/2, tabSize.x];
            chamfer = 4;
            translate(tabPosition) 
                rotate([90, 0, 90]) 
                linear_extrude(tabSize.x) {
                    translate([0, 0]) polygon([[0, 0], [0, tabSize.z - chamfer], 
                    [chamfer, tabSize.z], [tabSize.y - chamfer, tabSize.z],
                    [tabSize.y, tabSize.z - chamfer], [tabSize.y, 0]
                    ]);
                }
            }
    }
    
    // make a snap arm for the lock
    module snap() {
        linear_extrude(barSize.x - tabSize.x -tolerance*2) {
            union() {
                difference() {
                    // outer profile
                    resize([slotSpacing, tabSize.y/2 - snapHead/4])
                        circle(d=slotSpacing);
                    // inner profile
                    translate([0, tabSize.y*.7/24]) 
                        resize([slotSpacing*0.7, tabSize.y*0.7/2 - snapHead/4])
                        circle(d=slotSpacing);
                    translate([0, -slotSpacing/2]) square(slotSpacing);
                }
                // detent
                translate([-snapHead/2, barSize.y/4 - snapHead*3/8]) difference() {
                    circle(d=snapHead);
                    translate([0, -snapHead/2]) square(snapHead, center=true);
                }
            }
        }
    }

    module add() {
        // add the tabs
        for (k=[1:U_High]) {
            translate([0, 0, (k-1)*slotSpacing])
            bar_segment();
        }
        // bar
        translate([0, 0, 0]) 
            bar_stock(shelfCut.z - slotSpacing + wallThickness);

        // add support for the top tab
        translate([barSize.x - tabSize.x, -tabSize.y/2, shelfCut.z - slotSpacing])
            cube([tabSize.x, tabSize.y, tabSize.z + tabSize.x ]);

        // add the snaps
        reflect(Y) 
            rotate([0, 90, 0])
            translate([-shelfCut.z/2 - slotSpacing*(U_High - 2)/2 - wallThickness, 
                    tabSize.y/4 - snapHead/8, 
                    0])
            snap();
    }
    
    module subtract() {
        // create a finger hole
        holeFraction = 0.5; // how much space to give to the hole
        translate([barSize.x/2-epsilon, 0, shelfCut.z - slotSpacing - barSize.y/2*(1-holeFraction)])
            cube([barSize.x + epsilon*4, barSize.y*holeFraction, barSize.y*holeFraction], center=true);
        
        // make some room for the snap to move
        reflect(Y)
            translate([barSize.x/2 - epsilon, -barSize.y/2 - epsilon, shelfCut.z - slotSpacing + wallThickness + epsilon ]) 
            rotate([0, 90, 0]) linear_extrude(barSize.x+epsilon*4, center=true) 
            polygon([[0, 0], [0, snapHead], [snapHead, 0]]);
            
    }
    
    difference() {
        add();
        subtract();
    }
} 

// size is [depth, width, height], where
//depth is thickness of finger, width is width of finger, and height is length of finger.
module drawer_snap(size, head_size, mode="add") {
    // x - width
    // y - height
    // z - depth
    if (mode == "add") {
        // the finger
        {
            hexahedron(size1=[size.x, size.y], size2=[size.x/2, size.y], offset1=[size.x/2, 0], offset2=[size.x/4, 0], h=size.z);
        // the head
            translate([0, 0, size.z - catch.y]) rotate([90, 0, 0]) 
                cylinder(r=head_size, h=size.y, center=true, $fn=4);
        }
    } else { //mode == subtract
        // put a cut-out around the snap
        translate([-tolerance, -catch.y/2, 0]) 
            minkowski() {
                drawer_snap([size.x, size.y-catch.y + tolerance, size.z], "add");
                cube(catch.y + tolerance*2);
            }
    }
}
/* UTILITY FUNCTIONS */

/*
https://www.thingiverse.com/thing:2479342/files
Customizable Clip for storage box
by jrd3n Aug 30, 2017j
*/
module clip(ZExtrude, topdia, bottomDiam, spacebetween, Thickness) {

    linear_extrude(ZExtrude) {

    Clip(topdia,bottomDiam,spacebetween,Thickness);

    }
    module Clip(topdia,bottomDiam,spacebetween,Thickness) {
        
        union(){
            click(topdia , Thickness);
            
            click(bottomDiam , Thickness, [0,-spacebetween],-90, false);
        
       
            Line([(topdia+Thickness)/2,0],[(bottomDiam+Thickness)/2,-spacebetween],Thickness);
            Line([(bottomDiam+Thickness)/2,-spacebetween],[(bottomDiam+Thickness)/2, -spacebetween-bottomDiam],Thickness);

        }
    }
    module click(size,thickness, XY = [0,0],Angle = 0, full = true) {
        
        YMovement = -size*0.7;
        CentrePoint = [0,YMovement/2];
        OuterDiameter = size+(thickness*2);
        ConstantDistance = (size+thickness)/2;
        
        
        translate (XY) {
            rotate ([0,0,Angle]) {
                
                difference() {

                    union() {
                        // point ();
                        
                        circle(d = OuterDiameter, $fn=50);
                        
                        translate(CentrePoint) {
                            square([OuterDiameter,-YMovement], center = true);
                        }
                    
                        point ([ConstantDistance,YMovement], thickness);
                        point ([-ConstantDistance,YMovement], thickness);					
                    
                    }
                                
                    union() {
                        // point ();
                        
                        circle(d = size, $fn=50);
                        
                        translate([0,YMovement]) {
                            circle(d = size, $fn=50);
                        }	
                        
                        if (full!=true){
                            
                            translate([-ConstantDistance,YMovement/2]) {
                                square([ConstantDistance*2,ConstantDistance*4], center = true);
                            }
                                                
                        }
                                        
                    }	
                }
            }
        }
    }		
    module Line( XY1 , XY2 , Thickness ) {
        
        Ad = XY1 [0] - XY2[0];
        Op = XY1 [1] - XY2[1];
        Hyp = sqrt(pow(Op,2) + pow(Ad,2) );
        Angle = atan(Op/Ad);
        
        translate (Mid (XY1,XY2)){
            rotate([0,0,Angle]){
                square ([Hyp,Thickness], center = true);
            }		
        }
        
        point(XY1,Thickness);
        point(XY2,Thickness);
    }

    function Mid (XYstart,XYfin) = (XYstart + XYfin) / 2;
    module point (XY = [0,0] , Size = 1) {

        translate(XY) {
        
        circle(d = Size, $fn=50);
        
        }
    }
}


/* render both the child object and its mirror 
    usage: otherwise operates just like mirror()
*/
module reflect(v) {
    children();
    mirror(v) children();
}

// create a hollow cylinder, or tube
module tube(od, id, h=1, center=false) {
    epsilon = 0.01;
    difference() {
        cylinder(d=od, h=h, center=center);
        translate([0, 0, -epsilon]) 
            cylinder(d=id, h=h+epsilon*2, center=center);
    }
}

// create a hexahedron with a rectanglar base and rectangular top
// if size2 is omitted, top is dimishingly small (you get a four-sided pyramid)
module hexahedron(size1, size2=[0.001, 0.001], offset, offset2=[0,0], size, offset1=[0,0], h) {
    mySize1 = is_undef(size) ? size1 : size;
    myOffset1 = is_undef(offset) ? offset1 : offset;
    myOffset2 = is_undef(offset2) ? myOffset1 : offset2;
    epsilon = 0.001;
    if (is_undef(mySize1)) echo("Error! pyramid(): either size or size must be specified");
    hull() {
        translate(myOffset1) cube([mySize1.x, mySize1.y, epsilon], center=true);
        translate([myOffset2.x, myOffset2.y, h-epsilon]) cube([size2.x, size2.y, epsilon], center=true);
    }
}

/* rotate_extrude2 contributed by thehans 
 * http://forum.openscad.org/rotate-extrude-angle-always-360-td19035.html
 */
module rotate_extrude2(angle=360, convexity=2, size=1000) {


    module angle_cut(angle=90,size=1000) {
        x = size*cos(angle/2);
        y = size*sin(angle/2);
       translate([0,0,-size])
            linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
    }

    // support for angle parameter in rotate_extrude was added after release 2015.03
    // Thingiverse customizer is still on 2015.03
//    angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
    // Using angle parameter when possible provides huge speed boost, avoids a difference operation

//    if (angleSupport) {
//        rotate_extrude(angle=angle,convexity=convexity)
//            children();
//    } else {
        rotate([0,0,angle/2]) difference() {
            rotate_extrude(convexity=convexity) children();
            angle_cut(angle, size);
        }
//    }
}

/* MAIN  */
// display the selected part, either in context in usable orientation or
// in isolation in printable orientation
module main() {
    module shelf_clip() {
        clip(clipCut.z - tolerance*2, clip_bar_diameter+tolerance*2, clip_bar_diameter+tolerance*2, clipCut.y, clipThickness);
    }
    
    if (orientation == "viewing") {
        if (part == "foot") {
                reflect(X) reflect(Y) translate([shelf.x/2 - holeOffset.x, shelf.y/2 - holeOffset.y, -shelf.z/2 - padHeight]) foot();
                %shelf();
        } else if (part == "shelf") {
            %if (rear_lock == "yes") translate([-shelf.x/2, 0, -shelfCut.z/2]) rear_lock();
            shelf();
        } else if (part == "clip") {
            %shelf();
            // front side clips
            reflect(X) {
                for(k=[0:U_High-1]) {
                    // right side
                    translate([(shelf.x-clipCut.x/2)/2, 
                        (shelf.y-clipCut.y)/2, 
                        -shelfCut.z/2 + slotBottomWidth + slotSpacing/2 + slotSpacing*k + clipCut.z/2 - tolerance]) 
                        rotate([180, 0, 0]) 
                        shelf_clip();
                    // top clip cutouts
                    reflect(Y) { 
                        // front
                        translate([shelf.x/2 - clipCut.x/4, 
                            shelf.y/2 - holeOffset.y - clipCut.z/2 + tolerance, 
                            (shelf.z-clipCut.y)/2]) 
                            rotate([-90, 0, 0]) 
                            shelf_clip();

                    }
                }
            }
        } else if (part == "rear_lock") {
            if (orientation == "viewing") {
                %shelf();
                translate([-shelf.x/2, 0, -shelfCut.z/2]) rear_lock();
            }
        }
    } else { // printing orientation
        if (part == "foot") {
            foot();
        } else if (part == "shelf") {
            rotate([0, -90, 0]) shelf();
        } else if (part == "clip") {
            shelf_clip();
        } else if (part == "rear_lock") {
                rotate([90, 0, 0]) rear_lock();
        }
    }
}

main();