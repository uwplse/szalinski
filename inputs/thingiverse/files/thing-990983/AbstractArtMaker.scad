//Abstact Art Maker

Height = 40;

Twist = 360;

Scale = 0;

Slices = 10;

//Base Width
Width = 20;

//Base Length
Length = 10;

linear_extrude(height = Height, twist = Twist, scale = Scale,  slices = Slices)
            square([Width, Length]);