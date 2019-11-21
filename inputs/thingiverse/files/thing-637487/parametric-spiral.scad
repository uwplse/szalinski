////////////////////////////////
//
// HEXACORDE
//
// Parametric spiral
// 15.01.2015
////////////////////////////////



//Adjust the radius.
radius = 50; // [10:75]

//Adjust the height.
heigth = 60; // [1:100]

//Adjust ratio.
ratio = 45; // [1:100]

//Number of cylinders.
nb_cylinder = 20; // [1:20]

//Adjust cylinder radius.
radius_cylinder = 2; // [1:30]

//Adjust wall thickness.
wall_thickness = 3; // [1:24]

//Adjust twist
nb_twist = 100; // [1:1000]

//botom
bottom = "Yes"; // [Yes,No]

$fn=30;

module section()
{
	for (nb = [0: nb_cylinder]) 
	{
	    rotate(360*nb/nb_cylinder,[0,0,1])
	    translate([radius, 0, 0])
	    {		
	    	circle(r= radius_cylinder, h= heigth);
			rotate(90+180/nb_cylinder,[0,0,1])
			translate(v=[0,-wall_thickness/2,0])
	    	color("green")square([2*cos((180/nb_cylinder)-90)*radius,wall_thickness]);   
	    }
	}
}

module half_sphere()
{
	difference()
	{
		sphere(r=radius_cylinder);
		translate(v=[-radius_cylinder,-radius_cylinder,0])cube(radius_cylinder*2,radius_cylinder*2,radius_cylinder*2);
	}
}

//////////////////////////////////////////////////////////
rotate(180,[1,0,0])
	{
	linear_extrude(height = heigth, center = false, convexity = 20, twist = nb_twist , slices = 200, scale = ratio/100)section();

   if(bottom == "Yes")
		translate(v=[0,0,heigth])cylinder(r = (radius+radius_cylinder)*ratio/100,h=3);
/*
//half_spheres
half_spheres	= "No"; // [Yes,No]
	if (half_spheres == "Yes")
	{
		for (nb = [0: nb_cylinder]) 
			{
			rotate(360*nb/nb_cylinder,[0,0,1])
			translate([radius, 0, 0])half_sphere();
			}
	}
*/
}
