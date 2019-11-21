// Number of plots in a column.
plotRows = 3;

// Number of plots in a row.
plotColumns = 4;

// Additional padding around edges of the field, in mm. If set to -1, is set to padding for another plot. If set to 0, you can glue many fields together!
fieldPadding = -1;

// Size of each square plot, in mm. 
plotSize = 28;

// Maximum length of each plot's magnetic insert, in mm.
insertSize = 17.8; 

// Maximum height of each plot's magnetic insert, in mm.
insertHeight = 5;

// Thickness of walls around each plot and the entire field, in mm.
wallThickness = 1;

// Size between the insert and the top surface, in mm.
topLayerHeight = 2;

// Additional padding for inserts due to printing tolerance, in mm.
printerTolerance = 0.2;

  ////////////////////////
 // Computed Variables //
////////////////////////

// Distance around insert to the next plot, in mm.
insertPaddingWithTolerance = (plotSize - insertSize + printerTolerance)/2;

// Height of the insert with printer tolerance, in mm.
insertHeightWithTolerance = insertHeight + printerTolerance;

// Automatic field padding based on insert padding.
autoFieldPadding = fieldPadding < 0 ? insertPaddingWithTolerance : fieldPadding;

  ///////////////
 // Generator //
///////////////
union() {
    // Farming field
    difference () {
        // Entire field
        translate([-autoFieldPadding - wallThickness, -autoFieldPadding - wallThickness, -topLayerHeight])
        cube(size=[(plotRows * plotSize) + (autoFieldPadding * 2) + (wallThickness * 2), (plotColumns * plotSize) + (autoFieldPadding * 2) + (wallThickness * 2), insertHeightWithTolerance + topLayerHeight], center=false);
        
        // Shelled
        translate([-autoFieldPadding, -autoFieldPadding, 0])
        cube(size=[(plotRows * plotSize) + (autoFieldPadding * 2), (plotColumns * plotSize) + (autoFieldPadding * 2), insertHeightWithTolerance + topLayerHeight], center=false);
    }
    
    // Plot insert cutouts
    for(i = [0:plotRows-1]) {
        for(j = [0:plotColumns-1]) {
            difference() {
                translate([insertPaddingWithTolerance + (i * plotSize) - wallThickness, insertPaddingWithTolerance + (j * plotSize) - wallThickness, 0])
                cube([plotSize - (2 * insertPaddingWithTolerance) + (wallThickness * 2), plotSize - (2 * insertPaddingWithTolerance) + (wallThickness * 2), insertHeightWithTolerance]);
                
                translate([insertPaddingWithTolerance + (i * plotSize), insertPaddingWithTolerance + (j * plotSize), 0])
                cube([plotSize - (2 * insertPaddingWithTolerance), plotSize - (2 * insertPaddingWithTolerance), insertHeightWithTolerance]);
            }
        }
    }
}