/***********************************************************************
Name ......... : MicroToolsHolder.scad
Content ...... : Generates pieces to arrange accessories of micro tools
Author ....... : Jean-Etienne BOUVET (Jeet)
Version ...... : V2.1 du 30/03/2016
Licence ...... : GPL
***********************************************************************/
// Which one do you want to see?
Part = 0; //[0:All,1:SingleRow,2:Support]
WarpingPrevention = 1; //[1:Yes,0:No]

// How big are tools?
ToolsDiameter = 4.52;
// How many tools should be inserted into a row?
ToolsByRow = 6;
// How many rows are needed?
RowNumber = 8;
// What distance between two rows?
RowOffset = 13;
// How tall holders should be raised?
HolderHeight = 12;
// How thick the bottom of holders should be?
HolderBottomThickness = 0.6;
// How thick the wall around holders should be?
WallThickness = 2.4;
// What distance should be added between tools?
ToolsExtraOffset = 3;

// How big axis on rows should be?
AxisDiameter = 3;

// What distance would be kept to allow movement between two pieces?
Spacing = 0.1;

/* [Hidden] */
DippingAngle = acos((ToolsDiameter/2+WallThickness)/(RowOffset/2));
BoxWidth = ToolsByRow*(ToolsDiameter+WallThickness)+WallThickness-2*((1-cos(22.5))*(ToolsDiameter/2+WallThickness))+(ToolsByRow-1)*ToolsExtraOffset;
BoxLength = RowOffset*RowNumber;

OffsetX = ToolsDiameter+WallThickness+ToolsExtraOffset;

$fn = 30;

/**********************************************/
/****************** RENDER ********************/
/**********************************************/
if(Part == 0) {
  rows(RowNumber);
} else if(Part == 1) {
  union() {
    row();
    // Mickey Ears
    if(WarpingPrevention == 1)
      translate([-WallThickness-Spacing-BoxWidth/2, 0, -cos(22.5)*AxisDiameter/2])
        linearMatrix(numberX=2, offsetX=2*(WallThickness+Spacing)+BoxWidth)
          cylinder(d=15, h=0.2);
  }
} else if(Part == 2) {
  union() {
    support(RowNumber);
    // Mickey Ears
    if(WarpingPrevention == 1)
      translate([-WallThickness-Spacing-BoxWidth/2, RowOffset/2, -2*WallThickness-cos(22.5)*AxisDiameter/2])
        linearMatrix(numberX=2, numberY=2, offsetX=2*(WallThickness+Spacing)+BoxWidth, offsetY=-BoxLength)
          cylinder(d=25, h=0.2);
  }
}

/**********************************************/
/**************** MODULES *********************/
/**********************************************/

module rows(number=1) {
  linearMatrix(numberY=number, offsetY=-RowOffset) {
    rotate([-DippingAngle, 0, 0])
      row();
  }
  support(number);
}

module row() {
  difference() {
    positive();
    negative();
  }
}

module positive() {
  union() {
    // Corps des cylindre
    translate([-(ToolsByRow-1)/2*OffsetX, 0, -cos(22.5)*AxisDiameter/2]) {
      linearMatrix(numberX=ToolsByRow, offsetX=OffsetX)
        rotate([0, 0, 22.5])
          cylinder(d=ToolsDiameter+2*WallThickness, h=HolderHeight, $fn=8);
      if(ToolsExtraOffset > 0) {
        translate([OffsetX/2, 0, HolderHeight/2])
          linearMatrix(numberX=ToolsByRow-1, offsetX=OffsetX)
            cube([ToolsExtraOffset+WallThickness, sin(22.5)*(ToolsDiameter+2*WallThickness), HolderHeight], center=true);
      }
    }
    axis();
    mirror()
      axis();
  }
}

module axis() {
  translate([BoxWidth/2, 0, 0])
    rotate([0, 90, 0])
      rotate([0, 0, 22.5])
        cylinder(d=AxisDiameter, h=WallThickness, $fn=8);
}

module negative() {
  // Emplacement des forets
  translate([-(ToolsByRow-1)/2*OffsetX, 0, HolderBottomThickness-cos(22.5)*AxisDiameter/2])
    linearMatrix(numberX=ToolsByRow, offsetX=OffsetX)
      rotate([0, 0, 22.5])
        cylinder(d=ToolsDiameter, h=HolderHeight+1);
}

module support(number=1) {
  difference() {
    union() {
      translate([Spacing+BoxWidth/2+WallThickness, (RowOffset-BoxLength)/2, -WallThickness/2])
        cube([2*WallThickness, BoxLength, cos(22.5)*AxisDiameter+3*WallThickness], center=true);
      translate([-Spacing-BoxWidth/2-WallThickness, (RowOffset-BoxLength)/2, -WallThickness/2])
        cube([2*WallThickness, BoxLength, cos(22.5)*AxisDiameter+3*WallThickness], center=true);
      translate([0, -((number-1)*RowOffset)/2, -WallThickness-cos(22.5)*AxisDiameter/2])
        cube([BoxWidth+2*Spacing, number*RowOffset, 2*WallThickness], center=true);
    }
    translate([0, -((number-1)*RowOffset)/2, -WallThickness-cos(22.5)*AxisDiameter/2])
      scale([0.9, 0.9, 1.1])
        cube([BoxWidth+2*Spacing, number*RowOffset, 2*WallThickness], center=true);
    linearMatrix(numberY=number, offsetY=-RowOffset) {
      rotate([0, 90, 0])
        cylinder(d=AxisDiameter, h=BoxWidth+2.5*WallThickness, center=true);
      rotate([DippingAngle, 0, 0])
        translate([0, 0, (HolderHeight-cos(22.5)*AxisDiameter)/2])
          cube([BoxWidth+2*Spacing, cos(22.5)*(ToolsDiameter+2*WallThickness), HolderHeight], center=true);
      rotate([-DippingAngle, 0, 0])
        translate([0, 0, (HolderHeight-cos(22.5)*AxisDiameter)/2])
          cube([BoxWidth+2*Spacing, cos(22.5)*(ToolsDiameter+2*WallThickness), HolderHeight], center=true);
    }
  }
}

/**
 * Duplicates childrens as many as specify and on specified axis
 */
module linearMatrix(offsetX=1, offsetY=1, offsetZ=1, numberX=1, numberY=1, numberZ=1, center=false) {
  translate(center ? [-(offsetX*(numberX-1))/2, -(offsetY*(numberY-1))/2, -(offsetZ*(numberZ-1))/2, ] : [0, 0, 0]) {
    for(nx=[0:numberX-1]) {
      translate([nx*offsetX, 0, 0])
        for(ny=[0:numberY-1]) {
          translate([0, ny*offsetY, 0])
            for(nz=[0:numberZ-1]) {
              translate([0, 0, nz*offsetZ])
                children();
            }
        }
    }
  }
}
