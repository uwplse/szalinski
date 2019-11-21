/* [Base] */
xSize = 45; // length
ySize = 15; // height
zSize = 3; //thickness
holeDia = 3.5; // hole diameter
holehight=2;//hole high
/* [Text] */
textHeight = 2; // [1:10] 
textSize= 7.5; // [1:50]
myFont = "Liberation Sans"; // [Liberation Mono, Liberation Sans,]
myText = "My Name"; // Your name here!
/* [Hidden] */
// preview[view:south, tilt:top diagonal] 
baseSize = [xSize, ySize, zSize];
include <MCAD/boxes.scad>

module out()
{
 
    cylinder(holehight,holeDia,holeDia);
}
module in()
{
 
    cylinder(holehight+1,holeDia-1,holeDia-1);
}

module ring()
{  translate([0,10,0]) 
    difference(){
         out();
        in();
    }
}

module textExtrude() {
    linear_extrude(height = textHeight) 
    text(myText, halign = "center", valign = "center", size = textSize, font = myFont);
}
module base() {
  roundedBox(baseSize, radius = 0, sidesonly = 1, $fn = 36);
  //cube(baseSize, center = true);
}
module makeTag() {
      union() {
      base();
      //translate([0, -ySize/5 , zSize/2]) textExtrude();
      translate([0, -3, 1.5]) textExtrude();
     ring();
    } 
  }
makeTag();
//base();
//holes();
//textExtrude();