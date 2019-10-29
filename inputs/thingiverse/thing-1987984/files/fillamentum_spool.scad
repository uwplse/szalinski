/* Domecek pro lozisko spulky fillamentu
Blind Pew <blind.pew96@gmail.com>
GNU v3
*/

module rolna() {
	$fn = 50;
	spulka_prumer = 52.5; //diameter
	spulka_vyska = 18; //height
	//rozmery pro lozisko 6203
	loz_vnejsi = 40; //external diameter bearing
	loz_vyska = 14; //height bearing
	loz_vnitr = 16.8; //internal diameter bearing
	dira = 6.5; //hole
	hrana = 2;

	difference() {
		union() {
			cylinder(d = spulka_prumer, h = spulka_vyska, center = true);
			translate([0,0,-((spulka_vyska-hrana)/2)])			
				cylinder(d = spulka_prumer+5, h = hrana, center = true);
		}
		translate([0,0,-((spulka_vyska-loz_vyska)/2)])
			cylinder(d = loz_vnejsi, h = loz_vyska, center = true);
		cylinder(d = loz_vnejsi-hrana*2, h = spulka_vyska, center = true);
		cylinder(d = dira, h = spulka_vyska, center = true);
	}
	translate([0,0,-((spulka_vyska-loz_vyska)/2)])
		difference() {
			union() {
				cylinder(d = loz_vnitr, h = loz_vyska, center = true);
				translate([0,0,-((loz_vyska-hrana)/2)])
					cylinder(d = loz_vnitr+5, h = hrana, center = true);
			}
			cylinder(d = dira, h = loz_vyska, center = true);
		}
}
rolna();
