//This is my first attempt at designing something in OpenSCAD and is made to replace the FreeCAD export that I had, because it was difficult to modify. 
//Designed by Kyle Randall
//////////////////////////////////////////////////
//Edit the parameters below to modify the outer dimensions of your hollow calibration cube; it will still remain hollow, but you can adjust the wall thickness.

X=20.0;//this is X-axis length (left-right)
Y=20.0;//this is the Y-axis (forward-back)
Z=20.0;// this is the Z-axis (up-down)
Wall_Thickness=1.0;//wall thickness in mm
//don't edit the code below unless you know what you're doing

module thing()
{
	difference(){
		cube([X,Y,Z], center = true);
		cube([X-Wall_Thickness*2,Y-Wall_Thickness*2,Z-Wall_Thickness*2],center=true);//the size of the inner cube
	
	}
}
thing();