use <write/Write.scad>

// Parameters

/* [Text] */
line_1_text = "I Love";
line_2_text = "You";
text_thickness = 5;
text_height = 5.7;
text_position = 12;
line_spacing = 8;

/* [Heart] */
heart_height = sqrt(800);
heart_thickness = 5;
loop = "True"; // "True", "False"
loop_wall_thickness = 1.5;
loop_diameter = 5;

/* [Hidden] */
$fs = 0.01;
$fa = 5;
heart_edge = sqrt(heart_height*heart_height/2);


module flat_heart(edge) 
{
  square(edge);

  translate([edge/2, edge, 0])
  circle(edge/2);

  translate([edge, edge/2, 0])
  circle(edge/2);
}


linear_extrude(heart_thickness) 
	union()
	{
		rotate([0,0,45])
			flat_heart(heart_edge);
		if (loop == "True")
			{
				translate([0,heart_height+loop_diameter/2,0])
					difference()
					{
						circle(r = loop_diameter/2+loop_wall_thickness);
						circle(r = loop_diameter/2);
					}
			}
	}

translate([-heart_edge/2,text_position,0])
	writecube(line_1_text,[heart_edge/2,heart_edge/2,heart_thickness/2],[heart_edge,heart_edge,heart_thickness+text_height/2*0.9],t=text_thickness,h=text_height,face = "top");

translate([-heart_edge/2,text_position-line_spacing,0])
	writecube(line_2_text,[heart_edge/2,heart_edge/2,heart_thickness/2],[heart_edge,heart_edge,heart_thickness+text_height/2*0.9],t=text_thickness,h=text_height,face = "top");