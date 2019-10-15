//	Customizable Bobbin Thread Spool Holder
//	Copyright by Drato Lesandar - Anika Uhlemann - RobotMama

/* [Guide] */
// Height of the whole guide in mm
guideHeight = 6;
// Thickness of the whole guide in mm
guideT = 10;
// Length of the angled sides in mm
sideLength = 15;
// Length of the actual guiding part in mm
barLength = 60;
// Magnet Type (Testpieces are for fast prints, to test magnet fitting)
magType = 0; //[0:Rectangle, 1:Cylinder, 2:TestPieceCylinder, 3:TestPieceRectangle]
// Distance between the two magnets in mm
distMag = 25;

/* [Cylinder Magnets] */
// Radius of cylinder magnet in mm
cylMagRad = 5.1;
// Height of cylinder magnet in mm
cylMagHeight = 5.2;

/* [Rectangle Magnets] */
// Length of rectangle magnet in mm (part that goes along bar)
rectMagLength = 5.1;
// Width of rectangle magnet in mm (part that goes along width of bar)
rectMagWidth = 5.1;
// Height of rectangle magnet in mm
rectMagHeight = 5.4;

/* [Other] */
// How smooth the roundings are (the bigger the value the smoother)
$fn = 40;
rotate ([0,180,0])
if(magType==0 || magType==1) { // Print ready guide
    difference() {
        union() {
            sideCoords = (sideLength)/sqrt(2);
            hull() {
                cylinder(guideHeight, r = guideT/2, center = false);
                translate ([0,barLength,0])
                cylinder(guideHeight, r = guideT/2, center = false);
            }
            hull() {
                cylinder(guideHeight, r = guideT/2, center = false);
                translate ([sideCoords,-sideCoords,0])
                cylinder(guideHeight, r = guideT/2, center = false);
            }
            hull() {
                translate ([0,barLength,0])
                cylinder(guideHeight, r = guideT/2, center = false);
                translate ([sideCoords,sideCoords+barLength,0])
                cylinder(guideHeight, r = guideT/2, center = false);
            }
        }
        
        if(magType==1) { //Cylinder Hole
            translate ([0,0.5*barLength+0.5*distMag,-0.05])
            cylinder(cylMagHeight+0.05, r = cylMagRad, center = false);
            translate ([0,0.5*barLength-0.5*distMag,-0.05])
            cylinder(cylMagHeight+0.05, r = cylMagRad, center = false);
        } else { //Rectangle Hole
            translate ([-rectMagWidth*0.5,0.5*barLength+0.5*distMag,-0.05])
            cube([rectMagWidth, rectMagLength, rectMagHeight+0.05], center = false);
            translate ([-rectMagWidth*0.5,0.5*barLength-0.5*distMag,-0.05])
            cube([rectMagWidth, rectMagLength, rectMagHeight+0.05], center = false);
        } 
    }
} else { // Smaller TestPiece to test magnet fitting
    if(magType==2) { //Cylinder Hole
        difference() {
            translate ([0,0,0.05])
            cylinder(cylMagHeight+0.05+2, r = cylMagRad+1, center = false);
            cylinder(cylMagHeight+0.05, r = cylMagRad, center = false);
        }
    } else { //Rectangle Hole   
        difference() {
            translate ([-1,-1,0.05])
            cube([rectMagWidth+2, rectMagLength+2, rectMagHeight+0.05+2], center = false);      
            cube([rectMagWidth, rectMagLength, rectMagHeight+0.05], center = false);
        }
    }
}