//StarMaker Parol Edition
//by Alex Tanchoco (LionAlex)
//December 11, 2013
//Originally designed for making Christmas tree ornaments but can be adopted for making all kinds of stars
//This is just a model/replica size.
//Parol is type of lantern used as Christmas ornament in the Philippines
//It is typically about two to three feet in diameter but the sizes varies widely
//http://en.wikipedia.org/wiki/Parol


star_points = 5;
star_thickness = 0;	//set to zero for full height, otherwise limits height
point_length = 50;
point_width = 20;
point_thickness = 5;
point_points = 4;
post_diameter = 15;
post_sides = 3;
each_angle = 180/point_points;
mounting_post = true;
thread_hole = false;
wall_mount_hole = true;
torus = true;
top_half = true;
bottom_half = false;

if( top_half ) {
	translate( [-point_length*1.3,0,0] )
		top_half();
}

if( bottom_half ) {
	translate( [point_length*1.3,0,0] )
		bottom_half();
}


module tails() {
	translate( [-point_length*.85,point_length*0.6,0] )
		rotate( [0,-90,0] )
			cylinder( h=point_length*.75, r2=point_length/6,r1=point_length/7, $fn=32 );
	translate( [-point_length*.85,-point_length*0.6,0] )
		rotate( [0,-90,0] )
			cylinder( h=point_length*.75, r2=point_length/6,r1=point_length/7, $fn=32 );

}

module top_half() {
	//top half
	difference() {
		fullstar();
		translate( [-point_length*2,-point_length*2,-point_length*2] )
			cube( [point_length*4,point_length*4,point_length*2,] );
		rotate( [0,0,180/star_points] )
			sphere( r=point_length/4,$fn=star_points,center=true );

		if( wall_mount_hole ) 
			translate( [point_length*0.65,0,0] )
				rotate( [0,30,0] )
					cylinder( h=9,r=2,$fn=32,center=true );

		
	}

}


module bottom_half() {
	//bottom half
	difference() {
		rotate( [180,0,0] )
			fullstar();	
		translate( [-point_length,-point_length,-point_length*2] )
			cube( [point_length*2,point_length*2,point_length*2,] );
		rotate( [0,0,180/star_points] )
			sphere( r=point_length/4,$fn=star_points,center=true );


	}
}


module fullstar() {
difference() {
	intersection() {
		star();
		if( star_thickness>0 )
		cube( [point_length*3,point_length*3,star_thickness], center=true );
	}
	//mounting post
	if( mounting_post )
		translate( [-point_length*0.8,0,-post_diameter/2+2] )
			rotate( [0,90,0] )
				cylinder( h=point_length*2,r=post_diameter/2,$fn=post_sides, center = true );

	//thread hole
	if( thread_hole )
		translate( [point_length*0.75,0,0] )
			rotate( [90,0,0] )
				cylinder( h=point_length,r=1,$fn=16, center = true );	
}

	//perimeter torus
	if( torus ) {
		rotate_extrude(convexity = 10, $fn = 100)
			translate([point_length, 0, 0])
				circle(r = point_length/10, $fn = 16);
		tails();
	}

}

module star(star_scale=1) {
	scale( [star_scale,star_scale,star_scale] )
	for( i=[1:1:star_points] ) {
		rotate( [0,0,360/star_points * i] )
			translate( [point_length/2,0,0] )
				rotate( [0,90,0] )
				cylinder( h=point_length, r1=point_width, r2=0, $fn = point_points, center=true );
	}
}