/*----------------------------------------------------------------------------
 * Customisable three-armed spool holder for samples.
 * Created by FeNi64
 * Version 2.0, 2018-03-28
 * Inspired by https://www.thingiverse.com/thing:2033513
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License,
 * LGPL version 2.1, or (at your option) any later version of the GPL.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 *		2018. License, GPL v2 or later
 *----------------------------------------------------------------------------*/

// Display which part(s)?
show=1; //  [1:Hub,2:Arm,3:All]

// Hub hole diameter
hole_d=33; // [5:90]

// Width of hub disc
hub_w=20;  // [10:99]

//  Height of hub wall
hubwall=15; // [10:99]

// Length and diameter of arms.
arc_d=30; // [10:99]

// Diameter of the spool of filament (arms start here)
outer=140; // [50:200]

// Thickness of most things
wall=1.2; // [1:0.1:5]

// Number of arms
armcount=3; // [3:9]

// Filament diameter
filament_d=1.75; // [1.75:2,3.00:3.25]



/* [Hidden] */
M3=3.2;
$fn=60;
armangle=360/armcount;
arm_l=(outer-hole_d-2*hubwall)/2;

if (show==1) {
	Hub();
} else if(show==2) {
	translate([0,5,0])arm();
} else if (show==3) {
	//color("blue")
	Hub();
	for(a=[0:armangle:360]) {
		rotate([0,0,a]) 
			translate([hole_d/2+wall+(hubwall-wall)/2,wall/2,(hubwall-wall)/2+wall+0.5]) rotate([90,0,0])
			arm() ;
	}
}



module Hub() {
	difference() {
		union() {
			cylinder(h=wall,d=hole_d+hub_w);
			cylinder(h=hubwall,d=hole_d + 2 * wall);

			for(a=[0:armangle:360]) {
				rotate([0,0,a]) 
					translate([hole_d/2,-5*wall/2,0])
					difference() {
						cube([hubwall,7*wall,hubwall]);
						translate([-1,3*wall-1,-1])cube([hubwall+wall,wall+2,hubwall+2]);
						// Minus the hole for the M3 bolt.
						translate([hubwall/2+wall,5*hubwall,hubwall/2+wall])rotate([90,0,0]) cylinder(h=10*hubwall,d=M3);

					}
			}

		}
		translate([0,0,-25]) cylinder(h=wall+50,d=hole_d);
	}
}

module arm() {
	// The straight bit
	difference() {
		hull() {
			cylinder(h=2*wall,d=hubwall-wall-1);
			translate([arm_l,-(hubwall-wall)/2,0])cube([2*wall,hubwall-wall,2*wall]);
		}
		// Minus the hole for the M3 bolt.
		translate([0,0,-hubwall]) cylinder(h=2*hubwall,d=M3);

		// Some filament-end holes, at an angle so it bites.
		rotate([45,0,0])translate([arm_l*8/10,0,-10])cylinder(h=wall+30,d=filament_d);
	}
	// The curved bit
	x=arm_l+arc_d-2*wall; // Place it such that the inside arc touches the arm's end.
	translate([x,0,-(hubwall-wall)/3])rotate([0,0,0])scale([2.0,1.0,1.0]) arc(2*wall,hubwall-wall,arc_d/2,180);
}

/* module arc()
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 */

module arc( height, depth, radius, degrees ) {
	// This dies a horible death if it's not rendered here 
	// -- sucks up all memory and spins out of control 
	render() {
		difference() {
			// Outer ring
			rotate_extrude($fn = 100)
				translate([radius - height, 0, 0])
				square([height,depth]);

			// Cut half off
			translate([0,-(radius+1),-.5]) 
				cube ([radius+1,(radius+1)*2,depth+1]);

			// Cover the other half as necessary
			rotate([0,0,180-degrees])
				translate([0,-(radius+1),-.5]) 
				cube ([radius+1,(radius+1)*2,depth+1]);

		}
	}
}
