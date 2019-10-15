lengthOverall = 50; //Overall length of part
widthOverall = 25; //Width of part
partThickness = 3; //Thickness
partAngle = 60; //Angles between 0 and 90 degrees
mainWallHeight = 25; //Height of main vertical wall
secondWallScale = 0.4; //Height of second vertical wall % of main wall
ironMajorDiameter = 20; //diameter of soldering iron grip near the hot end
ironMinorDiameter = 15; //diameter of soldering iron grip near electrical cord

module SolderStand(thickness,Width, Length,Height, smallWallScale, Angle,Diameter, minorDiameter){
    
    
    Angle = 180-Angle;
    echo(Angle);
    //Check to ensure a valid angle has been entered
    if ((Angle>=90) && (Angle <=180)){
    secondWallHeight = Height*smallWallScale;
    echo(secondWallHeight);
    union(){
    union(){
    union(){
    //Base of Stand       
    cube(size=[Width,Length,thickness], center=true);
    //Tall Side Wall    
    translate([0, Length*0.5,Height*0.5-thickness*0.5]){
        rotate([90,0,0]){
            cube(size=[Width,Height,thickness], center=true);
        }
    }
    }
    
    //Short Side Wall 
    translate([0,-(Length*0.5),secondWallHeight*0.5-thickness*0.5]){
        rotate([90,0,0]){
        cube(size=[Width, secondWallHeight, thickness], center=true);
        }
    }
    }
    //Top Soldering Iron Rest   
    translate([-Width*0.5,Length*0.5+thickness*0.5, Height-thickness*0.5]){
        rotate([Angle,0,0])
        {
        difference(){
        cube(size=[Width, Height*0.5, thickness]);
        translate([Width*0.5,Height*0.5,0]){
        cylinder(r=Diameter*0.5,h=thickness);
        }
        }
        }
    }
    //Bottom Soldering Iron Rest
    translate([-Width*0.5, -(Length*0.5)+thickness*0.5,secondWallHeight-thickness*0.5]){
        rotate([Angle,0,0]){
            difference(){
            cube(size=[Width, secondWallHeight, thickness]);
            
            
            translate([Width*0.5,secondWallHeight,0]){
            cylinder(r=minorDiameter*0.5,h=thickness);
            }
            }
            
        }
    }
    }
    }
    //Error message if valid angle not entered
    else
    {
        echo("Use valid angle");
        }
}

SolderStand(partThickness,widthOverall, lengthOverall, mainWallHeight, secondWallScale, partAngle, ironMajorDiameter, ironMinorDiameter, $fn=100);