// Set lenght of the legs in mm
lengte = 30;

// Set size of inner dimension in mm
binnenzijde = 7.5;

// Set size of outer dimension in mm
buitenzijde = 10;

// Set size of wall thickness in mm
wand = 1;

// Set height of break lines in mm
hulplijn = 0.5;

// Set variant
variant = 5; // [1:End Piece, 2:Extension, 3:Corner, 4:T, 5:Cross]

module poot(l, b, h)
{
	cube([l,b,b]);
	color("blue")translate([0,-h,b/2-h/2]) cube([l,b+h*2,0.5]);

}

color("red")cube(buitenzijde+0.01);
translate([buitenzijde,(buitenzijde-binnenzijde)/2,(buitenzijde-binnenzijde)/2])poot(lengte, binnenzijde, hulplijn);

if (variant > 2)
{
	translate([10 - (buitenzijde-binnenzijde)/2,buitenzijde,(buitenzijde-binnenzijde)/2])rotate([0,0,90])poot(lengte, binnenzijde, hulplijn);
}

if (variant == 2 || variant > 3)
{
	translate([-lengte,(buitenzijde-binnenzijde)/2,(buitenzijde-binnenzijde)/2])poot(lengte, binnenzijde, hulplijn);
}

if (variant == 5)
{
	translate([10 - (buitenzijde-binnenzijde)/2,-lengte,(buitenzijde-binnenzijde)/2])rotate([0,0,90])poot(lengte, binnenzijde, hulplijn);
}