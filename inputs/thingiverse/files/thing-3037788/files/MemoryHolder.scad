rows = 6;
columns = 1;
wallThickness = 5;
cornerRadius = 3;
slotWidth = 7.1;
slotLength = 133.5;
holderHeight = 20;

$fn = 100;

module drawBase(width, length, height) {
    translate([0, 0, height / 2])
    union() {
        minkowski() {
            cube([width - cornerRadius * 2, length - cornerRadius * 2, height - cornerRadius * 2], center=true);
            sphere(cornerRadius);
        }
        translate([0, 0, -height / 2 + cornerRadius / 2])
        minkowski() {
            cube([width - cornerRadius * 2, length - cornerRadius * 2, cornerRadius], center=true);
            cylinder(cornerRadius, cornerRadius);
        }
    }
}

module drawHolder(rows, columns, wallThickness, cornerRadius, slotWidth, slotLength, holderHeight) {
    cutWidth = rows * (slotWidth + wallThickness) - wallThickness;
    cutLength = columns * (slotLength + wallThickness) - wallThickness;
    cutHeight = holderHeight - wallThickness;
    
    baseWidth = rows * (slotWidth + wallThickness) + wallThickness;
    baseLength = columns * (slotLength + wallThickness) + wallThickness;

    difference() {
        drawBase(baseWidth, baseLength, holderHeight);
        translate([-cutWidth / 2, -cutLength / 2, wallThickness])
        union() {
            for (column = [1:columns]) {
                for (row = [1:rows]) {
                    translate([(row - 1) * (slotWidth + wallThickness), (column - 1) * (slotLength + wallThickness), 0])
                    cube([slotWidth, slotLength, cutHeight]);
                }
            }
        }
    }
}

drawHolder(rows, columns, wallThickness, cornerRadius, slotWidth, slotLength, holderHeight);