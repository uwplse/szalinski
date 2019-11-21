Length = 50;
Thickness = 6;
holeDiameter = 3;
Height = 15;



difference()
{
    union()
    {
        walls();
        lip();
        plate();
        brace();
    }
    holes();
    MountingSlot();
}




// slot lip
module lip()
{
    hull()
    {
        translate([-1, 0, Height/2 + .5]) cube ([1,Length,1]);
        translate([0, 0, Height/2 - 1.5]) cube ([1,Length,1]);
    }

    hull()
    {
        translate([ 0,-1, Height/2 + .5]) cube ([Length,1,1]);
        translate([0, 0, Height/2 - 1.5]) cube ([Length,1,1]);
    }
}


module MountingSlot()
{
hull()
{
 translate([Length/2+holeDiameter, Length/2-holeDiameter, 0]) 
      cylinder(d=holeDiameter, h=Thickness +1);
 translate([Length/2-holeDiameter, Length/2+holeDiameter, 0]) 
      cylinder(d=holeDiameter, h=Thickness +1);
}
}

// holes
module holes()
{
translate([Length-15, -.5, Height/2]) 
    rotate([-90,0,0]) 
        cylinder(d=holeDiameter, h=Thickness +1);
translate([Length-15, -Thickness, Height/2]) 
    rotate([-90,0,0]) 
        cylinder(r=holeDiameter, h=Thickness );

translate([Length-15-15, -.5, Height/2]) 
    rotate([-90,0,0]) 
        cylinder(d=holeDiameter, h=Thickness +1);
 translate([Length-15-15, Thickness, Height/2]) 
    rotate([-90,0,0]) 
        cylinder(r=holeDiameter, h=Thickness );
 translate([Length-15-15, -Thickness, Height/2]) 
    rotate([-90,0,0]) 
        cylinder(r=holeDiameter, h=Thickness );
     
  
    
translate([ -.5,Length-15, Height/2]) 
    rotate([0, 90, 0]) 
        cylinder(d=holeDiameter, h=Thickness +1);
translate([ -Thickness,Length-15, Height/2]) 
    rotate([0,90,0]) 
        cylinder(r=holeDiameter, h=Thickness );
    
translate([ -.5,Length-15-15, Height/2]) 
    rotate([0,90,0]) 
        cylinder(d=holeDiameter, h=Thickness +1);
translate([ Thickness,Length-15-15, Height/2]) 
    rotate([0,90,0]) 
        cylinder(r=holeDiameter, h=Thickness );
translate([ -Thickness,Length-15-15, Height/2]) 
    rotate([0,90,0]) 
        cylinder(r=holeDiameter, h=Thickness );
}



module walls()
{
//walls
cube ([Thickness,Length,Height]);
cube ([Length,Thickness,Height]);
}


//angle plate
module plate()
{
hull()
{
    cube ([Thickness,Length,4]);
    cube ([Length,Thickness,4]);
    cube ([1,15,4]);
}
}


// inner brace
module brace()
{
hull()
{
    translate([0,0,Height-1]) cube ([Thickness,Height+Thickness,1]);
    translate([0,0,Height-1]) cube ([Height+Thickness,Thickness,1]);
    cube ([Thickness,Thickness,Height]);
}   
}

