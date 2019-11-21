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

Please enjoy, revise and share this desktop garbage bin freely.
I always appriciate it when credit is given back to me!

*/

//Diameter at the very base of the bin
baseDiameter = 70;
//Thickness of the base plate.
baseThickness = 4;     
//Diameter at the very top of the bin.
topDiameter = 90;    
//Thickness of the top rim.
topThickness = 4;       
//Overall height of the bin.
height = 90;            
//Number of pillars (this is per clockwise and counter-clockwise pillars).
pillars = 12;           
//Diameter of each pillar
pillarDiameter = 3;
//How twisty to make the pillars.
pillarTwist = 180; 
//You can have pillars going clockwise, counter-clockwise or both.  Both is best for stability.
pillarSets = "both"; // [both, clockwise, coutner-clockwise]

//Internal Variables - No need to change anything below this line.
overhang = (topDiameter - baseDiameter)/2;
angle = atan(height/overhang);
baseDiameterTop = (baseThickness / tan(angle)) * 2 + baseDiameter;
topDiameterBottom = topDiameter - (topThickness / tan(angle)) * 2;

//Logic
top();
base();
if (pillarSets == "both" || pillarSets == "clockwise") { pillars(true); }
if (pillarSets == "both" || pillarSets == "counter-clockwise") { pillars(false); }

//Modules
module pillars(invert)
{
    for (i = [1:pillars])
    {
        rotate([0,0,360/pillars * i])
        {
            translate([0,0,baseThickness])
            {
                linear_extrude(height=height-baseThickness-0.1,scale = topDiameter/baseDiameter,twist=invert?-pillarTwist:pillarTwist)
                {
                    translate([baseDiameter/2 - pillarDiameter/2,0,0])
                    {
            circle(d=pillarDiameter);
                    }
                }
            }
        }
    }
}

module top()
{
    translate([0,0,height-topThickness])
    {
        difference()
        {
            cylinder( d1=topDiameterBottom, d2=topDiameter,h=topThickness);
            
                        cylinder( d1=topDiameterBottom-pillarDiameter*2, d2=topDiameter-pillarDiameter*3,h=topThickness);
        }
    }
}

module base()
{
    cylinder( d1=baseDiameter, d2=baseDiameterTop,h=baseThickness);
}