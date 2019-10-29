/*
OpenSCAD-File to create a credit card shaped card with text
2013-11-03 - Rikard Lindström (ornotermes@gmail.com)

Based on:
OpenSCAD-File to generate a Customized luggage label
2013-11-01 - kowomike

Needs write.scad as found here:
https://github.com/rohieb/Write.scad

or here:
http://www.thingiverse.com/thing:16193
*/

// preview[view:south, tilt:top]

use <write/Write.scad>  //Change to directory where write.scad resides;

// Enter Text here
// Use up to 9 lines as needed; for alignment to center or right, use spaces

/* [Text] */
// You can use (up to) 9 lines for text
line_1="SLASHHOME.SE   SE";
line_2="61:D0:73:50    SC";
line_3="50:73:E2:61    HD";
line_4="7F:F7:A7:DC    -S";
line_5="36:04:4A:06     A";
line_6="";
line_7="";
line_8="";
line_9="";

/* [Text options] */
//Choose text engraving, embossing oder hiding inside
text_style=-25; // [-80:Deep engraving (80 %),-50:Half way through engraving (50 %),-25:Medium engraving (25 %),-10:Shallow engraving (10 %),10:Little embossing (10 %),25:Heavy embossing (25 %) ,50:Extra heavy embossing (50 %)] 

font="orbitron.dxf"; //[write/orbitron.dxf:Futuristic,write/Letters.dxf:Basic,write/knewave.dxf:Round,write/BlackRose.dxf:Classic,write/braille.dxf:Braille]

//Height of characters [mm]
fontsize=6;  //[4:10]						  

letter_spacing=1; //[-2:5]
letterspacing=1.0+letter_spacing/10;		 

line_spacing=2; //[0:5]
linespacing=0.7+line_spacing/10; 	

/* [Plate options] */

// [mm]
plate_thickness=1; //[1:5]

/* [Hidden] */

//Copy single text variables into array
text=[
line_1,
line_2,
line_3,
line_4,
line_5,
line_6,
line_7,
line_8,
line_9,
];

//Define additional parameters
charlength=0.686;
charheight=1.45;
descenderfactor=0.25;

//ISO/IEC 7810 ID-1 size (mm)
width = 85.6;
height = 53.98;
thickness = 0.76;
corner_radius = 3;

//Calculate margins
margin=2*sqrt(corner_radius);

//Calculate how much text will fit.
cols = (width - 2 * margin) / (fontsize * (charlength + letterspacing));
rows = (height - 2 * margin) / (fontsize * (charheight + linespacing));

//Thickness of text when hidden
hiddenheight=66;

//Find out maximum characters for first 10 lines for centering
maxtextchars = max(len(text[0]),len(text[1]),len(text[2]),len(text[3]),len(text[4]),len(text[5]),len(text[6]),len(text[7]),len(text[8]),len(text[9]));

//Find out how many lines do contain text
tl=[
len(text[8])>0 ? 9 : 0,
len(text[7])>0 ? 8 : 0,
len(text[6])>0 ? 7 : 0,
len(text[5])>0 ? 6 : 0,
len(text[4])>0 ? 5 : 0,
len(text[3])>0 ? 4 : 0,
len(text[2])>0 ? 3 : 0,
len(text[1])>0 ? 2 : 0,
len(text[0])>0 ? 1 : 0,
];

textlines=max(tl[0],tl[1],tl[2],tl[3],tl[4],tl[5],tl[6],tl[7],tl[8],tl[9]);

//Calculate plate size based on Text
linelength=maxtextchars*charlength*fontsize+(letterspacing-1)*(maxtextchars-1)*charlength*fontsize;
lineheight=charheight*fontsize;


//Part of plate with text
difference () {
	//Plate
	translate ([0,-height,0])
	cube (size = [width,height,plate_thickness]);

	//"Add" Text if engraved
	if (text_style<0) {
	translate ([margin,-margin - lineheight,0])
		union () {
			for (i=[0:textlines-1]) {
			translate ([0,-lineheight*i+descenderfactor*lineheight-(linespacing-1)*lineheight*i,plate_thickness+plate_thickness*text_style/100-0.05])
			write(text[i],t=abs(text_style)*plate_thickness/100+0.1,h=fontsize,font=font,space=letterspacing);
			}
		}
	}

	if (text_style==0) {
	translate ([margin+insertlength,0,0])
		union () {
			for (i=[0:textlines-1]) {
			translate ([0,-lineheight*i+descenderfactor*lineheight-(linespacing-1)*lineheight*i,plate_thickness+plate_thickness*text_style/100-0.05-(plate_thickness+(plate_thickness*hiddenheight/100))/2])
			write(text[i],t=hiddenheight*plate_thickness/100+0.1,h=fontsize,font=font,space=letterspacing);
			}
		}
	}


	//Cut rounded corners

	//Top Right
	translate ([0,0,0])
	translate ([width-corner_radius,-corner_radius,-0.05])
	difference () {
		cube ([corner_radius*2,corner_radius*2,plate_thickness+0.1]);
		translate ([0,0,-0.1])
		cylinder (r=corner_radius,h=plate_thickness+0.2,$fn=50);
	}

	//Bottom Right
	translate ([0,0,0])
	translate ([width-corner_radius,-height+corner_radius,-0.05])
	difference () {
		translate ([0,-corner_radius*2,0])
		cube ([corner_radius*2,corner_radius*2,plate_thickness+0.1]);
		translate ([0,0,-0.1])
		cylinder (r=corner_radius,h=plate_thickness+0.2,$fn=50);
	}

	//Top Left
	translate ([0,0,0])
	translate ([corner_radius,-corner_radius,-0.05])
	difference () {
		translate ([-corner_radius*2,0,0])
		cube ([corner_radius*2,corner_radius*2,plate_thickness+0.1]);
		translate ([0,0,-0.1])
		cylinder (r=corner_radius,h=plate_thickness+0.2,$fn=50);
	}

	//Bottom Left
	translate ([0,0,0])
	translate ([corner_radius,-height+corner_radius,-0.05])
	difference () {
		translate ([-corner_radius*2,-corner_radius*2,0])
		cube ([corner_radius*2,corner_radius*2,plate_thickness+0.1]);
		translate ([0,0,-0.1])
		cylinder (r=corner_radius,h=plate_thickness+0.2,$fn=50);
	}


}  //End difference

//Add text if embossed
if (text_style>0) {
	translate ([margin,-margin - lineheight,0])
		color ("YellowGreen")
		union () {
			for (i=[0:textlines-1]) {
			translate ([0,-lineheight*i+descenderfactor*lineheight-(linespacing-1)*lineheight*i,plate_thickness])
			write(text[i],t=abs(text_style)*plate_thickness/100+0.1,h=fontsize,font=font,space=letterspacing);
			}
}
}
