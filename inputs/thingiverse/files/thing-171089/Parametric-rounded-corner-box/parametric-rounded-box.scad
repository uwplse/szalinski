//outer size (x)
size_x=50;

//outer size (x)
size_y=30;


//wall thickness
size_z=0.5;

//radius or the rounded corners
corner_radius=5;

//total number of faces for all corners
corner_faces=32;

spacing=size_z+1;
size_x_2=size_x+spacing;
size_y_2=size_y+spacing;

//height of the box
rim_height=10;

rim_height_2=rim_height/2;

module plate (sizeX, sizeY, sizeZ, cornerRadius, cornerFaces)
{
	union()
	{
		difference()
		{
			cube([sizeX,sizeY,sizeZ]);		
			cube([cornerRadius,cornerRadius,	sizeZ+1]);
			translate([sizeX-cornerRadius,0,0]) cube([cornerRadius,cornerRadius,sizeZ+1]);
			translate([0,sizeY-cornerRadius,0]) cube([cornerRadius,cornerRadius,sizeZ+1]);
			translate([sizeX-cornerRadius,sizeY-cornerRadius,0]) cube([cornerRadius,cornerRadius,sizeZ+1]);
		}
		translate([cornerRadius,cornerRadius,0]) cylinder(r=cornerRadius,h=sizeZ, $fn=cornerFaces);
		translate([sizeX-cornerRadius,cornerRadius,0]) cylinder(r=cornerRadius,h=sizeZ, $fn=cornerFaces);
		translate([cornerRadius,sizeY-cornerRadius,0]) cylinder(r=cornerRadius,h=sizeZ, $fn=cornerFaces);
		translate([sizeX-cornerRadius,sizeY-cornerRadius,0]) cylinder(r=cornerRadius,h=sizeZ, $fn=cornerFaces);
	}
}


//Generate box
union()
{
	difference()
	{
		plate (size_x, size_y,rim_height, corner_radius, corner_faces);
		translate([size_z,size_z,0])
		plate (size_x-(2*size_z), size_y-(2*size_z),rim_height, corner_radius-size_z, corner_faces);
	}
	plate (size_x, size_y, size_z, corner_radius, corner_faces);
}

//Generate lid
translate([0,size_y+10,0])

//assembled view
//translate([size_x+(spacing/2),-(spacing/2),rim_height+size_z])
//rotate([0,180,0])


#union()
{
	difference()
	{
		plate (size_x_2, size_y_2,rim_height_2, corner_radius, corner_faces);
		translate([size_z,size_z,0])
		plate (size_x_2-(2*size_z), size_y_2-(2*size_z),rim_height_2, corner_radius-size_z, corner_faces);
	}
	plate (size_x_2, size_y_2, size_z, corner_radius, corner_faces);
}


