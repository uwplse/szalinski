xSize = 90; // length

myFont = "Liberation Sans"; // [Liberation Mono, Liberation Sans,]
myText = "3D Dream Box"; 
holeDia = 4; // [2:9] 
difference() {
  difference() {
    cube([xSize, 20, 5], center=false);

    translate([10, 10, 0]){
      cylinder(r1=holeDia, r2=holeDia, h=20, center=false);
    }
  }

  translate([20, 7.5, 3]){
    // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
    linear_extrude( height=5, twist=0, center=false){
      text(myText, font = "Liberation Serif", size = 10*0.75);
    }

  }
}