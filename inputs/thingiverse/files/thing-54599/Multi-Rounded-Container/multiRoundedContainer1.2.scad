// Makerbot Customizer Parameters:
Outer_Container_Width = 100; 
Outer_Container_Height = 40; 
Outer_Container_Depth =  200;
Radius_InnerAndOuter_Edges =  10;
Wall_InnerAndPartition_Thickness  = 1.5;
Number_Inner_Cell_Rows = 3;
Number_Inner_Cell_Columns = 2;


// Make Container
makeContainer(
	Outer_Container_Width, 				// Outer Container Width (X)
	Outer_Container_Height, 			// Outer Container Height (Y)
	Outer_Container_Depth, 				// Outer Container Depth (Z)
	Radius_InnerAndOuter_Edges, 		// Radius of Rounded Inner/Outer Edgers
	Wall_InnerAndPartition_Thickness, 	// Outer Wall & Inner Partition Thickness
	Number_Inner_Cell_Rows, 			// Number of Rows for Inner Cells (X)
	Number_Inner_Cell_Columns			// Number of Columns for Inner Cells (Z)
);

// Create Multi Rounded Container
module makeContainer(
	intWidth, 
	intHeight, 
	intDepth, 
	intRadius, 
	intWallthickness, 
	intRowsSpecified, 
	intColumnsSpecified) {
	
	// Fix invlaid column/row numbers, in case 0 is entered
	intColumns = (intColumnsSpecified == 0) ? 1 : intColumnsSpecified;
	intRows = (intRowsSpecified == 0) ? 1 : intRowsSpecified;
	
	// Calculate Cell Dimensions
	intContainerCell_Width = ((intWidth - (((intColumns -1) * intWallthickness) + (intWallthickness * 2))) / intColumns) - ((intColumns > 1) ? ((intRadius*2)*(intColumns-1))/intColumns:0);
	intContainerCell_Height = intHeight;
	intContainerCell_Depth = ((intDepth - (((intRows -1) * intWallthickness) + (intWallthickness * 2))) / intRows) - ((intRows > 1) ? ((intRadius*2)*(intRows-1))/intRows:0);

	// Calculate Base Positions
	intBaseXPosition = intWallthickness;
	intBaseYPosition = intWallthickness+0.1;
	intBaseZPosition = intWallthickness;

	// Define Position Functions
	function getXPosition(intColumnIndex) = intBaseXPosition + ((intContainerCell_Width+intBaseXPosition) * (intColumnIndex-1)) + ((intColumnIndex > 1) ? ((intRadius*2)*(intColumnIndex-1)):0);
	function getZPosition(intRowIndex) = intBaseZPosition + ((intContainerCell_Depth+intBaseZPosition) * (intRowIndex-1)) + ((intRowIndex > 1) ? ((intRadius*2)*(intRowIndex-1)):0);

	// Create Container
	difference() { 
		// Create Solid Shape
		createContainerShape(intWidth, intHeight, intDepth, intRadius);
		// Cut Out Inner Cells
		for (intRowCount= [1: intRows])
		{
			for (intColumnCount = [1: intColumns])
			{
			    	translate (v=[getXPosition(intColumnCount),intBaseYPosition,getZPosition(intRowCount)]) {
					createContainerShape(intContainerCell_Width, intContainerCell_Height, intContainerCell_Depth, intRadius); 
				}
			}
		}
	}
}

// Create Container Shape
module createContainerShape(
	width, 
	height, 
	depth, 
	radius) {
	
	// Create Shape
	hull() {
		// Base
		translate(v = [0, 0, 0]) { sphere(r=radius); }
		translate(v = [width, 0, 0]) { sphere(r=radius); }
		translate(v = [width, 0, depth]) { sphere(r=radius); }
		translate(v = [0, 0, depth]) { sphere(r=radius); }
		// Top
		translate(v = [0, height, 0]) { rotate(a=[90,0,0]) { cylinder(h=1, r=radius, center = true); } }
		translate(v = [width, height, 0]) { rotate(a=[90,0,0]) { cylinder(h=1, r=radius, center = true); } }
		translate(v = [width, height, depth]) { rotate(a=[90,0,0]) { cylinder(h=1, r=radius, center = true); } }
		translate(v = [0, height, depth]) { rotate(a=[90,0,0]) { cylinder(h=1, r=radius, center = true); } }
	}
}