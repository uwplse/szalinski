$fa=1;
$fs=.5;
plug_height=10;
plug_r=10;
plug_rtol=0.25;
slot_depth=4;
slot_width=2;
ridge_r=0.2;

module thread_ridge() //vertical ridge to catch threads in brush hole
{
	#cylinder(h=plug_height-slot_depth, r=ridge_r);
}

union()
{
	difference() //plug with .25mm tolerance and slot for turning
	{
		cylinder(h=plug_height, r=plug_r-plug_rtol);
		translate([-slot_width/2,-plug_r-0.75,plug_height-4])
			#cube([slot_width,2*plug_r+1.5,slot_depth+1]);
	}
	
	for(r=[0:90:359]) //create 4 thread ridges around the circumference of the plug
		{
		rotate([0,0,r])
			translate([plug_r-plug_rtol,0,0])
				thread_ridge();
		}
}