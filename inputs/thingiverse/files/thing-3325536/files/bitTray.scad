//
// Customizable Bit Tray
// Hexagonal hole pattern with 3 different customizable hole sizes for space-efficient storage of drill bits such as for Proxxon and Dremel tools.
//
// Initial version: V1.0 by Physicator, Dec/2018
// Updates:
// 2019-01-06: Fixed OpenSCAD file; now working with Thingiverse Customizer (remnoved non-standard characters). Corrected some typos.
//
// Licensed under the Creative Commons - Attribution - Non-Commercial license. 
//
// Note: I recommend using the integrated customizer in OpenSCAD (tested with version 2018.09.05).
//
// Note: parameters may NOT be fool-proof, so reasonable values must be chosen!
//

/* [Holes] */

// Depth of holes of type 1 (marked by hex pits).
holeDepth1 = 15; // [3 : 1 : 70]

// Depth of holes of type 2 (marked by circular pits).
holeDepth2 = 12; // [3 : 1 : 70]

// Depth of holes of type 3 (without pits).
holeDepth3 = 9; // [3 : 1 : 70]

// Diameter of type 1 holes.
holeDiameter1 = 2.8; // [1 : 0.1 : 7]

// Diameter of type 2 holes.
holeDiameter2 = 3.7; // [1 : 0.1 : 7]

// Diameter of type 3 holes.
holeDiameter3 = 2.8; // [1 : 0.1 : 7]

// Distance between holes of each type. This should be chosen based on the horizontal size of tool bits.
distance = 12; // [3 : 0.5 : 70]

// Number of rows of holes of each type. This determines the total length of the block (in addition to 'rimWidth' below).
rows = 5; // [3 : 1 : 20]

// Number of holes of each type per row. This determines the total width of the block (in addition to 'rimWidth' below).
columns = 4; // [2 : 1 : 20]

// Diameter of optional chamfers at top of all holes for easier bit insertion, in relative units of the hole diameter. Set to '1' for no chamfers.
chamferDiameter = 1.4; // [1: 0.1 : 5]

// Diameter of optional markers for easy distinction of different hole types, in relative units of the hole diameter. Set to '1' for no markers.
markerDiameter = 2; // [1 : 0.2 : 10]

/* [Block] */

// Thickness of bottom below deepest holes. This determines the total height of the block (in addition to the maximum hole depth).
bottomThickness = 1.2; // [0.2 : 0.2 : 15]

// Width of hole-less rim around the hole pattern. Affects total width and length of block.
rimWidth = 5; // [1 : 1 : 30]

// Total length of block. If set to zero it will be calculated based on parameters 'distance', 'columns', and 'rimWidth'. Otherwise 'rimWidth' is being overridden.
forcedLength = 50; // [0 : 1 : 200]

// Total width of block. If set to zero it will be calculated based on parameters 'distance', 'rows', and 'rimWidth'. Otherwise 'rimWidth' is being overridden.
forcedWidth = 50; // [0 : 1 : 200]

/* [Hidden] */

eps = 0.01; // small value
$fn = 30;
chamferAngle = 70; // angle of hole chamfers with respect to surface of block

// Derived parameters:
rowSpacing = distance / 2 * sqrt(3); // vertical spacing between centers of type 1 hole rows
totalLength = round100u((forcedLength > 0) ? forcedLength : ((columns - 1) * distance + 2 * rimWidth)); // total length of the block
totalWidth = round100u((forcedWidth > 0) ? forcedWidth : ((rows - 1) * rowSpacing + 2 * rimWidth)); // total width of the block
height = max(holeDepth1, holeDepth2, holeDepth3) + bottomThickness; // height of the block
X0 = -((columns - 1) / 2 * distance); // X position of first row's hole centers
Y0 = -((rows - 1) / 2 * rowSpacing); // y position of first row's hole centers

// Rounding to integer multiples of 100um:
function round100u(x) = round(x * 10) / 10;

// Hexagonal array of cylinders, arranged row by row and confined to a rectangular envelope shape. Optional chamfers at top.
// dist: nearest-neighbor distance of adjacent cylinder centers.
// dia: diameter of cylinders.
// h: height of cylinders.
// nx: maximum number of cylinders per row (every other row has one less).
// ny: number of rows.
// startLong: true = start with a 'long' row at the bottom, i.e. with nx cylinders; false = start with a 'short' row, i.e. (nx - 1) cylinders;
// chamAngle: if > 0 then then chamfers will be added at the top of each cylinder with this angle (with respect to top surface). May be smaller (for 'positive' array) or larger (for 'negative', i.e., hole array) than dia.
// chamDia: cylinder diameter at the top for the case of chamfers.
// fn: number of polygon segments (local value for $fn). If negative, the polygon is rotated by 90deg.
module hexArrayCylinders(dist, dia, h, nx, ny, startLong = true, chamAngle = 0, chamDia = 0, fn = 30)
{
    offset = (startLong == true) ? 0 : 1; // add offset to modulos if short row should be the first
    chamDepth = tan(chamAngle) * (chamDia - dia) / 2; // chamfer depth
    for (j = [0 : ny - 1])
    {
        for (i = [0 : nx - 1 - ((j + offset) % 2)])
        {
            translate([(i+((j+offset)%2)/2)*dist, j*dist/2*sqrt(3), 0])
                rotate([0, 0, (fn < 0) ? 90 : 0])
                {
                    if (chamAngle > 0) // add chamfers?
                    {
                        cylinder(h = h - chamDepth + eps, d = dia, $fn = abs(fn));
                        translate([0, 0, h - chamDepth])
                            cylinder(h = chamDepth, d1 = dia, d2 = chamDia, $fn = abs(fn));
                    }
                    else
                        cylinder(h = h, d = dia, $fn = abs(fn)); // no chamfers
                }
        }
    }
}

// Creates a shape that can be used for cutting out a fillet along an edge of a solid.
// The edge is assumed to be aligned along z, centered at the xy-plane.
// The solid is assumed to be located in the 1st quadrant (positive x and y directions).
// L: edge length
// r: fillet radius
// fn: number of polygon segments for fillet circle (local value for $fn).
module lineFillet(L, r, fn)
{
    linear_extrude(height = L + 2 * eps, center = true, convexity = 4)
        translate([-eps, -eps, 0])
            difference()
            {
                square(r + eps);
                translate([r, r, 0])
                    circle(r = r + 2 * eps, $fn = fn);
            }
}

// Creates a shape that can be used for cutting out fillets along all edges of a rectangular face of a solid.
// The face is assumed to be aligned within the xy-plane, centered around the origin.
// The solid is assumed to be located below the xy-plane (negative z direction).
// Lx, Ly: edge lengths of rectangular face along x and y directions, respectively.
// r: fillet radius
// fn: number of polygon segments for fillet circle (local value for $fn).
module rectFillets(Lx, Ly, r, fn)
{
    // Bottom edge:
    rotate([0, 90, 0])
        translate([0, -Ly/2, 0])
            lineFillet(Lx, r, fn);
    // Top edge:
    rotate([0, 90, 180])
        translate([0, -Ly/2, 0])
            lineFillet(Lx, r, fn);
    // Left edge:
    rotate([-90, 0, 0])
        translate([-Lx/2, 0, 0])
            lineFillet(Ly, r, fn);
    // Right edge:
    rotate([-90, 0, 180])
        translate([-Lx/2, 0, 0])
            lineFillet(Ly, r, fn);
}

// Main block (without holes).
module block()
{
    filletRad = round100u(max(min(rimWidth / 4, height / 10), 0.6)); // fillet radii
    difference()
    {
        translate([0, 0, height/2])
            cube(size = [totalLength, totalWidth, height], center = true);
        translate([0, 0, height])
            rectFillets(totalLength, totalWidth, filletRad, 32);
    }
}

// Complete bit holder.
module bitHolder()
{
    markingDepth1 = max(0.2, 2 * round100u(holeDiameter1/10)); // depth of marking circle around each hole of type 1
    markingDepth2 = max(0.2, 2 * round100u(holeDiameter2/10)); // depth of marking circle around each hole of type 1
    difference()
    {
        // Main block:
        block();
        
        // Holes of type 1:
        translate([X0, Y0, height-holeDepth1])
            hexArrayCylinders(distance, holeDiameter1, holeDepth1 + eps, columns, rows, true, (chamferDiameter > 1) ? chamferAngle : 0, chamferDiameter * holeDiameter1);
        // Top markings for type 1 holes:
        if (markerDiameter > 1)
            translate([X0, Y0, height-markingDepth1])
                hexArrayCylinders(distance, holeDiameter1 * markerDiameter, markingDepth1 + eps, columns, rows, true, 0, 0, -6);
        
        // Holes of type 2:
        translate([X0, Y0+distance/2/sqrt(3), height-holeDepth2])
            hexArrayCylinders(distance, holeDiameter2, holeDepth2 + eps, columns, rows - 1, false, (chamferDiameter > 1) ? chamferAngle : 0, chamferDiameter * holeDiameter2);
        // Top markings for type 2 holes:
        if (markerDiameter > 1)
            translate([X0, Y0+distance/2/sqrt(3), height-markingDepth2])
                hexArrayCylinders(distance, holeDiameter2 * markerDiameter, markingDepth2 + eps, columns, rows - 1, false, 0, 0, 30);
        
        // Holes of type 3:
        translate([X0, Y0+distance/sqrt(3), height-holeDepth3])
            hexArrayCylinders(distance, holeDiameter3, holeDepth3 + eps, columns, rows - 1, true, (chamferDiameter > 1) ? chamferAngle : 0, chamferDiameter * holeDiameter3);
    }
}

module showHoleTypes()
{
    rotate([0, 0, -30])
        difference()
        {
            translate([-X0, -Y0, 0])
                bitHolder();
            rotate([0, 0, 30])
                translate([-totalLength/2, -2*totalWidth, -eps])
                    cube([totalLength*2, totalWidth*2, height+2*eps]);
        }
}

echo(totalLength = totalLength);
echo(totalwidth = totalWidth);
bitHolder();
//showHoleTypes();
