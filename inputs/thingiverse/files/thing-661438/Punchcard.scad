


//Do Nothing = 0
//Increment = 1
//Decrement = 2
//Increment + Zerocheck = 3
//Decrement + Zerocheck = 4

//Text position:
//Top left: 0
//Left side inwards: 1
//Left side outwards: 2

/* [Instructions] */

//Instructions for the Left Counter
Left_counter = 0; // [0:Do Nothing,1:Increment,2:Decrement,3:Increment and Check Zero,4:Decrement and Check Zero]

//Instructions for the Middle Counter
Middle_counter = 0; // [0:Do Nothing,1:Increment,2:Decrement,3:Increment and Check Zero,4:Decrement and Check Zero]

//Instructions for the Right Counter
Right_counter = 0; // [0:Do Nothing,1:Increment,2:Decrement,3:Increment and Check Zero,4:Decrement and Check Zero]

//Hole that currently has no purpose
No_Purpose_Hole = 0; // [0:Don't create hole,1:Create hole]

/* [Text] */

//Text to show
Text="";

//Can be used for card number, description, etc.
Text_position=0;// [0:Top left corner (1-3 chars),1:Left side facing inwards (1-12 chars),2:Left side facing outwards (1-12 chars)]

/* [Hidden] */

$fn=30;


include <write/Write.scad>;

punchcard();

module punchcard(){

scale([25.4,25.4,25.4])
difference(){
card(Text);
union(){


if (Left_counter == 1)
	hole(3);
if (Left_counter == 2)
	hole(1);
if (Left_counter == 3){
	hole(3);
	hole(5);}
if (Left_counter == 4){
	hole(1);
	hole(5);}

if (Middle_counter == 1)
	hole(2);
if (Middle_counter == 2)
	hole(8);
if (Middle_counter == 3){
	hole(2);
	hole(4);}
if (Middle_counter == 4){
	hole(8);
	hole(4);}

if (Right_counter == 1)
	hole(10);
if (Right_counter == 2)
	hole(7);
if (Right_counter == 3){
	hole(10);
	hole(9);}
if (Right_counter == 4){
	hole(7);
	hole(9);}

if (No_Purpose_Hole == 1)
	hole(6);
	

}}}


module card(text){
	difference(){
		cube([3.3,1.8,.1]);
		translate([0,0,-.5])union(){
		//positioning holes
			translate([1.65,.25,0])
				cylinder(d=.25,h=1);
			translate([1.65, 1.55,0])
				cylinder(d=.25,h=1);
		//threading holes
			for(x=[.125,3.175])
				for(y=[.125,1.675])
					translate([x,y,0])
						cylinder(d=.125,h=1);
		}
if (Text_position == 0)
	translate([.4,1.675,.1])			
	scale([.04,.04,.1])
		writecube(text = Text, face = "top", size = .01, font = "write/Letters.dxf");
if (Text_position == 1)
	translate([.1,.9,.1])
	scale([.04,.04,.1])
	rotate([0,0,90])
		writecube(text = Text, face = "top", size = .01,font = "write/Letters.dxf");
if (Text_position == 2)
	translate([.1,.9,.1])
	scale([.04,.04,.1])
	rotate([0,0,-90])
		writecube(text = Text, face = "top", size = .01,font = "write/Letters.dxf");
						
		
	}
}

module hole (position){
	
	translate([.3*position,0.7,-.5])
	union(){
		cylinder(d=.2, h=1);
		translate([-.1,0,0])
			cube([.2,.3,1]);
		translate([0,.3,0])
			cylinder(d=.2, h=1);
		}}
	