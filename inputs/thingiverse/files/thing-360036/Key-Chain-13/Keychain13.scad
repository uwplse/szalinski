use <write/Write.scad> // use <Write.scad>
// preview[view:south, tilt:top]


//
// CUSTOMIZING

/* [Text] */ //Choose to add text
//Do you want to add text?
show_text="yes"; //[yes,no]
//Text Font
text_font="knewave.dxf";//[knewave.dxf:Knewave, Letters.dxf:Letter, orbitron.dxf:Orbitron, BlackRose.dxf:BlackRose, braille.dxf:Braille]
//What do you want the text to say?
text_itself="JOHN"; 
//default at position [0,0,0]
//text left to right
//XposText = -9; //[-5:5]
//y to come in front
//YposText = 1.5; //[-50:50]
//text bottom to top
//ZposText = 2; //[1:20]

//whether embossed(outwards) or engraved(inwards) text
text_allignment="engraved"; //[embossed,engraved]

//Text size(height)
text_size = 8; //[8:11]
//Spacing between adjacent letters
//text_spacing=1.5;

//default uploaded image height 10
//image_height = 0; //[-50:50]
  
// Load a 100x100 pixel image. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
//image_file = "image-surface.dat"; // [image_surface:100x100]


//
// ASSEMBLE BUILDING
//
if(text_allignment=="embossed"){
    union(){
		keychain(1);
		if (show_text=="yes") {
		textPart();
		}//end-of-show_text
	}
}
if(text_allignment=="engraved"){
	render()
	difference(){
		keychain(1);
		if (show_text=="yes") {
		textPart1();
		}//end-of-show_text
	}
}

module textPart(){

//	translate([0,-0.5,0])
	translate([12,20,1.4]){
rotate(130,[0,0,1])
//rotate(-20,[0,0,1])
  	//   scale([text_size,text_size,text_size]){
			color("salmon")

			write(text_itself,t=1.3,h=text_size,font=text_font,space=1.3, center = true);	

		}
}

module textPart1(){

//	translate([0,-0.5,0])
	translate([12,20,1.4]){
rotate(130,[0,0,1])

  	//   scale([text_size,text_size,text_size]){
			color("salmon")

			write(text_itself,t=1.3,h=text_size,font="Letters.dxf",space=1.3, center = true);	

		}
}

module keychain(scale) {
$fn=20;
scale([5,5,5])
minkowski()
{
linear_extrude(height = 0.2, center = true, convexity = 10, twist = 0)
polygon(points=[[2,0],[4,0],[5,1],[5,6],[3,8],[1,8],[0,7],[0,2]
,[2,0.5],[4,0.5],[0.5,4],[0.5,2]
],
paths=[[0,1,2,3,4,5,6,7],[8,9,10,11],[12,13,14,15]]);
cylinder(h=0.2,r=0.3,center=true);
}
}