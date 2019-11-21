//button with holes and a rim and a flat back for nice printing
//Customizer variables
//This section is displays the box options
//dimensions of button
//choose a style for the button.  All have flat backs for easy printing (most buttons are one sided anyway)
button_style="rim"; // [flat,bevel_edge,rim]
//total width of the button in mm
button_diameter = 20;	//	[5:100]
//thickness of the button in mm (not including decorative elements)
button_thickness = 3; // [2:50]
//number of holes
holes = 4; // [2,3,4,5,6]
//diameter of the holes in mm
holesize = 1.5; //[1:10]
//height of decorative rim (in mm) for some styles
rim_height = 1; //[1,2,3,4]

button_radius=button_diameter/2;

module buttonbody()
{
	if(button_style=="flat")
		{
		cylinder(button_thickness,button_radius,button_radius);
		}
	else if (button_style=="bevel_edge")
		{
			hull()
			{
			cylinder(0.75*button_thickness,button_radius,button_radius);
			cylinder(button_thickness,0.8*button_radius,0.8*button_radius);//inner 
			}
		}
	else if(button_style=="rim")
		{
		union()
		{
		cylinder(button_thickness,button_radius,button_radius);
		difference()
		{
		cylinder(rim_height+button_thickness,button_radius,button_radius);//outer
		cylinder(4+rim_height+button_thickness,0.85*button_radius,0.85*button_radius);//inner cut
}
}
}
}
//add holes
difference()
{
buttonbody();
	for (i=[1:holes])
		{rotate(i*360/holes,[0,0,1])
		 translate([0.5*holesize+0.25*button_radius,0,-2*button_thickness])
		cylinder (4*button_thickness + 4,holesize,holesize);
		}
}
		
