// Based on:
// mechanical deck box
// Andrew Hoadley
// License: erm... the one that means that you can do anything you like with it except sell it. :)

/* [Basic Settings] */

// Which part do you want to render?
part=0; // [0:Instructions,1:Front,2:Back,3:Left,4:Right,5:Gear rack,6:Hinged lid left,7:Hinged lid right,8:Hinge mount,9:Mechanism holder,10:Top hinge,11:Side hinge,12:Platform,13:Base,14:Plate A,15:Plate B,16:Plate C,17:Plate D,18:Plate E,19:Plate F,20:Plate G]

// Width of the card-storage area - should be the width of one of your cards
card_x = 70;

// Depth of the card-storage area - should be the thickness of the entire stack of cards. For example, 60 sleeved cards are about 40mm.
card_y = 75;

// Height of the card-storage area - should the height of one of your cards.
card_z = 100;

/* [Advanced Settings] */
// When rendering the AssembledLayout, explode parts by this amount. set to zero for normal assembly
explode = 0;

// Cylinder resolution. set it to 10 if you're mucking about, about 120 if you're exporting STL's
circle_resolution = 120;

// Printing Tolerance. There's probably some places where I've missed adding the tolerance.
// and your printer is probably better tuned than mine, so maybe it doesn't have to be this high for you.
printing_tolerance = 0.2;

/* [Printer] */
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 180; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 180; //[100:400]

/* [Hidden] */
// Specify a logo to stamp into the left side panel
left_logo = "none"; // [none:No Logo,manablue:Blue Mana,manared:Red Mana,manablack:Black Mana,manawhite:White Mana,managreen:Green Mana]

// Specify a logo to stamp into the right side panel
right_logo = "none"; // [none:No Logo,manablue:Blue Mana,manared:Red Mana,manablack:Black Mana,manawhite:White Mana,managreen:Green Mana]

// Specify a logo to stamp into the front panel
front_logo = "none"; // [none:No Logo,manablue:Blue Mana,manared:Red Mana,manablack:Black Mana,manawhite:White Mana,managreen:Green Mana]

// Specify a logo to stamp into the back panel
back_logo = "none"; // [none:No Logo,manablue:Blue Mana,manared:Red Mana,manablack:Black Mana,manawhite:White Mana,managreen:Green Mana]

// There needs to be a little clearance above the cards otherwise the mechanism gets caught when it rotates
card_clearance = 10;

// wall thickness
wall = 3;

hingeRad = 3;
hingeHole = 1;
etchDepth = 0.4;
printingGap = 3;

keyThickness = 2.4;

//Be a little more cautious with these
mechanism = 4;
slidewidth = 7;
rad = 25;
notchHeight = 13;
chx = 13; // this is the distance below the centre of the axes that the base is truncated
pivotrad = 5;
pivotheight = 3;

// Better not to touch these
ox = card_x /2 + wall;
oy = card_y /2 + mechanism + 2 * wall;
oz = card_z + card_clearance + wall*2;
ch = oz-rad; // height of the centre point of the axes that the lid rotates off
gearHeight = wall+ mechanism-printing_tolerance;

// Jitter is used to prevent coincident-surface problems with CSG. Should be set to something small.
j=0.1;


use<utils/build_plate.scad>;


module notches()
{
	// Cut notch for side
	translate ([ox-wall, notchHeight/2-printing_tolerance, -j]) 	
	cube(size = [50, notchHeight+printing_tolerance*2, wall+j*2]);
	
	translate ([ox-wall, notchHeight*2-printing_tolerance, -j]) 	
	cube(size = [50, notchHeight+printing_tolerance*2, wall+j*2]);
	
	// Cut notch for bottom
	translate ([ox-notchHeight*3/2-printing_tolerance, -j, -j]) 	
	cube(size = [notchHeight+printing_tolerance*2, wall+printing_tolerance+j, wall+j*2]);
}


module base_quarter()
{
	difference()
	{
		cube([ox-wall-printing_tolerance*2, oy, wall]);

		// edge notches
		translate ([-j, -printing_tolerance, -j])
		cube([ox-notchHeight*3/2+printing_tolerance+j, wall+printing_tolerance, wall+j*2]);
		
		translate ([ox-notchHeight/2+printing_tolerance*2, -printing_tolerance, -j])
		cube([notchHeight, wall+printing_tolerance*2, 100]);

		// notches for the inner supports
		translate([0, wall+mechanism, 0])
		{
			translate ([slidewidth+printing_tolerance, -printing_tolerance, -j])
			cube([ox-notchHeight*3/2-slidewidth, wall+printing_tolerance, wall+j*2]);
			translate ([ox-notchHeight/2+printing_tolerance*2, -printing_tolerance, -j])
			cube([notchHeight, wall+printing_tolerance*2, 100]);
		}
	}
}


module sideTab()
{
	union()
	{
		translate([0, -j, -j]) cube([wall+j, notchHeight/2+j, wall+j*2]);
		translate([0, notchHeight*3/2, -j]) cube([wall+j, notchHeight/2, wall+j*2]);
		translate([0, notchHeight*3-j, -j]) cube([wall+j, 100, wall+j*2]);
	}
}


module face_half()
{
	difference()
	{
		cube(size = [ox, oz, wall]);
		
		translate ([rad, ch, -j]) 	
		cylinder(h=wall+j*2, r=rad+printing_tolerance, $fn=circle_resolution);
		
		translate ([-j, ch-chx, -j]) cube(size = [ox+j*2, oz-ch+chx+j, wall+j*2]);
	    
		notches();
	}
}


module rack_lift_half()
{
	union()
	{
		translate([slidewidth, 50, mechanism/2-printing_tolerance])
		rotate(a=[0, 90, 180])
		gear_rack(2, 12, mechanism-printing_tolerance*2, slidewidth+2);
		
		difference()
		{
			cube([slidewidth-printing_tolerance, 40, mechanism+wall-printing_tolerance]);
			
			translate([-j, wall, -j])
			cube([slidewidth-wall+printing_tolerance+j, wall+printing_tolerance, mechanism+wall-printing_tolerance+j*2]);
		}
	}
}


module rack_lift_platform_half()
{
	union()
	{
		cube([slidewidth-wall-printing_tolerance, card_y+(wall+mechanism-printing_tolerance)*2, wall-printing_tolerance*2]);

		translate([0, wall+mechanism+printing_tolerance*3, 0])
		{
			cube([card_x/2-printing_tolerance*4, card_y-printing_tolerance*6, wall-printing_tolerance*2]);
			cube([slidewidth-wall-printing_tolerance, card_y-printing_tolerance*6, 2*wall-printing_tolerance*2]);
		}
	}
}


module mechanism_half()
{
	difference()
	{
		union()
		{
			cube(size = [ox, ch, wall]);
			translate ([rad, ch, 0])
			{
				cylinder(h=wall, r=card_x/2-rad, $fn=circle_resolution);
				cylinder(h=wall+pivotheight-printing_tolerance, r=pivotrad, $fn=circle_resolution);
			}
		}
		notches();
		translate([-j, -j, -j]) cube(size=[slidewidth+printing_tolerance+j, ch-chx+j, wall+j*2]);
	}
}


module hinge(r, hole, length)
{
	difference()
	{
		hull()
		{
			cube([r, r, length]);
			translate([r, r, 0]) cylinder(h=length, r=r, $fn=circle_resolution);
		}
		translate([r, r, -j]) cylinder(h=length+j*2, r=hole, $fn=circle_resolution);
	}
}


module side_half()
{
	difference()
	{
		cube(size = [oy, ch-rad, wall]);
		translate([oy-wall, 0, 0]) sideTab();
		translate([card_y/2, 0, 0]) sideTab();
	}
}


module top_half()
{
	//The height is incorrect. It's calculated using oz which already includes card_clearance + wall.
	// Careful changes need to be made to fix it though.

	union()
	{
		translate ([0, rad, 0]) 	
		cube(size = [ox, rad+card_clearance+wall, wall]);
		intersection()
		{
			cube(size = [ox, rad*2, wall]);
			translate ([rad, rad, 0]) 	
			cylinder(h=100, r=rad-printing_tolerance, $fn=circle_resolution);
		}

		translate ([rad, rad, 0])
		{
			difference()
			{
				union()
				{
					gear (circular_pitch=360, gear_thickness = gearHeight, rim_thickness = gearHeight, hub_thickness = gearHeight, circles=4);
					cylinder(h=gearHeight, r=card_x/2-rad, $fn=circle_resolution);
					translate([pivotrad+printing_tolerance*2, -pivotrad, 0])
					cube([ox-rad-(pivotrad+printing_tolerance*2), pivotrad*2, gearHeight]);
				}
				
				cylinder(h=gearHeight+j, r=pivotrad+printing_tolerance, $fn=circle_resolution);
				translate([ox-rad, -100, -j]) cube([100, 300, 100]);
			}
		}

		// These pegs will join the top together
		translate ([wall, rad*2+card_clearance+wall-wall-keyThickness/2, wall-j]) 
		cube([notchHeight-wall*2, keyThickness, wall*4]);

	}
}


module lid_connector_half()
{
	union()
	{
		translate([0, 0, wall])
		difference()
		{
			translate ([0, -wall, 0]) cube([notchHeight, wall*2, oy-wall+j]);
			translate ([wall*0.5, -keyThickness/1.5, -j]) cube([notchHeight-wall,  wall*2-keyThickness, wall*10]);
		}
		
		//  key system to hold the two parts of the top together
		translate ([notchHeight, wall, wall]) 
		scale([1, -1, 1])
		hinge(hingeRad, hingeHole, oy-card_y/6-printing_tolerance-wall);
	}

}


module lid_connector()
{
	rotate([-90, 0, 90])
	union()
	{
		lid_connector_half();
		translate([0, 0, oy*2]) scale([1, 1, -1]) lid_connector_half();
	}
}


module lid_half()
{
	union()
	{
		translate([-j, hingeRad*2-j, 0])
		cube([oy - wall - printing_tolerance*2 + j, ox-notchHeight-wall-2*hingeRad+j*2, wall]);
		
		translate ([-j, hingeRad*2, 0]) 
		scale([1, -1, 1])
		rotate(a=[90, 0, 90])
		hinge(hingeRad, hingeHole, card_y/6-printing_tolerance+j);

		translate ([card_y/6, ox-notchHeight-wall, 0]) 
		scale([-1, -1, 1])
		rotate(a=[90, 0, -90])
		hinge(hingeRad, hingeHole, card_y/3-printing_tolerance);
	}
}


module top_side_half()
{
	union()
	{
		translate([0, hingeRad*2-j, 0])
		cube([card_y/2-printing_tolerance, rad*2-4*hingeRad+card_clearance+wall+j*2, wall]);

		translate ([0, hingeRad*2, 0]) 
		scale([1, -1, 1])
		rotate(a=[90, 0, 90])
		hinge(hingeRad, hingeHole, card_y/6-printing_tolerance);

		translate ([card_y/6, rad*2-2*hingeRad+card_clearance+wall, 0]) 
		scale([-1, -1, 1])
		rotate(a=[90, 0, -90])
		hinge(hingeRad, hingeHole, card_y/3-printing_tolerance);
	}
}


module base_half()
{
	union()
	{
		base_quarter();
		translate([j, 0, 0]) scale([-1, 1, 1]) base_quarter();
	}
}

module base()
{
	union()
	{
		base_half();
		translate([0, oy*2-j, 0])	scale([1, -1, 1]) base_half();
	}
}

module frontAndBack(logoname)
{
	difference()
	{
		union()
		{
			face_half();
			scale ([-1, 1, 1]) face_half();
		}
		
		translate([0, (ch-rad)/2, wall/2])
		scale(min(ox, oz)*1.5)
		Logo(logoname);
	}
}

module mechanism()
{
	union()
	{
		mechanism_half();
		translate([j, 0, 0]) scale([-1, 1, 1]) mechanism_half();
	}
}

module side(logoname)
{
	difference()
	{
		union()
		{
			translate([-j, 0, 0]) side_half();
			
			translate([j, 0, 0]) scale([-1, 1, 1]) side_half();
			
			translate([card_y/6+printing_tolerance, ch-rad, 0])
			rotate(a=[0, -90, 0])
			hinge(hingeRad, hingeHole, card_y/3-printing_tolerance*2);
		}
		
		translate([0, (ch-rad)/2, wall/2])
		scale(min(oy, ch-rad)*0.8)
		Logo(logoname);
	}
}

module rack_lift()
{
	union()
	{
		rack_lift_half();
		translate([j, 0, 0]) scale([-1, 1, 1]) rack_lift_half();
	}
}

module rack_lift_platform()
{
	union()
	{
		rack_lift_platform_half();
		translate([j, 0, 0]) scale([-1, 1, 1]) rack_lift_platform_half();
	}
}


module lid()
{
	union()
	{
		lid_half();
		scale([-1, 1, 1]) lid_half();
	}
}


module top_side()
{
	top_side_half();
	scale([-1, 1, 1])
		top_side_half();
}


module Logo(logoname)
{
	union()
	{
		union()
		{
			if(logoname == "manablue") manaLogo("blue");
			if(logoname == "manawhite") manaLogo("white");
			if(logoname == "manared") manaLogo("red");
			if(logoname == "manablack") manaLogo("black");
			if(logoname == "managreen")  manaLogo("green");
		}
	}
}


// Magic the Gathering Mana badges by Stuartblarg
// It is licensed under the Creative Commons - Attribution license.
// http://www.thingiverse.com/thing:104988
module manaLogo(logoname)
{
	difference()
	{
		cylinder(r=0.5, h=1, $fn=circle_resolution);
		translate([0,0,-j])
		scale([0.9, 0.9, 1.2])
		union()
		{
			if(logoname == "blue") manaLogoBlue();
			if(logoname == "white") manaLogoWhite();
			if(logoname == "red") manaLogoRed();
			if(logoname == "black") manaLogoBlack();
			if(logoname == "green") manaLogoGreen();
		}
	}
}


module manaLogoBlue()
{
	union()
	{
		scale([0.029, 0.029, 0.4])
		translate([-166, -16, -11.25])
		import("blue.stl");
	}
}


module manaLogoWhite()
{
	union()
	{
		scale([0.026, 0.026, 0.4])
		translate([-191, -18, -11.25])
		import("white.stl");
	}
}


module manaLogoRed()
{
	union()
	{
		scale([0.026, 0.026, 0.4])
		translate([-195, -17, -11.25])
		import("red.stl");
	}
}


module manaLogoBlack()
{
	union()
	{
		scale([0.027, 0.027, 0.4])
		translate([-190, -17, -11.25])
		import("black.stl");
	}
}


module manaLogoGreen()
{
	union()
	{
		scale([0.03, 0.03, 0.4])
		translate([-193, -16, -11.25])
		import("green.stl");
	}
}




/////////////////////////////////////////////////////////////////////////
// Layouts
/////////////////////////////////////////////////////////////////////////
if(part==0)
{
	assembledLayout();
}
if(part==1)
{
	translate([0, -(ch-chx)*0.5, 0])
	frontAndBack(front_logo);
}
if(part==2)
{
	translate([0, -(ch-chx)*0.5, 0])
	frontAndBack(back_logo);
}
if(part==3)
{
	translate([0, -(ch-chx)*0.5, 0])
	side(left_logo);
}
if(part==4)
{
	translate([0, -(ch-chx)*0.5, 0])
	side(right_logo);
}
if(part==5)
{
	translate([0, -(37.7), 0])
	rack_lift();
}
if(part==6)
{
	translate([-ox/2, -(rad+card_clearance+wall), 0]) top_half();
}
if(part==7)
{
	translate([ox/2, -(rad+card_clearance+wall), 0]) scale([-1, 1, 1])	top_half();
}
if(part==8)
{
	translate([oy, printingGap/2, wall])
	lid_connector();
}
if(part==9)
{
	translate([0, -ch/2, 0])
	mechanism();
}
if(part==10)
{
	lid();
}
if(part==11)
{
	translate([0, -(rad*2-4*hingeRad+card_clearance+wall)/2, 0])
	top_side();
}
if(part==12)
{
	translate([0, -(card_y+(wall+mechanism-printing_tolerance))/2, 0])
	rack_lift_platform();
}
if(part==13)
{
	translate([0, -oy, 0])
	base();
}
if(part==14) // PLATE-A is just the base
{
	translate([0, -oy, 0])
	base();
}
if(part==15) // PLATE-B is the four corners and their joiners
{
	translate([0, (rad*2+card_clearance+wall)+printingGap/2, 0]) rotate([0, 0, 180])
	{
		translate([printingGap/2, 0, 0]) top_half();
		translate([-printingGap/2, 0, 0]) scale([-1, 1, 1])	top_half();
	}
	translate([0, -(rad*2+card_clearance+wall)-printingGap/2, 0]) 
{
		translate([printingGap/2, 0, 0]) top_half();
		translate([-printingGap/2, 0, 0]) scale([-1, 1, 1])	top_half();
	}

	translate([ox+printingGap*2, -oy, wall])
	rotate([0, 0, -90])
	lid_connector();

	translate([-ox-printingGap*2, -oy, wall])
	scale([1, -1, 1])
	rotate([0, 0, 90])
	lid_connector();
}
if(part==16) // PLATE-C is the two outer cutout panels and rack lifts
{
	translate([0, wall/2, 0]) frontAndBack(front_logo);
	rotate([0, 0, 180]) translate([0, wall/2, 0]) frontAndBack(back_logo);
	translate([ox+12+wall, -50, 0]) rack_lift();
	translate([-(ox+12+wall), -50, 0]) rack_lift();
}
if(part==17) // PLATE-D is the lower hinge panels
{
	translate([0, wall/2, 0]) side(left_logo);
	rotate([0, 0, 180]) translate([0, wall/2, 0]) side(right_logo);
}
if(part==18) // PLATE-E is the large mechanism-holding plates
{
	translate([ox+wall/2, -ch/2, 0]) mechanism();
	translate([-ox-wall/2, -ch/2, 0]) mechanism();
}
if(part==19) // PLATE-F is the upper hinged panels
{
	translate([0, -(rad*2-4*hingeRad+card_clearance+wall)-hingeRad*4-wall/2, 0]) top_side();
	translate([0, (rad*2-4*hingeRad+card_clearance+wall)+hingeRad*4+wall/2, 0]) rotate([0, 0, 180]) top_side();
	translate([-(card_y/2+printingGap), 0, 0]) rotate([0, 0, 90]) lid();
	translate([card_y/2+printingGap, 0, 0]) rotate([0, 0, -90]) lid();
}
if(part==20) // PLATE-G is the lift platform
{
	translate([0, -(card_y+(wall+mechanism-printing_tolerance)*2)/2, 0]) rack_lift_platform();
}


module assembledLayout()
{
	// front and back
	translate([0, -oy+wall-explode, 0])
	rotate(a=[90, 0, 0])
	frontAndBack(front_logo);

	translate([0, oy-wall+explode, 0])
	rotate(a=[90, 0, 180])
	frontAndBack(back_logo);

	// mechanisms
	color("RosyBrown")
	translate([0, -card_y/2, 0])
	rotate(a=[90, 0, 0])
	mechanism();

	color("RosyBrown")
	translate([0, card_y/2, 0])
	rotate(a=[90, 0, 180])
	mechanism();

	// sides (exploded)
	color("blue")
	translate([ox - wall + explode, 0, 0])
	rotate(a=[90, 0, 90])
	side(right_logo);

	color("blue")
	translate([-ox + wall -explode, 0, 0])
	rotate(a=[90, 0, -90])
	side(left_logo);

	// rack  / pinion card lift (slides)
	// mechanisms
	color("SeaGreen")
	translate([0, -card_y/2-wall-mechanism-explode/2, 0])
	rotate(a=[90, 0, 180])
	rack_lift();

	color("SeaGreen")
	translate([0, card_y/2+wall+mechanism+explode/2, 0])
	rotate(a=[90, 0, 0])
	rack_lift();

	// top
	color("DarkMagenta")
	translate([0+explode, -oy-explode, ch-rad+explode])
	rotate(a=[90, 0, 180])
	scale([-1, 1, 1])
	top_half();

	color("DarkMagenta")
	translate([0-explode, -oy-explode, ch-rad+explode])
	rotate(a=[90, 0, 180])
	top_half();

	color("DarkMagenta")
	translate([0-explode, oy+explode, ch-rad+explode])
	rotate(a=[90, 0, 0])
	scale([-1, 1, 1])
	top_half();

	color("DarkMagenta")
	translate([0+explode, oy+explode, ch-rad+explode])
	rotate(a=[90, 0, 0])
	top_half();

	// top
	// bug - height isn't supposed to include two lots of card_clearance and wall
	translate([notchHeight+explode, 0, oz+card_clearance+wall+explode])
	rotate(a=[0, 180, -90])
	lid();
	
	translate([-j-explode*0.5, -oy, oz+card_clearance+explode])
	rotate([180, 0, -90])
	lid_connector();
	
	translate([-notchHeight-explode, 0, oz+card_clearance+wall+explode])
	rotate(a=[0, 180, 90])
	lid();

	rotate([0, 0, 180])
	translate([-j-explode*0.5, -oy, oz+card_clearance+explode])
	rotate([180,0,-90])
	lid_connector();

	// top side
	translate([-ox-hingeRad*2+wall-explode, 0, oz+card_clearance+wall+explode/2])
	rotate(a=[90, 180, 90])
	top_side();

	translate([ox+hingeRad*2-wall+explode, 0, oz+card_clearance+wall+explode/2])
	rotate(a=[90, 180, -90])
	top_side();

	translate([0, -oy, -explode])
	base();
	
	translate([0, -oy, -explode*0.5])
	rack_lift_platform();
}

%build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);


/* ==========================================================================
   Include source for gear_rack.scad here to allow for Thingiverse Customizer
   ========================================================================== */
pi=3.1415926535897932384626433832795;
module tooth(mod,width) {opposite_at_reference_pitch=mod / tan(70);tooth_width_at_reference_pitch=(pi / 2) * mod;cube_width = tooth_width_at_reference_pitch - (2 * opposite_at_reference_pitch);opposite_of_triangle = mod < 1.25 ? 2.4 * mod : 2.25 * mod;adjacent_of_triangle = opposite_of_triangle / tan(70);diagonal = sqrt((opposite_of_triangle + 0.05) * (opposite_of_triangle + 0.05) + (adjacent_of_triangle * adjacent_of_triangle));correct_angle = 90 - acos(adjacent_of_triangle / diagonal);adjacent_of_mini_triangle = 0.05 / tan(90 - correct_angle);adjacent_top_cube = (0.5 * mod) / tan(45);translate([0,adjacent_of_mini_triangle * -1, 0]) {difference() {union() {intersection() {cube([opposite_of_triangle + 0.05,adjacent_of_triangle, width]);rotate([0,0,correct_angle]) cube([diagonal,adjacent_of_triangle, width]);}translate([0,adjacent_of_triangle,0]) cube([opposite_of_triangle + 0.05,cube_width, width]);translate([0,(adjacent_of_triangle * 2) + cube_width,width]) {rotate([180,0,0]) {intersection() {cube([opposite_of_triangle + 0.05,adjacent_of_triangle, width]);rotate([0,0,correct_angle]) cube([diagonal,adjacent_of_triangle, width]);}}}}translate([-0.5 * mod,-1,-0.5 * mod])cube([1 * mod + 0.05, 1+ adjacent_of_mini_triangle, width + (1 * mod)]);translate([-0.5 * mod,(adjacent_of_triangle * 2) + cube_width - adjacent_of_mini_triangle,-0.5 * mod]) cube([1 * mod + 0.05, 1, width + (1 * mod)]);translate([opposite_of_triangle + 0.05 * mod,adjacent_of_triangle - adjacent_top_cube,-0.25 * mod]) {rotate([0,0,45]) cube([1 * mod, 0.5 * mod,cube_width + (2 * mod)]);}translate([opposite_of_triangle + 0.05 * mod,adjacent_of_triangle - adjacent_top_cube + cube_width + 0.3 * mod,-0.25 * mod]) {rotate([0,0,45]) cube([0.5 * mod, 1 * mod,cube_width + (2 * mod)]);}}}}
module teeth(mod,number_of_teeth,width) {union() {for (i= [0:number_of_teeth - 1]) {translate([-0.05,i * mod * pi,0]) {tooth(mod=mod,width=width);	}}}}
module gear_rack(mod,number_of_teeth,rack_width,rack_bottom_height) {total_rack_length = number_of_teeth * pi * mod;rotate([0,90,0]) {translate([0,total_rack_length / 2 * -1,rack_width / 2 * -1]) {union() {teeth(mod=mod,number_of_teeth=number_of_teeth,width=rack_width);translate([rack_bottom_height * -1,0,0])cube([rack_bottom_height, number_of_teeth * pi * mod, rack_width]);}}}}


/* ==============================================================================================
   Include source for parametric_involute_gear_v5.0.scad here to allow for Thingiverse Customizer
   ============================================================================================== */
// Parametric Involute Bevel and Spur Gears by GregFrost
// It is licensed under the Creative Commons - GNU GPL license.
// © 2010 by GregFrost
// http://www.thingiverse.com/thing:3575
module bevel_gear_pair (gear1_teeth = 41,gear2_teeth = 7,axis_angle = 90,outside_circular_pitch=1000){outside_pitch_radius1 = gear1_teeth * outside_circular_pitch / 360;outside_pitch_radius2 = gear2_teeth * outside_circular_pitch / 360;pitch_apex1=outside_pitch_radius2 * sin (axis_angle) + (outside_pitch_radius2 * cos (axis_angle) + outside_pitch_radius1) / tan (axis_angle);cone_distance = sqrt (pow (pitch_apex1, 2) + pow (outside_pitch_radius1, 2));pitch_apex2 = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius2, 2));pitch_angle1 = asin (outside_pitch_radius1 / cone_distance);pitch_angle2 = asin (outside_pitch_radius2 / cone_distance);rotate([0,0,90])translate ([0,0,pitch_apex1+20]){translate([0,0,-pitch_apex1])bevel_gear (number_of_teeth=gear1_teeth,cone_distance=cone_distance,pressure_angle=30,outside_circular_pitch=outside_circular_pitch);rotate([0,-(pitch_angle1+pitch_angle2),0])translate([0,0,-pitch_apex2])bevel_gear (number_of_teeth=gear2_teeth,cone_distance=cone_distance,pressure_angle=30,outside_circular_pitch=outside_circular_pitch);}}bevel_gear_flat = 0;bevel_gear_back_cone = 1;
module bevel_gear (number_of_teeth=11,cone_distance=100,face_width=20,outside_circular_pitch=1000,pressure_angle=30,clearance = 0.2,bore_diameter=5,gear_thickness = 15,backlash = 0,involute_facets=0,finish = -1){outside_pitch_diameter  =  number_of_teeth * outside_circular_pitch / 180;outside_pitch_radius = outside_pitch_diameter / 2;pitch_apex = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius, 2));pitch_angle = asin (outside_pitch_radius/cone_distance);finish = (finish != -1) ? finish : (pitch_angle < 45) ? bevel_gear_flat : bevel_gear_back_cone;apex_to_apex=cone_distance / cos (pitch_angle);back_cone_radius = apex_to_apex * sin (pitch_angle);base_radius = back_cone_radius * cos (pressure_angle);	pitch_diametrial = number_of_teeth / outside_pitch_diameter;addendum = 1 / pitch_diametrial;outer_radius = back_cone_radius + addendum;dedendum = addendum + clearance;dedendum_angle = atan (dedendum / cone_distance);root_angle = pitch_angle - dedendum_angle;root_cone_full_radius = tan (root_angle)*apex_to_apex;back_cone_full_radius=apex_to_apex / tan (pitch_angle);back_cone_end_radius = outside_pitch_radius - dedendum * cos (pitch_angle) - gear_thickness / tan (pitch_angle);back_cone_descent = dedendum * sin (pitch_angle) + gear_thickness;root_radius = back_cone_radius - dedendum;half_tooth_thickness = outside_pitch_radius * sin (360 / (4 * number_of_teeth)) - backlash / 4;half_thick_angle = asin (half_tooth_thickness / back_cone_radius);face_cone_height = apex_to_apex-face_width / cos (pitch_angle);face_cone_full_radius = face_cone_height / tan (pitch_angle);face_cone_descent = dedendum * sin (pitch_angle);face_cone_end_radius = outside_pitch_radius -face_width / sin (pitch_angle) - face_cone_descent / tan (pitch_angle);bevel_gear_flat_height = pitch_apex - (cone_distance - face_width) * cos (pitch_angle);difference (){intersection (){union(){rotate (half_thick_angle)translate ([0,0,pitch_apex-apex_to_apex])cylinder ($fn=number_of_teeth*2, r1=root_cone_full_radius,r2=0,h=apex_to_apex);for (i = [1:number_of_teeth]){rotate ([0,0,i*360/number_of_teeth]){involute_bevel_gear_tooth (back_cone_radius = back_cone_radius,root_radius = root_radius,base_radius = base_radius,outer_radius = outer_radius,pitch_apex = pitch_apex,cone_distance = cone_distance,half_thick_angle = half_thick_angle,involute_facets = involute_facets);}}}if (finish == bevel_gear_back_cone){translate ([0,0,-back_cone_descent])cylinder ($fn=number_of_teeth*2, r1=back_cone_end_radius,r2=back_cone_full_radius*2,h=apex_to_apex + back_cone_descent);}else{translate ([-1.5*outside_pitch_radius,-1.5*outside_pitch_radius,0])cube ([3*outside_pitch_radius,3*outside_pitch_radius,bevel_gear_flat_height]);}}if (finish == bevel_gear_back_cone){translate ([0,0,-face_cone_descent])cylinder (r1=face_cone_end_radius,r2=face_cone_full_radius * 2,h=face_cone_height + face_cone_descent+pitch_apex);}translate ([0,0,pitch_apex - apex_to_apex])cylinder (r=bore_diameter/2,h=apex_to_apex);}}
module involute_bevel_gear_tooth (back_cone_radius,root_radius,base_radius,outer_radius,pitch_apex,cone_distance,half_thick_angle,involute_facets){min_radius = max (base_radius*2,root_radius*2);pitch_point = involute (base_radius*2, involute_intersect_angle (base_radius*2, back_cone_radius*2));pitch_angle = atan2 (pitch_point[1], pitch_point[0]);centre_angle = pitch_angle + half_thick_angle;start_angle = involute_intersect_angle (base_radius*2, min_radius);stop_angle = involute_intersect_angle (base_radius*2, outer_radius*2);res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;translate ([0,0,pitch_apex])rotate ([0,-atan(back_cone_radius/cone_distance),0])translate ([-back_cone_radius*2,0,-cone_distance*2])union (){for (i=[1:res]){assign (point1=involute (base_radius*2,start_angle+(stop_angle - start_angle)*(i-1)/res),point2=involute (base_radius*2,start_angle+(stop_angle - start_angle)*(i)/res)){assign (side1_point1 = rotate_point (centre_angle, point1),side1_point2 = rotate_point (centre_angle, point2),side2_point1 = mirror_point (rotate_point (centre_angle, point1)),side2_point2 = mirror_point (rotate_point (centre_angle, point2))){polyhedron (points=[[back_cone_radius*2+0.1,0,cone_distance*2],[side1_point1[0],side1_point1[1],0],[side1_point2[0],side1_point2[1],0],[side2_point2[0],side2_point2[1],0],[side2_point1[0],side2_point1[1],0],[0.1,0,0]],triangles=[[0,1,2],[0,2,3],[0,3,4],[0,5,1],[1,5,2],[2,5,3],[3,5,4],[0,4,5]]);}}}}}
module gear (number_of_teeth=15,circular_pitch=false, diametral_pitch=false,pressure_angle=28,clearance = 0.2,gear_thickness=5,rim_thickness=8,rim_width=5,hub_thickness=10,hub_diameter=15,bore_diameter=5,circles=0,backlash=0,twist=0,involute_facets=0){circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);pitch_diameter  =  number_of_teeth * circular_pitch / 180;pitch_radius = pitch_diameter/2;base_radius = pitch_radius*cos(pressure_angle);pitch_diametrial = number_of_teeth / pitch_diameter;addendum = 1/pitch_diametrial;outer_radius = pitch_radius+addendum;dedendum = addendum + clearance;root_radius = pitch_radius-dedendum;backlash_angle = backlash / pitch_radius * 180 / pi;half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;rim_radius = root_radius - rim_width;circle_orbit_diameter=hub_diameter/2+rim_radius;circle_orbit_curcumference=pi*circle_orbit_diameter;circle_diameter=min (0.70*circle_orbit_curcumference/circles,(rim_radius-hub_diameter/2)*0.9);difference (){union (){difference (){linear_extrude (height=rim_thickness, convexity=10, twist=twist)gear_shape (number_of_teeth,pitch_radius = pitch_radius,root_radius = root_radius,base_radius = base_radius,outer_radius = outer_radius,half_thick_angle = half_thick_angle,involute_facets=involute_facets);if (gear_thickness < rim_thickness)translate ([0,0,gear_thickness])cylinder (r=rim_radius,h=rim_thickness-gear_thickness+1);}if (gear_thickness > rim_thickness)cylinder (r=rim_radius,h=gear_thickness);if (hub_thickness > gear_thickness)translate ([0,0,gear_thickness])cylinder (r=hub_diameter/2,h=hub_thickness-gear_thickness);}translate ([0,0,-1])cylinder (r=bore_diameter/2,h=2+max(rim_thickness,hub_thickness,gear_thickness));if (circles>0){for(i=[0:circles-1])	rotate([0,0,i*360/circles])translate([circle_orbit_diameter/2,0,-1])cylinder(r=circle_diameter/2,h=max(gear_thickness,rim_thickness)+3);}}}
module gear_shape (number_of_teeth,pitch_radius,root_radius,base_radius,outer_radius,half_thick_angle,involute_facets){union(){rotate (half_thick_angle) circle ($fn=number_of_teeth*2, r=root_radius);for (i = [1:number_of_teeth]){rotate ([0,0,i*360/number_of_teeth]){involute_gear_tooth (pitch_radius = pitch_radius,root_radius = root_radius,base_radius = base_radius,outer_radius = outer_radius,half_thick_angle = half_thick_angle,involute_facets=involute_facets);}}}}
module involute_gear_tooth (pitch_radius,root_radius,base_radius,outer_radius,half_thick_angle,involute_facets){min_radius = max (base_radius,root_radius);pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));pitch_angle = atan2 (pitch_point[1], pitch_point[0]);centre_angle = pitch_angle + half_thick_angle;start_angle = involute_intersect_angle (base_radius, min_radius);stop_angle = involute_intersect_angle (base_radius, outer_radius);res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;union (){for (i=[1:res])assign (point1=involute (base_radius,start_angle+(stop_angle - start_angle)*(i-1)/res),point2=involute (base_radius,start_angle+(stop_angle - start_angle)*i/res)){assign (side1_point1=rotate_point (centre_angle, point1),side1_point2=rotate_point (centre_angle, point2),side2_point1=mirror_point (rotate_point (centre_angle, point1)),side2_point2=mirror_point (rotate_point (centre_angle, point2))){polygon (points=[[0,0],side1_point1,side1_point2,side2_point2,side2_point1],paths=[[0,1,2,3,4,0]]);}}}}
function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / pi;
function rotated_involute (rotate, base_radius, involute_angle) = [cos (rotate) * involute (base_radius, involute_angle)[0] + sin (rotate) * involute (base_radius, involute_angle)[1],cos (rotate) * involute (base_radius, involute_angle)[1] - sin (rotate) * involute (base_radius, involute_angle)[0]];
function mirror_point (coord) = [coord[0], -coord[1]];
function rotate_point (rotate, coord) =[cos (rotate) * coord[0] + sin (rotate) * coord[1],cos (rotate) * coord[1] - sin (rotate) * coord[0]];
function involute (base_radius, involute_angle) = [base_radius*(cos (involute_angle) + involute_angle*pi/180*sin (involute_angle)),base_radius*(sin (involute_angle) - involute_angle*pi/180*cos (involute_angle)),];
