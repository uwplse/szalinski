/*
 * Sub-Irrigated Planter (SIP) Continious Irrigation Block
 *
 * By: Mike Creuzer <thingiverse@creuzer.com>
 * 
 * http://www.thingiverse.com/thing:20753
 *
 * Version 1.1 - Made pot radius parametric
 */

/* Pot Diameters in MM */
// Soda Bottle = 100 ~ 4.5 inches
// 5 gallon bucket = 254 ~ 10 inches

planter = 254 ;

// Generatet the part
SipBody();


















module SipBody()
{
	difference() {
		union() {
			baseblock();
			//cylinder(h =13, r = 3.15);
			screw(2, 3.15, 4, 4, 13, 4);
			minkowski(){ rotate(a=[0,90,0]) cylinder(h =15, r = 5); cylinder(r=2,h=.25);}
			minkowski(){rotate(a=[0,-90,0]) cylinder(h =15, r = 5); cylinder(r=2,h=.25);}

		}
		union() {
			cylinder(h =31, r = 2.1);
			rotate(a=[0,90,0]) translate(v=[0,0,5]) cylinder(h =31, r1 = 3.25, r2 = 3);
			rotate(a=[0,-90,0]) translate(v=[0,0,5]) cylinder(h =31, r1 = 3.25, r2 = 3);
			
			rotate(a=[0,-90,0]) cylinder(h =32, r = 2.1, center=true);


		}
	}
}

// Nut
intersection() {
	union(){
		translate(v=[19,13,-5]) nut(2, 3.4, 4.25, 6, 6, 4, 6.5, 2);
		difference(){
			translate(v=[19,13,-2]) cylinder(h=6,r1=5.25,r2=8);
			translate(v=[19,13,-2]) cylinder(h=6,r=4.5);
		}
	}
	#translate(v=[18,12,-planter/2 + 1]) sphere( r =planter/2, $fa=1);

}





module baseblock()
{
	difference() {
		minkowski(){
			translate(v=[0,0,5]) cube([15.4, 15.4, 20], center = true);
 			cylinder(r=5,h=1);
		}
		#rotate(a=[90,0,0]) translate(v=[0,planter/2 + 5.5,-15]) cylinder(h =31, r =planter/2, $fa=1);

	}

}

module screw(type = 2, r1 = 15, r2 = 20, n = 7, h = 100, t = 8)
{
	linear_extrude(height = h, twist = 360*t/n, convexity = t)
	difference() {
		circle(r2);
		for (i = [0:n-1]) {
				if (type == 1) rotate(i*360/n) polygon([
						[ 2*r2, 0 ],
						[ r2, 0 ],
						[ r1*cos(180/n), r1*sin(180/n) ],
						[ r2*cos(360/n), r2*sin(360/n) ],
						[ 2*r2*cos(360/n), 2*r2*sin(360/n) ],
				]);
				if (type == 2) rotate(i*360/n) polygon([
						[ 2*r2, 0 ],
						[ r2, 0 ],
						[ r1*cos(90/n), r1*sin(90/n) ],
						[ r1*cos(180/n), r1*sin(180/n) ],
						[ r2*cos(270/n), r2*sin(270/n) ],
						[ 2*r2*cos(270/n), 2*r2*sin(270/n) ],
				]);
		}
	}
}

module nut(type = 2, r1 = 16, r2 = 21, r3 = 30, s = 6, n = 7, h = 100/5, t = 8/5)
{
	difference() {
		cylinder($fn = s, r = r3, h = h);
		translate([ 0, 0, -h/2 ]) screw(type, r1, r2, n, h*2, t*2);
	}
}
