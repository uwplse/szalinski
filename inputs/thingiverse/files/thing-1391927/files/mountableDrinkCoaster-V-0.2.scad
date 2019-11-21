/*update notes vor V 0.2:
	so I'm scrapping a lot of the old code and changing how it creates the file. Hopefully this makes it on the build plate instead of in the middle of it. (fingers crossed)
*/

//CUSTOMIZER VARIABLES

//	These units are in inches
height_Of_table = .75;

//	These units are also in inches
diameter_Of_cup=4;

//	How deep it clips onto the table
depth_Of_slot=3;

//	How thick the part is that clips onto the table
thickness_Of_slot=.125;

//	This option will not appear because of the *1
inch = 25.4*1;

//CUSTOMIZER VARIABLES END

/*I use the inch variable so I can design relative to inches 
  but the file will be in mm, aka I'm lazy, 
  and it is easier for me to follow
	also I used the capital Of so 
	I can easily re-assign the variable*/

height_of_table=height_Of_table*inch;
diameter_of_cup=diameter_Of_cup*inch;
depth_of_slot = depth_Of_slot*inch;
thickness_of_slot = thickness_Of_slot*inch;

height_of_thing = height_of_table+2*thickness_of_slot;
radi_of_cup = diameter_of_cup/2;

difference() {
	//this makes the inital rectangular prism this everything is then cut out of.
	union (){//combines stuff first so it's easier to work with
		translate([0,0,height_of_thing/2]){
			cube([diameter_of_cup+inch/4,diameter_of_cup+inch/4,height_of_thing],center = true);
		}
		
		//this adds the two small cubes that hold it to the table
		difference(){
			translate([0,diameter_of_cup/2+inch/2,height_of_thing/2]){
				cube([diameter_of_cup+inch/4,depth_of_slot,height_of_thing],center = true);
			}
			translate([0,diameter_of_cup/2+inch/2,height_of_thing/2]){
				cube([diameter_of_cup+inch/2,depth_of_slot+inch/4,height_of_table], center = true);
				//I needed to make the width and length of it a bit 
				//larger so there is it is clear it cuts it all out.
			}
		}
	}
	
	//this cuts out the hole for the cup
	translate([0,0,5]){
		rotate([0, 0, 0])
		cylinder(height_of_thing, r = radi_of_cup, $fn = 100);
	}
	
	//this fillets the top of the hole so it's easier to put the drink in
	difference(){
		//so this cuts a small cylinder out
		translate([0,0,height_of_thing-inch/8])
			cylinder(inch, r = radi_of_cup+inch/8,$fn = 100);	
		//this prevents a small rounded edge from being cut out, this gives the appearance of a fillet
		translate([0,0,height_of_thing/2]){
			rotate_extrude(convexity = 10, $fn = 100)
				translate([radi_of_cup+inch/8,height_of_table/2,0])
				rotate([0,0,90])
					circle(r = inch/8, $fn = 100);
		}
	}
	
	//this will round the exposed edges
	difference(){
		//this makes a small box
		translate([0,-(diameter_of_cup/2+inch),0])
			cube([diameter_of_cup*2,diameter_of_cup+2*inch,100],center=true);
		
		//this makes sure a semi-circle remains once it's done.
		translate([0,0,-50])
			cylinder(height_of_table+5*inch, r=radi_of_cup+inch*.125, $fn = 200);
		
	}
	
}	