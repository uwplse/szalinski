//StarMaker
//by Alex Tanchoco (LionAlex)
//December 9, 2013
//Originally designed for making Christmas tree ornaments but can be adopted for making all kinds of stars


star_points = 5;
star_thickness = 0;
point_length = 50;
point_width = 20;
point_thickness = 5;
point_points = 4;
post_diameter = 10;
post_sides = 3;
each_angle = 180/point_points;
mounting_post = true;
thread_hole = true;


difference() {
	intersection() {
		star();
		if( star_thickness>0 )
		cube( [point_length*3,point_length*3,star_thickness], center=true );
	}
	//mounting post
	if( mounting_post )
		translate( [-point_length*0.25,0,-post_diameter/2+2] )
			rotate( [0,90,0] )
				cylinder( h=point_length,r=post_diameter/2,$fn=post_sides, center = true );

	//thread hole
	if( thread_hole )
		translate( [point_length*0.75,0,0] )
			rotate( [90,0,0] )
				cylinder( h=point_length,r=1,$fn=16, center = true );	
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