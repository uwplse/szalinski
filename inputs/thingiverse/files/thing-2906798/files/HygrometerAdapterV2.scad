/*----------------------------------------------------------------------------
 * Customisable holder for a hygrometer bought from eBay.
 * Created by FeNi64
 * Version 2.0, 2018-05-10
 * Inspired by https://www.thingiverse.com/thing:2429114
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

// Mount a hygrometer into the hole for a filament spool

// Styles: 1: A cylinder into the smaller spool_d (Cocoon spools)
//         2: A cylinder into the larger spool_d, with cutouts for the spokes between that and the smaller spool_d (Cocoon spool have this)
//	   3: A flat front for the hygrometer to fit inside the larger spool_d (e.g. MasterSpool)
//	   4: Spans the spool edge, with a flat front (so the spools can stack sideways and it won't extend outside of spool).
//         5: Like 4, but it's a one sided clip, and the other is just a flat top panel. Will stack less well.
style=5;  // [1:Pipes for meter and spool,  2: Spoke-style into spool hole, 3: Front-panel (meter fits into spool hole) 4: Two-edge mounted, 5: One-edge mounted]

// Depth into the spool 
spool_h=10;
// Inside diameter of spool hole (Cocoon: 32, MasterSpool: 52.5)
spool_d=32;// [32-99]
// Inside width of spool hole, for edge-mount style
spool_wi=46;  // [32-99]
// Outside width of spool, for edge-mount style. There's a 1mm grip on each outside, grip_h tall.
spool_wo=65.5; // [32-99]
// Diameter of spool, so we can get the right roundness.
spool3_d=202;  // [150-250]
// Height of the 'edge' on the spool, so we can grip around it.
grip_h=7;

clip_inner=2; // Inner wall of one-sided clip has this gap for the edge to clip into.

// Meter body outside diameter
meter_d=42.5;
// Height of meter body
meter_h=15.0;
// The meter has grips which turn inward 4mm from the inside front edge.
meter2_h=4;
// Cocoon spool is 202mm diameter, 53-65mm wide, have a 2.5mm wall with a 4.5mm thick edge to it, 7mm tall edge.

// Everything is this thick
thickness=1.6; // [0.5-3.0]

/* [Hidden] */
// Angle of the holes on the spoke-style mount.
armangle=45; // There are eight spokes
$fn=120;
ArcWidth=28; // Should really be calculated from the angle of the meter hole plus a bit for surrounds.

if (style == 1) {

    // Cylinder into the 32mm spool
    difference() {
	cylinder(h=spool_h+1,d=spool_d);
	translate([0,0,-1])cylinder(h=spool_h+3,d=spool_d-thickness*2);
    }

    // The interface between the two.
    translate([0,0,spool_h]) difference() {
	cylinder(h=1,d=max(spool_d,meter_d));
	translate([0,0,-1]) cylinder(h=3,d=min(spool_d-thickness*2,meter_d+thickness*2));
    }

    // Where the meter fits.
    translate([0,0,spool_h]) difference() {
	cylinder(h=meter_h,d=meter_d+thickness*2);
	translate([0,0,-1])cylinder(h=meter_h+2,d=meter_d);
    }
} else if (style == 2) {

    // A 'claw' into the larger spool, to fit both MasterSpool and the other spools.
    difference() {
	cylinder(h=spool_h+1,d=spool_d);
	translate([0,0,-1])cylinder(h=spool_h+3,d=spool_d-thickness*2);

	// Minus some holes for the spool spokes
	for(a=[0:armangle:360]) {
	    rotate([0,0,a]) translate([0,-(spool_d+1)/2,-1]) {
		translate([-0.2,0,0])cube([2,spool_d+1,spool_h+1]);
	    }
	}

    }



    // The interface between the two.
    translate([0,0,spool_h]) difference() {
	cylinder(h=1,d=max(spool_d,meter_d));
	translate([0,0,-1]) cylinder(h=3,d=min(spool_d-thickness*2,meter_d+thickness*2));
    }

    // Where the meter fits.
    translate([0,0,spool_h]) difference() {
	cylinder(h=meter_h,d=meter_d+thickness*2);
	translate([0,0,-1])cylinder(h=meter_h+2,d=meter_d);
    }
} else if (style == 3) {
    // A flat front into the 52.5mm spool
    // (52.5mm + 4mm front piece, meter_d hole in a 52.5mm (OD) cylinder.
    if (spool_d < meter_d) {
	echo ("Cannot fit meter into spool hole");
    } else {
	difference() {
	    union() {
		cylinder(h=1,d=spool_d+4);
		cylinder(h=meter2_h,d=spool_d);
	    }
	    translate([0,0,-1]) cylinder(h=spool_h+2,d=meter_d);
	}
    }
} else if (style == 4) {
    // Show spool, during development (remove the 'translate and rotate' from the part below)
    if (0 == 1) {
	%union() {
	    difference() {
		cylinder(h=spool_wo,d=spool3_d);
		translate([0,0,(spool_wo-spool_wi)/2]) cylinder(h=spool_wi,d=spool3_d+1);

		translate([0,0,-0.1]) cylinder(h=1,d=spool3_d - grip_h);
		translate([0,0,spool_wo-1+0.1]) cylinder(h=1,d=spool3_d - grip_h);
	    }
	    cylinder(h=spool_wo,d=spool_d);
	}
    }

    translate([0,0,100])rotate([90,-ArcWidth/2,0]) {
	difference() {
	    union() {
		// The main body
		translate([0,0,-thickness])arc(2*thickness + grip_h,spool_wo+2*thickness,spool3_d/2 + thickness,ArcWidth);
		// A front panel for the meter.
		rotate([90,0,-ArcWidth/2]) translate([0,(spool_wo)/2,spool3_d/2-meter_h/2+6.5])cylinder(h=3,d=meter_d+5);
	    }

	    // Room for the spool
	    translate([0,0,(spool_wo-spool_wi-5)/2-6]) arc(2*thickness + grip_h,spool_wo-3,spool3_d/2 ,ArcWidth);

	    // Minus a gap around the spool edge
	    translate([0,0,(spool_wo-spool_wi)/2-9.5]) arc(grip_h,spool_wo,spool3_d/2,meter_d+0);

	    // Minus a hole for the meter.
	    rotate([90,0,-ArcWidth/2]) translate([0,(spool_wo)/2,spool3_d/2-meter_h/1])cylinder(h=2*meter_h,d=meter_d);
	}
    }

} else if (style == 5) {
    // Show spool, during development (remove the 'translate and rotate' from the part below)
    if (0 == 1) {
	%union() {
	    difference() {
		cylinder(h=spool_wo,d=spool3_d);
		translate([0,0,(spool_wo-spool_wi)/2]) cylinder(h=spool_wi,d=spool3_d+1);

		translate([0,0,-0.1]) cylinder(h=1,d=spool3_d - grip_h);
		translate([0,0,spool_wo-1+0.1]) cylinder(h=1,d=spool3_d - grip_h);
	    }
	    cylinder(h=spool_wo,d=spool_d);
	}
    }

    translate([0,0,100])rotate([90,-ArcWidth/2,0]) {
	union() {
	    difference() {
		union() {
		    // The main body
		    translate([0,0,-thickness])arc(2*thickness + grip_h,spool_wo+2*thickness,spool3_d/2 + thickness,ArcWidth);
		    // A front panel for the meter.
		    rotate([90,0,-ArcWidth/2]) translate([0,(spool_wo)/2-4.0,spool3_d/2-meter_h/2+6.5])cylinder(h=3,d=meter_d+5,$fn=30);
		}

		// Room for the spool
		translate([0,0,(spool_wo-spool_wi-5)/2-6]) rotate([0,0,+1]) arc(2*thickness + grip_h,spool_wo-3,spool3_d/2 ,ArcWidth+2);

		// Minus a gap around the spool edge
		translate([0,0,(spool_wo-spool_wi)/2-10 ]) rotate([0,0,+1]) arc(grip_h,spool_wo,spool3_d/2,ArcWidth+2);
		// One edge has no grip.
		translate([0,0,(spool_wo-spool_wi)/2-0.5]) rotate([0,0,+1]) arc(grip_h+5,spool_wo,spool3_d/2,ArcWidth+2);

		// Minus a hole for the meter.
		// Should replace 'ArcWidth/2 degrees' with some calculation on the arc size
		rotate([90,0,-ArcWidth/2]) translate([0,(spool_wo)/2-4.0,spool3_d/2-meter_h/1])cylinder(h=2*meter_h,d=meter_d,$fn=30);

	    }

	    // Put back an inner edge for the one-sided grip. (5.5mm from the inside of the grip, so there's a 4.5mm gap between this wall and the grip finger.
	    translate([0,0,0.3 + 5.0]) rotate([0,0,-(ArcWidth-10)/2]) arc(grip_h-3,2,spool3_d/2,10);
	}
    }

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
