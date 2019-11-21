tWidth = 70;                // Total width of box.
tLength = 100;              // Length of box plus front.
lipHeight = 15;             // Height of lip at front, no taller than tHeight.
tHeight = 35;               // Total height of box.
wallThickness = 0.8;        // Thickness of walls, 0.8mm (two shells) recommended.
columnThickness = 3;        // Thicker support columns helps when walls are thin, no smaller than wallThickness.
lipThickness = 5;           // Depth of lip arond the brim of the box, helps when walls are thin, best to keep above columnThickness.
baseThickness = 1;        // Thickness of the base of the bin.

module back (width, height, cThick, wThick, lThick){
    cube([width,wThick,height]);
    translate([cThick*-1,0,0])
        cube([cThick,cThick,height]);
    translate([width,0,0])
        cube([cThick,cThick,height]);
    union() {
        difference() {
            translate([lThick*-1,0,height-(cThick*3/4)])
                rotate([270,90,270])
                    linear_extrude(height = width + (lThick*2))
                        polygon(points=[[0,0],[lThick,0],[0,lThick]]);
            cCut(tHeight, lipThickness, columnThickness, 0, (lThick+0.01)*-1, -0.1);
            cCut(tHeight, lipThickness, columnThickness, 180, width+lThick+0.01, lThick);
        }
        translate([lThick*-1,0,height-(cThick*3/4)])
            cube([width + (lThick*2),lThick,(cThick*3/4)]);
    }
}

module left (length, height, lHeight, cThick, wThick, lThick){
    translate([wThick*-1,length*-1,0])
        cube([wThick,length,height]);
    translate([cThick*-1,length*-1,0])
        cube([cThick,cThick,height]);
    union() {
        difference() {
            translate([0,(length*-1),height-(cThick*3/4)])
                rotate([270,90,0])
                    linear_extrude(height = length + lThick)
                        polygon(points=[[0,0],[lThick,0],[0,lThick]]);
            cCut(tHeight, lipThickness, columnThickness, 270, (lThick+0.2)*-1, (lThick+0.01));
        }
        translate([lThick*-1,(length*-1),height-(cThick*3/4)])
            cube([lThick,length + lThick,(cThick*3/4)]);
    }
    rotate([0,270,0])
        linear_extrude(height = wThick)
            polygon(points=[[0,length*-1],[height,length*-1],[lHeight,(length + lHeight)*-1]]);
}

module right (length, height, width, lHeight, cThick, wThick, lThick){
    translate([width,length*-1,0])
        cube([wThick,length,height]);
    translate([width,length*-1,0])
        cube([cThick,cThick,height]);
    union() {
        difference() {
            translate([width,lThick,height-(cThick*3/4)])
                rotate([270,90,180])
                    linear_extrude(height = length + lThick)
                        polygon(points=[[0,0],[lThick,0],[0,lThick]]);
            cCut(tHeight, lipThickness, columnThickness, 270, width-0.01, (lThick+0.01));
        }
        translate([width,(length)*-1,height-(cThick*3/4)])
            cube([lThick,length + lThick,(cThick*3/4)]);
    }
    translate([width+wThick,0,0])
        rotate([0,270,0])
            linear_extrude(height = wThick)
                polygon(points=[[0,length*-1],[height,length*-1],[lHeight,(length + lHeight)*-1]]);
}

module bottom (length, height, width, lHeight, lThick, bThick, wThick){
    translate([0,length*-1,0])
        cube([width, length, bThick]);
    translate([width,0,0])
        rotate([0,270,0])
            linear_extrude(height = width)
                polygon(points=[[0,length*-1],[bThick,length*-1],[lHeight+bThick,(lHeight+length)*-1],[lHeight,(lHeight+length)*-1]]);
    translate([width+wThick,0,0])
        rotate([0,270,0])
            linear_extrude(height = width+(wThick*2))
                polygon(points=[[lHeight,(lHeight+length)*-1],[lHeight+bThick,(lHeight+length)*-1],[lHeight+bThick,((lHeight+length)*-1)+lThick],   [lHeight-lThick,(lHeight+length-lThick)*-1]]);
}

module cCut (height, lThick, cThick, zRot, xTrans, yTrans){
    translate([xTrans,yTrans,height-(lThick+cThick*3/4)])
            rotate([270,270,zRot])
                linear_extrude(height = lThick+1)
                    polygon(points=[[0,0],[lThick,0],[0,lThick]]);
}

back(tWidth, tHeight, columnThickness, wallThickness, lipThickness);
left(tLength, tHeight, lipHeight, columnThickness, wallThickness, lipThickness);
right(tLength, tHeight, tWidth, lipHeight, columnThickness, wallThickness, lipThickness);
bottom(tLength, tHeight, tWidth, lipHeight, lipThickness, baseThickness, wallThickness);