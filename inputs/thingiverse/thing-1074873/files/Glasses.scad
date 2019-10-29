/*---------------------------------------------------------\
|     From: Ekobots Innovation Ltda - www.ekobots.com      |
|       by: Juan Sirgado y Antico - www.jsya.com.br        |
|----------------------------------------------------------|
|             Program Galsses - 2014/10/15                 |
|               All rights reserved 2015                   |
|---------------------------------------------------------*/

/* [ Global ] */

// Which is the size for your glasses? It is the distance between ears in millimeters.
glasses_size = 160; // [100:10:200]

// Which is the thick for your glasses? It is the thick of the lens and arms in millimeters.
glasses_thick = 2;  // [1,2,3,4,5]

// Whitch type of hole you want? The values are: 0=no hole, 1=holes or 2=strips.
hole_type = 1;  // [0,1,2]

// Witch distance between holes or strips you want? It is the distance for x and z axes in millimeters.
holes_distance = 5;  // [2:0.5:5]

/* [ Hidden ] */
d=glasses_size;      // glasses diameter;
h=50;                // glasses height;
t=glasses_thick;     // glasses thick;
a=0.2;               // object cut adjust value;
f=120;               // number of faces in object;
ht = hole_type;      // type of holes  ;
hd = holes_distance; // distance between holes;
//---------------------------------------------------------|
// preview[view:south west, tilt:bottom diagonal]
//---------------------------------------------------------|
glasses();
//---------------------------------------------------------|
module glasses()
{
   difference()
   {
      union()
      {
         translate([0,0,0])
            glasses_len();
         for(x=[(d-t)/2,-(d-t)/2])
            translate([x+(x<0?6:-6),28,0])
               rotate([0,0,x>0?10:-10])
                  glasses_arm();
      }
      for(x=[40,-40])
         translate([x,(-d/2)+20,0]) 
            rotate([90,0,0])
               glasses_holes();
   }
}
//---------------------------------------------------------|
module glasses_len()
{
   difference()
   {
      translate([0,0,0]) 
         cylinder(h=h,d=d,center=true,$fn=f);
      translate([0,0,0]) 
         cylinder(h=h+a,d=d-(t*2),center=true,$fn=f);
      translate([0,(d/4),0]) 
         cube([d+a,(d/2)+10,h+a],center=true);
      translate([0,0,33]) 
         rotate([-20,0,0])
            cylinder(h=h,d=d+a,center=true,$fn=f);
      translate([0,(-d/2)+t,25]) 
          scale([20,80,50])
            sphere(d=1,center=true,$fn=f);
      for(x=[13.5,-13.5])
      {
         difference()
         {
            translate([x+(x<0?5:-5),(-d/2)+2.5,20]) 
               cube([20,30,10.2],center=true);
            translate([x+(x>0?5:-5),(-d/2)+2.5,15]) 
               rotate([90,0,0])
                  cylinder(h=30+a,d=20,center=true,$fn=f);
         }
      }
   }
}
//---------------------------------------------------------|
module glasses_arm()
{
   difference()
   {
      union()
      {
         translate([0,0,-7.5])
            cube([t,68,h-15],center=true);
         translate([0,35,(h/2)-35])
            cube_rounded([t,20,h-20],r=5,a=0);
      }
      translate([0,-2,(h/2)-12.25])
         rotate([-20,0,0])
            cube_rounded([t+a,80,h-20],r=10,a=0);
   }
}
//---------------------------------------------------------|
module glasses_holes()
{
   if(ht==0)
   {
      // do noting, no holes. 
   }
   else if(ht==1)
   {
      for(x=[-hd*5:hd:hd*5])
         for(y=[-hd*4:hd:hd*4])
            translate([x,y,0])
               cylinder(h=50,d=1,center=true,$fn=f);
   } 
   else if(ht==2)
   {
      for(x=[-hd*5:hd:hd*5])
         translate([x,y,0])
            cube([1,h-10,40],center=true);
   } 
}
//---------------------------------------------------------|
module cube_rounded(xyz=[20,10,5],r=1,a=2) 
{
   // cut corners in x -> a=0 or y -> a=1 or z -> a=2
   x = xyz[0]; // x axis length
   y = xyz[1]; // y axis length
   z = xyz[2]; // z axis length
   ra=a==0?[0,90,0]:
      a==1?[90,0,0]:
           [0,0,0];
   difference()
   {
      // main cube no translation and no rotation
      translate([0,0,0]) 
         rotate([0,0,0]) 
            cube(xyz,center=true);
      // corner cut rotation, default cut is z
      rotate(ra) 
         cube_corners(x=x,y=y,z=z,r=r,a=a);
   }
}
//---------------------------------------------------------|
module cube_corners(x=20,y=10,z=5,r=1,a=2)
{
   c = 0.2;    // correction
   // points and rotation for z corners 
   px = [[-z,-y,0,-1,-1,0,0],[z,-y,0,1,-1,0,90],
        [z,y,0,1,1,0,180],[-z,y,0,-1,1,0,270]]; 
   py = [[-x,-z,0,-1,-1,0,0],[x,-z,0,1,-1,0,90],
        [x,z,0,1,1,0,180],[-x,z,0,-1,1,0,270]]; 
   pz = [[-x,-y,0,-1,-1,0,0],[x,-y,0,1,-1,0,90],
        [x,y,0,1,1,0,180],[-x,y,0,-1,1,0,270]];
   p=a==0?px:a==1?py:pz;
   d=a==0?x:a==1?y:z;
   for(i=p)
   {
      translate([(i[0]-r*i[3])/2,
                 (i[1]-r*i[4])/2,
                 (i[2]-r*i[5])/2]) 
         rotate([0,0,i[6]])
            cube_border(z=d,r=r,c=c);
   }
}
//---------------------------------------------------------|
module cube_border(z=10,r=1,c=2) 
{
   // cube border cut
   difference() 
   {
      translate([0,0,0])
         cube([r+c,r+c,z+c],center=true);
      translate([r/2,r/2,0]) 
         cylinder(h=z+(c*2),r=r,center=true,$fn=50);
   }
}
//---------------------------------------------------------|

