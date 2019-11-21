//
//
//			Ladder Light bracket
//
//			slips over step ladder to hold trouble light
//			or flash light
//
//
//			R. Lazure 		June 2019
//
//
length = 175; // [160:1:200]
width = 26; // [20:1:40]
//

/* [Hidden] */
bar_width = 10;
bar_height = 10;
tab_length = 10; 
$fn=60;
//
//
union () {

//
// long bar
//
color("pink")
translate([0,0,0]) rotate([0,0,0]) 
	cube(size = [length+2*bar_width, bar_width, bar_height], center = false); 
//
//  left side bar
//
color("red")
translate([bar_width,bar_width,0]) rotate([0,0,90]) 
	cube(size = [width, bar_width, bar_height], center = false); 
//
//  tab
//
color("green")
translate([0,width+bar_width,0]) rotate([0,0,0]) 
	cube(size = [bar_width+tab_length, bar_width, bar_height], center = false); 
//
//  right side bar
//
color("red")
translate([length+2*bar_width,bar_width,0]) rotate([0,0,90]) 
	cube(size = [width, bar_width, bar_height], center = false); 
//
//  tab
//
color("green")
translate([length+bar_width-tab_length,width+bar_width,0]) rotate([0,0,0]) 
	cube(size = [tab_length+bar_width, bar_width, bar_height], center = false);

} 

