// Customizable hex pattern
// Created by Kjell Kernen
// Date 11.10.2015

/*[Pattern Parameters]*/
// of the pattern in mm:
diameter=100;           // [10:150]

// of the pattern in tens of mm:
height=20;              // [2:200]

// in tens of mm:
border_width=20;        // [2:100]

// in tens of mm:
border_height=30;       // [2:100]

// in mm:
hex_radius=8;           // [1:20]

// in tens of mm: 
hex_border_width=25;    // [2:50]

/*[Hidden]*/
x=sqrt(3/4*hex_radius*hex_radius);
ystep=2*x;
xstep=3*hex_radius/2;

module hex(x,y)
{
	difference()
	{
		translate([x,y,-height/20]) 
			cylinder(r=(hex_radius+hex_border_width/20), h=height/10, $fn=6);	
		translate([x,y,-(height/20)-1]) 
			cylinder(r=(hex_radius-hex_border_width/20), h=(height/10)+2, $fn=6);
	}
}

//Pattern
intersection()
{
    intersection()
	{
		for (xi=[0:xstep:diameter])
			for(yi=[0:ystep:diameter])
				hex(xi-diameter/2,((((xi/xstep)%2)==0)?0:ystep/2)+yi-diameter/2);
		translate([-diameter/2, -diameter/2, -height/20]) 
			cube([diameter,diameter,height/10]);
	}
	cylinder( d=diameter, h=height );
}

// Frame
difference()
{
	cylinder( d=diameter, h=border_height/10 );
	translate ([0,0,-1])
		cylinder( d=diameter-border_width/10, h=(border_height/10) + 2  );
}



