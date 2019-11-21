// Number of wrench head
wrenchCount = 3; //[3,4,5,6]

// Length of wrench hand
wrenchLength = 15; //[10:50]


multiWrench(wrenchCount,wrenchLength);

module multiWrench(count,length){
    for(degree=[0:360/count:359]){
        union(){
            echo(degree);
            wrenchBranch(length,degree);
        }
    }
}
module wrenchBranch(length,degree){
    difference(){
        rotate([90,0,degree]) {
            translate([0,0,length/2]) {
                cylinder(length, 6,5, center=true);
                translate([0,0,length/2]) {
                    roundedRect([5, 5, 8], 1.29, $fn=18);
                }
            }
        }
        translate([0,0,-5.1]){
            cube([length*3,length*3,4],center=true);
        }
    }
}

module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}



