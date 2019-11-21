/* Parameters for customizing the build */

/* [Global] */
// the number of coin cells to hold
num_cells = 7;   // [1:100]
// the thickness of the inter-slot walls in mm
inter_walls = 1.75; // [1.5:3]
// How thick the cells are in mm.  The slots will be exactly this size.  Friction fit is good.
cell_thick = 3.2; // [0.5:7]
// The diameter of the cells in mm. Loose fit is important.  The radial_gap will be added to both sides.
cell_round = 20;
// The gap between the cell and the outside walls in mm.   
radial_gap = 1; // [0.5:2]
// The thickness of the outside bottom, side and end in mm.
end_walls = 3; // [1:5]


/* [Hidden] */

include <MCAD/units.scad>

module coin_cell_slot(diameter, thickness, offset_x)
{
	hull() {
		cylinder(d=diameter, h=thickness);
		translate([offset_x,0,0])cylinder(d=diameter, h=thickness);
	}
}

module cell_array(num_cells, diameter, thickness, offset_z, offset_x)
{
	for( cell_num = [0:num_cells - 1] ) {
		translate([0,0,cell_num * offset_z]) coin_cell_slot(diameter, thickness, offset_x);
	}
}

cavity_round = cell_round + (2 * radial_gap);
big_width=cavity_round + (2 * end_walls) ;
big_height=cell_round + (1 * end_walls) ;
center_y = big_width/2;
center_z = big_height/2;
side_grip_relief = (big_width - cell_round)/2 +2;
long = end_walls + ((num_cells - 1) * inter_walls) + (num_cells * cell_thick) + end_walls;
thisFont=8bit_polyfont();

difference() {
	translate([-end_walls,-center_y, -center_z]) cube([long,big_width,big_height]);
	rotate ([0,90,0]) {
			cell_array(num_cells, cavity_round, cell_thick, cell_thick + inter_walls, -cell_round);
	
	}
	translate([-end_walls -epsilon,-(center_y + epsilon), (center_z -cell_round/2 + 1.5) ]) cube([long+2,side_grip_relief, cell_round/2-1]);
	translate([-end_walls -epsilon,+(center_y - side_grip_relief) +epsilon, (center_z -cell_round/2 + 1.5) ]) cube([long+2,side_grip_relief, cell_round/2-1]);
	translate([-end_walls*2, 0, -center_z]) rotate ([0,90,0]) 
		cylinder(h=long+2*end_walls, d=cell_round*2/3);
 	translate([-(epsilon+end_walls), 0, +center_z/4]) rotate ([0,90,0]) 
		cylinder(h=(2*epsilon) + end_walls, d=cell_round/3);

	
};