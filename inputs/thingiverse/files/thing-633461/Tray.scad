
//Hole radius
hole_radius=10; //[1:30]

//Hole spacing
hole_spacing=2; //[1:10]

//Number of rows
rows=10; //[1:30]

//Number of columns
columns=4; //[1:30]

//Height of tray
base_height=20; //[10:100]

//Base thickness under each hole
base_bottom_thickness=2; //[2:8]

base_width=rows*(hole_spacing+hole_radius*2)+hole_spacing;
base_length=columns*(hole_spacing+hole_radius*2)+hole_spacing;

//number_of_holes=(base_length-(base_length%((shell_radius+hole_spacing)*2)))/((shell_radius+hole_spacing)*2);

number_of_holes=columns;

difference()
{

	translate([0,0,-base_bottom_thickness]) cube([base_length,base_width,base_height]);

	for(i=[1:number_of_holes])
	{
		for(j=[1:rows])
		{
			translate([i*(hole_radius*2+hole_spacing)-hole_radius,j*(hole_radius*2+hole_spacing)-hole_radius,0]) cylinder(r=hole_radius,h=base_height+1);
		}
	}

}