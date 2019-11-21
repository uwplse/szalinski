//size of the pyramid (mm)
r = 50;

/* [Hidden] */
alpha = 54.8;

module puzzle (r=10){
    
difference() {
translate ([0,0,-r/(2*sqrt(2))])rotate ([alpha,0,0])pyramid(r);
  translate ([0,0,5*r]) cube([20*r,20*r,10*r], center = true);
}
}

module pyramid(side=50 ){

	
	
	{
		
			polyhedron (	points = [[0,0,0],[side,0,0],[side/2,sqrt(3)*side/2,0],
								[side/2,sqrt(3)*side/6,sqrt(6)/3*side]], 
						faces = [[0,1,2], [1,0,3], [2,1,3],[2,3,0]]);			
		
}	}

color("green")rotate([alpha,0,0]) puzzle(r);
*color("red") translate ([r/2,r/3.7,r/2.40])rotate([0,35,90]) rotate([0,90,0]) puzzle(r);

