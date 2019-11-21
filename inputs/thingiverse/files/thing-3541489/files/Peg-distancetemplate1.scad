//By Coat, 04-apr-2019
//Licensed under the Creative Commons - Attribution license.
//Mallet to extend the peg-holes for shelfs in cabinets etc.

//number of guidepins
nguidepin=2;
//distance between these pins (center to center)
guidedistance=32;//[1:0.1:200]
//number of peg-holes to set out
nsetouthole=2;
//distance between these holes (center to center)
setoutdistance=32;//[1:0.1:200]

//height of the guidepin (make it smaller then the depth of the holes)
heightpin=5;//[1:0.1:20]
//diameter of the guidepin (tolerance will be extracted)
diampin=5;//[1:0.1:20]
//diameter of the peg-hole (tolerance will be added)
diamhole=5;//[1:0.1:20]
//tolerance to make your work easier
tolerance = 0.2;
//thickness of the baseplate
thickplate=3;//[1:0.1:20]

//modules

module pin(ii)
{
  dx = space+diampin/2+ii*guidedistance;
  dy=widthplate/2; 
  diamp= diampin-tolerance;  
   
  translate([dx,dy,0])
    cylinder(d=diamp, h= heightpin+thickplate);   
}  

module hole(jj)
{
  dx = space+diampin/2
       + (nguidepin-1)*guidedistance
       + jj*setoutdistance
       + setoutdistance;
       
  dy=widthplate/2; 
  diamh= diamhole+tolerance;  
  translate([dx,dy,-thickplate/4])
    cylinder(d=diamh, h= thickplate*2);   
}  



//main
//secondary parameters
$fn= 24;
space=5;
lengthplate= 
  (nguidepin-1)*guidedistance
  + nsetouthole*setoutdistance
  + diampin/2
  + diamhole/2
  + space*2;  //space on both sides
  
widthplate = max(diampin-tolerance,diamhole+tolerance) + space;  
echo(widthplate);  

//the thing
difference()
{
  union()
  {
    cube([lengthplate, widthplate,thickplate]); //baseplate
    for(i =[0:nguidepin-1])                     //guidepins 
      pin(i); 
  }
  for(j =[0:nsetouthole-1])                    //setout holes 
    hole(j);
}

  