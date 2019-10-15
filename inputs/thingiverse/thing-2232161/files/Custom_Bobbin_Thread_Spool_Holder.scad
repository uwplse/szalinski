//	Customizable Bobbin Thread Spool Holder
//	Copyright by Drato Lesandar - Anika Uhlemann - RobotMama

// Number of rows
numRows = 3;

// Number of Spools in 1 row
numSpools = 5;

// Height of each spool in mm (determines the distance of dividers in a row)
heightSpool = 13;

// Thickness of dividers between each spool in mm
dividerThickness = 2;

// Radius of Spools in mm (Determines Size of each row)
radiusSpool = 10.25;

// Wall Thickness of every row in mm
wallThickness = 2;

// True = Flat Bottom for easy printability, false = rounded bottom
flatBottom = 1; //[1:true, 0:false]

rotate([90,0,0])
difference() {
   
    lengthHolder = (heightSpool+dividerThickness)*numSpools+dividerThickness;
    radiusOuter = radiusSpool+0.5+wallThickness;
    offset = wallThickness*0.5;//0.96;
    widthHolder = numRows*2*(radiusOuter-offset);
    
    union() {
        for (i = [0:numRows-1]) {
            difference() {
                // Outer Cyl
                 if (flatBottom) {
                    union() {
                    translate ([i*2*(radiusOuter-offset),0,0])
                    cylinder(lengthHolder, r = radiusOuter, center = true);
                    translate ([i*((radiusOuter-offset)*2),-(radiusOuter+0.01)*0.5,0])
                    cube([radiusOuter*2, radiusOuter,lengthHolder], center = true);
                    }
                }
                else {
                    translate ([i*2*(radiusOuter-offset),0,0])
                    cylinder(lengthHolder, r = radiusOuter, center = true);
                }
                // Cutout: inner Cyl
                translate ([i*2*(radiusOuter-offset),0,0])
                cylinder(lengthHolder+10, r = radiusSpool+0.5, center = true);
            }
            for (j = [0:numSpools]) {
            // Divider
                translate ([i*2*(radiusOuter-offset),
                            0,
                            j*(heightSpool+dividerThickness)-lengthHolder*0.5])
                cylinder(dividerThickness, r = radiusSpool+0.5, center = false);
            }
        }
        
    }
    //Cut away upper half of rows
    translate ([-(radiusOuter),0,-0.5*(heightSpool+dividerThickness*2+10)*numSpools])
    cube ([ numRows*2*(radiusOuter), 
            radiusOuter, 
            (heightSpool+dividerThickness*2+10)*numSpools], center = false);
}