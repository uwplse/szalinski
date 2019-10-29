/*
cardSizes

TicketToRide
    43.44 x 67.51 x 0.25

Dominion
    58.95 x 90.83 x 0.3

Catan
    54.2 x 80.2 x 0.3
    
Power Grid Money
    45 x  90 x 0.1
    
Power Grid Plants
    70 x 70 x 0.25
*/

// if using sleeves, this will be the sleeve width
cardWidth = 70;
// if using sleeves, this will be the sleeve height
cardHeight = 70;
// if using sleeves, this is the total width of a card in a sleeve
totalCardDepth = 0.25;
// additional space around the card, 2 is 1mm at each end
xySpace = 2;
// additional space at the top of the set of cards (it's no fun if they want to fall out all the time). Cards also have imperfections and don't stack perfectly so we'll add a little extra space here.
zSpace = 2.5;
// totalCards to hold
numberOfCards = 50;
// outer edge at the bottom
baseEdgeThickness = 7;
// size of rounded corners at the bottom
filletSize=8;
// this can be tailored based on your printer. A figure of zero essentially means that the points at the end of the interlocking system should exactly touch, so we need to push them together to create a lock. A more accurate printer should permit this figure to get close to the precise figure of -2.
interlockClearance = -1.2;
// another locking clearance parameter, this time for the top/bottom interlock. a typical feature of 3D printing is that the bottom layer is a touch larger than the rest in order to create good bed adhesion, in this case, removing a small sliver from the locking mechanism helps top/bottom stacking to happen cleanly without giving rise to bending trays. You'll tailor this based on your experience with your own printer.
topBottomInterlockClearance = 0.7;
// to allow only a lid to be printed
lidOnly = "no"; //[yes,no]

module basePlate() {
    // start with the easy stuff
    // the bottom layer contains enough space for the card, the perimeter walls at 2mm and the extra breathing space configured
    cube ([cardWidth+4+xySpace, cardHeight+4+xySpace, 2], center=true);
}

module cutOut() {
    
    cube ([cardWidth-baseEdgeThickness*2, cardHeight-baseEdgeThickness*2, 2.1], center=true);
}

module cutOutFillets() {
    translate ([cardWidth/2-baseEdgeThickness-filletSize/2,cardHeight/2-baseEdgeThickness-filletSize/2,0]) rotate([0,0,180]) fillet(filletSize,2);
    translate ([-(cardWidth/2-baseEdgeThickness-filletSize/2),cardHeight/2-baseEdgeThickness-filletSize/2,0]) rotate([0,0,-90]) fillet(filletSize,2);
    translate ([-(cardWidth/2-baseEdgeThickness-filletSize/2),-(cardHeight/2-baseEdgeThickness-filletSize/2),0]) rotate([0,0,0]) fillet(filletSize,2);
    translate ([cardWidth/2-baseEdgeThickness-filletSize/2,-(cardHeight/2-baseEdgeThickness-filletSize/2),0]) rotate([0,0,90]) fillet(filletSize,2);
}

module fingerAccess() {
    fingerAccessX = (cardWidth+xySpace+2)/2-1;
    fingerAccessY = (cardHeight+xySpace+2)/2-1;
    translate([0,fingerAccessY,0])
    cube([28,4.01,3],center=true);
    translate([0,-fingerAccessY,0])
    cube([28,4.01,3],center=true);
    translate([fingerAccessX,0,0])
    cube([4.01,28,3],center=true);
    translate([-fingerAccessX,0,0])
    cube([4.01,28,3],center=true);
}

module fingerAccessFillets() {
    fingerAccessX = (cardWidth+xySpace+2)/2-2;
    fingerAccessY = (cardHeight+xySpace+2)/2-2;
    translate([-13,fingerAccessY,0])
    fillet(2,2);
    translate([13,fingerAccessY,0])
    rotate([0,0,90])
    fillet(2,2);
    translate([-13,-fingerAccessY,0])
    rotate([0,0,-90])
    fillet(2,2);
    translate([13,-fingerAccessY,0])
    rotate([0,0,180])
    fillet(2,2);
    translate([fingerAccessX,13,0])
    rotate([0,0,-90])
    fillet(2,2);
    translate([fingerAccessX,-13,0])
    rotate([0,0,0])
    fillet(2,2);
    translate([-fingerAccessX,13,0])
    rotate([0,0,180])
    fillet(2,2);
    translate([-fingerAccessX,-13,0])
    rotate([0,0,90])
    fillet(2,2);

}

module edgeWalls() {
    // our edge walls will be 2mm thick; the same as the base
    // we'll need the to be high enough for the stack of cards we want to contain
    // rather than build many separate walls, we'll create a large cube, cutout the center, then cut out the holes in the edges
    translate([0,0,(totalCardDepth*numberOfCards+zSpace)/2])
    difference() {
        // main block
        cube ([cardWidth+4+xySpace, cardHeight+4+xySpace, totalCardDepth*numberOfCards+zSpace], center=true);
        // remove center
        cube ([cardWidth+xySpace, cardHeight+xySpace, totalCardDepth*numberOfCards+zSpace+0.1], center=true);
        // remove centers
        cube([28,cardHeight*2,totalCardDepth*numberOfCards+zSpace+0.1], center=true);
        // remove centers
        cube([cardWidth*2,28,totalCardDepth*numberOfCards+zSpace+0.1], center=true);
        // and lets round those corners to prevent bleeding fingers and nuckles
    }
}

module edgeFillets() {
    filletX = (cardWidth+xySpace+2)/2;
    filletY = (cardHeight+xySpace+2)/2;
    translate([filletX,16,totalCardDepth*numberOfCards+zSpace-2])
        rotate([0,90,0])
        fillet(4,3);   

    translate([-filletX,16,totalCardDepth*numberOfCards+zSpace-2])
        rotate([0,90,0])
        fillet(4,3);   
    translate([-filletX,-16,totalCardDepth*numberOfCards+zSpace-2])
        rotate([0,90,180])
        fillet(4,3);   
    translate([filletX,-16,totalCardDepth*numberOfCards+zSpace-2])
        rotate([0,90,180])
        fillet(4,3);
    translate([-16,filletY,totalCardDepth*numberOfCards+zSpace-2])
        rotate([0,90,90])
        fillet(4,3);   
    translate([16,filletY,totalCardDepth*numberOfCards+zSpace-2])
        rotate([0,90,-90])
        fillet(4,3);   
    translate([-16,-filletY,totalCardDepth*numberOfCards+zSpace-2])
        rotate([0,90,90])
        fillet(4,3);   
    translate([16,-filletY,totalCardDepth*numberOfCards+zSpace-2])
        rotate([0,90,-90])
        fillet(4,3);   

}

module lockingPerimeter() {
    translate([0,0,(totalCardDepth*numberOfCards+zSpace)/2+2])
    difference() {
        // main block
                                                                                                     cube ([cardWidth+8+xySpace, cardHeight+8+xySpace, totalCardDepth*numberOfCards+zSpace+1], center=true);
        // remove center
        cube ([cardWidth+4+xySpace, cardHeight+4+xySpace, totalCardDepth*numberOfCards+zSpace+1.1], center=true);
        // remove centers
        cube([28,cardHeight*2,totalCardDepth*numberOfCards+zSpace+1.1], center=true);
        // remove centers
        cube([cardWidth*2,28,totalCardDepth*numberOfCards+zSpace+1.1], center=true);
        // and lets round those corners to prevent bleeding fingers and nuckles
    }
}

module lock(length,rX,rY,rZ,bcR) {
    translate([0,0,(totalCardDepth*numberOfCards+zSpace+1.1)/2])
    difference() {
        rotate([rX,rY,rZ])
        difference() {
                cube([2,length-interlockClearance,totalCardDepth*numberOfCards+zSpace+1.1],center=true);
                translate([0,(length-interlockClearance)/2,0])
                rotate([0,0,45])
                cube([2,length-interlockClearance,totalCardDepth*numberOfCards+zSpace+1.2],center=true);
        };
        translate([0,0,-(totalCardDepth*numberOfCards+zSpace+1.1)/2])
        rotate([rX,rY,rZ])
        rotate([0,bcR,0])
        cube([2,length+0.1-interlockClearance,totalCardDepth*numberOfCards+zSpace+1.2],center=true);
    }
}

module lockingPerimeter2() {
    translate([(cardWidth+4+2+xySpace)/2,(sideLength/2-14)/4-sideLength/2-interlockClearance/2,1.5])
        lock((sideLength/2-14)/2,0,180,0,45);
    translate([(cardWidth+4+2+xySpace)/2,-((sideLength/2-14)/4-sideLength/2-interlockClearance/2),1.5])
        lock((sideLength/2-14)/2,180,180,0,-45);
    translate([-(cardWidth+4+2+xySpace)/2,(sideLength/2-14)/4+14-interlockClearance/2,1.5])
        lock((sideLength/2-14)/2,0,0,0,-45);
    translate([-(cardWidth+4+2+xySpace)/2,-((sideLength/2-14)/4+14-interlockClearance/2),1.5])
        lock((sideLength/2-14)/2,180,0,0,45);
    
    translate([-((endLength/2-14)/4-endLength/2-interlockClearance/2),(cardHeight+4+2+xySpace)/2,1.5])
        lock((endLength/2-14)/2,0,180,90,45);
    translate([((endLength/2-14)/4-endLength/2-interlockClearance/2),(cardHeight+4+2+xySpace)/2,1.5])
        lock((endLength/2-14)/2,0,0,270,-45);
    translate([-((endLength/2-14)/4+14-interlockClearance/2),-(cardHeight+4+2+xySpace)/2,1.5])
        lock((endLength/2-14)/2,0,0,90,-45);
    translate([((endLength/2-14)/4+14-interlockClearance/2),-(cardHeight+4+2+xySpace)/2,1.5])
        lock((endLength/2-14)/2,0,180,270,45);

}

module perimeterFillets () {
    translate([-14-2,-(cardHeight+4+2+xySpace)/2,totalCardDepth*numberOfCards+zSpace+1-0.4])
    rotate([0,90,90])
    fillet(4,3);
    translate([-(-14-2),-(cardHeight+4+2+xySpace)/2,totalCardDepth*numberOfCards+zSpace+1-0.4])
    rotate([0,90,-90])
    fillet(4,3);
    translate([-(cardWidth+4+2+xySpace)/2,-(-14-2),totalCardDepth*numberOfCards+zSpace+1-0.4])
    rotate([0,90,0])
    fillet(4,3);
    translate([-(cardWidth+4+2+xySpace)/2,(-14-2),totalCardDepth*numberOfCards+zSpace+1-0.4])
    rotate([0,90,180])
    fillet(4,3);

}

module fillet(r, h) {
    $fn = 50;
    difference() {
        cube([r + 0.01, r + 0.01, h], center = true);

        translate([r/2, r/2, 0])
            cylinder(r = r, h = h + 1, center = true);

    }
}

module topBottomLockAssist() {
    translate([0,0,2+totalCardDepth*numberOfCards+zSpace])
    cube ([cardWidth+4+xySpace+topBottomInterlockClearance, cardHeight+4+xySpace+topBottomInterlockClearance, 2], center=true);
}

sideLength = cardHeight+xySpace+4;
endLength = cardWidth+xySpace+4;


union() {
    difference() {
        // 1. to make the base we'll make a rectangle
        basePlate();
        // 2. and cut out the center and finger access points
        cutOut();
        fingerAccess();
    }
    // 3. then add the fillets()
    cutOutFillets();
    fingerAccessFillets();
    if (lidOnly=="no") {
        // 4. With the base built, we can add the walls
        translate([0,0,1])
        difference() {
            edgeWalls();
            edgeFillets();
        }
        // 5. Now we'll add the inter-locking system
        difference () {
            lockingPerimeter2();
            perimeterFillets();
            topBottomLockAssist();
        }
    }
}