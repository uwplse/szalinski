
cellSize = 32.5;
cellHeight = 80;
numberCellLength = 2; // this is along the x dim
numberCellWidth = 3; // this is along the y dim
height = 90; // total enclosure height excluding the lid
buffer = 3; // the wall thickness
xBankLength = 2*buffer + numberCellLength*cellSize;
yBankLength = 2*buffer + numberCellWidth*cellSize;
screwSize = 3.4;
screwLength = 10;

module constructBase(){
  // draw the shape out, cut the corners, cut screw holes
  difference(){
      cube([xBankLength, yBankLength, height]);
      cube([3*buffer, 3*buffer, height]);
      translate([xBankLength - 3*buffer, 0, 0])
        cube([3*buffer, 3*buffer, height]);
      translate([xBankLength - 3*buffer, yBankLength - 3*buffer, 0])
        cube([3*buffer, 3*buffer, height]);
      translate([0, yBankLength - 3*buffer, 0])
        cube([3*buffer,3*buffer,height]);
      screwTapping(); // screws are cut before the corners are filled back in
    }

    // replace the cut corners with rounded corners
    translate([3*buffer, 3*buffer, 0])
      cylinder(r = 3*buffer, height);
    translate([xBankLength - 3*buffer, 3*buffer, 0])
      cylinder(r=3*buffer, height);
    translate([3*buffer, yBankLength-3*buffer, 0])
      cylinder(r=3*buffer, height);
    translate([xBankLength - 3*buffer, yBankLength - 3*buffer, 0])
      cylinder(r=3*buffer, height);
}

module cellConstructor(){
  for(x = [0:numberCellWidth - 1]){
    for(y = [0:numberCellLength - 1]){
      translate([buffer + (cellSize/2) + (cellSize*y), buffer + (cellSize/2) + (cellSize*x), buffer])
        cylinder(h = height-buffer, d = cellSize, $fn = 50);
    }
  }
}

module supportSkeletize(){
  // this cuts away extra areas inside the center posts
  for(x = [1:numberCellWidth-1]){
    for(y = [1:numberCellLength-1]){
      translate([buffer + cellSize + (cellSize*(y-1)), buffer + cellSize + (cellSize*(x-1)), buffer])
      cylinder(h = cellHeight - buffer - screwLength, d = (cellSize/2)*0.70);
    }
  }

  // these two cut away the thin round walls between the cells
  for(x = [0:numberCellLength-1]){
    translate([buffer + cellSize/4 + cellSize*x, buffer + cellSize/2, buffer])
    cube([cellSize/2, yBankLength - 2*buffer - cellSize, height - buffer]);
  }

  for(y = [0:numberCellWidth-1]){
    translate([buffer + cellSize/2, buffer + cellSize/4 + cellSize*y, buffer])
    cube([xBankLength - 2*buffer - cellSize, cellSize/2, height - buffer]);
  }

  // this lowers the center posts down for mounting things
  translate([buffer + cellSize/2, buffer + cellSize/2, cellHeight])
  cube([xBankLength - 2*buffer - cellSize, yBankLength - 2*buffer - cellSize, height - cellHeight]);
}

module screwTapping(){
  // these add the exterior screws
  for(x=[0:numberCellLength-1]){
    translate([buffer+cellSize+(cellSize*x),buffer,height-screwLength])
    cylinder(h = screwLength, d = screwSize, $fn = 20);
    translate([buffer+cellSize+(cellSize*x),yBankLength-buffer,height-screwLength])
    cylinder(h = screwLength, d = screwSize, $fn = 20);
  }

  for(y=[0:numberCellWidth-1]){
    translate([buffer,buffer+cellSize+(cellSize*y),height-screwLength])
    cylinder(h = screwLength, d = screwSize, $fn = 20);
    translate([xBankLength-buffer,buffer+cellSize+(cellSize*y),height-screwLength])
    cylinder(h = screwLength, d = screwSize, $fn = 20);
  }

  // this adds interior screw holes in the posts
  for(x = [1:numberCellLength]){
    for(y = [1:numberCellWidth]){
      translate([buffer + cellSize + (cellSize*(y-1)), buffer + cellSize + (cellSize*(x-1)), buffer + cellHeight - screwLength])
      cylinder(h = screwLength, d = screwSize, $fn = 20);
    }
  }
}

// Final Assembly!

difference(){
  constructBase();
  supportSkeletize();
  cellConstructor();
}
