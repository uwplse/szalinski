
// preview[view:south, tilt:top]
// Number of periods in the pattern per rotation?
whole_periods =2;//[0:10]
// How many times should the pattern wrap around?
turns = 3;//[1:10]
// How tall (in mm)?
height = 10;
// Thickness of the band (mm)?
width = 5;
// Inside diameter of the thing (mm)?
inner_diameter = 22;
// Diameter of the rail (mm)?
rail_diameter = 2; 
// Adds a vertically mirrored copy of the rail.
mirror_reinforced = "yes";//[yes,no]
// Adds rings to top and bottom
top_and_bottom_reinforced = "no";//[yes,no]
// Fills in to make easier to print
solid_ring = "no";//[yes,no]

//Go with as small a number as you can without sacrificing too much detail. This will greatly reduce the time it takes to generate the STL
segments_per_turn = 50;//[15:150]
//Go with as small a number as you can without sacrificing too much detail. This will greatly reduce the time it takes to generate the STL
fragments_per_segment = 8;//[3:25]

periods = 1/turns+whole_periods;
twoPi = 2*3.1415;
radialShift = (inner_diameter/2+width/2+rail_diameter/2);
delta = 1/segments_per_turn;

ring();



module ring() 
{
	color("Blue")
	union()
	{
		for ( i = [0 : delta : turns] )
		{
			hull()
			{
				makeSphere(i);
				makeSphere(i+delta);
			}
		}
		if (mirror_reinforced == "yes")
		{
			for ( i = [0 : 1/segments_per_turn : turns] )
			{
				mirror([0,0,1])
				{
					hull()
					{
						makeSphere(i);
						makeSphere(i+delta);
					}
				}
			}
		}
		if (top_and_bottom_reinforced == "yes")
		{
			makeRing(radialShift,rail_diameter,height/2);
			makeRing(radialShift,rail_diameter,-height/2);
		}
		if (solid_ring == "yes")
		{
			donut(radialShift,height*4/8,width*4/8);
		}
	}
}


function xPos(i) = (inner_diameter/2+width/2+rail_diameter/2)*sin(360*i) + width/2*sin(360*i*periods)*sin(i*360);
function yPos(i) = (inner_diameter/2+width/2+rail_diameter/2)*cos(360*i) + width/2*sin(360*i*periods)*cos(i*360);
function zPos(i) = height/2*cos(360*i*periods);
function xVel(i) = (width*cos(i*360)*sin(i*360*periods)/(2*twoPi)+periods*width*sin(i*360)*cos(i*360*periods)/(2*twoPi)+radialShift*cos(i*360)/twoPi);
function yVel(i) = (-width*sin(i*360)*sin(i*360*periods)/(2*twoPi)+periods*width*cos(i*360)*cos(i*360*periods)/(2*twoPi)-radialShift*sin(i*360)/twoPi);
function zVel(i) = -height*periods*sin(i*360*periods)/(2*twoPi);
function rotAngle(i) = atan2(sqrt((xVel(i)*xVel(i))+(yVel(i)*yVel(i))),zVel(i));
function rotAxis(i) = [-yVel(i),xVel(i),0];

module makeCylinder(i) 
{
	translate([xPos(i),yPos(i), zPos(i)])
	rotate(a=rotAngle(i),v=rotAxis(i))
	cylinder(h=.001,r=rail_diameter,center = true,$fn = fragments_per_segment);
}

module makeSphere(i) 
{
	translate([xPos(i),yPos(i), zPos(i)])
	sphere(r=rail_diameter,center = true,$fn = fragments_per_segment);
}

module makeRing(r,d,z)
{
	translate([0,0,z])
	rotate_extrude(convexity = 10)
	translate([r,0,0])
	rotate(r=[0,90,0])
	circle(r=d,$fn = fragments_per_segment);
}

module donut(r,h,w)
{
	scale([1,1,h/w])
	rotate_extrude(convexity = 10)
	translate([r,0,0])
	rotate(r=[0,90,0])
	circle(r=w,$fn = fragments_per_segment*3);	
}
