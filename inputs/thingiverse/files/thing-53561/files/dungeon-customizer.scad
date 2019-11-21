
squares_long = 1; //[1:10]
squares_wide = 1; //[1:10]
wall_style="stone"; //[stone, wood_horiz, wood_vert, smooth]
floor_style="stone"; //[stone, wood_horiz, wood_vert, smooth]
wall_north="yes"; //[yes,no]
wall_south="yes"; //[yes,no]
wall_east="yes"; //[yes,no]
wall_west="yes"; //[yes,no]

module customizer(squares_long, squares_wide, wall_style, floor_style, wall_north, wall_south, wall_east, wall_west) {
	north = wall_north=="yes" ? true : false;
	south = wall_south=="yes" ? true : false;
	east = wall_east=="yes" ? true : false;
	west = wall_west=="yes" ? true : false;
	segment(squares_long, squares_wide, wall_style=wall_style, floor_style=floor_style, north=north, south=south, east=east, west=west);
}

customizer(squares_long, squares_wide, wall_style, floor_style, wall_north, wall_south, wall_east, wall_west);

WALL_SHORT = 4 + 0; //Done so the customizer won't let this value be changed
WALL_TALL = 29.5 + 0;

// Connectors

module connector_wall() {
	difference () {
		union () {
			translate([-.5,.55,0]) rounded_cube(3.5,1.4,3.8, .3);
			translate([2,0,0]) rounded_cube(1.5,2.5,3.8, .3);
		}
	}
}

// Corners

module corner(height, plugs=[true,true,true,true]) {
	difference() {
		union () {
			translate([-0.01, -0.01, 0]) cube([6.02,6.02,height]);
			if (plugs[0]) {
				translate([6,1.8,0]) connector_wall();
			}
			if (plugs[1]) {
				rotate([0,0,90]) translate([6,-4.2,0]) connector_wall();
			}
			if (plugs[2]) {
				rotate([0,0,180]) translate([0,-4.2,0]) connector_wall();
			}
			if (plugs[3]) {
				rotate([0,0,270]) translate([0,1.8,0]) connector_wall();
			}
		}
		if (height >= WALL_TALL) {
			translate([3,3,height-6]) cylinder(6.1,1.75,1.75);
		}
	}
}


//corner(WALL_TALL);
//corner(WALL_SHORT);
//wall(WALL_SHORT);//
// cube with rounded esges on all sides
// The first three parameters define the size of the cube
// The forth parameter defines the radius of the rounded edges
// made by Luc Bos
//

module rounded_cube(sx,sy,sz,r) 
{
	union()
	{
		translate([r,r,0]) cube([sx-2*r,sy-2*r,sz],false);
		translate([r-0.01,0,r]) cube([sx-2*r+0.02,sy,sz-2*r],false);
		translate([0,r,r]) cube([sx,sy-2*r,sz-2*r],false);

		translate([r,r,r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false);
		translate([r,sy-r,r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false);
		translate([r,r,sz-r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false);
		translate([r,sy-r,sz-r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false);

		translate([r,r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false);
		translate([r,sy-r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false);
		translate([sx-r,r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false);
		translate([sx-r,sy-r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false);

		translate([r,r,r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false);
		translate([r,r,sz-r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false);
		translate([sx-r,r,r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false);
		translate([sx-r,r,sz-r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false);

		translate([r,r,r]) sphere(r);
		translate([r,sy-r,r]) sphere(r);
		translate([r,r,sz-r]) sphere(r);
		translate([r,sy-r,sz-r]) sphere(r);

		translate([sx-r,r,r]) sphere(r);
		translate([sx-r,sy-r,r]) sphere(r);
		translate([sx-r,r,sz-r]) sphere(r);
		translate([sx-r,sy-r,sz-r]) sphere(r);
	}
}


module flooring(x=1, y=1, north=true, south=true, east=true, west=true, tileset="stone", tile=false, rot=false, style="stone") {
	seed_vect = rands(0, 100, 2);
	tile_vect = rands(tile == false ? 0 : tile, tile == false ? 4 : tile, x*y, seed=seed_vect[0]);
	rot_vect = rands(rot == false ? 0 : rot, rot == false ? 4 : rot, x*y, seed=seed_vect[1]);
	union() {
		for (xcnt = [0:x])  {
			for (ycnt = [0:y]) {
				if(xcnt < x && ycnt < y) {
					translate([xcnt * 32 + 6, ycnt * 32 + 6,0]) tile(
						connections=[xcnt==0 && !west, ycnt==0 && !south, xcnt==x-1 && !east, ycnt==y-1  && !north],
						tile=floor(tile_vect[xcnt*y+ycnt]),
						rot=floor(rot_vect[xcnt*y+ycnt]),
						style=style);
					if(ycnt > 0) {
						translate([xcnt * 32 + 6, ycnt * 32+6,0]) rotate([0,0,270]) wall_base(
							WALL_SHORT,
							connections=[false, false],
							plugs=[xcnt == 0 && !west, xcnt == x-1 && !east]);
					}
					if(xcnt > 0) {
						translate([xcnt * 32, ycnt * 32+6,0]) rotate([0,0,0]) wall_base(
							WALL_SHORT,
							connections=[false, false],
							plugs=[ycnt == 0  && !south, ycnt == y-1 && !north]);
					}
					if(xcnt  > 0 && ycnt > 0) {
						translate([xcnt * 32-.5, ycnt * 32,0]) cube([1, 6, WALL_SHORT]);
						translate([xcnt * 32, ycnt * 32-.5,0]) cube([6, 1, WALL_SHORT]);
						translate([xcnt * 32+5.5, ycnt * 32,0]) cube([1, 6, WALL_SHORT]);
						translate([xcnt * 32, ycnt * 32+5.5,0]) cube([6, 1, WALL_SHORT]);
					}
					if(xcnt > 0 && ycnt > 0) {
						translate([xcnt * 32, ycnt * 32,0]) corner(WALL_SHORT, [false, false, false, false]);
					}
					if((xcnt==0 && west) || xcnt > 0) {
						translate([xcnt * 32+5.5, ycnt * 32+6,0]) cube([1, 26, 3.5]);
					}
					if((ycnt==0 && south) || ycnt > 0) {
						translate([xcnt * 32+6, ycnt * 32+5.5,0]) cube([26, 1, 3.5]);
					}
				}
				if(((xcnt==x && east) || (xcnt > 0 && xcnt < x)) && ycnt < y) {
					translate([xcnt * 32-.5, ycnt * 32+6,0]) cube([1, 26, 3.5]);
				}
				if(((ycnt==y && north) || (ycnt > 0 && ycnt < y)) && xcnt < x) {
					translate([xcnt * 32+6, ycnt * 32-.5]) cube([26, 1, 3.5]);
				}
			}
		}
	}
}

module walling(x=1, y=1, north=true, south=true, east=true, west=true, tileset="stone", wall=false, rot=false, style="stone") {
	seed_vect = rands(0, 100, 2);
	wall_vect = rands(wall == false ? 0 : wall, wall == false ? 4 : wall, (x+y)*2, seed=seed_vect[0]);
	rot_vect = rands(rot == false ? 0 : rot, rot == false ? 4 : rot, (x+y)*2, seed=seed_vect[1]);
	union() {
		for (xcnt = [0:x])  {
			for (ycnt = [0:y]) {
				if ((xcnt == 0 || xcnt == x) && ycnt < y) {
					if(xcnt == 0 && west || xcnt == x && east) {
						translate([xcnt * 32, ycnt * 32+6,0]) wall(
							connections=[xcnt == x && east, xcnt == 0 && west],
							plugs=[ycnt == 0 && !south, ycnt == y-1 && !north],
							wall=floor(wall_vect[xcnt*y+ycnt]),
							rot=floor(rot_vect[xcnt*y+ycnt]),
							style=style);
					}
				}
				if ((ycnt == 0 || ycnt == y) && xcnt < x) {
					if(ycnt == 0 && south || ycnt == y && north) {
						translate([xcnt * 32+32, ycnt * 32,0]) rotate([0,0,90]) wall(
							connections=[ycnt == y && north, ycnt == 0 && south],
							plugs=[xcnt==x-1 && !east, xcnt==0 && !west],
							wall=floor(wall_vect[xcnt*y+ycnt]),
							rot=floor(rot_vect[xcnt*y+ycnt]),
							style=style);
					}
				}
				if (xcnt == 0 || xcnt == x || ycnt == 0 || ycnt == y) {
					if (xcnt == 0 && west || xcnt == x && east) {
						if (ycnt == 0 && south || ycnt == y && north || ycnt > 0 && ycnt < y) {
							translate([xcnt * 32, ycnt * 32,0]) corner(
								WALL_TALL,
								plugs=[xcnt != 0 && east, ycnt == y && north, xcnt == 0 && west, ycnt == 0 && south]);
							if(xcnt > 0) {
								translate([xcnt * 32-.5, ycnt * 32,0]) cube([1, 6, WALL_TALL]);
							}
							if(ycnt > 0) {
								translate([xcnt * 32, ycnt * 32-.5,0]) cube([6, 1, WALL_TALL]);
							}
							if(xcnt < x) {
								translate([xcnt * 32+5.5, ycnt * 32,0]) cube([1, 6, WALL_TALL]);
							}
							if(ycnt < y) {
								translate([xcnt * 32, ycnt * 32+5.5,0]) cube([6, 1, WALL_TALL]);
							}
						}
					} else if (ycnt == 0 && south || ycnt == y && north) {
						if (xcnt == 0 && west || xcnt == x && east || xcnt > 0 && xcnt < x) {
							translate([xcnt * 32, ycnt * 32,0]) corner(
								WALL_TALL,
								plugs=[false, ycnt != 0 && north, false, ycnt == 0 && south]);
							if(xcnt > 0) {
								translate([xcnt * 32-.5, ycnt * 32,0]) cube([1, 6, WALL_TALL]);
							}
							if(ycnt > 0) {
								translate([xcnt * 32, ycnt * 32-.5,0]) cube([6, 1, WALL_TALL]);
							}
							if(xcnt < x) {
								translate([xcnt * 32+5.5, ycnt * 32,0]) cube([1, 6, WALL_TALL]);
							}
							if(ycnt < y) {
								translate([xcnt * 32, ycnt * 32+5.5,0]) cube([6, 1, WALL_TALL]);
							}
						}
					}
				}
			}
		}
	}
}

module segment(x=1, y=1, north=true, south=true, east=true, west=true, wall_style="stone", floor_style="stone") {
	walling(x, y, north=north, south=south, east=east, west=west, style=wall_style);
	flooring(x, y, north=north, south=south, east=east, west=west, style=floor_style);
}

module segment_corner(x=1, y=1, floor_style="stone", wall_style="stone")  {
	segment(x, y, south=false, west=false, floor_style=floor_style, wall_style=wall_style);
}

module segment_floor(x=1, y=1, floor_style="stone") {
	segment(x, y, north=false, south=false, east=false, west=false, floor_style=floor_style);
}

module segment_wall(x=1, y=1, floor_style="stone", wall_style="stone") {
	segment(x, y, north=false, south=false, west=false, floor_style=floor_style, wall_style=wall_style);
}

module segment_dead_end(x=1, y=1, floor_style="stone", wall_style="stone") {
	segment(x, y, south=false, floor_style=floor_style, wall_style=wall_style);
}

module segment_hall(x=1, y=1, floor_style="stone", wall_style="stone") {
	segment(x, y, north=false, south=false, floor_style=floor_style, wall_style=wall_style);
}

//segment_corner(2, 2, wall_style="wood_horiz", floor_style="stone");
//segment_floor(1, 2, floor_style="stone");
//segment_dead_end(2, 2, floor_style="stone", wall_style="wood_horiz");
//segment_hall(2,2);

module connector_tile_gap() {
	union () {
		translate([0,0,-0.1]) cube([2.5,3,2.1]);
		translate([0,15,-0.1]) cube([2.5,3,2.1]);
		translate([2.5,0,-0.1]) rotate([0,0,45]) cube([sqrt(4.5*4.5 + 4.5*4.5),3,2.1]);
		translate([2.5,18,-0.1]) rotate([0,0,225]) cube([3,sqrt(4.5*4.5 + 4.5*4.5),2.1]);
		translate([4,4.5,-0.1]) cube([3,9,2.1]);
	}
}

module tile_base(connections=[true,true,true,true]) {
	difference() {
		cube([26,26,3.5]);
		if (connections[0]) {
			translate([-0.01,4,0]) connector_tile_gap();
		}
		if (connections[1]) {
			translate([22,-0.01,0]) rotate([0,0,90]) connector_tile_gap();
		}
		if (connections[2]) {
			translate([26.01,22,0]) rotate([0,0,180]) connector_tile_gap();
		}
		if (connections[3]) {
			translate([4,26.01,0]) rotate([0,0,270]) connector_tile_gap();
		}
		translate([13,13,-0.1]) cylinder(2.1,2.25,2.25);
	}
}

module tile_rotate(rot) {
	if (rot == 1) {
		translate([26,0,0]) rotate([0,0,90]) child(0);
	} else if (rot == 2) {
		translate([26,26,0]) rotate([0,0,180]) child(0);
	} else if (rot == 3) {
		translate([0,26,0]) rotate([0,0,270]) child(0);
	} else {
		translate([0,0,0]) rotate([0,0,0]) child(0);
	}
}

module tile_stone_1(connections=[true, true, true, true], rot=0) {
	union () {
		tile_base(connections);
		tile_rotate(rot) {
			union() {
				translate([10,18,4]) rotate([0,90,0]) rounded_cube(1.5,8,16,.5);
				translate([20,17.5,4]) rotate([90,90,0]) rounded_cube(1.5,6,10,.5);
				translate([10,13.5,4]) rotate([0,90,0]) rounded_cube(1.5,4,9.5,.5);
				translate([17,0,4]) rotate([0,90,0]) rounded_cube(1.5,7,9,.5);
				translate([17,7.5,4]) rotate([0,90,0]) rounded_cube(1.5,5.5,2.5,.5);
				translate([6,0,4]) rotate([0,90,0]) rounded_cube(1.5,13,10.5,.5);
				translate([0,13.5,4]) rotate([0,90,0]) rounded_cube(1.5,12.5,9.5,.5);
				translate([0,0,4]) rotate([0,90,0]) rounded_cube(1.5,13,5.5,.5);
			}
		}
	}
}

module tile_stone_2(connections=[true, true, true, true], rot=0) {
	union () {
		tile_base(connections);
		tile_rotate(rot) {
			union() {
				translate([0,18,4]) rotate([0,90,0]) rounded_cube(1.5,8,16,.5);
				translate([10,17.5,4]) rotate([90,90,0]) rounded_cube(1.5,6,10,.5);
				translate([16.5,15.5,4]) rotate([0,90,0]) rounded_cube(1.5,4,9.5,.5);
				translate([16.5,20,4]) rotate([0,90,0]) rounded_cube(1.5,6,6,.5);
				translate([23,20,4]) rotate([0,90,0]) rounded_cube(1.5,6,3,.5);
				translate([7,7.5,4]) rotate([0,90,0]) rounded_cube(1.5,5.5,2.5,.5);
				translate([16.5,0,4]) rotate([0,90,0]) rounded_cube(1.5,15,9.5,.5);
				translate([0,13.5,4]) rotate([0,90,0]) rounded_cube(1.5,4,9.5,.5);
				translate([0,0,4]) rotate([0,90,0]) rounded_cube(1.5,13,6.5,.5);
				translate([7,0,4]) rotate([0,90,0]) rounded_cube(1.5,7,6.5,.5);
				translate([14,0,4]) rotate([0,90,0]) rounded_cube(1.5,7,2,.5);
			}
		}
	}
}

module tile_stone_3(connections=[true, true, true, true], rot=0) {
	union () {
		tile_base(connections);
		tile_rotate(rot) {
			union() {
				translate([10,10,4]) rotate([0,90,0]) rounded_cube(1.5,8,16,.5);
				translate([20,9.5,4]) rotate([90,90,0]) rounded_cube(1.5,6,9.5,.5);
				translate([0,14,4]) rotate([0,90,0]) rounded_cube(1.5,7,9.5,.5);
				translate([0,0,4]) rotate([0,90,0]) rounded_cube(1.5,7,8,.5);
				translate([8.5,4,4]) rotate([0,90,0]) rounded_cube(1.5,5.5,3.5,.5);
				translate([0,7.5,4]) rotate([0,90,0]) rounded_cube(1.5,6,8,.5);
				translate([0,10,4]) rotate([0,90,0]) rounded_cube(1.5,3.5,9.5,.5);
				translate([8.5,0,4]) rotate([0,90,0]) rounded_cube(1.5,3.5,11,.5);
				translate([12.5,4,4]) rotate([0,90,0]) rounded_cube(1.5,5.5,7,.5);
				translate([0,21.5,4]) rotate([0,90,0]) rounded_cube(1.5,4.5,15,.5);
				translate([15.5,18.5,4]) rotate([0,90,0]) rounded_cube(1.5,7.5,10.5,.5);
				translate([10,18.5,4]) rotate([0,90,0]) rounded_cube(1.5,2.5,5,.5);
			}
		}
	}
}

module tile_stone_4(connections=[true, true, true, true], rot=0) {
	union () {
		tile_base(connections);
		tile_rotate(rot) {
			union() {
				translate([5,9,4]) rotate([0,90,0]) rounded_cube(1.5,8,16,.5);
				translate([0,13,4]) rotate([90,90,0]) rounded_cube(1.5,4.5,13,.5);
				translate([0,20.5,4]) rotate([90,90,0]) rounded_cube(1.5,4.5,7,.5);
				translate([5,17.5,4]) rotate([0,90,0]) rounded_cube(1.5,3,9.5,.5);
				translate([15,17.5,4]) rotate([0,90,0]) rounded_cube(1.5,8.5,11,.5);
				translate([7,21,4]) rotate([0,90,0]) rounded_cube(1.5,5,7.5,.5);
				translate([0,21,4]) rotate([0,90,0]) rounded_cube(1.5,5,6.5,.5);
				translate([21.5,6,4]) rotate([0,90,0]) rounded_cube(1.5,11,4.5,.5);
				translate([5,0,4]) rotate([0,90,0]) rounded_cube(1.5,8.5,9.5,.5);
				translate([15,0,4]) rotate([0,90,0]) rounded_cube(1.5,5.5,11,.5);
				translate([15,6,4]) rotate([0,90,0]) rounded_cube(1.5,2.5,6,.5);
			}
		}
	}
}

module tile_stone(connections=[true,true,true,true], tile=0, rot=0) {
	if (tile == 1) {
		tile_stone_1(connections=connections, tile=tile, rot=rot);
	} else if (tile == 2) {
		tile_stone_2(connections=connections, tile=tile, rot=rot);
	} else if (tile == 3) {
		tile_stone_3(connections=connections, tile=tile, rot=rot);
	} else {
		tile_stone_4(connections=connections, tile=tile, rot=rot);
	}
}

module tile_wood_horiz(connections=[true, true, true, true], deg=90) {
	union () {
		tile_base(connections);
		for(i = [0 : 12]) {
			if (i % 3 == 0) {
				translate([0.25,i*2+.2, 2.1]) cube([8,1.6,1.8]);
				translate([8.65,i*2+.2,2.1]) cube([15,1.6,1.8]);
				translate([24.05,i*2+.2,2.1]) cube([1.7,1.6,1.8]);
			} else if (i % 3 == 1) {
				translate([0.25,i*2+.2,2.1]) cube([5,1.6,1.8]);
				translate([5.65,i*2+.2,2.1]) cube([15,1.6,1.8]);
				translate([21.05,i*2+.2,2.1]) cube([4.7,1.6,1.8]);
			} else {
				translate([0.25,i*2+.2,2.1]) cube([15,1.6,1.8]);
				translate([15.65,i*2+.2,2.1]) cube([10.1,1.6,1.8]);
			}
		}
	}
}

module tile_wood_vert(connections=[true, true, true, true], deg=90) {
	union () {
		tile_base(connections);
		for(i = [0 : 12]) {
			if (i % 3 == 0) {
				translate([i*2+.2, 0.25, 2.1]) cube([1.6,8,1.8]);
				translate([i*2+.2, 8.65, 2.1]) cube([1.6,15,1.8]);
				translate([i*2+.2, 24.05, 2.1]) cube([1.6,1.7,1.8]);
			} else if (i % 3 == 1) {
				translate([i*2+.2, 0.25, 2.1]) cube([1.6,5,1.8]);
				translate([i*2+.2, 5.65, 2.1]) cube([1.6,15,1.8]);
				translate([i*2+.2, 21.05, 2.1]) cube([1.6,4.7,1.8]);
			} else {
				translate([i*2+.2, 0.25, 2.1]) cube([1.6,15,1.8]);
				translate([i*2+.2, 15.65, 2.1]) cube([1.6,10.1,1.8]);
			}
		}
	}
}

module tile_wood(connections=[true, true, true, true], deg=0) {
	union () {
		tile_base(connections);
		intersection () {
			translate([0,0,2.1]) cube([26,26,2]);
			for ( i = [0: 90] ) {
				difference () {
					rotate([0,0,deg]) translate([i*2-40,-40,2.1]) cube([1.7,90,1.8]);
					for ( j = [0: 5] ) {
						if (i % 3 == 0) {
							rotate([0, 0, deg]) translate([i*2-40.2, j*15.3-40, 2]) cube([2.1, 0.4, 2.1]);	
						} else if (i % 3 == 1) {
							rotate([0, 0, deg]) translate([i*2-40.2, j*15.3-32.5, 2]) cube([2.1, 0.4, 2.1]);	
						} else {
							rotate([0, 0, deg]) translate([i*2-40.2, j*15.3-28, 2]) cube([2.1, 0.4, 2.1]);
						}
					}
				}
			}
		}
	}
}

module tile_smooth(connections=[true, true, true, true]) {
	union () {
		tile_base(connections);
		translate([0,0,2.1]) rounded_cube(25.9,25.9,2,0.5);
	}
}

module tile(connections=[true,true,true,true], tile=0, rot=0, deg=0, style="stone") {
	union() {
		if(style == "stone") {
			tile_stone(connections=connections, tile=tile, rot=rot);
		} else if (style == "smooth") {
			tile_smooth(connections=connections);
		} else if (style == "wood") {
			tile_wood(connections=connections, deg=deg);
		} else if (style == "wood_horiz") {
			tile_wood_horiz(connections=connections);
		} else if (style == "wood_vert") {
			tile_wood_vert(connections=connections);
		} else if (style == "wood_angle") {
			tile_wood(connections=connections, deg=45);
		} else if (style == "wood_angle_2") {
			tile_wood(connections=connections, deg=135);
		}
	}
}

//tile(style="wood_angle");

module connector_tile() {
	union() {
		translate([0,.2,0]) cube([2.5,2.6,2]);
		translate([0,15.2,0]) cube([2.5,2.6,2]);
		translate([2.5,.2,0]) rotate([0,0,45]) cube([sqrt(4.3*4.3 + 4.3*4.3),2.6,2]);
		translate([2.5,17.8,0]) rotate([0,0,225]) cube([2.6,sqrt(4.3*4.3 + 4.3*4.3),2]);
		translate([4.2,4.5,0]) cube([2.6,9,2]);
	}
}

module connector_wall_gap() {
	union () {
		translate([0,.5,-0.1]) cube([2,1.5,4.2]);
		translate([2,0,-0.1]) cube([1.5,2.5,4.2]);
	}
}

module wall_rotate(rot) {
	if (rot == 1) {
		translate([0,29.75,3.5]) rotate([90,0,0]) child(0);
	} else if (rot == 2) {
		translate([0,26,33.5]) rotate([180,0,0]) child(0);
	} else if (rot == 3) {
		translate([0,-3.75,29.5]) rotate([270,0,0]) child(0);
	} else {
		translate([0,0,0]) rotate([0,0,0]) child(0);
	}
}

module wall_remove_plugs(plugs) {
	difference() {
		child();
		if (plugs[0]) {
			translate([4.25,-0.01,0]) rotate([0,0,90]) connector_wall_gap();
		}
		if (plugs[1]) {
			translate([1.75,26.01,0]) rotate([0,0,270]) connector_wall_gap();
		}
	}
}

module wall_base(height, connections=[true, true], plugs=[true, true]) {
	difference() {
		union() {
			translate([-0.1,0,0]) cube([6.02,26,height]);
			if (connections[0]) {
				translate([6,4,0]) connector_tile();
			}
			if (connections[1]) {
				translate([0,22,0]) rotate([0,0,180]) connector_tile();
			}
		}
		if (plugs[0]) {
			translate([4.25,-0.01,0]) rotate([0,0,90]) connector_wall_gap();
		}
		if (plugs[1]) {
			translate([1.75,26.01,0]) rotate([0,0,270]) connector_wall_gap();
		}
	}
}

module wall_stone_1(connections=[true, true], plugs=[true, true], rot=0) {
	wall_remove_plugs(plugs) {
		union() {
			wall_base(WALL_TALL, connections, plugs);
			wall_rotate(rot) {
				union() {
					translate([-.5,0,4]) rounded_cube(7,8,16,.5);
					translate([-.5,8.5,4]) rounded_cube(7,7,5,.5);
					translate([-.5,16,4]) rounded_cube(7,4.5,5,.5);
					translate([-.5,8.5,9.5]) rounded_cube(7,12,6,.5);
					translate([-.5,21,4]) rounded_cube(7,5,19,.5);
					translate([-.5,0,20.5]) rounded_cube(7,12,9,.5);
					translate([-.5,12.5,23.5]) rounded_cube(7,13.5,6,.5);
					translate([-.5,8.5,16]) rounded_cube(7,3.5,4,.5);
					translate([-.5,12.5,16]) rounded_cube(7,8,7,.5);
				}
			}
		}
	}
}

module wall_stone_2(connections=[true, true], plugs=[true, true], rot=0) {
	wall_remove_plugs(plugs) {
		union() {
			wall_base(WALL_TALL, connections, plugs);
			wall_rotate(rot) {
				union() {
					translate([-.5,10,8]) rounded_cube(7,8,16,.5);
					translate([-.5,10,4]) rounded_cube(7,16,3.5,.5);
					translate([-.5,0,4]) rounded_cube(7,9.5,7,.5);
					translate([-.5,18.5,8]) rounded_cube(7,7.5,6,.5);
					translate([-.5,21,14.5]) rounded_cube(7,5,15,.5);
					translate([-.5,18.5,14.5]) rounded_cube(7,2,9.5,.5);
					translate([-.5,6,24.5]) rounded_cube(7,14.5,5,.5);
					translate([-.5,2,24.5]) rounded_cube(7,3.5,2.5,.5);
					translate([-.5,0,27.5]) rounded_cube(7,5.5,2,.5);
					translate([-.5,0,24.5]) rounded_cube(7,1.5,2.5,.5);
					translate([-.5,0,11.5]) rounded_cube(7,9.5,12.5,.5);
				}
			}
		}
	}
}

module wall_stone_3(connections=[true, true], plugs=[true, true], rot=0) {
	wall_remove_plugs(plugs) {
		union() {
			wall_base(WALL_TALL, connections, plugs);
			wall_rotate(rot) {
				union() {
					translate([-.5,6,8]) rounded_cube(7,16,8,.5);
					translate([-.5,0,4]) rounded_cube(7,18.5,3.5,.5);
					translate([-.5,19,4]) rounded_cube(7,7,3.5,.5);
					translate([-.5,16.5,16.5]) rounded_cube(7,9.5,6.5,.5);
					translate([-.5,19.5,23.5]) rounded_cube(7,6.5,6,.5);
					translate([-.5,10,16.5]) rounded_cube(7,6,13,.5);
					translate([-.5,16.5,23.5]) rounded_cube(7,2.5,6,.5);
					translate([-.5,22.5,8]) rounded_cube(7,3.5,8,.5);
					translate([-.5,0,8]) rounded_cube(7,5.5,5,.5);
					translate([-.5,0,13.5]) rounded_cube(7,5.5,10,.5);
					translate([-.5,0,24]) rounded_cube(7,9.5,5.5,.5);
					translate([-.5,6,16.5]) rounded_cube(7,3.5,7,.5);
				}
			}
		}
	}
}

module wall_stone_4(connections=[true, true], plugs=[true, true], rot=0) {
	wall_remove_plugs(plugs) {
		union() {
			wall_base(WALL_TALL, connections, plugs);
			wall_rotate(rot) {
				union() {
					translate([-.5,6,12]) rounded_cube(7,16,8,.5);
					translate([-.5,0,4]) rounded_cube(7,18.5,3.5,.5);
					translate([-.5,19,4]) rounded_cube(7,7,7.5,.5);
					translate([-.5,22.5,12]) rounded_cube(7,3.5,17.5,.5);
					translate([-.5,6,8]) rounded_cube(7,6.5,3.5,.5);
					translate([-.5,13,8]) rounded_cube(7,5.5,3.5,.5);
					translate([-.5,0,8]) rounded_cube(7,5.5,16,.5);
					translate([-.5,0,24.5]) rounded_cube(7,9,5,.5);
					translate([-.5,6,20.5]) rounded_cube(7,9,3.5,.5);
					translate([-.5,15.5,20.5]) rounded_cube(7,6.5,9,.5);
					translate([-.5,9.5,24.5]) rounded_cube(7,5.5,5,.5);
				}
			}
		}
	}
}

module wall_stone(connections=[true,true], plugs=[true,true], wall=0, rot=0) {
	if (wall == 1) {
		wall_stone_2(connections=connections, plugs=plugs, rot=rot);
	} else if (wall == 2) {
		wall_stone_3(connections=connections, plugs=plugs, rot=rot);
	} else if (wall == 3) {
		wall_stone_4(connections=connections, plugs=plugs, rot=rot);
	} else {
		wall_stone_1(connections=connections, plugs=plugs, rot=rot);
	}
}

module wall_wood_vert(connections=[true,true], plugs=[true,true], deg=0) {
	union () {
		wall_base(WALL_TALL, connections, plugs);
		for(i = [0 : 12]) {
			if (i % 3 == 0) {
				translate([-0.5,i*2+.15,4.25]) cube([6.8,1.6,8]);
				translate([-0.5,i*2+.15,12.65]) cube([6.8,1.6,16.60]);
			} else if (i % 3 == 1) {
				translate([-0.5,i*2+.15,4.25]) cube([6.8,1.6,5]);
				translate([-0.5,i*2+.15,9.65]) cube([6.8,1.6,15]);
				translate([-0.5,i*2+.15,25.05]) cube([6.8,1.6,4.2]);
			} else {
				translate([-0.5,i*2+.15,4.25]) cube([6.8,1.6,15]);
				translate([-0.5,i*2+.15,19.65]) cube([6.8,1.6,9.6]);
			}
		}
	}
}

module wall_wood_horiz(connections=[true,true], plugs=[true,true], deg=0) {
	union () {
		wall_base(WALL_TALL, connections, plugs);
		for(i = [0 : 11]) {
			if (i % 3 == 0) {
				rotate([90, 0, 0]) translate([-0.5,i*2.05+5,-25.75]) cube([6.8,1.65,8]);
				rotate([90, 0, 0]) translate([-0.5,i*2.05+5,-17.35]) cube([6.8,1.65,17.10]);
			} else if (i % 3 == 1) {
				rotate([90, 0, 0]) translate([-0.5,i*2.05+5,-25.75]) cube([6.8,1.65,5]);
				rotate([90, 0, 0]) translate([-0.5,i*2.05+5,-20.35]) cube([6.8,1.65,15]);
				rotate([90, 0, 0]) translate([-0.5,i*2.05+5,-4.95]) cube([6.8,1.65,4.7]);
			} else {
				rotate([90, 0, 0]) translate([-0.5,i*2.05+5,-25.75]) cube([6.8,1.65,15]);
				rotate([90, 0, 0]) translate([-0.5,i*2.05+5,-10.35]) cube([6.8,1.65,10.1]);
			}
		}
	}
}

module wall_wood(connections=[true,true], plugs=[true,true], deg=0) {
	union () {
		wall_base(WALL_TALL, connections, plugs);
		intersection() {
			translate([-0.5,0.5,4.25]) cube([7,25,25]);
			for ( i = [0: 90] ) {
				difference () {
					rotate([deg,0,0]) translate([-0.5,i*2-40,-40]) cube([6.8,1.6,90]);
					for ( j = [0: 5] ) {
						if (i % 3 == 0) {
							rotate([deg, 0, 0]) translate([-0.6, i*2-40, j*15.3-40]) cube([7, 1.9, 0.4]);	
						} else if (i % 3 == 1) {
							rotate([deg, 0, 0]) translate([-0.6, i*2-40, j*15.3-32.5]) cube([7, 1.9, 0.4]);	
						} else {
							rotate([deg, 0, 0]) translate([-0.6, i*2-40, j*15.3-28]) cube([7, 1.9, 0.4]);
						}
					}
				}
			}
		}
	}
}

module wall_smooth(connections=[true,true], plugs=[true,true]) {
	union () {
		wall_base(WALL_TALL, connections, plugs);
		translate([-0.6,0.1,4.1]) rounded_cube(7,25.8,25.3, 0.5);
	}
}

module wall(connections=[true,true], plugs=[true,true], wall=0, rot=0, deg=0, style="stone") {
	union() {
		if(style == "stone") {
			wall_stone(connections=connections, plugs=plugs, wall=wall, rot=rot);
		} else if (style == "smooth") {
			wall_smooth(connections=connections, plugs=plugs);
		} else if (style == "wood") {
			wall_wood(connections=connections, plugs=plugs, deg=deg);
		} else if (style == "wood_horiz") {
			wall_wood_horiz(connections=connections, plugs=plugs);
		} else if (style == "wood_vert") {
			wall_wood_vert(connections=connections, plugs=plugs);
		} else if (style == "wood_angle") {
			wall_wood(connections=connections, plugs=plugs, deg=45);
		} else if (style == "wood_angle_2") {
			wall_wood(connections=connections, plugs=plugs, deg=135);
		}
	}
}

//wall(style="stone", wall=3, rot=3);
