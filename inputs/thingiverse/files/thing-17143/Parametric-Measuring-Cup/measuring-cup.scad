//Code by Griffin Nicoll 2012

//Stuff to edit! volume is summed so only add what you want
cups = 1;
tbsp = 0;
tsp = 0;
mL = 0;
wall = 1.6; //wall thickness

//stuff you don't need to edit
sq = 1.2; //squeeze
sh = 0.16; //shear
pi = 3.14159;
volume = cups*236588+tbsp*14787+tsp*4929+1000*mL;//mm^3

difference(){
	minkowski(){
		cylinder(r1=0,r2=wall,h=wall,$fn=6);
		cupBase(volume);
	}
	translate([0,0,wall])cupBase(volume);
}
module cupBase(volume){
	x = pow(volume/(570*pi),1/3);
	multmatrix(m=[
		[sq, 0, sh, 0],
		[0, 1/sq, 0, 0],
		[0, 0, 1, 0],
		[0, 0, 0,  1]])
	cylinder(h=10*x,r1=6*x,r2=9*x,$fn=64);
}