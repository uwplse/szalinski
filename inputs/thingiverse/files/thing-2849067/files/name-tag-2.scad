//!OpenSCAD

// Note: Make it longer at a longer text
text2 = "abc";
font_thickness = 1;
font_size = 10;
hight = 1;
radius_of_hole = 2;
eges_of_hole = 100;
edges_of_rounding = 100;
// Lengh of your name tag
Lengh = 20;
// Width of your name tag
width = 10;
linear_extrude( height=hight, twist=0, scale=[1, 1], center=false){
  difference() {
    union(){
      {
        $fn=edges_of_rounding;    //set sides to edges_of_rounding
        circle(r=(width / 2));
      }
      translate([0, (width / -2), 0]){
        square([Lengh, width], center=false);
      }
    }

    {
      $fn=eges_of_hole;    //set sides to eges_of_hole
      circle(r=radius_of_hole);
    }
  }
}
translate([3, -3.5, hight]){
  // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
  linear_extrude( height=font_thickness, twist=0, center=false){
    text(str(text2), font = "Roboto", size = font_size*0.75);
  }

}