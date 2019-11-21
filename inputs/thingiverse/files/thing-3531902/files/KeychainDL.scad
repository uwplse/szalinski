/*****************************************************************************
	Simple Keychain     
	
	DeelTech.com
                                    
*****************************************************************************/

/* [Basic] */

//Base Length 10 - 120
Length = 64;  

//Width 2 - 12
Width = 5;  

//text Size (0.5 to 3)
TextSize = 1.3;

thickness = 2;

ring_diam = 7;

//What do you want the text to say?
MyText = "CHRIS";

//font = "Liberation Serif:style=Bold Italic";
//font = "Liberation Sans:style=Bold Italic";
//font = "ARIEL:style=Bold Italic";
//font = "Ariel:style=Bold";

font="Liberation Serif:style=Bold Italic"; // [Domine:Domine bold Italic, DejaVu Sans:DejaVu Sans Condensed Bold, Arial:Arial bold, Liberation Serif:Liberation Serif Bold Italic, Pacifico, Courgette, Ultra, Bevan ]




/* [Hidden] */

$fn = 50;

KeyChain();



module KeyChain()
{  
	//translate([-7.5, 0, -2])
	translate([0, -thickness, 0])
	cube([Length, thickness, Width]);

	translate([ring_diam, 0, 0])
	linear_extrude(height=Width)
	scale([TextSize, TextSize])
	{
		text(MyText, font = font);
	}
		
		
	translate([0, (ring_diam-thickness+1)/2, 0])
	difference() 
	{
		cylinder(h=Width, d=ring_diam+thickness+1);
		cylinder(h=Width+1, d=ring_diam);
	}
}  

