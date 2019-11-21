
$fn=23;
gMS=2.4;


include <../Modules/Module_Rounded_Cube.scad>;



union()
{
		spacer();

}

module spacer()
{
	difference()
	{
		cylinder(d=6, h=3);

		cylinder(d=3.5, h=3);
	}
}
