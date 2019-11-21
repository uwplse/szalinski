/* [Card Info] */
// width of card
cardWidth = 56;
// length of card
cardLength = 87;
// height of each card stack (not total stack if doing multiple columns)
cardHeight = 25.5;
// number of stacks to use in box
cardStacks = 2;

/* [Padding and Gaps] */
// space around the cards in the tray
cardGap = 2.5;
// space above the stack of cards
stackGap = 5;
// gap for ease of getting lid off of box
boxGap = 1;
// thickness of box walls
wallThickness = 2.5;

/* [Box Label] */
// will be embossed into lid
title = "UNO";
//depth of the lettering
textDepth = 1;
// size of the font
textSize = 24;
// font to use
textFont = "Helvetica"; // [Arial,Times,Helvetica,Courier,Futura]

/* [hidden] */
// used to offset z collisions
fudge = 0.005;
// use 100 segments on rounded edges
$fn = 100;

cardBox = [
    cardWidth + 2 * cardGap,
    cardLength + 2 * cardGap,
    cardHeight + stackGap
];

bottomBox = [
    cardBox[0] * cardStacks + (cardStacks + 1) * wallThickness,
    cardBox[1] + 2 * wallThickness,
    cardBox[2] + wallThickness
];

topBox = [
    bottomBox[0] + 2 * wallThickness + boxGap,
    bottomBox[1] + 2 * wallThickness + boxGap,
    bottomBox[2] + wallThickness
];

// bottom box
difference() {    
    cube(bottomBox);
    
    for (n = [0 : cardStacks - 1]) {
        translate([wallThickness + n * (cardBox[0] + wallThickness), wallThickness, wallThickness + fudge])
        cube(cardBox);
    }

    translate([-fudge, bottomBox[1] / 2, bottomBox[2]])
    rotate([0, 90])
    cylinder(r=cardBox[2]*0.6, h=bottomBox[0]+2*fudge, center = false);
}

startingPoint = [-wallThickness - boxGap/2, - topBox[1] - 5];

// top box
difference() {
    translate(startingPoint) {
        cube(topBox);
    }
        
    translate(startingPoint) {
        translate([wallThickness, wallThickness, wallThickness + fudge])
        cube([bottomBox[0] + boxGap, bottomBox[1] + boxGap, bottomBox[2] + wallThickness]);
        
        translate([-fudge, topBox[1] / 2, topBox[2]])
        rotate([0, 90])
        cylinder(r=cardBox[2]*0.3, h=topBox[0]+2*fudge, center = false);
        
        translate([topBox[0] / 2, topBox[1] / 2, textDepth - fudge])
        rotate([180])
        linear_extrude(height = textDepth)
        text(title, size = textSize, font = textFont, valign="center", halign="center");
    }
}