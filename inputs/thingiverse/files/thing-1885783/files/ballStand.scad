/***********************************************************************
Name ......... : exerciseBallStand.scad
Description....: Exercise Ball Stand
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/11/11
Licence ...... : GPL
***********************************************************************/

//Max diameter at base of stand
maxDiameter = 150;

//Min diameter at top of stand
minDiameter = 100;
//Height of stand
height = 30;

//Thickness of stand
thickness = 5;

//Number of facets of circular features
facets = 100;

module ballStand()
{
    difference(){
    cylinder(r1=maxDiameter*0.5,r2=minDiameter*0.5, h=height, center = true, $fn = facets);
    
    cylinder(r1=maxDiameter*0.5 - thickness*0.5,r2 = minDiameter*0.5-thickness*0.5,  h = height+2, center = true, $fn = facets);
    }
}


ballStand();