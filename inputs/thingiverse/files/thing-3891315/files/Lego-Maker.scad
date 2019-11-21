//Width of Lego Brick
width = 2;
//Length of Lego Brick
length = 3;
//Resolution (100 is usually plenty good)
$fn=100;

Lego_Maker (width,length);
 
// Parameters:
// Length:	Number of pegs long
// Width:	Number of pegs wide
// Pegs On:	Generate Pegs or No Pegs
//

module Lego_Maker (width, length)
{

 	// Variables
	unit_height = 9.6; // Height of main Brick
	unit_width = 8; // width of one Unit
	nub_diameter = 4.8; // Diameter of linking nub
	nub_height = 1.8; // Height off the top of brick
	play = 0.1;	// Removed from all outside sides to allow for play
	support_diameter_inner = 4.8; // underside cylinder inner circle diameter
	support_diameter_outer = 6.5;// outer circle
	brick_thickness_verticle = 1.2;
	brick_thickness_horizontal = 1;
	union(){

union(){ // join the nubs, brick and other together
difference(){
	cube([length*unit_width, width*unit_width, unit_height], center=true); // Make the base of the brick
	translate([0,0,-1]) cube([length*unit_width-2.4, width*unit_width-2.4, unit_height], center=true);
}
	for (w = [0:width-1]) // for each row in width
{
	for (l = [0:length-1]) // and each column in length
{
	// Weird Math... 
	//The the cylinder() spawns in the center at 0,0,0 in the middle of the brick, so we need to move it
	//Height is easy, just move it up half the brick height
	//Length and Width are the same:
	// l*8-((length-1)*4) 
	// l is the column, time it by 8(a nub unit), and move it back a bit, I figured it out on a sugar rush, not sure if I can still explain it...
	color("blue") translate([l*8-((length-1)*4),   w*8-((width-1)*4),unit_height/2]) cylinder(h=nub_height, r=nub_diameter/2, center=false);
	//color("blue") translate([l*8-((length-1)*4),w*8-((width-1)*4),unit_height/2-6]) cylinder(h=nub_height*4, r=nub_diameter/2, center=false);

} 



}


}
if(length>1 && width>1){

	for (w = [0:width-2]) // for each row in width
{
	for (l = [0:length-2]) // and each column in length
{
difference(){
	color("green") translate([l*8- ((length-2)*4)  ,w*8-((width-2)*4),0])cylinder(h=unit_height, r=support_diameter_outer/2, center=true);//make the two cylinders one inside other, need a mini diffence, put in an if statement to avoid this if less than 2x2
	color("orange")translate([l*8- ((length-2)*4),w*8-((width-2)*4),0]) cylinder(h=unit_height, r=support_diameter_inner/2, center=true);
	}
	}}
	}
}
}

