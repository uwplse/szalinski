/*
Author: Avp (Alexander Purikov)
Design is based on Ben Wittbrodt one: http://www.thingiverse.com/thing:435802
*/

/*[Customizer Variables]*/

//Which part would you like to render?
part			=	"both"; //[top:Top, bottom:Bottom, both:Both]
//Diameter of the outer guard for the spooler
big_diameter	=	50;	//[40:160]
//Thickness of the flange and spool walls
flange_thick	=	1;	//[1:4]	
//Diameter of the middle spool cylinder
cylinder_diameter	=	20;	//[10:40]
//Width of the winding area (where the wire will be)
winding_thick	=	10;	//[5:50]
//Width of the slots and holes for fastening wire ends
gaps_width		=	1; //[0:3]
//Diameter of the circle cutouts on outer guard
cut_diameter	=	0;	//[0:9]


/*[hidden]*/
$fa=5; $fs=0.75;
Clearance = 0.2;


big_radius = big_diameter/2;
small_radius = (cylinder_diameter-flange_thick*2)/2;
cut_radius = cut_diameter/2;

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

		for (i=[1:6])
		{
			rotate([0,0,60*i])
			translate([big_radius/2+cut_radius,0,-.1])
				cylinder(r=cut_radius,h=flange_thick+.2); //Flange cutouts
		}
		for (i=[1:3])
		{
			rotate([0,0,120*i+30])
				translate ([big_radius,0,0])
					cube ([big_radius/2,gaps_width,flange_thick*2+0.2], center=true);
		}

		if ( gaps_width > 0 )
		{
			rotate([0,0,30])
					translate ([small_radius+2/2+flange_thick,0,-0.1])
						cylinder ( r=(gaps_width<2) ? 1 : gaps_width/2, h=flange_thick+0.2 );
			
			translate([0,0,-.15])
				cylinder(r=small_radius, h=winding_thick+flange_thick*2+0.2);	//inner radius cutout
		}
		translate([-small_radius-flange_thick,-1.7,flange_thick*1+0.2])
			cube([small_radius*2+(2*flange_thick)+Clearance,3.2,winding_thick]);		//locking slot
	}
}

module bottom()
{
	difference()
	{
		union()
		{
			cylinder(r=big_radius, h=flange_thick);	//Outer flange
			cylinder(r=small_radius-Clearance, h=flange_thick+winding_thick);	//Inner cylinder

			translate([-small_radius-flange_thick,-1.5,flange_thick*2])
				cube([small_radius*2+(2*flange_thick),3,winding_thick-(flange_thick*2)]);  //locking tabs
		}

		for (i=[1:6])
		{
			rotate([0,0,60*i])
			translate([big_radius/2+cut_radius,0,-.1])
				cylinder(r=cut_radius,h=flange_thick+.2); //Flange cutouts
		}

		if ( gaps_width > 0 )
		{
			for (i=[1:3])
			{
				rotate([0,0,120*i+30])
					translate ([big_radius,0,0])
						cube ([big_radius/2,gaps_width,flange_thick*2+0.2], center=true);
			}
			
			rotate([0,0,30])
					translate ([small_radius+2/2+flange_thick,0,-0.1])
						cylinder ( r=(gaps_width<2) ? 1 : gaps_width/2, h=flange_thick+0.2 );
			}
		translate([0,0,-.15])
		cylinder(r=small_radius-flange_thick, h=winding_thick+flange_thick*2+0.2); //Inner cylinder cutout
	}
}