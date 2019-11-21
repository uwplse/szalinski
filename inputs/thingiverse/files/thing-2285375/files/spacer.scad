//in mm
length = 152;

type = 3; //[0:straight only,1:corner left,2:corner right,3:corner left and right]

//Cable outlet on which side?
cable = -1; //[0:no,-1:left,1:right]

/*
	[Hidden]
*/
width = 7;
height = 11;

difference(){
	straight();
	if(type == 1 || type == 3)
		corner_left();
	if(type == 2 || type == 3)
		corner_right();
	if(cable == -1)
		cable_right();
	if(cable == 1)
		cable_left();
}

module straight(){
	translate([0,-width,0]){
	cube([length,width,height]);
	translate([0,-.5,0])
	cube([length,.5,.5]);
	}
}

module corner_left(){
	rotate([0,0,-135])
	translate([0,0,-.125])
	cube(16);
}

module corner_right(){
	translate([length,0,0])
	scale([-1,1,1])
	corner_left();
}

module cable_right(){
	rotate([0,0,-45])
	translate([-.1,-.1,-.1])
	cube([7,2*width,height+1]);
	
	rotate([0,0,-135])
	translate([.1,0,height/2-4])
	scale([-1,1,1])
	cube([1.5,width*3,8]);	
}



module cable_left(){
	translate([length,0,0])
	scale([-1,1,1])
	cable_right();
}