/*
 * Wheel Generator v1.1
 *
 * http://www.thingiverse.com/thing:1887576
 *
 * By: Maxstupo
 */

// (The outer diameter of the wheel):
outerDiameter = 80; 

// (The width of the wheel):
treadWidth = 10;

// (The thickness of the outer wheel ring):
treadThickness = 5; 

// (The axle diameter):
shaftDiameter = 4; 

// (The thickness of the hub):
hubThickness = 10; 

// (The width of the hub):
hubWidth = 8; 

// (The width of the keyed hole, set to zero to disable):
keyWidth = 3.5; 

// (Number of spokes):
spokeCount = 10;

// (The width of each spoke):
spokeWidth = 5; 

// (The height of each spoke in Z axis):
spokeThickness = 6;

/* [Misc] */
$fn = 50;

makeWheel(outerDiameter,treadWidth,treadThickness,shaftDiameter,hubThickness,hubWidth,keyWidth,spokeCount,spokeWidth,spokeThickness);

module makeWheel(outerDiameter=80, treadWidth=10, treadThickness=5, shaftDiameter=4, hubThickness=10,hubWidth=8,keyWidth=1.5,spokeCount=10,spokeWidth=5,spokeThickness=6){
union(){
    hollowCylinder(outerDiameter, outerDiameter - treadThickness, treadWidth); // The "wheel"
 
    union(){
       hollowCylinder(shaftDiameter + hubThickness, shaftDiameter, hubWidth); // The wheel hub
        
        // Spokes
        difference(){
            union(){
                for (i = [0 : (360 / spokeCount) : 360]) {
                    rotate([0, 0, i]) translate([0, -spokeWidth / 2, 0]) cube([outerDiameter / 2, spokeWidth, spokeThickness]);   
                }
            }
            translate([0, 0, -1]) cylinder(h=spokeThickness + 2, d=shaftDiameter);
            translate([0, 0, -1]) hollowCylinder(outerDiameter + treadThickness, outerDiameter, spokeThickness + 2);
        }
         
        // Make the shaft hole keyed
        if(keyWidth>0){
            difference(){
                translate([-shaftDiameter / 2, -shaftDiameter / 2, 0]) cube([shaftDiameter, shaftDiameter - keyWidth, hubWidth]);
                translate([0, 0, -1]) hollowCylinder(outerDiameter - treadThickness, shaftDiameter + hubThickness, hubWidth + 2);
            }
        }
    }
}
}

module hollowCylinder(od, id, h){
    difference(){
        cylinder(d=od, h=h);
        translate([0, 0, -1]) cylinder(d=id, h=h + 2);
    }
}