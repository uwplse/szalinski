/*[Global]*/

//The payload will be 10% less. In mm.
pot_radius=61; //[50:150]

//The payload will be 10% less. In mm.
pot_depth=89; //[50:200]

//In mm.
stand_hole_radius=6.5; //[5:20]

//What color do you wish to be?
color="green"; //[yellow:Yellow,green:Green,black:Black,white:White,blue:Blue,red:Red,pink:Pink,silver:Silver,gold:Gold]

/*[Hidden]*/

$fn=500;

difference(){
	color(color)
	shape();
	translate([0,0,pot_depth*0.1])
		cylinder(pot_depth,pot_radius*0.9,pot_radius*0.9);
	translate([pot_radius+(pot_radius/3),0,pot_depth*0.1])
		cylinder(pot_depth,stand_hole_radius,stand_hole_radius);
}

module shape(){
	hull(){
		linear_extrude(pot_depth){
			circle(pot_radius);
		}
		translate([pot_radius+(pot_radius/3),0,0])
			linear_extrude(pot_depth){
				circle(pot_radius/3);
			}
	}
}