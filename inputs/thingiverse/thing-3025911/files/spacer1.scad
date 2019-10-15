//By Coat, 29-jul-2018
//Licensed under the Creative Commons - Attribution license.

//primary parameters 
//The height of the spacer (mm)
spacerlength = 20;
//Thickness of the mounting spacer (mm, left and right)
spacerthick = 5;
//Round corners Yes (1) or No (0)
roundcorner = 1;
//If using round corners use this radius (mm)
cornerrad = 2;
//Ridge for aligning with 2020 alu frame , Yes (1) or No (0)
ridge2020 = 0;
//Diameter of the mountingholes
mholediam = 4.5;
//The mountingholes: give the position of the center in mm.
mhole01y = 10;
//Position center mountinghole 2 (0 = disabled):
mhole02y = 0;
//Position center mountinghole 3 (0 = disabled):
mhole03y = 0;
//Position center mountinghole 4 (0 = disabled):
mhole04y = 0;

module corner(cr, pt)
{
  if (roundcorner)
  {
    $fn = 32;
    cylinder(r=cr, h = pt);
  }
  else
  {
    $fn = 4;
    rotate([0,0,45])
    cylinder(r=sqrt(2)*cr, h = pt);
  } 
}

module hullspacer(dx,dy,cr,pt)
{
  hull()
  {
    translate([dx, dy,0])    //topright
      corner(cr, pt);
    translate([-dx, dy,0])    //topleft
      corner(cr, pt);
    translate([-dx, -dy,0])   //bottomleft
      corner(cr, pt);
    translate([dx, -dy,0])   //bottomright
      corner(cr, pt);
  }
}

module spacer()
{
  union()
  {
    hullspacer(0.5* spacerwidth- cornerrad2,    
               0.5*spacerlength - cornerrad2,
               cornerrad2,                   
               spacerthick);                 

    if(ridge2020)   
       translate([rx,0,0.5*rt + spacerthick]) 
         cube([rw,spacerlength,rt], center = true); 
  }
}

module mountinghole(xmh,ymh,diamh)
{
  if (xmh!=0||ymh!=0)
  { 
     $fn=32;
     translate([xmh,-ymh,0]) 
       cylinder(d = diamh, h = 3*(spacerthick + rt), center=true); 
  }  
}  


//Main
//secondary parameters
spacerwidth = 20;
rx = 0;    //position ridge
rt=1.4;     //thickness ridge
rw = 5.8; //width ridge

//recalculated parameters
cornerrad2 = min(max(cornerrad,1), 0.5*spacerlength, 0.5*spacerwidth);

//the Thing
difference()
{
  union()
  {
    translate([0,-0.5*spacerlength,0])
      spacer();
  }
  mountinghole(0,mhole01y, mholediam);
  mountinghole(0,mhole02y, mholediam);
  mountinghole(0,mhole03y, mholediam);
  mountinghole(0,mhole04y, mholediam);
}


