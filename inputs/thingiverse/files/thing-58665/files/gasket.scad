//Customizable Gasket
// This is a simple open-source parametric gasket

//CUSTOMIZER VARIABLES
//Defines the height of the gasket
gasket_thickness=1; //[1:10] 

//Defines the gasket outer diameter
gasket_outer_diameter=2; //[2:100]

//Defines the gasket inner diameter
gasket_inner_diameter=1; //Numeric value smaller than Gasket Outer Diameter

//CUSTOMIZER VARIABLES END

module gasket()
{
	difference()
	{
	cylinder(h=gasket_thickness, r=gasket_outer_diameter*2, center=true, $fn=100);
	cylinder(h=gasket_thickness, r=gasket_inner_diameter*2, center=true, $fn=100);
	}
}

gasket();
