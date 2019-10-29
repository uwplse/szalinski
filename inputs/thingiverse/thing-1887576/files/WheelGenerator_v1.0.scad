/*
 * Wheel Generator v1.0
 *
 * http://www.thingiverse.com/thing:1887576
 *
 * By: Maxstupo
 */

// (The outer diameter of the wheel):
outerDiameter = 70; 

// (The width of the wheel):
treadWidth = 15;

// (The thickness of the outer wheel ring):
treadThickness = 5; 

// (The axle diameter):
shaftDiameter = 4; 

// (The thickness of the hub):
hubThickness = 3; 

// (The width of the hub):
hubWidth = 8; 

// (If true use a keyed shaft hole):
useKey=true; // [true,false]

// (The offset of the key from the centre of the hole):
keyWidth = 0.5; 

// (Number of spokes):
spokeCount = 10;

// (The width of each spoke):
spokeWidth = 5; 

// (The height of each spoke in Z axis):
spokeThickness = 6;

/* [Misc] */
$fn = 50;


union(){
    hollowCylinder(outerDiameter,outerDiameter-treadThickness,treadWidth); // The "wheel"
 
    union(){
        hollowCylinder(shaftDiameter+hubThickness,shaftDiameter,hubWidth); // The wheel hub
        
        // Spokes
        difference(){
            union(){
                for (i = [0 : (360 / spokeCount) : 360]) {
                    rotate([0,0,i])translate([0,-spokeWidth/2,0]) cube([outerDiameter/2,spokeWidth,spokeThickness]);   
                }
            }
            translate([0,0,-1]) cylinder(h=spokeThickness+2,d=shaftDiameter);
            translate([0,0,-1]) hollowCylinder(outerDiameter+treadThickness,outerDiameter,spokeThickness+2);
        }
         
        // Make the shaft hole keyed
        if(useKey){
            difference(){
                translate([-shaftDiameter/2,keyWidth,0]) cube([shaftDiameter,shaftDiameter/2-keyWidth,hubWidth]);
                translate([0,0,-1]) hollowCylinder(outerDiameter-treadThickness,shaftDiameter+hubThickness,hubWidth+2);
            }
        }
    }
}

module hollowCylinder(od,id,h){
    difference(){
        cylinder(d=od,h=h);
        translate([0,0,-1]) cylinder(d=id,h=h+2);
    }
}