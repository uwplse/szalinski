// Customizable hex pattern
// Created by Kjell Kernen
// Date 22.9.2014

/*[Pattern Parameters]*/
// of the pattern in mm:
width=100;       // [10:200]

// of the pattern in mm:
lenght=155;      // [10:200]

// of the pattern in tens of mm:
height=5;       // [2:200]

// in tens of mm:
border_width=20;// [2:100]

// in mm:
hex_radius=2;   // [1:20]

// in tens of mm: 
hex_border_width=5; // [2:50]

/*[Hidden]*/

xborder=(border_width/10<width)?width-border_width/10:0;
yborder=(border_width/10<lenght)?lenght-border_width/10:0;

x=sqrt(3/4*hex_radius*hex_radius);
ystep=2*x;
xstep=3*hex_radius/2;

module hex(x,y)
{
	difference()
	{
		translate([x,y,-height/20]) 
			cylinder(r=(hex_radius+hex_border_width/20), h=height/10, $fn=6);	
		translate([x,y,-height/20]) 
			cylinder(r=(hex_radius-hex_border_width/20), h=height/10, $fn=6);
	}
}

//Pattern
intersection()
{
	for (xi=[0:xstep:width])
		for(yi=[0:ystep:lenght])
			hex(xi-width/2,((((xi/xstep)%2)==0)?0:ystep/2)+yi-lenght/2);
	translate([-width/2, -lenght/2, -height/20]) 
		cube([width,lenght,height/10]);
}

// Frame
difference()
{
	translate([-width/2, -lenght/2, -height/20]) 
		cube([width,lenght,height/10]);
	translate([-xborder/2, -yborder/2, -(height/20+0.1)]) 
		cube([xborder,yborder,height/10+0.2]); 
}




