//CUSTOMIZER VARIABLES

//	This section is displays the disk options
//	Diameter of disk
Diameter = 100;	

//	Thickness of the disk
Thickness = 10;	

//	Hole in the disk
Hole_disk = "no"; // [yes,no]	

//	Diameter of the hole in the disk
Diameter_hole = 25;


if (Hole_disk=="yes")
{
    difference() {
 	cylinder(h = Thickness, r=Diameter/2);
	cylinder(h = Thickness, r=Diameter_hole/2);
 	}
} else {
    cylinder(h = Thickness, r=Diameter/2);
}