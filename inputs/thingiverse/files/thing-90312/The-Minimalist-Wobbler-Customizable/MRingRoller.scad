// Minimalist Wobbler
// Version 1.0
// Luigi Cisana, 17 May, 2013

outer_diameter=36;

hole_diameter=26;

thickness=3; // [1:5]

/* [Hidden] */
$fn=96;
facet=0.5;

height=thickness;
radius=outer_diameter/2;
iradius=hole_diameter/2;

sradius=radius-iradius+1;
slot=sradius;

x1=2;
y1=sqrt(pow(5,2)-x1);

difference() {
	union() {
		difference() {
			cylinder(h=height,r=radius);	
			translate ([-x1,-y1,0]) difference() {
				cylinder(h=height,r=radius+10);
				cylinder(h=height/2,r1=radius-height/2+5,r2=radius+5);
				translate([0,0,height/2]) cylinder(h=height/2,r1=radius+5,r2=radius-height/2+5);
			}
			translate ([-x1,y1,0]) difference() {
				cylinder(h=height,r=radius+10);
				cylinder(h=height/2,r1=radius-height/2+5,r2=radius+5);
				translate([0,0,height/2]) cylinder(h=height/2,r1=radius+5,r2=radius-height/2+5);
			}
			cylinder(h=facet,r1=iradius+facet,r2=iradius);
			translate ([0,0,facet]) cylinder(h=height-2*facet,r1=iradius,r2=iradius);
			translate ([0,0,height-facet]) cylinder(h=facet,r1=iradius,r2=iradius+facet);
		}
		translate([radius-slot,0,0]) cylinder(h=facet,r1=sradius-facet,r2=sradius);
		translate([radius-slot,0,facet]) cylinder(h=height-2*facet,r=sradius);
		translate([radius-slot,0,height-facet]) cylinder(h=facet,r1=sradius,r2=sradius-facet);
	}  //union
	translate([radius-slot+facet,-height/2,0]) cube(size=[slot,height,height],center=false);
}
