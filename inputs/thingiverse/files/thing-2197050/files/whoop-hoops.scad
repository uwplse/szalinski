/* [Base] */
// Select part for display, change settings for each part below
part = "Connector"; // [Connector, BatteryTray, SurfaceMount]

// Diameter of your base dowel
holeCenter = 16.2; // [10:0.1:50]
// Thickness of the wall around the dowel
wallThickness = 2; // [0.8:0.1:10]
// Thickness of the top and bottom shells
bottom = 1.4; // [0.5:0.1:10]

/* [Connector] */
// Height should be a little bit less than the diameter of what you are using for the hoop
height = 16; // [5:1:100]
// Hole diameter for zip tie
holeZip = 6; // [0:1:10]

/* [Battery Tray] */
// Length of th battery tray
batteryLength = 15; // [2:1:100]
// Width of the battery tray
batteryWidth = 35; // [10:1:100]
// Width of Zip tie
widthZip = 4; // [0:1:10]
// Roundness of corners
roundness = 2; // [0:1:2]

/* [Surface mount] */
flapWidth = 15; // [5:1:100]
mountHeight  = 10; // [5:1:100]

/* [Hidden] */
connectorHeight = mountHeight;
tapeWidth = flapWidth;
hole = holeCenter;
zip = holeZip;
walls = wallThickness;
$fn = 64;
holeRadius = hole / 2;
zipRadius = zip / 2;
xOffset = 8;
yOffset = 9;

totalHeight = height + bottom;
batteryHeight = bottom * 2 + zip;
batteryWidthOuter = batteryWidth + bottom * 2;

if(part == "Connector") gate();
if(part == "BatteryTray") rotate([0, 0, 180]) battery();
if(part == "SurfaceMount") connector();

module connector() {
    group() {
        hull() {
            cylinder(r = holeRadius + walls, h = bottom);

            translate([tapeWidth + holeRadius + walls - 1, 0, bottom / 2])
                cube([1, 5, bottom], center = true);
            
            translate([-tapeWidth - holeRadius - walls + 1, 0, bottom / 2])
                cube([1, 5, bottom], center = true);
        }

        difference() {
            cylinder(r = holeRadius + walls, h = bottom + connectorHeight);

            translate([0, 0, bottom])
                cylinder(r = holeRadius, h = bottom + connectorHeight);
        }

        translate([tapeWidth + holeRadius + walls, 0, bottom])
            cube([bottom, 5, bottom * 2], center = true);

        translate([-tapeWidth - holeRadius - walls  , 0, bottom])
            cube([bottom, 5, bottom * 2], center = true);
    }
}

module battery() {
    difference(){
        difference() {
            hull() {
                cylinder(r = holeRadius + walls, h = batteryHeight);
                
                translate([-batteryWidthOuter / 2, holeRadius + walls, 0])
                    cube([batteryWidthOuter, batteryLength, batteryHeight / 2]);
                
                
                translate([-batteryWidthOuter / 2, holeRadius + walls + batteryLength - roundness, bottom * 2 + zip -  roundness])
                    rotate([0, 90, 0])
                        cylinder(r=roundness, h = batteryWidthOuter);
                
                translate([-batteryWidthOuter / 2, holeRadius + walls, batteryHeight / 2])
                        cube([batteryWidthOuter, batteryLength - roundness, batteryHeight / 2]);
            }
            
            translate([0, 0, -1])
                cylinder(r = holeRadius, h = totalHeight + 2);
            
            translate([-batteryWidthOuter / 2 + bottom, holeRadius + walls, bottom])
                    cube([batteryWidth, batteryLength + 1, batteryHeight]);
        }
    
         translate([0, 0, bottom]) {
             difference() {          
                 translate([0, -holeRadius + walls + 1, 0])
                    cylinder(r = holeRadius * 2, h = zip);

                 translate([0, -holeRadius + walls + 1, 0])
                    cylinder(r = holeRadius * 2 - widthZip, h = zip); 
            }
        }
    }
}

module gate() {
    difference() {
        hull() {
            cylinder(r = holeRadius + walls, h = totalHeight);

            translate([-xOffset, -yOffset, 0])
                cylinder(r = holeRadius + walls, h = totalHeight);
                
            translate([xOffset, -yOffset, 0])
                cylinder(r = holeRadius + walls, h = totalHeight);  
        }
        
        translate([0, 0, bottom])
            cylinder(r = holeRadius, h = totalHeight + 2);
        
        translate([-zipRadius - holeRadius, -holeRadius  + zip / 2 - 0.5, -1])
            cylinder(r = zipRadius, h = totalHeight + 2);

        translate([holeRadius + zipRadius, -holeRadius  + zip / 2 - 0.5, -1])
            cylinder(r = zipRadius, h = totalHeight + 2);
        
        translate([-50, -100 - holeRadius - walls, bottom])
            cube([100, 100, totalHeight]);
    }
}
