diameter = 75;
thickness = 5;
hole_sizes = [20, 3, 5, 7, 8, 10, 15]; //holes starting in center; 
chamfer = true;

sfn = $preview ? $fn : 32;

difference() {
    cylinder(d=diameter, h=thickness, center=true);
        for(i=[0:len(hole_sizes)-1]) {
            rotate([0,0,360/(len(hole_sizes)-1)*(i-1)]) translate([i==0 ? 0 : (diameter+hole_sizes[0])/4,0,0]) {
                cylinder(d=hole_sizes[i], h=thickness+1, center=true);
                if (chamfer) {
                    for(j=[0:1]) {
                        translate([0,0,pow(-1,j+1)*thickness/4]) cylinder(d1=hole_sizes[i]+pow(-1,j)*(thickness/4+1),d2 = hole_sizes[i]-pow(-1,j)*(thickness/4+1), h=thickness/2+2, center=true);
                    }
                }
            }
        }
    }

