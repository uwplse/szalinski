/* [Model Generation Selection] */

// Generate sliders for Ultimaker2 Extended or the regular Ultimaker2
extended = true;

// Include the lower runner halves
includeLowerSections = true;

// Include the upper runner halves
includeUpperSections = true; 

// Incldue runners for the left side of the printer
includeLeftSections = true;

// Inlude runners for the right side of the printer
includeRightSections = true;

/* [Knotches] */

// Include knotches on the inside surface to help latch the sliding door.
knotches = true;

// Spacing between knotches
knotchSpacing = 30;

/* [Model Customisation] */

// How high up the base part is filled to stop the door going all the way down. 
filledHeight = 60;
// 60mm gives just above display Actual fill is this - the floor offset

// How much speace to leave between the bottom of the runners and the floor (bottom of the UM)
//floorOffset = 15; //- if you have feet around the corners of the printer.
floorOffset = 2;

// Width of acrylic door. allow a tollerance, e.g. 3mm cast acrylic can be 3.5mm or even 4mm in places.
acrylicWidth = 4;

/* [Testing] */

// Create the test piece only. Useful for checking fit to the UM.
testPiece = false;

/* [Hidden] */

// Visualisation for UM.
ultimakerWidth = 339; 

// UM2 Extended only. 
distanceBetweenHoles = 122;

// Show the Ultimaker, door etc for model checking
includeVisualisation = false;

// Gap between models.
seperationBetweenSides = 0;
// -32 for offset in right bracked.
//seperationBetweenSides = ultimakerWidth - (38*2);
// gives 0 width for ultimaker inbeterrn
 //seperationBetweenSides = -(38*2);

module showUltimakerExtended() {
    // down 2mm as the runners are raised up by 2mm.
    translate([-(ultimakerWidth-38 +2) ,11,-2]) {
        cube([ultimakerWidth,200,490]);
        
        // Show Screws.
        translate([0,5-1,0]) {
            for (zOfffset = [69-1 : distanceBetweenHoles : 480]) {           
                translate([0,0,zOfffset]) {
                    cube([400,2,2]);
                }
            }
        }
    }
}

module showUltimakerRegular() {
    // down 2mm as the runners are raised up by 2mm.
    translate([-(ultimakerWidth-38 +2) ,11,-2]) {
        cube([ultimakerWidth,200,388]);
        
        // Show Screws.
        translate([0,5-1,0]) {
            translate([0,0,69.7]) {
                cube([400,2,2]);
            }
            translate([0,0,69.7 + 131.9]) {
                cube([400,2,2]);
            }
            translate([0,0,69.7 + 131.9 + 134.1]) {
                cube([400,2,2]);
            }    
        }
    }
}

module showDoor() {
xOffset = -(ultimakerWidth-38 +2) + 19;

    translate([xOffset ,2,15 + filledHeight-floorOffset]) {
        % cube([300,acrylicWidth,500]);
    }
}

module bracket(h) {
    linear_extrude(height = h) { 
        //+4 on the x.
        //polygon(points=[[0,0],[34,0],[34,25],[32,25],[32,7],[25.5,7],[25.5,11],[4,11],[4,8],[19,8],[19,2],[0,2], [0,0]]);
        
        difference() {
            union() {
                polygon(points=[[0,0],[36,0],[38,2],[38,20+acrylicWidth],[36,20+acrylicWidth],[36,2+acrylicWidth],[29.5,2+acrylicWidth],[29.5,6+acrylicWidth],[8,6+acrylicWidth],[8,2+acrylicWidth],[17.5,2+acrylicWidth],[17.5,2],[0,2], [0,0]]);
                
                translate([36,2,0]) {
                    // 4.2mm hole allows for a M3 pushfit nut
                    // or small cable/string run inside
                    circle(d=4, $fn=60);
                }
            }
            union() {
                translate([23,4,0]) {
                    // 4.2mm hole allows for a M3 pushfit nut
                    // or small cable/string run inside
                   // circle(d=4.2, $fn=60);
                }
            }
        }
    }
}



// Well, more take them away
module addRightKnotches(h) {
    // start at 15mm as this keeps the underside
    // vent gap in the Ultimaker open
    for (zOffset = [15: knotchSpacing: h]) {
        translate([0,6+acrylicWidth, zOffset]) {
            rotate([0,90,-90]) {
                linear_extrude(height = 4) { 
                    polygon(points=[[0,0],[10,4],[0,4],[0,0]]);
                }
            }
        }
    }
}

module addLeftKnotches(h) {
    // start at 15mm as this keeps the underside
    // vent gap in the Ultimaker open
    for (zOffset = [15: knotchSpacing: h]) {
        translate([-3,6+acrylicWidth, zOffset]) {
            rotate([0,90,-90]) {
                linear_extrude(height = 4) { 
                    polygon(points=[[10,0],[10,0],[0,4],[00,0]]);
                }
            }
        }
    }
}

module rightBracket (h)  {
    bracket(h);
    if (knotches) {
        translate([4,0,0]) {
            addRightKnotches(h);
        }
    }
}

module leftBracket (h)  {
    translate([-4,0,h]) {
        rotate([0,180,0]) {
            bracket(h);
        }
    }
    if (knotches) {
        translate([-9,0,0]) {
            addLeftKnotches(h);
        }
    }
}    

// Used by the lower section as that wants to be in a set place
module screwHole(zPosition, isBase) {
    if (isBase) {
        // Single fixed place hole
        translate([-395,0,zPosition]) {
            rotate([0,90,0]) {
                cylinder(d=3.5, h=600, $fn=20);
            }
        }
    } else {
        longScrewHole(zPosition);
    }
}

// User by the upper position to allow for a little fitting tollerance.
module longScrewHole(zPosition) {   
    // Larger hole for adjustment.
    translate([-395,0,zPosition-1]) {
        rotate([0,90,0]) {
            cylinder(d=3.5, h=600, $fn=20);
        }
    }
    
    // Join the holes.
    translate([-395,-3.6/2,zPosition-(2/2)]) {
        cube([600,3.6,2]);
    }
    
    translate([-395,0,zPosition+1]) {
        rotate([0,90,0]) {
            cylinder(d=3.5, h=600, $fn=20);
        }
    }
}

module main(h, fillBase, holes) {
    // for 2 sections to make a door on extended
    
    echo ("Height = ", h);
    echo ("First Hole At = ", holes[0]);
    
    difference() {
        union() {
            if (includeRightSections) {
                rightBracket(h);            
            }
            
            if (includeLeftSections) {
                translate([-seperationBetweenSides,0,0]) {
                   leftBracket(h);    
                }
            }
        }
        union() {
            
            translate([34-3,11+acrylicWidth,0]) {                
                // holes.
                for (holeZPosition = holes) {
                    screwHole(holeZPosition, fillBase);
                }                
            }
        }
    }   
    
    // fill the bottom(/top) to stop acrylic calling out.
    if (fillBase) {
        if (includeRightSections) {
            cube([20, 6 + acrylicWidth, filledHeight - floorOffset]);
        }
        
        if (includeLeftSections) {
            translate([-seperationBetweenSides-24,0,0]) {
                cube([20, 6 + acrylicWidth, filledHeight - floorOffset]);
            }
        }
    }
}



// Help visualise if we have the screwholes in the correct place.
module lowerSectionMarker() {
    translate([30,10,0]) {
        // first hole
        cube([10,10,70]);
        // second hole
        translate([0,10,0]) cube([10,10,70+122]);
        // top
        translate([0,20,0]) cube([10,10,70+122+61]);
    }
}

module upperSectionMarker() {
    translate([30,10,0]) {
        // first hole
        cube([10,10,61]);
        // second hole
        translate([0,10,0]) cube([10,10,61+122]);
        // top
        translate([0,20,0]) cube([10,10,61+122+61]);
    }
}

// ==============================================
// UM2 Extended runners.
// ==============================================
module extendedUpperDoorRunners() {
    // Set-up so that 2 pieced
    // can be stacked on top of each other
    
    // For upper parts.
    lowerPartHeight = (distanceBetweenHoles/2); // 122/2 == 61mm.
    
    // 28mm lower in height to so they don't jut over the top.
    // + 7.8mm takes the part to the top of the UME
    height = lowerPartHeight + (distanceBetweenHoles) + (distanceBetweenHoles/2) - 27 + 7.8; 
    
    holes = [lowerPartHeight, lowerPartHeight + distanceBetweenHoles];
    
    main(height, false, holes);
}

module extendedLowerDoorRunners() {
    // For base parts
    // actual first hole at 70mm
    // leaves 2mm gap on floor
    lowerPartHeight = 68; 
    
    height = lowerPartHeight + (distanceBetweenHoles) + (distanceBetweenHoles/2)-  floorOffset; 
    
    holes = [lowerPartHeight -  floorOffset, lowerPartHeight + distanceBetweenHoles-  floorOffset];
    
    main(height, true, holes);
}

module extendedDoorRunners() {
    // Set-up so that 2 pieced
    // can be stacked on top of each other
    if (includeUpperSections) {
        // For Printing
        translate([0,30,0]) {
        // For Visualisation
        //translate([0,0,68 + 122 + 61 + 0.5-floorOffset]) {
            extendedUpperDoorRunners();
        }
    }
        
    if (includeLowerSections) {
        extendedLowerDoorRunners();
    }
}

// ==============================================
// Regular UM2 runners.
// ==============================================
module regularDoorRunners() {
    
// Overall height 388mm
// Holes:
// 69.7 + 131.9 + 134.1 = 335.7
// 69.7 + 131.9 = 201.6
// 69.7
    
// Need to take off any offset
splitPoint = 69.7 + 131.9;       
   
    // Upper section
    if (includeUpperSections) {
        // For Printing
        translate([0,30,0]) {
        // For Visualisation
        //translate([0,0,splitPoint-floorOffset]) {
            // UM full height - 20mm offset at top
            height = 388 - 20 - splitPoint;
            holes = [0, 134.1];
            main(height, false, holes);
        }
    }
  
    // Lower section
    if (includeLowerSections) {
        // Joint is in the middle of the second screw.
        height = splitPoint - floorOffset; 
        
        // z positions for holes.
        holes = [69.7 - floorOffset, 201.6 - floorOffset];
        main(height, true, holes);
    }
}


// Application flow...

if (testPiece) {
    // Print test pieces for fit.
    main(10, 5, false);
} else {

    if (extended) {
        extendedDoorRunners();
    } else {
        regularDoorRunners();
    }

    if (includeVisualisation) {

        // Visualisation
        translate([0,0,-floorOffset]) {
            if (extended) {
                %showUltimakerExtended();
            } else {
                %showUltimakerRegular();
            }
            %showDoor();

            translate([0,0,251.5]) {
                %upperSectionMarker();
            }

            translate([0,0,-2]) {
                %lowerSectionMarker();
            }
        }
    }
}



