// inner diameter of the spool
filamantSpoolHoleDiameter = 54;

// diameter for the holder rail (like IKEA GRUNDTAL)
holderRailDiameter = 17; 

/* [Hidden] */
$fa=0.5; // default minimum facet angle is now 0.5
/* [Hidden] */
$fs=0.5; // default minimum facet size is now 0.5 mm

/* [Hidden] */
height = 10;

overlapDiameter = filamantSpoolHoleDiameter + filamantSpoolHoleDiameter * 0.3;
tolerance = height*0.1;

module ring()
{
	difference()
	{
		union()
		{
			intersection()
			{
				cylinder(h=height, d=overlapDiameter);
				translate([0,0,height/2])
				cylinder(h=height/2, d=filamantSpoolHoleDiameter);
				
			}
			cylinder(h=height/2, d=overlapDiameter);
		}
		translate([0,0,-tolerance])
		cylinder(h=height+tolerance*2, d=holderRailDiameter);
	}
}

module pie_slice(r=3.0,a=30) {
  intersection() {
    circle(r=r);
    square(r);
    rotate(a-90) square(r);
  }
}

module spaces()
{
	difference()
	{
		degree = 45;
		for(i=[1:1:360/degree/2])
		{
			rotate([00,0,degree*i*2])
			pie_slice(r=1+overlapDiameter/2,a=degree);
		}
		circle(d=holderRailDiameter+holderRailDiameter*0.6);
	}
}

difference()
{
	ring();
	translate([0,0,-tolerance])
	linear_extrude(height+tolerance*2)
	spaces();
}