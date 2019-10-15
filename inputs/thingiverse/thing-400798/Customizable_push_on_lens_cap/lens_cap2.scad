//Parameterised push on lens cap
// Glyn Cowles July 2014
// Added option to have a place for a tether
// Scott Hergott September 2014

//Thickness of sides
thickness=1;//[1:5] 
//Inside diameter
idiam=51;//[10:200]   
//Height
lidh=6;//[2:20]
//Looseness factor (5 = extra .5mm + diameter)
looseness=0;//[0:20]
// Toggle for tether
doTether= "true"; // ["true","false"]

/* [Hidden] */
$fn=70;
loose=looseness/10; // ie looseness = 5 loose = 0.5mm


lid(); 

//-----------------------------------------------------------------------
module tube(d,h,th) {  // d= outside diam
rad=d/2;
difference() {
	cylinder(h=h,r=rad);
	cylinder(h=h,r=rad-th);
	}
}

module tether( edge ) {
translate([-(edge+1)/2, 0, 0])
difference() {
	cylinder(h=thickness,r=4, center=false);
	cylinder(h=thickness,r=2, center=false);
	}
}

//-----------------------------------------------------------------------

module lid(){
union() {
	tube(idiam+thickness*2+loose,lidh,thickness); // sides
	tube(idiam+thickness*2+loose,thickness,idiam+thickness*2+loose); // base
	if (doTether)
	{
		tether(idiam+thickness/2+loose);
	}
}
}



