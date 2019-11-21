/*
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
// Use up to 10 lines as needed; for alignment to center or right, use spaces

/* [Text] */
// You can use (up to) 10 lines for text
line_1="Just enter";
line_2="name and";
line_3="address";
line_4="";
line_5="";
line_6="";
line_7="";
line_8="";
line_9="";
line_10="";

/* [Text options] */
//Choose text engraving, embossing oder hiding inside
text_style=-80; // [-80:Deep engraving (80 %),-50:Half way through engraving (50 %),-10:Shallow engraving (10 %),0: Hide text inside (takes 66 %),10:Little embossing (10 %),25:Heavy embossing (25 %) ] 

font="orbitron.dxf"; //[write/orbitron.dxf:Futuristic,write/Letters.dxf:Basic,write/knewave.dxf:Round,write/BlackRose.dxf:Classic,write/braille.dxf:Braille]

//Height of characters [mm]
fontsize=8;  //[5:20]						  

letter_spacing=1; //[-2:5]
letterspacing=1.0+letter_spacing/10;		 

line_spacing=2; //[0:5]
linespacing=0.7+line_spacing/10; 	

/* [Plate options] */

// [mm]
plate_thickness=3; //[1:5]

//Radius of plate corners [mm]
corner_radius=3; //[1:10]
 
// [mm]
slitlength=12; //[2:30]		 

// [mm]
slitwidth=4; //[2:10]	



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
line_10
];

//Define additional parameters
charlength=0.686;
charheight=1.45;
descenderfactor=0.25;

//Calculate margins
margin=2*sqrt(corner_radius);

//Calculate space for slit
insertlength=slitwidth+margin;

//Thickness of text when hidden
hiddenheight=66;

//Find out maximum characters for first 10 lines for centering
maxtextchars = max(len(text[0]),len(text[1]),len(text[2]),len(text[3]),len(text[4]),len(text[5]),len(text[6]),len(text[7]),len(text[8]),len(text[9]));

//Find out how many lines do contain text
tl=[
len(text[9])>0 ? 10 : 0,
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
	translate ([0,-lineheight*(textlines-1)-(linespacing-1)*lineheight*(textlines-1)-margin,0])
	cube ([linelength+margin*2+insertlength,+lineheight*(textlines-1)+(linespacing-1)*lineheight*(textlines-1)+margin+lineheight+margin,plate_thickness]);

	//"Add" Text if engraved
	if (text_style<0) {
	translate ([margin+insertlength,0,0])
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
	translate ([margin+insertlength,0,0])
	translate ([linelength+margin-corner_radius,lineheight+margin-corner_radius,-0.05])
	difference () {
		cube ([corner_radius*2,corner_radius*2,plate_thickness+0.1]);
		translate ([0,0,-0.1])
		cylinder (r=corner_radius,h=plate_thickness+0.2,$fn=100);
	}

	//Bottom Right
	translate ([margin+insertlength,0,0])
	translate ([linelength+margin-corner_radius,-lineheight*(textlines-1)-(linespacing-1)*lineheight*(textlines-1)-margin+corner_radius,-0.05])
	difference () {
		translate ([0,-corner_radius*2,0])
		cube ([corner_radius*2,corner_radius*2,plate_thickness+0.1]);
		translate ([0,0,-0.1])
		cylinder (r=corner_radius,h=plate_thickness+0.2,$fn=100);
	}

	//Top Left
	translate ([0,0,0])
	translate ([corner_radius,lineheight+margin-corner_radius,-0.05])
	difference () {
		translate ([-corner_radius*2,0,0])
		cube ([corner_radius*2,corner_radius*2,plate_thickness+0.1]);
		translate ([0,0,-0.1])
		cylinder (r=corner_radius,h=plate_thickness+0.2,$fn=100);
	}

	//Bottom Left
	translate ([0,0,0])
	translate ([corner_radius,-lineheight*(textlines-1)-(linespacing-1)*lineheight*(textlines-1)-margin+corner_radius,-0.05])
	difference () {
		translate ([-corner_radius*2,-corner_radius*2,0])
		cube ([corner_radius*2,corner_radius*2,plate_thickness+0.1]);
		translate ([0,0,-0.1])
		cylinder (r=corner_radius,h=plate_thickness+0.2,$fn=100);
	}

	//Cut out hole
	translate ([margin,-lineheight*(textlines/2-1)-(linespacing-1)*lineheight*(textlines/2-1)-slitlength/2+slitwidth/2,-0.05])
	union () {
		translate ([slitwidth/2,slitlength-slitwidth,0])
		cylinder (r=slitwidth/2,h=plate_thickness+0.1,$fn=100);
		cube ([slitwidth,slitlength-slitwidth,plate_thickness+0.1]);		
		translate ([slitwidth/2,0,0])
		cylinder (r=slitwidth/2,h=plate_thickness+0.1,$fn=100);
	}
}  //End difference

//Add text if embossed
if (text_style>0) {
	translate ([margin+insertlength,0,0])
		color ("YellowGreen")
		union () {
			for (i=[0:textlines-1]) {
			translate ([0,-lineheight*i+descenderfactor*lineheight-(linespacing-1)*lineheight*i,plate_thickness])
			write(text[i],t=abs(text_style)*plate_thickness/100+0.1,h=fontsize,font=font,space=letterspacing);
			}
}
}

