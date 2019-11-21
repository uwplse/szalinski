//fastner radius
lR = 7.5;
//hole radius
iR = 2.25;
//fastner height of tags
h = 1.5;
//paper width
pW = 3;
//increment of stopper to fasten
dH=1;

module fastnerPeg(){
difference(){
 union(){
	cylinder(r=lR,h=h);
	translate([0,0,h]) cylinder(r=iR,h=pW+h);
	translate([0,0,2*h+pW]) sphere(r=iR+dH/2);
	}
	translate([-(dH*1.25)/2,-(iR*2+dH)/2,h]) cube([dH*1.25,iR*2+dH,h+pW+iR+dH/2]) ;
}
}

module fastnerWasher(){
	difference(){
		cylinder(r=lR,h=h);
		// increase r if your printer prints smaller holes.
		cylinder(r=iR+dH/2+0.3,h=h);
	}
}

fastnerPeg();

translate([lR *2 + 2,0,0]) 
fastnerWasher();