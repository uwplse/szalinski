//Rewards Card
//W. Collins
//2013

//Use this card to track some goal: break off a tab
//(and recycle it) everyday that you work on your goal,
//then reward yourself when they are all gone at the
//end of the month! 


use <write/Write.scad>
//resolution (50+)
$fn = 50;

//credit card dimensions-keep
card_x = 85.60;
//credit card dimensions-keep
card_y = 53.98;
//card thickness (2.5 = max recommended)
card_z = 2.1;

//break-off tab width
tab_x = 3;
//break-off tab depth
tab_y = 8;
//break-off tab cut plane(do not change)
tab_z = 10;

//number of tabs on long edge
edge_x1_num = 10;


//number of tabs on short edge
edge_y1_num = 4;


//tab center-center space
break = 6;

//Card Name
text_1 = "$30 Splurge";

//Text height
text_h = 8;

difference()
{
	cube([card_x , card_y, card_z]);
	for( i = [1 : edge_x1_num + 1])
	{
		translate([i * break , 0 , -.5 * tab_z])
		cube([tab_x , tab_y , tab_z]);
	}
	
	for( i = [1 : edge_x1_num + 1])
	{
		translate([i * break , card_y - tab_y , -.5 * tab_z])
		cube([tab_x , tab_y , tab_z]);
	}

	for( i = [1 : edge_y1_num + 1])
	{
		translate([0, i * break + ( tab_y) , -.5 * tab_z])
		cube([tab_y , tab_x , tab_z]);
	}

	for( i = [1 : edge_y1_num + 1])
	{
		translate([card_x - tab_y, i * break + ( tab_y) , -.5 * tab_z])
		cube([tab_y , tab_x , tab_z]);
	}
	
	translate([card_x / 2, card_y / 2 , 0])
	write(text_1 , h = text_h , t = card_z * 2, center=true);


}
 
