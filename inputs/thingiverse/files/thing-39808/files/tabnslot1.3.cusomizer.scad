/*-------------------------------------------------------------------------\
Tab n Slot module

Author: SimCity


A simple module to generate tabs and slots to make 2 objects interlock
Use slots(); with a difference to cut grooves
Use tab(); with a union to add tabs to the other object

just about everything I could think of is panametric, just watch that you don't set certain values to numbers that wouldn't work. Most of these are simple math to avoid.

To Do: currently generating 2 or more tabs cannont be compliled to look right but renders fine. Need to fix this to make life easier
Stops are not implemented so have to make own if groove protrude out the other side of the object
Need to add some error code to stop the use of values that will result in slots longer than possible and tabs that are too big for there to be enough room for grooves.
\----------------------------------------------------------------------------*/

// Display Tabs or Slots? (Note: Slots generates what is to be cut away)
part=1; //[1:Tabs,0:Slots]

//diameter of center hole which everything rotates around
center_hole=55;
//turn on or off removing material from the center hole (broken atm)
cut_hole=0; //[0:Disabled,1:Enabled]
//how far you want to go in before turning
insert_depth=10;
//how deep to cut the groove (In other terms ho much should the tabs stick out by)
groove_depth=4;
//Ho wide should the groove be (Or in other terms how thick to make the tabs)
groove_width=3; 
//width of tab (Good idea to not make this more than Radius)
tab_width=10; 
//how far to rotate to lock, never set to more than 360/Tab Number
rotation=25; 
//Number of tabs, don't recommend using 1 for physical use but is handy for testing things
tab_number=2; //[2:10]
//self explanetry really, this will be dependant on printer
tollerance=0.2;
//which way you want to rotate, set to 0 for anti-clockwise
direction=1; //[1:Clockwise,0:Counter-Clockwise]
//use this if the center_hole is larger than the object that will have the tabs to extend them
gap=10;
//this adds a little indent and nub at the final resting point to make it harder to turn back, adjust to a value that is not too big just enough to make it click into place. Takes a bit of fine tuning
lock=0; 
//Use if slots material is going to be thinner than groove thickness to add a stop to edge of tab. Untested
stop=0; //[0:Disabled,1:Enabled]

//enable to remove any material that is in the arc the tabs will rotate through, not needed if cut_hole is set true
tab_clearance=0; //[0:Disabled,1:Enabled]


//test tabs
if (part){
union(){
//cylinder(r=center_hole/2, h=insert_depth);
tabs();
}
}
else{
//test slots

difference(){
translate([0,0,insert_depth/2-5])
cube([center_hole+groove_depth*2+40,center_hole+groove_depth*2+40,insert_depth+10],center=true);
//cylinder(r=center_hole/2, h=insert_depth+15,center=true);
slots();
}
}    
  

//math, leave commented (its in the modules only noted here for reference)
//a=center_hole+2*groove_depth+10;
//b=center_hole/2+groove_depth;
//c=tab_width/2+tollerance;

module slots(

center_hole=center_hole,
cut_hole=cut_hole,
insert_depth=insert_depth,
groove_depth=groove_depth,
groove_width=groove_width,
tab_width=tab_width,
rotation=rotation,
tab_number=tab_number,
tollerance=tollerance,
direction=direction,
gap=gap,
lock=lock,
stop=stop,
tab_clearance=tab_clearance

){

a=center_hole+2*groove_depth+10;
b=center_hole/2+groove_depth;
c=tab_width/2+tollerance;

	union(){
		for(i = [0:tab_number]){
			rotate((360/tab_number)*i)
			union(){
				difference(){
					cylinder(r=b, h=insert_depth);
					rotate(-rotation*(direction))
					translate([-a/2,c,-5])
					cube([a,b,insert_depth+10]);
					rotate(rotation*(1-direction))
					translate([-a/2,-c-b-10,-5])
					cube([a,b+10,insert_depth+10]);
					if(tab_clearance){
						translate([0,0,groove_width+2*tollerance])
						difference(){
							cylinder(r=b+5, h=insert_depth);
							cylinder(r=center_hole/2, h=insert_depth+10,center=true);
							translate([-a/2,(2*+c*direction)-c-b-10,-5])
							cube([a,b+10,insert_depth+10]);
						}
					}else {
						translate([-a/2,(2*c*direction)-c,groove_width+2*tollerance])
						cube([a,b+10,insert_depth]);
					}
					rotate([0,90,rotation*(direction)+90])
					cylinder(r=lock, h=center_hole+groove_depth+10);
				}
			}
		}
		if (cut_hole)
		cylinder(r=center_hole/2, h=insert_depth);
	}
}


module tabs(

center_hole=center_hole,
insert_depth=insert_depth,
groove_depth=groove_depth,
groove_width=groove_width,
tab_width=tab_width,
tab_number=tab_number,
tollerance=tollerance,
direction=direction,
gap=gap,
lock=lock,
stop=stop

){

a=center_hole+2*groove_depth+10;
b=center_hole/2+groove_depth;
c=tab_width/2+tollerance;

	intersection(){
		cylinder(r=b, h=insert_depth);
		for(i = [0:tab_number]){
		rotate((360/tab_number)*i)
            
            difference(){
                union(){

                    translate([0,-tab_width/2,0])
                    cube([center_hole+groove_depth,tab_width,groove_width]);
                    if(stop){
                        translate([(center_hole+groove_depth)/2,(tab_width/2-(groove_width/4))*(direction?1:-1),groove_width])
                        cube([center_hole+groove_depth,groove_width/2,groove_width],center=true); 
                    }
                }
                rotate([0,90,0])
                cylinder(r=lock, h=center_hole+groove_depth+10);
                translate([0,0,-5])
                if (cut_hole)
                cylinder(r=(center_hole/2)-tollerance-gap, h=groove_width+10);
            }

		}
	}
}

