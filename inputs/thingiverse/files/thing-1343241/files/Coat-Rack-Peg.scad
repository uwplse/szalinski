/**
 * Customizable coat rack pegs that fit into holes in the rack.
 */

// The depth of the hole that the peg fits into.
hole_depth = 12;

// The diameter of the hole that the peg fits into.
hole_diameter = 12.5;

// The total length of the visible portion of the peg.
peg_length = 50;

module coat_rack_peg(hole_depth=12, hole_diameter=12.5, peg_length=50) {
	$fs = 1;
	$fa = 1;

	p0=[hole_diameter / 2 * 1.1,0];
	p1=[hole_diameter / 2 * .5, ( peg_length / 2 )];
	p2=[hole_diameter / 2 * .5, peg_length];

	difference() {
	    cylinder(r1=hole_diameter / 2 * .95, r2 = hole_diameter / 2 * 1.1, h = hole_depth);
	    cylinder(r=1.5, h=hole_depth);
	}

	translate([0, 0, hole_depth]) {
	    translate([0, 0, peg_length]) sphere(r=hole_diameter / 2);
	}

	translate([0, 0, hole_depth]) {
	    bezier_solid( p0, p1, p2, steps=20);
	    translate([0, 0, peg_length]) sphere(r=hole_diameter / 2);
	}
}

module bezier_solid( p0, p1, p2, steps = 5 ) {
    stepsize1 = (p1-p0)/steps;
    stepsize2 = (p2-p1)/steps;
    
    rotate_extrude() {
        for (i=[0:steps-1]) {
            point1 = p0+stepsize1*i;
            point2 = p1+stepsize2*i;
            point3 = p0+stepsize1*(i+1);
            point4 = p1+stepsize2*(i+1);
            bpoint1 = point1+(point2-point1)*(i/steps);
            bpoint2 = point3+(point4-point3)*((i+1)/steps);
            polygon(
                points=[
                   [0, bpoint1[1]],
                   bpoint1,
                   bpoint2,
                   [0, bpoint2[1]]
                ]
            );
        }
    }
}

coat_rack_peg(hole_depth=hole_depth, hole_diameter=hole_diameter, peg_length=peg_length);