//base plate
size_x=100;
size_y=50;
size_z=1;
corner_radius=5;
corner_faces=32;

//cutout
cutout_corner_radius=2;
cutout_corner_faces=32;
offset_x=10;
offset_y=8;

//rim
rim_height=10;

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

module posts()
{

	union()
	{
		difference()
		{
			translate([0+2.775,0+2.6,size_z]) cylinder(r1=6/2, r2=5/2,h=7, $fn=32);	
			translate([0+2.775,0+2.6,size_z]) cylinder(r=3/2,h=7.5, $fn=16);
		}
		difference()
		{
			translate([0+2.775,31+2.6,size_z]) cylinder(r1=6/2, r2=5/2,h=7, $fn=32);
			translate([0+2.775,31+2.6,size_z]) cylinder(r=3/2,h=7.5, $fn=16);
		}

		difference()
		{
			translate([74.60+2.775,0+2.6,size_z]) cylinder(r1=6/2, r2=5/2,h=7, $fn=32);
			translate([74.60+2.775,0+2.6,size_z]) cylinder(r=3/2,h=7.5, $fn=16);
		}	

		difference()
		{
			translate([74.60+2.775,31+2.6,size_z]) cylinder(r1=6/2, r2=5/2,h=7, $fn=32);
			translate([74.60+2.775,31+2.6,size_z]) cylinder(r=3/2,h=7.5, $fn=16);
		}
	}
}


difference()
{
plate (size_x, size_y,rim_height, corner_radius, corner_faces);
translate([size_z,size_z,0])
plate (size_x-(2*size_z), size_y-(2*size_z),rim_height, corner_radius-size_z, corner_faces);
}

union()
{
difference()
{
//base plate
plate (size_x, size_y, size_z, corner_radius, corner_faces);

//display cutout
translate([7.75+offset_x,8.8+offset_y,0])
plate(64.5,15.9,10,cutout_corner_radius,cutout_corner_faces);

}
translate([offset_x,offset_y,0])
posts();
}


