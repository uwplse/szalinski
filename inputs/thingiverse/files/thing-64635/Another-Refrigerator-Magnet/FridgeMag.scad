// Refrigerator Magnet.  
// Uses a neodymium disk magnet.
// Tapered 60 degrees towards magnetic side so it's easy to remove.
//
// Magnet socket is a hair deeper to allow for a drop of glue
//
//  Mooselake 21 Mar 2013
//

// Magnet Diameter
Dmagnet = 10.0;

// Magnet Thickness
Hmagnet = 2.5;

// Top Diameter of holder (out side)
Dtop = 22;

// Bottom Diameter of holder (Refrigerator side), must be bigger than magnet.
Dbot = 16;


// Thickness of holder
Hholder = 6;


Rmagnet = Dmagnet/2;
Rbot    = Dbot/2;
Rtop    = Dtop/2;

// print upside down, magnet cutout on top

difference() {
	cylinder(h = Hholder, r1 = Rtop, r2 = Rbot);		// holder
	translate([0,0,Hholder-Hmagnet-0.1])
		cylinder(h=Hmagnet+0.1, r=Rmagnet);			// magnet hole
	translate([0,0,Hholder-(Hmagnet*0.25)])
		cylinder(h=1, r1=Rmagnet*0.98, r2=Rmagnet*1.07);  // chamfered for easy insertion
	}