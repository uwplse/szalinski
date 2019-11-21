n=6; //Snowflakes are hexagonal.
y=150;//determines height of the triangles.
x=25;//determines width of the triangles.
height=3; //thickness of stencil.
tierx1=.5;//multiplyer of the width of first tier triangles.
tiery1=.4;//multiplyer of the height of first tier triangles.
tierx2=.2;//multiplyer of the width of second tier triangles.
tiery2=.2;//multiplyer of height of second tier triangles.
tier1angle=65;//turn angle of first tier triangles.
tier2angle=45;//turn angle of second tier triangles.

difference()
{

linear_extrude(height=height)
rotate([0,0,360/(2*n)])circle(y+.05*y,$fn=n);
echo(2*(y+.05*y));//diameter of stencil.

translate([0,0,-5])
linear_extrude(height=height+10)
union()
{
circle(y/3,$fn=n);

	for(i=[0:n])
	{
	rotate([0,0,i*360/n])
	{
		polygon([[x,0],[-x,0],[0,y]]);

		translate([0,y/2,0])rotate([0,0,tier1angle])
		polygon([[tierx1*x,0],[-tierx1*x,0],[0,tiery1*y]]);

		translate([0,y/2,0])rotate([0,0,-tier1angle])
		polygon([[tierx1*x,0],[-tierx1*x,0],[0,tiery1*y]]);

		translate([0,(4*y)/5,0])rotate([0,0,tier2angle])
		polygon([[tierx2*x,0],[-tierx2*x,0],[0,tiery2*y]]);

		translate([0,(4*y)/5,0])rotate([0,0,-tier2angle])
		polygon([[tierx2*x,0],[-tierx2*x,0],[0,tiery2*y]]);
		}
	}
}
}