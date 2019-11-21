$fn=150;

volume = 5; // in mililiter

height = (volume * 1000) / (PI * 64); 
// h = V / pi * r^2
// 1 mililiter = 1000 cubic milimeters
// -> Volumen * 1000

difference(){
	union(){
		cylinder(h=height+2,r=9);
		translate([0,-5,height-1])cube([50,10,3]);
	}
	translate([0,0,2])cylinder(h=100,r=8);
}