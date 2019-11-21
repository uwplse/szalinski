use <write/Write.scad>

/* [Main] */

// String for the first line
string1 = "MacKenzie";

// String for the second line
string2 = "and";

// String for the third line
string3 = "Abby";

// String for the fourth line
string4 = "11/26/11";

// The length of the lock cable
cableLength = 20;

module body()
{
	scale = 5;
	fontSize = scale * 3;
	fontWidth = scale;
	levelScale = .35;
	width = .7;
	
	union()	{
	difference() {
		difference() {
			cube([scale*25,scale*10,scale*20], true);
			translate([0, 0,scale*0]) cube([scale*23,scale*8,scale*18], true);
			//cylinder(r = scale*levelScale, h = width*scale);
		}
		union()	{
			translate([-3*scale, 0,scale*9]) cylinder(r = scale*2+2, h = scale);
			//translate([-7*scale, 0,scale*9]) cylinder(r = scale*2+2, h = scale);
			translate([7*scale, 0,scale*9]) cylinder(r = scale+2, h = scale);
		}
	}
		union() {
			union()	{
				translate([-6*scale, 5*scale,scale*8]) rotate([90,0,0]) cylinder(r = scale*levelScale, h = 10*scale);
				translate([0*scale, 5*scale,scale*8]) rotate([90,0,0]) cylinder(r = scale*levelScale, h = 10*scale);
			}
		}
	}

			translate([scale*.2, scale*-5,scale*7]) rotate([90,0,0])
			{write(string1,t=fontWidth,h=fontSize,center=true, font = "orbitron.dxf");}

			translate([scale*.2, scale*-5,scale*3]) rotate([90,0,0])
			{write(string2,t=fontWidth,h=fontSize,center=true, font = "orbitron.dxf");}

			translate([scale*.2, scale*-5,scale*-1]) rotate([90,0,0])
			{write(string3,t=fontWidth,h=fontSize,center=true, font = "orbitron.dxf");}

			translate([scale*.2, scale*-5,scale*-6.5]) rotate([90,0,0])
			{write(string4,t=fontWidth,h=fontSize,center=true, font = "orbitron.dxf");}		
}


module pin()
{
	scale = 5;
	n = 18;
	d = 180/n;
	iph = .85;
	
	translate([scale*2, 0,scale*20]) rotate([0,-90,270]) union() {
	//translate([scale*0, 0,scale*20]) rotate([0,-90,270]) union() {
		for (i = [1:n])
		{
			translate([sin(i*d) * 5 * scale, cos(i*d) * 5 * scale, 0])
			//translate([sin(i*d) * 5 * scale, cos(i*d) * 7 * scale, 0])
			{
				sphere(scale);
			}
		}
		rotate([0,270,0]) {
			translate([0,5*scale,0]) {
				sphere(scale);
				cylinder(r = scale, h = cableLength*scale);
			}
			translate([0,5*scale,(cableLength-.5)*scale]) {
				cube([scale*3,5*scale,3*scale], true);
			}

			translate([0,-5*scale,0]) {
				sphere(scale);
				cylinder(r = scale, h = (cableLength*iph)*scale);
			}
			translate([0,-5*scale,((cableLength * iph) -.5)*scale]) {
				cube([scale*2,4*scale,3*scale], true);
			}
		}
	}
}


module lever()
{
	scale = 10;
	levelScale = .35;
	width = .7;
	
	rotate([90,0,0]) translate([scale*-3,scale*4, scale*-.25]) union() {
		difference() {
			cylinder(r = scale*levelScale*2, h = width*scale);
			cylinder(r = scale*levelScale, h = width*scale);
		}
		translate([width*scale*1.5,0,width*scale*.5])cube([width*scale*2,width*scale,width*scale], true);
	}

	rotate([90,0,0]) translate([scale*0,scale*4, scale*.25]) rotate([0,180,0]) union() {
		difference() {
			cylinder(r = scale*levelScale*2, h = width*scale);
			cylinder(r = scale*levelScale, h = width*scale);
		}
		translate([width*scale*1.5,0,width*scale*.5])cube([width*scale*2,width*scale,width*scale], true);
	}
}

lever();

pin();

body();
