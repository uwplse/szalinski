difference() {
    
	cylinder (h = 40, d=87, $fn=50);
	
    translate ([0,0,50])
        sphere (d=90, $fn=50);

        for (k=[5:5:25])
        for (x=[0:360/k:360])
            rotate([0,0,x])
                translate([k,k,-2])
                    cube([5,1,48]);
        
        translate([-2.5,-0.5,-2])
            cube([5,1,48]);
        
    };
        
        

