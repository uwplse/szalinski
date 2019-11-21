// Show parts
part = 0; // [0:All opened, 1:Base, 2:Lid, 3:Closed]

/* [Box dimensions] */

// Outer box width
boxWidth = 150;

// Outer box depth
boxDepth = 60;

// Outer total box height
boxHeight = 40;

// Lid height
lidHeight = 10; // [6:100]

// Radius for rounded corners
corner = 5; // [1:40]


/* [Box setup] */
// Separators direction
sepDir = 0; // [0:1xN, 1:Nx1]

// Number of separators
numSeparators = 5; // [1:20]

// Width of main container
mainSep = 25; // [1:200]

// Include separators on lid to avoid movements when closed
separatorsLid = 1; // [0:No, 1:Yes]

// Outer wall thickness
wallThickness = 1.4;

// Tolerance
tolerance = 0.2;


/* [Text] */
// Font (use font names from Google Fonts)
font="Arial"; 
textFont = font != "" ? font : "Arial";

// Text on base (empty to remove)
textBase = "Here";

// Base text size
textBaseSize = 15; // [3:50]

// Text on lid (empty to remove)
textLid = "Your Text";

// Lid text size
textLidSize = 20; // [3:50]

/* [Internal text on lid] */

// Internal text size
textContainerSize = 4; // [0:20]

// Text1
_text1 = "AAA";

// Text2
_text2 = "BBB";

// Text3
_text3 = "CCC";

// Text4
_text4 = "DDD";

// Text5
_text5 = "EEE";

// Text6
_text6 = "FFF";

// Text7
_text7 = "GGG";

// Text8
_text8 = "HHH";

// Text9
_text9 = "III";

// Text10
_text10 = "JJJ";

// Text11
_text11 = "KKK";

// Text12
_text12 = "LLL";

textCompartment = concat(_text1, _text2, _text3, _text4, _text5, _text6, _text7, _text8, _text9, _text10, _text11, _text12);


/* [Hinge configuration] */
// Hinge Radius
hingeRad=3;

// Hinge Length
hingeLength=10; // [5:50]

// Hinge barrette radius
hingeBar=1.2;

// Hinge separation from box body
hingeSep=2; // [0:5]

/* [Hidden] */
wt = wallThickness;
m=2+corner;
hingeTolerance=0.5;
sep = hingeSep;
$fn=60;

il=3;
iw=wt/2-tolerance;
internalWall = 1;

print_part();

module print_part() {
    if (part == 0) {
        print_both();
    }
    else if (part == 1) {
        print_base();
    }
    else if (part == 2) {
        print_lid();
    }
    else if (part == 3) {
        print_closed();
    }
    else {
        print_both();
    }
}


module print_both() {
    boxBase();
    translate([0, boxDepth/2+lidHeight+sep+hingeRad, (boxHeight-lidHeight)+boxDepth/2+sep+hingeRad]) rotate(a=[90, 0, 0]) boxLid();
}

module print_base() {
    boxBase();
}

module print_lid() {
    boxLid();
}

module print_closed() {
    boxBase();
    %translate([0, 0, boxHeight]) rotate(a=[180, 0, 0]) boxLid();
}


module separatorsBase() {
    translate([-boxWidth/2+wt, -boxDepth/2+wt, 0])
    buildSeparators(boxHeight-lidHeight+il-wt);
}

module separatorsLid() {
    rotate([0, 0, sepDir == 0 ? 180 : 0]) translate([-boxWidth/2+wt, -boxDepth/2+wt, 0]) 
    buildSeparators(lidHeight-il-wt);
}

module buildSeparators(height) {
    mainWidth = sepDir == 0 ? boxWidth - 2*wt : internalWall;
    mainDepth = sepDir == 0 ? internalWall : boxDepth - 2*wt;
   
    secWidth = sepDir == 0 ? internalWall : boxWidth - mainSep - internalWall - 2*wt;
    secDepth = sepDir == 0 ? boxDepth - 2*wt - mainSep - internalWall : internalWall;
    
    mainPosX = sepDir == 0 ? 0 : mainSep;
    mainPosY = sepDir == 0 ? secDepth : 0;
    
    secPosX = sepDir == 0 ? 0 : mainSep + internalWall;
    secPosY = sepDir == 0 ? 0 : 0;
    
    diffX = sepDir == 0 ? (boxWidth - 2*wt) / numSeparators : 0;
    diffY = sepDir == 0 ? 0 : (boxDepth - 2*wt) / numSeparators;
    
    translate([mainPosX, mainPosY, wt]) linear_extrude(height=height) square([mainWidth, mainDepth]);
    
    for (a = [1 : numSeparators-1]) {
        translate([secPosX + a * diffX, secPosY + a * diffY, wt]) linear_extrude(height=height) square([secWidth, secDepth]);
    }

}

module compartmentText () {
    mainWidth = sepDir == 0 ? boxWidth - 2*wt : mainSep;
    mainDepth = sepDir == 0 ? mainSep : boxDepth - 2*wt;
   
    secWidth = sepDir == 0 ? 0 : boxWidth - mainSep - internalWall - 2*wt;
    secDepth = sepDir == 0 ? boxDepth - 2*wt - mainSep - internalWall : 0;
    
    mainPosX = sepDir == 0 ? 0 : mainSep;
    mainPosY = sepDir == 0 ? secDepth : 0;
    
    secPosX = sepDir == 0 ? 0 : mainSep + wt + internalWall;
    secPosY = sepDir == 0 ? mainSep : wt;
    
    diffX = sepDir == 0 ? (boxWidth - 2*wt) / numSeparators : 0;
    diffY = sepDir == 0 ? 0 : (boxDepth - 2*wt) / numSeparators;
    
    translate([-boxWidth/2, -boxDepth/2, 0]) {    
        translate([mainWidth/2, mainDepth/2, wt]) linear_extrude(height=1) text(textCompartment[0], valign="center", halign="center", size=textContainerSize, font=textFont);
    
    
    
    for (a = [1 : len(textCompartment)-1]) {
        if (a < numSeparators+1) 
            translate([secPosX + secWidth/2 + diffX/2 + diffX * (a-1), secPosY + secDepth/2 + diffY/2 + diffY * (a-1), wt]) linear_extrude(height=1) text(textCompartment[a], valign="center", halign="center", size=textContainerSize, font=textFont);
    }
    }
}



module boxBase() {
    difference(){
        union(){
            
            roundedCube(boxWidth, boxDepth, boxHeight-lidHeight, corner);
            hingeLow(hingeRad, hingeLength);
            translate([0, 0, boxHeight-lidHeight]) roundedCube(boxWidth-2*(wt-iw), boxDepth-2*(wt-iw), il, corner);
        }

        translate([0, -boxDepth/2-1, boxHeight-lidHeight-5]) closeInsert();
        translate([0, 0, wt]) roundedCube(boxWidth-2*wt, boxDepth-2*wt, boxHeight+il, corner);
        translate([0, -boxDepth/2+0.5, (boxHeight-lidHeight)/2]) rotate(a=[90, 0, 0]) linear_extrude(height=2) text(textBase, valign="center", halign="center", font=textFont, size=textBaseSize);
        }
        separatorsBase();
}

module boxLid() {
    closeTab();
    difference() {
        union () {
            roundedCube(boxWidth, boxDepth, lidHeight, corner);
            hingeUp(hingeRad, hingeLength);
        }
            
        translate([0, 0, lidHeight-il]) roundedCube(boxWidth-2*iw, boxDepth-2*iw, il+1, corner);
        translate([0, 0, wt]) roundedCube(boxWidth-2*wt, boxDepth-2*wt, boxHeight, corner);
        translate([0, 0, 0.5]) rotate(a=[180, 0, 0]) linear_extrude(height=2) text(textLid, valign="center", halign="center", font=textFont, size=textLidSize);
    }
    if (separatorsLid == 1) separatorsLid();
    compartmentText();
}

module closeTab() {
    translate([-5, boxDepth/2+1, lidHeight-5]) {
    rotate(a=[180, 0, 0]) rotate(a=[0, 90, 0]) linear_extrude(height=10) polygon(points=[[10, 0], [8, 2], [8, 1], [-1, 1], [0, 0]]);
    }
}

module closeInsert() {
    translate([-15/2, 0, 0.5])
    cube([15, 3, 2]);
}


module hingeUp(hingeRad, hingeLength) {
    rotate(a=[0, 0, 180])
    translate([-boxWidth/2, boxDepth/2, lidHeight])
    rotate(a=[0, 90, 0])
    difference() {
        union() {
        
        if ((hingeLength+hingeTolerance)*6+2*m<boxWidth) {
            translate([0, 0, m+hingeLength+hingeTolerance]) hingeSupport(hingeRad, hingeLength);
            translate([0, 0, boxWidth-2*hingeLength-hingeTolerance-m]) hingeSupport(hingeRad, hingeLength);
            }
        else {
            translate([0, 0, m+hingeLength+hingeTolerance]) hingeSupport(hingeRad, boxWidth-2*m-2*hingeLength-2);
        }
    }
        translate([0, sep+hingeRad, -1]) cylinder(r=hingeBar, h=boxWidth+2);
    }
}

module hingeLow(hingeRad, hingeLength) {
    translate([-boxWidth/2, boxDepth/2, boxHeight-lidHeight])
    rotate(a=[0, 90, 0])
    difference() {
        union() {
        translate([0, 0, m]) hingeSupport(hingeRad, hingeLength);
        if ((hingeLength+hingeTolerance)*6+2*m<boxWidth) {
            translate([0, 0, hingeLength*2+2*hingeTolerance+m]) hingeSupport(hingeRad, hingeLength);
            translate([0, 0, boxWidth-hingeLength*3-2*hingeTolerance-m]) hingeSupport(hingeRad, hingeLength);
        }
        translate([0, 0, boxWidth-hingeLength-m]) hingeSupport(hingeRad, hingeLength);
        }
        translate([0, sep+hingeRad, -1]) cylinder(r=hingeBar, h=boxWidth+2);
    }
}

module hingeSupport(hingeRad, hingeLength) {
    translate([0, sep+hingeRad, 0]) {
        cylinder(r=hingeRad, h=hingeLength);
        difference() {
translate([0, -(hingeRad+sep), 0]) cube([2*hingeRad+sep, sep+hingeRad, hingeLength]);

translate([hingeRad*2+sep, 0, -1]) cylinder(r=hingeRad+sep, h=hingeLength+2);
}
    }
}


module roundedCube (w, d, h, r) {
    hull() {
        translate([-w/2+r, -d/2+r, 0]) cylinder(r=r, h=h);
        translate([-w/2+r, d/2-r, 0]) cylinder(r=r, h=h);    
        translate([w/2-r, -d/2+r, 0]) cylinder(r=r, h=h);
        translate([w/2-r, d/2-r, 0]) cylinder(r=r, h=h);
    }
}
