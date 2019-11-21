
size_x=100;
size_y=50;
size_z=1;
corner_radius=5;
corner_faces=32;



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

plate (size_x, size_y, size_z, corner_radius, corner_faces);
