/*
 * Parametric SMD Parts Holder with Lid
 * Copyright (C) 2018  Fully Automated Technologies <fully.automated@astech.hu>
 * Zoé Eisendle
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * https://www.thingiverse.com/thing:3238003 
 */
 
// Should a single box be generated? 
GENERATE_SINGLE_BOX=0; // [1:yes, 0:no]
// Should a lid be generated?
GENERATE_LID=0; // [1:yes, 0:no]
// Should a tray be generated?
GENERATE_TRAY=1; // [1:yes, 0:no]
// Should a rack with shelves for the trays be generated?
GENERATE_RACK = 0; // [1:yes, 0:no]
// Should a funnel be generated?
GENERATE_FUNNEL =0; //  [1:yes, 0:no]
// Should a box with lid on it be generated? Not useful for printing.
GENERATE_LID_TEST = 0; // [1:yes, 0:no]
// Should I flip the parts upside down? (Recommended printing orientation)
FLIP_UPSIDE_DOWN = 0; // [1:yes, 0:no]

// Long side of each compartment
compartmentSide = 15; // mm
// General wall thickness 
wall = 0.48*3; // mm (recommended: 1.2*<nozzle_diam>*3
// Depth of the compartments
depth = 8; // mm
// Gap between parts. Reduce for tighter fit.
gap = 0.25; // mm
// Rounding radius for the corners
cornerRounding = 3.5; // mm
// Opening for the compartment, 75% of the
compartmentWindow = compartmentSide * 0.75; // mm
// Width of the side rails
railWidth = 6*wall; // mm, recommended is 6 * wall thickness
// Thickness of the rails and the base plate.
railThickness = 2*wall; // mm, recommended is 2 * wall thickness
// Width of the tray (numbers of compartments will be auto-calculated. Width includes the rails.
trayWidth = 160; // mm
// Height of the tray (numbers of compartments will be auto-calculated
trayHeight = 100; // mm
// Pivot ball radius. 80% of wall thickness is recommended 
pivotBall = wall*0.8; // mm
// Thickness of lid. 120% of wall thickness is default
lidcoverThickness = wall*1.2; // mm
// Height of the funnel
funnelHeight = 46; // mm
// $fn quality parameter (approximation of curves)
$fn=22; // setting it too high will take forever to render
// Number of shelves for the rack
rackShelves = 6; 

////// CODE
module empty() {
}
font = "DINPro:style=Regular";
//font = "write/orbitron.dxf";
epsilon = 0.01;

if (GENERATE_FUNNEL == 1) {
    translate([-100,-100,(FLIP_UPSIDE_DOWN==1?funnelHeight+3*wall:0)])
    rotate([0,(FLIP_UPSIDE_DOWN==1?180:0),0])
funnel();
}
if (GENERATE_TRAY == 1) {
    translate([(FLIP_UPSIDE_DOWN==1?trayWidth:0),0,(FLIP_UPSIDE_DOWN==1?box.z:0)])
        rotate([0,(FLIP_UPSIDE_DOWN==1?180:0),0])
            evenBetterTray(trayWidth,trayHeight);
}

if (GENERATE_SINGLE_BOX == 1) {
    translate([wall,-wall+(FLIP_UPSIDE_DOWN==1?0:-biggerbox.y-enlargement),(FLIP_UPSIDE_DOWN==1?box.z:0)])
        rotate([(FLIP_UPSIDE_DOWN==1?180:0),0,0])
            partBox();
}

if (GENERATE_LID == 1 ) {
    translate([-box.x-wall,-wall,(FLIP_UPSIDE_DOWN==1?lidcoverThickness:2.5*wall)])
    rotate([(FLIP_UPSIDE_DOWN==1?180:0),0,0])
    lid();
}

if (GENERATE_LID_TEST == 1) {
    translate([-biggerbox.x-wall,-biggerbox.y-wall,0])
    lidTest();
}

if (GENERATE_RACK == 1) {
    translate([trayWidth + 3*wall,0,0])
        rack();
}

    box = [compartmentSide + 2* wall,
                    compartmentSide + 2* wall,
                    depth + 2* wall];
    window = [box.x-4*wall, compartmentSide-compartmentWindow, lidcoverThickness+2*epsilon];
enlargement=wall;
biggerbox = [box.x+enlargement,box.y+enlargement,3*wall];

hingeCoords = [0,box.y-window.y/2,-wall];

lockCoords = [box.x/2-wall/2,wall*1.5+gap,-wall*1.5];

module printableSet(w,h) {
translate([0,0,box.z]) rotate([180,0,0]) evenBetterTray(w,h);
translate([0,0,lidcoverThickness]) rotate([0,180,0]) lid();
}

module lidTest() {
translate([enlargement/2,enlargement/2,box.z]) {
    %lid();
translate(hingeCoords)
rotate([-100,0,0])
        translate(-hingeCoords)
        %lid();
}
partBox();
}

module roundedCube(a,r) {
    translate([1,1,1]*a/-2)
    minkowski() {
        sphere(r);
        cube(a);
    }
}

module inside(side,radius) {
    a = side-radius*2;
    r = radius;
    translate([1,1,1]*side/2)
    intersection() {
        rotate([45,0,0])
            roundedCube(a,r);
        rotate([0,45,0])
            roundedCube(a,r);
        translate([1,1,2]*side/-2)
            cube(side);
    }
}

module roundedSquare1(a,b,r,h) {
    translate([r,r,0])
        minkowski() {
            cube([a-2*r,b-2*r,h-r]);
            cylinder(r=r, h=r);
        }
}

module roundedSquare2(a,b,r,h) {
    translate([r,r,r])
        minkowski() {
            cube([a-2*r,b-2*r,h-2*r]);
            sphere(r);
        }
}


module roundedSquare3(a,b,r,h) {
//    translate([r,0,0])
//        cube([a-2*r,b,h]);
//    translate([0,r,0])
//        cube([a,b-2*r,h]);
    vectors = [[r,r],[a-r,r],[r,b-r],[a-r,b-r]];
    hull() {
        for (vector=vectors)
            translate(vector)
                cylinder(r=r,h=h);
    }
}

module roundedSquare4(a,b,r,h) {
    intersection() {
        union() {
            translate([r,0,0])
                cube([a-2*r,b,h]);
            translate([0,r,0])
                cube([a,b-2*r,h]);
            vectors = [[r,r],[a-r,r],[r,b-r],[a-r,b-r]];
            for (vector=vectors)
                translate(vector)
                    cylinder(r=r,h=h);
        }
        union() {
            dh = r*(1-1/sqrt(2));
            dy = r/sqrt(2);
            longer = (a>b)?a:b;
            translate([a/2,b/2,epsilon])
                cylinder(d1=2,d2=1.1*sqrt(2)*longer,h=h);
        }
    }
}

module rackRail(width,chamfer=false) {
    h = trayHeight+wall;
    chamferRadius = width * 0.55;
    translate([0,0,box.z-railThickness*2-gap]) {
        roundedSquare3(width,h,width/2,railThickness);
    if (chamfer) {
        translate([0,0,railThickness])
        rotate([-90,0,0])
        intersection() {
            cylinder(r=chamferRadius ,h=h);
            translate([0,0,-epsilon])
                cube([chamferRadius ,chamferRadius ,h+2*epsilon]);
        }
    }
}
}

module rack() {
    railWidth = 5*wall;
    spacingBetweenTrayAndRack = 0.7 * wall;
    rackWallThickness = wall*2;
    totalWidth = trayWidth + 2* spacingBetweenTrayAndRack + 2* rackWallThickness;
    levelSeparation = box.z + lidcoverThickness + 2.5*wall;
    for( i = [0:rackShelves-1])
        translate([0,0,levelSeparation*i+wall*2]) {
            rrw = railWidth+spacingBetweenTrayAndRack+rackWallThickness;
            rackRail(rrw,true);
            translate([totalWidth,0,0])
            mirror([1,0,0])
                rackRail(rrw,true);
            // thin guide rail
            translate([0,wall,railThickness*2+3*gap])
                rackRail(rrw/2,false);
            translate([totalWidth,wall,railThickness*2+3*gap])
            mirror([1,0,0])
                rackRail(rrw/2,false);
        }
        // left side
        wallGeom = [rackWallThickness,trayHeight+rackWallThickness,rackShelves*levelSeparation];
        cube(wallGeom);
        // right side
        translate([totalWidth - wallGeom.x,0,0])
            cube(wallGeom);
        // backside
        translate([0,trayHeight,0])
            cube([totalWidth,rackWallThickness,wallGeom.z]);
        
        // connector
        for( j=[0:1])
            mirror([1,0,0])
        for (i=[0:1])
        translate([-j*(totalWidth-2*epsilon)+epsilon,rackWallThickness+i*(wallGeom.y-12*rackWallThickness),wallGeom.z+rackWallThickness*2])
        rotate([-100,0,0])
        linear_extrude(10*rackWallThickness,scale=0)
            polygon([[-rackWallThickness,0],[0,0],[0,5*rackWallThickness]]);
        
        // boden
        cube([totalWidth,trayHeight+wall,wall]);
}

module partBoxPositive() {
        translate([enlargement/2,enlargement/2,0])
    difference() {
        union() {
        // base
        translate([-enlargement/2,-enlargement/2,box.z-biggerbox.z])
        cube(biggerbox+[0,wall,0]);
        roundedSquare3(box.x,(box.y-window.y),cornerRounding*1.2,box.z);
        }
                // cylindricalCut
        topPart = box.y-compartmentWindow;
        cl = box.x - 6*wall;
        translate([(box.x-cl)/2,box.y,box.z-topPart/2-wall])
            rotate([0,90,0])
               cylinder(d=topPart, h=cl);
    }
}

module partBoxNegative() {
        translate([enlargement/2,enlargement/2,0])
        union() {
            // pocket
            translate([wall,wall,wall])
                    roundedSquare4(compartmentSide,compartmentWindow,cornerRounding,depth+wall+epsilon);

        // hinges
       translate(hingeCoords+[0,0,box.z]) {
            nhinge();
            mirror([1,0,0])
                translate([-box.x,0,0])
            nhinge();
       }
    translate(lockCoords + [-gap/2,-gap/2,box.z])
        rotate([45,0,0])
            cube((wall*1.1+gap)*[1,1,1]);
    }
}

module partBox() {
difference() {
        partBoxPositive();
        partBoxNegative();
    }
}

module betterTray(width,height) {
    rad = wall*4;
    railZ = box.z -railThickness;
    cols = floor((width - 2*railWidth) / (biggerbox.x-epsilon));
    rows = floor(height / (biggerbox.y-epsilon));
    echo("cols",cols,"rows",rows);
    effectiveArea = [cols*(biggerbox.x-epsilon),rows*(biggerbox.y-epsilon),railThickness];
    spacing = [(width- cols*(biggerbox.x-epsilon))/2, 
                               (height - rows*(biggerbox.y-epsilon))/2, railZ];
    
    difference() {
        union() {
            translate([width/4,0,spacing.z-railThickness])
                cube([width/2,spacing.y/2,railThickness+epsilon]);
            translate([spacing.x,spacing.y,0])
                    for (row=[0:rows-1])
                        for (col=[0:cols-1])
                            translate([(biggerbox.x-epsilon)*col,
                                                    (biggerbox.y-epsilon)*row,
                                                    0])
                            partBoxPositive();
                        
                    translate([0,0,box.z-railThickness-epsilon]) {
                        difference() {
                        roundedSquare3(width,height,rad,railThickness);
                            translate([spacing.x+wall,spacing.y+wall,-railThickness-epsilon])
                        roundedSquare3(effectiveArea.x-2*wall,effectiveArea.y-2*wall,rad/3,railThickness+2*epsilon);    
                        }
                    }
                }
    translate([spacing.x,spacing.y,0])
        for (row=[0:rows-1])
            for (col=[0:cols-1])
                translate([(biggerbox.x-epsilon)*col,
                                        (biggerbox.y-epsilon)*row,
                                        0])
                partBoxNegative();
    }
}

module evenBetterTray(width,height) {
    rad = wall*4;
    railZ = box.z -railThickness;
    cols = floor((width - 2*railWidth) / (biggerbox.x-epsilon));
    rows = floor(height / (biggerbox.y-epsilon));
    echo("cols",cols,"rows",rows);
    effectiveArea = [cols*(biggerbox.x-epsilon),rows*(biggerbox.y-epsilon),railThickness];
    spacing = [(width- cols*(biggerbox.x-epsilon))/2, 
                               (height - rows*(biggerbox.y-epsilon))/2, railZ];
    
    difference() {
        union() {
//            translate([width/4,railThickness/2,spacing.z])
//                rotate([0,90,0])
//                    cylinder(d=railThickness,h=width/2);
            // pull out handle
            handle = [width*0.15, compartmentSide,wall*2];
            
            translate([(width-handle.x)/2,epsilon-handle.y/2,box.z-handle.z])
            difference() {
                roundedSquare3(handle.x,handle.y,rad,handle.z);
                translate([wall*2,wall*2,-epsilon])
                roundedSquare3(handle.x-4*wall,handle.y-4*wall,rad*0.8,handle.z+2*epsilon);
                
            }
            
            translate([spacing.x-wall,spacing.y-wall,0])
                roundedSquare3(effectiveArea.x+2*wall,effectiveArea.y+2*wall,rad/2,box.z);
                        
                    translate([0,0,box.z-railThickness-epsilon]) {
                        difference() {
                        roundedSquare3(width,height,rad,railThickness);
                            translate([spacing.x+wall,spacing.y+wall,-railThickness-epsilon])
                        roundedSquare3(effectiveArea.x-2*wall,effectiveArea.y-2*wall,rad/3,railThickness+2*epsilon);    
                        }
                    }
                }
    translate([spacing.x,spacing.y,0])
        for (row=[0:rows-1])
            for (col=[0:cols-1])
                translate([(biggerbox.x-epsilon)*col,
                                        (biggerbox.y-epsilon)*row,
                                        0])
                partBoxNegative();
            
            textSize = effectiveArea.x/12;
            textLength = 11*textSize;
            textSpacing = [(effectiveArea.x - textLength)/2,
                                                   (effectiveArea.y - textSize)/2, 0];
            translate([spacing.x+textSpacing.x,spacing.y+textSpacing.y,wall/3])
            rotate([180,0,0])
            linear_extrude(wall/3+epsilon)
            text(font=font,size=textSize ,text="fully.automated.ee",$fn=26);
    }
}

module tray(width,height) {
    rad = wall*4;
    railZ = box.z -railThickness;
    cols = floor((width - 2*railWidth) / (biggerbox.x-epsilon));
    rows = floor(height / (biggerbox.y-epsilon));
    echo("cols",cols,"rows",rows);
    effectiveArea = [cols*(biggerbox.x-epsilon),rows*(biggerbox.y-epsilon),railThickness];
    spacing = [(width- cols*(biggerbox.x-epsilon))/2, 
                               (height - rows*(biggerbox.y-epsilon))/2, railZ];
    translate([spacing.x,spacing.y,0])
        boxen(rows,cols);

    translate([width/4,0,spacing.z-railThickness])
        cube([width/2,spacing.y/2,railThickness+epsilon]);
    difference() {
        translate([rad,rad,spacing.z]) { 
            minkowski() {
                cube([width-2*rad,height-2*rad,railThickness/2]);
                cylinder(r=rad,h=railThickness/2);
            }
        }
        union() {
            translate([spacing.x+epsilon,spacing.y+epsilon,spacing.z-epsilon])
                 cube([effectiveArea.x,effectiveArea.y,effectiveArea.z+2*epsilon]);
            
        }
    }
}

module funnel() {
    lowerDiam = compartmentSide+wall;
    upperDiam = 4*lowerDiam;
                 plugGeom = [compartmentSide-2*gap,
                                    compartmentWindow-2*gap];
                neckGeom = plugGeom + wall*[2,2];
    holeGeom = [plugGeom.x - wall*2, plugGeom.y/2-wall];
    intersection() {
    difference() {
        union() {
            // positive
            translate([0,0,4*wall-epsilon])
            cylinder(d1=lowerDiam,d2=upperDiam,h=funnelHeight-4*wall);

        translate(plugGeom/-2)
             roundedSquare3(plugGeom.x,plugGeom.y,cornerRounding,2*wall);
            translate([neckGeom.x/-2,neckGeom.y/-2,2*wall+epsilon])
                roundedSquare3(neckGeom.x,neckGeom.y,cornerRounding,2*wall);
            
        }
        union() {
            // negative 
            
            // cut for the lid
            translate([-box.x/2-wall*1.5,plugGeom.y/2,-epsilon])
                cube([box.x+3*wall,lidcoverThickness+2*wall+gap,box.y+gap+2*wall]);
            // cut off the unnecessary thin part of the funnel
            translate([-box.x,plugGeom.y/2,box.y*0.4])
                cube([box.x*2,box.x,box.y/2]);
            
                        translate([0,0,-epsilon]) {
                            translate([0,0,box.y+wall])
                            // upper cone
                            cylinder(d1=0,d2=upperDiam-8*wall,h=funnelHeight-box.y-wall+epsilon);
                        }

                            translate([holeGeom.x/-2,-holeGeom.y/2,-2*epsilon])
                //oval shaped cut
                       roundedSquare3(holeGeom.x,holeGeom.y,cornerRounding/2,funnelHeight);
                        
        }
    }
    cylinder(d=upperDiam-2*wall,h=funnelHeight+wall);
}
}

module boxen(rows,cols) {
    difference() {
    for (row=[0:rows-1])
        for (col=[0:cols-1])
            translate([(biggerbox.x-epsilon)*col,
                                        (biggerbox.y-epsilon)*row,
                                        0])
                partBoxPositive();
    
        for (row=[0:rows-1])
        for (col=[0:cols-1])
            translate([(biggerbox.x-epsilon)*col,
                                        (biggerbox.y-epsilon)*row,
                                        0])
                partBoxNegative();
    }
}
module nhinge(angle=95) {
    translate([wall+gap*0.4,0,0]) {
        sphere(pivotBall+gap*0.6);
        cylinder(d=pivotBall*1,h=wall+pivotBall);
    }
    hull() {
        hinge(true,$fn=16);
        rotate([-angle,0,0])
            hinge(true,$fn=16);
    }
}

module hinge(neg=false) {
    sg = gap * 0.4;
    cylRad = pivotBall + (neg?gap+0.5*wall:0.2*wall);
    armLength = compartmentSide*(neg?0.22:0.20);
    rr = wall*0.5 + (neg?0:0);
    net = neg?wall+2*gap:0;
    netTop = neg?gap:0;
    tn = wall  + net;
    top = 0.5*wall+lidcoverThickness+netTop;
    translate([wall,0,0])
        rotate([0,-90,0]) {
            if (!neg) sphere(pivotBall);
            translate([0,0,neg?-sg:0])
            hull() {
            cylinder(r=cylRad,h=tn);
            translate([wall,-armLength,0])
                cylinder(r=rr,h=tn);
            translate([top,-armLength,0])
                cylinder(r=rr,h=tn);
            translate([top,-armLength/2,0])
                cylinder(r=rr,h=tn);
            translate([top,0,0])
                cylinder(r=rr,h=tn);
//            if (neg) {
//            translate([-cylRad/2,-armLength/3,0])
//                cylinder(d=cylRad,h=tn);
//                }
            }
        }
}

module negativeCylinder(d,h) {
    difference() {
        translate([-epsilon,-d/2-epsilon,-epsilon])
            cube([d/2+2*epsilon,d/2+2*epsilon,h+2*epsilon]);
        translate([d/2,-d/2,0])
            cylinder(d=d,h=h);
    }
}

module lid() {
    plugHeight = 1.4*wall;
//    color("purple")
    difference() { 
        // base
        cube([box.x,box.y-window.y,lidcoverThickness]);
        
        // cut at opening 
        translate([-epsilon,0,-gap])
            rotate([0,90,0])
                cylinder(h=box.x+2*epsilon,r=wall);
    
    // cut close to the hinge
        translate([-epsilon,box.y-window.y,lidcoverThickness])
            rotate([0,90,0])
                negativeCylinder(h=box.x+2*epsilon,d=lidcoverThickness);
    }    
    plugGeom = [compartmentSide-2*gap,
                                    compartmentWindow-2*gap];
    translate([wall,wall,0]) {
        translate([gap,gap,-plugHeight])
            difference() {
             roundedSquare3(plugGeom.x,plugGeom.y,cornerRounding,plugHeight+epsilon);
                translate([wall*0.75,wall*0.75,-epsilon])
                    roundedSquare3(plugGeom.x-2*wall*0.75,plugGeom.y-wall*2*0.75,cornerRounding,plugHeight+2*epsilon);
        }
    }
    translate(lockCoords)
        rotate([45,0,0])
            intersection() {
                factor = 1.2;
                cube(wall*factor);
                rotate([45,0,0])
                    translate(sqrt(2)*wall*factor*[-1,0,-0.15])
                        cube(sqrt(2)*wall*factor*[3,1,1]);
            }
    
    // pivot balls
   translate(hingeCoords) {
            hinge();
        mirror([1,0,0])
    translate([-box.x,0,0])
            hinge();
   }
}