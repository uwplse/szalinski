mesh = 1;

difference(){
	cylinder( h=25, r=20);
	cylinder( h=25, r=15);
	
	
		
			for(i = [0:360/(mesh*4)]){
			rotate([0,0,mesh*4*i])
				for(j = [0:(100/(mesh*4))]){
				translate([20,0,j*mesh])
					cube(size=mesh/2, center=true);
			}	
	}
		
}