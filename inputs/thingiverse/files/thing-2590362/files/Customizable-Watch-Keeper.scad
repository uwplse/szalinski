width = 5.5;
length = 26.75;
height = 10;
bandThickness = 2;
radius = 3;

tabRendered = 1;
tabWidth = 2.25;
tabLength = 9.25;
tabHeight = 1.25;
tabRadius = 1;


difference(){
    roundedRect([width+bandThickness,length+bandThickness,height], center=true, radius);
    translate([0,0,-1]){roundedRect([width,length,height+5], center=true, radius);}
}
if(tabRendered){translate([(width/2)+(radius/2),0,height/2]){rotate([90,0,-90]){roundedRect([tabLength, tabHeight, tabWidth], center=true, tabRadius);}}}


// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}