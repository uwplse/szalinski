// Tube Bracket - Made by MakeWithLasers.com
// Sharing of this file outside of Thingiverse or without
// crediting MakeWithLasers.com is prohibited.

// Description: Creates a customized mount for a laser tube.

// All units are in mm.

// Tube diameter is the diameter of the tube.

// Tube center height tells how far above the mounting surface
// the center of the laser tube should be.  This is the height
// of the center of the first mirror.

// Part controls whether to build the top of the bracket, the
// bottom of the bracket, or a spacer.

// preview[view:south west, tilt:top]

// User-defined variables

// 
Tube_Diameter = 55;

// 
Tube_Center_Height = 72;

// 
Part = "bottom"; // [top: Top of bracket,bottom: Bottom of bracket,spacer: Spacer]

// Internal variables
$fn = 50*1;
defaultBlockHeight = 8*1;
blockWidth = 40*1;
blockLength = 69*1;
holeSpaceing = 29*1;
lowerHoleLength = 12*1;
lowerHoleWidth = 5.5*1;
upperHoleLength = 14.5*1;
upperHoleWidth = 9*1;
holeSeparationX = 28*1;
holeSeparationY = 44.5*1;
ringThickness = 5*1;
ringWidth = 20*1;
screwBlockWidth = 8*1;
screwBlockHeight = 5*1;
screwBlockOffset = (Tube_Diameter/2 + ringThickness) - (Tube_Diameter/2+ringThickness)*cos(asin(screwBlockHeight/(Tube_Diameter/2+ringThickness)));
screwGap = 4*1;

// Construct model

module spacingBlock(blockHeight = defaultBlockHeight, topBlock = false) {
    // topBlock = false; Parameter to determine whether or not to countersink the top half for the screws
    // blockHeight = 8; Passed as parameter to allow different heights, which is needed for the top bracket.    
    
    difference() {
        translate([-blockWidth/2,-blockLength/2,0]) {
            cube([blockWidth, blockLength, blockHeight]);
        }
        
        for (i = [0:1]) {
            for (j = [0:1]) {
                // Remove the smaller hole that goes all the way through
                translate([holeSeparationX/2*(1-2*i),holeSeparationY/2*(1-2*j),0]){
                    hull(){
                        translate([0,-(lowerHoleLength-lowerHoleWidth)/2,-blockHeight/2]) {
                            cylinder(blockHeight*2,d1=lowerHoleWidth,d2=lowerHoleWidth);
                            translate([0,lowerHoleLength-lowerHoleWidth,0]) {
                                cylinder(blockHeight*2,d1=lowerHoleWidth,d2=lowerHoleWidth);
                            }
                        }
                    }
                }
                
                if (topBlock == true) { // Remove the larger hole (screwhead countersink area)
                    translate([holeSeparationX/2*(1-2*i),holeSeparationY/2*(1-2*j),0]){
                        hull(){
                            translate([0,-(upperHoleLength-upperHoleWidth)/2,blockHeight/2]) {
                                cylinder(blockHeight,d1=upperHoleWidth,d2=upperHoleWidth);
                                translate([0,upperHoleLength-upperHoleWidth,0]) {
                                    cylinder(blockHeight,d1=upperHoleWidth,d2=upperHoleWidth);
                                }
                            }
                        }
                    }
                }
            }
        }
    }    
}

module bottomTubeBracket() {
    spacingBlockHeight = (Tube_Center_Height - (Tube_Diameter/2)) - defaultBlockHeight*floor((Tube_Center_Height - (Tube_Diameter/2)) / defaultBlockHeight) <= max(defaultBlockHeight/2,ringThickness) ? (Tube_Center_Height - (Tube_Diameter/2)) - (defaultBlockHeight)*(floor((Tube_Center_Height - (Tube_Diameter/2)) / defaultBlockHeight)-1) : (Tube_Center_Height - (Tube_Diameter/2)) - defaultBlockHeight*floor((Tube_Center_Height - (Tube_Diameter/2)) / defaultBlockHeight);
    
    
    echo(str("SpacingBlockHeight=",spacingBlockHeight));
    union() {        
        spacingBlock(spacingBlockHeight,true);
        translate([0,0,spacingBlockHeight+Tube_Diameter/2]) {
            rotate([0,90,0]) {
                difference() {
                    union() {
                        cylinder(ringWidth,d1=Tube_Diameter+2*ringThickness,d2=Tube_Diameter+2*ringThickness,center=true);
                        translate([(Tube_Diameter/2+ringThickness)-Tube_Diameter/4,0,0]) {
                            cube([Tube_Diameter/2,Tube_Diameter,ringWidth-2],true);
                        }
                        
                        for (i = [0:1]) {
                            translate([screwBlockHeight/2,(1-2*i)*(Tube_Diameter/2+ringThickness+screwBlockWidth/2-screwBlockOffset),0]){
                                difference() {
                                    cube([screwBlockHeight,screwBlockWidth,ringWidth],center=true);
                                    rotate([0,90,0]) {
                                        cylinder(screwBlockHeight*2,d1=4.5,d2=4.5,center=true);
                                    }
                                }
                            }
                        }
                        
                    }
                    cylinder(ringWidth*2,d1=Tube_Diameter,d2=Tube_Diameter,center=true);
                    translate([-(Tube_Diameter+2*ringThickness)/4,0,0]) {
                        cube([(Tube_Diameter+2*ringThickness)/2,(Tube_Diameter+2*ringThickness),ringWidth*4],true);
                    }
                }
            }   
        }
    }
}

module topTubeBracket() {
    
        translate([0,0,ringWidth/2]){
            union(){
                for (i = [0:1]) {
                    translate([-screwBlockHeight/2,(1-2*i)*(Tube_Diameter/2+ringThickness+screwBlockWidth/2-screwBlockOffset),0]){
                        difference() {
                            cube([screwBlockHeight,screwBlockWidth,ringWidth],center=true);
                            rotate([0,90,0]) {
                                cylinder(screwBlockHeight*2,d1=4.5,d2=4.5,center=true);
                            }
                        }
                    }
                }
                
                difference() {
                    cylinder(ringWidth,d1=Tube_Diameter+2*ringThickness,d2=Tube_Diameter+2*ringThickness,center=true);
                    cylinder(ringWidth*2,d1=Tube_Diameter,d2=Tube_Diameter,center=true);
                    translate([(Tube_Diameter+2*ringThickness)/4,0,0]) {
                        cube([(Tube_Diameter+2*ringThickness)/2,(Tube_Diameter+2*ringThickness),ringWidth*4],true);
                    }
                }
            }
        }
}


if (Part == "bottom") {
    bottomTubeBracket();
} else if (Part == "top") {
    topTubeBracket();
} else {
    spacingBlock();
}