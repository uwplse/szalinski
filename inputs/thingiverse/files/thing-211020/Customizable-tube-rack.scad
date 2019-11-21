//Customizable test tube rack
//by Iron Momo

// preview[view:north, tilt:top]

/* [Basic] */

//Number of tubes
nb_tubes = 5; //[1:20]
//Number of rows
nb_rows = 1; //[1:10]

//Tubes diameter (mm)
hole_diameter = 20;

//Material thickness (mm)
thickness = 5; //[3,4,5,10]

//Total height (mm)
height1 = 80;
//Middle height (mm)
height2 = 20;


output_type = "STL"; //[DXF,STL]

/* [Hidden] */
inter=10;
width1 = nb_tubes*hole_diameter + (nb_tubes+1)*inter;
width2 = nb_tubes*hole_diameter + (nb_tubes+1)*inter+2*thickness;
depth1= nb_rows*hole_diameter+nb_rows*inter;
depth2= nb_rows*hole_diameter+nb_rows*inter+2*thickness;

if(output_type=="STL")
{linear_extrude(height = thickness, center = false) rack_creation();
}

if(output_type=="DXF")
{rack_creation();}

module rack_creation()
{
bottom();
translate([0,depth2+5,0]) middle();
translate([0,2*depth2+10,0]) top();
translate([0,-height2-15,0])side1();
translate([0,-2*height2-30,0])side1();
translate([-5,-2*height2-30,0])rotate([0,0,90])side2();
translate([-5,height1-2*height2,0])rotate([0,0,90])side2();

}



module bottom()
{
difference()
{
	square([width2,depth2]);
	for (i = [1:nb_tubes])
		{
			translate([thickness+i*inter+(i-1)*hole_diameter,0,0]) square([hole_diameter,thickness]);

			translate([thickness+i*inter+(i-1)*hole_diameter,depth1+thickness,0]) square([hole_diameter,thickness]);
		}

	translate([0,depth2/5,0]) square([thickness,depth2/5]);
	translate([0,3*depth2/5,0]) square([thickness,depth2/5]);

	translate([width1+thickness,depth2/5,0]) square([thickness,depth2/5]);
	translate([width1+thickness,3*depth2/5,0]) square([thickness,depth2/5]);
}
}


module top()
{
difference()
{
	square([width2,depth2]);
	for (i=[0:nb_rows-1])
		{
			for (j = [1:nb_tubes])
				{
					translate([thickness+j*inter+(j-1)*hole_diameter+hole_diameter/2,thickness+inter/2+hole_diameter/2+i*(hole_diameter+inter),0]) circle(hole_diameter/2);
				}
		}

	translate([0,depth2/5,0]) square([thickness,depth2/5]);
	translate([0,3*(depth2/5),0]) square([thickness,depth2/5]);

	translate([width1+thickness,depth2/5,0]) square([thickness,depth2/5]);
	translate([width1+thickness,3*(depth2/5),0]) square([thickness,depth2/5]);
}
}

module middle()
{
difference()
{
top();
for (i = [1:nb_tubes])
	{
		translate([thickness+i*inter+(i-1)*hole_diameter,0,0]) square([hole_diameter,thickness]);

		translate([thickness+i*inter+(i-1)*hole_diameter,depth1+thickness,0]) square([hole_diameter,thickness]);
	}
}
}


module side1()
{
difference()
{
	translate([0,thickness,0]) square([width2,height2]);

	translate([0,thickness+height2/3,0]) square([thickness,height2/3]);
	translate([width1+thickness,thickness+height2/3,0]) square([thickness,height2/3]);
}
for (i = [1:nb_tubes])
	{
		translate([thickness+i*inter+(i-1)*hole_diameter,0,0]) square([hole_diameter,thickness]);

		translate([thickness+i*inter+(i-1)*hole_diameter,height2+thickness,0]) square([hole_diameter,thickness]);
	}
}

module side2()
{
difference() 
{
	//Forme de base
	translate([thickness,0,0]) square([height1,depth2]);

	//Trous middle
	translate([height2+thickness,0,0]) square([thickness,depth2/5]);
	translate([height2+thickness,4*depth2/5,0]) square([thickness,depth2/5]);
	translate([height2+thickness,2*depth2/5,0]) square([thickness,depth2/5]);

	//Trous side1
	translate([thickness,0,0]) square([height2/3,thickness]);
	translate([thickness,depth1+thickness,0]) square([height2/3,thickness]);
	translate([thickness+2*height2/3,0,0]) square([height2/3,thickness]);
	translate([thickness+2*height2/3,depth1+thickness,0]) square([height2/3,thickness]);


}

//Ajout bottom
translate([0,depth2/5,0]) square([thickness,depth2/5]);
translate([0,3*(depth2/5),0]) square([thickness,depth2/5]);


//Ajout top
translate([height1+thickness,depth2/5,0]) square([thickness,depth2/5]);
translate([height1+thickness,3*(depth2/5),0]) square([thickness,depth2/5]);



}




