//base plate
size_x=100;
size_y=50;
size_z=1;
corner_radius=3;
corner_faces=64;

//cutout
cutout_corner_radius=1;
cutout_corner_faces=16;
offset_x=10;
offset_y=8;

//rim
rim_height=16;

module plate (sizeX, sizeY, sizeZ, cornerRadius, cornerFaces)
{
    translate([cornerRadius, 0, 0])
        cube([sizeX - 2 * cornerRadius, sizeY, sizeZ]);		
    translate([0, cornerRadius, 0])
        cube([sizeX, sizeY - 2 * cornerRadius, sizeZ]);		
    translate([cornerRadius,cornerRadius,0])
        cylinder(r=cornerRadius,h=sizeZ, $fn=cornerFaces);
    translate([sizeX-cornerRadius,cornerRadius,0])
        cylinder(r=cornerRadius,h=sizeZ, $fn=cornerFaces);
    translate([cornerRadius,sizeY-cornerRadius,0])
        cylinder(r=cornerRadius,h=sizeZ, $fn=cornerFaces);
    translate([sizeX-cornerRadius,sizeY-cornerRadius,0])
        cylinder(r=cornerRadius,h=sizeZ, $fn=cornerFaces);
}

module posts()
{

	union()
	{
		difference()
		{
			translate([0+2.775,0+2.6,size_z]) cylinder(r1=6/2, r2=5/2,h=7, $fn=32);	
			translate([0+2.775,0+2.6,size_z]) cylinder(r=1,h=7.5, $fn=16);
		}
		difference()
		{
			translate([0+2.775,31+2.6,size_z]) cylinder(r1=6/2, r2=5/2,h=7, $fn=32);
			translate([0+2.775,31+2.6,size_z]) cylinder(r=1,h=7.5, $fn=16);
		}

		difference()
		{
			translate([74.60+2.775,0+2.6,size_z]) cylinder(r1=6/2, r2=5/2,h=7, $fn=32);
			translate([74.60+2.775,0+2.6,size_z]) cylinder(r=1,h=7.5, $fn=16);
		}	

		difference()
		{
			translate([74.60+2.775,31+2.6,size_z]) cylinder(r1=6/2, r2=5/2,h=7, $fn=32);
			translate([74.60+2.775,31+2.6,size_z]) cylinder(r=1,h=7.5, $fn=16);
		}
	}
}


difference()
{
    plate (size_x, size_y,rim_height, corner_radius, corner_faces);
    translate([size_z,size_z,-size_z])
        plate (size_x-(2*size_z), size_y-(2*size_z),rim_height + size_z * 2, corner_radius-size_z, corner_faces);
}

union()
{
    difference()
    {
        //base plate
        plate (size_x, size_y, size_z, corner_radius, corner_faces);
        //display cutout
        translate([7.75+offset_x,8.8+offset_y,-size_z * 5])
            plate(64.5,15.9,10,cutout_corner_radius,cutout_corner_faces);

    }
    translate([offset_x,offset_y,0])
        posts();
}


