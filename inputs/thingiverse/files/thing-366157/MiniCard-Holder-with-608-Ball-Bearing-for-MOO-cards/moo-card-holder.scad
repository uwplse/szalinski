/* Card holder for "Moo"-style mini-cards.
** Somewhat parametric, so other card sizes can be supported.
** Inspired by the official moo card holder.
**
** Version 1.2, 2014-07-02
**
** Copyright 20014 Robert Quattlebaum.
** All rights Reserved.
**
** Released under the Attribution-NonCommercial 4.0 International License
** http://creativecommons.org/licenses/by-nc/4.0/
**
** Please contact me for commercial use. <darco@deepdarc.com>
*/

//part = "presentation";
part = "both"; // [both, top, bottom]
//part = "exploded";
//part = "intersection";
//part = "top";
//part = "bottom";
//$t=0.5;

lidText = "";

// Can't be lower than bearingHeight/cardThickness, or 14 for the default bearing.
cardCapacity = 20;

// In millimeters (Default is for MOO MiniCards)
cardHeight = 28.5;

// In millimeters (Default is for MOO MiniCards)
cardWidth = 70.75;

// In millimeters (Default is for MOO MiniCards)
cardThickness = 0.5;

// How thick should the walls be?
wallThickness = 1.2;

// In millimeters
bearingOuterDiameter=22.2;

// In millimeters
bearingInnerDiameter=8;

// In millimeters
bearingHeight=7;

$fs=0.1;
$fa=3;

if(bearingHeight/cardThickness > cardCapacity) {
	echo("ERROR: Card capacity too low! Max is ", bearingHeight/cardThickness);
}

if(part=="presentation") {
	SlideCardHolder(part_index=1);
	SlideCardHolder(part_index=2);
	color([0.8,0.8,0.8,0.5])
	SlideCardHolder(part_index=3);
} else if(part=="top") {
	SlideCardHolder(part_index=2, flipped=true);
} else if(part=="bottom") {
	SlideCardHolder(part_index=1);
} else if(part=="both") {
	assign($t = 0) {
	translate([00,-20,00])SlideCardHolder(part_index=1);
	translate([00, 20,00])SlideCardHolder(part_index=2, flipped=true);
	}
} else if(part=="intersection") {
	%SlideCardHolder(part_index=0);
	render()
	union() {
		intersection() {
			SlideCardHolder(part_index=1);
			SlideCardHolder(part_index=2);
		}
		intersection() {
			union() {
				SlideCardHolder(part_index=1);
				SlideCardHolder(part_index=2);
			}
			SlideCardHolder(part_index=3);
		}
	}
} else if(part=="exploded") {
	assign($t = 0) {
	translate([00,0,00])SlideCardHolder(part_index=1);
	translate([00,0,25])SlideCardHolder(part_index=2);
	color([0.8,0.8,0.8,0.5])
	translate([0,0,50])bearing_608();
	}
}

module printLidText(thisText="OpenSCAD Rocks!",h=1,thisFont=8bit_polyfont(),center=true)
{
	// Find one letter matches from 2nd column (index 1)
	theseIndicies=search(thisText,thisFont[2],1,1);
	// Letter spacing, x direction.
	x_shift=thisFont[0][0];
	y_shift=thisFont[0][1];
	x_offset = (center==true)?-len(theseIndicies)*x_shift/2:0;
	y_offset = (center==true)?-y_shift/2:0;
	// Simple polygon usage.
	linear_extrude(height=h)for(i=[0:len(theseIndicies)-1])
		translate([i*x_shift+x_offset,y_offset]) {
			polygon(
				points=thisFont[2][theseIndicies[i]][6][0],
				paths=thisFont[2][theseIndicies[i]][6][1]
			);
		}
}


module bearing_608()
{
	render() union() {
		difference() {
			cylinder(h=bearingHeight, d=bearingOuterDiameter);
			cylinder(h=bearingHeight+1, d=bearingOuterDiameter-2);
		}
		difference() {
			union() {
				cylinder(h=bearingHeight, d=bearingInnerDiameter+2);
				translate([0,0,1])cylinder(h=bearingHeight-2, d=bearingOuterDiameter);
			}
			cylinder(h=bearingHeight+1, d=bearingInnerDiameter);
		}
	}
}

module rcube(Size=[20,20,20],b=2,center=false)
{
	translate((center==false)?[Size[0]/2,Size[1]/2,Size[2]/2]:[0,0,0])
	hull() {
		for(x=[-(Size[0]/2-b),(Size[0]/2-b)]) {
			for(y=[-(Size[1]/2-b),(Size[1]/2-b)]) {
				for(z=[-(Size[2]/2-b),(Size[2]/2-b)]) {
					translate([x,y,z])
						sphere(r=b, $fa=$fa*5);
				}
			}
		}
	}
}


module rcylinder(h=10,r1=10,r2=10,b=2,center=false)
{

	translate([0,0,(center==true)?-h/2:0]) {
		rotate_extrude()
		hull() {
			translate([r1-b,   b, 0]) circle(r = b, $fa=$fa*5);
			translate([r2-b, h-b, 0]) circle(r = b, $fa=$fa*5);
			square([r1-b,b]);
			translate([0, h-b, 0])
			square([r2-b,b]);
		}
	}
}

module inv_minkowski() {
	render()
	difference() {
		child(0);
		minkowski() {
			difference() {
				cube([1000000000,1000000000,1000000000],center=true);
				child(0);
			}
			child(1);
		}
	}
}

module round_edges(r=3) {
	minkowski() {
		inv_minkowski() {
			child(0);
			sphere(r);
		}
		sphere(r);
	}
}

module hollow() {
	difference() {
		child(0);
		inv_minkowski() {
			child(0);
			child(1);
		}
	}
}

use <MCAD/fonts.scad>

module SlideCardHolder(
	tol = 0.2,
	part_index = 0,
	lidText = lidText,
	flipped = false
) {

	thisFont=8bit_polyfont();

	hingeRadius = bearingInnerDiameter/2;
	rampAngle = 60;
	cardDepth = cardThickness*cardCapacity;
	rampWidth = cardDepth/tan(rampAngle);
	notchSize = 1.1;
	bearingRadius = bearingOuterDiameter/2;
	lidThickness = wallThickness*2;
	lipDepth = 2.5;
	hingeSpace = bearingRadius + wallThickness*2;
	boxHeight = cardThickness*cardCapacity + wallThickness + lidThickness + tol;
	curveCompensation = 2.1; // TODO: Calculate this automatically!

	outerRadius = cardWidth + hingeSpace + rampWidth + curveCompensation + wallThickness*2 + lidThickness + tol;

	module CardVolume() {
		translate(
			[	hingeSpace + wallThickness,
				-cardHeight/2,
				wallThickness,
			]
		)
		cube ([cardWidth,cardHeight,cardThickness*cardCapacity]);
	}

	module HingeClip() {
		translate([0,0,wallThickness])
		difference() {
			union() {
				cylinder(h=boxHeight-wallThickness,r1=hingeRadius,r2=hingeRadius-tol/2);
/*
				translate([0,0,boxHeight-1-wallThickness])
				intersection() {
					cylinder(h=1, r1=hingeRadius-tol/2,r2=hingeRadius-tol/2+1);
					cylinder(h=1, r2=hingeRadius-tol/2,r1=hingeRadius-tol/2+1);
				}
*/
			}
/*
			union () {
				cylinder(h=boxHeight,r=hingeRadius-1.2);
				cube([0.8,cardWidth,cardDepth*5],center=true);
				cube([cardWidth,0.8,cardDepth*5],center=true);
			}
*/
		}
		cylinder(h=boxHeight-bearingHeight,r=hingeRadius+2);
	}

	hingeClearance=1.0;

	module InnerBoxVolume() {
		difference() {
			union() {
				translate([0,0,boxHeight-bearingHeight-hingeClearance])
				cylinder(h = bearingHeight-lidThickness+hingeClearance-tol/2, r = bearingRadius+wallThickness+hingeClearance);
				intersection() {
					cylinder(
						r = outerRadius - wallThickness - lidThickness - tol,
						h = cardThickness*cardCapacity *2
					);
					translate(
						[	hingeSpace,
							-0.5*(cardHeight),
							wallThickness,
						]
					)
						cube (
							[	cardWidth*2,
								cardHeight,
								cardThickness*cardCapacity,
							]
						);
				}
			}
			translate([cardWidth+hingeSpace+wallThickness,cardHeight,wallThickness])
				rotate([90,0,0])linear_extrude(cardHeight*2)
					polygon([
						[0,0],
						[rampWidth+curveCompensation,0],
						[rampWidth+curveCompensation,cardThickness*cardCapacity],
						[rampWidth,cardThickness*cardCapacity]
					]);
			translate(
				[	hingeSpace,
					-cardHeight,
					wallThickness,
				]
			)
				cube (
					[	wallThickness,
						cardHeight*2,
						cardThickness*cardCapacity,
					]
				);
		}
	}

	module BoxVolume() {
		hull() {
			rcylinder(h = boxHeight, r1 = 0.5*(cardHeight + wallThickness*2), r2 = 0.5*(cardHeight + wallThickness*2));
			intersection() {
				rcylinder(
					r1 = outerRadius,
					r2 = outerRadius,
					h = boxHeight,
					b = 3
				);
				translate(
					[	0,//-hingeSpace - wallThickness,
						-0.5*(cardHeight + wallThickness*2),
						0,
					]
				)
				rcube (
					[	cardWidth*2,
						cardHeight + wallThickness*2,
						boxHeight,
					]
				);
			}
		}
	}

	module BoxShell() {
		difference() {
			BoxVolume();
			InnerBoxVolume();
		}
	}

	// This object is used to separate the top half from the bottom half.
	module PartSeparator(dialation) {
		difference() {
			scale([1.0,1.0+dialation*1.5,1.0])
			union() {
				if(dialation<0) {
					translate([outerRadius - lidThickness-curveCompensation-wallThickness*3/4,0,cardThickness*cardCapacity + wallThickness/2+tol + dialation])scale([wallThickness,cardHeight + wallThickness*2,wallThickness])sphere(d=1/*,$fa=10*/);
				}
				translate([0, 0, wallThickness])
				rcylinder(
					h = cardThickness*cardCapacity + dialation,
					r1 = outerRadius - lidThickness + dialation,
					r2 = outerRadius - lidThickness + dialation,
					center = false
				);
				cylinder(
					h = wallThickness + cardThickness*cardCapacity/2,
					r = outerRadius - lidThickness + wallThickness - lipDepth + dialation*0.25,
					center = false
				);
			}
			translate([outerRadius - lidThickness + min(0,dialation), 0, 0])
			cylinder(h=cardThickness*cardCapacity + lidThickness + dialation,d=notchSize);
/*
			rotate([0,0,45])
			translate([-notchSize/2, -notchSize/2, 0])
			cube([notchSize,notchSize,cardThickness*cardCapacity + lidThickness + dialation]);
*/
		}
	}

	module Base() {
		difference() {
			union() {
				intersection() {
					BoxShell();
					PartSeparator(-tol/2);
				}
				HingeClip();
			}
			// Lanyard hole
			cylinder(h = boxHeight+1, r = hingeRadius-wallThickness);
			cylinder(h = wallThickness*2, r1 = hingeRadius, r2=hingeRadius-wallThickness);
		}
	}

	module Lid() {
		difference() {
			union() {
				difference() {
					BoxShell();
					PartSeparator(tol/2);
				}
				// Bearing sleeve
				translate([0,0,boxHeight-bearingHeight])
				cylinder(h = bearingHeight, r = bearingRadius+wallThickness-tol/2);
			}

			// Bearing cavity
			cylinder(h = boxHeight+1.0, r = bearingRadius);

			// Embossed text
			translate([
				hingeSpace-wallThickness+(cardWidth + rampWidth + curveCompensation)/2,
				0,
				boxHeight-0.5
			]) printLidText(lidText,h=5);
		}
	}

	translate([0,0,(flipped==true)?boxHeight:0]) rotate([(flipped==true)?180:0,0,0]) union() {
		if ((part_index == 0) || (part_index == 1)) {
			render() Base();
		}
		if ((part_index == 0) || (part_index == 2)) {
			rotate([0,0,$t*25]) render() Lid();
		}
		if ((part_index == 0) || (part_index == 3)) {
			translate([0,0,boxHeight-bearingHeight]) bearing_608();
		}
	}
}

