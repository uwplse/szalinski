/*
    

This is a remix of the sharpie holder created by Ritesh Khanna - ritesh@gmail.com

I added Multiple rows and a name entry. Hope you enjoy!



*/
font = "Liberation Sans";

holeCount = 12;          //Number of sharpies per row.
rowCount = 5;           //Number of Rows
name = "Name";
markerDiameter = 11.5;   //Diameter of Markers
holeWallThickness = 1.5;//Wall Thickness of the holes
holeHeight = 25;        //Height of each hole
holeGap = .5;            //Distance between each hole
angle=15;                //Angle of each hole


// these probably don't need to be changed
letter_size = 10;       //Size of letters for name extrusion
baseHeight = 2;         //Thickness of base.
holeDiameter= markerDiameter + holeWallThickness;        //Diameter INCLUDING wall thickness of each hole.

//Logic, no need to edit below this line.
difference()
{
    holes();
    translate([0,0,-holeHeight])
    {
        base(holeHeight,18);
    }
}
translate([2,0,0])


base(baseHeight,18);

module base(height, addedDepth)
{
    length = (holeDiameter + holeGap) * holeCount + holeGap;
    translate([ -( holeDiameter / 2 + holeGap * 2) ,-holeGap,0])
    {
        cube( [(holeDiameter + holeGap * 4)*rowCount + addedDepth,length,height]);
    };
    // Add a name
    translate([(holeDiameter + holeGap * 4)*rowCount + addedDepth-letter_size-2,length/2,height])
    rotate (90,0,0)
    {
        linear_extrude(height = 5) {
            text(name, size = letter_size, font = font, halign = "center", valign = "bottom", $fn = 16);
        }
    }
}

module holes()
{
    for (i = [0:rowCount-1])
    {
        for (j = [0:holeCount-1])
        {
            translate([i* (holeDiameter + holeGap) + holeDiameter *0.5,j * (holeDiameter + holeGap) + holeDiameter *0.5, -(sin(25) * (holeDiameter/2) ) -0.1 ])
            {
                rotate([0,angle,0])
                {
                    linear_extrude(holeHeight)
                    {
                        difference()
                        {
                            circle(d=holeDiameter);
                            circle(d=(holeDiameter-holeWallThickness));
                        }
                    }
                }
            }
        }
    }
}