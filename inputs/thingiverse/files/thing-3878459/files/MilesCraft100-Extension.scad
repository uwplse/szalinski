// Booleans are set as number because thingiverse customizer does not seem to support booleans variables (checkboxes)

// All dimensions are in millimeters

/* [General] */
// Optional side grips to hold onto the pocket-hole jig
addGrips = 1; // [1:Yes, 0:No]
// Distance (in mm) between the edge of the jig and the edge of the pocket-hole jig and the edge of the wood piece
bodyLength = 35.6; // [10:100]
// Name your jig extension (make sure the text fits with your dimensions)
topText = "1 1/2";
// Height (in mm) of the text
fontSize = 10; // [5:30]

/* [Lip] */
// Optional lip that comes against the edge of the wood piece
addLip = 1; // [1:Yes, 0:No]
// How low (in mm) does this lip go down the wood piece
lipDepth = 15; // [5:30]
// Thickness (in mm) of this lip
lipThickness = 6; // [2:20]

/* [Wings] */
// Side wings that can be used to laterally position the jig on the wood piece (serves as an edge guide)
addWings = 1; // [1:Yes, 0:No]
// Size (in mm) of the wing from the left side of the jig (when viewed from the drill)
leftWing = 13; // [0:100]
// Size (in mm) of the wing from the right side of the jig (when viewed from the drill)
rightWing = 13; // [0:100]
// optional lip on the edge of the left wing
leftWingLip = 0;  // [1:Yes, 0:No]
// optional lip on the edge of the right wing
rightWingLip = 0;  // [1:Yes, 0:No]


/* [Hidden] */
inch = 25.4; // mm

// These are measurements from the Milescraft jig and should thus be common to all designs (not configurable)

// Head
headWidth = 11.5;
cornerSide = 4;
height = 14.6;
depth = 5.6; 

// Body
jigWidthTolerance = 0.2;
jigWidth = 1 * inch + jigWidthTolerance;

// Grip
firstDentTolerance = 0.2;
firstDent = 11.5 + firstDentTolerance;
dentSide = 3.8;
gripWidth = 6; // aribtrary

letter_height = 2;
font = "Liberation Sans";

// Computed
actualLeftWing = (leftWing < gripWidth && addGrips && addWings && !leftWingLip) ? gripWidth : leftWing;
actualRightWing = (rightWing < gripWidth && addGrips && addWings && !rightWingLip) ? gripWidth : rightWing;

// Conditionnal sizing of the body width and middle axis
bodyWidth = jigWidth + (
    addWings ? 
        actualLeftWing + actualRightWing : 
        (addGrips ? gripWidth * 2 : 0)
);
bodyMiddle = addWings ? (actualLeftWing - actualRightWing)/2 : 0;

// These 2 conditional expressions are equivalent to: 
//if (addWings) {
//    bodyWidth = bodyWidth + actualLeftWing + actualRightWing;
//    bodyMiddle = (actualLeftWing - actualRightWing)/2;
//} else if (addGrips) {
//    bodyWidth = bodyWidth + gripWidth * 2;
//}


//   _-*-_-*-_-*-_-*   Modules   *-_-*-_-*-_-*-_   \\


module letter(l) {  // Written in 2014 by Torsten Paul <Torsten.Paul@gmx.de>
  linear_extrude(height=letter_height) {
    text(l, size=fontSize, font=font, halign="center", valign="center", $fn=30);
  }
} // This letter module /\ was imported from the text_on_cube.scad example

module grip(direction) {
    translate([firstDent,direction * jigWidth/2,0]) {
        // Grip Body
        translate([-firstDent/2,direction * gripWidth/2,0]) scale([firstDent + gripWidth,gripWidth,height]) cube(1, center=true);
        // Grip Corner
        rotate([0,0,45])  scale([cornerSide,cornerSide,height]) cube(1, center=true);
    }

}

module lip(length) {
    translate([- lipThickness/2, 0,lipDepth/2]) scale([lipThickness, length, lipDepth + height]) cube(1, center=true);
}

module wingLip(direction, wingLen) {
    wingLipLength = bodyLength + (addLip ? lipThickness : 0);
    
    rotate([0,0,direction * 90]) translate([-1 * (wingLen + jigWidth/2),direction * (wingLipLength)/2,0]) lip(wingLipLength);
}


//   _-*-_-*-_-*-_-*   Assembly   *-_-*-_-*-_-*-_   \\


rotate([-180,0,0]) {
    difference() {
        // Main piece
        union() {
            // Head
            scale([depth*2,headWidth,height]) cube(1, center=true);
            // Middle Dent
            translate([depth,0,0]) rotate([0,0,45])  scale([cornerSide,cornerSide,height]) cube(1, center=true);
            
            // Body (+ optional wings)
            translate([-bodyLength/2,bodyMiddle,0])  scale([bodyLength, bodyWidth, height]) cube(1, center=true);
            
            // Options
            if (addLip) {
                translate([- bodyLength, bodyMiddle, 0]) lip(bodyWidth);
            }
            if (addWings) {
                if (leftWingLip) wingLip(-1, actualLeftWing);
                if (rightWingLip) wingLip(1, actualRightWing);
            }
            if (addGrips) {
                grip(1);
                grip(-1);
            }
        }
        
        // Text if not empty (substracted from the main piece)
        if (topText) {
            translate([-bodyLength/2, bodyMiddle, -height/2+1]) rotate([-180,0,-90]) letter(topText); //  + letter_height
        }
    }
}
