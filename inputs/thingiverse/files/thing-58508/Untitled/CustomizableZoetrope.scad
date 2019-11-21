//-------------------------------------------------------------
//--------Written March 7th, 2013 by Sam Maliszewski-----------
//-------------------------------------------------------------

parts = "both"; // [both:Wheel and Stand,first:Wheel Only,second:Stand Only]

//How many frames your animation will be
frames = 12;

//Frame width (in mm)
width = 32;

//Frame height (in mm)
height = 24;

//How far frames are pushed out to create viewing slits
slit = 4;

//Scales the wheel but not the stand
set_diameter = 0; // [1:Yes, 0:No]

//Size the wheel will be scaled to
diameter = 120;

//Height from the axel to the ground
stand_height = 75;

//Variables
radius = (height+4 + slit) / 2 / tan(180/frames);
expand = tan(180/frames) * (radius + 2) * 2;
scale = (diameter/(radius*2)-1) * set_diameter + 1;

//-------------------------------------------------------------

//Part Switcher
print_part();

module print_part() {
	if (parts == "first") {
		singleWheel();
	} else if (parts == "second") {
		singleStand();
	} else if (parts == "both") {
		wheelAndStand();
	} else {
		wheelAndStand();
	}
}

//-------------------------------------------------------------

module wheelAndStand() {

//Wheel--------------------------------------------------------

translate([-radius*scale - 10,0,0]){
difference(){ 					//subtract holes
union(){ 						//make wheel watertight
scale(scale){
for(i=[0 : frames]){				//loop through frames
rotate([0,0,i*360/frames]){		//rotate beam and frameholder

translate([(height+4)/-2,radius,0]){		//place holder
cube([height+4,2,width+4]);		//backplate
translate([(expand-height-4)/-2,-2,0]){ //place bottomplate
	cube([expand,4,6]);	//bottomplate
}	
translate([0,-2,0]){				//move left side
	cube([2,4,width+4]);		//left side
}
translate([height+2,-2,0]){		//move right side
	cube([2,4,width+4]);		//right side
}
translate([0,-2,0]){				//move left clip
	cube([4,1,width+4]);		//left clip
}
translate([height,-2,0]){			//move right clip
	cube([4,1,width+4]);		//right clip
}
}
rotate([0,0,360/frames/2]){		//rotate support beam
translate([-3,0,0]){				//place support beam
	cube([6,(height+4 + slit) / 2 / sin(180/frames),3]); //support beam
}}}}}

cylinder(h=5*scale, r=16);				//hub cylinder
}

for(i=[0 : 3]){					//create 4 holes
rotate([0,0,i*90]){				//move holes around axis
translate([12,0,-1]){			//place holes
	cylinder(h=7*scale, r=3.5);		//holes
}}}
translate([0,0,-1]){				//place center hole
cylinder(h=7*scale, r=5.5);			//center hole
}}}

//Stand--------------------------------------------------------

translate([stand_height/2 + 10,0,0]){
union(){
translate([0,-15,1]){
translate([0,0,stand_height]){
rotate([-90,0,0]){
difference(){
cylinder(h=10,r=15);
translate([0,0,-1]){
cylinder(h=12,r=5.25);}}}}
translate([-10,0,-1]){
cube([20,10,stand_height-7.5]);}
translate([stand_height/-2,0,-1]){
cube([stand_height,10,5]);}
translate([stand_height/-2,-40,-1]){
cube([10,60,5]);}
translate([(stand_height/2)-10,-40,-1]){
cube([10,60,5]);}
translate([(stand_height/-2)+5,-40,-1]){
cylinder(h=5,r=5);}
translate([(stand_height/2)-5,-40,-1]){
cylinder(h=5,r=5);}
translate([(stand_height/-2)+5,20,-1]){
cylinder(h=5,r=5);}
translate([(stand_height/2)-5,20,-1]){
cylinder(h=5,r=5);}
}

//Knob
translate([15,45,0]){
intersection(){
translate([0,0,8]){
scale([1,1,1.8]){
sphere(12);}}
translate([0,0,12.5]){
cube(25, true);}}
translate([0,0,30]){
cube([8,2,10], true);}
translate([0,0,30]){
cube([2,8,10], true);}
}

//Hub
translate([-15,45,0]){
difference(){
cylinder(h=10,r=15);
translate([0,0,5]){
cube([9,3,12], true);}
translate([0,0,5]){
cube([3,9,12], true);}}
for(i=[0 : 3]){
rotate([0,0,i*90]){	
translate([12,0,0]){
cylinder(h=20,r=3, $fn=16);}}}
}

//Arm
translate([0,20,0]){
difference(){
hull(){
translate([20,0,0]){
cylinder(h=10,r=7);}
translate([-20,0,0]){
cylinder(h=11,r=7);}}
translate([20,0,5]){
cube([9,3,12], true);}
translate([20,0,5]){
cube([3,9,12], true);}}
translate([-20,0,0]){
cylinder(h=21.5,r=5);}
translate([-20,0,25]){
cube([8,2,10], true);}
translate([-20,0,25]){
cube([2,8,10], true);}
}
}
}
}

//-------------------------------------------------------------

module singleWheel() {

//Wheel--------------------------------------------------------

difference(){ 					//subtract holes
union(){ 						//make wheel watertight
scale(scale){
for(i=[0 : frames]){				//loop through frames
rotate([0,0,i*360/frames]){		//rotate beam and frameholder

translate([(height+4)/-2,radius,0]){		//place holder
cube([height+4,2,width+4]);		//backplate
translate([(expand-height-4)/-2,-2,0]){ //place bottomplate
	cube([expand,4,6]);	//bottomplate
}	
translate([0,-2,0]){				//move left side
	cube([2,4,width+4]);		//left side
}
translate([height+2,-2,0]){		//move right side
	cube([2,4,width+4]);		//right side
}
translate([0,-2,0]){				//move left clip
	cube([4,1,width+4]);		//left clip
}
translate([height,-2,0]){			//move right clip
	cube([4,1,width+4]);		//right clip
}
}
rotate([0,0,360/frames/2]){		//rotate support beam
translate([-3,0,0]){				//place support beam
	cube([6,(height+4 + slit) / 2 / sin(180/frames),3]); //support beam
}}}}}

cylinder(h=5*scale, r=16);				//hub cylinder
}

for(i=[0 : 3]){					//create 4 holes
rotate([0,0,i*90]){				//move holes around axis
translate([12,0,-1]){			//place holes
	cylinder(h=7*scale, r=3.5);		//holes
}}}
translate([0,0,-1]){				//place center hole
cylinder(h=7*scale, r=5.5);			//center hole
}}
}

//-------------------------------------------------------------

module singleStand() {

//Stand--------------------------------------------------------

union(){
translate([0,-15,1]){
translate([0,0,stand_height]){
rotate([-90,0,0]){
difference(){
cylinder(h=10,r=15);
translate([0,0,-1]){
cylinder(h=12,r=5.25);}}}}
translate([-5,0,-1]){
cube([10,10,stand_height-10]);}
translate([stand_height/-2,0,-1]){
cube([stand_height,10,5]);}
translate([stand_height/-2,-40,-1]){
cube([10,60,5]);}
translate([(stand_height/2)-10,-40,-1]){
cube([10,60,5]);}
translate([(stand_height/-2)+5,-40,-1]){
cylinder(h=5,r=5);}
translate([(stand_height/2)-5,-40,-1]){
cylinder(h=5,r=5);}
translate([(stand_height/-2)+5,20,-1]){
cylinder(h=5,r=5);}
translate([(stand_height/2)-5,20,-1]){
cylinder(h=5,r=5);}
}

//Knob
translate([15,45,0]){
intersection(){
translate([0,0,8]){
scale([1,1,1.8]){
sphere(12);}}
translate([0,0,12.5]){
cube(25, true);}}
translate([0,0,30]){
cube([8,2,10], true);}
translate([0,0,30]){
cube([2,8,10], true);}
}

//Hub
translate([-15,45,0]){
difference(){
cylinder(h=10,r=15);
translate([0,0,5]){
cube([9,3,12], true);}
translate([0,0,5]){
cube([3,9,12], true);}}
for(i=[0 : 3]){
rotate([0,0,i*90]){	
translate([12,0,0]){
cylinder(h=20,r=3, $fn=16);}}}
}

//Arm
translate([0,20,0]){
difference(){
hull(){
translate([20,0,0]){
cylinder(h=10,r=7);}
translate([-20,0,0]){
cylinder(h=11,r=7);}}
translate([20,0,5]){
cube([9,3,12], true);}
translate([20,0,5]){
cube([3,9,12], true);}}
translate([-20,0,0]){
cylinder(h=21.5,r=5);}
translate([-20,0,25]){
cube([8,2,10], true);}
translate([-20,0,25]){
cube([2,8,10], true);}
}
}
}