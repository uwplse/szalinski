//Wheel Diameter [mm]
wheelDiameter = 15;
//Wheel Width [mm]
wheelWidth = 6;
//Axle Diameter [mm]
axleDiameter = 2;
//Number of Spokes
noSpokes = 7;
//Spoke Width [mm]
spokesWidth = 2;
//Tyre Offset [mm]
tyreOffset = 0.4;
//Lip Height [mm]
lipHeight = 1.5;
spokeType = "cube"; // [cube,cylinder]

$fn =100;
module lip()
{
    translate([0,0,wheelWidth/2])
    rotate_extrude(convexity = 10)
    translate([wheelDiameter/2-lipHeight/2,wheelWidth/2,0])rotate(-90)translate([lipHeight/2+tyreOffset,0,0])
    {
        circle(d=lipHeight);
        translate([wheelWidth-lipHeight-tyreOffset*2,0,0])circle(d=lipHeight);
        square([wheelWidth-lipHeight-tyreOffset*2,lipHeight/2]);
        translate([-lipHeight/2-tyreOffset,-lipHeight/2,0])square([wheelWidth,lipHeight/2]);
    }
}
module center()
{
    difference()
    {
        cylinder(axleDiameter*3.2,d = axleDiameter*2);
        translate([0,0,1])cylinder(axleDiameter*3.2,d = axleDiameter);
    }
}  
module spokes()
{
    for (i = [0:noSpokes-1])
    {
        step = 360/noSpokes;
        //echo(step);
        rotate(i*step)translate([axleDiameter*0.75,-spokesWidth/2,0])
        if(spokeType == "cube")
        {
            cube([(wheelDiameter-axleDiameter*2)/2-lipHeight/2,spokesWidth,spokesWidth]);    
        }
        else
        {
            translate([0,spokesWidth/2,spokesWidth/2])rotate(90,[0,1,0])cylinder(h =(wheelDiameter-axleDiameter*2)/2-lipHeight/2,d1 =spokesWidth,d2 =spokesWidth);
           
        }
    }
}




lip();
center();
spokes();