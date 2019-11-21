// Customizable Jack-O-Lantern v1.2
// by TheNewHobbyist 2014 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:162641
//
// I wanted to make a couple 3D printed Halloween dectorations.
// It seemed like a waste not to make to customizable as well.
//						
// Change Log:		                                            ,_   .-.
//                                                              \ `\/ '`
// v1.0                                                    _.--"|  |"--._
// Initial Release                                       .' /  /`--`\  \ '.
//                                                      /  ;  /\    /\  ;  \
// v1.1                                                ;  |  /o_\  /o_\  |  ;
// ADDED additoinal some toothy                        |  |   |  /\  |   |  |
//     grins for ramai                                 ;  | /\; '--' ;/\ |  ;                 
//                                                      \  ;\ \/\/\/\/ /;  /
// v1.2                                                  '._\\_/\__/\_//_.' 
// ADDED Kayla078's "organic" pumpkin design        jgs     `'--'--'--'`
// http://www.thingiverse.com/Kayla078
// http://www.thingiverse.com/thing:477836
//

/////////////////////////
//  Customizer Stuff  //
///////////////////////

/* [Happy Halloween!] */

pumpkin_style = "Organic"; // [8-Bit:8-Bit,Organic:Organic]
select_eyes = "None"; // [None:None,oval_eyes:Oval Eyes,rectangular_eyes:Rectangular Eyes,round_eyes:Round Eyes,square_eyes:Square Eyes,triangular_eyes:Triangular Eyes]
select_nose = "None"; // [None:None,oval_nose:Oval Nose,rectangular_nose:Rectangular Nose,round_nose:Round Nose,square_nose:Square Nose,triangular_nose:Triangular Nose]
select_mouth = "None"; // [None:None,oval_mouth:Oval Mouth,rectangular_mouth:Rectangular Mouth,round_mouth:Round Mouth,square_mouth:Square Mouth,teeth:Teeth,triangular_mouth:Triangular Mouth,underbite:Underbite]
// Leave the bottom open for lighting?
open_bottom = "yes"; // [yes:Yes,no:No]

/////////////////////////
// Beat it Customizer //
///////////////////////

/* [Hidden] */

use <write/Write.scad>
// preview[view:south, tilt:side]
$fn=32;

///////////////////////
// The Pumpkin Guts //
/////////////////////

module wall(rad1, rad2, height){
	translate([13,0,0]) cylinder(r1=rad1/2, r2=rad2/2, h=height, center=true);
}

module pumpkin(rad1, rad2, height){
	rotate([0,0,0]) wall(rad1, rad2, height);
	rotate([0,0,45]) wall(rad1, rad2, height);
	rotate([0,0,90]) wall(rad1, rad2, height);
	rotate([0,0,45*3]) wall(rad1, rad2, height);
	rotate([0,0,45*4]) wall(rad1, rad2, height);
	rotate([0,0,45*5]) wall(rad1, rad2, height);
	rotate([0,0,45*6]) wall(rad1, rad2, height);
	rotate([0,0,45*7]) wall(rad1, rad2, height);	
}

module full_pumpkin(){
	pumpkin(10.9,13.1, 2);
	cylinder(r=10, h=2, center=true);
	translate([0,0,2]) pumpkin(13.1,17.1, 2);
	translate([0,0,2*2]) pumpkin(17.1,22.2, 2);
	translate([0,0,2*3]) pumpkin(22.2,27.8, 2);
	translate([0,0,2*4]) pumpkin(27.8,32, 2);
	translate([0,0,2*5]) pumpkin(32,33.6, 2);
	translate([0,0,2*6]) pumpkin(33.6,33.9, 2);
	translate([0,0,2*7+15]) pumpkin(33.9,33.9, 34);
	translate([0,0,2*23.5]) pumpkin(33.9,30.5, 2);
	translate([0,0,2*24.5]) pumpkin(30.5,24.7, 2);
	translate([0,0,2*25.5]) pumpkin(24.7,19.8, 2);
	translate([0,0,2*26.5]) pumpkin(19.8,15.8, 2);
	translate([0,0,2*27+.5]) pumpkin(15.8,7, 1);
}

module hollow_pumpkin(){
	union(){
		color("Brown") translate([0,0,2*27.2]) cylinder(r1=2,r2=3, h=10, center=true);
		difference(){
			color("Orange") full_pumpkin();
			translate([0,0,25]) sphere(r=25);
			translate([0,-15,-1]) rotate([0,0,180]) write("T",h=4,t=2,font="write/orbitron.dxf", space=1, center=true);
			rotate([0,0,45]) translate([0,-15,-1]) rotate([0,180,0]) write("N",h=4,t=2,font="write/orbitron.dxf", space=1, center=true);
			rotate([0,0,90]) translate([0,-15,-1]) write("H",h=4,t=2,font="write/orbitron.dxf", space=1, center=true);
		}
	}
}

module bottom(){
	if (open_bottom == "yes"){
		cylinder(r=12, h=10, center=true);
		translate([0,20,0]) rotate([90,0,0]) cylinder(r=2, h=20, center=true);
	}
}

module eyes(){
	if (select_eyes == "oval_eyes"){
		translate([-10,-25,38]) scale([1.4,1.2,.9]) rotate([90,0,0]) cylinder(r=5, h=30, center=true);
		translate([10,-25,38]) scale([1.4,1.2,.9]) rotate([90,0,0]) cylinder(r=5, h=30, center=true);
	}
	else if (select_eyes == "rectangular_eyes"){
		translate([-10,-25,38]) cube([15, 40, 8], center=true);
		translate([10,-25,38]) cube([15, 40, 8], center=true);
	}
	else if (select_eyes == "round_eyes"){
		translate([10,-20,38]) rotate([90,0,0]) cylinder(r=5, h=25, center=true);
		translate([-10,-20,38]) rotate([90,0,0]) cylinder(r=5, h=25, center=true);
	}
	else if (select_eyes == "square_eyes"){
		translate([10,-20,38]) cube([10, 25, 10], center=true);
		translate([-10,-20,38]) cube([10, 25, 10], center=true);
	}
	else if (select_eyes == "triangular_eyes"){
		translate([10,-20,38]) rotate([90,30,0]) cylinder(r=7, h=25, center=true, $fn=3);
		translate([-10,-20,38]) rotate([90,30,0]) cylinder(r=7, h=25, center=true, $fn=3);
	}
}

module nose(){
	if (select_nose == "oval_nose"){
		translate([0,-25,27]) scale([1,1.2,.7]) rotate([90,0,0]) cylinder(r=5, h=14, center=true);
	}
	else if (select_nose == "rectangular_nose"){
		translate([0,-25,27]) cube([10,17, 5], center=true);
	}
	else if (select_nose == "round_nose"){
		translate([0,-20,27]) rotate([90,0,0]) cylinder(r=4, h=28, center=true);
	}
	else if (select_nose == "square_nose"){
		translate([0,-20,27]) cube([6, 28, 6], center=true);
	}
	else if (select_nose == "triangular_nose"){
		translate([0,-20,27]) rotate([90,30,0]) cylinder(r=4, h=28, center=true, $fn=3);
	}
}

module mouth(){
	if (select_mouth == "oval_mouth"){
		translate([0,-25,15]) scale([2,1.2,1]) rotate([90,0,0]) cylinder(r=5, h=14, center=true);
	}	
	else if (select_mouth == "round_mouth"){
		translate([0,-20,15]) rotate([90,0,0]) cylinder(r=5, h=25, center=true);
	}
	else if (select_mouth == "rectangular_mouth"){
		translate([0,-25,15]) cube([20, 15, 10], center=true);
	}
	else if (select_mouth == "square_mouth"){
		translate([0,-20,15]) cube([10, 25, 10], center=true);
	}
	else if (select_mouth == "teeth"){
		translate([-10,-20,15]) cube([4, 25, 5], center=true);
		translate([0,-20,15]) cube([4, 25, 5], center=true);
		translate([10,-20,15]) cube([4, 25, 5], center=true);
		translate([5,-20,20]) cube([4, 25, 5], center=true);
		translate([-5,-20,20]) cube([4, 25, 5], center=true);
		translate([-15,-20,20]) cube([4, 25, 5], center=true);
		translate([15,-20,20]) cube([4, 25, 5], center=true);
		
	}	
	else if (select_mouth == "triangular_mouth"){
		translate([0,-20,16]) scale([2.2,1,.8]) rotate([90,-30,0]) cylinder(r=6, h=25, center=true, $fn=3);
	}
	else if (select_mouth == "underbite"){
		difference(){
			translate([0,-25,15]) scale([2.5,1.2,.8]) rotate([90,0,0]) cylinder(r=5, h=15, center=true);
			translate([0,-20,10]) cube([4, 20, 10], center=true);
			translate([6,-20,10]) cube([4, 20, 10], center=true);
			translate([-6,-20,10]) cube([4, 20, 10], center=true);
		}
	}
}

module organic_pumpkin(){
	color("orange") union() { 
		scale([1.15, 1, 1.25]) translate([9, 0, 0]) sphere(r=20);
		scale([1.15, 1, 1.25]) translate([-9, 0, 0]) sphere(r=20);
	}

	color("orange") rotate([0,0,55]) scale([1.15, 1, 1.25]) translate([9, 0, 0]) sphere(r=20);
	color("orange") rotate([0,0,-50]) scale([1.15, 1, 1.25]) translate([9, 0, 0]) sphere(r=20);
	color("orange") rotate([0,0,-100]) scale([1.15, 1, 1.25]) translate([9, 0, 0]) sphere(r=20);
	color("orange") rotate([0,0,-80]) scale([1.15, 1, 1.25]) translate([-9, 0, 0]) sphere(r=20);
	color("orange") rotate([0,0,-35]) scale([1.15, 1, 1.25]) translate([-9, 0, 0]) sphere(r=20);
	color("orange") rotate([0,0,45]) scale([1.15, 1, 1.25]) translate([-9, 0, 0]) sphere(r=20);

	color("brown") linear_extrude(height = 32, convexity = 2, twist = -400)
	translate([1, -1, 0])
	circle(r = 3.5);	
}

module organic_cutout(){
		union() { 
		scale([1.15, 1, 1.25]) translate([9, 0, 0]) sphere(r=20);
		scale([1.15, 1, 1.25]) translate([-9, 0, 0]) sphere(r=20);
	}

	rotate([0,0,55]) scale([1.15, 1, 1.25]) translate([9, 0, 0]) sphere(r=20);
	rotate([0,0,-50]) scale([1.15, 1, 1.25]) translate([9, 0, 0]) sphere(r=20);
	rotate([0,0,-100]) scale([1.15, 1, 1.25]) translate([9, 0, 0]) sphere(r=20);
	rotate([0,0,-80]) scale([1.15, 1, 1.25]) translate([-9, 0, 0]) sphere(r=20);
	rotate([0,0,-35]) scale([1.15, 1, 1.25]) translate([-9, 0, 0]) sphere(r=20);
	rotate([0,0,45]) scale([1.15, 1, 1.25]) translate([-9, 0, 0]) sphere(r=20);

}

module organic_flat(){
	difference(){
		organic_pumpkin();
		translate([0,0,-34]) cube([100, 100, 20], center=true);
	}
}


module organic_hollow(){
	difference(){ 
		organic_cutout();
		translate([0,0,-30]) cube([100, 100, 20], center=true);
	}
}


////////////////////////    
//          /))       //
//       __(((__      //
//    .' _`""`_`'.    //
//   /  /\\  /\\  \   //
//  |  /)_\\/)_\\  |  //
//  |  _  _()_  _  |  //
//  |  \\/\\/\\//  |  // 
//   \  \/\/\/\/  /   //
//    '.___..___.'    //
//                    //
// Jackolantern Time! //
////////////////////////

if (pumpkin_style == "8-Bit"){
	union(){
		difference(){
			hollow_pumpkin();
			eyes(select_eyes);
			nose(select_nose);
			mouth(select_mouth);
			bottom(open_bottom);
		}
	}
}
else {
	difference(){
		translate([0,0,28]) organic_flat();
		scale(.85) translate([0,0,28]) organic_hollow();
		eyes(select_eyes);
		nose(select_nose);
		mouth(select_mouth);
		translate([0,0,4]) bottom(open_bottom);
	}
}


