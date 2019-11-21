
//######################VARIBLES#####################
//handle properties

//handle height
handle_height = 15;
//handle diamater
handle_diamater = 6;

//(optional) cylinder flywheel

//use flywheel
flywheel = "on";//[on, off]
//flywheel height
flywheel_height = 3;
//flywheel diamater
flywheel_diamater = 20;

//cone (can act as flywheel)

//cone height
cone_height = 15;
//cone diamater
cone_top_diamater = 20;

//seperate objects(for supportless printing)
seperate = "off";//[on,off]

//seperation distance
sep_dist = 10;
//joiner
join = "clip";//[none, pin, clip]
//joiner width
join_d = 4;
//joiner length
join_l = 5;
//tolerance(free space left in joiner, good if your pritner isnt accurate)
tolerance = 0.1;

//accuracy
$fn=64;
//#################END OF VARIABLES##################

//converting units
handle_r = handle_diamater/2;
flywheel_r = flywheel_diamater/2;
cone_top_r = cone_top_diamater/2;
join_r = join_d/2;

//simple old code, no seperation
if (seperate == "off")
{
	//bottom cone
	cylinder(cone_height, 0, cone_top_r);
	
	//different behaviour with and without flywheel
	if(flywheel == "on")
	{
		//flywheel
		translate([0,0,cone_height]) cylinder(flywheel_height, flywheel_r, flywheel_r);
		//handle
		translate([0,0,cone_height+flywheel_height]) cylinder(handle_height, handle_r, handle_r);
	}
	else
	{
		translate([0,0,cone_height]) cylinder(handle_height, handle_r, handle_r);
	}
}
else//seperate code
{
		//handle
	cylinder(handle_height, handle_r, handle_r);
	//joiner
	translate([0,0,handle_height])joiner();
	//different logic needed with and without flywheel
	if(flywheel == "on")
	{	
		//is the cone or flywheel larger
		if(flywheel_r > cone_top_r)
		{	
			difference()
			{
				//make flywheel/cone into one object
				union()	
				{
					//make flywheel
					translate([handle_r+flywheel_r+sep_dist,0,0]) cylinder(flywheel_height, flywheel_r, flywheel_r);
					//make cone
					translate([handle_r+flywheel_r+sep_dist,0,flywheel_height]) cylinder(cone_height,cone_top_r, 0);
				}
				translate([handle_r+flywheel_r+sep_dist,0,0])joiner("female");
			}
		
		}
		else
		{	
			echo("WARNING : cone bigger than flywheel, overhang inevitable!!!!!!(unless the overhang is very small, you should inspect the model before use)");
			difference()
			{
				//make flywheel/cone into one object
				union()	
				{
					//make flywheel
					translate([handle_r+cone_top_r+sep_dist,0,0]) cylinder(flywheel_height, flywheel_r, flywheel_r);
					//make cone
					translate([handle_r+cone_top_r+sep_dist,0,flywheel_height]) cylinder(cone_height,cone_top_r, 0);
				}
				translate([handle_r+cone_top_r+sep_dist,0,0])joiner("female");
			}
		}
	}
	else
	{
		//put clip/pin hole in cone
		difference()
			{
				//make cone
				translate([handle_r+cone_top_r+sep_dist,0,0]) cylinder(cone_height,cone_top_r, 0);
				translate([handle_r+cone_top_r+sep_dist,0,0])joiner("female");
			}
	}
}

//simple place for all joiners(used to be repeated many times)
module joiner(gen = "male", type = join, joinerl = join_l, joinerr = join_r, tol = tolerance)
{
	//male clip
	if (gen == "male")
	{
		if(type == "pin")
		{
			//simple cylinder pin	
			cylinder(joinerl,joinerr,joinerr);
		}
		if(type == "clip")
		{
			//press clip
			difference()
			{
				//start with pin shaped cylinder
				cylinder(joinerl,joinerr,joinerr);
				difference()
				{
					//create mask to remove narrow portion
					//start with a larger shorter cylinder, then hollow out the middle
					translate([0,0,-1]) cylinder(joinerl*0.7+1,joinerr*1.1,joinerr*1.1);
					translate([0,0,-1]) cylinder(joinerl*0.7+1,joinerr*0.8,joinerr*0.8);
				}
				difference()
				{
					//bevel on top for easy use
					//mask made with large cylinder, then subtracting bevel shape using cone cylinder
					translate([0,0,joinerl*0.8]) cylinder(joinerl,joinerr*1.1,joinerr);
					translate([0,0,joinerl*0.8]) cylinder(joinerl*0.7,joinerr,0);
				}
				//take out slice in middle
				translate([0-joinerr*1.1,0-joinerr*0.3,joinerl*0.2]) cube([joinerr*2.2,joinerr*0.6, joinerl*1.1]);
				//trim the sides to make them flat, anti spin, ease of use
				translate([0-joinerr*1.05,0-joinerr,0-joinerl*0.05]) cube([joinerr*0.3,joinerr*2,joinerl*1.1]);
				translate([joinerr*0.75,0-joinerr,0-joinerl*0.05]) cube([joinerr*0.3,joinerr*2,joinerl*1.1]);
			}
		}
	}
	//female mask, to subtract
	if(gen == "female")
	{
		if(type == "pin")
		{
			translate([0,0,0])cylinder(joinerl+tol,joinerr+tol,joinerr+tol);
		}
		if(type == "clip")
		{
			difference()
			{
				//start with pin shaped cylinder, bigger for tolerance
				cylinder(joinerl+tol,joinerr+tol,joinerr+tol);
				difference()
				{
					//create mask to remove narrow portion, with more tolerance	
					//start with a larger shorter cylinder, then hollow out the middle
					cylinder(joinerl*0.7-tol,joinerr*1.1+tol,joinerr*1.1+tol);
					cylinder(joinerl*0.7-tol,joinerr*0.8+tol,joinerr*0.8+tol);
				}
				//trim the sides to make them flat, anti spin, ease of use
				translate([0-joinerr*1.05-tol,0-joinerr,0-joinerl*0.05]) cube([joinerr*0.3,joinerr*2,joinerl*1.1]);
				translate([joinerr*0.75+tol,0-joinerr,0-joinerl*0.05]) cube([joinerr*0.3,joinerr*2,joinerl*1.1]);
			}
		}
	}
}