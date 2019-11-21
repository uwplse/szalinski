/* Lithophane Gallery by Bob Hamlet 5/2/13
 * Based on Customizable Lithopane with More http://www.thingiverse.com/thing:78719
 * 
 * Added support for multiple image panes.
 * Different type of hanger.
 * Rev 1 - adjustments to hanger placement, split tabs for upper and lower section. 5/24/13
 * Rev 2 - added the text pane to the bottom, minor difference bug fixes, fixed image height bug.  5/29/13
 * Rev 3 - added option for helper disks at outside corners, changed hanger depth to 1/2 total height. 6/1/13
 */

//use <write.scad>/////////////////////uncomment this line to use local copy/////////////////////////////////////////
use <write/Write.scad>/////////////comment out this line to use local copy//////////////////////////////////

// preview[view:south, tilt:top]

/* [Top Row Images] */

// First image on top row. Load a 100x100 pixel image.(images will be stretched to fit)  Simple photos work best.  Don't forget to click the Invert Colors checkbox!
image1 = "image-surface.dat"; // [image_surface:100x100]
// Second image on top row.  Don't forget to click the Invert Colors checkbox!
image2 = "image-surface.dat"; // [image_surface:100x100]
// Third image on top row. Don't forget to click the Invert Colors checkbox!
image3 = "image-surface.dat"; // [image_surface:100x100]
// Last image on top row. Don't forget to click the Invert Colors checkbox!
image4 = "image-surface.dat"; // [image_surface:100x100]

/* [Bottom Row Images] */

// First image on bottom row. Don't forget to click the Invert Colors checkbox!
image5 = "image-surface.dat"; // [image_surface:100x100]
// Second image on bottom row. Don't forget to click the Invert Colors checkbox!
image6 = "image-surface.dat"; // [image_surface:100x100]
// Third image on bottom row. Don't forget to click the Invert Colors checkbox!
image7 = "image-surface.dat"; // [image_surface:100x100]
// Last image on bottom row. Don't forget to click the Invert Colors checkbox!
image8 = "image-surface.dat"; // [image_surface:100x100]

/* [Text Message Pane] */

//How many lines of text at the botttom?
Text_Lines = 0; //[0,1,2]
//Enter your first line message here:
Top_Text = "First Line";
//Enter your second line message here:
Bottom_Text = "Second Line";
//How dark do you want your lettering?
Shade=2;//[1:Dark,2:Medium,3:Light]
//Choose your font

font = "write/knewave.dxf";//[write/BlackRose.dxf:Black Rose,write/braille.dxf:Braille,write/knewave.dxf:Knewave,write/Letters.dxf:Letters,write/orbitron.dxf:Orbitron]
////////////////////////////////////////////comment out the above line to use local copy//////////////////////////////////
//font = "knewave.dxf";/////////////////////uncomment this line to use local copy/////////////////////////////////////////

//How tall do you want your letters?
Text_Height=6;//[4:8]
//Letter spacing you want?
Letter_Spacing=12;//[6:40]
space=Letter_Spacing/10;

/* [Layout and Hangers] */

//Images 1-4.  If you want less, don't load images into remaining slots.
top_row = 2; //[1,2,3,4]
//Images 5-8.  Load image 5 for first image on bottom row, regardless of number of top row images.
bottom_row = 0; //[0,1,2,3,4]
//Choose the number of hanger loops.
hangers = 2; //[0,1,2,3]

/* [Borders] */

hanger_opening = 5; //[2:10]
hanger_thickness = 2; //[2:10]
// Set value to zero for no border. (Not recommended)
pane_border = 1;//[0:3]

/* [Slicing and Printing] */

// What layer height will you slice this at?  The thinner the better.
layer_height = 0.2;
// The lower the layer height, the more layers you can use.  More layers means more even shading.
number_of_layers = 16; // [5:20]
//Do you want to include helper disks at the corners to help prevent lifting?
helper_disks=0;//[1:Yes,0:No]

/* [Hidden] */
images = [image1, image2, image3, image4, image5, image6, image7, image8];
s = 0.01; // used for difference
length = 50; // Surface / 2
min_height = layer_height*2;// base (white) will always be 2 layers thick
inhole_radius = hanger_opening/2;
outhole_radius = inhole_radius+hanger_thickness;
height = layer_height*number_of_layers+min_height;
hang_length = top_row*(length+pane_border)+pane_border-outhole_radius*2;
hang_height = length/2+pane_border;
topboxlen=top_row*(length+pane_border)+pane_border;
bottomboxlen=bottom_row*(length+pane_border)+pane_border;
longer=(topboxlen>bottomboxlen)?topboxlen:bottomboxlen;

assembly();

module assembly(){
	union(){
		if (bottom_row<1){
			toplayout(top_row);
			hangers();
			message(topboxlen);
			helpers(topboxlen,topboxlen);
		}
		else{
			translate([0,(length+pane_border)/2,0]){
				toplayout(top_row);
				hangers();
				helpers(topboxlen,longer);
			}
			translate([0,-(length+pane_border)/2,0]){
				bottomlayout(bottom_row);
				message(bottomboxlen);
				helpers(longer,bottomboxlen);
			}
		}
	} // end union
} // end assembly module

module toplayout(row){
	translate([-(row-1)*(length+pane_border)/2,0,0]){
		for(i=[1:row])translate([(i-1)*(length+pane_border),0,0])pane(images[i-1]);
	} // end translate
} // end toplayout module

module bottomlayout(row){
	translate([-(row-1)*(length+pane_border)/2,0,0]){
		for(i=[1:row])translate([(i-1)*(length+pane_border),0,0])pane(images[i+3]);
	} // end translate
} // end bottomlayout module

module pane(image){
	union() {
		// Cut off unwanted bottom portion
		difference(){
    		translate([0,0,min_height]) scale([.5,.5,height-min_height]) surface(file=image,center=true,convexity=5);
		// -
			translate([0,0,-height+min_height-s])linear_extrude(height=height-min_height+s)square(length+s,center=true);
		} // end difference
		// Make the frame and white base
		difference(){
			linear_extrude(height=height) square(length+(pane_border*2),center=true);
		// -
			translate([0,0,min_height])linear_extrude(height=layer_height*number_of_layers) square(length+s,center=true);
		} // end difference
	} // end union
} // end pane module

module hangers(){
if (hangers==1){u();}
if (hangers>1){
	translate([-(hang_length)/2,0,0]){
		for(i=[1:hangers])translate([(i-1)*(hang_length)/(hangers-1),0,0])
			u();
	} // end translate
} // end if
} // end hangers module

module u(){
render()
	translate([0,hang_height,0]){
		translate([0,hanger_thickness,0])disk();
		difference(){
			union(){
				translate([0,outhole_radius/2,height/4])cube([outhole_radius*2,outhole_radius,height/2],center=true);
				translate([0,outhole_radius,height/4])cylinder(h=height/2,r=outhole_radius,center=true,$fn=50);
			} // end union
		// -
			translate([0,outhole_radius/2,height/4-s])cube([inhole_radius*2,outhole_radius,height/2+2*s],center=true);
			translate([0,outhole_radius,height/4-s])cylinder(h=height/2+2*s,r=inhole_radius,center=true,$fn=50);
		} // end difference
	} // end translate
} // end module

module message(len){
	if (Text_Lines>0){
		difference(){
			translate([0,-hang_height-Text_Lines*Text_Height/2-1,height/2])cube([len,Text_Lines*Text_Height+2+2*pane_border,height],center=true);
			translate([0,-hang_height-Text_Lines*Text_Height/2-1+s,height/2+min_height])cube([len-2*pane_border+s,Text_Lines*Text_Height+2+s,height],center=true);
		} // end difference
		translate([space,-hang_height-(Text_Height/2+1/Text_Lines)+pane_border/2,height/Shade/2])write(Top_Text,font=font,t=height/Shade,h=Text_Height,space=space,center=true);
		if (Text_Lines>1){
			translate([space,-hang_height-0.5-Text_Height*1.5,height/Shade/2])write(Bottom_Text,font=font,t=height/Shade,h=Text_Height,space=space,center=true);
		} // end if
	} // end if
} // end module

module helpers(up,down){
	for(a=[0,1]){
		mirror([a,0,0]){
			translate([up/2,hang_height,0])disk();
			translate([down/2,-hang_height,0])disk();
		} // end mirror
	} // end for
} // end module

module disk(){
	translate([0,0,layer_height/2])cylinder(h=layer_height*helper_disks,r=hanger_opening+3*hanger_thickness,center=true,$fn=50);
}