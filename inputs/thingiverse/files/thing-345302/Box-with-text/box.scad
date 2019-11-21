use <write/Write.scad> // use <Write.scad>
// preview[view:south, tilt:top]


//
// CUSTOMIZING

/* [Text] */ //Choose to add text
//Do you want to add text?
show_text="yes"; //[yes,no]
//Text Font
text_font="knewave.dxf";//[stencil_TNH.dxf:Stencil,knewave.dxf:Knewave, Letters.dxf:Letter, orbitron.dxf:Orbitron, BlackRose.dxf:BlackRose, braille.dxf:Braille]
//What do you want the text to say?
text_itself="MIM";

//text size(height)
text_size = 7; //[8:10]
//Spacing between adjacent letters
//text_spacing=1.5;
//specify the font thickness
//font_thickness = 5; //[1.3:3]
//default uploaded image height 10
//image_height = 0; //[-50:50]
  
//whether embossed(outwards) or engraved(inwards) text
text_allignment="embossed"; //[embossed,engraved]
// Load a 100x100 pixel image. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
//image_file = "image-surface.dat"; // [image_surface:100x100]

// END CUSTOMIZER

if(text_allignment=="embossed"){
	union(){
		poly(1);
		if (show_text=="yes") {
		textPart();
		}//end-of-show_text
	}
}
if(text_allignment=="engraved"){
  render()
	difference(){
		poly(1);
		if (show_text=="yes") {
		textPart();
		}//end-of-show_text
	}
}
module textPart(){
//  if(text_font=="stencil_TNH.dxf"){
//	translate([-1,-5.5,10])
//	color("salmon")
//	rotate(-90,[0,1,0])
//	rotate(90,[1,0,0])
//	rotate(-90,[0,0,1])
//	write(text_itself,t=1.6,bold=0,h=text_size,font=text_font,space=1.3, center = true);
//  writecylinder(text=text_itself,where=[0,7,-38.5],radius=7,height=66,rotate=90,t=font_thickness,bold=1,h=text_size,font=text_font,space=1.3);
//  }
//  if(text_font!="stencil_TNH.dxf"){
	translate([0,-5.5,10])
	color("salmon")
	rotate(-90,[0,1,0])
	rotate(90,[1,0,0])
	rotate(-90,[0,0,1])
	write(text_itself,t=1.6,bold=0,h=text_size,font=text_font,space=1.3, center = true);
//  }

}

//poly(1);
module poly(scale) {polyhedron(
 points=[[-1.000000e+001,-5.635398e+000,0.000000e+000],[-1.000000e+001,5.635398e+000,0.000000e+000],[1.000000e+001,5.635398e+000,0.000000e+000],[1.000000e+001,5.635398e+000,0.000000e+000],[1.000000e+001,-5.635398e+000,0.000000e+000],[-1.000000e+001,-5.635398e+000,0.000000e+000],[-1.000000e+001,-5.635398e+000,2.000000e+001],[1.000000e+001,-5.635398e+000,2.000000e+001],[1.000000e+001,5.635398e+000,2.000000e+001],[1.000000e+001,5.635398e+000,2.000000e+001],[-1.000000e+001,5.635398e+000,2.000000e+001],[-1.000000e+001,-5.635398e+000,2.000000e+001],[-1.000000e+001,-5.635398e+000,0.000000e+000],[1.000000e+001,-5.635398e+000,0.000000e+000],[1.000000e+001,-5.635398e+000,2.000000e+001],[1.000000e+001,-5.635398e+000,2.000000e+001],[-1.000000e+001,-5.635398e+000,2.000000e+001],[-1.000000e+001,-5.635398e+000,0.000000e+000],[1.000000e+001,-5.635398e+000,0.000000e+000],[1.000000e+001,5.635398e+000,0.000000e+000],[1.000000e+001,5.635398e+000,2.000000e+001],[1.000000e+001,5.635398e+000,2.000000e+001],[1.000000e+001,-5.635398e+000,2.000000e+001],[1.000000e+001,-5.635398e+000,0.000000e+000],[1.000000e+001,5.635398e+000,0.000000e+000],[-1.000000e+001,5.635398e+000,0.000000e+000],[-1.000000e+001,5.635398e+000,2.000000e+001],[-1.000000e+001,5.635398e+000,2.000000e+001],[1.000000e+001,5.635398e+000,2.000000e+001],[1.000000e+001,5.635398e+000,0.000000e+000],[-1.000000e+001,5.635398e+000,0.000000e+000],[-1.000000e+001,-5.635398e+000,0.000000e+000],[-1.000000e+001,-5.635398e+000,2.000000e+001],[-1.000000e+001,-5.635398e+000,2.000000e+001],[-1.000000e+001,5.635398e+000,2.000000e+001],[-1.000000e+001,5.635398e+000,0.000000e+000] ],
triangles=[[0,1,2],[3,4,5],[6,7,8],[9,10,11],[12,13,14],[15,16,17],[18,19,20],[21,22,23],[24,25,26],[27,28,29],[30,31,32],[33,34,35]]);}

//object1(1);

