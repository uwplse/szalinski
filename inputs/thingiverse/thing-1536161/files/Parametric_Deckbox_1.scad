//parametrics:


//length of deck --> a deck of 100 unsleeved cards are ~32mm thick, 100 sleeved cards ~57mm thick
deckl = 60;	
//width of deck in mm --> ~66 for unsleeved cards, ~70 for sleeved 
deckw = 70;	
//height of deck --> ~89 unsleeved, ~92 sleeved
deckh = 92;	
//changes where lid meets box;should be a value between 0.3 and 0.8
lid_height = 0.5;   
deckh_lower = deckh*lid_height;	
deckh_upper = deckh*(1-deckh_lower/deckh);
//how thick the walls are in mm, probably stay above 3
wall = 4;			
//how much tolerance for the lid in mm
tolerance = 0.6;	
//commander stuff
commandl = 2;		
commandw = 70;
//this determines the entire height of deckbox, should be greater than or equal to "deckh"
commandh = 92;     
//window for commander artwork
windoww = 55;		
windowh = 63;
//changes size of grip, 0 for no grip space
gripw = 30;			
griph = deckh_lower+deckh*0.2+tolerance;
bump_radius = wall/3;



///This was made by David South (south2012)


module Commander ()
	{
     difference()
        {
            	cube([commandl+2*wall,commandw+2*wall,commandh+wall]);
            translate([wall,wall,wall])
            	cube([commandl,commandw,commandh+0.01]);
        		translate([-0.01,((commandw+2*wall)-windoww)/2,commandh-windowh+0.01+wall])
            	cube([wall+0.02,windoww,windowh]);
			
        }    
	}
    
module Deckbox ()
    {
    difference()
        {
			union()
			{
         	cube ([deckl+(wall*2),deckw+(wall*2),deckh_lower+wall]);
			translate([wall,0.5*wall+tolerance/2,deckh_lower+wall])
				cube([deckl+0.5*wall-tolerance/2,deckw+wall-tolerance,deckh*0.2-tolerance/2]);
			}
			translate([wall,wall,wall])
				cube ([deckl,deckw,deckh+0.01]);
			translate([deckl/3-tolerance/4+wall,0,deckh_lower-(deckh/6)])
				cube([deckl/3+0.5*tolerance,wall/2+0.5*tolerance,deckh_lower]);
			translate([deckl/2+wall,wall/2+0.5*tolerance,deckh_lower-(deckh/6)])
				rotate(90,[1,0,0])cylinder($fn=50,r=deckl/6+tolerance/4,h=0.5*wall+0.5*tolerance);
			translate([deckl/3-tolerance/4+wall,1.5*wall+deckw-tolerance/2,deckh_lower-(deckh/6)])
				cube([deckl/3+0.5*tolerance,wall/2+tolerance,deckh_lower]);
			translate([deckl/2+wall,2*wall+deckw,deckh_lower-(deckh/6)])
				rotate(90,[1,0,0])cylinder($fn=50,r=deckl/6+tolerance/4,h=0.5*wall+0.5*tolerance);
        
        translate([deckl/3+tolerance/4+wall-tolerance/2,wall/2-tolerance/2,deckh_lower-(deckh/6)+3])
            {
           intersection(){rotate(90,[0,1,0])cylinder($fn=50,r=bump_radius+tolerance,h=deckl/3+tolerance);
           translate([0,0,-bump_radius-tolerance])cube([deckl/3+tolerance/2,bump_radius+tolerance,2*bump_radius+2*tolerance]);}}
       
           rotate(180,[0,0,1])translate([-2/3*deckl-wall-tolerance/4,-1.5*wall-deckw-tolerance/2,deckh_lower-(deckh/6)+3])
            {
           intersection(){rotate(90,[0,1,0])cylinder($fn=50,r=bump_radius+tolerance,h=deckl/3+tolerance);
           translate([0,0,-bump_radius-tolerance])cube([deckl/3+tolerance/2,bump_radius+tolerance,2*bump_radius+2]);}}
   
       }
    }

module Lid ()
	{
	difference()
		{
		translate([0,0,deckh_lower])
			cube([deckl+wall,deckw+2*wall,deckh_upper+wall]);
		translate([0,0.5*wall-tolerance/2,deckh_lower])
			cube([deckl+0.5*wall+tolerance/2,deckw+wall+tolerance,deckh*deckh_upper]);
		}
        difference()
        {
        translate([0,0,deckh_lower+0.2*deckh+tolerance/2]) cube([deckl+wall,deckw+2*wall,-0.2*deckh+commandh]);
        translate([0,wall,deckh_lower+0.2*deckh+tolerance/2]) cube([deckl,deckw,0.5*deckh-0.2*deckh+wall+commandh-deckh]);
        translate([-0.01,-0.01,commandh]) cube([deckl+wall+0.02,deckw+2*wall+0.02,deckh]);
        }
	translate([0,0,deckh])
		cube([deckl+wall,deckw+2*wall,commandh-deckh+wall]);
	translate([-1*(wall*2+commandl),((0.5*(deckw+2*wall))-(0.5*(commandw+2*wall))),commandh])
		cube([commandl+2*wall,commandw+2*wall,wall]);
	translate([deckl/3+tolerance/4,0,deckh_lower-(deckh/6)-wall])
		cube([deckl/3-tolerance/2,wall/2-tolerance/2,deckh/3]);
	translate([deckl/2,wall/2-0.5*tolerance,deckh_lower-(deckh/6+wall)])
		rotate(90,[1,0,0])cylinder($fn=50,r=deckl/6-tolerance/4,h=0.5*wall-0.5*tolerance);
	translate([deckl/3+tolerance/4,deckw+1.5*wall+0.5*tolerance,deckh_lower-(deckh/6)-wall])
		cube([deckl/3-tolerance/2,wall/2-tolerance/2,deckh/3]);
	translate([deckl/2,deckw+1.5*wall+0.5*tolerance+wall/2-tolerance/2,deckh_lower-(deckh/6)-wall])
		rotate(90,[1,0,0])cylinder($fn=50,r=deckl/6-tolerance/4,h=0.5*wall-0.5*tolerance);
    translate([deckl/3+tolerance/4,wall/2-tolerance/2-0.01,deckh_lower-(deckh/6)+3-wall])
            {
           intersection(){rotate(90,[0,1,0])cylinder($fn=50,r=bump_radius,h=deckl/3);
           translate([0,0,-bump_radius])cube([deckl/3-tolerance/2,bump_radius,2*bump_radius]);}}
    translate([2*deckl/3-tolerance/4,2*wall+deckw-wall/2+tolerance/2,deckh_lower-(deckh/6)+3-wall])
            {
           rotate(180,[0,0,1]){intersection(){rotate(90,[0,1,0])cylinder($fn=50,r=bump_radius,h=deckl/3);
           translate([0,0,-bump_radius])cube([deckl/3-tolerance/2,bump_radius,2*bump_radius]);}}}
           
    
       }
	
	
//Commander stuff

	{
	difference()
	{	
	translate ([-1*(commandl+2*wall),((0.5*(deckw+2*wall))-(0.5*(commandw+2*wall))),0])
		Commander();
		translate([-wall,(2*wall+deckw)/2,griph+0.5*commandh])
				{
				cube([4*wall,gripw,commandh],center=true);
				}
		translate([-wall,(2*wall+deckw)/2,griph])
				{
				rotate(90,[0,1,0])cylinder($fn=50,r=gripw/2,h=4*wall+2,center=true);
				}

	}
	}	


//Actual deck

translate([-wall,0,0])
   Deckbox();

rotate(180,[0,0,1])rotate(180,[0,1,0])translate([0,wall*4,-commandh-wall])
		
    Lid();

    





 
