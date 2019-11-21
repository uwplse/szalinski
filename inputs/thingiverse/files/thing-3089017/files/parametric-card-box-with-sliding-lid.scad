/*********************************************************************
* Parametric Card Box with Sliding Lid
*
* This is a simple box to hold playing cards.  The box has a sliding
* lid that uses friction to hold fairly tight.  The shared edges of
* the parts are mitered.
*********************************************************************/

/*********************************************************************
* Parameters
*********************************************************************/

/* [Build] */
generateTop    = "true"; //[true, false]
generateBottom = "true"; //[true, false]

/* [Card] */
cardWidth   = 64; /* Dimension of the "draw" side of the card */
cardLength  = 89;
stackHeight = 17;

/* [Box] */
wallThickness  = 3;
numberOfStacks = 3;
margin         = 0.5; /* Defines shell of extra space around the card stack */

/* [Text] */

/* Direction of text */
textInWidthDirection = "true"; //[true, false]

/* Lid text parameters */
addLidText  = "true"; //[true, false]
lidText     = "ABC";
lidTextSize = 20; /* mm */
lidTextFont = "Times";

/* Bottom text parameters */
addBottomText  = "true"; //[true, false]
bottomText     = "ABC";
bottomTextSize = 20; /* mm */
bottomTextFont = "Times";

/* [Hidden] */
/*********************************************************************
* Intermediate Calculations
*********************************************************************/

/* Calculate the interior size for compartment to hold 1 card stack */
compartmentInteriorSize = [cardWidth,cardLength,stackHeight] + margin*[2,2,2];

/* Calculate the total outside size of the box */
outsideSize = [ numberOfStacks*compartmentInteriorSize[0] + (numberOfStacks+1)*wallThickness,  compartmentInteriorSize[1] + 2*wallThickness, compartmentInteriorSize[2] + 2*wallThickness];

/*********************************************************************
* Generate 3D Model
*********************************************************************/

translate([outsideSize[0],0,outsideSize[2]])
if (generateTop == "true") {
    rotate([0,180,0])
    top();
}

if (generateTop == "true" && generateBottom == "true") {
    if (outsideSize[0] < outsideSize[1]) {
    translate([outsideSize[0]+5,0,0])
    bottom();
    }
    else {
        translate([0,outsideSize[1]+5,0])
        bottom();
    }
}
else if (generateBottom == "true") {
    bottom();
}

/*********************************************************************
* Modules
*********************************************************************/

/* Sliding lid for the top of the box */
module top() {
    
    difference() {
        union() {    
            /************************************
            * Vertical part of the sliding lid
            ************************************/
            
            translate([wallThickness,0,wallThickness])
            cube([outsideSize[0]-2*wallThickness, wallThickness, outsideSize[2]-wallThickness]);    
            
            translate([wallThickness,0,wallThickness])
            rotate([0,90,0])
            partSharedEdge(outsideSize[0]-2*wallThickness);
            
            translate([wallThickness,0,wallThickness])
            rotate([0,0,90])
            partSharedEdge(outsideSize[2]-wallThickness);
            
            translate([outsideSize[0]-wallThickness,0,wallThickness])
            rotate([0,0,0])
            partSharedEdge(outsideSize[2]-wallThickness);

            translate([wallThickness,0,wallThickness])
            euler321Rotate([90,180,0])
            partSharedCorner();

            translate([outsideSize[0]-wallThickness,0,wallThickness])
            mirror([1,0,0])
            euler321Rotate([90,180,0])
            partSharedCorner();
            
            /************************************
            * Horizontal part of the sliding lid
            ************************************/    
            
            translate([wallThickness,0,outsideSize[2]-wallThickness])
            cube([outsideSize[0]-2*wallThickness, outsideSize[1]-wallThickness, wallThickness]);

            translate([wallThickness,0,outsideSize[2]])
            rotate([270,90,0])
            partSharedEdge(outsideSize[1]-wallThickness);
            
            translate([outsideSize[0]-wallThickness,0,outsideSize[2]])
            mirror([1,0,0])
            rotate([270,90,0])
            partSharedEdge(outsideSize[1]-wallThickness);
            
            translate([wallThickness,outsideSize[1]-wallThickness,outsideSize[2]])
            rotate([0,90,0])
            partSharedEdge(outsideSize[0]-2*wallThickness);
            
            translate([outsideSize[0]-wallThickness,outsideSize[1]-wallThickness,outsideSize[2]])
            rotate([0,90,90])   
            partSharedCorner();

            translate([wallThickness,outsideSize[1]-wallThickness,outsideSize[2]])
            mirror([1,0,0])
            rotate([0,90,90])
            partSharedCorner();
            
            /************************************
            * Channel lock for the sliding lid
            ************************************/     
            
            translate([wallThickness,outsideSize[1]-wallThickness,outsideSize[2]-wallThickness])
            rotate([90,-90,0])
            lidLock(outsideSize[1]-wallThickness);
            
            translate([outsideSize[0]-wallThickness,outsideSize[1]-wallThickness,outsideSize[2]-wallThickness])
            rotate([90,0,0])
            lidLock(outsideSize[1]-wallThickness);
            
            translate([outsideSize[0]-wallThickness,outsideSize[1]-wallThickness,outsideSize[2]-wallThickness])
            mirror([0,1,0])
            rotate([90,0,270])
            lidLock(outsideSize[0]-2*wallThickness);
            
            translate([wallThickness,outsideSize[1]-wallThickness,outsideSize[2]-wallThickness])
            mirror([0,0,1])
            rotate([0,90,180])
            lidLockCorner();
            
            translate([outsideSize[0]-wallThickness,outsideSize[1]-wallThickness,outsideSize[2]-wallThickness])
            mirror([1,0,0])
            mirror([0,0,1])
            rotate([0,90,180])
            lidLockCorner();    
        }
    
        /************************************
        * Add text to the lid
        ************************************/
        
        if (addLidText == "true") {
            translate([0.5*outsideSize[0],0.5*outsideSize[1],outsideSize[2]-0.5])
            if (textInWidthDirection == "true") {
                writeText(lidText, lidTextSize, lidTextFont, 1.0);
            }
            else {
                rotate([0,0,270])
                writeText(lidText, lidTextSize, lidTextFont, 1.0);
            }
        }
    }
}

module bottom() {
    difference() {
        union() {
            translate([0, wallThickness, 0])
            cube([outsideSize[0], outsideSize[1]-wallThickness, outsideSize[2]-wallThickness]);

            translate([0,wallThickness,0])
            euler321Rotate([0,90,180])
            partSharedEdge(outsideSize[0]);

            translate([0,outsideSize[1],outsideSize[2]-wallThickness])
            euler321Rotate([0,90,180])
            partSharedEdge(outsideSize[0]);

            translate([0,wallThickness,0])
            rotate([0,0,-90])
            partSharedEdge(outsideSize[2]-wallThickness);
            
            translate([outsideSize[0],wallThickness,0])
            rotate([0,0,180])
            partSharedEdge(outsideSize[2]-wallThickness);

            translate([0,outsideSize[1],outsideSize[2]-wallThickness])
            rotate([90,0,0])
            partSharedEdge(outsideSize[1]-wallThickness);

            translate([outsideSize[0],outsideSize[1],outsideSize[2]-wallThickness])
            mirror([1,0,0])
            rotate([90,0,0])
            partSharedEdge(outsideSize[1]-wallThickness);

            translate([0,wallThickness,outsideSize[2]-wallThickness])
            partSharedCorner();

            translate([outsideSize[0],wallThickness,outsideSize[2]-wallThickness])
            mirror([1,0,0])
            partSharedCorner();
        }

        /* Remove channels for the lid lock to slide in to */
        /* Y direction, left side */
        translate([wallThickness,outsideSize[1]-wallThickness+0.001,outsideSize[2]-wallThickness])
        rotate([90,-90,0])
        lidLock(outsideSize[1]-wallThickness);
        /* Y direction, right side */
        translate([outsideSize[0]-wallThickness,outsideSize[1]-wallThickness+0.001,outsideSize[2]-wallThickness])
        rotate([90,0,0])
        lidLock(outsideSize[1]-wallThickness);
        /* X direction */
        translate([outsideSize[0]-wallThickness+0.001,outsideSize[1]-wallThickness,outsideSize[2]-wallThickness])
        mirror([0,1,0])
        rotate([90,0,270])
        lidLock(outsideSize[0]-2*wallThickness+0.002);
            
        translate([wallThickness,outsideSize[1]-wallThickness,outsideSize[2]-wallThickness])
        mirror([0,0,1])
        rotate([0,90,180])
        lidLockCorner();
        
        translate([outsideSize[0]-wallThickness,outsideSize[1]-wallThickness,outsideSize[2]-wallThickness])
        mirror([1,0,0])
        mirror([0,0,1])
        rotate([0,90,180])
        lidLockCorner();
        
        /* Remove space for interior card stack compartment */
        for (i = [1:numberOfStacks]) {
            xPosition = i*wallThickness + compartmentInteriorSize[0]*(i-1);
            cubePosition = [xPosition, wallThickness, wallThickness];        
            translate(cubePosition-[0,1,0]) cube(compartmentInteriorSize + [0,1,wallThickness+1]);
        }
        
        /************************************
        * Add text to the bottom of the box
        ************************************/

        if (addBottomText == "true") {
            translate([0.5*outsideSize[0],0.5*outsideSize[1],-0.5])
            mirror([1,0,0])
            if (textInWidthDirection == "true") {
                writeText(bottomText, bottomTextSize, bottomTextFont, 1.0);
            }
            else {
                rotate([0,0,90])
                writeText(bottomText, bottomTextSize, bottomTextFont, 1.0);
            }
        }        
    }
}

module lidLock(length = 1) {
    camfer(0.5*wallThickness, length);
}

module partSharedEdge(length = 1) {
    camfer(wallThickness, length);
}

module camfer(edgeWidth = 1, edgeLength = 1) {
    scale([edgeWidth, edgeWidth, edgeLength])
    linear_extrude(1) polygon([[0,0],[0,1],[1,0]]);
}

module partSharedCorner() {
    scale([wallThickness, wallThickness, wallThickness])
    openCornerCamfer();
}

module lidLockCorner() {
    scale([0.5*wallThickness, 0.5*wallThickness, 0.5*wallThickness])
    openCornerCamfer();
}

module openCornerCamfer() {
    intersection() {
        rotate([0,0,-90]) linear_extrude(1) polygon([[0,0],[0,1],[1,0]]);
        translate([0,0,0]) rotate([90,0,0]) linear_extrude(1) polygon([[0,0],[0,1],[1,0]]);
    }
}

module euler123Rotate(a = [0,0,0]) {
    rotate([   0,    0, a[2]])
    rotate([   0, a[1],    0])
    rotate([a[0],    0,    0])
    children();   
}

module euler321Rotate(a = [0,0,0]) {
    rotate([a[2],    0,    0])
    rotate([   0, a[1],    0])
    rotate([   0,    0, a[0]])
    children();   
}

module writeText(textString, textSize, textFont, textHeight)
{
    linear_extrude(textHeight)
    text(textString, textSize, textFont, halign = "center", valign = "center");
}