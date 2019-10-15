/*

	Guitar nut for acoustic guitar

*/

neckW = 44;
height = 8.5;
depth = 6;

module guitar_nut()
{

	difference()
	{
		//The base cube
		cube([height,neckW,depth],center=true);
		//Cutting off the end in angle
		translate([0.6,0,5])rotate([0,10,0])cube([height+10,neckW+10,depth],center=true);
		//gaps for the strings
		gaps();
	}
}




module gaps()
{
    rotation = -20;
    grooveX = 4.5;
    grooveZ = -6;
    
	translate([grooveX, 18.5,grooveZ]) rotate([0,rotation,0]) cube([-grooveZ,0.3,20]);
	translate([grooveX, 11.1,grooveZ]) rotate([0,rotation,0]) cube([-grooveZ,0.45,20]);
	translate([grooveX,  3.7,grooveZ]) rotate([0,rotation,0]) cube([-grooveZ,0.7,20]);
	translate([grooveX, -3.7,grooveZ]) rotate([0,rotation,0]) cube([-grooveZ,0.9,20]);
	translate([grooveX,-11.1,grooveZ]) rotate([0,rotation,0]) cube([-grooveZ,1.2,20]);
	translate([grooveX,-18.5,grooveZ]) rotate([0,rotation,0]) cube([-grooveZ,1.5,20]);
	
}


guitar_nut();