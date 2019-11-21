/*
    
 ______                                                
/\  _  \                                               
\ \ \L\ \                                              
 \ \  __ \                                             
  \ \ \/\ \                                            
   \ \_\ \_\                                           
    \/_/\/_/                                           
                                                       
                                                       
 ____        __                   __                   
/\  _`\   __/\ \__               /\ \                  
\ \ \L\ \/\_\ \ ,_\    __    ____\ \ \___              
 \ \ ,  /\/\ \ \ \/  /'__`\ /',__\\ \  _ `\            
  \ \ \\ \\ \ \ \ \_/\  __//\__, `\\ \ \ \ \           
   \ \_\ \_\ \_\ \__\ \____\/\____/ \ \_\ \_\          
    \/_/\/ /\/_/\/__/\/____/\/___/   \/_/\/_/          
                                                       
                                                       
 __  __   __                                           
/\ \/\ \ /\ \                                          
\ \ \/'/'\ \ \___      __      ___     ___      __     
 \ \ , <  \ \  _ `\  /'__`\  /' _ `\ /' _ `\  /'__`\   
  \ \ \\`\ \ \ \ \ \/\ \L\.\_/\ \/\ \/\ \/\ \/\ \L\.\_ 
   \ \_\ \_\\ \_\ \_\ \__/.\_\ \_\ \_\ \_\ \_\ \__/.\_\
    \/_/\/_/ \/_/\/_/\/__/\/_/\/_/\/_/\/_/\/_/\/__/\/_/
                                                       
                                                       
 ____                                                  
/\  _`\                  __                            
\ \ \/\ \     __    ____/\_\     __     ___            
 \ \ \ \ \  /'__`\ /',__\/\ \  /'_ `\ /' _ `\          
  \ \ \_\ \/\  __//\__, `\ \ \/\ \L\ \/\ \/\ \         
   \ \____/\ \____\/\____/\ \_\ \____ \ \_\ \_\        
    \/___/  \/____/\/___/  \/_/\/___L\ \/_/\/_/        
                                 /\____/               
                                 \_/__/                

Ritesh Khanna - ritesh@gmail.com

Please enjoy, revise and share this spinning top freely.
I always appriciate it when credit is given back to me!

*/

//Number of rings on the spinning top.
ringCount = 5;
//The diameter of each ring.
ringDiameter = 30; //   [15:80]
//How thick each ring is near the center of the spinning top.
ringInnerDepth = 2; //  [2:5]
//How thick each ring is at the furthest point from the center of the spinning top.  You should make this higher than the inner depth, as we want weight on the outside.
ringOutterDepth = 4; // [2:12]
//The height of each ring is near the center of the spinning top.
ringHeightInner = 2; // [2:5]
//The height of each ring at the furthest point from the center of the spinning top.  You should make this higher than the inner height, as we want weight on the outside.
ringHeightOutter = 6; // [2:12]

//How long you want the spinning shaft to be in the middle/
shaftHeight = 30;   //[15:50]
//The diameter of the shaft at the top
shaftDiameterTop = 6;   //[5:12]
//The diameter of the shaft at the base
shaftDiameterBase = 10; //[5:20]

//How "snug" should the point fit in to the shaft, if you can seem to get it in, increase this number, if it is too lose and falls out, decrease it.
pointInsertClearance = 0.05;
//How long should the point be.
pointHeight = 8;
//How pointy should the point be, 2 is a recommended value for all tops.
pointBallDiameter = 2;

//Thickness of the walls where the point enters the shaft.
shaftHoleWallThickness = 1;
//How deep should the point go in to the shaft.
shaftHoleHeight = 10;

//Quality of the object, higher values will result in smoother edges, but will take longer to render.
quality = 100; //[25:200]

//If you want to only print the body or point, you can
printMode = "both"; //[both, body, point]

//Internal Variables - NO NEED TO EDIT BELOW THIS LINE
ringInnerDiameter = ringDiameter - ringInnerDepth - ringOutterDepth;
ringHeightDelta = ringHeightOutter - ringHeightInner;

if (printMode == "both" || printMode == "body")
{
    rings();
    shaft();
}

if (printMode == "both" || printMode == "point")
{
    point();
}

module point()
{
    translate([ringDiameter,ringDiameter,shaftHoleHeight])
    {
        pointTip();
        translate([0,0,0])
        {
            rotate([0,180,0])
            {
                pointInsert();
            }
        }
    }
}



module pointTip()
{
    cylinder( d1=pointBallDiameter,d1=shaftDiameterBase-pointInsertClearance*2,h=pointHeight,$fn=quality);
    translate([0,0,pointHeight])
    {
        sphere( d=pointBallDiameter,$fn=quality);
    }
}

module pointInsert()
{
    difference()
    {
        cylinder(h=shaftHeight-pointInsertClearance,d1=shaftDiameterBase-shaftHoleWallThickness*2-pointInsertClearance*2,d2=shaftDiameterTop-shaftHoleWallThickness*2-pointInsertClearance*2,$fn=quality);
        
        translate([0,0,shaftHoleHeight + shaftHeight/2])
        {
            cube( [shaftDiameterBase,shaftDiameterBase,shaftHeight], true);
        }
    }
}


module shaft()
{
    difference()
    {
        shaftShell();
        shaftHole();
    }
}

module shaftShell()
{
    cylinder(h=shaftHeight,d1=shaftDiameterBase,d2=shaftDiameterTop,$fn=quality);
    translate([0,0,shaftHeight])
    {
        sphere( d=shaftDiameterTop,$fn=quality);
    }
} 
module shaftHole()
{
    difference()
    {
        cylinder(h=shaftHeight,d1=shaftDiameterBase-shaftHoleWallThickness*2,d2=shaftDiameterTop-shaftHoleWallThickness*2,$fn=quality);
        
        translate([0,0,shaftHoleHeight + shaftHeight/2])
        {
            cube( [shaftDiameterBase,shaftDiameterBase,shaftHeight], true);
        }
    }
}


module rings()
{
    difference()
    {
        ringsWhole();
        shaftHole();
    }
}

module ringsWhole()
{
    for (i = [0:ringCount])
    {
        rotate([0,0, i*(360/ringCount)])
        {
            ring();
        }
    }
}

module ring()
{
    translate([ ringDiameter/-2, 0,0])
    {
        difference()
        {
            difference()
            {
                linear_extrude(ringHeightOutter) { circle( d=ringDiameter ); }
                translate([ ringOutterDepth - ringInnerDepth,0,0])
                {
                    linear_extrude(ringHeightOutter) { circle( d=ringInnerDiameter ); }
                }
            }

            translate([ringDiameter/-2,ringDiameter/-2,ringHeightOutter])
            {
                theta = asin(ringHeightDelta / ringDiameter);
                rotate([0,theta,0])
                {
                    cube( [ringDiameter + 0.2,ringDiameter, ringHeightOutter]);
                }
            }
        }
    }
}