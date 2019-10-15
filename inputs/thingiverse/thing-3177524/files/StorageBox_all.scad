/* 
    Simple Parametric Storage Box by dector (https://www.thingiverse.com/thing:3177524)

    This version is optimized for Thingiverse Customizer.
    For full sources and latest version checkout github repository:

    https://github.com/dector/things/tree/master/StorageBox
*/

cellSize = [25, 30, 25];
cellsCount = [3, 1];

innerThickness = 1;
outerThickness = 1;
coverThickness = 1;
bottomThickness = 1;

coverOverlap = 2;
coverGap = 0.3;

$fa = 1;
$fs = 0.2;

// Utils

function boxXSize(count, size, innerThickness, outerThickness) = count * (size + innerThickness) - innerThickness + 2 * outerThickness;

function boxYSize(count, size, innerThickness, outerThickness) = count * (size + innerThickness) - innerThickness + 2 * outerThickness;

function boxZSize(size, bottomThickness) = bottomThickness + size;

module StorageBox(cellsCount, cellSize, innerThickness = innerThickness, outerThickness = outerThickness, bottomThickness = bottomThickness) {
    
    boxSize = [
        boxXSize(cellsCount.x, cellSize.x, innerThickness, outerThickness),
        boxYSize(cellsCount.y, cellSize.y, innerThickness, outerThickness),
        boxZSize(cellSize.z, bottomThickness)
    ];

    difference() {
        cube(boxSize);    // Outer bound

        union() {
            for (i = [1:cellsCount.x]) {
                for (j = [1:cellsCount.y]) {
                    x = outerThickness + (i-1) * (cellSize.x + innerThickness);
                    y = outerThickness + (j-1) * (cellSize.y + innerThickness);
                    z = bottomThickness;

                    translate([x, y, z]) cube([cellSize.x, cellSize.y, cellSize.z]);    // Cell
                }
            }
        }
    }
}

module Cover(boxSize, overlap = coverOverlap, gap = coverGap, thickness = coverThickness) {
    
    coverSize = [
        boxSize.x + 2*coverThickness + 2*coverGap,
        boxSize.y + 2*coverThickness + 2*coverGap,
        coverThickness + coverOverlap        
    ];

    difference() {
        cube(coverSize);
        translate([thickness + gap, thickness + gap, thickness]) cube([boxSize.x, boxSize.y, coverOverlap]);
    }
}

// StorageBox
{
    StorageBox(cellsCount, cellSize);
}

// Cover
boxYSize = boxYSize(cellsCount.y, cellSize.y, innerThickness, outerThickness);
translate([0, boxYSize + 5, 0]) {
    boxSize = [
        boxXSize(cellsCount.x, cellSize.x, innerThickness, outerThickness),
        boxYSize
    ];
    Cover(boxSize);
}
