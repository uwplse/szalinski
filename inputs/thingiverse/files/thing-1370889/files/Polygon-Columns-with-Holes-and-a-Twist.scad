// Start Data Input

/* [Overview and Base] */
// Base Width (side to side). All distances are in mm. 
BX = 150;
// Base Depth (front to back)
BY = 100;
// Base Thickness Use 0 thickness for no base
BZ  = 8;
// Mounting hole diameter, mounting holes are located in the center of each edge of the base. Use 0 for no holes
BHDia = 2;

/* [Column 1] */
// Column 1 Diameter [diameter of the circle within which the column 1 polygon is inscribed] Use 0 for no Column 1.
C1D = 40;
// Column 1 Sides. (The number of sides for the Column 1 cross-section polygon.  3 sides make a triangle, 4 sides make a square, 5 sides make a pentagon, … Use a large number (e.g. 60 or 100) to make a polygon with so many sides that it appears to be circular when printed. Gotcha: objects with many sides may take a long time to be rendered as an object.
C1S =5;
// X coordinate for the center of column 1. The 0, 0, 0 origin for the coordinate system is the front left corner of the top of the base plate.
C1X = 23;
// Y coordinate for the center of column 1
C1Y = 32;
// Column 1 height above top of base.
C1Z = 25;
// Column 1 twist. Measured in degrees. e.g. 360 is one complete counter clockwise twist, 180 is a half twist, etc. Use negative degrees (e.g. -180) for clockwise twist. Use 0 for no twist
C1T = 180;
//Diameter of the circle within which the column 1 hole polygon is inscribed. Use 0 for no hole.
C1HDia = 30;
//Number of sides for the hole.
C1HS = 4;
// Depth of the Column 1 hole, measured down from the top of the column.
C1HDpth = 20;

/* [Column 2] */
// See Column 1 tab for explanation of the column parameters
C2D = 80;
C2S = 8;
C2X = 105;
C2Y = 50;
C2Z = 10;
C2T = 52;
C2HDia = 0;
C2HS = 60;
C2HDpth = 0;

/* [Column 3] */
// See Column 1 tab for explanation of the column parameters
C3D = 25;
C3S = 7;
C3X = 95;
C3Y = 30;
C3Z = 35;
C3T = -180;
C3HDia = 18;
C3HS = 60;
C3HDpth = 40;

/* [Column 4] */
// See Column 1 tab for explanation of the column parameters
C4D = 25;
C4S = 7;
C4X = 125;
C4Y = 40;
C4Z = 35;
C4T = 180;
C4HDia = 18;
C4HS = 60;
C4HDpth = 40;

/* [Column 5] */
// See Column 1 tab for explanation of the column parameters
C5D = 35;
C5S = 5;
C5X = 20;
C5Y = 68;
C5Z = 40;
C5T = 60;
C5HDia = 20;
C5HS = 5;
C5HDpth = 45;

/* [Column 6] */
// See Column 1 tab for explanation of the column parameters
C6D = 25;
C6S = 4;
C6X = 53;
C6Y = 68;
C6Z = 40;
C6T = 0;
C6HDia = 18;
C6HS = 60;
C6HDpth = 45;

/* [Column 7] */
// See Column 1 tab for explanation of the column parameters
C7D = 25;
C7S = 60;
C7X = 82;
C7Y = 72;
C7Z = 40;
C7T = 0;
C7HDia = 18;
C7HS = 60;
C7HDpth = 10;

/* [Column 8] */
// See Column 1 tab for explanation of the column parameters
C8D = 30;
C8S = 4;
C8X = 120;
C8Y = 70;
C8Z = 40;
C8T = 0;
C8HDia = 18;
C8HS = 60;
C8HDpth = 30;

/* [Column 9] */
// See Column 1 tab for explanation of the column parameters
C9D = 0;
C9S = 3;
C9X = 40;
C9Y = 20;
C9Z = 20;
C9T = 0;
C9HDia = 0;
C9HS = 6;
C9HDpth = 20;

/* [Column 10] */
// See Column 1 tab for explanation of the column parameters
C10D = 0;
C10S = 3;
C10X = 40;
C10Y = 20;
C10Z = 20;
C10T = 0;
C10HDia = 0;
C10HS = 6;
C10HDpth = 20;

// -- End data input

// -- Start Modules

//Base Builder Module builds the base and subtracts the mounting holes.

module base(X,Y,Z,BHD)
    {
        difference(){
    cube([X,Y,Z]);
           translate([BHD, Y/2, 0]) 
            cylinder (h = Z, r = BHD/2, center = false, $fn=100);
        translate([X-BHD, Y/2, 0]) 
            cylinder (h = Z, r = BHD/2, center = false, $fn=100);
        translate([X/2, BHD, 0]) 
            cylinder (h = Z, r = BHD/2, center = false, $fn=100);
        translate([X/2, Y- BHD, 0]) 
            cylinder (h = Z, r = BHD/2, center = false, $fn=100);
        }
    }

//Column Builder Module

module column(CD, CS, CX, CY, CZ, CT)
    {
        translate([CX, CY, 0])
        linear_extrude(height = CZ + BZ, center = false, twist = CT)
        circle(r=CD/2, $fn=CS);
    }
//Hole Builder Module
    
    module hole(HDia, HS, HX, HY, HZ, HDpth, HT)
        {
        translate([HX, HY, ((HZ + BZ) - HDpth)]) 
            linear_extrude(height = HDpth, center = false, twist = HT)
            circle(r=HDia/2, $fn=HS);
        }
// --- End Modules

// (Finally!) Construct the object 
//        by combining the base and the columns, and then subtracting the column holes.

difference() 
    // subtract the holes from the joined columns and base
{
    
union()
    // join the base and the columns
    
    {
    // build the base
        base(BX,BY,BZ,BHDia);
        
    // build the columns
        column(C1D,C1S,C1X,C1Y,C1Z,C1T);
        column(C2D,C2S,C2X,C2Y,C2Z,C2T);
        column(C3D,C3S,C3X,C3Y,C3Z,C3T);
        column(C4D,C4S,C4X,C4Y,C4Z,C4T);
        column(C5D,C5S,C5X,C5Y,C5Z,C5T);
        column(C6D,C6S,C6X,C6Y,C6Z,C6T);
        column(C7D,C7S,C7X,C7Y,C7Z,C7T);
        column(C8D,C8S,C8X,C8Y,C8Z,C8T);
        column(C9D,C9S,C9X,C9Y,C9Z,C9T);
        column(C10D,C10S,C10X,C10Y,C10Z,C10T);
}
union()
    //build and join the holes
    {
        hole(C1HDia, C1HS, C1X, C1Y, C1Z, C1HDpth, 0);
        hole(C2HDia, C2HS, C2X, C2Y, C2Z, C2HDpth, 0);
        hole(C3HDia, C3HS, C3X, C3Y, C3Z, C3HDpth, 0);
        hole(C4HDia, C4HS, C4X, C4Y, C4Z, C4HDpth, 0);
        hole(C5HDia, C5HS, C5X, C5Y, C5Z, C5HDpth, 0);
        hole(C6HDia, C6HS, C6X, C6Y, C6Z, C6HDpth, 0);
        hole(C7HDia, C7HS, C7X, C7Y, C7Z, C7HDpth, 0);
        hole(C8HDia, C8HS, C8X, C8Y, C8Z, C8HDpth, 0);
        hole(C9HDia, C9HS, C9X, C9Y, C9Z, C9HDpth, 0);
        hole(C10HDia, C10HS, C10X, C10Y, C10Z, C10HDpth, 0);
    }
}

