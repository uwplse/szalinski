
// Which parts to include - change this if you only want to print the module itself or just the connector
parts = "both"; // [both:Module and connector, module:Module only, connector:Connector only]

module_sx = 110;
module_sy = 110;
module_sz = 110;
wall = 0.8;

module_d_hole = 98;
module_hole_fase=4;
bottom_fase=0.5;
fit_gap = 0.5;
tilt_angle=-5;
module_tube_dx = 5;
module_tube_dz = 20;
d_keyslot=8;
snapper_height = 3;

	
module solid_tube(sz,d,z_fase,extend) {
	$fn=180;
	intersection() {
		cylinder(sz, d/2, d/2 );
		cylinder(sz+d/2-z_fase, sz+d/2-z_fase, 0);
	}
	translate([0,0,-sz/2])
		cylinder(sz, d/2, d/2 );

	if(extend) {
		cylinder(sz*2, d/2-z_fase, d/2-z_fase);
	}
}


module connector() {
	
	$fn=90;
	wall=0.8;
	inset = 0.4;
	dent_inset = 0.5;
	
	a = 1.5*d_keyslot;
	b = 0.9*d_keyslot;

	module keyslot(o) {
		offset(o) {
		union() {
			difference() {
				square([a+b, a+b], center=true);
				translate([0.5*(a+b)-dent_inset,0])
					circle(b/2+inset);				
				translate([0,0.5*(a+b)-dent_inset])
					circle(b/2+inset);				
				translate([-0.5*(a+b)+dent_inset,0])
					circle(b/2+inset);				
				translate([0,-0.5*(a+b)+dent_inset])
					circle(b/2+inset);				
			}
			translate([0.5*(a+b),0.5*(a+b)])
				circle(a/2-inset);
			translate([-0.5*(a+b),0.5*(a+b)])
				circle(a/2-inset);
			translate([-0.5*(a+b),-0.5*(a+b)])
				circle(a/2-inset);
			translate([0.5*(a+b),-0.5*(a+b)])
				circle(a/2-inset);
		}
		}
	}
	
	module solidconnector(offset) {
		linear_extrude(module_sx) {
			keyslot(offset);
		}
	}

	difference() {
		solidconnector(0);
		translate([0,0,wall])
			solidconnector(-wall);
	}

}


module outside_2d(sx,sy) {
	$fn=90;
	
	a = 1.5*d_keyslot;
	b = 0.75*d_keyslot;
	
	module keyslot() {
		union() {
			difference() {
				square([a+b, a+b], center=true);
				translate([0.5*(a+b),0])
					circle(b/2);				
				translate([0,0.5*(a+b)])
					circle(b/2);				
			}
			translate([0.5*(a+b),0.5*(a+b)])
				circle(a/2);
		}
	}
	
	module left_keyslot() {
		// translate([sx-2*d_keyslot, d_keyslot/2 ])
			// circle(d_keyslot);
	}
	
	difference() {
		polygon([ [0,0],
				  [sx,0],
				  [sx,sy],
				  [0,sy]] );
		keyslot();
		translate([sx,0]) rotate(90) keyslot();
		translate([sx,sy]) rotate(180) keyslot();
		translate([0,sy]) rotate(270) keyslot();
	}

}


module solid_box(sx,sy,sz,w)
{
	module snapper(snapper_width, s_wall) {
		$fn=90;
		translate([sx-sy/4+snapper_height,sy/2,sz/2])
		rotate(90, [1,0,0])
		translate([0,0,-snapper_width/2-s_wall])
			cylinder(snapper_width+2*s_wall,sy/4+2*s_wall,sy/4+2*s_wall);
	}

	module edge_fase(angle) {
		translate([sx/2,sy/2,0])
		rotate(angle,[0,0,1])
		translate([-sx/2,-sy/2,0])
		rotate(45,[1,0,0])
		translate([0,-bottom_fase,-bottom_fase])
			cube([2*sx, 2*bottom_fase, 2*bottom_fase]);
	}
	
	union()
	{
		difference() {
			linear_extrude(sz) { 
				offset(delta=w) {
					outside_2d(sx,sy);
				}
			}
			edge_fase(0);
			edge_fase(90);
			edge_fase(180);
			edge_fase(270);
			
			translate([-sx,0,0])
				snapper(sy/4+4*wall, -w);
		}
		snapper(sy/4, w);
	}
		
}



module tube_transform() {
	translate([module_sx/2+module_tube_dx,module_sy/2,-module_tube_dz])
	rotate(tilt_angle, [0,1,0])
		children();
}

module tube_inner_hull()
{
	solid_tube(module_sz, module_d_hole, module_hole_fase, true);
}

module tube_outer_hull()
{
	translate([0,0,sqrt(2)*wall])
		solid_tube(module_sz+wall, module_d_hole+2*wall, module_hole_fase+2*wall, false);
}


module box_outer_hull() {
	solid_box(module_sx, module_sy, module_sz, 0);
}

module box_inner_hull() {
	translate([0, 0, wall])
	solid_box(module_sx, module_sy, module_sz, -wall);
}

module box_hull() {
	difference() {
		box_outer_hull();
		union() {
			box_inner_hull();
			tube_transform() {
				tube_inner_hull();
			}
		}
	}

}

module solid_box_with_tube() {
	difference() {
		box_outer_hull();
		tube_transform() {
			tube_inner_hull();
		}
	}
}

module tube_hull() {
	intersection() {
		tube_transform() {
			difference() {
				tube_outer_hull();
				tube_inner_hull();
			}
		}
		box_outer_hull();
	}
}

module connect_cross() {
	intersection() {
		solid_box_with_tube();
		translate([module_sx/2, module_sy/2,0])
		union() {
			cube([2*module_sx, wall, 2*module_sz], center=true);
			cube([wall, 2*module_sy, 2*module_sz], center=true);
		}
	}
}

if(parts=="both" || parts=="connector")
{
    translate([module_sx/2,module_sy/2,0])
    {
        connector();
    }
}
if(parts=="both" || parts=="module")
{
    connect_cross();
    box_hull();
    tube_hull();
}
