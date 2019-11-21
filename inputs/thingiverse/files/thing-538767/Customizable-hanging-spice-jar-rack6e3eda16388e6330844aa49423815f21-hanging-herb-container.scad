// hanging herb container rack

$fn=90;

// Number columns of containers for uneven rows
number_of_columns = 3;

// Number of rows of containers
number_of_rows = 2;

// The diameter of each container (mm).
container_diameter = 44;

// The height of each container (mm).
container_height = 60;

// The thickness of the board which holds the rack.
board_thickness = 15;

// The thickness of the walls
wall_thickness = 1.5;


module hexagon(r, h) {
	translate([0,0,h/2])
	union() {
		cube( size=[2*r, sqrt(4/3)*r, h], center=true);
		rotate( 120, [0,0,1]) cube( size=[2*r, sqrt(4/3)*r, h], center=true );
		rotate( 240, [0,0,1]) cube( size=[2*r, sqrt(4/3)*r, h], center=true );
	}
}

module cylinderGap() {
	gapy = sqrt((container_diameter+wall_thickness)*(container_diameter+wall_thickness) - (container_diameter*container_diameter));
	cube( size=[2*container_diameter, gapy, container_height*3], center=true );
}

module inner_cylinder() {
	union() {
		cylinder( r=container_diameter/2, h=container_height+wall_thickness );
		cylinderGap();
		rotate(60, [0,0,1]) cylinderGap();
		rotate(-60, [0,0,1]) cylinderGap();
	}
}

dx = container_diameter;
dy = sqrt( 0.75 * dx*dx );


module outer_cylinder() {
	intersection() {
		hexagon( r=container_diameter/2, h=container_height );
	
		union() {
			cylinder( r=container_diameter/2+wall_thickness, h=container_height );
			rotate(30, [0,0,1])
				cube( size=[2*container_diameter, wall_thickness, 2*container_height], center=true );
			rotate(-30, [0,0,1])
				cube( size=[2*container_diameter, wall_thickness, 2*container_height], center=true );
			rotate(-90, [0,0,1])
				cube( size=[2*container_diameter, wall_thickness, 2*container_height], center=true );
		}
	}
}

module containerPlate() {
	hexagon( r=container_diameter/2, h=wall_thickness );
}

module singleContainerRack() {

	union() {
		containerPlate();
		
		difference() {
			outer_cylinder();
			inner_cylinder();
		}
	}
}


module containerMatrix() {
	
	//difference() {
		union() {
			for( nx = [0 : number_of_columns-1] ) {
				for( ny = [0 : number_of_rows-1] ) {
					translate([nx*dx + 0.5*dx*(ny%2), -ny*dy, 0])
						singleContainerRack();
				}
			}
		}
		
		// union() {
			// for( nx = [number_of_columns : number_of_columns] ) {
				// for( ny = [0 : number_of_rows-1] ) {
					// translate([nx*dx + 0.5*dx*(ny%2), -ny*dy, 0])
						// singleContainerRack();
				// }
			// }
		// }
	//}
}

module singleUProfile() {
	difference() {
		translate([0.5*wall_thickness, 0, 0])
		cube(size=[container_diameter, board_thickness+2*wall_thickness, board_thickness+wall_thickness]);
		translate([-0.5*wall_thickness, wall_thickness, wall_thickness])
			cube(size=[container_diameter+2*wall_thickness, board_thickness, board_thickness+wall_thickness]);
	}
	translate([0.5*wall_thickness,-0.5*container_diameter,0])
		cube(size=[container_diameter, 0.5*container_diameter, wall_thickness]);
}

module uProfileMatrix() {
	union() {
		for( nx = [0 : number_of_columns-1] ) {
			translate([nx*dx, 0, 0])
				singleUProfile();
		}

	}
}

union()
{
	translate([-0.5*container_diameter-0.5*wall_thickness, 0.5*container_diameter, 0])
		uProfileMatrix();
	difference() {
		containerMatrix();
		translate([-0.5*dx, 0.5*container_diameter+wall_thickness, 0] )
			cube( size=[number_of_columns * dx, board_thickness, 2*container_height]);
	}
}