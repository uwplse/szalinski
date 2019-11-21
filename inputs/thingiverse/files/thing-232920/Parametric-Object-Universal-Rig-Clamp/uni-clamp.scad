//M. Haris Usmani
//http://harisusmani.com

//All Units are in mm, Import as STL with Unit=mm

/* [Main Settings] */
//Radius of Pipe in Inches (Schedule 40)
R=1.9; //[2.375:2"PVC,1.9:1-1/2"PVC,1.660:1-1/4"PVC,1.315:1"PVC]

//Space for Tightening
T=3; //[0:5]

//Nut Size
M=5; //[4,5,6]

/////////////////////////////////////////////////////////////////////////////
R_mm=R*25.4; //Converted to mm!
//Strength of Clamp (Fixed)
S=1.2; // [1.2] Determines Strength of Clamp in Percentage-FIXED!

/////////////////////////////////////////////////////////////////////////////
//Hexagonal Module from shapes.scad, http://svn.clifford.at/openscad/trunk/libraries/shapes.scad by Catarina Mota
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
/////////////////////////////////////////////////////////////////////////////

//Pipe Model for Visualization
//translate([R_mm*S/2,R_mm*S/2,-R_mm*6]) cylinder(R_mm*10,R_mm/2,R_mm/2);

union()//Main Duplication
{

difference() //Pipe Hole
{
union()
{
minkowski() //Fillet
{
	union()
	{
		cube([R_mm*S,R_mm/2*S, R_mm*S]); //Main Body
		translate([R_mm*S/2,R_mm*S/2,0]) cylinder(R_mm*S,R_mm*S/2,R_mm*S/2); //Curved Edge
	}
	sphere([R_mm/2,R_mm,R_mm*5/12]); //Fillet Object
}

minkowski() //Fillet
{
	difference() //Hard Chamfer
	{
		translate([-R_mm/4,R_mm/5,(R_mm/2)-(R_mm*5/48)]) cube([R_mm/2,R_mm/1.4,R_mm*5/12]);
		translate([-R_mm,-R_mm*7/17,(R_mm/2)-(R_mm*5/24)]) rotate([0,0,-33]) cube([R_mm/2,R_mm,2*R_mm*5/12]);
	}
	sphere([R_mm/2,R_mm,R_mm*5/12]); //Fillet Object
}
}
	union()
	{
		translate([R_mm*S/2,R_mm*S/2,-R_mm*6]) cylinder(R_mm*10,R_mm/2,R_mm/2);//Pipe
		translate([-R_mm,R_mm*S*5/12,-R_mm]) cube([R_mm*2,R_mm/(15-T),R_mm*4]);//Tightning Space
		translate([-R_mm/7,R_mm*2,(R_mm*S/2)]) rotate([90,0,0]) cylinder((R_mm*4),M/2,M/2); //Screw Space
		if (M==4) translate([-R_mm/7,-R_mm*0.2,(R_mm*S/2)]) rotate([90,0,0]) hexagon(7.66,50); //NUTS
		if (M==5) translate([-R_mm/7,-R_mm*0.2,(R_mm*S/2)]) rotate([90,0,0]) hexagon(8.79,50);
		if (M==6) translate([-R_mm/7,-R_mm*0.2,(R_mm*S/2)]) rotate([90,0,0]) hexagon(11.05,50);
	}
} //Single Side ENDS

}

{

translate([R_mm*S,1,R_mm*S]) rotate([180,90,0]) //Main Translation

//COPY SIDE HERE
difference() //Pipe Hole
{
union()
{
minkowski() //Fillet
{
	union()
	{
		cube([R_mm*S,R_mm/2*S, R_mm*S]); //Main Body
		translate([R_mm*S/2,R_mm*S/2,0]) cylinder(R_mm*S,R_mm*S/2,R_mm*S/2); //Curved Edge
	}
	sphere([R_mm/2,R_mm,R_mm*5/12]); //Fillet Object
}

minkowski() //Fillet
{
	difference() //Hard Chamfer
	{
		translate([-R_mm/4,R_mm/5,(R_mm/2)-(R_mm*5/48)]) cube([R_mm/2,R_mm/1.4,R_mm*5/12]);
		translate([-R_mm,-R_mm*7/17,(R_mm/2)-(R_mm*5/24)]) rotate([0,0,-33]) cube([R_mm/2,R_mm,2*R_mm*5/12]);
	}
	sphere([R_mm/2,R_mm,R_mm*5/12]); //Fillet Object
}
}
	union()
	{
		translate([R_mm*S/2,R_mm*S/2,-R_mm*6]) cylinder(R_mm*10,R_mm/2,R_mm/2);//Pipe
		translate([-R_mm,R_mm*S*5/12,-R_mm]) cube([R_mm*2,R_mm/(15-T),R_mm*4]);//Tightning Space
		translate([-R_mm/7,R_mm*2,(R_mm*S/2)]) rotate([90,0,0]) cylinder((R_mm*4),M/2,M/2); //Screw Space
		if (M==4) translate([-R_mm/7,-R_mm*0.2,(R_mm*S/2)]) rotate([90,0,0]) hexagon(7.66,50); //NUTS
		if (M==5) translate([-R_mm/7,-R_mm*0.2,(R_mm*S/2)]) rotate([90,0,0]) hexagon(8.79,50);
		if (M==6) translate([-R_mm/7,-R_mm*0.2,(R_mm*S/2)]) rotate([90,0,0]) hexagon(11.05,50);
	}
}
///////////////
}

//preview[view: north, tilt: top];
