drawText = true;

ioWidth = 159; // Width of I/O slot
ioHeight = 44.7; // Height of I/O slot
ioBottom = 8.55; // Bottom distance from case to I/O slot (stand-off)
ioMargin = 172.44; // Placement of I/O slot from bottom right

materialThickness = 2; // Thickness of I/O plate
materialOverlap = 5; // Overlap on bottom

screwHeight = 9.5; // Height of the screw stand-offs
screwRadius = 4 / 2; // Radius of the screws
screwOverlapRadius = 9.1 / 2; // Radius of screw base in overlap area (below board)

boardWidth = 170; // Width of the mainboard (Mini-ITX)
boardDepth = boardWidth;

// Holes are measured from the bottom right (where the PCI-e card sits)
topRightHole = [6.35-1, 165.1];
topLeftHole = [163.83, 165.1];

bottomRightHole = [6.35-1, 10.16];
bottomLeftHole = [163.83, 33.02];

pciWidth = 45;
pciDepth = 131;
pciOverlap = 23.45;
pciBottom = 42;
pciPadding = 25;
pciHoleMargin = 45.72;

/*
 * Arduino board
 */
arduinoWidth = 53.3; // Width of Arduino board
arduinoDepth = 68.6; // Depth of Arduino board
arduinoHeight = 4; // Height of Arduino board (+ Ethernet shield)
arduinoPcb = 1.65; // Height of Arduino PCB
arduinoMargin = 15; // Margin from left

/*
 * Arduino mounting holes
 */
bottomHoleGap = 14+1.3; // Distance from front of board to first holes
rightHoleGap = 2.5; // Distance from right side of the board to first hole
holeDistance = 50.9; // Distance between front row of holes and back
backHoleDistance = 27.9; // Distance between 2 back holes
rowGap = 5.1; // Gap between front and back row
frontHoleDistance = 15.2+backHoleDistance+rowGap; // Distance between front holes

/*
 * Board parameters
 */
pinGap = 2.5; // Gap on bottom for pins that are sticking out
screwBaseRadius = 2; // Radius of base below screw holes
arduinoScrewRadius = 1.2; // Radius of screw holes

/*
 * Arduino ports
 */

usbLeft = 9.35;
usbBottom = 0;
usbWidth = 12+1;
usbHeight = 11+1;

powerLeft = 40;
powerBottom = 0;
powerWidth = 10+1;
powerHeight = 11+1;

ethernetLeft = 6.5;
ethernetBottom = 16.75-1;
ethernetWidth = 16.2+1;
ethernetHeight = 14+1;

ethernetLedLeft = 11.6;
ethernetLedBottom = 40;
ethernetLedWidth = 1.5;
ethernetLedHeight = 20.2;

$fn = 50;

difference()
{
    group()
    {
        translate([boardWidth-ioMargin, 0, 0]) cube([ioWidth, materialThickness, ioHeight]); // I/O slot
        translate([boardWidth-ioMargin, 0, -materialOverlap]) cube([ioWidth, materialThickness, materialOverlap]); // I/O slot overlap
        translate([boardWidth-ioMargin, materialThickness, -materialOverlap]) cube([ioMargin-boardWidth, boardDepth+pciPadding/2, materialThickness+materialOverlap]); // I/O slot
        
        // Move behind I/O cover
        translate([0, materialThickness, 0])
        {
            difference()
            {
                group()
                {
                    cube([boardWidth+pciOverlap+pciPadding, boardDepth+pciPadding/2, materialThickness]); // Mainboard
                    translate([0, 0, -materialOverlap]) cube([boardWidth+pciOverlap+pciPadding, boardDepth+pciPadding/2, materialOverlap]); // Overlap under board to hold onto screws
                }
                
                translate([boardWidth - pciOverlap, pciBottom, materialThickness-materialOverlap]) cube([pciWidth, pciDepth, materialOverlap+1]); // Cutout for PCI-e miner card
            
                translate([boardWidth, 0, -1])
                {
                    //translate([-topRightHole[0], topRightHole[1]]) cylinder(r = screwRadius, h = materialThickness+2); // Don't draw top right hole (Mini-ITX), inside of PCI-e cutout
                    translate([-topLeftHole[0], topLeftHole[1]]) cylinder(r = screwRadius, h = materialThickness+2); // Top left hole (Mini-ITX)
                    translate([-bottomRightHole[0], bottomRightHole[1]]) cylinder(r = screwRadius, h = materialThickness+2); // Bottom right hole (Mini-ITX)
                    translate([-bottomLeftHole[0], bottomLeftHole[1]]) cylinder(r = screwRadius, h = materialThickness+2); // Bottom left hole (Mini-ITX)
                    
                    translate([-bottomRightHole[0]+pciHoleMargin, bottomRightHole[1]]) cylinder(r = screwRadius, h = materialThickness+2); // Bottom right hole (ATX)
                    translate([-topRightHole[0]+pciHoleMargin, topRightHole[1]]) cylinder(r = screwRadius, h = materialThickness+2); // Top right hole (ATX)
                    
                    // Draw holes on underside
                    translate([0, 0, -materialOverlap])
                    {
                        translate([-topLeftHole[0], topLeftHole[1]]) cylinder(r = screwOverlapRadius, h = materialOverlap+1); // Top left hole (Mini-ITX)
                        translate([-bottomRightHole[0], bottomRightHole[1]]) cylinder(r = screwOverlapRadius, h = materialOverlap+1); // Bottom right hole (Mini-ITX)
                        translate([-bottomLeftHole[0], bottomLeftHole[1]]) cylinder(r = screwOverlapRadius, h = materialOverlap+1); // Bottom left hole (Mini-ITX)
                        
                        translate([-bottomRightHole[0]+pciHoleMargin, bottomRightHole[1]]) cylinder(r = screwOverlapRadius, h = materialOverlap+1); // Bottom right hole (ATX)
                        translate([-topRightHole[0]+pciHoleMargin, topRightHole[1]]) cylinder(r = screwOverlapRadius, h = materialOverlap+1); // Top right hole (ATX)
                    }
                }
            }
        }
    }
    
    // Text
    if(drawText)
    {
        translate([ioWidth - 5, 0.2, 8]) rotate([90, 0, 0]) linear_extrude(0.2 + 1) text("DAS01", size=6, halign="right"); // Front text
        translate([ioWidth - 5, 0.2, 0]) rotate([90, 0, 0]) linear_extrude(0.2 + 1) text("00/00/0000", size=6, halign="right"); // Front text
    }
    
    // Arduino cutouts
    translate([arduinoMargin, 0, materialThickness])
    {
        // Move above pin gap and in front (to prevent clipping)
        translate([0, -1, pinGap])
        {
            // Move to Arduino PCB
            translate([materialThickness, 0, arduinoPcb])
            {
                // Cut USB port
                translate([usbLeft, 0, usbBottom]) cube([usbWidth,materialThickness+2,usbHeight]);
                
                // Cut power port
                translate([powerLeft, 0, powerBottom]) cube([powerWidth,materialThickness+2,powerHeight]);
                
                // Cut Ethernet port
                translate([ethernetLeft, 0, ethernetBottom]) cube([ethernetWidth,materialThickness+2,ethernetHeight]);
            }
        }
    }
}

// Arduino holders
translate([arduinoMargin+2, materialThickness, materialThickness])
{
    // Move to front row of holes
    translate([arduinoWidth-rightHoleGap, bottomHoleGap, 0])
    {
        translate([0, -1.3, 0])
        {
            // Create bottom right hole
            cylinder(h = pinGap, r = screwBaseRadius);
            
            cylinder(h = arduinoHeight, r = arduinoScrewRadius);
        }
        
        // Create bottom left hole
        translate([-frontHoleDistance, 0, 0])
        {
            cylinder(h = pinGap, r = screwBaseRadius);
            
            cylinder(h = arduinoHeight, r = arduinoScrewRadius);
        }
        
        // Move to back row of holes
        translate([-rowGap, holeDistance, 0])
        {
            // Create top right hole
            cylinder(h = pinGap, r = screwBaseRadius);
            
            cylinder(h = arduinoHeight, r = arduinoScrewRadius);
            
            // Create top left hole
            translate([-backHoleDistance, 0, 0])
            {
                cylinder(h = pinGap, r = screwBaseRadius);
                
                cylinder(h = arduinoHeight, r = arduinoScrewRadius);
            }
        }
    }
}