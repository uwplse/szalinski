// The height of the bowl 
height = 40; // [30:5:100]

module ring(itterations,radious){
    for(i=[1:itterations]){  
        rotate((((i*360)+ 180)/itterations))
             translate( [radious,0,0] ) 
                children();
    }
}

module cubicBowl(height,rads = 20,offset =3){
  
	for(j=[5:5:height]){
		difference(){
			ring(12+j,rads+j)
				translate([0,0,j])
					rotate([45,30,j])
						cube(10,true);
			ring(12+j,rads-offset+j)
				translate([0,0,j])
					rotate([45,30,j])
						cube(10,true);
			translate([0,0,j])cylinder(25,rads-offset+j,31+j,true);
		}
	}

	cylinder(10,45,30,true,$fn=100);
}

cubicBowl(height);