// Inside Width of the Box
InnerWidth = 70; //[0:0.1:200]

// Inside Length of the box
InnerLength = 135; //[0:0.1:200]

// Inside Height of the box
InnerHeight = 50; //[0:0.1:200]

// Wall Thickness
Thickness = 1.2; //[0:0.1:2]

// Size of the shape sides
ShapeSize = 15; //[0:0.1:50]

// Distance between shapes
ShapeGap = .5; //[0:0.1:5]

// Different Shape Options
ShapeSides = "Hexagon"; //["Hexagon", "Square", "Triangle"]

CalcInnerWidth = InnerWidth / 10;
CalcInnerLength = InnerLength / 10;
CalcInnerHeight = InnerHeight / 10;
CalcThickness = Thickness / 10;
CalcShapeSize = ShapeSize / 10;
CalcShapeGap = ShapeGap / 10;


CalcOuterWidth = CalcInnerWidth + 2 * CalcThickness;
CalcOuterLength = CalcInnerLength + 2 * CalcThickness;
CalcOuterHeight = CalcInnerHeight + CalcThickness;

union() {
Side(CalcOuterLength, CalcOuterWidth); //Bottom
rotate([90,0,90]) Side(CalcOuterWidth, CalcOuterHeight); //Left
translate([0, CalcThickness, 0]) rotate([90,0,0]) Side(CalcOuterLength, CalcOuterHeight); //Front
translate([CalcOuterLength - CalcThickness, 0, 0]) rotate([90,0,90]) Side(CalcOuterWidth, CalcOuterHeight); //Right
translate([0, CalcOuterWidth, 0]) rotate([90, 0,0]) Side(CalcOuterLength, CalcOuterHeight); //Back
}

module Side(SideLength, SideWidth) {
       union() {
           SideEdges(SideLength, SideWidth);

           difference() {
                cube([SideLength, SideWidth, CalcThickness], false);
                if(ShapeSides == "Triangle"){
                     triangleGrid(SideLength, SideWidth);
                }
                else if(ShapeSides == "Square") {
                    cubeGrid(SideLength, SideWidth);
                }
                else if (ShapeSides == "Hexagon") {
                    hexagonGrid(SideLength, SideWidth);
                }
           }
       }
    }

module SideEdges(SideLength, SideWidth) {
    union(){
        cube([CalcThickness, SideWidth, CalcThickness], false);
        cube([SideLength, CalcThickness, CalcThickness], false);
        translate([SideLength - CalcThickness,0,0]) cube([CalcThickness, SideWidth, CalcThickness], false);
        translate([0,SideWidth - CalcThickness,0])cube([SideLength, CalcThickness, CalcThickness], false);
    }
}

module hexagon(){
    side = CalcShapeSize/sqrt(3);
    for (i = [-60, 0, 60]) translate([0,0,CalcThickness / 2]) rotate([0,0,i]) cube([side, CalcShapeSize, CalcThickness], true);
}

module triangle() {
    intersection() {
        cube([CalcShapeSize,CalcShapeSize,CalcThickness]);
        rotate([0,0,-30]) cube([CalcShapeSize,CalcShapeSize,CalcThickness]);
        translate([CalcShapeSize,0,0]) rotate([0,0,120]) #cube([CalcShapeSize,CalcShapeSize,CalcThickness]);
    }
}

module hexagonGrid(xGrid, yGrid) {
    MinDiameter = (CalcShapeSize + CalcShapeGap) / 2;
    MaxDiameter = (2 * MinDiameter) / sqrt(3);    
    xOffset = (-3 * MaxDiameter) + (xGrid % (3 * MaxDiameter)) / 2;
    yOffset = (-4 * MinDiameter) + (yGrid % (2 * MinDiameter)) / 2;
    for (y = [yOffset:MinDiameter:yGrid - yOffset]) {
        for (x = [xOffset:(3 * MaxDiameter):xGrid - xOffset]) {
            if (abs(round(((y / MinDiameter) % 2))) == 1) {
                x = x + (1.5 * MaxDiameter);
                translate([x, y, 0])
                    hexagon();
            } 
            else {
                translate([x, y, 0])
                    hexagon();
            }
        }
    } 
}


module cubeGrid(xGrid, yGrid) {
    cubeOffset = CalcShapeSize + CalcShapeGap;
    xOffset = (-cubeOffset) + CalcShapeGap / 2 + (xGrid % cubeOffset) / 2;
    yOffset = (-cubeOffset) + CalcShapeGap / 2 + (yGrid % cubeOffset) / 2;
    for (y = [yOffset:cubeOffset:yGrid]) {
        for (x = [xOffset:cubeOffset:xGrid]) {
            if (abs(round(y / cubeOffset)) % 2 == 1) {
                x = x + (cubeOffset / 2);
                translate([x, y, 0]) cube(CalcShapeSize);
            }
            else {
                translate([x, y, 0]) cube(CalcShapeSize);
            }
        }
    }
}

module triangleGrid(xGrid, yGrid) {
    xShift = CalcShapeSize / 2 + CalcShapeGap;
    triangleHeight = sqrt(pow(CalcShapeSize, 2) - pow(CalcShapeSize / 2, 2));
    yShift = triangleHeight + CalcShapeGap;
    xOffset = -(CalcShapeSize + 2 * CalcShapeSize) + (xGrid % (CalcShapeSize + 2 * CalcShapeGap)) / 2;
    yOffset = (-2 * (2 * (triangleHeight + CalcShapeGap))) + (yGrid % (2 * (triangleHeight + CalcShapeGap))) / 2;
    for (y = [yOffset:yShift:yGrid]) {
        for (x = [xOffset:xShift:xGrid]) {
            if ((abs(round(y / yShift)) % 2 + abs(round(x / xShift)) % 2) % 2 == 1) {
                y = y + triangleHeight;
                translate([x+CalcShapeSize, y, 0]) rotate([0,0,180]) triangle();
            }
            else {
                translate([x, y, 0]) triangle();
            }
        }
    }
}

