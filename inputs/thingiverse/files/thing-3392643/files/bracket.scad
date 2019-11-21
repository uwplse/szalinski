

// height of power supply
psuHeight = 102;

// depth of power supply
psuDepth = 53;

// diameter of mounting holes
mountHoleDia = 4.5;

// length of mount pad
mountPadLength = 12;

// wall thickness
thickness = 4;

// width of bracket
width = 10;



module bracket() {
  difference() {
    union() {
        cube([psuHeight+2*thickness, psuDepth+2*thickness, width], center=true);
        translate([0,psuDepth/2+thickness/2,0]) cube([psuHeight+2*thickness+2*mountPadLength, thickness, width], center=true);
    }
    translate([0,thickness,0]) cube([psuHeight,psuDepth+thickness*2,width+0.01], center=true);
  
  
    translate([psuHeight/2+thickness+mountPadLength/2,0,0]) 
    rotate([90,0,0]) cylinder (d=mountHoleDia, h=psuDepth*2, center=true, $fn=50);
  
    translate([-psuHeight/2-thickness-mountPadLength/2,0,0]) 
    rotate([90,0,0]) cylinder (d=mountHoleDia, h=psuDepth*2, center=true, $fn=50);
  }
}

bracket();



