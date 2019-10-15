//Different print configurations.
Configuration = "0"; // [0:Both,1:Left Only,2:Right Only]
//Measured from the bottom inside to the top outside of the body. (Not the ear hook!)
Hearing_Aid_Height = 20;
//Measured from the bottom inside to the bottom ouside of the body.
Hearing_Aid_Length = 10;
//Measured from the thickest point on the body between the left side and the right side of the body.
Hearing_Aid_Width = 5;
//Measured from the bottom inside of the body to the microphone. 
Microphone_Location = 15;
//Average betwen the largest diameter and the inside diameter of the rubberized ear piece.
Headphone_Diameter = 5;
//Determines the strength of the part.
Shell_Distance = 0.5;

module solid()
{
    difference()
    {
    union()
    {
        translate([Microphone_Location,-2,6]) rotate ([90,0,0]) cylinder (h = 4, r=(Headphone_Diameter+Shell_Distance)/2, center = true, $fn=5000);
        difference()
        {
            cube([Hearing_Aid_Height + Shell_Distance*2,Hearing_Aid_Width + Shell_Distance*2,Hearing_Aid_Length + Shell_Distance]);
            translate([Shell_Distance,Shell_Distance,Shell_Distance+1])cube([Hearing_Aid_Height,Hearing_Aid_Width,  Hearing_Aid_Length]);
        }
    }
        translate([Microphone_Location,-2,6]) rotate ([90,0,0]) cylinder (h = 7, r=Headphone_Diameter/2, center = true, $fn=5000);
    }
}

module print_solid()
{
	if (Configuration == "0")
    {
		Both();
	}
    else 
    if (Configuration == "1")
    {
		Left();
    } 
    else 
    if (Configuration == "2")
    {
        Right();
    }
    else
    {
		Both();
	}
}
module Both()
{
    translate([0,-5-Hearing_Aid_Width,0]) solid();
    mirror([0,1,0]) translate([0,-5-Hearing_Aid_Width,0]) solid();
}
module Left()
{
    solid();
}
module Right()
{
    mirror([0,1,0])  solid();
}
print_solid();

