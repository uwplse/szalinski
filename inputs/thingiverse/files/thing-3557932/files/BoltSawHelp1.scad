//By Coat, 11-april-2019
//Licensed under the Creative Commons - Attribution license.
//Sawhelp for shorten bolts and machine screws, useable calibrationcube

/* [Nut or Bolt] */
//Width nut or bolt head (mm, flat side to flatside), make it a little smaller, so you can press in the nut. 
wsize = 6.8; //[1:0.1:20] 
//Height/depth of nut   (mm, if 0 -> wsize/2)
nutheight = 0; //[0:0.1:10]
//Hole fo threat (mm, if 0 -> wsize-2, make it bigger then actual size and smaller then wsize)
threadholediam = 0; //[0:0.1:20]

/* [Cube] */
//Width of cube (mm, if 0 -> two times wsize)
cubewidth = 0; //[0:1:40]
//Height of cube (mm, if 0 -> two times nutheight)
cubeheight = 0;  //[0:1:40]   

/* [text, optional] */
//Font
textfont = "Arial";
//Text for each vertical side
cubetext1 = "M4";
cubetext2 = "";
cubetext3 = "";
cubetext4 = "";
//Fontsize = this factor * cubeheight
textsizefactor= 0.5; //[0:0.05:1]

//---Modules---
module cylinsert(dd, hh,ff,rr)  //diameter,height,fn,angle
{
  $fn = ff;
  rotate([0,0,rr])
    cylinder(d = dd, h = hh, center= true);
}

module textoncube(tt,zr)
{
  if (tt!="")
  {
    rotate([0,0,zr])
    translate([0,-cw/2,0])
      rotate([90,0,0])
        linear_extrude(height = 1, center = true)
          text(tt, size = ch*textsizefactor, font = textfont, halign="center",valign="center",spacing = 1);
  }  
}  

//----Thing---

//secondary parameters
nh= nutheight==0?wsize/2:nutheight;
thd = threadholediam==0?wsize-2:threadholediam;
cw= cubewidth==0?wsize*2:cubewidth;
ch= cubeheight==0?nh*2:cubeheight;

translate([0,0,ch/2])
  difference()
  {
    cube([cw,cw,ch], center = true);
    translate([0,0,ch/2])
      cylinsert(wsize/sqrt(0.75), nh*2,6,0); //hole to fit nut/bolt
    cylinsert(thd, ch*2,32,0); //hole for thread 
    textoncube(cubetext1,0);
    textoncube(cubetext2,90);
    textoncube(cubetext3,180);
    textoncube(cubetext4,270);
  }

