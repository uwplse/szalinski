//parametic rounded sliding lid & box
//john finch 12-1-13


//User Inputs
width = 30;
len = 76;
height =22;
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


echo (x, y, z, radius);

linear_extrude(height=z)
hull()
{
// place 4 circles in the corners, with the given radius
translate([(-x/2)+(radius), (-y/2)+(radius), 0])
circle(r=radius);

translate([(x/2)-(radius), (-y/2)+(radius), 0])
circle(r=radius);

translate([(-x/2)+(radius), (y/2)-(radius), 0])
circle(r=radius);

translate([(x/2)-(radius), (y/2)-(radius), 0])
circle(r=radius);
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



