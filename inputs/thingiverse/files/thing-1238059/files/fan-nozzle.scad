// Universal Nozzle/Duct Creator

// Dean Cording
// dean@cording.id.au


// Remixed from Customizable fan nozzle for 40mm fans
// by mx5
// http://www.thingiverse.com/thing:130917

/* [Nozzle] */
// Length of nozzle body length
nozzle_length = 28; // [300]

// Thickness of nozzle wall
nozzle_wall = 1.4; 

// Tilt angle of nozzle body
nozzle_tilt = 70; // [-90:90]

// Extension of nozzle base
nozzle_extension = 5; // [100]

/* [Output Hole] */
// Size of nozzle output hole
nozzle_dillation = 40;  // [0:300]

// Ratio of height/width of nozzle output hole
nozzle_scale = 0.55;  // [0:0.05:4]

// Number of sides/corners of nozzle output hole (>2)
nozzle_edges = 6; // [3,4,5,6,7,8,9,10] 

// Curvature of nozzle output hole corners
nozzle_edgeradius = 5;  // [0:20]

// Rotate nozzle output hole between flat or corner
nozzle_edgerotate = 1; // [0,1] 

// Tilt angle of nozzle output hole relative to nozzle body
nozzle_end_tilt = 10;  // [-90:90]

/* [Base] */
// Thickness of nozzle mounting base (0 = no base)
base_thickness = 2; // [10]

// Inner diameter of nozzle input
inlet_inner_diameter = 38;  // [1:300]

// Diameter of mounting holes/pins
mntholes_diameter = 4.2; // [0:10]

// Distance from centre of duct to centre of mounting holes/pins
mntholes_radius = 22.5;   // [0:400]

// Angles of mounting holes/pins around nozzle base
mntholes_angles = [-45,45 ]; 

// Length of optional mounting pins (0 for holes instead of pins)
pin_length = 10.5;  // [0:50]

/* [Hidden] */
$fn = 64;


*%translate([0,0,-11])
    import("40mm fan.stl");

module nozzle_outer_shape( r, h)
{
    linear_extrude(height=h)
        offset(r=nozzle_wall)
            scale( [ nozzle_scale, 1 / nozzle_scale, 1 ] )
                rotate( [ 0, 0, nozzle_edgerotate * (180 / nozzle_edges)] )
                    offset(r=nozzle_edgeradius)
                        circle(max(0.1,r-nozzle_edgeradius),$fn=nozzle_edges);

}


module nozzle_inner_shape(r, h)
{
    linear_extrude(height=h)
        scale( [ nozzle_scale, 1 / nozzle_scale, 1 ] )
            rotate( [ 0, 0, nozzle_edgerotate * (180 / nozzle_edges)] )
                offset(r=nozzle_edgeradius)
                    circle(max(0.1,r-nozzle_edgeradius),$fn=nozzle_edges);
}

difference() {
	union()	{
        // Base plate
        hull() {
            cylinder(d=inlet_inner_diameter+nozzle_wall*2,base_thickness,center=true);
            
            for ( a = mntholes_angles )
                rotate( [ 0, 0, a ] )
                    translate( [ mntholes_radius, 0, 0 ] )
                        cylinder( r = 4, h = base_thickness, center = true, $fn = 16 );
        }
        
        // Nozzle body
		hull() {
            translate([0,0,base_thickness/2])
                cylinder(d=inlet_inner_diameter+nozzle_wall*2, h = max(0.01,nozzle_extension));
            translate([0,0,(nozzle_extension+base_thickness/2)/2])
                rotate( [ 0, nozzle_tilt, 0 ] )
                    translate( [ 0, 0, nozzle_length ] )
                        rotate([0,nozzle_end_tilt,0])
                            nozzle_outer_shape( r = nozzle_dillation/2, h = 0.1);
		}
        
	}
    
    // Inlet hole
    cylinder(d=inlet_inner_diameter,h=base_thickness+0.1,center=true);

    // Mounting holes
	for ( a = mntholes_angles )
		rotate( [ 0, 0, a ] )
			translate( [ mntholes_radius, 0, 0 ] )
				cylinder( d = mntholes_diameter, h = base_thickness+0.05, center = true, $fn = 16 );

    // Nozzle interior
	hull(){
        translate([0,0,base_thickness/2])
            cylinder( d = inlet_inner_diameter, h = max(0.01,(nozzle_extension - nozzle_wall)) );
        translate([0,0,(nozzle_extension+base_thickness/2)/2])
            rotate( [ 0, nozzle_tilt, 0 ] )
                translate( [ 0, 0, nozzle_length ] )
                  rotate([0,nozzle_end_tilt,0])
                    nozzle_inner_shape( r = nozzle_dillation/2, h = 0.2 ); 
	}
}

// Mounting Pins
if (pin_length > 0 && base_thickness > 0) {
	for ( a = mntholes_angles )
		rotate( [ 0, 0, a ] )
			translate( [ mntholes_radius, 0, -pin_length/2 ] )
				cylinder( d = mntholes_diameter, h = base_thickness+pin_length, center = true, $fn = 16 );

}