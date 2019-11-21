//propeller module
//test angles and prop sizes for best flight

propD=150;          //outside diameter
propZ=10;            //prop deapth in Z
propBladeW=6;       //prop width, if less than propZ it will not trim
propBladeT=2;       //prop thickness
propBladeP=35;      //prop pitch angle from horizontal
propBladeNum=8;     //number of blades around z axis
ringT=1.5;            //thickness of the outer ring
centerD=15;         //center post diameter
centerHole=8;       //hole for pencil or dowel etc.
centerPost=4;       //additional post height for proper attachment

propR=propD/2;      //prop radius
centerR=centerD/2;  //center post radius

$fa=0.1;


//module for prop with or without outer ring
propeller(true);



module propeller(ring=true)
{
    if (ring==true)
    {
        //outer Ring
        difference()
        {
            //outer diameter of ring
            cylinder(r=propR, h=propZ);
            //inner diameter of ring
            cylinder(r=propR-2*ringT, h=3*propZ, center=true);
        }

        //removes the hole from center and blade edges
        difference()    
        {
            union()
            {
                //rotates blades  around z axis evenly
                for (i= [0 : 360/propBladeNum : 360])   
                {
                    rotate(i)
                        //positions the blade centered on starting x axis
                        translate([propR/2, 0, propZ/2])    
                        difference()
                        {
                            //prop pitch angle from horizontal 
                            rotate([propBladeP, 0, 0])   
                            //prop 
                            cube([propR-ringT, propBladeW*2, propBladeT], center=true);           
                            //blade trim planes
                            union() 
                            {
                                //top trim plane
                                translate([-propD/2, -propD/2, propZ/2])
                                cube([propD, propD, 10]);
                                
                                //bottom trim plane
                                translate([-propD/2, -propD/2, -(propZ/2+10)])
                                cube([propD, propD, 10]);
                                
                            }
                        }
                }
                //Center post
                translate([0, 0, -centerPost])
                cylinder(r=centerR, h=propZ+centerPost);
            }
            //center hole to remove
            translate([0, 0, -(centerPost+((centerD-centerHole)/2))])
            cylinder(r=centerHole/2, h=propZ+centerPost);
        }
        
    }
    else
                //removes the hole from center and blade edges
        difference()    
        {
            union()
            {
                //rotates blades  around z axis evenly
                for (i= [0 : 360/propBladeNum : 360])   
                {
                    rotate(i)
                        //positions the blade centered on starting x axis
                        translate([propR/2, 0, propZ/2])    
                        difference()
                        {
                            //prop pitch angle from horizontal 
                            rotate([propBladeP, 0, 0])   
                            //prop 
                            cube([propR-centerR, propBladeW*2, propBladeT], center=true);           
                            //blade trim planes
                            union() 
                            {
                                //top trim plane
                                translate([-propD/2, -propD/2, propZ/2])
                                cube([propD, propD, 10]);
                                
                                //bottom trim plane
                                translate([-propD/2, -propD/2, -(propZ/2+10)])
                                cube([propD, propD, 10]);
                            }
                        }
                }
                //Center post
                translate([0, 0, -centerPost])
                cylinder(r=centerR, h=propZ+centerPost);
            }
            //center hole to remove
            translate([0, 0, -(centerPost+((centerD-centerHole)/2))])
            cylinder(r=centerHole/2, h=propZ+centerPost);
        }
        
}




