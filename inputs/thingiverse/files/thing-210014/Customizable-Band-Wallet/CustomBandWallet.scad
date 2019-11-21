// Customizable Card Holder

// Inspired by http://www.thingiverse.com/thing:50752. But reimplemented
// to be customizable (AKA parametric) so contactinfo can be embedded into the wallet.

// All code (c) Laird Popkin, 2013.

use <write/Write.scad>;

/* [Personalize] */

// Name (this line is larger)
FL1 = "Your Name";
// line 2
FL2 = "email: name@domain.com";
// Line 3
FL3 = "cell: 999/999-9999";
// Back line 1
BL1 = "If Found, Please Mail to:";
// Line 2
BL2 = "1 Awesome Street";
// Line 3
BL3 = "Cooltown, FL 33067";
// Edge margins
margin = 5;
// Wallet thickness (mm)
thickness = 1.5;
// Hub radius
hubR = 5;
// Hub height
hubH = 2;
// Band Height
bandH = 10;

/* [Hidden] */
// Card dimensions
cardLen = 85.60 + margin;
cardWidth = 53.98 + margin;
gap = 0.01; // to avoid parallel faces
echo(cardLen, cardWidth, gap, margin);
notchR = 10;
notchDepth = margin*1.5;
hubY=cardWidth/2-hubR-bandH/2;

// shape of wallet faces
module shape() {
	difference() {
		cube([cardLen, cardWidth, thickness]);
		// cut out notches on the ends for the bands
		translate([0,cardWidth/2,thickness/2-1])
			cube(size=[margin+gap,bandH,3+thickness], center=true);
		translate([cardLen,cardWidth/2,thickness/2-1])
			cube(size=[margin+gap,bandH,3+thickness], center=true);
		// cut out notch at bottom for pushing cards out
		translate([(cardLen-2*bandH)/4,-notchR+notchDepth, -1])
			cylinder(r=notchR, h=thickness+2);
		// band guides
		translate([cardLen/2, cardWidth/2, thickness])
			cube([cardLen,bandH,0.5], center=true);
		translate([cardLen/2+hubR+bandH/2,
				cardWidth/4-gap-hubR/2,thickness])
			cube([bandH,cardWidth/2-hubR+1,0.5], center=true);
		translate([cardLen/2-hubR-bandH/2,
				cardWidth/4-gap-hubR/2,thickness])
			cube([bandH,cardWidth/2-hubR+1,0.5], center=true);
		}
	translate([cardLen/2,hubY,thickness-gap])
		cylinder(r1=hubR, r2=hubR+hubH, h=hubH); // 45 degree angle out
	}

// write text onto wallet
module face(line1, line2, line3, scale, mirror) {
	shape();
	color("black") {
		translate([cardLen/2,cardWidth*.9,thickness]) mirror([mirror,0,0])
			scale([scale,scale,scale]) write(line1, center=true);
		translate([cardLen/2,cardWidth*.75,thickness]) mirror([mirror,0,0])
			write(line2, center=true);
		translate([cardLen/2,cardWidth*.65,thickness]) mirror([mirror,0,0])
			write(line3, center=true);
		}
	}

translate([0,5,0]) {
	face(FL1, FL2, FL3, 2, 0);
	}
mirror([0,1,0]) translate([0,5,0]) face(BL1, BL2, BL3, 1, 1);