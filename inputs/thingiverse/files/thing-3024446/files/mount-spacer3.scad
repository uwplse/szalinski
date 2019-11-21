//By Coat, 29-jul-2018
//Licensed under the Creative Commons - Attribution license.

//primary parameters 

/*[The Base]*/
//The height of the plate (mm, Y direction)
platelength = 20; //[0:0.1:200]
//The width for mountingplate at the left side (mm, X-direction to the left)
platewidthleft = 10; //[0:0.1:200]
//The width for mountingplate at the right side (mm,, X-direction to the right)
platewidthright = 10; //[0:0.1:200]
//Thickness of the mounting plate (mm, left and right, Z-direction)
platethick = 3; //[0:0.1:20] 
//The offset of the plate from the object you will put it on (mm, Z-direction)
plateoffsetdepth = 0; //[0:0.1:100]
//Round corners Yes (1) or No (0)
roundcorner = 1;
//If using round corners use this radius (mm)
cornerrad = 2; //[0:0.1:20]
//Ridge for aligning 2020 alu frame , Yes (1) or No (0)
ridge2020 = 0;
/*[The optional Helpgrid]*/
//Helpgrid, 0 is none, >0 is line distance in mm. Do'nt forget to set it back to 0 (off) when your done. 
helpgridmm = 0; //[0:20]


/*[Hole 1]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole01x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole01y = 10; //[0:0.1:200]
//And give the diameter of the hole
mhole01diam = 4.5; //[0:0.1:200]

/*[Hole 2]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole02x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole02y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole02diam = 4.5; //[0:0.1:200]

/*[Hole 3]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole03x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole03y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole03diam = 4.5; //[0:0.1:200]

/*[Hole 4]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole04x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole04y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole04diam = 4.5; //[0:0.1:200]

/*[Hole 5]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole05x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole05y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole05diam = 4.5; //[0:0.1:200]

/*[Hole 6]*/
// Give the X-position in mm. Negative for left side, positive for right side. 
mhole06x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole06y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole06diam = 4.5; //[0:0.1:200]

/*[Hole 7]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole07x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole07y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole07diam = 4.5; //[0:0.1:200]

/*[Hole 8]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole08x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole08y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole08diam = 4.5; //[0:0.1:200]

/*[Hole 9]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole09x = 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole09y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole09diam = 4.5; //[0:0.1:200]

/*[Hole 10]*/
//Give the X-position in mm. Negative for left side, positive for right side. 
mhole10x= 0; //[-200:0.1:200]
//Give the Y-position, always positive
mhole10y = 0; //[0:0.1:200]
//And give the diameter of the hole
mhole10diam = 4.5; //[0:0.1:200]

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

module hullplate(dwr,dwl,dh,cr,pt)
{
  hull()
  {
    translate([dwr, dh,0])    //topright
      corner(cr, pt);
    translate([dwl, dh,0])    //topleft
      corner(cr, pt);
    translate([dwl, -dh,0])   //bottomleft
      corner(cr, pt);
    translate([dwr, -dh,0])   //bottomright
      corner(cr, pt);
  }
}

module plate()
{
  union()
  {
    color("Yellow") 
    hullplate(platewidthright - cornerrad2,    //width right side Mplate
              -platewidthleft + cornerrad2,    //width left side Mplate
              0.5*platelength - cornerrad2,    //height Mplate 
              cornerrad2,                      //cornerradius    
              platethick);                    //thickness Mplate  

    if(plateoffsetdepth!=0)
      color("MediumSeaGreen")
      translate([podx,0,-plateoffsetdepth]) 
         hullplate(0.5*podw-cornerrad2,         //width right side offsetplate
                   -0.5*podw+cornerrad2,        //width left side offsetplate
                   0.5*platelength-cornerrad2,  //height offsetplate
                   cornerrad2,                  //same cornerradius
                   plateoffsetdepth);          //thickness offsetplate

    if(ridge2020)   
       color("DarkOrange")  
       translate([rx,0,-0.5*rt - plateoffsetdepth]) 
         cube([rw,platelength,rt], center = true); 
  }
}

module mountinghole(xmh,ymh,diamh)
{
  if (xmh!=0||ymh!=0)
  { 
     $fn=32;
     translate([xmh,-ymh,0]) 
       cylinder(d = diamh, h = 3*(platethick + rt + plateoffsetdepth), center=true); 
  }  
}  

module helpgrid(wl,wr,hp,tp,dg)
{
  linew = 0.4;               //width gridlines 
  for(i = [0:dg:floor(wl)])  //grid left vertical
  {
    color([0,1,0]) translate([-i,-0.5*hp,tp])
      cube([linew,hp,linew], center = true);  
  }
  for(i = [0:dg:floor(hp)])  //grid left horizontal
  {
    color([0,1,0]) translate([-0.5*wl,-i,tp])
      cube([wl,linew,linew], center = true);  
  }
  for(i = [0:dg:floor(wr)])   //grid right vertical          
  {
     color([0,0.5,0]) translate([i,-0.5*hp,tp])
     cube([linew,hp,linew], center = true);  
  }
  for(i = [0:dg:floor(hp)])  //grid right horizontal          
  {
    color([0,0.5,0]) translate([0.5*wr,-i,tp])
      cube([wr,linew,linew], center = true);  
  }
  color([1,0,0]) translate([0,-0.5*hp,tp])  //0-line
    cube([linew*2,hp,linew], center = true);  
  color([1,0,0,0.2]) translate([0,-0.5*hp,tp]) //2020-frame-zone
    cube([podw,hp,linew/2], center = true);  
}  

//Main
//secondary parameters
rx = 0;    //position ridge
rt=1.4;     //thickness ridge
rw = 5.8; //width ridge
podx =0;  //position offsetplate;
podw =20; //width offsetplate

//recalculated parameters
cornerrad2 = min(max(cornerrad,1), 0.5*platelength, 0.5* (platewidthleft + platewidthright));  //max -> you need a radius also with square. min -> radius can't be bigger than the half of the buidsizes.

//the Thing
difference()
{
  union()
  {
    translate([0,-0.5*platelength,0])
      plate();
    if(helpgridmm > 0)
      helpgrid(platewidthleft, platewidthright, platelength, platethick,helpgridmm);
  }
  mountinghole(mhole01x,mhole01y, mhole01diam);
  mountinghole(mhole02x,mhole02y, mhole02diam);
  mountinghole(mhole03x,mhole03y, mhole03diam);
  mountinghole(mhole04x,mhole04y, mhole04diam);
  mountinghole(mhole05x,mhole05y, mhole05diam);
  mountinghole(mhole06x,mhole06y, mhole06diam);
  mountinghole(mhole07x,mhole07y, mhole07diam);
  mountinghole(mhole08x,mhole08y, mhole08diam);
  mountinghole(mhole09x,mhole09y, mhole09diam);
  mountinghole(mhole10x,mhole10y, mhole10diam);
}


