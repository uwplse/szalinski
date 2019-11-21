// hight of thelabel (=depth)
height = 5;
//Your Text
Text2 = "100. DESIGNS";
//Font size
Size = 15;
// Base legth fine tune in mm 
base_legth = 15;
linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
  union(){
    translate([0, 3, 0]){
      // size is multiplied by 0.75 because openScad fonts size is in points, not pixels
      text(str(Text2), font = "Comic Sans MS", size = Size* 0.75);

    }
    square([(len(Text2) * (Size * 0.39))*1.25 + base_legth, 4], center=false);
  }
}