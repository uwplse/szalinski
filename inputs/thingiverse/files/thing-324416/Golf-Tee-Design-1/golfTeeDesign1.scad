use <write/Write.scad> // use <Write.scad>
// preview[view:south, tilt:top]


//
// CUSTOMIZING

/* [Text] */ //Choose to add text
//Do you want to add text?
show_text="yes"; //[yes,no]
//Text Font
text_font="write/orbitron.dxf";//[Letters.dxf:Letter, orbitron.dxf:Orbitron, BlackRose.dxf:BlackRose, braille.dxf:Braille]
//What do you want the text to say?
text_itself="MARCO";
//default at position [0,0,0]
//text left to right
//XposText = -9; //[-5:5]
//y to come in front
//YposText = 1.5; //[-50:50]
//text bottom to top
//ZposText = 2; //[1:20]

//default text size(height) [0.75]
text_size = 2; //[1:2]
//Spacing between adjacent letters
//text_spacing=1.5;

//default uploaded image height 10
//image_height = 0; //[-50:50]
  
// Load a 100x100 pixel image. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
//image_file = "image-surface.dat"; // [image_surface:100x100]


//
// ASSEMBLE BUILDING
//
union(){
golfTea();
if (show_text=="yes") {
  writecylinder(text=text_itself,where=[0,5,-27],radius=7,height=66,rotate=90,t=1.3,bold=1,h=text_size,font=text_font,space=1.3);
  }
}

module golfTea(){
difference() {
cylinder(h = 12, r=2.5, $fn=50);

//cylinder(h = 11, r1 = 18, r2 = 8, center = true);
 translate([0,0,0])rotate ([90,0,0]) sphere(r = 2, $fn=50);
}
 translate([0,0,12.5])
  {
   cylinder(h = 1, r1 =2.5, r2 = 1.3, $fn=50, center = true);
//   cylinder(h = 6, r1 =1.5, r2 = 0.2, center = true);
  }
 translate([0,0,16])
  {
//   cylinder(h = 1, r1 =2.5, r2 = 1.5, center = true);
   cylinder(h = 8, r1 =1.5, r2 = 0.2, $fn=50, center = true);
  }
}