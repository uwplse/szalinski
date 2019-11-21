
//cube([172,166,20]);
//roundedRect([172,166,20], 20);

// Notes: Always work centered (at least for the main object)
$fn=200;

sr1=50; // shaker 1
sr2=64; // shaker 2
sd=15; // shaker depth
scootch1=14;
scootch2=10;
w=sr2*3.1; l=sr1*4; h=40; 
r=19; // rounded corner radius (added to dimensions)

    difference() {
        difference() {
            miniround([w-r*2,l-r*2,h-r*2], r, center=true);
            translate([w/4-scootch1,l/4-scootch1/2,h/2-sd]) { cylinder(h=sd, d=sr1, center=false); }
            translate([-w/4+scootch1,l/4-scootch1/2,h/2-sd]) { cylinder(h=sd, d=sr1, center=false); }
            translate([w/4-scootch2,-l/4+scootch2,h/2-sd]) { cylinder(h=sd, d=sr2, center=false); }
            translate([-w/4+scootch2,-l/4+scootch2,h/2-sd]) { cylinder(h=sd, d=sr2, center=false); }
        }
        translate([0,0,-h/2]) {
            cube([w,l,h], center=true);
        }
    }


// Rounded box: radius is added outside, to each dimension
module miniround(size, radius, center)
{
    x = size[0]-radius/2;
    y = size[1]-radius/2;

    minkowski()
    {
        cube(size=[x,y,size[2]], center=center);
        //cylinder(r=radius);
        // Using a sphere is possible, but will kill performance
        sphere(r=radius, center=center);
    }
}

// size - [x,y,z]
// radius - radius of corners
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


