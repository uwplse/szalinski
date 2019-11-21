number_of_holes=3; // [2:6]
hole_Angle=20; // [0:40]
hole_Size=12;
thickness=15;
additional_gerth=0;



divider=360/number_of_holes;
holeRadius=hole_Size/2;

if (hole_Angle > 20) 
{
  printitem(hole_Angle-20);
} else {
  printitem(0);
}






module printitem(invar) {
	pieceSize=(hole_Size*3.33)+number_of_holes+invar+additional_gerth;
	pieceRadius=pieceSize/2;
	difference(){
		cylinder(r=pieceRadius,h=thickness);
		for (a=[0:number_of_holes-1]) {
			rotate([0,0,divider*a])translate([0,hole_Size-(5-number_of_holes),-10])rotate([0,hole_Angle,0])cylinder(r=holeRadius,h=thickness*3);
		}

	}
}