part = "both"; // [bottom, block, both]
// Length of the base
length = 60;
// Width of the base
width = 40;
// Bottom thickness
bottom = 1.2;
// Roundness of the corners
roundness = 5;

/* [Slot] */
// Top width of the slot
slotTop = 4;
// Bottom width of the slot
slotBottom = 9;
// Height of the slot
slotHeight = 4;
// Tolerance for the slot (adjust in case it does not slide properly)
slotTolerance = 0.1;
// Padding around the slot before the cutout starts
slotPadding = 2;
// Walls on the outside before the cutout starts
walls = 2;

/* [Block] */
// Height of the block
holderHeight = 25;
// Top thickness of the block
holderThickness = 5;
// Bottom thickness of the block
holderThicknessBottom = 8;
// Padding for the cutout
holderPadding = 2.4;
// Depth for the rubber band slot
bandSlotDepth = 2;
// Height of the slot for the rubber band
bandSlotHeight = 2;
// Z Offset for the rubber band sllot
bandSlotOffsetZ = 4;
// Z Top Offset for the PCB slot
pcbOffsetZ = 2;
// Height of the cutout for the PCB
heightPcb = 1.2;
// Depth of the cutout for the PCB
depthPcb = 1.2;
// Outer height of the cutout for the PCB
heightPcbOuter = 2;

/* [Hidden] */
$fn = 90;
height = slotHeight + bottom;
cutoutDiameter = (width - slotBottom - slotPadding * 2 - walls * 2) / 2;
cutoutRadius = cutoutDiameter / 2;

if(part == "bottom") {
  bottom();
}
if(part == "block") {
  rotate([0, -90, 0])
    holder();
}
if(part == "both") {
  bottom();
  translate([-slotHeight - 5, 0, 0])
    rotate([0, -90, 0])
      holder();
}

module sled() {
  slotTopInner = slotTop - slotTolerance;
  slotBottomInner = slotBottom - slotTolerance;
  
  difference() {
    hull() {
      translate([0, -slotTopInner / 2, -0.1])
        cube([holderThicknessBottom, slotTopInner, 0.1]);
      
      translate([0, -slotBottomInner / 2, -slotHeight])
        cube([holderThicknessBottom, slotBottomInner, 0.1]);
    }
  
    translate([-1, -slotBottomInner / 2 - 1, -slotHeight - (slotTolerance * 2 + slotTolerance / 2)])
      cube([holderThicknessBottom + 2, slotBottomInner + 2, slotTolerance * 2]);
  }
}

module holder() {
  difference() {
    hull() {
      cube([holderThicknessBottom, width, 0.1]);
      translate([0, 0, holderHeight - 0.1])
        cube([holderThickness, width, 0.1]);
    }
    
    translate([-1, -1, bandSlotOffsetZ])
      cube([holderThicknessBottom + 2, bandSlotDepth+1, bandSlotHeight]);
    translate([-1, width - bandSlotDepth, bandSlotOffsetZ])
      cube([holderThicknessBottom + 2, bandSlotDepth+1, bandSlotHeight]);
    translate([holderThicknessBottom - bandSlotDepth, -1, bandSlotOffsetZ])
      cube([bandSlotDepth+1, width + 2, bandSlotHeight]);
    
    hull() {
      translate([depthPcb - 0.1, -1, holderHeight - pcbOffsetZ - heightPcb])
        cube([0.1, width + 2, heightPcb]);
      translate([-0.1, -1, holderHeight - pcbOffsetZ -heightPcb - (heightPcbOuter - heightPcb) / 2])
        cube([0.1, width + 2, heightPcbOuter]); 
    }
    
    translate([-1, holderPadding, bandSlotOffsetZ + bandSlotHeight + holderPadding])
    cube([holderThicknessBottom + 2, width - holderPadding * 2, holderHeight - (bandSlotOffsetZ + bandSlotHeight + holderPadding * 2 + pcbOffsetZ + heightPcbOuter)]);
  }
  
  translate([0, width / 2, 0])
    sled();
}

module bottom() {
  difference() {
    hull() {
      translate([roundness, roundness, 0])
        cylinder(r= roundness, h = height);
      translate([length - roundness, roundness, 0])
        cylinder(r= roundness, h = height);
      
      translate([roundness, width - roundness, 0])
        cylinder(r= roundness, h = height);
      translate([length - roundness, width - roundness, 0])
        cylinder(r= roundness, h = height);
    }
    
    hull() {
      translate([cutoutRadius + walls, cutoutRadius + walls, -1])
        cylinder(r= cutoutRadius, h = height + 2);
      translate([length - (cutoutRadius + walls), cutoutRadius + walls, -1])
        cylinder(r= cutoutRadius, h = height + 2);
    }
    
    hull() {
      translate([cutoutRadius + walls, width - (cutoutRadius + walls), -1])
        cylinder(r= cutoutRadius, h = height + 2);
      translate([length - (cutoutRadius + walls), width - (cutoutRadius + walls), -1])
        cylinder(r= cutoutRadius, h = height + 2);
    }

    hull() {
      translate([-1, width / 2 - slotBottom / 2, bottom])
        cube([length + 2, slotBottom, 0.1]);

      translate([-1, width / 2 - slotTop / 2, height])
        cube([length + 2, slotTop, 0.1]);
    }
  }
}