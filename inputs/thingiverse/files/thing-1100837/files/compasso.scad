$fn = 30;
/* [Global] */
ruller_size = 100; // [100:250]
tip_hole_diameter = 3; // [1:6]

base();
translate([20, 15, 0]) tipHolder();
translate([0, 15, 0]) tipHolder();
translate([45, 20, 0]) tip();
translate([60, 20, 0]) tip();

module base(){
	difference(){
		cube([ruller_size,9.8,4.8]);
		for (z = [0:ruller_size/10-2])
		{
	   translate([(z * 10) + 10, 0, 4])
    	 cube([0.5,4,1]);
		}
		for (z = [0:ruller_size/10-1])
		{
	   translate([(z * 10) + 5, 0, 4])
    	 cube([0.5,2,1]);
		}
	}
}


module tipHolder(){
	difference(){
		roundedcube(12.8,16,7,5,5,0.01,0.01);
		translate([-1, 5, 1]) cube([14.8,10,5]);
		translate([6.4, 6, 3.5]) rotate([90,0,0]) cylinder(	r=1, h=8);
	}
	difference(){
		union(){
			difference(){
				translate([0, 16, 0]) roundedcube(12.8,13,18,0.01,0.01,5,5);
				translate([6.4, 21.75, -1]) cylinder(r=4.75, h=20);
			}
			translate([3.9, 27.75, 6.25]) roundedcube(5,5,5,0.01,0.01,1,1);
		}
		translate([6.4, 33.75, 8.75]) rotate([90,0,0]) cylinder(r=1, h=8);
	}
}

module tip(){
    difference(){
        union(){
            cylinder(d=12, h=1);
            translate([0,0,1]) cylinder(d=8, h=14);
        }
        translate([0,0,-0.5]) cylinder(d=tip_hole_diameter, h=16);
    }
}

module roundedcube(xdim ,ydim ,zdim,rdim1, rdim2, rdim3, rdim4){
hull(){
	translate([rdim1,rdim1,0]) cylinder(r=rdim1, h=zdim);
	translate([xdim-rdim2,rdim2,0]) cylinder(r=rdim2, h=zdim);

	translate([rdim3,ydim-rdim3,0]) cylinder(r=rdim3, h=zdim);
	translate([xdim-rdim4,ydim-rdim4,0]) cylinder(r=rdim4, h=zdim);
}
}