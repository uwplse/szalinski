// A Case for a raspberry pi and a display shield. Used for the quimat 3.5" display. 
// Highly customizable, may also work with other displays. 
// No connection holes, just a hole for cables. This has been used for a controller for a 3d-printer.
// Created by Simon Klein (https://www.thingiverse.com/kleinsimon/)

//Parts to display. enable one for printing

topEnable = 1;
bottomEnable = 1;
holderEnable = 1;
holderBoth = 1;

//Dimension of the pi
piXL = 85;
piYL = 56;

//location of the screw holes for raspberry
holes = [[81.5,3.5],[23.5,3.5],[81.5,52.5],[23.5,52.5]];

sdY = 28;
sdW = 14;
sdH = 10;

//Dimension of the display board
dispXL = 85;
dispYL = 70;
dispHeight = 26;

//Visible area of the display
dispFovX = 75;
dispFovY = 51.5;

//Offset between Raspberry board and visible area of display
dispFovXOffset = 1;
dispFovYOffset = 1;

//Additional space in the case
addSpaceLeft = 15;
addSpaceRight = 3;
addSpaceTop = 18;
addSpaceBottom = 3;

//Text on the top
textEnable=true;
topText = "RasPi   Case ";
topTextDepth=0.8;

//Logo
logoEnable=true;
logoFile ="pi.stl";
logoW = 7.8;
logoH = 10;

//Hole for cables
cableWidth=20;
cableHeight=10;

//Fixture for the raspberry. If fixouter is true, shafts are inserted in the screw holes, so the pi might just be pushed on them.
fixOuter = true;
fixDia=2.7;
fixDia2=6.2;
fixHeight=4;
fixHeight2=4;

//Print a holder for a toch pen. Size and position can be customized
penEnable = true;
penDia = 6;
penWall = 1;
penOpen = 12;
penPos = 0; //0: Horiz, 1: Vert
penMirrorX = 0;
penMirrorY = 1;

//general wall thickness 
wall = 2;
//Step size between the case parts
wallDiff = 1.5;
wallDiffSpace=0.4;
//Distance between the notches at the rim to keep the case parts in line
wallRimMinSpace = 35;

//Screw holes on the top part
connHole = 4;
connHead = 8;
//Screw guiadnce on the lower part
connHoleBig = 5;
connDist = connHead/2-wall/2;

//Create holes and wedges for top side fixture of case
holderWidth = 20;
holderHeight = 40;
holderDist = 8;
holderDepth = 11;
holderZOffset = 3;
holderHolesDia = 4;
holderHolesDist = 20;
holderScrewRadius = 8;
holderScrewAngle = 90;
holderScrewDia = 3.5;
holderScrewBorder = 4;
holderNutWidth=6;
holderNutHeight=3;
holderPinHeight=2;
holderPinDia = 5;
holderWall = 4;



//////////////////////////////////////////////////////////
// Calculated sizes)

baseWidth = max(piXL,dispXL) + addSpaceLeft + addSpaceRight;
baseHeight = max(piYL,dispYL) + addSpaceTop + addSpaceBottom;
baseDepth = 15;
topDepth = dispHeight - baseDepth + fixHeight;

// Quality of round faces
$fa = 3;
$fs = 0.5;

// Distance to overlap differences
dx = 1e-2;

if (bottomEnable)
    bottom();
if (topEnable)
    top();
if (holderEnable) {
    ifMirrorAxis(holderBoth, [1,0,0], true)
        holder();
}

module holder(){
    color("Green")
    translate([-baseWidth/2-wall-holderWall,baseHeight/2-holderDepth+holderDist,-baseDepth/2+holderZOffset])
    union() {
        holderWedge();
        holderFix();
    }
}

module holderFix(){
    translate([0,holderDepth,-holderHeight/2])
        difference() {
            cube([holderWidth,holderWall,holderHeight]);
            translate([holderWidth/2,0,holderHeight/2-holderHolesDist/2])
                rotate([90,0,0])
                    cylinder(d=holderHolesDia,h=3*holderWall,center=true);
            translate([holderWidth/2,0,holderHeight/2+holderHolesDist/2])
                rotate([90,0,0])
                    cylinder(d=holderHolesDia,h=3*holderWall,center=true);
        }
}

module holderWedge(){
    rotate([-90,0,-90])
    difference() {
        union() {
            linear_extrude(height=holderWall)
                polygon([[0,-holderScrewBorder],[0,holderScrewBorder],[-holderDepth,holderHeight/2],[-holderDepth,-holderHeight/2]]);
            hull() {
                rotate([0,0,-(holderScrewAngle+15)/2])
                    rotate_extrude(angle=holderScrewAngle+15)
                        translate([holderScrewRadius+holderScrewBorder-holderScrewDia/2,0])
                            square(holderScrewDia,2*holderWall);
                cylinder(h=holderWall,d=holderScrewBorder*2);
            }
            cylinder(h=holderWall+holderPinHeight, d=holderPinDia);
        }
        
        translate([0,0,-1])
        rotate([0,0,-holderScrewAngle/2])
            rotate_extrude(angle=holderScrewAngle)
                translate([holderScrewRadius-holderScrewDia/2,0])
                    square([holderScrewDia,holderWall*2]);
    }
}

module top() {
    color("Orange",0.8)
    difference() {
        union() {
            caseTop();
            penShaft();
            connTop();
        }
        fov();
        if (penEnable)
            penHole();
        if (logoEnable)
            #logo();
        if (textEnable)
            topTextCut();
    }
}

module logo() {
    translate([0,baseHeight/2-addSpaceTop/2,topDepth+wall+dx])
        resize([logoW,logoH,topTextDepth])
            import(logoFile, center=true, convexity=0);
}

module topTextCut() {
    translate([0,baseHeight/2-addSpaceTop/2,topDepth+wall-topTextDepth])
        linear_extrude(height=wall)
            text(topText,halign="center", valign="center");
}

module bottom() {
    difference() {
        union() {
            base();
            mount();
            connBottom();
            ifMirrorAxis(true, [0,1,0], true)
                translate([-baseWidth/2,-baseHeight/2,0])
                    addRimHolders(wall/2,0,baseWidth);
            ifMirrorAxis(true, [1,0,0], true)
                translate([baseWidth/2,-baseHeight/2,0])
                    rotate([0,0,90])
                        addRimHolders(wall/2,0,baseHeight);
            if (holderEnable){
                ifMirrorAxis(true, [1,0,0], true)
                    translate([-baseWidth/2,baseHeight/2-holderDepth+holderDist-holderScrewRadius,-baseDepth])
                        holderScrewBlock();
            }
        }
        sdSlot();
        cableHole();
        connBottomHoles();
        if (holderEnable) {
            ifMirrorAxis(true, [1,0,0], true)
                translate([-baseWidth/2-wall-holderWall,baseHeight/2-holderDepth+holderDist,-baseDepth/2+holderZOffset])
                    holderHole();
        }
    }
}

module addRimHolders(X, Y, Length) {
    n = floor(Length/wallRimMinSpace);
    l = n*wallRimMinSpace;
    translate([(Length-l)/2,0,wallDiff])
    for (i=[0:n]) {
        rimHolder(X+i*wallRimMinSpace,Y);
    }
}


module rimHolder(X,Y) {
    translate([X,Y,0])
        rotate([0,-90,0])
            linear_extrude(height=wall)
                polygon([[0,0],[0,wall-wallDiffSpace],[-wallDiff,wall-wallDiffSpace],[-3*wallDiff,0],[-wallDiff,0]]);
}

module holderHole() {
    translate([wall-1e-2,0,0]) {
        rotate([-90,0,-90])
            cylinder(h=wall*2.5, d=holderPinDia*1.2);
    translate([0,-holderScrewRadius,0])
        rotate([-90,0,-90])
            cylinder(h=30, d=holderScrewDia);
    }
}

module holderScrewBlock() {
    h=baseDepth/2+holderNutWidth*sqrt(3)/2;
    translate([holderNutHeight,0,h/2])
    difference() {
        cube([holderNutHeight*2,holderNutWidth*2,h], center=true);
        translate([0,0,baseDepth/2+holderZOffset-holderNutWidth*sqrt(3)/4])
            cube([holderNutHeight,holderNutWidth,baseDepth], center=true);
    }
}

module connTop() {
    translate([0,0,topDepth/2]) {
        connFix(-baseWidth/2+connDist,-baseHeight/2+connDist);
        connFix(+baseWidth/2-connDist,-baseHeight/2+connDist);
        connFix(+baseWidth/2-connDist,+baseHeight/2-connDist);
        connFix(-baseWidth/2+connDist,+baseHeight/2-connDist);
    }
}

module connBottom() {
    translate([-baseWidth/2,-baseHeight/2,-baseDepth/2]) {
        connContra(connDist,connDist);
        connContra(baseWidth-connDist,connDist);
        connContra(baseWidth-connDist,baseHeight-connDist);
        connContra(connDist,baseHeight-connDist);
    }
}

module connBottomHoles() {
    translate([-baseWidth/2,-baseHeight/2,-baseDepth/2-wall-1e-2]) {
        connContraHole(connDist,connDist);
        connContraHole(baseWidth-connDist,connDist);
        connContraHole(baseWidth-connDist,baseHeight-connDist);
        connContraHole(connDist,baseHeight-connDist);
    }
}

module connFix(X,Y) {
    translate([X,Y,0])
    difference() {
        cylinder(d=connHead, h=topDepth, center=true);
        cylinder(d=connHole, h=2*topDepth, center=true);
    }
}

module connContra(X,Y) {
    translate([X,Y,0])
    difference() {
        cylinder(d=connHead+wall, h=baseDepth, center=true);
    }
}

module connContraHole(X,Y) {
    translate([X,Y,0])
    union() {
        cylinder(d=connHead, h=baseDepth, center=true);
        cylinder(d=connHoleBig, h=2*baseDepth, center=true);
    }
}

module penShaft() {
    ifMirrorAxis(penMirrorX, [1,0,0]) 
    ifMirrorAxis(penMirrorY, [0,1,0]) 
    translate([0,0,topDepth-(penDia+2*penWall)/2+wall/2])
    if (penPos==0) {
        penShaftGen(baseWidth+wall,baseHeight,-90);
    }
    else
    {
        penShaftGen(baseHeight+wall,baseWidth,0);
    }

}

module penShaftGen(L,X,R) {
    rotate([-90,0,R])
        translate([-X/2+(penDia+2*penWall)/2,0,0])
            cube([penDia+2*penWall,penDia+2*penWall,L],center=true);
}

module penHole() {
    ifMirrorAxis(penMirrorX, [1,0,0]) 
    ifMirrorAxis(penMirrorY, [0,1,0]) 
    if (penPos==0) {
        penHoleGen(baseWidth,baseHeight,-90);
    }
    else
    {
        penHoleGen(baseHeight,baseWidth,0);
    }
    
}

module penHoleGen(L,X,R) {
    rotate([-90,0,R])
        translate([-X/2+(penDia+2*penWall)/2,-topDepth+(penDia+2*penWall)/2-wall/2,wall])
            union(){
                cylinder(d=penDia, h=L+1,center=true);
                translate([-penDia,0,dx+L/2-penOpen/2])
                    cube([penOpen,penDia,penDia*2],center=true);
            }
}

module ifMirrorAxis(doMirror, Axis, duplicate=false) {
    if(doMirror) {
        mirror(Axis) 
            children();
    }
    if (!doMirror || duplicate) {
        children();
    }
}

module caseTop() {
    translate([-baseWidth/2,-baseHeight/2,0])
        difference() {
            union() {
                hull() {
                    translate([0,0,topDepth])
                        linear_extrude(height=wall)
                            square([baseWidth,baseHeight]);
                    translate([0,0,wallDiff])
                        linear_extrude(height=topDepth-wallDiff)
                            offset(r=wall)
                                square([baseWidth,baseHeight]);
                }
                translate([0,0,0])
                    linear_extrude(height=wallDiff)
                        offset(r=wall/2-wallDiffSpace/2)
                            square([baseWidth,baseHeight]);
            }
            translate([0,0,-dx])
                linear_extrude(height=topDepth+dx)
                    square([baseWidth,baseHeight]);
        }
}

module cableHole() {
    translate([0,baseHeight/2,-baseDepth+cableHeight/2])
        cube([cableWidth,wall*3,cableHeight],center=true);
}

module fov() {
    translate([baseWidth/2-piXL-addSpaceRight+dispFovXOffset,baseHeight/2-piYL-addSpaceTop+dispFovYOffset,topDepth-5])
        cube([dispFovX,dispFovY,10]);
}

module base() {
    translate([-baseWidth/2,-baseHeight/2,-baseDepth-wall])
        difference() {
            linear_extrude(height=baseDepth+wall+wallDiff)
                offset(r=wall)
                    square([baseWidth,baseHeight]);
            translate([0,0,wall+1e-2])
            linear_extrude(height=baseDepth+wallDiff)
                square([baseWidth,baseHeight]);
            translate([0,0,baseDepth+wall+1e-2])
                linear_extrude(height=wallDiff+2e-2)
                    offset(r=wall/2+wallDiffSpace/2)
                        square([baseWidth,baseHeight]);
        }
}

module sdSlot() {
    translate([baseWidth/2,baseHeight/2-addSpaceTop-sdY,-baseDepth])
        cube([wall*3,sdW,sdH],center=true);
}

module mount() {
    translate([-baseWidth/2,-baseHeight/2,-baseDepth])
    for (pos = holes) {
        fix(addSpaceLeft + pos[0], baseHeight - pos[1] - addSpaceTop);
    }
}


module fix(X,Y) {
    translate([X,Y,0])
    if (fixOuter) {
        union() {
            cylinder(d=fixDia2, h=fixHeight, center=false); 
            cylinder(d=fixDia, h=fixHeight2+fixHeight, center=false); 
        }
    }
    else {
        difference() {
            cylinder(d=fixDia2, h=fixHeight, center=false); 
            cylinder(d=fixDia, h=fixHeight2+fixHeight, center=false); 
        }
    }
}