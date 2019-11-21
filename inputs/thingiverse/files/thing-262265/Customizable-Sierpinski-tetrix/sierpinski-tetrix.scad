/**
 * sierpinski-triangle.scad: Recursively defined Sierpinksi tetrahedron.
 **
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// Original by Chris Granade (cgranade)
//  http://www.thingiverse.com/thing:187131
//
// Modified by Bill Owens, February 2014
//  - added external support to allow clean printing on a fused-filament printer

// for Thingiverse Customizer

/* Global */

// Order/level of the Sierpinski tetrix
order=3; // [0,1,2,3,4]

// Size of the tetrix (edge length) in mm
size=80;

// Adjustment to the size of the tetrahedra to allow for some adhesion between them
adhesion=0.25;

// Intersection between the support and the tetrix - larger makes more solid support, but harder to remove
stick=0.005;


TETRA_POINTS = [
    [1/sqrt(3), 0, 0],
    [-1/(2*sqrt(3)), 1/2, 0],
    [-1/(2*sqrt(3)), -1/2, 0],
    [0, 0, sqrt(2/3)]
];

module tetra() {
    polyhedron(
        points=TETRA_POINTS,
        triangles=[
            [0, 1, 2],
            [2, 1, 3],
            [0, 2, 3],
            [0, 3, 1]
    ]);
}

module sier(n, overscale=0.2) {
    if (n == 0) {
        scale(1 + overscale)
        tetra();
    } else {
        for (pt = TETRA_POINTS) {
            translate(pow(2, n - 1) * pt)
            sier(n - 1, overscale);
        }
    }
}

module support(s) {
	difference() {
		cylinder(r1=s/sqrt(2), r2=0, h=s, $fn=36);
		difference() {
			cube(size=[s*3,s*3,s*2], center=true);
			translate([-s,0,0]) cube(size=[s*2,s*.1,s*2], center=true);
		}
		translate([0,0,s*1.3]) cube(size=[s*5,s*5,s], center=true);
	}
}
	
scale(size) 
  union() { 		
	difference() {
	rotate([180,0,0]) translate([0,0,-sqrt(2/3)*(1+(adhesion/pow(2,order)))+stick]) scale(1/pow(2,order)) sier(order, overscale=adhesion);			// the tetrix itself
	translate([0,0,-1]) cube(size=[2,2,2], center=true);	// trim anything below Z=0
	}
	difference() {										// the support structure
		union() {
			translate([1/sqrt(2),0,0]) support(1);
			rotate([0,0,120]) translate([1/sqrt(2),0,0]) support(1);
			rotate([0,0,-120]) translate([1/sqrt(2),0,0]) support(1);
		}
		rotate([0,20,180]) translate([1/2*1.03,0,1/3]) cube(size=[1,0.05,1], center=true);
		rotate([0,20,300]) translate([1/2*1.03,0,1/3]) cube(size=[1,0.05,1], center=true);
		rotate([0,20,-300]) translate([1/2*1.03,0,1/3]) cube(size=[1,0.05,1], center=true);
	}
 
}
