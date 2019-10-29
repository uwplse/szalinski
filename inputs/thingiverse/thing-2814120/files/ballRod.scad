//All in milimeters
ballDiameter = 35;
rodDiameter = 7.6;
flatBottom = 5;

$fn = 50;

difference()
{
    sphere(ballDiameter/2);
    translate([0,0,-ballDiameter/2+flatBottom/2]){
    cube([ballDiameter,ballDiameter, flatBottom], center=true); 
    cylinder(ballDiameter, rodDiameter/2, rodDiameter/2, center = true);   
    }
    translate([0,0, flatBottom/2])
    {
        sphere(rodDiameter/2);   
    }
}
