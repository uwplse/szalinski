// Joe Stubbs
// February 24 2012
// http://www.thingiverse.com/thing:53816


use <utils/build_plate.scad>

use<Write.scad>
include <write/Write.scad>


$fn=100*1;


//pick from the list of available bracelet sizes
bracelet_size = 65; //[35:0-6 Mos,39:6-12 Mos,44:12-24 Mos,48:2-5 Yrs,52:6-8 Yrs,57:9-13 Yrs,62:Women's Petite,65:Women's Small,68:Women's Medium,75:Women's Large,80:Women's Plus,86:Women's Ankle,70:Men's Small,73:Men's Medium,78:Men's Large,83:Men's Plus]

//enter your custom inscription
inscription = "Best Friends!";

emboss_or_engrave = 1; // [0:Emboss,1:Engrave]

//select the font of your choice
font = "write/knewave.dxf"; //["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy,"write/braille.dxf":Braille,"write/knewave.dxf":Smooth]


//font = "BlackRose.dxf"
//font = "orbitron.dxf"
//font = "knewave.dxf"
//font = "braille.dxf"

//font height should be less than the top surface width
font_height = 10; // [4:20]
font_depth = 2; // [1,2,3,4]


bottom_style = 1; //[1:Split Bottom,0:Continuous]

//width of the surface where the inscription will go
top_surface_width_in_millimeters = 20; // [8:30]

//width near the bottom of your wrist
bottom_surface_width = 0.25; //[0.25:Small,0.45:Medium,0.75:Large,.99:Full]

//thinkness of the braclet under the inscription
top_thinkness_in_millimeters = 5; //[5:10]

//thinkness near the bottom of your wrist
bottom_thinkness_in_millimeters = 3; //[3:10]



//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);





inside_width = bracelet_size; // x
inside_height = inside_width * 55 / 65; // y




top_thick = top_thinkness_in_millimeters;
bottom_thick = bottom_thinkness_in_millimeters;

outside_width = inside_width + (top_thick + bottom_thick) / 2 * 2; // x
outside_height = inside_height + top_thick + bottom_thick; //y

bottom_gap_enable = bottom_style;
bottom_gap = inside_width *30/65;

//bottom_ball_enalbe = 1;
//bottom_ball = 5;

top_broad = top_surface_width_in_millimeters;
bottom_broad = top_surface_width_in_millimeters*bottom_surface_width;

fudge = 0.05*1;
talest = top_broad;



a = (top_broad - bottom_broad);
b = outside_height;
c = sqrt(a*a+b*b);

angle = asin(a/c) ;

echo("a", a ,"abs:",a/abs(a));
echo("angle", angle);



if (top_broad < bottom_broad) {
	echo("top_broad must be larger than bottom broad");
}


bracelet ();


module bracelet () {

//color([0.5,0.2,0.2])
rotate(a=-angle/2,v=[1,0,0])
translate (v=[0, 0,(top_broad+bottom_broad)/2/2]) 

difference () {
	// full shape
	scale (v=[outside_width/outside_height,1,1]) {
		cylinder(r = outside_height/2, h = talest, center = true);
		
		if (emboss_or_engrave==0) {
translate([0,0,font_height/6])
				writecylinder(inscription,[0,0,0],outside_height/2,0,rotate=0,font=font,
					t=font_depth,h=font_height);
		}

	}

	// inside cutout
	translate(v = [0, (top_thick-bottom_thick)/2, 0]) 
		scale (v=[inside_width/inside_height,1,1])
			cylinder(r = inside_height/2, h = talest+fudge, center = true);
	block_cuts();
	if(bottom_gap_enable==1){
		gap_cuts ();
	}


		if (emboss_or_engrave==1) {
		scale (v=[outside_width/outside_height,1,1]) 
translate([0,0,font_height/6])
			writecylinder(inscription,[0,0,0],(outside_height/2)-font_depth/2+fudge,0,rotate=0,//font=font,
				t=font_depth,h=font_height);
		}


}
}



//gap_cuts();

module block_cuts () {
	rotate (a=-angle/2,v=[1,0,0])
		translate(v = [0, 0, 25]) 
			translate(v = [0, 0, (bottom_broad+top_broad)/2/2]) 
				cube(size = [outside_width+10,outside_height+10,50], center = true);


	rotate (a=angle/2,v=[1,0,0])
		translate(v = [0, 0, -25]) 
			translate(v = [0, 0, -(bottom_broad+top_broad)/2/2]) 
				cube(size = [outside_width+10,outside_height+10,50], center = true);

}


module gap_cuts () {
		translate(v = [0, outside_height/2, 0]) 
	cube(size = [bottom_gap,outside_height,top_broad+bottom_broad+fudge], center = true);
}










