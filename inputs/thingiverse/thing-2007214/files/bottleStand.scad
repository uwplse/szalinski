/***********************************************************************
Name ......... : bottleStand.scad
Description....: Customizable Small Bottle Stand
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/12/31
Licence ...... : GPL
***********************************************************************/

//measured bottle diameter + a small clearance
bottleDiameter = 35.0;
//measured bottle height + a small clearance
bottleHeight = 85.0;

//number of bottles
numBottles = 4;

//Spacing around edges
edge = 10;
//Spacing Between Bottles
bottleSpace = 5;


module bottleStand()
{
    
    L = (bottleDiameter + bottleSpace)*numBottles + edge*0.5;
    
    difference(){
    cube([L, bottleHeight+edge, bottleDiameter*0.5], center = true);
    
    
    for(i=[0:1:numBottles-1]){
    
        
     x = -L*0.5 + (bottleDiameter*0.5+edge*0.5) + (bottleDiameter+bottleSpace)*i;
     //x=-L*0.5 + bottleDiameter-edge*0.5;   
        
    translate([x,0,bottleDiameter*0.5]){
    
    rotate([90,0,0]){
    cylinder(r=bottleDiameter*0.5, h=bottleHeight, center = true, $fn=100);
    }
    }
    }
    }
    
}






bottleStand();



