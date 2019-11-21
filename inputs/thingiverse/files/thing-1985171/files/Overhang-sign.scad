/*[Global]*/

//The length of the sign
sign_length=100; // [300]

//Text size
text_size=30; // [100]

//Thickness of the sign
thickness=2.8;	

//Thickness of the door
door_thickness=21;

//Text
sign_text="Metal";

//Make the sign face down for easier printing
Face_down=0; //[0:False, 180:True]


rotate([Face_down,0,0])
difference(){
	cube([sign_length, text_size+ thickness*2, door_thickness+thickness], center=true);
	translate([0,-thickness,0])
		cube([sign_length+thickness*2, text_size+thickness*2, door_thickness], center=true);
	translate([0,0,-(door_thickness+thickness)/2])
		cube([sign_length-thickness*4, text_size, thickness+0.2], center=true);
	translate([0,(text_size+thickness)/2,-(thickness+0.1)/2])
		cube([sign_length-thickness*6, thickness+0.2, door_thickness+ thickness+0.1], center=true);
translate([-1,0,(door_thickness+thickness)/2+0.4])
	linear_extrude(height=thickness, center=true, convexity=10, twist=0) 
		text(sign_text,size=text_size, halign="center",valign="center");
}