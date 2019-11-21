/* [Global] */

// width of holder
width = 10;

// inner height of clamp (should be the height of the board you want to attach it to)
clamp_inner_height = 17;

// length of the round part that goes into the roll
roll_holder_length = 30;

holder("right",width,clamp_inner_height,roll_holder_length);
translate([30,0,0]) holder("left",width,clamp_inner_height,roll_holder_length);

module holder(side,width,clamp_inner_height,roll_holder_length){

	if(side == "right"){
		translate([0,clamp_inner_height+1.6,0]) rotate([0,0,2]) cube([20,2.4,width]);
		translate([17.5,0,0]) cube([2.5,clamp_inner_height+2.5,width]);
	}else{
		translate([0,clamp_inner_height+2,0]) rotate([0,0,-2]) cube([20,2.4,width]);
		translate([0,0,0]) cube([2.3,clamp_inner_height+2,width]);
	}
	cube([20,2,width]);
	difference(){
		union(){
			translate([0,-40,0]) cube([20,40,width]);
			translate([10,-40,width]) cylinder(r=10,h=roll_holder_length);
		}
		translate([10,-40,-0.05]) cylinder(r=5,h=roll_holder_length+width+0.1);
		translate([0,-70,-0.05]) cube([30,30,roll_holder_length+width+0.1]);
		hull(){
			translate([10,-10,-0.01]) cylinder(r=5,h=width+0.1);
			translate([10,-20,-0.01]) cylinder(r=5,h=width+0.1);
		}
	}
}
