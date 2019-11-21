//CUSTOMIZER VARIABLES

//Outside diameter of the pipe to cap (mm)
insideDiameter = 112;

//Thickness of the walls of the cap (mm)
wallThickness = 2;

//Total height of the slider (mm)
height = 25;

//	Marker Diameter (mm)
diameter = 10;	//	[5:30]

//CUSTOMIZER VARIABLES END

outsideDiameter = insideDiameter + wallThickness;

outsideRadius = outsideDiameter / 2;
insideRadius = insideDiameter / 2;
edgeHeight = height;
        
difference() {
    cylinder(r=outsideRadius, h=edgeHeight);
    cylinder(r=insideRadius, h=edgeHeight+1);
}

translate([0,0,edgeHeight/2]) 
{
    rotate(90, [0, 1, 0])
    {
        markerOnAStick(0, 10, 10);
        markerOnAStick(25, 10, 10);
        markerOnAStick(75, 10, 10);
        markerOnAStick(110, 10, 10);
        markerOnAStick(155, 10, 10);
        markerOnAStick(205, 10, 10);
        markerOnAStick(265, 10, 10);
        markerOnAStick(325, 10, 10);
    }
}

module markerOnAStick(rot, length, diameter)
{
    rotate(rot, [1, 0, 0])
    {
        translate([0,insideRadius,0]) 
        {
            rotate(-90, [1, 0, 0])
            {
                cylinder(length, diameter / 4);
                translate([0,0,length]) 
                {
                    sphere(diameter / 2);
                }
            }
        }
    }
}

