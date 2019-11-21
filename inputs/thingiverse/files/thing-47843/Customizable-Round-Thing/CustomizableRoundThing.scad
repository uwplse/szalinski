// The internal diameter at the bottom
0base_diameter=75;//[5:120]
// The internal diameter at the top
1top_diameter=75;//[5:120]
// The height of the sides (from the top of the base)
2side=3;//[1:120]
// The thickness of the base
3base=2;//[1:10]
// The thickness of the wall
4wall=2;//[1:10]
// by Patrick Wiseman
//www.thingiverse.com/thing:47843
use <utils/build_plate.scad>;
build_plate(3,230,200); // Type A Machines Series 1 build plate
module thing(base_diameter,top_diameter,side, base,wall)
{
	$fa=0.01;
	linear_extrude(height=base) circle(base_diameter/2+wall);
	translate([0,0,base]) difference() {
		cylinder(side,base_diameter/2+wall,top_diameter/2+wall);
		cylinder(side,base_diameter/2,top_diameter/2);
	}
}
thing(0base_diameter,1top_diameter,2side,3base,4wall);
// Examples
//thing(75,75,3,2,2); // 75mm can lid (the default)
//thing(50,60,40,2,2); // cup
//thing(35,50,120,2,2); // vase
//thing(50,35,120,2,2); // another vase
//thing(40,120,25,2,3); // dish
//thing(100,85,15,2,5); // pet bowl
//thing(150,100,5,2,2); // frisbee
//thing(75,50,3,2,2); // ash tray
//thing(50,175,50,5,5); // dish
//thing(75,75,20,4,1); // ~3" (75mm) biscuit cutter
