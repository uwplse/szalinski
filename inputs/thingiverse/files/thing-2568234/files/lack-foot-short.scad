resolution = 50; // 10; don't increase too much, or you'll get performance issues
wall = 8;

xoffset = (50.7+(wall-2))/2+1.1;
//zheight = 140; // height of the rectangular cube
zheight = 100; // height of the rectangular cube
//zoffset = 50; // height of the hole pairs above/below the axis
zoffset = ( zheight / 2 ) - 20; // height of the hole pairs above/below the axis
//zremoval = 90; // amount that the cavities cut into the rectangular cube, vertically
zremoval = 150; // amount that the cavities cut into the rectangular cube, vertically

supportxy = 13; // distance proud of the rectangular cube for supports
//supportz = 50; // z distance from the axis for supports
supportz = zoffset; // z distance from the axis for supports

rotate([0,180,0]) difference() {
    union() {
		minkowski() {
			union() {
				translate([0,0,-10]) cube([50.7+(wall-2),50.7+(wall-2),zheight], center=true);
				// positive x-axis bump-out support
                translate([-supportxy,0,-supportz]) cube([40,40,14], center=true);
                // negative y-axis bump-out support
                translate([0,-supportxy,-supportz]) cube([40,40,14], center=true);
			}
			sphere(r=2, $fn=resolution, center=true);
		}
			
		// holder nub
		//translate([0,-xoffset2,-zoffset-20]) cube([2,2,1.8]);
	}
	
    // cavity for descending leg
	translate([0,0,45+35]) minkowski() {
		cube([50.7-3.5,50.7-3.5,zremoval], center=true);
		sphere(r=2, $fn=resolution, center=true);
	}
	
    // cavity for table top corner
	translate([3,3,-(45+35)]) minkowski() {
        cube([50.7+4,50.7+4,zremoval], center=true);
		sphere(r=2, $fn=resolution, center=true);
	}
	
    // inside holes for 6mm magnets
	translate([-xoffset,0,zoffset]) rotate([0,90,0]) cylinder(h=4, d=6, $fn=resolution, center=true);
	translate([-xoffset,0,-zoffset-20]) rotate([0,90,0]) cylinder(h=4, d=6, $fn=resolution, center=true);
	translate([0,-xoffset,zoffset]) rotate([90,0,0]) cylinder(h=4, d=6, $fn=resolution, center=true);
	translate([0,-xoffset,-zoffset-20]) rotate([90,0,0]) cylinder(h=4, d=6, $fn=resolution, center=true);

    // outside holes for 12mm plastic magnet surrounds
	xoffset2 = (50.7+(wall-2))/2+2.8;
	translate([-xoffset2,0,zoffset]) rotate([0,-90,0]) cylinder(h=4, d1=12, d2=18, $fn=resolution, center=true);
	translate([-xoffset2,0,-zoffset-20]) rotate([0,-90,0]) cylinder(h=4, d1=12, d2=18, $fn=resolution, center=true);
	translate([0,-xoffset2,zoffset]) rotate([90,0,0]) cylinder(h=4, d1=12, d2=18, $fn=resolution, center=true);
	translate([0,-xoffset2,-zoffset-20]) rotate([90,0,0]) cylinder(h=4, d1=12, d2=18, $fn=resolution, center=true);
}