epaisseur=3;
longueur_centre=50;
largeur_centre=10;
longueur_attache=20;
largeur_attache=20;
rayon=5;
profondeur_entaille=0;


eprouvette(epaisseur,longueur_centre,largeur_centre,longueur_attache,largeur_attache,rayon,profondeur_entaille);
$fa=0.5;
$fs=0.5;


module eprouvette(e=3, loc=50, lac=10, loa=20, laa=20, r=(largeur_attache-largeur_centre)/2, a=profondeur_entaille)
{
	difference()
	{
		translate([loa,laa/4,0])
		{
			union()
			{
				cube([loc, lac, e]);
				translate([-loa, -(laa-lac)/2,0])cube([loa, laa, e]);
				translate([loc, -(laa-lac)/2,0])cube([loa, laa, e]);
			}
			union()
			{
				translate([0,lac,0])difference(){conge(e,r); translate([0,(laa-lac)/2,0])cube([r-(laa-lac)/2,r-(laa-lac)/2,e]);}
				rotate([0,0,-90])difference(){conge(e,r); translate([(laa-lac)/2,0,0])cube([r-(laa-lac)/2,r-(laa-lac)/2,e]);}
				translate([loc,lac,0])rotate([0,0,90])difference(){conge(e,r); translate([(laa-lac)/2,0,0])cube([r-(laa-lac)/2,r-(laa-lac)/2,e]);}
				translate([loc,0,0])rotate([0,0,180])difference(){conge(e,r); translate([0,(laa-lac)/2,0])cube([r-(laa-lac)/2,r-(laa-lac)/2,e]);}
			}
		}

		translate([loa+loc/2+1,(laa-lac)/2-0.01,0])cube([2,a,e]);
		//translate([loa+loc/2+1,laa-((laa-lac)/2-0.01)-a,0])cube([2,a,e]);
	}
}

module conge(e=epaisseur,r=(largeur_attache-largeur_centre)/2)
{
	difference()
	{
		cube([r,r,e]);
		translate([r+0.01,r+0.01,0-0.01])cylinder(e+0.02,r+0.01,r+0.01);
	}
}
