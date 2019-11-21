//height of the font in mm
Font_height = 1;
//size of the word in mm
font_size = 10;
//word
text = "abc";
//Thickness of the drop in mm
Drop_thickness = 2;
//size of the diameter of the drop in mm
size = 10;
union(){
  // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
  linear_extrude( height=(Drop_thickness + Font_height), twist=0, center=false){
    text(str(text), font = "Roboto", size = font_size*0.75, halign="center", valign="center");
  }

  rotate([0, 0, 45]){
    linear_extrude( height=2, twist=0, scale=[1, 1], center=false){
      union(){
        circle(r=size);
        square([size, size], center=false);
      }
    }
  }
}