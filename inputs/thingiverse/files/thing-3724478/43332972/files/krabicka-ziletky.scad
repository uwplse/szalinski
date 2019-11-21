// Sealing (not just) for Ikea Korken
// https://www.thingiverse.com/thing:3724478
// Vilem Marsik, 2019
// CC BY-NC-SA
// https://creativecommons.org/licenses/by-nc-sa/4.0/


// wall thickness
wt=1;
// blade box height
zs=65;
// blade box X
xs=43;
// blade box Y
ys=9;
// handle X
xh=17.5;
// handle Y
yh=15.5;
// handle edge radius
re=3.5;

/* [Hidden] */
$fs=.5;

module rcube(xs,ys,zs,re)	{
	hull()
		for(x=[re,xs-re])
			for(y=[re,ys-re])
				translate([x,y,0])
					cylinder(r=re,h=zs);
}

difference()	{
	union()	{
		rcube(xs+2*wt,ys+2*wt,zs+wt,wt);
		translate([(xs-xh)/2,-yh-wt,0])
			rcube(xh+2*wt,yh+2*wt,zs+wt,re);
	}
	translate([xs/4+wt,wt,-1])
		cube([xs/2,ys,wt+2]);
	translate([wt,wt,wt])
		cube([xs,ys,zs+1]);
	translate([(xs-xh)/2+wt,-yh,-1])
		rcube(xh,yh,zs+wt+2,max(.1,re-wt));
}

