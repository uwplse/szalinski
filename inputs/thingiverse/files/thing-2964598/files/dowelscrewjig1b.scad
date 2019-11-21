//By Coat, 18-jun-2018
//Licensed under the Creative Commons - Attribution license.

//Thickness board to use with this tool
thbo=18;
//thickness side 1
ths1=10;
//thickness side 2
ths2=2;
//Diameter holes in side 1
diam1=8.2;
//Diameter holes in side 2
diam2=3.1;
//Distance center to center of the holes (side 1 and 2)
hth=20;
//Number of holes
nh=10;
//First distance short edge jig to edge first hole
fde = 8;
//Nodges at long sides? (0 = none, 1 = at side 2, 2 = at both sides)
nodges = 1;
//Endstops at short sides? (0 = none, 1 = one side, 2 = both sides)
nstop = 0;


module anotch(r,a,tx)
{
  rotate(a) 
    cube([r,r,tx*2],center=true);   
}  

module aside(tm,dm,ns)
{
  difference()
  {
    cube([leng,thbo,tm]);
    translate([fde+diam0/2,thbo/2,tm/-2])
      for(i=[0:nh-1])
        translate([i*hth,0,0])
          rotate([0,0,45])
          cylinder(d=dm,h=tm*2);

    if (ns)                  //0 = false, every other value is true
    {  
    translate([fde+diam0/2,thbo,tm/2])
      for(i=[0:nh-1])
        translate([i*hth,0,0])
         anotch(2,45,tm);
    }  
    if (nstop<1)              //if no stop then a notch
      translate([0,thbo/2,tm/2])
        anotch(3,45,tm);
  
    if (nstop<2)             //if no stop then a notch  
    translate([leng,thbo/2,tm/2])
      anotch(3,45,tm);    
  } 
}  

module astop(d)
{
  t=2;                     //thickness endstop
  dm= 3;                   //diameter extra marking hole in endstop
  translate([d,0,0])
    rotate([0,-90,0])
      translate([0,-ths2,0])
        difference()
        {
        cube([thbo+ths1,thbo+ths2,t]);
        translate([ths1+thbo/2,ths2+thbo/2,-1])
          cylinder(d=dm,h=t*2);   //extra marking hole in the middle
        }  
}

//main
nedges = 50;  //over the top: Number of edges holes (see rotate cylinder in aside)
$fn=nedges;

diam0 = max(diam1, diam2);   //to keep both diameters at same distance
leng = hth*(nh-1)+diam0+fde*2;  //total length of jig
echo(str("Total length of jig:" , leng, " mm"));

rotate([0,0,270])          //unnessecary but for thingiverse customizer view
translate([leng * -1,0,0]) //unnessecary but for thingiverse customizer view
union()
{
  aside(ths1,diam1,max(0,nodges-1));
  translate([0,0,ths1])
    rotate([90,0,0])
      aside(ths2,diam2,nodges);
  rotate([90,0,0])
    cube([leng,ths1,ths2]);
  if (nstop>0)
    astop(0); 
  if (nstop>1)
    astop(leng+1.5); 
}



