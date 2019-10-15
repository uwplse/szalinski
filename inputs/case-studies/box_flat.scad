//Box Depth (X)
x=60;

//Box Thickness (Y)
y=120;

//Box Height (Z)
z=30;

//Box Wall Thickness
h=2;

//Number of Rows
r=5;

//Number of Columns
c=3;

$fn=100;

module Body()
{cube([x,y,z]);}

module Lid()
{difference(){
    cube([x+1+2*h,y+1+2*h,z/5]);
    translate([h,h,h+.001])cube([x,y,(z/5-h)]);
    }
}

module Hole (){
cube([((x-h-r*(h))/r),(y-h-c*(h))/(c),z-h]);}

module Pattern (){
    for (i=[1:r]){
        for (j=[1:c]){
            translate ([h*(i)+(i-1)*(x-h-r*(h))/r,h*(j)+(j-1)*(y-h-c*(h))/(c),h+.001])Hole();
        }
    }}
    
difference ()
{
    Body();
    Pattern();
}

translate ([-x-5-h,-h,0])Lid();   
    