$fn = 100;

/*
    D c C
    /---\
  d/  |h \b
  /-------\
  A   a    B

*/

//length of the prism rail 
length = 80;//[0:160]


//wider part of the prism
a = 43;

//smaller part of the prism
c = 37;

//height of the prism
h = 15;



// b = sqrt( ((c-a)/2)*((c-a)/2) + h*h )// d = b


module GP_Level_prism_rail_trapezoid()
{
	translate([-c/2,-h/2,-length/2])
	{
		linear_extrude(height=length)
		{
			union()
			{
				square([c,h]);
				translate([c,0,0]) polygon(points=[[0,0],[(a-c)/2,0],[0,h]], paths=[[0,1,2]]);
				translate([0,0,0]) mirror([1,0,0]) polygon(points=[[0,0],[(a-c)/2,0],[0,h]], paths=[[0,1,2]]);
			}
		}
	}
	
}



module GP_Level_prism_rail()
{
	rotate(a=[90,0,0])
	difference()
	{
		GP_Level_prism_rail_trapezoid();

		translate([0,-1.5,0]) scale(0.9) GP_Level_prism_rail_trapezoid();

		for(i = [-length/4:length/4])
		{
			translate([0,20,i]) rotate(a=[90,0,0]) cylinder(r=6.4/2, h=50);
		}

	}
}

GP_Level_prism_rail();


