cellSize = 32.5;
numberCellLength = 2;
numberCellWidth = 3;
height = 5;
buffer = 3;
xBankLength = 2*buffer + numberCellLength*cellSize;
yBankLength = 2*buffer + numberCellWidth*cellSize;
screwSize = 2.9;
screwLength = 5;
screwHeadLength = 3;
screwHeadDiameter = 4.2;
boltDiameter = 8;
boltHeight = 10;
boltHeadDiameter = 12;
boltHeadLength = 3;
faces = 40;

// countersunk screws (angled) v. cheese head screws (straight sides)
// \    /     |   |
//  \ /       |   |
//  ||         ||
//  ||         ||

screwType = "countersunk"; // see above diagram, other option is "cheesehead"

module lidConstructor(){
  //cut the corners while drawing the shape out
  difference(){
    cube([xBankLength, yBankLength, height]);
    cube([3*buffer, 3*buffer, height]);
    translate([xBankLength - 3*buffer, 0, 0])
      cube([3*buffer, 3*buffer, height]);
    translate([xBankLength - 3*buffer, yBankLength-3*buffer, 0])
      cube([3*buffer, 3*buffer, height]);
    translate([0, yBankLength - 3*buffer, 0])
      cube([3*buffer, 3*buffer, height]);
    screwTapping("screw");
  }

  translate([3*buffer, 3*buffer, 0])
    cylinder(r=3*buffer, height);
  translate([xBankLength-3*buffer,3*buffer,0])
    cylinder(r=3*buffer, height);
  translate([3*buffer,yBankLength-3*buffer,0])
    cylinder(r=3*buffer, height);
  translate([xBankLength-3*buffer,yBankLength-3*buffer,0])
    cylinder(r=3*buffer, height);
}

module screwHead(type){
  if(type=="screw"){
    union(){
      cylinder(h = screwLength, d = screwSize, $fn = faces);
      if(screwType=="cheesehead"){
        cylinder(h = screwHeadLength, d = screwHeadDiameter, $fn = faces);
      }
      else if(screwType=="countersunk"){
        cylinder(h = screwHeadLength, d1 = screwHeadDiameter, d2 = screwSize, $fn = faces);
      }
    }
  }
  else if(type=="bolt"){
    union(){
      cylinder(d = boltDiameter, h = boltHeight, $fn = faces);
      translate([0, 0, height - boltHeadLength])
        cylinder(d = boltHeadDiameter, h = boltHeadLength, $fn = faces);
    }
  }
}

module screwTapping(type){
  // these two cut exterior screwhead holes in the lid
  if(type == "screw"){
    for(x = [0:numberCellLength - 1]){
      translate([buffer + cellSize + (cellSize*x), buffer, height - screwLength])
        screwHead("screw");
      translate([buffer + cellSize + (cellSize*x), yBankLength - buffer, height - screwLength])
        screwHead("screw");
    }

    for(y = [0:numberCellWidth - 1]){
      translate([buffer, buffer + cellSize + (cellSize*y), height - screwLength])
        screwHead("screw");
      translate([xBankLength - buffer, buffer + cellSize + (cellSize*y), height - screwLength])
        screwHead("screw");
    }
  }

  if(type == "bolt"){
    // this cuts the bolt terminal holes
    translate([buffer + cellSize/2, buffer + cellSize/2, 0])
      screwHead("bolt");
    translate([xBankLength - buffer - cellSize/2, buffer + cellSize/2, 0])
      screwHead("bolt");
  }

}

difference(){
  lidConstructor();
  screwTapping("bolt");
}
