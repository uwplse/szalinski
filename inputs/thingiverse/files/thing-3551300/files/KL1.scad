//Reproduction case for KL-1 Round Russian Slide Rule Calculator
//Written as an OpenSCAD learning exercise, so reader user beware!

//Good results printing with Hatchbox PLA
//At 188 deg and 0.15mm layer height

/* [Global] */
// Choose Bottom, Top, or Both
part = "both"; // [bottom:Bottom Only,top:Top Only,both:Bottom and Top]

// Change in radius along the ramps
Ramp_Delta	= 0.75; 
//Number of ramp sections
Num_Ramps	= 6;   //[2,3,4,6,8,9,12]
//clearance between top and bottom in open position
Clearance			= 0.50; 
//rounding diameter for top/bottom edges
Dia_Round	=	3; 

/* [Bottom] */
//Inside diameter of bottom
ID_Bottom     		= 57.0;
//Height of Bottom excluding ring
Ht_Bottom     		=  9.2;
// Minimum thickness of wall around bottom. 
Thk_Bottom_Wall		=  1.5;
// Thickness of bottom
Thk_Bottom    		= 1.5;
//Height of Bottom Ring
Ht_Bottom_Ring 		= 4.0;
// Minimum thickness of the ring
Thk_Bot_Ring		= 1.5;

/* [Top] */
//Total (Outside) Height of Top
Ht_Top     		= 10.7;
// Thickness of Top in mm
Thk_Top    		= 1.5; 
// Minimum thickness of wall around top. 
Thk_Top_Wall	= 1.5; 
//Depth of inlaid text
Top_Text_Depth	= .75; 
// Text to print on top
Top_Text		="\u041A\u041B-1";//"KL-1" in Cyrillic
// Left offset to start text
Top_Text_Offset	= 15;


/* [Hidden] */
$fa=1;
Fave_Color			= [0.9, 0.5, 0.25]; //main color
Alt_Color			= [0.5, 0.5, 1];    //color for ring for visual contrast

Pad					= 0.01; //Tiny bit extra to ensure clean manifold 

OD_BotLip_Min 		= ID_Bottom     + 2 * Thk_Bot_Ring; 
OD_BotLip_Max		= OD_BotLip_Min + 2 * Ramp_Delta;

OD_Bottom			= max(ID_Bottom + 2 * Thk_Bottom_Wall, OD_BotLip_Max); //Make sure ring doesn't overhang the bottom

ID_Top_Max 			= OD_BotLip_Max + 2 * Clearance;
ID_Top_Min 			= OD_BotLip_Min + 2 * Clearance;
OD_Top 	   			= ID_Top_Max + Thk_Top_Wall;

/*Calculate volume? Why not*/
IRad_Bottom		=	ID_Bottom/2; //Internal Radius of the Bottom
pi=3.14;
internal_height =	(Ht_Bottom-Thk_Bottom + max(Ht_Bottom_Ring,Ht_Top-Thk_Top));	//max() checks for bottom ring so tall it holds up the top.
//Note that we are ignoring any additional volume due to the radius of the top being larger than that of the bottom.
//Fix this if it ever becomes an important concern. 
Volume=pi*pow(IRad_Bottom,2) * internal_height/1000;	//cm^3. 

//Container Configuration Check:
echo("ID Bottom is ", ID_Bottom, "mm.");
echo("OD Bottom is ", OD_Bottom);
echo("OD Top is", OD_Top);
echo("When lid is placed, there is ", (ID_Top_Min - OD_BotLip_Min)/2, "mm clearance.");
echo("And", (ID_Top_Max - OD_BotLip_Max)/2, "mm clearance.");
echo("At full closure there is", (ID_Top_Min - OD_BotLip_Max)/2, "mm clearance.");
echo("Bottom Lip OD varies from", OD_BotLip_Min, "to", OD_BotLip_Max);
echo("Top Cover ID varies from", ID_Top_Min, "to", ID_Top_Max);
echo("Top Ramp Delta is", (ID_Top_Max - ID_Top_Min)/2);
echo("Bot Ramp Delta is", (OD_BotLip_Max - OD_BotLip_Min)/2);
echo("Bottom storage space is",Ht_Bottom-Thk_Bottom,"mm.");
echo("Top storage space is",Ht_Top-Thk_Top,"mm.");
echo("Total storage space is",Ht_Bottom-Thk_Bottom+Ht_Top-Thk_Top,"mm.");
echo("Bare minimum is about 15, and original is about 18mm for the KL-1.");
echo("Volume is about", Volume, "cc.");

module print_part() {
/* 	This module produces either the top, bottom, or both parts.
	use of the variable named "part" is specified in the
	Customizer documentation to make script work on Thingiverse
	When a user customizes this item, Customizer will loop thru
	all possible values of "part" and create separate
	.STL models for the cases
 */	
	if (part == "bottom") {
		bottom();
	} else if (part == "top") {
		top();
	} else {
		translate([-OD_Bottom/2-5,0,0])
		bottom();
		translate([OD_Top/2+5,0,0])
		top();
/* 				bottom();
		rotate([0,0,-0*60])
		translate ([0,0, Ht_Bottom+Ht_Bottom_Ring+Ht_Top/2+1])
		rotate([180,0,0])
		translate([0,0,-Ht_Top/2])
		#top();
  */	}
}


module ratchet(min_r=29.4, max_r=29.9, h=4.35, n=6, step=5){
/*  ratchet creates a circular ring of height h with n sections
    which vary like a ramp from a min to a max radius
	n and step must be chosen such that 360/n is a multiple of step
	for example, choosing n=8 and step=10 will fail because 10 does not divide 360/8 evenly
	I restricted choices of n in customizer to protect as long as step==5
	 */
	 
    deg_per_sec = 360/n;
	diff_r = max_r - min_r;
	echo("min_d=", 2*min_r, "max_d=", 2*max_r);

	
	for(s=[0:n]) //repeat for each section
	rotate([0,0,s*deg_per_sec])
	hull()
		for(r=[0:step:deg_per_sec])
			rotate([0,0,-r])       // operating in the -r direction sets the rotation direction to clockwise
			cube([min_r + diff_r * r/deg_per_sec, 0.01, h]);
}

module bottom(){
//bottom ring
color(Alt_Color)
translate([0,0,Ht_Bottom-Pad])
difference(){
ratchet(min_r=OD_BotLip_Min/2, max_r=OD_BotLip_Max/2, h=Ht_Bottom_Ring+Pad, n=Num_Ramps, step=5);
translate([0,0,-Pad]) //Pad to ensure clean manifold	
cylinder(r=IRad_Bottom, h=Ht_Bottom_Ring+3*Pad);
		}
		
//bottom
color(Fave_Color)
difference(){
r_cyl(r=OD_Bottom/2, h=Ht_Bottom, d=Dia_Round);
translate([0,0,Thk_Bottom])
cylinder(r=IRad_Bottom, h=Ht_Bottom-Thk_Bottom+Pad);
}
 
 }
  
module top() {
color(Fave_Color)
difference(){
r_cyl(r=OD_Top/2, h=Ht_Top);
translate([0,0,Thk_Top]) //cut the ratchet shape out of the interior, leaving desired thickness
ratchet(min_r=ID_Top_Max/2, max_r=ID_Top_Min/2, h=Ht_Top, n=Num_Ramps, step=5);
invtext();
}
}
module invtext(txt=Top_Text,pos=Top_Text_Offset, h=Top_Text_Depth){
translate([-pos,0,h]) //back to just below top surface to etch text
rotate([180,0,0]) //flips 180 around x axis for writing text
linear_extrude(height = h+Pad) { 
       text(text = txt, font = "Liberation Sans", size = 10, valign="center");
}
}

module r_cyl(r=25, h=10, d=Dia_Round){
translate([0,0,d/2]) cylinder(r=r,h=h-d/2);
translate([0,0,d/2]) 
		minkowski() {
		cylinder(r=r-d/2,h=h-d);
		sphere(d=d);
		}
		
		}

print_part();