spazio=3; // [1:7]
lato=9; // [9:20]
gap=spazio+lato;
lcube=[lato,lato,lato];


translate([0,0,0]){
	cube(lcube);
	}

translate([gap,0,0]){
	cube(lcube);
	}		

translate([0,gap,0]){
	cube(lcube);
	}	
translate([gap,gap,0]){
	cube(lcube);
	}		
translate([0,0,gap]){
	cube(lcube);
	}

translate([gap,0,gap]){
	cube(lcube);
	}		

translate([0,gap,gap]){
	cube(lcube);
	}	
translate([gap,gap,gap]){
	cube(lcube);
	}		
translate([gap/2,0,gap/2]){
	cube([lato,((lato*2)+spazio),lato]);
	}		
translate([0,gap/2,gap/2]){
cube([((lato*2)+spazio),lato,lato]);
	}		
translate([(gap/2),(gap/2),0]){
cube([lato,lato,((lato*2)+spazio)]);
	}	


