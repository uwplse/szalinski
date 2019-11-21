////////////////////////
//  Nameplate Cardholder
//
//  Remix of Desktop nameplate
//  Thing:162367  and Thing:256837
//
//  RLazure
//
//  February 24, 2019
//  1) Add an optional business card holder to the desktop namplate.
//
//  2)Use Google fonts
//    Anton, Archivo Black, Baloo, BreeSerif-Regular, 
//		Courgette, FrancoisOne-Regular, Montserrat, Roboto-Black
//
//  3) small changes in geometry - triangular shape larger
//
//  4) Designed for a weighted base - set to 5% infill pause print to fill with
//		  aquarium gravel.
//
//////////////////////////////


///// inputs ////////////////

// What would you like to label?
label_text = "Startrek fan2";

// Business card holder?
cardholder = true;  // [true:false]

// How big?
font_size = 14; //[8:20]

// How much space on the ends?
end_space = 3; //[0:10]

// using Google fonts 
font_name = "Courgette"; // [Anton, Archivo Black, Baloo, BreeSerif-Regular, Courgette, FrancoisOne-Regular, Montserrat, Roboto-Black]

//  space between the letters
letter_spacing = 1.0; // [0.7:0.1:1.5]

//  adjust centering
tweak = 0;  // [-15:0.5:15]

//  Single or Dual Extrusion ?
part= "single"; // [single,dual-base,dual-text]

///////////////////

/* [Hidden] */
$fn = 100;
cardw= 92+4;  // add thickness of prisms each side
cardh=40;
cardt=1.5;
///////////////////  calculations  //////////////

width = (.65*font_size*letter_spacing); // Find width of each character
totalwidth = width * len(label_text); // Find total width of text

length_extrude = totalwidth+(end_space*width);
textz_start_pos = totalwidth/2;
textx_start_pos = (26-font_size)/2 + font_size;


///////////////////////////////////////
/////// modules ///////////////////////
//////////////////////////////////////
module myText(text_to_generate,font_size,nfont,character_spacing) {
// echo("text_to_generate",text_to_generate,"font_size",font_size,"nfont",nfont,"character_spacing",character_spacing);

    linear_extrude(height = 2) {
        text(text= text_to_generate,
            size = font_size,
            font = nfont,
            halign = "left",
            valign = "baseline",
            spacing = character_spacing,
            direction = "ltr",
            language = "en",
            script = "latin",
            $fn = 50);
    }
}

 module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );

}

module business_card(){
//
// adds backing to nameplate 
//
 rotate([0,90,90])
difference() {
union() {
color("red")
translate([0,10,cardt/2])cube([cardw,cardh,cardt], center = true);
color("blue")
rotate([0,0,180])translate([cardw/2-2,-cardh*0.75+10,0])prism(2,cardh*0.75,10);
color("blue")
rotate([0,0,180])translate([-cardw/2,-cardh*0.75+10,0])prism(2,cardh*0.75,10);
}

// take away this oval from the geometry above

color("green")
translate([0,cardh-10,0]) scale([1.5,1,1])cylinder(  20, d=40, center=true);
}


}

module base(){
//
//  base on which text rests
//
linear_extrude(height=length_extrude, center = true)
	polygon([[10,0],[0,18],[26,18],[18,0]], [[0,1,2,3]]);  // profile shape

}
module text_plate() {
//
// text on extrusion
//	
color("black")			
	translate([textx_start_pos,18.0,textz_start_pos+tweak]) rotate([0,90,90])
	myText(label_text,font_size,font_name,letter_spacing);

	}

module print_part()
				{
//
//  assembly depending on single or dual extruder
//	
if (part == "single") 
		{
			union() {
				base();
				text_plate();
				if (cardholder) {
		 			business_card();
					}
						}	
		} else if (part == "dual-base")
			{
				base();
				if (cardholder) {
					 business_card();
					}
		} else if (part == "dual-text")
			{
				text_plate();
		}

}

//////////////////////////////////////////////////////

// orient on platform

rotate([90,0,270])
translate([-14,0,0]) print_part();

// preview[view:south, tilt:top]