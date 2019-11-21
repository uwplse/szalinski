/// The "normal" settings
length=95; //<-- Excluding the "head"
width=10;
distanceBetweenHeads=20; //<-- Enter a negative number for just one head
label="Printer";
thickness=1;

/// Label settings
xLabelPosition=15; //<-- The start position of the label, 0=right after the head, negative number to get the label between the two heads
yLabelPosition=0; //<-- 0=Center of the tie 
letterSize=6;
letterHeight=thickness; //<-- Positive number for raised text, negative number for indented
font = "Open Sans Condensed:style=bold"; //<-- See "Help->Font List" for more fonts

/// 
wrinkleHeight=thickness;
// The rinkles left of the label
xWrinkleStart1=0; //<-- Measured from the head, the size of the head excluded
xWrinkleEnd1=xLabelPosition; //<-- Measured from the head, the size of the head excluded, enter "length" for all the 
// The rinkles right of the labes
xWrinkleStart2=45; //<-- Measured from the head, the size of the head excluded
xWrinkleEnd2=length; //<-- Measured from the head, the size of the head excluded, enter "length" for all the way to the end

/// Settings for the head
headLength=13;
headWidth=width+6;

// This is something that seem to be necessary to avoid infinit thin left overs when cutting
magicTolerance=0.01;

module head() {
    cutLength=5;
    cutWidth=width+2*1;
    filletRadius=3;
    
    translate([0, -headWidth/2, 0]) {
        difference() {
            filletCube(headLength, headWidth, thickness, filletRadius);
            // Make the cut
            translate([(headLength-cutLength)/2, (headWidth-cutWidth)/2, -magicTolerance/2]) {
                translate([cutLength-2*thickness,0,0]) {
                    cube([thickness, cutWidth, thickness+magicTolerance]);
                    rotate([-90, 0, 0])
                        linear_extrude(height=cutWidth)
                        polygon(points=[[0+magicTolerance,0],[-thickness,0],[0, -thickness]], paths=[[0,1,2]]);
                }
                cube([cutLength,1,thickness+magicTolerance]);
                translate([0, cutWidth-1, 0])
                    cube([cutLength, 1, thickness+magicTolerance]);
            }
        }
    }
}

module filletCube(length, width, thickness, radius) {
    difference() {
        cube ([length, width, thickness]);
        fillet(radius, thickness+magicTolerance);   
        translate([0, width, 0])
            rotate([0, 0, -90])
                fillet(radius, thickness+magicTolerance);   
        translate([length, width, 0])
            rotate([0, 0, 180])
                fillet(radius, thickness+magicTolerance);   
        translate([length, 0, 0])
            rotate([0, 0, 90])
                fillet(radius, thickness+magicTolerance);   
    }
}

module campherEdge() {
    translate([-magicTolerance, -magicTolerance, -magicTolerance])
        rotate([0,90,0])
        linear_extrude(height=length)
            polygon(points=[[0,thickness],[-thickness,0],[0,0]], paths=[[0,1,2]]);
}

module body(length) {
    filletRadius=3;
    translate([0, -width/2, 0]) {
        difference() {
            // Make the tie
            translate([-filletRadius,0,0]) // To remove the fillet corners closest to the head
                filletCube(length+filletRadius, width, thickness, filletRadius);
            campherEdge();
            translate([0, width, 0]) 
                mirror([0,1,0])
                    campherEdge();
        }
        wrinkle(xWrinkleStart1, xWrinkleEnd1);
        wrinkle(xWrinkleStart2, xWrinkleEnd2);
    }
}

module label(zPosition, lheight) {
    echo(lheight);
    color("red")
    translate([xLabelPosition, yLabelPosition, zPosition-magicTolerance]) {
        linear_extrude(height=lheight)
        text(label, letterSize, font, halign = "left", valign = "center");
    }
}

module wrinkle(start, end) {
    color("black")
    for (i=[start:5:end-5]) {
        translate([i,0,thickness-magicTolerance])
        filletCube(2, width, wrinkleHeight, 1);
    }
}

module fillet(r, h) {
    $fn = 60;
    difference() {
        translate([-magicTolerance/2, -magicTolerance/2, -magicTolerance/2])
            cube([r, r, h]);
        translate([r-magicTolerance/2, r-magicTolerance/2, -magicTolerance/2])
            cylinder(r = r, h = h+magicTolerance);
    }
}

union() {
    // Second head
    if(distanceBetweenHeads >= 0) {
        translate([-(2*headLength+distanceBetweenHeads), 0, 0]) {
            head();
            translate([headLength, -width/2, 0])
                cube([distanceBetweenHeads, width, thickness]);
        }
    }
    
    // First head
    translate([-headLength, 0, 0])
        head();
    
    // Rais or indent the label
    if(letterHeight > 0) {
        union() {
            body(length);
            label(thickness, letterHeight);
        }
    }
    else {
        difference() {
            body(length);
            label(thickness+letterHeight, -letterHeight);
        }
    }
}
