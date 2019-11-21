//Customizable clamping square
//By Iron Momo


/* [Basic] */
square_width = 150;
hole_diameter = 20;

output_type = "STL"; //[DXF,STL]

/* [STL output] */
material_thickness = 10;

/* [Hidden] */
l1 = 3*square_width/4;
l2 = hole_diameter + 10;


// preview[view: north, tilt:top]

if(output_type=="STL")
{linear_extrude(height = material_thickness, center = false) square_creation();
}

if(output_type=="DXF")
{square_creation();}

module square_creation()
{
difference()
{
	square(square_width);	

	translate([square_width,square_width,0])rotate([0,0,-45])square(square_width, center= true);
	rotate([0,0,-45]) square(square_width/6 , center= true);
	translate([l1,l2,0])circle(hole_diameter);
	translate([l2,l1,0])circle(hole_diameter);
	
}
}