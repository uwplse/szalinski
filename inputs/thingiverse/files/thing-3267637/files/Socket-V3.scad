// Created By :Curtis Jones

isSixPoint = 1;
isMetric = 0;
Socket_Size = 1;
Drive_Size_Numerator = 3;
Drive_Size_Denominator = 8;
Socket_Depth__Negative_1_for_Auto = -1; // -1 For auto
Wall_Thickness = 5;

$fa = .5;
$fs = .1;


//Get hypotenuse where A = B
function SquareHypotenuse(Length) = sqrt((Length * Length)*2);

//Get side lenght from hight of equilateral triangle
function LenghtViaHight(Height) = sqrt((Height * Height * 4)/3) ;

//Inch To Milimeter
function InToMm(Inches) = Inches * 25.4;

//Drive size is in inches to standardize.
module Socket(Size , Drive = 0.25, Depth = -1, Walls = 2,  SixPoint=false , Tolerance = 0.4)
{
    // Convert dive size from inches to mm
    drive = InToMm(Drive);

    
    //Variable = Condition ? True : False
    
    //Set the outer size based on wich is bigger drive or bolt hole.
    SocketOuter = Size < drive ? SquareHypotenuse(drive)+Walls : SquareHypotenuse(Size)+Walls;
    
    //Set width of Cube to rotate for bolt hole.
    SideSixPoint = SixPoint ? LenghtViaHight(Size/2) : Size ;
    
    //Calulated 3 time so this is olny an optimisation
    DriveCtr = drive/2;
    
    //Since calculations can't be in the module definition it is calulated here.
    depth = (Depth <= 0) ? Size * 2 : Depth;
    height = depth + drive;
    
    // Move to positive coord
    translate([(SocketOuter/2)+Tolerance,(SocketOuter/2)+Tolerance,(height/2)+Tolerance])
    {
    
        difference()
        {
            //Creates the outer shell to cut from
            minkowski()
            {
                cylinder(height,d=SocketOuter,center = true );
                sphere(Tolerance);
            }
            union()
            {
                //Cuts the bolt hole
                translate([0,0,DriveCtr])
                {
                    for(i = [0,60,120])
                    {
                        rotate([0,0,i])
                        {
                            minkowski()
                            {
                                cube([Size,SideSixPoint,depth+Tolerance],center = true);
                                sphere(Tolerance);
                            }
                        }
                    }
                }
                
                translate([0,0,(DriveCtr)-(height/2)])
                {
                    //Cuts the drive hole
                    minkowski()
                    {
                        cube([drive,drive,drive+Tolerance], center = true );
                        sphere(Tolerance);
                    }
                    //Cuts the ball bearing retainer hole
                    translate([DriveCtr,0,0])
                    {
                        sphere(1, center = true);
                    }
                }
            }
        }
    }
}
Socket_Depth = Socket_Depth__Negative_1_for_Auto;
Drive_Size = Drive_Size_Numerator / Drive_Size_Denominator ;

if(isMetric)
{
    Socket(Socket_Size,Drive_Size,Socket_Depth,SixPoint=isSixPoint);
}else{
    Socket(InToMm(Socket_Size),Drive_Size,Socket_Depth,Wall_Thickness,SixPoint=isSixPoint);
}


