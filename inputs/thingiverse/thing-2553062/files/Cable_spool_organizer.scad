/*
Another customizable version by Marko22: https://www.thingiverse.com/Marko22/designs
Customizeable version of: http://www.thingiverse.com/thing:427024 by cheewee2000)
Made by Ben Wittbrodt (http://www.thingiverse.com/BenWittbrodt/)
*/

/*[Customizer Variables]*/

//Which part would you like to render?
part			=	"both"; //[top:Top, bottom:Bottom, both:Both]
//Radius of the outer guard for the spooler
big_radius	=	70;	//[20:80]
//Thickness of the flange of the outer guard
flange_thick	=	2;	//[1:4]	
//Radius of the circle cutouts on outer guard
cut_radius	=	12;	//[0:20]
//Radius of the middle cylindrical cutout
small_radius	=	30;	//[2:50]
//Thickness of the winding area (where the cord will be)
winding_thick	=	30;	//[5:50]
//Cutouts count
cutouts_count	=	12; //[0:30]

/*[hidden]*/
$fn=100;

output();

module output()
{
	if (part == "top") {
		top();
	} else if (part == "bottom") {
		bottom();
	} else if (part == "both") {
		top();
		translate([big_radius*2+5,0,0])
		bottom();
	} 
}

module top()
{
	difference()
	{
		union()
		{
			cylinder(r=big_radius, h=flange_thick); //Outer flange

			cylinder(r=small_radius+flange_thick, h=flange_thick+winding_thick);	//Inner cylinder
		}

		for (i=[1:cutouts_count])
		{
			rotate([0,0,(360/cutouts_count)*i])
				translate([big_radius / 2 + small_radius / 2,0,-.1])
					cylinder(r=cut_radius,h=flange_thick+.2); //Flange cutouts
		}

		translate([0,0,-.15])
			cylinder(r=small_radius, h=winding_thick+flange_thick*2+0.2);	//inner radius cutout

		translate([-small_radius-flange_thick,0,flange_thick*3])
			cube([small_radius*2+(2*flange_thick),3,winding_thick]);		//locking slot
	}
}

module bottom()
{
	difference()
	{
		union()
		{
			cylinder(r=big_radius, h=flange_thick);	//Outer flange
			cylinder(r=small_radius-.2, h=flange_thick+winding_thick);	//Inner cylinder

			translate([-small_radius-flange_thick,0,flange_thick*2])
				cube([small_radius*2+(2*flange_thick),3,winding_thick-(flange_thick*2)]);  //locking tabs
		}

		for (i=[1:cutouts_count])
		{
			rotate([0,0,(360/cutouts_count)*i])
				translate([big_radius / 2 + small_radius / 2,0,-.1])
					cylinder(r=cut_radius,h=flange_thick+.2); //Flange cutouts
		}

		translate([0,0,-.15])
		cylinder(r=small_radius-flange_thick, h=winding_thick+flange_thick*2+0.2); //Inner cylinder cutout
	}
}