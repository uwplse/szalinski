/* [Global] */

// set this to "Checked" this before you create your object
finalPass = "uncheck"; //[checked:Checked,uncheck:Unchecked]
// Which area would you like to see?
show_Part = "all"; // [first:Pot Only,second:Water Reservoir Only,three:Internal Only,all:Pot All,dish:Dish]
// Thickness of the entire model
thickness = 2.5;

/* [Pot] */

pot_diameter = 80;
pot_height = 70;
//The larger the number, the straighter the curve
pot_curve = 100;
//The distance each pot is moved from the center
triPot_distance = 30;

/* [Water Reservoir] */

waterRes_diameter = 60;
waterRes_height = 57;
//Height of the gap at the base of the reservoir
waterRes_bottemGap = 6;
//Space between the of the reservior and bottem, this stops dirt from coming in
waterBase_height = 7;
//The amount of supports that are around the reservoir
waterSupport_amount = 25;


funnel_diameter = 20;
//Make sure that this value is 3mm from the top of the pot
funnel_height = 10;
//Hole size for the funnel intake
funnel_hole = 10;

/* [internal] */

//This is the height when the water starts to drain
outlet_height = 20;
//Size of the drain
outlet_Diameter= 5;
//Size of the water intake hole for the drain
outlet_intake = 5;

/* [Dish] */

dish_height = 15;

dish_support_width = 25;
dish_support_height = 3;
dish_support_length = 10;
dish_support_distant = 30;
dish_support_amount = 6;

/* [final] */

// Used to generate the pot and dish
part = "pot"; //[pot:Pot,dish:Dish]
// How high poly will it be
resolution = 40;

/* [Hidden] */

$fn = resolution;

//making pot
union()
{
	if(finalPass == "checked")
	{
		difference()
		{
			union()
			{
				if(part == "pot")
				{
					triPot();
				}
				if(part == "pot")
				{
					waterBase();
				}			
			}
			
			if(part == "pot")
			{
				outletInt();
			}
	
			if(part == "pot")
			{
				rotate([0,0,60])
				 	translate([0,0,-pot_height+thickness])
						triPot();
			}
		}
		
		if(part == "pot")
		{
			waterRes();
			waterResSup();
			flange();
			outletExt();
		}
	
		if(part == "pot")
		{
			outletExt();
		}
	
		if(part == "dish")
		{
			catchment();
		}
	
	}
	else
	{
		difference()
		{
			union()
			{
				if(show_Part == "first" || show_Part == "all")
				{
					triPot();
				}
				if(show_Part == "second" || show_Part == "three" || show_Part == "all")
				{
					waterBase();
				}			
			}
			
			if(show_Part == "first" || show_Part == "second" || show_Part == "three" || show_Part == "all")
			{
				outletInt();
			}
	
			if(show_Part == "all")
			{
				rotate([0,0,60])
				 	translate([0,0,-pot_height+thickness])
						triPot();
			}
		}
		
		if(show_Part == "second" || show_Part == "all")
		{
			waterRes();
			waterResSup();
			flange();
			outletExt();
		}
	
		if(show_Part == "second" || show_Part == "three" || show_Part == "all")
		{
			outletExt();
		}
	
		if(show_Part == "dish")
		{
			catchment();
		}
	}
}

module catchment()
{
	union()
	{

		triPotDish();
	
		for ( i = [0 : dish_support_amount] )
		{
			rotate( i * 360 / dish_support_amount, [0, 0, 1])
				translate([dish_support_distant,-dish_support_width/2,-dish_height + thickness])
		    			cube([dish_support_length,dish_support_width,dish_support_height]);
		}
	}	
}

// pot outlet
module outletInt()
{
	union()
	{
		translate([0,0,-pot_height-0.2]) 
			cylinder(outlet_height+thickness*2+outlet_intake+0.4, outlet_Diameter/2, outlet_Diameter/2, false);
	
		translate([0,0,-pot_height+ thickness*2+ outlet_height+ outlet_intake/2- 0.1])
			rotate ([0,90,0])
				cylinder(outlet_height+0.2, outlet_intake/2, outlet_intake/2, true);
	}
}

module outletExt()
{
	difference()
	{
		translate([0,0,-pot_height+0.1]) 
			cylinder(outlet_height+thickness*3+outlet_intake+0.4, outlet_Diameter/2+thickness, outlet_Diameter/2+thickness, false);
		
		outletInt();
	}
}

module flange()
{
	difference()
	{
		translate([0,0,-pot_height + waterRes_height])
			cylinder(funnel_height, funnel_hole/2+thickness, funnel_diameter/2+thickness, false);

		translate([0,0,-pot_height + waterRes_height-0.1])
			cylinder(funnel_height+0.2, funnel_hole/2, funnel_diameter/2, false);
	}
}

// for the resouver
module waterRes()
{
	union()
	{
		waterResExt();
		waterResSup();
	}
}

module waterResSup()
{
	for ( i = [0 : waterSupport_amount] )
	{
	    rotate( i * 360 / waterSupport_amount, [0, 0, 1])
	    translate([0, waterRes_diameter/2-thickness*2, -pot_height + thickness*2])
	    cube([thickness,thickness*2,waterRes_bottemGap]);
	}
}

module waterResExt()
{
	difference()
	{
		translate([0,0,-pot_height + (thickness*2 + waterRes_bottemGap)]) 
			cylinder(waterRes_height - (thickness*2 + waterRes_bottemGap), waterRes_diameter/2, funnel_hole/2+thickness, false);
	
		translate([0,0,-pot_height + (thickness*2 + waterRes_bottemGap) -0.1]) 
			cylinder(waterRes_height - (thickness*2 + waterRes_bottemGap) +0.2, waterRes_diameter/2-thickness, funnel_hole/2, false);
	}
}

module waterBase()
{
	translate([0,0,-pot_height + thickness*2-0.2]) 
		cylinder(waterBase_height+0.2, waterRes_diameter/2, waterRes_diameter/2-waterBase_height, false);
}

// for makeing the pot
module triPot() 
{
	difference()
	{
		union()
		{
			for ( i = [0 : 2] )
			{
				potExternal(triPot_distance,i*120);
			}
		}
	
		union()
		{
			for ( i = [0 : 2] )
			{
				potInternal(triPot_distance,i*120);
			}
		}
	}
}

module potExternal(distance, rot) 
{
	difference()
	{
		//sphere outer
		rotate([0,0,rot]) 
			translate([distance,0,0])
				resize([pot_diameter,pot_diameter,pot_curve*2]) 
					sphere(1);
		
		//top cap
		rotate([0,0,rot]) 
			translate([distance-pot_diameter/2-2,-pot_diameter/2-2,0]) 
				cube([pot_diameter+4,pot_diameter+4,pot_curve+0.1]);
		
		//base cap
		rotate([0,0,rot]) 
			translate([distance-pot_diameter/2,-pot_diameter/2,-pot_height-pot_curve]) 
				cube([pot_diameter,pot_diameter,pot_curve-0.1]);
	}
}

module potInternal(distance, rot) 
{
	difference()
	{
		// draws internal sphere
		rotate([0,0,rot]) 
			translate([distance,0,0])
				resize([pot_diameter-thickness*2,pot_diameter-thickness*2,pot_curve*2]) 
					sphere(1);

		//base with thickness
		rotate([0,0,rot]) 
			translate([distance-pot_diameter/2,-pot_diameter/2,-pot_height-pot_curve+thickness*2]) 
				cube([pot_diameter,pot_diameter,pot_curve-0.1]);
	}
}

module triPotDish() 
{
	difference()
	{
		union()
		{
			for ( i = [0 : 2] )
			{
				dishExternal(triPot_distance,i*120);
			}
		}
	
		union()
		{
			for ( i = [0 : 2] )
			{
				dishInternal(triPot_distance,i*120);
			}
		}
	}
}

module dishExternal(distance, rot) 
{
	difference()
	{
		//sphere outer
		rotate([0,0,rot]) 
			translate([distance,0,0])
				resize([pot_diameter,pot_diameter,pot_curve*2]) 
					sphere(1);
		
		//top cap
		rotate([0,0,rot]) 
			translate([distance-pot_diameter/2-2,-pot_diameter/2-2,0]) 
				cube([pot_diameter+4,pot_diameter+4,pot_curve+0.1]);
		
		//base cap
		rotate([0,0,rot]) 
			translate([distance-pot_diameter/2,-pot_diameter/2,-dish_height-pot_curve]) 
				cube([pot_diameter,pot_diameter,pot_curve-0.1]);
	}
}

module dishInternal(distance, rot) 
{
	difference()
	{
		// draws internal sphere
		rotate([0,0,rot]) 
			translate([distance,0,0])
				resize([pot_diameter-thickness*2,pot_diameter-thickness*2,pot_curve*2]) 
					sphere(1);

		//base with thickness
		rotate([0,0,rot]) 
			translate([distance-pot_diameter/2,-pot_diameter/2,-dish_height-pot_curve+thickness]) 
				cube([pot_diameter,pot_diameter,pot_curve-0.1]);
	}
}