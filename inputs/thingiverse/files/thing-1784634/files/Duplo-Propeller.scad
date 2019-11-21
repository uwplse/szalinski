// preview[view:north east, tilt:top diagonal]

// How many blades?
blades = 3; // [1:1:75]

// Length of blades
length = 45; // [1:1:300]

// Depth of propeller
depth = 10; // [1:1:75]

// How thick shall the blades be?
t = 2.2; // [0.1:0.1:7]

// Center hole for the shaft
shaft = 6.8; // [0:0.1:20]

// Do you want one flat side in the shaft hole?
cut = 0; // [1:Yes,0:No]

// Add a nudge
donudge = 1; // [1:Yes,0:No]

// Add nudge at x mm
nudge = 1.4; // [0:0.1:75]

// Cut off the top
docuttop = 1; // [1:Yes,0:No]

// How much to cut off the top
cuttopheight = 4.5;

/* [Hidden] */
angle = 45;

difference() {   
    ///////////////////////
    // Draw these things //
    ///////////////////////
    union(){
        for (rotation =[0:360/blades:360]) {
            rotate([0,0,rotation]) {
                translate([0,8,-5]) {
                    rotate([angle,0,0]) {
                        // Draw blades
                        cube([length, t, depth/sin(angle)+10],false);
                    } // End rotate
                } // End translate       
            } // End rotate
        } // End for spaceW

    if (depth>20) {
        // Draw center cylinder for deep propellers
        cylinder(h=depth, r1=depth/4, r2=depth/3, center=false, $fn=40);
        } else {
        // Draw center cylinder for shallow propellers
        cylinder(h=depth, r1=9, r2=depth/1.3, center=false, $fn=30); 
        } // End else
    } // End union

    ///////////////////////////
    // Cut away these things //
    ///////////////////////////

    // Draw shaft hole
    translate([0,0,-1]) {
        cylinder(h=depth+1, r1=shaft/2, r2=shaft/2, center=false, $fn=30);
    } // End translate

    // Cut away bottom
    translate([0,0,-5]) {
        cube([1000, 1000, 10],true);
    } // End translate

    // Cut away top
    translate([-500,-500,depth-1]) {
        cube([1000, 1000, 10],false);
    } // End translate
    
    if (docuttop==1) {
        translate([0, 0, depth-cuttopheight]) {
            difference() {
                cylinder(h=cuttopheight, r=length+1);
                translate([0, 0, -0.1]) cylinder(h=cuttopheight+0.2, r=shaft);
            }
        }
    }

} // End difference

// Draw extra part in shaft hole if cut is choosen
if (cut==1) {
    translate([shaft/3,-shaft/2,0]) {
        cube([shaft/3, shaft, depth-1],false);
    } // End translate
} // End if cut

// Add nudge inside shaft
translate([0, 0, 2]) {
    difference() {
        cylinder(h=nudge, r=shaft, $fn=30);
        translate([0, 0, -0.1]) cylinder(h=nudge+0.2, r=(shaft/2)-0.2, $fn=30);
    }
}

