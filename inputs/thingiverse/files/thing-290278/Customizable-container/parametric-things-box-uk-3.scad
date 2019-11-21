// Main solid dimensions
CubeWidth=80;
CubeDepth=400;
CubeHeight=80;
BorderWidth=2;

// Choose on which faces you want the holes. 1 for YES and 0 for NO
HolesFront=1;
HolesLateral=1;
HolesBottom=1;

// Holes in the main solid
HoleWidth=10;
HoleHeight=10;
HorizontalHoleNumber=4;
VerticalHoleNumber=4;

// Calculates space among holes
WidthSpace=((CubeWidth - BorderWidth * 2) - (HoleWidth * HorizontalHoleNumber)) /(HorizontalHoleNumber + 1) ;
DepthSpace=((CubeDepth - BorderWidth * 2) - (HoleWidth * HorizontalHoleNumber)) /(HorizontalHoleNumber + 1) ;
HeightSpace=((CubeHeight - BorderWidth * 2) - (HoleHeight * VerticalHoleNumber)) / (VerticalHoleNumber + 1);


echo("");
echo("");
echo (DepthSpace);
echo("");
echo("");

// Draw the solid
difference () {

	// Draw main solid
	cube ([CubeWidth, CubeDepth, CubeHeight]);
	// Empty main solid with a smaller inner solid
	translate ([BorderWidth, BorderWidth, BorderWidth])
	cube ([CubeWidth-2*BorderWidth, CubeDepth-2*BorderWidth, CubeHeight*1.5]);

	// Front and back holes
	if (HolesFront==1){
		for (z = [0 : VerticalHoleNumber - 1])
		{
		for (x = [0 : HorizontalHoleNumber -1 ])
		{
		translate ([BorderWidth + WidthSpace + (HoleWidth + WidthSpace) * x , -10, BorderWidth +  HeightSpace + (HoleHeight + HeightSpace) * z])
		cube ([HoleWidth, CubeDepth * 1.4, HoleHeight]);
		}
		}
	}
	
	// Lateral holes
	if (HolesLateral==1) {
		rotate ([0,0,90])
		translate ([0, -CubeWidth * 1.2, 0])
		for (z = [0 : VerticalHoleNumber - 1])
		{
		for (x = [0 : HorizontalHoleNumber -1 ])
		{
		translate ([BorderWidth + DepthSpace + (HoleWidth + DepthSpace) * x, -10, BorderWidth +  HeightSpace + (HoleHeight + HeightSpace) * z])
		cube ([HoleWidth, CubeWidth * 1.4, HoleHeight]);
		}
		}
	}

	// Bottom holes
	if (HolesBottom==1){
		rotate ([-90,0,0])
		translate ([0, -CubeWidth * 1.2, 0])
		for (z = [0 : HorizontalHoleNumber - 1])
		{
		for (x = [0 : HorizontalHoleNumber -1 ])
		{
		translate ([BorderWidth + WidthSpace + (HoleWidth + WidthSpace) * x , -10, BorderWidth +  DepthSpace + (HoleHeight + DepthSpace) * z])
		cube ([HoleWidth, CubeWidth * 1.4, HoleHeight]);
		}
		}
	}

}