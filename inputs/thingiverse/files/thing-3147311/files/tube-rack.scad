/* [Parts] */
// select parts to display or print
Print_Part = "assembly"; // [assembly,platter_stand,platter_shelves,stand,shoe,shelf_1,shelf_2,shelf_3]

/* [Tubes] */
// X separation between tubes (along row)
tube_x_separation = 22; // [5:0.5:50]
// Y separation between tubes (between rows)
tube_y_separation = 22; // [5:0.5:50]
// How many rows of tubes
tube_y_count = 1; // [1:6]
// How many tubes on each row
tube_x_count = [6,6,6,6,0,0]; // 1:20
// Offset the row by a quarter of a tube. Alternate +1 and -1 to stagger rows.
tube_x_offset = [0,0,0,0,0,0]; // -1:1:1
// How large is the hole on each shelf (top..bottom)
tube_size = [17,17,8];

/* [Shelves] */
// Base size of each shelf  (x,y,z)
shelf_size = [140,30,2]; // 1:0.5:200
// How many shelves
shelf_count = 3; // [2:3]
// Vertical distance between shelves
shelf_height = 35; // [0:60]
// Thickness of reinforcement rails
reinforcement_rail = 2.0; // [0:0.5:5]
// Distance of rail from shelf edge
reinforcement_edge_inset = 1.5; // [0:0.5:5]
// Size of slide registration bump
registration_bump = 0.6; // [0:0.1:1.5]
// Tolerance distance for slide fit
slide_tolerance = 0.2; // [0:0.05:0.5]


/* [Stand] */
// Vertical height of the bottom shelf
stand_height = 10; // [10:1:40]
// Thickness of stand walls
stand_thick = 2; // [1:0.5:4]
// Width of stand foot
stand_foot = 10; // [5:1:20]
// Add 'shoes' to prevent rack tipping over
stand_shoes = true;
// Base size of stand shoes (x,y,z)
shoe_size = [15,70,2];

/* [Hidden] */
// Inset from slide edge for registration bump
registration_inset = 3; // [0:1:10]
// Distance of rail from stand
reinforcement_rail_inset = 6; // [0:1:10]

// combine options into arrays

// How much shelf space to allocate to each tube (x,y)
tube_separation = [tube_x_separation,tube_y_separation];





/*
// 1 x 10ml test
tube_y_count = 1;
tube_x_count = [1];
tube_x_offset = [0];
tube_size = [17,17,8];
tube_separation = [22,20,0];
shelf_size = [30,30,2];
shelf_height = 30;
shelf_count = 3;
stand_height = 10;
stand_thick = 2;
stand_foot = 10;
shoe_size = [15,70,2];
reinforcement_edge_inset = 2;
reinforcement_rail = 2.5;

*/

/*
// 14 x 2ml
tube_y_count = 2;
tube_x_count = [7,7];
tube_x_offset = [0,0];
tube_size = [11,11,7];
tube_separation = [15.5,20,0];
shelf_size = [120,40,1.5];
shelf_height = 16;
shelf_count = 3;
stand_height = 10;
stand_thick = 2;
stand_foot = 10;
*/

// pill box markings
/*
upper_markings = ["S","M","T","W","T","F","S"];
upper_markings_size = 4;
upper_markings_y = 40;
*/



if(Print_Part=="shelf_1") {
	shelf(0);
} else if(Print_Part=="shelf_2") {
	shelf(1);
} else if(Print_Part=="shelf_3") {
	shelf(2);
} else if(Print_Part=="stand") {
	translate([0,0,shelf_size[1]/2])
		rotate([-90,0,0]) stand();
} else if(Print_Part=="shoe") {
	translate([0,0,shoe_size[0]])
		rotate([0,90,0]) shoe();
} else if(Print_Part=="platter_stand") {
	// stand and shoes
	mirror_x() {
		translate([5,-(stand_height+shelf_height*(shelf_count-1))/2,shelf_size[1]/2])
			rotate([-90,0,0]) stand();
		if(stand_shoes) translate([-stand_foot-13,0,shoe_size[0]]) 
			rotate([0,90,0]) shoe();
	}
} else if(Print_Part=="platter_shelves") {
	// shelves
	for(i=[0:shelf_count-1]) translate([0,(i-(shelf_count-1)/2)*(shelf_size[1]+5),0]) 
		shelf(i);
} else {
	rack_assembly();
}

module rack_assembly() {
	color("grey",0.6) for(i=[0:shelf_count-1]) translate([0,0,(shelf_count-i-1)*shelf_height+stand_height]) {
		rotate([180,0,0]) shelf(i);
	}
	color("blue",0.5) mirror_x() translate(-[shelf_size[0]/2,0,0]) {
		stand();
		if(stand_shoes) {
			translate([-2,0,-shoe_size[2]]) shoe();
		}
	}
}

module shoe() {
	translate([0,-shoe_size[1]/2,0])
		cube(shoe_size);
	clip_offset = 5; // stand_thick*2 + 1;
	clip_size = [shoe_size[0]-clip_offset,2,2];
	p = [clip_offset,-shelf_size[1]/2-2-slide_tolerance,shoe_size[2]];
	mirror_y() {
		translate(p) cube(clip_size+[0,0,2.1]);
		hull() {
			translate(p+[0,0,stand_thick+0.51]) cube(clip_size);
			translate(p+[0,4,stand_thick-slide_tolerance]) cube(clip_size);
		}
		//translate(p+[0,stand_thick*2,stand_thick-slide_tolerance]) cube(clip_size+[0,3,0]);
	}
}

module stand() {
	cut_z = 0; // shelf_size[2];
	translate(-[stand_thick,shelf_size[1]/2,0]) {
		cube([stand_thick,shelf_size[1],(shelf_count-1) * shelf_height + stand_height]);
		for(i=[0:shelf_count-1]) translate([0,0,(i)*shelf_height+ stand_height]) {
			// slide rail
			translate([0,0,0]) cube([stand_thick+5,shelf_size[1],2]);
			translate([0,0,-4-shelf_size[2]-slide_tolerance]) {
				cube([stand_thick+1,shelf_size[1],2]);
				translate([stand_thick,0,0]) difference() {
					hull() {
						translate([1,0,0]) cube([1,shelf_size[1],2]);
						translate([4,0,2]) cube([1,shelf_size[1],2]);
					}
					// registration bumps
					for(y=[
						registration_inset,
						shelf_size[1]-registration_inset-registration_bump*2-1
					]) {
						translate([1,y,4]) hull() {
							cube([5,registration_bump*2+1,0.1+slide_tolerance]);
							translate([0,registration_bump,-registration_bump]) cube([5,1,0.1+registration_bump+slide_tolerance]);
						}
					}
				}
			}
		}
		// foot
		cube([stand_foot+stand_thick,shelf_size[1],stand_thick]);
		// foot chamfer
		hull() {
			cube([stand_thick,shelf_size[1],stand_thick*2]);
			cube([stand_thick*2,shelf_size[1],stand_thick]);
		}
	}
}

module shelf(index=0) {
	translate(-[shelf_size[0],shelf_size[1],0]/2) {
		difference() {
			cube(shelf_size);
			// tube holes
			for(y=[0:tube_y_count-1]) {
				x_count = tube_x_count[y];
				tube_origin = [
					shelf_size[0] - tube_separation[0]*(x_count-1 - tube_x_offset[y]*0.5), 
					shelf_size[1] - tube_separation[1]*(tube_y_count-1), 
					-1
				]/2;
				for(x=[0:x_count-1]) {
					translate(tube_origin + [x*tube_separation[0],y*tube_separation[1],0])
						cylinder(d=tube_size[index], h=shelf_size[2]+1, $fn=30);
				}
			}
			// markings
			/*
			if(upper_markings) {
				x_count = tube_x_count[0];
				label_origin = [
					shelf_size[0] - tube_separation[0]*(x_count-1 - tube_x_offset[y]*0.5), 
					upper_markings_y, 
					1
				]/2;
				for(x=[0:x_count-1]) {
					translate(label_origin + [x*tube_separation[0],0,0])
						rotate([180,0,0]) linear_extrude(height=1)
							text(upper_markings[x],font="Liberation Sans:style=Bold",size=upper_markings_size,halign="center",valign="center");
					
				}
			}
			*/
		}
		// reinforcement
		if(reinforcement_rail) {
			r = reinforcement_rail;
			if(tube_y_count>1) {
				// reinforcement rails between rows
				for(y=[0:tube_y_count-2]) {
					tube_y = (shelf_size[1] - tube_separation[1]*(tube_y_count-1))/2;
					rail_origin = [
						reinforcement_rail_inset, 
						tube_y + tube_separation[1]*(y+0.5) - r/2, //tube_separation[1]*(y+1) - r/2, 
						shelf_size[2]-1
					];
					rail_size = [ shelf_size[0]-reinforcement_rail_inset*2, r, 1 ];
					hull() {
						translate(rail_origin) cube(rail_size);
						translate(rail_origin+[r,0,r]) cube(rail_size-[2*r,0,0]);
					}
				}
			}
			// reinforcement rails at sides
			for(y=[reinforcement_edge_inset, shelf_size[1]-reinforcement_edge_inset-r]) {
				rail_origin = [
					reinforcement_rail_inset, 
					y, 
					shelf_size[2]-1
				];
				rail_size = [ shelf_size[0]-reinforcement_rail_inset*2, r, 1 ];
				hull() {
					translate(rail_origin) cube(rail_size);
					translate(rail_origin+[r,0,r]) cube(rail_size-[2*r,0,0]);
				}
			}
		}
	}
	mirror_x() translate(-[shelf_size[0],shelf_size[1],0]/2) {
		// slide rails
		difference() {
			hull() {
				cube([4,shelf_size[1],shelf_size[2]]);
				cube([1,shelf_size[1],shelf_size[2]+2]);
			}
		}
		// registration bump
		translate([0,registration_inset,shelf_size[2]-0.1]) hull() {
			cube([5.5,registration_bump*2+1,0.1]);
			translate([0,registration_bump,0]) cube([5,1,0.1+registration_bump]);
		}
	}
	
}

// utilities
 
module cube_centered(size=[10,10,10]) {
	translate(-[size[0],size[1],0]/2) cube(size);
}

module mirror_x() {
	children();
	mirror([1,0,0]) children();
}

module mirror_y() {
	children();
	mirror([0,1,0]) children();
}

module mirror_z() {
	children();
	mirror([0,0,1]) children();
}

module mirror_xy() {
	mirror_x() mirror_y() children();
}

module explode(distance=100, direction=[0,0,1]) {
	nd = direction / norm(direction);
	translate(nd * distance * animate_explode) children();
}
