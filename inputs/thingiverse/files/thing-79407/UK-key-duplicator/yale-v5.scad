/**********************************************
 *     Author : Rory Renton                   *
 *Description : generates Yale compatible keys*
 **********************************************/

use <write/Write.scad> 

// preview[view:south, tilt:side]

/************
 *Parameters*
 ************/

//Text on key
grip_text="";

//(closest to tip)
notch1= 6; //[0:9]
notch2= 3; //[0:9]
notch3= 5; //[0:9]
notch4= 2; //[0:9]
//(closest to handle)
notch5= 4; //[0:9]

//(key pattern offset in mm)
pattern_offset=5; //[3:10]

//cutting style
cutter_style=0; //[0:Normal, 1:Enhanced]

//Position ready for printing?
print_ready=0; //[0:No,1:Yes]

/*[Advanced]*/

shaft_length=26;//[20:35]
shaft_height=8;//[5:10]
key_width	=2;//[1.8,1.9,2.0,2.1,2.2]
grip_radius	=12;//[10:17]
stop_width	=3;//[2:5]

if (print_ready==0){
	rotate([-90,0,-180]) create_yale();
} else if (print_ready==1) {
	create_yale();
} else {
	rotate([0,180,180]) create_yale();
}

/***********
 *Yale Keys*
 ***********/
 
module create_yale()
{
	notch_width	=2;
	notch_spacer=2.2;
	tip_width	=8.5;
	notch_offsetZ=0.48;
	notch_baseZ	=-0.40;
	notch_angle=45;

	create_circle_grip();		

	difference(){
		create_grooves_yale();

		//Make the end of the key
		rotate([0,0,0]) cutter(0,-4.8,tip_width,notch_angle);
		rotate([180,0,0]) cutter(0,-2.2,tip_width,notch_angle);
		translate([-7.49,0,0]) cube([15,15,15], center=true);

		//cut the notches for pins
		if (cutter_style==0) {
			cutter(1 + notch_spacer + pattern_offset,notch_baseZ + (notch1*notch_offsetZ),notch_width,notch_angle);
			cutter(1 + (notch_spacer*3) + pattern_offset,notch_baseZ + (notch2*notch_offsetZ),notch_width,notch_angle);
			cutter(1 + (notch_spacer*5) + pattern_offset,notch_baseZ + (notch3*notch_offsetZ),notch_width,notch_angle);
			cutter(1 + (notch_spacer*7) + pattern_offset,notch_baseZ + (notch4*notch_offsetZ),notch_width,notch_angle);
			cutter(1 + (notch_spacer*9) + pattern_offset,notch_baseZ + (notch5*notch_offsetZ),notch_width,notch_angle);
		}else{
			rotate([180,0,0])
			translate([-3,0,-5])
			linear_extrude(height=10)
			polygon(points=[
				[1+pattern_offset-(notch_spacer*10)				  , 5],
				[1+pattern_offset+(notch_spacer*1)				  , notch_baseZ + (notch1*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*1)+(notch_width*1), notch_baseZ + (notch1*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*2)+(notch_width*1), notch_baseZ + (notch2*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*2)+(notch_width*2), notch_baseZ + (notch2*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*3)+(notch_width*2), notch_baseZ + (notch3*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*3)+(notch_width*3), notch_baseZ + (notch3*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*4)+(notch_width*3), notch_baseZ + (notch4*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*4)+(notch_width*4), notch_baseZ + (notch4*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*5)+(notch_width*4), notch_baseZ + (notch5*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*5)+(notch_width*5), notch_baseZ + (notch5*notch_offsetZ)],
				[1+pattern_offset+(notch_spacer*8)+(notch_width*5), 5],
			]);
		}
	}
}

module create_grooves_yale(){
	difference(){
		create_shaft();
		//first square
		poly_groove([[0,0.8],[1.3,1.2],[1.3,2.8],[0,3.2]],0,0,1);
		//key pattern groove
		poly_groove([[0,5.8],[1.3,6.3],[1.3,6.8],[0.65,7.8],[0.65,8.4],[0,8.4]],0,0,1);
		//second square
		poly_groove([[0,3.5],[1.3,3.8],[1.3,5.2],[0.4,5.6],[0,6]],0,0,0);
		//keypattern slope
		poly_groove([[0,6.8],[0.65,7.8],[0.65,8.4],[0,8.4]],0,0,0);
	}
	
}

/*****************
 *Other functions*
 *****************/
 
module create_circle_grip()
{
	difference() {
		union() {
			//Create the grip head
			translate([grip_radius+shaft_length+stop_width,0,key_width/2]) rotate(a=[0,0,0]) cylinder(h=key_width, r=grip_radius, center=true);
			//Create the spacer/stopper between the grip and shaft
			translate([shaft_length+7,0,key_width/2])
			minkowski() {
				cube([stop_width+4, shaft_height+4, key_width/2], center=true);
				rotate([0,0,0]) cylinder(r=1,h=key_width/2,center=true,$fn=50);
			}//minkowski
		}//union

		//key hole
		translate([grip_radius+shaft_length+stop_width+6,0,0]) rotate(a=[0,0,90]) cylinder(h=key_width+4, r=2, center=true, $fn=30);

	}//difference

	write_text();
}

module poly_groove(poly, offsetY, offsetZ, mirrorZ) {
	if (mirrorZ==0) {
		translate([0,offsetY+4,offsetZ-0.01])		
		mirror([0,0,1])
		mirror([0,1,0])
		rotate([0,90,0])
		linear_extrude(height=shaft_length+2.7,convexity =10, twist =0 )

		polygon(points=poly);
	}else{
		translate([0,offsetY+4,offsetZ+key_width+0.01])
		rotate([180,90,180])
		mirror([0,1,0])
		linear_extrude(height=shaft_length+2.7,convexity =10, twist =0 )
		polygon(points=poly);
	}
}

module create_shaft() {
	translate([(shaft_length+5)/2,0,key_width/2]) cube(size=[shaft_length+5,shaft_height,key_width], center=true);
}

module cutter(lposition, hposition, flat_width, cutterAngle) {
	cutter_wedge_height=15;

	translate([lposition-flat_width,-15/2-hposition,2])
	hull() {
		translate([0,-1*cutter_wedge_height,0]) rotate([0,90,0]) cube([cutter_wedge_height,1,flat_width+cutterAngle], center=true);
		cube([flat_width,cutter_wedge_height,cutter_wedge_height], center=true);
	}
}

module write_text() {
	 {
		if (print_ready==2) {
			translate([shaft_length+stop_width*2+grip_radius/2+3, 0 ,0])
			rotate([0,180,90])
			writecircle(grip_text,[0,0,0],grip_radius-5.5, t=1, font="write/Letters.dxf");
			
			translate([grip_radius+shaft_length+stop_width+2, +6.5 ,0])
			rotate([0,180,90])
			write(str(notch1,notch2,notch3,notch4,notch5),h=4,t=0.5, font="write/Letters.dxf");
		} else {
			translate([shaft_length+stop_width*2+grip_radius/2+3, 0 ,key_width])
			rotate([0,0,90])
			writecircle(grip_text,[0,0,0],grip_radius-5.5, t=1, font="write/Letters.dxf");

			translate([grip_radius+shaft_length+stop_width+2, -6.5 ,key_width])
			rotate([0,0,90])
			write(str(notch1,notch2,notch3,notch4,notch5),h=4,t=0.5, font="write/Letters.dxf");
		}
	}
}







