use <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
// Clothes Rod Diameter in Inches
rod_diameter_in = 1.5;
// Length of Bracket Stem in Inches
stem_length_in = 2.0;
// Height of Hole in Bracket
hanger_height_in = 0.625;
// Width of Hole in Bracket
hanger_width_in = 0.625;
// Bracket Thickness
wall_thickness_in=0.25; // [0.125:Thin (1/8"),0.25:Normal (1/4"),0.5:Thick (1/2"), 0.75:Super Chunk(3/4")]
// Create a Raft?
create_raft = 0;         // [0:Yes, 1:No]
//CUSTOMIZER VARIABLES END

IN = 25.4/1;

rod_diameter = rod_diameter_in*IN;
stem_length = stem_length_in*IN;
hanger_height = hanger_height_in*IN;
hanger_width = hanger_width_in*IN;
wall_thickness = wall_thickness_in*IN;
part_width = wall_thickness_in*IN;

raft_section_width = 0.5/1;
raft_section_spacing = 1.5/1;
raft_manifold_tweak = 0.01/1;


module rod_holder() {
	od = wall_thickness*2 + rod_diameter;
    heights = [-part_width*1.5, 0, part_width*1.5];

*translate([0,0,-part_width*1.5])
cylinder(h=part_width*4, r=od/2, $fs=1);

	union() {
		for ( i = [0:2] ) {
			translate([od/2,0,heights[i]])
			difference() {
				cylinder(h=part_width, r=od/2, $fs=1);
		
				translate([0,0,-part_width/2])
				cylinder(h=part_width*2, r=rod_diameter/2, $fs=1);
			}
		}
	
		for(j = [0, 2]) {
			for ( i = [0:11] ) {
				color("green")
				translate([od/2, 0, heights[j]/2])
				rotate(i*360 / 12, [0, 0, 1])
				translate([od/2-wall_thickness/2, 0, 0])
				cylinder(h=part_width, r=wall_thickness/2);
			}
		}
	}
}

module stem() {
	translate([0, -rod_diameter/4, 0])
	cube([stem_length+wall_thickness*2, rod_diameter/2, part_width]);
}

module hanger() {
	translate([0, -rod_diameter/4, 0])
	difference() {
		cube([hanger_height+wall_thickness*2, rod_diameter/2, hanger_width+wall_thickness*2]);
		
		translate([wall_thickness, -rod_diameter/4, wall_thickness])
		cube([hanger_height, rod_diameter, hanger_width]);
	}
}

module make_raft(x, y, z) {
	intersection() {
		cube([x, y*2, z*2]);

		union() {
			for( i = [ 0 : raft_section_spacing*2 : x ] ) {
				translate([i, 0, 0])
				cube([raft_section_width, y, z+raft_manifold_tweak*2]);
			
				translate([i, 0, 0])
				cube([raft_section_spacing+raft_section_width, raft_section_width, z+raft_manifold_tweak*2]);
			
				translate([i+raft_section_spacing, 0, 0])
				cube([raft_section_width, y, z+raft_manifold_tweak*2]);
			
				translate([i+raft_section_spacing, y, 0])
				cube([raft_section_spacing+raft_section_width, raft_section_width, z+raft_manifold_tweak*2]);
			}
		}
	}
}

module raft() {
	box_length = stem_length;
	box_width = part_width*1.5;
	box_height = rod_diameter/2 - part_width/2 + raft_manifold_tweak;

	color("purple")	
	translate([hanger_height+wall_thickness*2, -(hanger_width+wall_thickness*2)+(hanger_width+wall_thickness)/3, 0])
	make_raft(box_length, box_width, box_height);

	color("purple")
	translate([0,-(hanger_width+wall_thickness*2.5), 0])
	make_raft(hanger_height+wall_thickness*2, hanger_width+wall_thickness*3, (rod_diameter/2+wall_thickness) - rod_diameter/4 + raft_manifold_tweak);
}


total_part_length = (rod_diameter + wall_thickness*2) + stem_length + (hanger_height+wall_thickness*2);

translate([-total_part_length/2, 0, 0])
union() {
	translate([0, 0, wall_thickness + rod_diameter/2])
	rotate([90,0,0])
	translate([hanger_height+wall_thickness, 0, 0])
	union() {
		translate([-(hanger_height+wall_thickness), 0, 0])
		hanger();
	
		translate([(stem_length+wall_thickness), 0, (hanger_width+2*wall_thickness)/2-(part_width/2)])
		union()
		{
			rod_holder();
	
			translate([-(stem_length+wall_thickness), 0, 0])
			stem();
		}
	}
	
	if (create_raft) {
		raft();
	}
}

build_plate(build_plate_selector);