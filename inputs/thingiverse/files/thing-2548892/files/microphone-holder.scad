// preview[view:south west, tilt:top diagonal]

// Which part would you like to see?
part = "all"; // [all:All parts,mount:Mount Only,holder:Holder Only,axle:Axle Only]

/* [Basic] */

// Nut parameters in a mount

// Size of a nut between two flat edges
nut_size = 16;

nut_height = 8.3;

// Microphone holder parameters
holder_length = 30;

// Front inner diameter must be bigger or equal than rear one
front_inner_diameter = 32;
rear_inner_diameter = 29;

// Holder wall thickness
wall_thickness = 1.5;

/* [Advanced] */

// Knurled mount parameters
mount_base_height = 12;
mount_base_diameter = 28;

// Knurl's depth
knurl_depth = 2;
knurl_count = 10;

// Joint parameters
joint_outer_diameter = 16;

// Distance between two outer surfaces of the joint
joint_total_thickness = 12;
joint_height = 18;

// Gap width for middle joint arm
joint_slot_width = 4;

// Hole for the joint axle
joint_hole_diameter = 7;

// Joint cogs parameters
cogs_count=30;
cogs_height=0.5;

// An offset from outer joint surface and inner joint axle hole
cogs_offset=1;

/* [Print options] */

// printing parameters

// Expansion of detail as a result of extrusion
print_expansion = 0.1;

// Gap between details when printed together
gap_between_parts = 2;

/* [Hidden] */

// construction hidden constants

// technical overlap between joined or deducted details to ensure volumes are combined in one and deducted without thin planes at the edges
overlap=0.1;
pi=3.14;

// all parts together

print_part();

module print_part() {
    if ( (part == "all") || (part == "mount") ) {
        base_part();
    }

    if ( (part == "all") || (part == "holder") ) {
        offset=(mount_base_diameter/2)*cos(asin(((front_inner_diameter/2+wall_thickness)*sin(45))/(mount_base_diameter/2)))+(front_inner_diameter/2+wall_thickness)*(1+cos(45))+wall_thickness;
        translate( [offset+gap_between_parts,0,0] )
        rotate( [0,0,-90] )
        holder_part();
    }

    if ( (part == "all") || (part == "axle") ) {
        translate( [mount_base_diameter/2+gap_between_parts+joint_hole_diameter/2,0,0] )
        axle_part();
    }
}

// PART 1: Stand Mount

module base_part() {
    union() {
        difference() {
            base();
            nut ();
            knurls();
        };

        translate( [0,0,mount_base_height] )
        stand_mount_joint();
    }
}

module base () {
    cylinder( $fn=mount_base_diameter*pi*3, mount_base_height, d=mount_base_diameter );
}    

module knurls () {
    count = knurl_count;
    height = mount_base_height;
    radius = knurl_depth;
    surface_diameter = mount_base_diameter;
    
    angle=360/count;
    for( number = [1 : count] ) {
        rotate( [0,0,angle*number] )
        translate( [surface_diameter/2,0,-overlap] )
        cylinder( $fn=24, height+2*overlap, r=radius );
    };
}

module nut () {
    translate( [0,0,-overlap] )
    cylinder( $fn=6, nut_height+print_expansion+overlap, d=((nut_size+2*print_expansion)/cos(30)) );
}

module stand_mount_joint () {
    width = joint_outer_diameter;
    depth = joint_total_thickness;
    height = joint_height;
    hole_diameter = joint_hole_diameter+2*print_expansion;
	
	slot_width = joint_slot_width+2*print_expansion;

	union() {
		// joint without cogs
		difference() {
			// joint full body
			union() {
				// cubical part of the joint is radius less than full height
				// radius is half width of the joint
				translate( [-width/2, -depth/2, -overlap] )
				cube( [width, depth, height-width/2+overlap] );
				
				// radial part of the joint
				translate( [0,0,height-width/2] )
				rotate( [90,0,0] ) 
				cylinder( $fn=width*pi*3, depth, d=width, center=true );
			}
			
			// slot
			translate( [-width/2-overlap, -slot_width/2, -overlap*2] )
			cube( [width+overlap*2, slot_width, height+overlap*3] );
			
			// mount hole
			translate( [0,0,height-width/2] )
			rotate( [90,0,0] ) 
			cylinder( $fn=hole_diameter*pi*3, depth+overlap*2, d=hole_diameter, center=true );
		}
		
		// cogs
		translate( [0,-slot_width/2,height-width/2] )
		cogs( true );

        rotate ( [0,0,180] )
		translate( [0,-slot_width/2,height-width/2] )
		cogs( true );
	}
}

// PART 2: Holder

// this is the angle for whole detail to rotate to make holder semi-circle perpendicular to XY plane
ratio = front_inner_diameter/rear_inner_diameter;
tilt_angle = atan(((rear_inner_diameter/2+wall_thickness)*ratio-(rear_inner_diameter/2+wall_thickness))/holder_length);

module holder_part() {
    // make wide side of the holder laying flat at XY plane
    translate ( [0,0,holder_length/2] )
    rotate( [-90+tilt_angle,0,0] )
    union() {
        holder();

        holder_joint();
    }
}

module holder() {
	length = holder_length;
	inner_radius = [rear_inner_diameter/2, front_inner_diameter/2];
	thickness = wall_thickness;
	
	outer_radius = [inner_radius[0]+thickness, (inner_radius[0]+thickness)*ratio];
	
    // rotate holder to make it horizontal before attaching to the joint
	rotate( [-tilt_angle,0,0] )
    translate( [0,0,-outer_radius[0]*(1+ratio)/2] )
    rotate( [-90,0,0] )
	rotate( [0,0,45] )
	linear_extrude( height=length, slices=ceil(length), scale=ratio, center=true )
	union() {
		difference() {
			circle( $fn=2*outer_radius[0]*pi*3, r=outer_radius[0] );
			circle( $fn=2*inner_radius[0]*pi*3, r=inner_radius[0] );
			square( outer_radius[0]+overlap );
		}
		
		translate( [inner_radius[0]+thickness/2, 0] )
		circle( $fn=12, d=thickness );

		translate( [0, inner_radius[0]+thickness/2] )
		circle( $fn=12, d=thickness );
	}
}

// joint arm
module holder_joint () {
    width = joint_outer_diameter;
    depth = joint_slot_width-print_expansion;
    height = joint_height;
    hole_diameter = joint_hole_diameter+2*print_expansion;

	holder_min_radius = rear_inner_diameter/2+wall_thickness;
	insert_angle = asin((depth/2)/holder_min_radius);
	insert_length = holder_min_radius*(1-cos(insert_angle))+overlap;

	translate( [0, 0, -insert_length/2] )
	cube( [depth, width, insert_length], center=true );
	
	union() {
		// joint without cogs
		difference() {
			// joint full body
			union() {
				// cubical part of the joint
				translate( [-depth/2, -width/2, -overlap] )
				cube( [depth, width, height-width/2+overlap] );
				
				// radial part of the joint
				translate( [0,0,height-width/2] )
				rotate( [0,90,0] ) 
				cylinder( $fn=width*pi*3, depth, d=width, center=true );
			}
			
			// mount hole
			translate( [0,0,height-width/2] )
			rotate( [0,90,0] ) 
			cylinder( $fn=hole_diameter*pi*3, depth+overlap*2, d=hole_diameter, center=true );

			// cogs
			rotate( [0,0,90] )
			translate( [0,-depth/2,height-width/2] )
			cogs();

			rotate( [0,0,-90] )
			translate( [0,-depth/2,height-width/2] )
			cogs( false );
		}
	}
}


// PART 3: Joining Axle

module axle_part() {
    cylinder( $fn=joint_hole_diameter*pi*3, joint_total_thickness, d=joint_hole_diameter-print_expansion*2 );
}

// small cogs to make a traction in joint
// if cogs are convex, then their length is shorter to fit into concave cogs slots after printing
module cogs( isConvex=true ) {
    count = cogs_count;
    angle=360/count;

	offset = cogs_offset + ( isConvex ? -2*print_expansion : 2*print_expansion );
	outer_radius = joint_outer_diameter/2-offset;
	inner_radius = joint_hole_diameter/2+offset;

    height = cogs_height;
	length = outer_radius*cos(angle/2)-inner_radius;
    
	outer_width=outer_radius*sin(angle/2)*2;
	inner_width=inner_radius*tan(angle/2)*2;
	
    for( number = [1 : count] ) {
        rotate( [0,number*angle,0] )
		translate( [0,0,-outer_radius*cos(angle/2)] )
		linear_extrude( height=length, slices=ceil(length), scale=[(inner_width/outer_width),1] )
		polygon( points=[[-outer_width/2,0], [0,height], [outer_width/2,0], [outer_width/2,-overlap], [-outer_width/2,-overlap]] );
    };
}

