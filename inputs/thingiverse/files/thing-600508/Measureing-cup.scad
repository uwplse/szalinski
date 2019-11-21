//Volume in mL or CC.
volume=236.588;

wallThick=1.04; // [1.04:1.20]

//Who says it has to stay the same...
pi=3.1415926536;
radius=10*pow((volume*375)/(236*pi),1/3);

handlX=1.3*radius;
handlY=0.3*radius;
handlZ=0.2*radius;

//Resolution
res=30;

echo("volume: " );echo(volume);
echo("height: " );echo(4*radius/5);
echo("radius: ");echo(radius);
echo("thickness: ");echo(radius*(wallThick-1));

module cup(r)
{

	difference()
	{
	sphere(r,$fn=res);
	translate([0,0,(r+1)])cube(2*(r+1),true);

	translate([0,0,-(r+1)-4*r/5])cube(2*(r+1),true);
	}
}

difference()
{
cup(radius*wallThick);
translate([0,0,0.001])cup(radius);	
}

translate([(handlX/2)+radius,0,-handlZ/2])cube([handlX,handlY,handlZ],true);
translate([(handlX/2)+radius+handlX/2,0,-(4*radius*wallThick/5)/2])cube([2,handlY,(4*radius*wallThick/5)],true);
translate([(handlX/2)+radius+handlX/2,0,-(4*radius*wallThick/5)])scale([4,1,1])cylinder(r=2*handlY/3,h=1,$fn=4);