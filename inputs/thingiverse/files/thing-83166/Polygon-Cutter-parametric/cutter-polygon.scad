//Polygon sides
polysides=6; // [5:20]

//Height of cutter
cutterheight=30; // [5:50]

//Radius of inner cutter
cutterradius = 40;// [5:100]

//Wall thickness
wallthick = 3; // [1:10]

//Base height
baseheight = 5; // [0:10]

/* [Hidden] */
$fn=60;
cutterradius_o = cutterradius+wallthick;

difference() {
	union() {
			
		linear_extrude(height=cutterheight) circle(r=cutterradius_o,$fn=polysides);
			
		cylinder(h=baseheight,r=cutterradius_o);
	}

translate([0,0,-10]) linear_extrude(height=cutterheight+20) circle(r=cutterradius,$fn=polysides);

}

