use <write/Write.scad>

//Parametric bridge
/* [Global] */
bridge_width=10;//width of bridge
bridge_length=50;//length of bridge
bridge_height=3;//height off  build plate
bridge_thickness=.6;//thickness of bridge

/*[Simple]*/

/* [User] */
extrusion_width=.55;//extrusion width set in slicing program. Normally nozzle*1.1
layer_height=.2;//layer height in slicing program

/* [Hidden] */
actual_width=bridge_width-bridge_width%extrusion_width;
support_length=actual_width*.5;
total_height=bridge_height+bridge_thickness;
support_radius=3;
angle=90-atan(total_height/(support_length*.6));

//Bridge Modules
module Support()
{
	color("blue")
	difference()
		{
			 translate([0,0,total_height/2])cube([support_length,actual_width,total_height],center=true);//create cube support
			 translate([-support_length/2,+actual_width,0])rotate([0,-angle,180]) cube([support_length,actual_width*2,bridge_height*10]);//cut cube support at angle
		}
	//brim
	color("yellow") scale([.8,.8,1])
	minkowski()
	{
	translate([0,0,layer_height/2]) cube([support_length,actual_width,layer_height/2],center=true);
	cylinder(r=support_radius,h=layer_height/2,$fs=1);
	}
}

module bridge()
{
	union()
	{
		color("yellow") translate([0,0,bridge_height+bridge_thickness/2]) cube([bridge_length*1.01,actual_width,bridge_thickness],center=true);
		color("blue") writecube("BRIDGE",[0,0,bridge_height+bridge_thickness/2],[bridge_length*1.01,actual_width,bridge_thickness], face="top",font = "write/orbitron.dxf",t=layer_height*4,h=actual_width*.9);
	}
}

//Build
translate([-bridge_length/2-support_length/2,0,0]) Support();
translate([bridge_length/2+support_length/2,0,0]) rotate([0,0,180])Support();
bridge();


