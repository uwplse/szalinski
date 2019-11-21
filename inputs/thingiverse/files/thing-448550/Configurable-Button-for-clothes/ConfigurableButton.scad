/////////////////Parameters
/* [Sizes] */
// total height
TotalHeight =3;
// inner height
InnerHeight = 2;
// outer size
OuterSize = 20;
// inner size
InnerSize = 16;
// How many holes?
NHoles=4; // [0:6]
// hole size
HoleSize = 2; //
// hole distance from center (to be more than HoleSize/2 and less than InnerSize/2)
HoleDistance = 3;
// rounding: -1 = automatic, 0 = no, >0 = radius of rounding 
Rounding = -1;
/* [Hidden] */


knopf(TotalHeight,InnerHeight,OuterSize/2,InnerSize/2,NHoles,HoleDistance,HoleSize/2);

module knopf(h1,h2,r1,r2,nh,rh,ih,rr= -1) {
	irr = (rr<0) ? h1/5 : rr;
	difference() {	
		rcyl(r1,h1,irr);
		translate([0,0,h2])
			cylinder(r=r2,h=(h1-h2+0.01),$fn=120);
		if (nh > 1) {
			for (i=[0:360/nh:360-0.01]) {
				translate([cos(i)*rh,sin(i)*rh,0]) 
					cylinder(r=ih,h=h1*2,center=true,$fn=60);
			}
		} else 
			if (nh > 0)
				cylinder(r=ih,h=h1*2,center=true,$fn=60);
	}
}  


module rcyl(cr,hh,rr,ce=false,fn=120) {
	if (rr > 0) {
		translate([0,0,rr]) 
			minkowski() {
				cylinder(r=cr-rr,h=hh-2*rr,center=ce,$fn=fn);
				sphere(rr,$fn=24);
			}
	} else {
		cylinder(r=cr,h=hh,center=ce,$fn=fn);
	}
}


