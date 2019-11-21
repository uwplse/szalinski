$fn    = 40*1; // For Customizer

// Nr of foots
FUESSE = 3; // [0:8] 

// Height 
HOEHE  = 6; // [3:15]
  

difference() {
   cube([6,6,1], true);
	for(j = [1:4]) {
		rotate(j*360/4, [0, 0, 1]) {
    			translate([2.3, 2.3, -1]) cylinder(h=2, r=0.2);
		}
	}
}


translate([0,0,HOEHE/2]) {
    cylinder(h=HOEHE, r=0.8, center = true);
    translate([0,0,HOEHE/2]) {
        sphere(1.5); 
    }
} 

for (i = [1:FUESSE]) {
	rotate(270, [0,1,0]) {
	    translate([0.5,0,0]) {
			rotate((i*360 / FUESSE) + 21, [1,0,0]) {
				linear_extrude(height = 1, center = true) polygon(points=[[0,0],[3,0],[0,1.9]], paths=[[1,2,0]]);
			}
		}
	}
}



