/* [Fields] */
fieldLength = 20; // Inner field size in X direction
fieldWidth = 20; // Inner field size in Y direction
fieldCountX = 6; // Number of field in X direction
fieldCountY = 4; // Number of field in Y direction

/* [Sizes] */
wallThickness = 2; // Thickness of wall between fields
palletteHeight = 2; // Total height of pallette
fieldHoleHeight = 1.4; // Height of field hole
innerRadius = 2; // Field inner radius

/* [Labels] */
withLabels = false; // Display labels or not
labelWidth = 10; // Size of label in Y direction
labelRecess = 0.4; // Height of label hole, set to 0 if you don't want recessed labels

/* [Hidden] */
$fs = 0.15;
fix = 1;

pallett();

module pallett() {
    for (x = [0:fieldCountX-1], y = [0:fieldCountY-1]) {
        if (withLabels) {
            yMove = (y) * (labelWidth+wallThickness);

            translate([0,yMove,0]) palletteField(x, y);
            labelField(x, y);
        } else {
            palletteField(x, y);
        }
    }
    border();
}

module palletteField(x, y) {
    size = [fieldLength, fieldWidth, palletteHeight];

    field(x, y, size, fieldHoleHeight);
}

module labelField(x, y) {
    size = [fieldLength, labelWidth, palletteHeight];
    yMove = (y+1) * (fieldWidth+wallThickness) + y * (labelWidth) - y * (fieldWidth);

    translate([0,yMove,0]) field(x, y, size, labelRecess);
}

module field(x, y, fieldSize, recess) {
    bottomHeight = palletteHeight - recess;
    fieldSizeWithWall = [
        fieldSize[0] + 2*wallThickness,
        fieldSize[1] + 2*wallThickness,
        palletteHeight
    ];

    translate([x*(fieldLength+wallThickness), y*(fieldWidth+wallThickness), 0])
    difference() {
        roundedcube(fieldSizeWithWall, innerRadius + wallThickness/2);
        translate([wallThickness, wallThickness, bottomHeight]) roundedcube(fieldSize, innerRadius);
    }
}

module border() {
    xSize = fieldCountX * (fieldLength + wallThickness) - wallThickness*3;
    ySize = fieldCountY * (fieldWidth + wallThickness)  + (withLabels ? fieldCountY*(labelWidth+wallThickness) : 0) - wallThickness*3;
    xMove = fieldCountX * (fieldLength + wallThickness);
    yMove = fieldCountY * (fieldWidth + wallThickness) + (withLabels ? fieldCountY*(labelWidth+wallThickness) : 0);

    translate([wallThickness*2,0,0]) cube([xSize, wallThickness, palletteHeight]);
    translate([wallThickness*2,yMove,0]) cube([xSize, wallThickness, palletteHeight]);
    translate([0,wallThickness*2,0]) cube([wallThickness, ySize, palletteHeight]);
    translate([xMove,wallThickness*2,0]) cube([wallThickness, ySize, palletteHeight]);
}

// Rounded cube
module roundedcube(size, radius = 0) {

    if (radius <= 0) {
        cube(size);
    } else {
        // If single value, convert to [x, y, z] vector
        size = (size[0] == undef) ? [size, size, size] : size;
        height = size[2];
        translatePos = [
            [radius, radius, 0],
            [size[0] - radius, radius, 0],
            [radius, size[1] - radius, 0],
            [size[0] - radius, size[1] - radius, 0],
        ];
        
        hull() {
            for (pos = translatePos) translate(pos) {
                cylinder(h=height, r=radius);
            }
        }
    }
}