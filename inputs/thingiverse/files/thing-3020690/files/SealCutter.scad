// Seal cutter, for 9mm blades

// Width of seal
width = 14.3;

// Depth of seal
depth = 24.4;

// Width of secondary seal, set to 0 to disable
secondWidth = 0;

// Gap size for blade
gap = 0.6;

// Gap angle (default: 10 degrees)
gapAngle = 20;

// Spacing between block and cap
capSpacing = 0.1;

// Positions in 3x3 grid to make holes in. Rows from bottom to top. 1 = hole, 0 = no hole.
holePositions = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];

// Horizontal spacing in 3x3 hole grid (if used)
holeSpacingX = 4;

// Vertical spacing in 3x3 hole grid (if used)
holeSpacingY = 9;

// Diameter of drill hole
holeSize = 2.1;

// Edge for cutting block (default: 8, but increase for large gap angles)
cutEdge = 8;

// Edge for cap (3 is fine)
capEdge = 3;

// Font size for text
fontSize = 6;

    
// Make cutting block
translate([0,0,16])rotate([0,180,0])cuttingBlock();

// Make cap in 3D print layout
translate([width+2*cutEdge+capEdge+5,0,0])cap();

// Make cap in assembly layout
//translate([0,0,-4])cap();

//myText();


//function float2str(num) = str(floor(num),".",floor(num*100%100));

// Text
module myText() {
        rotate([0,0,90])
            linear_extrude(height = 2)
                union(){
                    translate([0,fontSize*0.8,0])
                    text(str(width,"x",depth),size=fontSize,halign="center",valign="center");
                    translate([0,-fontSize*0.8,0])
                        text(str(gapAngle," deg"),size=fontSize,halign="center",valign="center");//,font="Arial Narrow:style=Bold"
                }
}

// Make cutting  block
module cuttingBlock(){
  translate([0,0,8]){
    difference(){
      cube([width+2*cutEdge, depth+2*cutEdge,16],center=true);
      translate([0,0,-2]){
        union(){
          translate([-width/2,0,-6])
            rotate([0,0,0])
              slit();
          translate([0,-depth/2,-6])
            rotate([0,0,90])
              slit();
          translate([width/2,0,-6])
            rotate([0,0,180])
              slit();
          if(secondWidth>0)        
            translate([-width/2+secondWidth,0,-6])
              rotate([0,0,180])
                slit();        
          translate([0,depth/2,-6])
            rotate([0,0,270])
              slit();
          translate([0,0,-6])
            holes();
        }
      }
      translate([0,0,7]) {
        myText();
      }
    }
  }
}

// Make cap
module cap(){
  color("green")
  translate([0,0,4]){
    difference(){
      cube([width+2*(cutEdge+capEdge),depth+2*(cutEdge+capEdge),8],center=true);
      translate([0,0,3]){
        union(){
          cube([width+2*(cutEdge+capEdge)+2,depth+4,6],center=true);
          cube([width+4,depth+2*(cutEdge+capEdge)+2,6],center=true);
          cube([width+2*(cutEdge+capSpacing),depth+2*(cutEdge+capSpacing),6],center=true);
          translate([0,0,-7])holes();
        }
      }
      translate([0,0,-3])
        rotate([0,180,0])
            myText();
    }
  }
}

// Makes an inclined slit primitive
module slit(){
  rotate([0,-gapAngle,0])
    translate([0,0,5])
      cube([gap,max(width,depth)+2*cutEdge+2,14],center=true);
}

// Makes a cylinder for creation of holes
module holes() {
  for (i=[0:2]) {
    for (j=[0:2]) {
      if (holePositions[j][i]) {
        translate([holeSpacingX*(i-1),holeSpacingY*(j-1),8]) {
          cylinder(18,d=holeSize,center=true,$fn=20);
        }
      }
    }
  }
}
