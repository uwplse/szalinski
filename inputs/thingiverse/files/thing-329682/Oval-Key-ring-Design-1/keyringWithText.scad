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
text_itself="DEBRAJ";
//default at position [0,0,0]
//text left to right
//XposText = -9; //[-5:5]
//y to come in front
//YposText = 1.5; //[-50:50]
//text bottom to top
//ZposText = 2; //[1:20]

//default text size(height) [3]
text_size = 3; //[3:5]
//Spacing between adjacent letters
//text_spacing=1.5;
//specify the font thickness
//font_thickness = 15; //[1.3:5]
//default uploaded image height 10
//image_height = 0; //[-50:50]
  
// Load a 100x100 pixel image. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
//image_file = "image-surface.dat"; // [image_surface:100x100]


//
// ASSEMBLE BUILDING
//
//rotate(90,[0,1,0])
//rotate(-75,[0,0,1])
scale([0.7,0.7,0.7])
union(){
keyringWithPic();
if (show_text=="yes") {
	translate([1.5,0,0])
	rotate(90,[0,1,0])
	color("salmon")
//	writesphere(text=text_itself,where=[0,0,0],radius=7,height=66,rotate=0,t=font_thickness,bold=1,h=text_size,font=text_font,space=1.3);
	write(text_itself,t=7,bold=1,h=text_size,font=text_font,space=1.3, center = true);
//	write(message,t=font_thickness, h=font_size, center = true, font = Font)
  }
}

module keyringWithPic(){
difference() {
	scale([1.0,2.0,3.0]) sphere(r=8.0,$fn =100);
	translate([0,0,17.5])rotate ([90,0,0])sphere(r = 5.5,$fn =100);
	translate([11,0,0])rotate ([90,0,0]) scale([2.0,4.2,3.0])sphere(r=4.5,$fn =100);
   }
}