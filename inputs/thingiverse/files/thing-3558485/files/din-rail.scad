length = 10;

//t([-7.5,0,0])
linear_extrude(length) dinRail();

module dinRail(){
	t([0,-27/2]) square([1,27]);
	
	t([0,-27/2]) square([7.5,1]);
	t([0,27/2-1]) square([7.5,1]);
	
	t([7.5-1,-27/2-5+1]) square([1,5]);
	t([7.5-1,27/2-1]) square([1,5]);
}

module t(v=[0,0,0]){translate(v) children();}