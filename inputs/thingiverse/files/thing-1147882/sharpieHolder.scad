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

Please enjoy, revise and share this sharpie marker holder freely.
I always appriciate it when credit is given back to me!

*/

holeCount = 8;          //Number of sharpies to hold.
holeDiameter=12;        //Diameter INCLUDING wall thickness of each hole.
holeWallThickness = 1.5;//Wall Thickness of the holes
holeHeight = 20;        //Height of each hole
holeGap = 1;            //Distance between each hole
angle=5;                //Angle of each hole
baseHeight = 2;         //Thickness of base.


//Logic, no need to edit below this line.
difference()
{
    holes();
    translate([0,0,-holeHeight])
    {
        base(holeHeight,18);
    }
}
translate([2,0,0])


base(baseHeight,18);

module base(height, addedDepth)
{
    length = (holeDiameter + holeGap) * holeCount + holeGap;
translate([ -( holeDiameter / 2 + holeGap * 2) ,-holeGap,0])
{
    cube( [holeDiameter + holeGap * 4 + addedDepth,length,height]);
};

}

module holes()
{
    for (i = [0:holeCount-1])
    {
        translate([0,i * (holeDiameter + holeGap) + holeDiameter *0.5, -(sin(25) * (holeDiameter/2) ) -0.1 ])
        {
            rotate([0,angle,0])
            {
                linear_extrude(holeHeight)
                {
                    difference()
                    {
                        circle(d=holeDiameter);
                        circle(d=(holeDiameter-holeWallThickness));
                    }
                }
            }
        }
    }
}