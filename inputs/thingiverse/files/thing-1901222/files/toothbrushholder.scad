/**
* Holder for Oral b Toothbrush
*/

border = 10;    // border on the left and right side
width = 30;     // width of the object
height = 40;    // height of the object
holes = 5;      // how many holes
distance = 30;  // disctance between holes
thickness = 4;  // thickness of the layer

// Bottom
color("DeepPink")
  translate([0, 0, 0])
    cube([width, 2*border + holes*distance, thickness]);
    
// Bolt
color("Blue") {
  for (i = [1:holes]) {
    translate([width/2, distance*(i-1) + distance/2 + border, thickness])
      cylinder(12,5,1);    
  }
}

// Top with holes
color("DeepPink")
  translate([0, 0, height])
    difference() {
      cube([width, border*2 + holes*distance, thickness]);
      
      for (i = [1:holes]) {
        translate([width/2, distance*(i-1) + distance/2 + border,-1])
          cylinder(6,8,8);   
      }
    }

// left side
color("DarkGreen")
  drawSide();

// right side
color("DarkGreen")
  mirror([0,1,0])
    translate([0, (2*border + holes*distance)*-1, 0])
      drawSide();
         
module drawSide() {
  rotate([90,90,90])
    translate([-1*(height+thickness)/2, 0, 0])
      difference() {
        cylinder(width, (height+thickness)/2, (height+thickness)/2);
        translate([0, 0, -1])
          cylinder(width+2, (height-thickness)/2, (height-thickness)/2);
        translate([-1*(height/2+2), 0, -1])
          cube([height+thickness, (height+thickness)/2, width+thickness/2]);
      }
}