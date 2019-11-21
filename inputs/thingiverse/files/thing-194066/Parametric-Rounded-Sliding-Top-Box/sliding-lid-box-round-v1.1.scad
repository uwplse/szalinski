//parametic rounded sliding lid & box
//john finch 12-1-13

//Version 1.1 12-2-13
//Fixed problem of boxes being slightly under dimensioned due to too few
//facets in the rounded corners.  Reworked the roundedRect module to use
//cylinders with facet count control.  This took the steps out of the rounded
//corners and brought the outside dimensions closer to specified. Compile time 
//is increased.


//User Inputs
width = 47;
len = 66;
height =25;
thickness = 2;
min_wall = 0.7; //remaining wall thickness inside lid groove
radius = 4; // .1 to say 10
//End of user inputs

x1 = len/2;
y1 = width/2;
z1 = 0;


x2 = x1 - thickness;
y2 = y1 - thickness;
z2 = z1 + thickness;

echo (x1,x2,y1,y2);




module roundedRect(size, radius)  //modified William A Adams roundedrect.scad
{
x = size[0];
y = size[1];
z = size[2];
fa=0.01;
fs=0.5;
radius=max(0.1,radius);
radius=min(radius,10);
//echo ("Radius= ",radius);

//echo (x, y, z, radius);


hull()
	{
	translate([-x/2+radius,-y/2+radius,0])
	cylinder(h=z,r1=radius,r2=radius,$fa=1,$fs=fs);
	
	translate([x/2-radius,-y/2+radius,0])
	cylinder(h=z,r1=radius,r2=radius,$fa=1,$fs=fs);

	translate([-x/2+radius,y/2-radius,0])
	cylinder(h=z,r1=radius,r2=radius,$fa=1,$fs=fs);

	translate([x/2-radius,y/2-radius,0])
	cylinder(h=z,r1=radius,r2=radius,$fa=1,$fs=fs);

	}
}
module lid_trimmer(){
difference(){
	translate([-(len+5)/2,-(width+5)/2,0])
	cube([len+5,width+5,thickness+5]);
	roundedRect([len-2*min_wall,width-2*min_wall,thickness+5],radius);
	}

}

module lid(adjust){

difference(){
	polyhedron ( 
				points = [	[-x1,-y2+min_wall+adjust,0], 
							[x2-min_wall-adjust,-y2+min_wall+adjust,0],
							[x2-min_wall-adjust,y2-min_wall-adjust,0], 
							[-x1,y2-min_wall-adjust,0],
							[-x1,-y1+min_wall+adjust,z2],
							[x1-min_wall-adjust,-y1+min_wall+adjust,z2], 
							[x1-min_wall-adjust,y1-min_wall-adjust,z2], 
							[-x1,y1-min_wall-adjust,z2]], 

			triangles = [	[0,5,1], 
							[5,0,4], 
							[1,6,2], 
							[1,5,6], 
							[6,3,2], 
							[6,7,3], 
							[7,0	,3], 
							[4,0,7], 
							[4,6,5], 
							[6,4,7], 
							[0,1,2], 
							[0,2,3]]);
	lid_trimmer();
	}
}

module box() {
difference(){
	
	translate([0,5+width,0])
	roundedRect([len,width,height],radius);

	
	translate([0,5+width,thickness])
	roundedRect([len-2*thickness,width-2*thickness,height],radius-thickness);
	
	translate([0,5+width,height+.1])
	rotate([180,0,0])
	lid(0);
	//cut slot end open
	translate([-thickness,5+width,height+.1])
	rotate([180,0,0])
	lid(0);

	}
	/*
	translate([0,5+width,height+.1])
	rotate([180,0,0])
	lid(.5);
	*/

}

//print lid undersized in length by .5mm and width by 1.0 mm

lid(.5);
	
//lid_trimmer();
box();



