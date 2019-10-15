// Grid
// By Dana Woodman <dana@danawoodman.com>


// Settings
//--------------------------

/* [Global] */

// The width of the exported file.
width = 30;

// The height of the exported file.
height = 30;

// The number of columns to generate.
cols = 10;

// The number of rows to generate.
rows = 10;

// The border around the grids/slats
border = 4;

// The spacing between rows/columns.
spacing = .8;

//thickness
thickness = 2;

/* [Hidden] */

// The magic...
//--------------------------

// Calculated inner width of dispaly area.
innerWidth = (width - (2 * border));
innerHeight = (height - (2 * border));
//echo("innerWidth", innerWidth, "innerHeight", innerHeight);

// Calculate size of the squares.
function dimension(size, divisions) = (size - ((divisions - 1) * spacing)) / divisions;
xWidth = dimension(innerWidth, cols);
yWidth = dimension(innerHeight, rows);
//echo("xWidth", xWidth, "yWidth", yWidth);

function calculate_location(size, index, spacing) = (size + spacing) * index;

eps=.001;
// Subtract the squares from the display area.
difference() {

	// The display area.
	cube(size=[width, height,thickness]);

	// Offset by border size.
	translate([border, border,-eps])

		// Iterate over all the columns.
		for (col = [0 : cols - 1]) {
			
			// Iterate over all the rows.
			for (row = [0 : rows - 1]) {

				// Caclulate position of each square
				translate([
					calculate_location(xWidth, col, spacing), 
					calculate_location(yWidth, row, spacing)
				])
					cube(size=[xWidth, yWidth,2*thickness]);
			}
		}
}
