//============================================================
// OpenSCAD Project : Build a Dome
//
// Vincent DUBOIS
//============================================================

// The Dome is centered at origine. Do what you want after build
// D = Ground Diameter (Basement)
// H = Height of the Dome (from center)

// Explain :
// There is only one Sphere for 3 points in space.
// H + Diameter (2 points on the Diameter) = 3
// Whatever are H and R with 0<R and 0<H
// The Sphere Radius is an equation of R and H
// See below

// use as : use <dome.scad>
// inside script : Dome(D=Diameter,H=height)

//------------------------------------------------------------
// Parameters for Customizer
// Tested with OpenSCAD version 2017.01.20 (git 59df0d1)
//------------------------------------------------------------
/* [OpenScad resolution] */
// Set global resolution.
$fn = 100 ; // [1:250]

/* [Dome size] */
// The Height of the dome ]0,∞[.
DomeHeight = 20;

// The diameter of the base of dome [0,∞[ (0=sphere).
BaseDiameter = 20;

/* [Debug mode] */
// Set it if you want the values to be shown in console.
Debug = false;

//------------------------------------------------------------
// View
//------------------------------------------------------------
Dome(BaseDiameter,DomeHeight);


//------------------------------------------------------------
// Build the Dome
// D : Diameter of the Dome - the basement
// H : Height of the Dome
//------------------------------------------------------------
module Dome(D=1,H=2)
{
    // Control to avoid problems
    // a =   test ? TrueValue : FalseValue ;
    D = D<=0 ? abs(D) : D;
    H = H<0 ? abs(H) : H==0 ? 1 : H;

	// Calculation of the sphere radius
	//  ( (H*H) + (R*R) ) / (2*H)
	R=D/2;
	Sphere_Radius = ( pow(H,2) + pow(R,2) ) / (2*H);

	// Log the values, uncomment if needed
    if (Debug)
    {
        echo(str("Debug mode"));
        echo (str("",
            "\nDome Height : ", H,
            "\nBasement Diameter : ", D,
            "\nSphere Radius : ", Sphere_Radius, " (calculated)",
            "\nSphere Diameter : ", Sphere_Radius*2, " (calculated)\n"));
    }
	
	// center at origin the Dome for good rotating
	translate([0,0,-(Sphere_Radius-H)-H/2])

	difference()
	{
		// build the sphere which contain the Dome
		sphere(Sphere_Radius);
		// remove the useless sphere portion with a cube
		translate([0,0,-H])
			cube([2*Sphere_Radius,2*Sphere_Radius,2*Sphere_Radius],center=true);
	}
}

//==EOF=======================================================