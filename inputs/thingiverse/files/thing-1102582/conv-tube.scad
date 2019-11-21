//
// tube diameter conversion
//
// design by Egil Kvaleberg, 30 Oct 2015
//
// 

major_diameter = 95.9; // larger diameter
minor_diameter = 59.7; // smaller diameter
sleeve_length = 35.0; 
slope_length = 50.0;
wall = 2.0; // general wall thickness
wire_diameter = 7.0; // diameter of wire


/* [Hidden] */
tol = 0.25; // general tolerance
d = 0.01;

intersection () {
    difference() {
        union () {
            cylinder(r=major_diameter/2 + tol + wall, h=sleeve_length+d, $fn=120);
            translate([0, 0, sleeve_length]) cylinder(r1=major_diameter/2 + tol + wall, r2=minor_diameter/2 + tol + wall, h=slope_length, $fn=120);
            translate([0, 0, sleeve_length+slope_length-d]) cylinder(r=minor_diameter/2 + tol + wall, h=sleeve_length+d, $fn=120);
        }
        union () { // subtract
            translate([0, 0, -d]) cylinder(r=major_diameter/2 + tol, h=sleeve_length + 3*d, $fn=120);
            translate([0, 0, sleeve_length-d]) cylinder(r1=major_diameter/2 + tol, r2=minor_diameter/2 + tol, h=slope_length+2*d, $fn=120);
            translate([0, 0, sleeve_length+slope_length-2*d]) cylinder(r1=minor_diameter/2 + tol, r2=minor_diameter/2 + tol - wall, h=wall+3*d, $fn=120);
            translate([0, 0, sleeve_length+slope_length+wall]) cylinder(r=minor_diameter/2 + tol, h=sleeve_length-wall+d, $fn=120);
        }
    }
	//cube([100, 100, 100]);
}