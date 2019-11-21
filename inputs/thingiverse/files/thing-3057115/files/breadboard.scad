
// preview[view:south west, tilt:top diagonal]

/*[Pin Configuration]*/

// Number of pin rows
rows = 63;  // [1:1:100]

// Number of pin columns
columns = 10;   // [1:1:40]

// Side length of one pin section [in mm]
pinDiameter = 1.0;  // [0.4:0.1:4.0]

// Distance from pin-center to pin-center [in mm] (default: 0.l inch = 2.54 mm)
pinSpacing = 2.54;  // [2.54:0.1 Inch, 2.0:2.0 mm]

// Pins per horizontal pin-group
pinsPerGroup = 5;   // [1:1:40]

// Space between horizontal pin groups [in pins]
pinGroupSpacing = 3;    // [1:0.5:5]

// Add or remove bevel on upper side of the breadboard
pinBevelEnabled = true; // [true:Enabled, false:Disabled]

// Amount of Pin-bevel on upper side of the breadboard [in mm]
pinBevelAmount = 0.3;   // [0.0:0.1:1.0]

// Steepness of Pin-bevel on upper side of the breadboard
pinBevelSteepness = 1;  // [0.0:0.1:3.0]


/*[Power-Terminal Configuration]*/

// Add left power-terminal
powerLeftEnabled = true;    // [true:Enabled, false:Disabled]

// Add right power-terminal
powerRightEnabled = true;   // [true:Enabled, false:Disabled]

// Pins per vertical power-terminal pin group
pinsPerPowerGroup = 5;  // [1:1:40]

// Space between vertical power-terminal pin groups [in pins]
pinPowerGroupSpacing = 2;   // [1:0.5:5]

// Offset of the first power-terminal pin group [in pins]
powerGroupPinOffsetTop = 2; // [0.0:0.5:5.0]

// Offset of the last power-terminal pin group [in pins]
powerGroupPinOffsetBottom = 2;  // [0.0:0.5:5.0]


/*[Board Configuration]*/

// Horizontal border-width [in pins]
horizontalBorderWidth = 1.5;    // [0.5:0.5:5.0]

// Vertical border-width [in pins]
verticalBorderWidth = 1.5;  // [0.5:0.5:5.0]

// Height of the breadboard [in mm]
boardHeight = 9.5;  // [5.0:0.5:15.0]


/*[Wiring-Section Configuration]*/

// Enable or disable wiring sections on the bottom of the breadboard
wiringSectionEnabled = true;    // [true:Enabled, false:Disabled]

// Additional cutted out space for the first and last pin of each wiring section, to make wiring easier and fit different types of wirings [in mm]
wiringSectionTollerance = 0;    // [0:0.1:10.0]

// Width of the walls separating the wiring sections, seen from below [in mm]
wallThickness = 1.2;    // [0.1:0.1:3.0]

// Thickness of the face of the board where the building-parts are placed [in mm]
faceThickness = 1;  // [0.4:0.1:2.0]






breadboard(
    rows = rows,
    columns = columns,
    pinSpacing = pinSpacing,
    pinDiameter = pinDiameter,
    pinsPerGroup = pinsPerGroup,
    pinGroupSpacing = pinGroupSpacing,
    pinBevelEnabled = pinBevelEnabled,
    pinBevelAmount = pinBevelAmount,
    pinBevelSteepness = pinBevelSteepness,
    powerLeftEnabled = powerLeftEnabled,
    powerRightEnabled = powerRightEnabled,
    pinsPerPowerGroup = pinsPerPowerGroup,
    pinPowerGroupSpacing = pinPowerGroupSpacing,
    powerGroupPinOffsetTop = powerGroupPinOffsetTop,
    powerGroupPinOffsetBottom = powerGroupPinOffsetBottom,
    horizontalBorderWidth = horizontalBorderWidth,
    verticalBorderWidth = verticalBorderWidth,
    boardHeight = boardHeight,
    wiringSectionEnabled = wiringSectionEnabled,
    wiringSectionTollerance = wiringSectionTollerance,
    wallThickness = wallThickness,
    faceThickness = faceThickness
);


// Examples:

// standard 830 pin breadboard
//breadboard();

// standard 400 pin breadboard
/*
breadboard(
    rows=30,
    powerGroupPinOffsetTop=0.5,
    powerGroupPinOffsetBottom=0.5
);
*/

// small custom breadboard
/*
breadboard(
    rows=17,
    powerLeftEnabled=false,
    powerRightEnabled=false
);
*/

// highly customized breadboard
/*
breadboard(
    rows=10,
    columns=20,
    powerLeftEnabled=true,
    powerRightEnabled=false,
    pinSpacing=2.54,
    pinsPerGroup=10,
    pinGroupSpacing=2,
    pinsPerPowerGroup=1,
    pinPowerGroupSpacing=1,
    powerGroupPinOffsetTop=0,
    powerGroupPinOffsetBottom=0,
    horizontalBorderWidth=1,
    verticalBorderWidth=1,
    boardHeight=5,
    pinDiameter=1.6,
    wallThickness=1.6,
    faceThickness=2
);
*/



/*
rows: Number of pin rows
columns: Number of pin columns
pinSpacing: Distance from pin-center to pin-center [in mm] (default: 0.l inch = 2.54 mm)
pinDiameter: Side length of one pin section [in mm]
pinsPerGroup: Pins per horizontal pin-group
pinGroupSpacing: Space between horizontal pin groups [in pins]
pinBevelEnabled: Add or remove bevel on upper side of the breadboard
pinBevelAmount: Amount of Pin-bevel on upper side of the breadboard [in mm]
pinBevelSteepness: Steepness of Pin-bevel on upper side of the breadboard
powerLeftEnabled: Add left power-terminal
powerRightEnabled: Add right power-terminal
pinsPerPowerGroup: Pins per vertical power-terminal pin group
pinPowerGroupSpacing: Space between vertical power-terminal pin groups [in pins]
powerGroupPinOffsetTop: Offset of the first power-terminal pin group [in pins]
powerGroupPinOffsetBottom: Offset of the last power-terminal pin group [in pins]
horizontalBorderWidth: Horizontal border-width [in pins]
verticalBorderWidth: Vertical border-width [in pins]
boardHeight: Height of the breadboard [in mm]
wiringSectionEnabled: Enable or disable wiring sections on the bottom of the breadboard
wiringSectionTollerance: Additional cutted out space for the first and last pin of each wiring section, to make wiring easier and fit different types of wirings [in mm]
wallThickness: Width of the walls separating the wiring sections, seen from below [in mm]
faceThickness: Thickness of the face of the board where the building-parts are placed [in mm]
*/
module breadboard(
    rows = 63,
    columns = 10,
    pinSpacing = 2.54,
    pinDiameter = 1.0,
    pinsPerGroup = 5,
    pinGroupSpacing = 3,
    pinBevelEnabled = true,
    pinBevelAmount = 0.3,
    pinBevelSteepness = 1,
    powerLeftEnabled = true,
    powerRightEnabled = true,
    pinsPerPowerGroup = 5,
    pinPowerGroupSpacing = 2,
    powerGroupPinOffsetTop = 2,
    powerGroupPinOffsetBottom = 2,
    horizontalBorderWidth = 1.5,
    verticalBorderWidth = 1.5,
    boardHeight = 9.5,
    wiringSectionEnabled = true,
    wiringSectionTollerance = 0,
    wallThickness = 1.2,
    faceThickness = 1
) {

    // Calc board-size
    // width:
    boardWidth = ((columns - 1) * pinSpacing)           // space for pins
        + ((horizontalBorderWidth * 2) * pinSpacing)    // space for border
        + (floor((columns - 1) / pinsPerGroup) * (pinGroupSpacing-1) * pinSpacing);// space for pin-group-spacing
    
    // length:
    boardLength = ((rows - 1) * pinSpacing)         // space for pins
        + ((verticalBorderWidth * 2) * pinSpacing); // space for border



    union() {


        // Main breadboard
        difference() {
        
            // breadboard base body
            cube([boardWidth, boardLength, boardHeight]);

            // insert pins
            for(pinRow = [0:rows-1]) {
                
                for(pinColumn = [0:columns-1]) {
                
                    // Calc pins x-position
                    posX = (horizontalBorderWidth * pinSpacing) // space for border
                        + (pinColumn * pinSpacing)              // space for pins
                        + (floor(pinColumn / pinsPerGroup) * (pinGroupSpacing-1) * pinSpacing);// space for pin groups
                    
                    // Calc pins y-position
                    posY = (verticalBorderWidth * pinSpacing) // space for border
                        + (pinRow * pinSpacing);                // space for pins
                    
                    posZ = -0.05 - (0.05*(pinBevelEnabled == true ? 1 : 0));

                    translate([posX, posY, posZ]) {
                        pinSection(pinDiameter=pinDiameter, height=boardHeight+0.1, bevelEnabled=pinBevelEnabled, bevelAmount=pinBevelAmount, bevelSteepness=pinBevelSteepness);
                    }
                    
                }
                
            }


            if(wiringSectionEnabled == true) {
            
                // cut out space for "wiring"
                for(wiringRow = [0:rows-1]) {
                    
                    for(wiringColumn = [0:floor((columns-1) / pinsPerGroup)]) {
                
                        // Calc wiringSection x-position
                        posX = (horizontalBorderWidth * pinSpacing) // space for border
                            + (((pinsPerGroup-1) / 2) * pinSpacing) // center on first pin group
                            + (wiringColumn * (pinGroupSpacing-1) * pinSpacing)  // space for pin groups                
                            + (wiringColumn * pinsPerGroup * pinSpacing);   // adapt to current column
                        
                        
                        // Calc wiringSection y-position
                        posY = (verticalBorderWidth * pinSpacing)   // space for border
                            + (wiringRow * pinSpacing);             // adapt to current row
                        
                        translate([posX, posY, -1])
                            wiringSection(
                                width = (pinSpacing * pinsPerGroup) - wallThickness + (wiringSectionTollerance * 2),
                                length = pinSpacing - wallThickness,
                                height = boardHeight - faceThickness + 1
                            );
                    }
                    
                }
                
            }
        
        }


        // left power-terminal
        if(powerLeftEnabled == true) {

            // Calc sizes, etc.
            powerLeftBoardWidth = pinSpacing    // space for pins
                + ((horizontalBorderWidth * 2) * pinSpacing); // space for border
            
            powerLeftBoardLength = boardLength;

            // move to the left of the breadboard
            translate([-powerLeftBoardWidth, 0, 0]) {

                difference() {
            
                    // left power-terminal base body
                    cube([powerLeftBoardWidth, powerLeftBoardLength, boardHeight]);


                    numPinSpacings = ceil(
                        (
                            (rows - powerGroupPinOffsetTop - powerGroupPinOffsetBottom) // num relevant pins
                            + (pinPowerGroupSpacing-1)  // add power group pin spacing
                        ) / (
                            pinsPerPowerGroup + (pinPowerGroupSpacing - 1)  // divide by size of powerGroup + powerGroupSpacing
                        )
                    ) - 1;

                    // Calculate number of power-pin-rows
                    powerPinRows = rows // start with number of rows
                        - powerGroupPinOffsetTop    // remove top offset
                        - powerGroupPinOffsetBottom // remove bottom offset
                        - (numPinSpacings * (pinPowerGroupSpacing-1));   // remove group-spacings

                    if(powerPinRows >= 1) {

                        // insert pins
                        for(pinRow = [0:powerPinRows-1]) {
                            
                            for(pinColumn = [0:1]) {
                            
                                // Calc pins x-position
                                posX = (horizontalBorderWidth * pinSpacing) // space for border
                                    + (pinColumn * pinSpacing);             // space for pins
                                
                                // Calc pins y-position
                                posY = (verticalBorderWidth * pinSpacing) // space for border
                                    + (pinRow * pinSpacing)                 // space for pins
                                    + (powerGroupPinOffsetTop * pinSpacing) // top offset
                                    + (floor(pinRow / pinsPerPowerGroup) * (pinPowerGroupSpacing-1) * pinSpacing);// space for pin groups
                                
                                posZ = -0.05 - (0.05*(pinBevelEnabled == true ? 1 : 0));
                                
                                translate([posX, posY, posZ]) {
                                    pinSection(pinDiameter=pinDiameter, height=boardHeight+0.1, bevelEnabled=pinBevelEnabled, , bevelAmount=pinBevelAmount, bevelSteepness=pinBevelSteepness);
                                }
                                
                            }
                            
                        }
                        
                    }


                    if(wiringSectionEnabled == true) {
                        
                        // cut out space for "wiring"
                        posX = horizontalBorderWidth * pinSpacing;
                        posY = (rows - 1 - powerGroupPinOffsetTop - powerGroupPinOffsetBottom) / 2 * pinSpacing + ((verticalBorderWidth + powerGroupPinOffsetTop) * pinSpacing);
                        
                        translate([posX, posY, -1])
                            wiringSection(
                                width = pinSpacing - wallThickness,
                                length = ((rows - powerGroupPinOffsetTop - powerGroupPinOffsetBottom) * pinSpacing) - wallThickness + (wiringSectionTollerance * 2),
                                height = boardHeight - faceThickness + 1
                            );
                        
                        translate([posX + pinSpacing, posY, -1])
                            wiringSection(
                                width = pinSpacing - wallThickness,
                                length = ((rows - powerGroupPinOffsetTop - powerGroupPinOffsetBottom) * pinSpacing) - wallThickness + (wiringSectionTollerance * 2),
                                height = boardHeight - faceThickness + 1
                            );
                        
                    }
                    
                }

            }
            
        }
        



        // right power-terminal
        if(powerRightEnabled == true) {

            // Calc sizes, etc.
            powerRightBoardWidth = pinSpacing    // space for pins
                + ((horizontalBorderWidth * 2) * pinSpacing); // space for border
            
            powerRightBoardLength = boardLength;

            // move to the right of the breadboard
            translate([boardWidth, 0, 0]) {

                difference() {
            
                    // right power-terminal base body
                    cube([powerRightBoardWidth, powerRightBoardLength, boardHeight]);


                    numPinSpacings = ceil(
                        (
                            (rows - powerGroupPinOffsetTop - powerGroupPinOffsetBottom) // num relevant pins
                            + (pinPowerGroupSpacing-1)  // add power group pin spacing
                        ) / (
                            pinsPerPowerGroup + (pinPowerGroupSpacing - 1)  // divide by size of powerGroup + powerGroupSpacing
                        )
                    ) - 1;

                    // Calculate number of power-pin-rows
                    powerPinRows = rows // start with number of rows
                        - powerGroupPinOffsetTop    // remove top offset
                        - powerGroupPinOffsetBottom // remove bottom offset
                        - (numPinSpacings * (pinPowerGroupSpacing-1));   // remove group-spacings

                    if(powerPinRows >= 1) {

                        // insert pins
                        for(pinRow = [0:powerPinRows-1]) {
                            
                            for(pinColumn = [0:1]) {
                            
                                // Calc pins x-position
                                posX = (horizontalBorderWidth * pinSpacing) // space for border
                                    + (pinColumn * pinSpacing);             // space for pins
                                
                                // Calc pins y-position
                                posY = (verticalBorderWidth * pinSpacing) // space for border
                                    + (pinRow * pinSpacing)                 // space for pins
                                    + (powerGroupPinOffsetTop * pinSpacing) // top offset
                                    + (floor(pinRow / pinsPerPowerGroup) * (pinPowerGroupSpacing-1) * pinSpacing);// space for pin groups
                                
                                posZ = -0.05 - (0.05*(pinBevelEnabled == true ? 1 : 0));
                                
                                translate([posX, posY, posZ]) {
                                    pinSection(pinDiameter=pinDiameter, height=boardHeight+0.1, bevelEnabled=pinBevelEnabled, , bevelAmount=pinBevelAmount, bevelSteepness=pinBevelSteepness);
                                }
                                
                            }
                            
                        }
                        
                    }
                    

                    if(wiringSectionEnabled == true) {

                        // cut out space for "wiring"
                        posX = horizontalBorderWidth * pinSpacing;
                        posY = (rows - 1 - powerGroupPinOffsetTop - powerGroupPinOffsetBottom) / 2 * pinSpacing + ((verticalBorderWidth + powerGroupPinOffsetTop) * pinSpacing);
                        
                        translate([posX, posY, -1])
                            wiringSection(
                                width = pinSpacing - wallThickness,
                                length = ((rows - powerGroupPinOffsetTop - powerGroupPinOffsetBottom) * pinSpacing) - wallThickness + (wiringSectionTollerance * 2),
                                height = boardHeight - faceThickness + 1
                            );
                        
                        translate([posX + pinSpacing, posY, -1])
                            wiringSection(
                                width = pinSpacing - wallThickness,
                                length = ((rows - powerGroupPinOffsetTop - powerGroupPinOffsetBottom) * pinSpacing) - wallThickness + (wiringSectionTollerance * 2),
                                height = boardHeight - faceThickness + 1
                            );
                    
                    }
                    
                }

            }
            
        }

    }

}



module pinSection(pinDiameter=0.8, height=10, bevelEnabled = true, bevelAmount=0.3, bevelSteepness=1) {
    
    translate([-pinDiameter / 2, -pinDiameter / 2, 0])
        cube([pinDiameter, pinDiameter, height]);
    
    if(bevelEnabled == true) {
        translate([0, 0, height+0.001])
            rotate([180, 0, 0])
                polyhedron(
                  points=[
                    // the four points at base
                    [(-(pinDiameter+bevelAmount) / 2),(-(pinDiameter+bevelAmount) / 2),0],
                    [(-(pinDiameter+bevelAmount) / 2),((pinDiameter+bevelAmount) / 2),0],
                    [((pinDiameter+bevelAmount) / 2),((pinDiameter+bevelAmount) / 2),0],
                    [((pinDiameter+bevelAmount) / 2),(-(pinDiameter+bevelAmount) / 2),0],
                    // the apex point 
                    [0,0,((pinDiameter+bevelAmount) / 2)*bevelSteepness]
                  ],
                  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
                              [1,0,3],[2,1,3] ]                         // two triangles for square base
                 );
    }
     
}

module wiringSection(width=6.7, length=1.34, height=8) {
    
    translate([-width / 2, -length / 2, 0]) 
        cube([width, length, height]);
    
}
















