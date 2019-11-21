//Diameter of holes in mm
cableDiameter=4;

//Cables next to each other
xCountCable=3;//[1:14]

//Dual line for cables like 8-pin, 6-pin, 24-pin    Single line for SATA-power
lines=2; //[1:single line,2:dual line]

//Height in mm
height=3;

//Distance between cables
xCableSpace=1.2;

//Distance between lines
yCableSpace=2;

//If your cables fall out, decrase this value. If you can't get them in increase this value. Something between 55-70 worked for me.
opening=65;//[50:70]

module cableComb(cableDiameter, xCountCable, Row, height, xCableSpace, yCableSpace, opening)
{
    difference()
    {
        difference()
        {
            Body(cableDiameter, xCountCable, Row , height, xCableSpace, yCableSpace);
            #Cable(cableDiameter, xCountCable, Row , height, xCableSpace, yCableSpace);
        }
        boxes(cableDiameter, xCountCable, Row, height, xCableSpace, yCableSpace, opening);
    } 
}

module Cable(cableDiameter, xCountCable, Row, height, xCableSpace, yCableSpace)
{   
    $fn=60;
    for(x=[1:xCountCable])
    {
        for(y=[1:Row])
        {
            newX=(cableDiameter+xCableSpace)*(x-1)+xCableSpace+cableDiameter/2;
            newY= cableDiameter/2+(y-1)*(cableDiameter+yCableSpace);
            translate([newX, newY,0])
            cylinder(h=height*2+1, d=cableDiameter, center=true);
        }
    }
}
module boxes(cableDiameter, xCountCable, Row, height, xCableSpace, yCableSpace, opening)
{   
    for(x=[1:xCountCable])
    {
        for(y=[1:Row])
        {
            newX=(cableDiameter+xCableSpace)*(x-1)+xCableSpace+cableDiameter/2;
            newY=(y-1)*(cableDiameter*2+yCableSpace);
            translate([newX, newY,0])
            cube([cableDiameter*opening/100,3,height*2+1], center=true);
        }
    }
}
module Body(cableDiameter, xCountCable, Row , height, xCableSpace, yCableSpace)
{
    xSizeofCube=cableDiameter*xCountCable+(xCountCable+1)*xCableSpace;
    if(Row==2)
    {
        ySizeofCube=cableDiameter*2+yCableSpace;
        $fn=30;
        minkowski(){
            cube([xSizeofCube, ySizeofCube, height-2]);
            sphere(1);
        }    
    }
    else
    {
        ySizeofCube=cableDiameter+yCableSpace;
        $fn=30;
        minkowski(){
            cube([xSizeofCube, ySizeofCube, height-2]);
            sphere(1);
        }    
    }
}
cableComb(cableDiameter, xCountCable, lines, height, xCableSpace, yCableSpace, opening);

