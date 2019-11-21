
// user configuration

// should be equal to spacing of LEDs in your strip
snap_spacing=16.0;

// total length of the part
length=100;

// increase this if you want to go thicker but diffuser_block_depth is already at maximum value
top_thickness=0.6;

// bigger value -> less light gets through. should not exceed 4, otherwise won't fit in 2020 V slot with LED
diffuser_block_depth=1.0;

// set to 0 to solidify the middle between walls
canyon_width=4;

tolerance=0.3;

// should be at least 8
top_width=12.0;

// probably not interesting
hide_from_ui=sin(0);
tol=tolerance; // abbreviation
depth=4 - tol + hide_from_ui;
width=6 - tol + hide_from_ui;
snap_width=2.0 + hide_from_ui;
snap_slot_depth=2.75 + hide_from_ui;

/*
     |-| overhang_depth
y   __ ...y=h+overhang_h
|  |  \
|  |  | <- land_length
|  |  / <- return_angle
|  | |......................y=h
|  | |  <- thickness
|  | |
| _/ \_ <- bevel
+----|-----------> x
     *x=0

w: length in Z dimension
h: how thick is whatever edge the hook attaches to
w_tip is fraction, specifies Z dimension of tip relative to base
*/
module cantilever(w,h,thickness=1.2,overhang_depth=0.6,return_angle=30,w_tip=1,overhang_h=3.0,base=2.0,bevel=2/3) {
	t=1/2*thickness;
	t0=thickness*base;
	b=bevel*thickness;
	bot_slope_h=overhang_depth * tan(return_angle);
	//land_length=overhang_h/3;
	land_length=overhang_h/5;
	slant=atan((w-w*w_tip)/2/(h+overhang_h));
	difference() {
		linear_extrude(height=w)
		polygon([
		[-t0-b,0], [-t0,b], [-t,h+overhang_h], [0,h+overhang_h],
		[overhang_depth,h+bot_slope_h+land_length],
		[overhang_depth,h+bot_slope_h], [0,h], [0,b], [b,0]]);
		translate([-1e5,-1e-5,-1e-5])
		rotate(slant,[1,0,0])
		mirror([0,0,1])
		cube([2e5,1e5,1e5]);
		translate([-1e5,-1e-5,w+1e-5])
		rotate(-slant,[1,0,0])
		cube([2e5,1e5,1e5]);
	}
}

module slots() {
	for(y=[(length%snap_spacing-snap_width)/2:2*snap_spacing:length]) {
		translate([top_width/2+width/2, y, 0]) children(0);
		translate([top_width/2-width/2, y + snap_spacing, 0]) mirror([1,0,0]) children(0);
	}
}

intersection(convexity=10) {
	union() {
		if (diffuser_block_depth > 0) {
			difference() {
				// the diffuser block
				translate([top_width/2-width/2,-1,-1]) cube([width, length+2, top_thickness+1+diffuser_block_depth]);

				// slots for cantilevers
				slots()
				translate([-snap_slot_depth,-tol,0])
				cube([snap_slot_depth+5,snap_width+2*tol,1e4]);

				if (canyon_width > 0) {
					// canyon in the middle
					translate([top_width/2,length/2,diffuser_block_depth/2]) cube([canyon_width,1e5,1e5],center=true);
				}
			}
		}

		// top plate
		translate([0,-2,-3]) cube([top_width, length+4, top_thickness+3]);

		slots()
		translate([0,snap_width-tol,top_thickness-0.1])
		rotate(90,[1,0,0])
		cantilever(snap_width-2*tol, 2+tol+0.1, thickness=1.2, overhang_depth=1.0, return_angle=20, overhang_h=1.35, base=1.5, bevel=0.1);
	}
	cube([top_width, length, depth + top_thickness]);
}

