// preview[view:north west, tilt:top diaganol]

use<write/Write.scad>;
//Enter volume in units of 1 US Cup
volume = .375; // 
//Enter height in millimeters
height = 35;
//Enter wall thickness in millimeters
wall_thickness = 5;
font_name = "Orbitron.dxf"; //[orbitron.dxf:Orbitron,BlackRose.dxf:BlackRose,knewave.dxf:Knewavef,braille.dxf:Braille]
name = "Scooby";

/*[HIDDEN]*/
handle_width = 16;
cup2mm = 236588.236;
volume_mm = (cup2mm *volume);
cup_area = volume_mm/(height - wall_thickness);
radius = sqrt(cup_area/PI);
diameter = radius*2;
handle_thickness = handle_width*5/8;
 





module handle()
{
fillet_pos_y = radius - radius*cos(asin((handle_width/2)/radius));
echo("Fillet position Y = ",fillet_pos_y);
	union()
	{
	  	translate([-(50/2),-(handle_width/2),((height) - handle_thickness)])
		{
			cube([50, handle_width, handle_thickness], center=false);
		}
	  	translate([25, 0,0]) 
		{
		  	cylinder(r=handle_width/2, h=((height)), center=false, $fn=40);
		}
		difference()
		{
			translate([-(fillet_pos_y+2)  ,-(handle_width/2)-2,((height) - handle_thickness)]) 
			{
				cube([4,4,handle_thickness], center = false);
			}

			translate([-(fillet_pos_y-2)  ,-(handle_width/2)-3,((height) - handle_thickness)]) 
			{
			  	cylinder(r=3, h=handle_thickness, center=false, $fn=40);
			}
		}
		difference()
		{
			translate([-(fillet_pos_y+2)  ,(handle_width/2)-2,((height) - handle_thickness)]) 
			{
				cube([4,4,handle_thickness], center = false);
			}

			translate([-(fillet_pos_y-2)  ,(handle_width/2)+3,((height) - handle_thickness)]) 
			{
			  	cylinder(r=3, h=handle_thickness, center=false, $fn=40);
			}
		}


	}



}

module cup() 
{
	echo("radius = ",radius);
  	translate([-(radius + (wall_thickness/2)) , 0,0]) 
	{
	  		cylinder(r=radius + (wall_thickness/2) , h=(height), center=false, $fn=50);
	
	writecylinder(text = name,where = [0,0,0], radius = (radius + (wall_thickness/2)), height = (height),west = 90,h = 8,t=2,bold=true,space = 1.2,font = font_name); 
			
	}

}



difference()
{
		
	union()
	{
		handle();
		cup();
	}
  	translate([-(radius + (wall_thickness/2)) , 0,wall_thickness]) 
	{
	  		cylinder(r=radius , h=height , center=false, $fn=50);
	}
}





