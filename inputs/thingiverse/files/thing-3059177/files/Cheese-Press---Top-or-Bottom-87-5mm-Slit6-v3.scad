difference() {
    
	cylinder (h = 40, d=87.5, $fn=200);
	
    translate ([0,0,50])
        sphere (d=90, $fn=200);

        for (k=[3:6:30])
        for (x=[0:360/k:360])
            rotate([0,0,x])
                translate([k,k,-2])
                    cube([6,1,48]);
        
        cube([1,1,48],center=true);
        
    };
        
        

