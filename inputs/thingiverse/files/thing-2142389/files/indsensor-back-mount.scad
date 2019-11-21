//$fn = 50;
$fs = 0.1;
$fa = 3;

// general info
thn0   = 2.0;
thn1   = 5.0;
over   = 0.15;
r      = 6.0 + over;

// ind sensor info
ind_d      = 12.6;
ind_r      = ind_d/2;

// led info
led_d      = 3.2 + over;
led_r      = led_d/2;

// general slide info
s_screw_d       = 5.0 + over;
s_screw_r       = s_screw_d/2;
s_i1_d0        =  6.5;
s_i1_d1        =  8.5;
s_i1_h         =  2.0;
s_i2_d         = 17.5;
s_i2_h0        =  7.5 + s_i1_h;
s_i2_h1        =  3.0 + s_i2_h0;

// back top slide info
s1_top_screw    =  5.0;
s1_side_screw   =  6.0;
s1_width        = 30.0;
s1_depth        = 22.0; 
s1_height       = 34.0;

// back bottom slide info
s2_top_screw    =  5.0;
s2_side_screw   =  8.0;
s2_width        = 58.0;
s2_depth        = 22.0;
s2_height       = 34.0;

// mounting info
thnm        = 1.5;
m_width     = 58.0;
m_height    = 79.0;
m_screw_d   =  2.7 + over;
m_screw_r   =  m_screw_d/2;
m_screw1    = 14.0;
m_screw2    = 22.0;

module prismy(c, dir=1, over=0) { render() {
	polyhedron(
		points = [[0,0,0], [c[0],0,0], [c[0],c[1],0], [0,c[1],0], [0,dir*c[1],c[2]], [c[0],dir*c[1],c[2]]],
		faces = [[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
	);
	translate([0, 0, -over]) cube([c[0], c[1], over]);
	translate([0, c[1], -over]) cube([c[0], over, c[2]+over]);
}}

module s1() {
	module add() {
		cube([s1_width, s1_depth, s1_height/2]);
	}
	module sub() {
		module screw() {
			translate([0, -1, 0])
				rotate([-90, 0, 0])
					cylinder(r=s_screw_r, h=s1_depth+2);
		}
		
		// top right
		translate([s1_width-s1_side_screw, 0, s1_height/2-s1_top_screw]) screw();
		// top left
		translate([s1_side_screw, 0, s1_height/2-s1_top_screw]) screw();
		
		// i1
		translate([s1_width+1, s_i1_d0, s1_height/2])
			rotate([0, 180, 0])
				prismy([s1_width+2, (s_i1_d1-s_i1_d0), s_i1_h], over=1);
		translate([-1, s_i1_d1, s1_height/2-s_i1_h])
			cube([s1_width+2, s1_depth, s_i1_h+1]);
		
		// i2
		translate([-1, s_i2_d, s1_height/2-s_i2_h0])
			cube([s1_width+2, s1_depth, s_i2_h0]);
		translate([s1_width+1, s_i2_d, s1_height/2-s_i2_h0])
			rotate([0, 180, 0])
				prismy([s1_width+2, (s1_depth-s_i2_d), s_i2_h1-s_i2_h0], over=1);
	}
	module all() {
		translate([-s1_width/2, -s1_depth/2, 0])
		color("silver") difference() {
			add();
			sub();
		}
	}
	
	all();
	rotate([0, 180, 0])
		all();
}

module s2() {
	module add() {
		cube([s2_width, s2_depth, s2_height/2]);
	}
	module sub() {
		module screw() {
			translate([0, -1, 0])
				rotate([-90, 0, 0])
					cylinder(r=s_screw_r, h=s2_depth+2);
		}
		
		// top right
		translate([s2_width-s2_side_screw, 0, s2_height/2-s2_top_screw]) screw();
		// top left
		translate([s2_side_screw, 0, s2_height/2-s2_top_screw]) screw();
		
		// i1
		translate([s2_width+1, s_i1_d0, s2_height/2])
			rotate([0, 180, 0])
				prismy([s2_width+2, (s_i1_d1-s_i1_d0), s_i1_h], over=1);
		translate([-1, s_i1_d1, s1_height/2-s_i1_h])
			cube([s2_width+2, s2_depth, s_i1_h+1]);
		
		// i2
		translate([-1, s_i2_d, s2_height/2-s_i2_h0])
			cube([s2_width+2, s2_depth, s_i2_h0]);
		translate([s2_width+1, s_i2_d, s2_height/2-s_i2_h0])
			rotate([0, 180, 0])
				prismy([s2_width+2, (s2_depth-s_i2_d), s_i2_h1-s_i2_h0], over=1);
	}
	module all() {
		translate([-s2_width/2, -s2_depth/2, 0])
		color("silver") difference() {
			add();
			sub();
		}
	}
	
	all();
	rotate([0, 180, 0])
		all();
}

module mounting() {
	module add() {
		cube([m_width, thnm, m_height]);
	}
	module sub() {
		module screwh() {
			translate([0, -1, 0])
				rotate([-90, 0, 0])
					cylinder(r=s_screw_r, h=thnm+2);
		}
		module screwl() {
			translate([0, -1, 0])
				rotate([-90, 0, 0])
					cylinder(r=m_screw_r, h=thnm+2);
		}
		
		// s2
		// bottom left
		translate([s2_side_screw, 0, s2_top_screw]) screwh();
		// bottom right
		translate([s2_width-s2_side_screw, 0, s2_top_screw]) screwh();
		// top left
		translate([s2_side_screw, 0, s2_height-s2_top_screw]) screwh();
		// top right
		translate([s2_width-s2_side_screw, 0, s2_height-s2_top_screw]) screwh();
		
		// s1
		// top left
		translate([m_width/2-s1_width/2+s1_side_screw, 0, m_height-s1_top_screw]) screwh();
		// top right
		translate([m_width/2+s1_width/2-s1_side_screw, 0, m_height-s1_top_screw]) screwh();
		// bottom left
		translate([m_width/2-s1_width/2+s1_side_screw, 0, m_height-s1_height+s1_top_screw]) screwh();
		// bottom right
		translate([m_width/2+s1_width/2-s1_side_screw, 0, m_height-s1_height+s1_top_screw]) screwh();
		
		// other screws
		translate([0, 0, m_height/2]) {
			translate([m_screw1, 0, 0]) screwl();
			translate([m_screw2, 0, 0]) screwl();
			translate([m_width-m_screw1, 0, 0]) screwl();
			translate([m_width-m_screw2, 0, 0]) screwl();
		}
	}
	module all() {
		translate([-m_width/2, -thnm, 0])
		color([0.4, 0.4, 0.4]) difference() {
			add();
			sub();
		}
	}
	
	all();
}

module completehead() {
	translate([0, s1_depth/2, m_height-s1_height/2])
		s1();
	translate([0, s2_depth/2, s2_height/2])
		s2();
	mounting();
}

module indsensormount() {
	module add() {
		// front
		translate([-s1_width/2+over, -thnm-thn0-over, m_height-s1_height])
			cube([s1_width-2*over, thn0, s1_height+thn1]);
		// top
		translate([-s1_width/2+over, -thnm-thn0-over, m_height])
			cube([s1_width-2*over, thnm+thn0+s1_depth, thn1]);
		translate([-s1_width/2+over, over, m_height-s1_height/2+over])
			cube([s1_width-2*over, s1_depth+thn1-over, thn1+s1_height/2-over]);
		// back
		translate([-s1_width/2+over, s1_depth, -2*thn1])
			cube([s1_width-2*over, thn1, m_height+2*thn1]);
		
		// ind sensor mounting
		difference() {
			translate([0, s1_depth+thn1, -2*thn1])
				scale([s1_width-2*over, 5*ind_d, 1])
					cylinder(d=1, h=2*thn1, $fn=150);
			translate([-s2_width/2, s2_depth-5*ind_d, -2*thn1-1])
				cube([s2_width, 5*ind_d, 2*thn1+2]);
		}
		
		// led mounting
		translate([-s1_width/2+over, s1_depth-2*thn1, -2*thn1])
			cube([s1_width-2*over, 2*thn1, thn1]);
	}
	module sub() {
		module screwh() {
			translate([0, -1, 0])
				rotate([-90, 0, 0])
					cylinder(r=s_screw_r+0.001, h=thnm+thn0+thn1+over+s1_depth+2);
		}
		module screwl() {
			translate([0, -1, 0])
				rotate([-90, 0, 0])
					cylinder(r=m_screw_r, h=thnm+thn0+thn1+over+s1_depth+2);
		}
		
		completehead();
		
		// s1
		// top left
		translate([-s1_width/2+s1_side_screw, -thnm-thn0-over, m_height-s1_top_screw]) screwh();
		// top right
		translate([s1_width/2-s1_side_screw, -thnm-thn0-over, m_height-s1_top_screw]) screwh();
		// bottom left
		translate([-s1_width/2+s1_side_screw, -thnm-thn0-over, m_height-s1_height+s1_top_screw]) screwh();
		// bottom right
		translate([s1_width/2-s1_side_screw, -thnm-thn0-over, m_height-s1_height+s1_top_screw]) screwh();
		
		// inner 2 screws
		translate([0, -thnm-thn0-over, m_height/2]) {
			translate([-m_width/2+m_screw2, 0, 0]) screwl();
			translate([m_width/2-m_screw2, 0, 0]) screwl();
		}
		
		// ind sensor
		translate([0, s1_depth+thn1+ind_d+ind_r, -2*thn1-1])
			cylinder(r=ind_r, h=2*thn1+2);
		
		// leds
		translate([1/3*s1_width, s1_depth-thn1, -2*thn1-1])
			cylinder(r=led_r, h=thn1+2);
		translate([-1/3*s1_width, s1_depth-thn1, -2*thn1-1])
			cylinder(r=led_r, h=thn1+2);
	}
	module all() {
		color("yellow") difference() {
			add();
			sub();
		}
	}
	
	all();
}

indsensormount();
//completehead();