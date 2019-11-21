//Customization Project

//INSTRUCTIONS: save as scad, press f6, save as stl, upload to thingiverse, customize there.

//What should the outer square side length be?
l=10;//[0:.5:50]

//What should the height be?
h=5;//[0:.5:50]

//What should the thickness be?
t=2;//[0:.5:50]

module Outersquare()
{
offset(l)
square(size=l,center=true);
}

module Innersquare()
{   
offset(l-t)
square(size=(l-t),center=true);  
}

difference()
{
    linear_extrude(height=h,center=true,$fn=100)
    {
    Outersquare();
    }
    linear_extrude(height=(h+1),center=true,$fn=100)
    {
    Innersquare();
    }
}