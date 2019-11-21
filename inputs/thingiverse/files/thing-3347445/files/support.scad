
width   = 12;
height 	= 18.3;
depth	= 20;
thichness = 10;
thichness_hole = 2;
plugdia   = 7;

leg_width = 7;
leg_depth = 13;
leg_height = 4;
leg_height_decal = 0;
holes	= 3.8;


module handle_solid() {
	cube([ width, depth, height ]);
	translate([ (width - leg_width)/2, depth, leg_height_decal ])
		cube([ leg_width, leg_depth , leg_height ]);
}

module handle() {
	difference() {
		handle_solid();
		translate([ -1, -thichness*2, thichness ])
			cube([ width+2, depth, height ]);
		translate([ thichness_hole, -thichness_hole, thichness ])
			cube([ width-thichness_hole*2, depth, height ]);
		translate([ (width - leg_height + holes)/2, depth + leg_depth - holes, 0 ])
			cylinder( d = holes, h = 200, center = true, $fn = 50 );
		translate([ (width - leg_height + holes)/2, depth + leg_depth - holes, height - holes ])
			rotate([90,0,0])
			cylinder( d = holes, h = 200, center = true, $fn = 50 );
		connector( 0.2 );
	}
}

module connector( space ) {
	translate([width/2, thichness/2 - 0.1, thichness/2])
	rotate([90,0,0])
		cylinder( d = plugdia+space, h = depth / 2, $fn = 8, center=true );
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
                                circle(r=radius, $fn=fn);

                        translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
                                circle(r=radius, $fn=fn);

                        translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
                                circle(r=radius, $fn=fn);

                        translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
                                circle(r=radius, $fn=fn);
                }
}

module male() {
	union() {
		cube([ width, depth, thichness ]);
		translate([0, depth - 0.5, 0])
			connector( -0.2 );
	}
}


handle();

translate([ 20, 0, 0 ]) rotate([90,0,0]) male();


