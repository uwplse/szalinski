/* [Global] */

// major radius
r_major = 28.75;

// minor radius
r_minor = 26;

// width of strap
s_width = 21.6;

// thickness of strap
thickness = 1.15;

/* [Hidden] */
$fn=100;

pin_r = 1.2; // pin radius

c_width = s_width+thickness;
pebble = [42.5,16,s_width+thickness];

module pin()
{
    difference()
    {
        cylinder(r=pin_r+thickness,h=s_width,center=true);
        cylinder(r=pin_r,h=c_width,center=true);
        translate([0,pin_r,0])
            cube([pin_r*1.25,pin_r*2,c_width],center=true);
    }
}

translate([0,0,s_width/2])
{
	difference()
	{
		resize([r_major*2,r_minor*2,0])
			cylinder(r=(r_major+r_minor)/2, h=s_width, center=true);
		resize([(r_major-thickness)*2,(r_minor-thickness)*2,0])
			cylinder(r=(r_major+r_minor)/2, h=c_width, center=true);
		translate([0,r_minor-pebble[1]/2,0]) cube(pebble,center=true);
	}
	
	for(i=[1,-1]) translate([i*(pebble[0]/2-pin_r),r_minor-pebble[1]/2-pin_r,0]) pin();
}