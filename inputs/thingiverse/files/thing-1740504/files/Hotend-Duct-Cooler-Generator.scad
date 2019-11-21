/*
 * Hotend Duct Cooler Generator. 
 * 
 * http://www.thingiverse.com/thing:1740504
 * 
 * By: Maxstupo
 */

// (Preset compatible with Sunhokey Prusa i3 2015)
// Variables preset for E3D v5 hotend (I think)

$fn = 50;


sideThickness = 4;
backThickness = 5;

// The height of the hot end cooling fins (or the height of the mount).
height = 32;

// The diameter of the hot end cooling fins.
hotendFinDiameter = 25;

/*[Fan Mount]*/

// The fan size used (eg. 30x30)
fanSize = 30;

// The inside diameter of the fan.
innerFanDiameter = 27;

// The spacing between the holes. (center to center)
fanMountHoleSize = 24;

// The plate thickness for the fan.
fanPlateThickness = 3;

// The length of the duct.
ductLength = 0;

// The thickness of the duct.
ductThickness = 2;

// The hole diameter for the fan mount holes.
fanPlateMountHoleDiameter = 2.5;

// The depth of the holes for the fan mount.
fanPlateMountHoleDepth = 5;

fanMountLength = fanPlateThickness+ductLength;

/*[Holder Tab]*/
tabHeightOffset = 0;
tabLength = 1;
tabThickness = 1.5;


width = hotendFinDiameter+sideThickness*2;
length = hotendFinDiameter;


module fanHole() {
    
    // Fan hole.
    fanHoleheight = length/2+backThickness;
    
    translate([width/2,fanHoleheight+1,height/2])rotate([90,0,0]) 
    cylinder(h=fanHoleheight+2,d=hotendFinDiameter,d2=hotendFinDiameter);
        
}

difference(){
    union() {
        difference() {
            cube([width,length,height]);
            
            // Slot for clipping onto the hotend.
            translate([width/2,length/2+backThickness,-1]) cylinder(h=height+2,d=hotendFinDiameter);
            
            fanHole();
        }
    
        // Tab to prevent mount sliding off the hotend.
        difference() {
            translate([width/2,length/2+backThickness,height/2-tabThickness/2+tabHeightOffset]) 
            cylinder(h=tabThickness, d=hotendFinDiameter);
            
            translate([width/2,length/2+backThickness,height/2-tabThickness/2+tabHeightOffset-1]) 
            cylinder(h=tabThickness+2,d=hotendFinDiameter-tabLength);
           
            fanHole(); 
            translate([0,length,0]) cube([width,backThickness,height]);
        }
        
        
        // Duct & Plate
        translate([width/2-fanSize/2,0,height/2-fanSize/2]) {
         
                // Plate
                difference() {
                    translate([0,-fanMountLength,0]) cube([fanSize,fanPlateThickness,fanSize]);
                    translate([fanSize/2,fanPlateThickness+0.5-fanMountLength,fanSize/2]) rotate([90,0,0]) cylinder(h=fanPlateThickness+1,d=innerFanDiameter);
                }
        
                // Duct
                difference() {
                    dd1 = hotendFinDiameter;
                    dd2 = innerFanDiameter;
                    
                    translate([fanSize/2,0,fanSize/2])  rotate([90,0,0]) cylinder(h=fanMountLength-fanPlateThickness,d=dd1+ductThickness,d2=dd2+ductThickness);     
                    translate([fanSize/2,0.25,fanSize/2])  rotate([90,0,0]) cylinder(h=fanMountLength-fanPlateThickness+0.5,d=dd1,d2=dd2);
                
                }
            
        }
        
    }
    
    // Fan mount holes.
    translate([width/2-fanSize/2,0,height/2-fanSize/2]) {
            translate([fanSize/2+fanMountHoleSize/2,fanPlateThickness-fanMountLength+fanPlateMountHoleDepth,fanSize/2+fanMountHoleSize/2]) rotate([90,0,0]) cylinder(h=fanPlateThickness+fanPlateMountHoleDepth,d=fanPlateMountHoleDiameter);
            translate([fanSize/2-fanMountHoleSize/2,fanPlateThickness-fanMountLength+fanPlateMountHoleDepth,fanSize/2+fanMountHoleSize/2]) rotate([90,0,0]) cylinder(h=fanPlateThickness+fanPlateMountHoleDepth,d=fanPlateMountHoleDiameter);
                    
            translate([fanSize/2+fanMountHoleSize/2,fanPlateThickness-fanMountLength+fanPlateMountHoleDepth,fanSize/2-fanMountHoleSize/2]) rotate([90,0,0]) cylinder(h=fanPlateThickness+fanPlateMountHoleDepth,d=fanPlateMountHoleDiameter);
            translate([fanSize/2-fanMountHoleSize/2,fanPlateThickness-fanMountLength+fanPlateMountHoleDepth,fanSize/2-fanMountHoleSize/2]) rotate([90,0,0]) cylinder(h=fanPlateThickness+fanPlateMountHoleDepth,d=fanPlateMountHoleDiameter);
    }
}


