//hight of the text in mm
Text_hight = 2;
// Text size
Text_size = 15;
// Text itself
Text = "Plant";
// hight of the label
height = 1;
// width of the label in mm
label_width = 15;
// length of the label in mm
label_length = 50;
// width of the earth stick in mm
earth_stick_witdth = 5;
// length of the earthstick in mm
earth_stick_length = 50;
union(){
  translate([((label_length + earth_stick_length) / 2), 0, 0]){
    cube([earth_stick_length, earth_stick_witdth, height], center=true);
  }
  cube([label_length, label_width, height], center=true);
  // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
  linear_extrude( height=(Text_hight + height)/2, twist=0, center=false){
    text(str(Text), font = "Roboto", size = Text_size *0.75, halign="center", valign="center");
  }

  {
    $fn=50;    //set sides to 50
    translate([((label_length + 0) / 2 + earth_stick_length), 0, 0]){
      union(){
        linear_extrude( height=(height / 2), twist=0, scale=[1, 1], center=false){
          circle(r=(earth_stick_witdth / 2));
        }
        linear_extrude( height=(height), twist=0, scale=[1, 1], center=true){
          circle(r=(earth_stick_witdth / 2));
        }
      }
    }
  }
  {
    $fn=50;    //set sides to 50
    translate([((label_length + 0) / 2), 0, 0]){
      union(){
        linear_extrude( height=(height), twist=0, scale=[1, 1], center=true){
          circle(r=(label_width / 2));
        }
        linear_extrude( height=(height), twist=0, scale=[1, 1], center=true){
          circle(r=(label_width / -2));
        }
      }
    }
  }
  {
    $fn=50;    //set sides to 50
    translate([((label_length + 0) / -2), 0, 0]){
      union(){
        linear_extrude( height=(height / 2), twist=0, scale=[1, 1], center=false){
          circle(r=(label_width / 2));
        }
        linear_extrude( height=(height), twist=0, scale=[1, 1], center=true){
          circle(r=(label_width / 2));
        }
      }
    }
  }
}