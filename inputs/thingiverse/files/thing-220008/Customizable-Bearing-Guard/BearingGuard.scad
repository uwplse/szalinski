// Bearing guard printer

// Radius of inside of bearing
ir=4.6875;
// Race depth
race=2;
rr=ir+race;
// Guard radius (could be bearing size, or more if you like.
or=12.5;
// Thickness of guard
h=1;
// Thickness of race
raceH = 0.5;
h2=h+raceH;

difference() {
	union() {
		cylinder(r=rr, h=h2);
		cylinder(r=or, h=h);
		}
	cylinder(r=ir+.5, h=h2);
	}