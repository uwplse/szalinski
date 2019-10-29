$fn = 50;

// 0 for chessbox, 1 for 2nd color chessboard squares
onlyChessboardColor2 = 0;

// (mm) How big the box will be square (< build area)
boxLength = 224.0;

// (mm) How tall the box will be
boxHeight = 22.0;

// (mm) Thickness of box walls
wallThickness = 3.0;

// How pieces for hinge (even number required)
hingeDivNum = 8.0;

// (mm) How tall the chessboard squares should be
chessboardHeight = 1.5;

// (mm) Diameter of the hinge hole (works for piece of filament)
hingeHoleDiameter=2.6;

// (mm) Diameter of the hinge
hingeDiameter=wallThickness*2;

// (mm) Tolerance - leave it alone or may not all fit together
tol = 0.5;

if ( onlyChessboardColor2 == 0 ) box();
else chessboard(1);

module box() {
    width = boxLength/2.0;
    hingeDivLength = (boxLength/hingeDivNum);   
    hingeRadius = hingeDiameter/2.0;
                          
    difference () {
        union() {
            difference() {
                //  Box
                translate([0, 0, 0])
                    cube([width,boxLength,boxHeight]);
            
                // cutout inside of box
                translate([wallThickness, wallThickness, wallThickness])
                    cube([width-wallThickness*2, boxLength-wallThickness*2, boxHeight]);
        
                // cutout chessboard area of box
                translate([0, 0, 0])
                    cube([width, boxLength, chessboardHeight]);
            }
            
            // Add Chessboard color 1 squares (same as box)
            chessboard(0);
            
            // Add hinge cylinder
            translate([-tol, 0, boxHeight+tol]) rotate([-90,0,0])
                 cylinder(d=hingeDiameter, h=boxLength);
            
            addLatches();
        }
        
        // Cutout hinge center hole and fingers in hinge
        translate([-tol, 0, boxHeight+tol]) rotate([-90,0,0]) {

            // cutout hinge center hole
            cylinder(d=hingeHoleDiameter, h=boxLength+tol);
                        
            // Cutout fingers in hinge
            for ( i = [0:2:hingeDivNum-1] ) {
                y = hingeDivLength*i - tol/2.0;
                translate([0, 0, y])
                    cylinder(d=hingeDiameter+tol*3, h=hingeDivLength+tol);
            }    
        }   
    }
}

module addLatches()
{
    latchHeight = hingeDiameter/2.0+boxHeight+tol;
    latchLength = (boxLength-(wallThickness*2.0))/10.0;
    
    latchYPos1 = wallThickness+latchLength*1.5+tol;
    latchYPos2 = wallThickness+latchLength*8.7+tol;

    latchXPos1 = boxLength/2.0-wallThickness*2;
    latchXPos2 = boxLength/2.0-wallThickness-tol*0.5;
    latchXPos3 = boxLength/2.0-wallThickness-tol*1.5;

    latchZPos1 = chessboardHeight;
    latchZPos2 = boxHeight;
    
    latchHeight2 = latchHeight;
    latchHeight3 = latchHeight-boxHeight;

    // 1st latch
    difference () {
        translate([latchXPos1, latchYPos1, latchZPos1])
            cube([wallThickness, latchLength-tol*2, latchHeight]);
        translate([latchXPos2, latchYPos1, latchZPos2])
            cube([tol, latchLength-tol, latchHeight2]);
        translate([latchXPos3, latchYPos1, latchZPos2])
            cube([tol, latchLength-tol, latchHeight3]);
    }
    
    // 2nd latch
    difference () {
        translate([latchXPos1, latchYPos2, latchZPos1])
            cube([wallThickness, latchLength-tol*2, latchHeight]);
        translate([latchXPos2, latchYPos2, latchZPos2])
            cube([tol, latchLength-tol, latchHeight2]);
        translate([latchXPos3, latchYPos2, latchZPos2])
            cube([tol, latchLength-tol, latchHeight3]);
    }
}

module chessboard( color2 )
{
    height = chessboardHeight;
    squareSize = boxLength/8.0;

    for (ypos = [0,2,4,6]) {
        y = ypos*squareSize;
         for ( xpos = (color2 == 0) ? [0,2] : [1,3] ) {
            x = squareSize*xpos;
            translate([x,y,0])
                cube([squareSize,squareSize,height]);
        }
    }
    for (ypos = [1,3,5,7]) {
        y = ypos*squareSize;
        for ( xpos = (color2 == 0) ? [1,3] : [0,2] ) {
            x = squareSize*xpos;
            translate([x,y,0])
                cube([squareSize,squareSize,height]);
        }
    }
}