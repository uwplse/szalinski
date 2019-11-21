// version 1.1

rows = 2;
columns = 3;

// height in mm
height = 8;

// gap width for the nickel strips
gap = 6;
// height of the lip holding the battery in place
lipHeight = 2;
// diameter of the battery
batteryDiameter = 18;

addHoles = 1; // [1:true, 0:false]
holeDiameter = 3;

// adds gaps between the holes on the side of the holder, usefull for tie wraps.
addSideGaps = 1; // [1:true, 0:false]
sideGapWidth = 6;
sideGapDepth = 2;

// the overlap amount used for defining the distance between the cells
overlap = 2;

// make the outer borders rounded?
roundCorners = 1; // [1:true, 0:false]
cornerRadius = 2;

$fn = 30;

function width () = batteryDiameter + 4;
function offset(i) = (width()-overlap) * i;

intersection() {
    difference() {
        for(row = [0 : rows-1]) {
            for(column = [0 : columns-1]) {
                union() {
                    difference() {
                        translate([offset(row), offset(column), lipHeight])
                            cube([width(), width(), height-lipHeight]);
                        translate([offset(row)+width()/2, offset(column)+width()/2, lipHeight])
                            cylinder(h = height-lipHeight, r = (batteryDiameter+0.4)/2);
                    }
                    difference() {
                        translate([offset(row), offset(column), 0])
                            cube([width(), width(), lipHeight]);
                        
                        translate([offset(row) + ((width()-gap)/lipHeight), offset(column), 0])
                            cube([gap, width(), lipHeight]);
                        translate([offset(row), offset(column) + ((width()-gap)/lipHeight), 0])
                            cube([width(), gap, lipHeight]);
                    }
                }
            }
        }
        
        if(addHoles && holeDiameter > 0) {
            for(row = [1 : rows-1]) { // start from second column and row, no holes at the edges
                for(column = [1 : columns-1]) {
                    translate([offset(row)+overlap/2, offset(column)+overlap/2, 0])
                        cylinder(h = height, r = holeDiameter/2);
                }
            }
        }
        
        if(addSideGaps) {
            if(columns > 1) {
                for(column = [1 : columns-1]) {
                    translate([offset(0)-sideGapDepth, offset(column)-sideGapWidth/2+overlap/2, 0])
                        cube([sideGapDepth*2, sideGapWidth, height]);
                }
                
                for(column = [1 : columns-1]) {
                    translate([offset(rows)+overlap-sideGapDepth, offset(column)-sideGapWidth/2+overlap/2, 0])
                        cube([sideGapDepth*2, sideGapWidth, height]);
                }
            }
            
            if(rows > 1) {
                for(row = [1 : rows-1]) {
                    translate([offset(row)-sideGapWidth/2+overlap/2, offset(0)-sideGapDepth, 0])
                        cube([sideGapWidth, sideGapDepth*2, height]);
                }
                
                for(row = [1 : rows-1]) {
                    translate([offset(row)-sideGapWidth/2+overlap/2, offset(columns)+overlap-sideGapDepth, 0])
                        cube([sideGapWidth, sideGapDepth*2, height]);
                }
            }
        }
    }
    
    // adding the rounded corners
    if(roundCorners) {
        hull() {
            translate([0, 0, cornerRadius])
                cube([offset(rows)+overlap, offset(columns)+overlap, height-cornerRadius]);
            translate([cornerRadius, cornerRadius, cornerRadius])
                sphere(r = cornerRadius);
            translate([offset(rows)+overlap-cornerRadius, cornerRadius, cornerRadius])
                sphere(r = cornerRadius);
            translate([cornerRadius, offset(columns)+overlap-cornerRadius, cornerRadius])
                sphere(r = cornerRadius);
            translate([offset(rows)+overlap-cornerRadius, offset(columns)+overlap-cornerRadius, cornerRadius])
                sphere(r = cornerRadius);
        } 
    }
}