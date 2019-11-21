/* [Global] */
// Rows of paint wells for the tray
rows = 2;
// Paint wells in each row
wellsPerRow = 5;
// Wall width of paint well exterior
wellWidth = 18;
// Wall length of paint well exterior
wellLength = 25;
// Wall height of paint well exterior
wellHeight = 12;
// Wall thickness of paint well interior
wellThickness = 2;
// Thickness of border between rows and around tray edge
borderThickness = 3;

module paintwell(width,length,height,thickness) {
    // 45 degree right triangle
    polyhedron(points = [
        [thickness,length/2 - thickness,thickness], //0
        [thickness,length - thickness,thickness], //1
        [thickness,length - thickness,height], //2
        [width - thickness,length/2 - thickness,thickness], //3
        [width - thickness,length - thickness,thickness], //4
        [width - thickness,length - thickness,height] //5
    ], faces = [
        [0,3,4,1], //bottom
        [2,5,3,0], //front
        [5,2,1,4], //back
        [5,4,3], //right
        [1,2,0] //left
    ], convexity = 10);

    difference() {
        cube([width, length, height]);

        translate([thickness,thickness,thickness])
            cube([width-thickness*2,length-thickness*2,height]);
    }
}

module trayBorder(width,length,height,thickness,rows,columns) {
    cube([width*columns,thickness,height]);
    translate([-thickness,0,0])
        cube([thickness,length*rows + thickness,height]);
    translate([width*columns,0,0])
        cube([thickness,length*rows + thickness,height]);
}

module paintTray(rows=2, wellsPerRow=5, wellWidth=18, wellLength=25, wellHeight=12, wellThickness=2, borderThickness=3) {
    trayBorder(wellWidth,wellLength,wellHeight,borderThickness,rows,wellsPerRow);

    for(i = [1:rows], j = [1:wellsPerRow]) {
        if(i % 2 == 1) { // odd
            translate([wellWidth*(j-1),wellLength*(i-1)+borderThickness,0]) {
                paintwell(width = wellWidth,length = wellLength,height = wellHeight,thickness = wellThickness);
            }
            translate([wellWidth*(j-1),wellLength*(i)+wellThickness,0])
                cube([wellWidth,borderThickness,wellHeight]);
        } else {
            translate([wellWidth*(j),wellLength*i+borderThickness,0]) rotate([0,0,180]) {
                paintwell(width = wellWidth,length = wellLength,height = wellHeight,thickness = wellThickness);
                cube([wellWidth,borderThickness,wellHeight]);
            }
        }
    }
}

paintTray(rows,wellsPerRow,wellWidth,wellLength,wellHeight,wellThickness,borderThickness);
