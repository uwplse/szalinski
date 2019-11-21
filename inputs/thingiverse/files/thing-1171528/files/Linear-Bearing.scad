/*---------------------------------------------------------\
|     From: Ekobots Innovation Ltda - www.ekobots.com.br   |
|       by: Juan Sirgado y Antico - www.jsya.com.br        |
|----------------------------------------------------------|
|          Program Linear Bearing - 2015/12/03             |
|               All rights reserved 2015                   |
|---------------------------------------------------------*/

/* [ Global ] */

/* [ Bearing ] */

// Bearing external diameter in millimeters.
bearing_diameter = 17.5;
// Bearing internal diameter (shaft diameter) in millimeters.
bearing_hole = 8;
// Bearing height in millimeters.
bearing_height = 20;

/* [ Roller ] */

// sphere diameter;
sphere_diameter = 2;
// number of lines of spheres;
number_spheres = 5;

/* [ Cover ] */

// Cover thickness in millimeters.
cover_thickness = 5;

/* [ Parts ] */

//Bearing parts to render: 1-Cup; 2-Cover; 3-Roller; 4-Roller set; 5-Full;
part_render = 5; // [1,2,3,4,5]

/* [ Hidden ] */

// Render internal variables:
be = bearing_diameter; // bearing external diameter;
bi = bearing_hole;     // bearing internal diameter;
bh = bearing_height;   // bearing height;
sd = sphere_diameter;  // sphere diameter;
ns = number_spheres;   // number of spheres;
ct = cover_thickness;  // cover thickness;
pr = part_render; // part to render:
                  // (1-Cup, 2-Cover, 3-Roller, 4-Roller set, 5-Full);
ac = 0.25;  // adjust value for object cut;
ad = sd/10; // adjust value for sphere house cut;
fn = 120;   // number of faces for objects;
//---------------------------------------------------------|
linear_bearing_parts();
//---------------------------------------------------------|
module linear_bearing_parts()
{
   // partial render
   if(pr==1)
     linear_ring();
   if(pr==2)
     linear_cover();
   if(pr==3)
     linear_roller();
   if(pr==4)
     linear_rollers();
   if(pr==5)
     linear_bearing();
}
//---------------------------------------------------------|
module linear_bearing()
{
   // full render
   translate([0,0,0])
      color([1,1,1],.8)
         linear_rollers();
   translate([0,0,(bh-ct)/2+10])
      color([0,0,1],1)
         //!rotate([0,180,0])
         linear_cover();
   translate([0,0,0])
      color([0,0,1],1)
         linear_ring();
}
//---------------------------------------------------------|
module linear_ring()
{
   // cup render
   cp = (bh-ct+ac)/2;        // cover cut position
   cd = (be-(be-bi)/2)+sd/4; // cover diameter
   difference()
   {
      translate([0,0,0])
         cylinder(h=bh,d=be,center=true,$fn=fn);
      translate([0,0,0])
         cylinder(h=bh+ac,d=bi+(sd/2.5),center=true,$fn=fn);
      translate([0,0,cp])
         cylinder(h=ct+ac,d=cd,center=true,$fn=fn);
      translate([0,0,0])
         linear_channel_contact();
      translate([0,0,0])
         linear_channel_return();
      translate([0,0,0])
         bottom_channel_arch();
   }
}
//---------------------------------------------------------|
module linear_rollers()
{
   // roller render
   ri = 360/ns;           // rotation incremente
   sp = (bi/2)+(sd/2);    // sphere position
   lp = (bh/2)-(ct/1.5)-(sd/2); // line start position
   // spheres contact
   for(z=[-lp:sd:lp])
      for(r=[ri:ri:361])
         rotate([0,0,r])
            translate([sp,0,z])
               linear_roller();
   // spheres return
   for(z=[-lp:sd:lp])
      for(r=[ri:ri:361])
         rotate([0,0,r])
            translate([sp,sd+1,z])
               linear_roller();
}
//---------------------------------------------------------|
module linear_roller()
{
   // individual roller 
   translate([0,0,0])
      sphere(d=sd,center=true,$fn=fn);
}
//---------------------------------------------------------|
module linear_cover()
{
   // cover render
   cd = (be-(be-bi)/2)+sd/2.5; // cover diameter
   difference()
   {
      union()
      {
         translate([0,0,0])
            cylinder(h=ct,d=cd-ac,center=true,$fn=fn);
         translate([0,0,0])
         linear_cover_align();
      }
      translate([0,0,0])
         cylinder(h=ct+ac,d=bi+(sd/2.5),center=true,$fn=fn);
      translate([0,0,0])
         top_channel_arch();
   }
}
//---------------------------------------------------------|
module linear_channel_contact()
{
   ri = 360/ns;        // rotation incremente
   cp = (bi/2)+(sd/2); // channel contact position
   for(r=[ri:ri:361])
      rotate([0,0,r])
         translate([cp,0,ct/2])
            cylinder(h=bh-(sd*2)+(ad*2),d=sd+ac,center=true,$fn=fn);
}
//---------------------------------------------------------|
module linear_channel_return()
{
   ri = 360/ns;          // rotation incremente
   cp = (bi/2)+(sd/2); // channel return position
   for(r=[ri:ri:361])
      rotate([0,0,r])
         translate([cp,sd+1,ct/2])
            cylinder(h=bh-(sd*2)+(ad*2),d=sd+ac,center=true,$fn=fn);
}
//---------------------------------------------------------|
module linear_cover_align()
{
   ri = 360/ns;          // rotation incremente
   cp = (bi/2)+(sd/2); // channel return position
   for(r=[ri:ri:361])
      rotate([0,0,r])
         translate([cp,sd+1,ct/4])
            cylinder(h=ct/2,d=sd+ac,center=true,$fn=fn);
}
//---------------------------------------------------------|
module top_channel_arch()
{
   ri = 360/ns;          // rotation incremente
   cp = (bi/2)+(sd/2); // channel return position
   for(r=[ri:ri:361])
      rotate([0,0,r])
         translate([cp,(sd+1)/2,-((ct+ac)/2)])
            rotate([0,90,0])
               channel_arch();
}
//---------------------------------------------------------|
module bottom_channel_arch()
{
   ri = 360/ns;          // rotation incremente
   cp = (bi/2)+(sd/2); // channel return position

   for(r=[ri:ri:361])
      rotate([0,0,r])
         translate([cp,(sd+1)/2,-(bh/2)+ct])
            rotate([0,-90,0])
               channel_arch();
}
//---------------------------------------------------------|
module channel_arch()
{
   pi = 3.1415926535897932384626433832795028841971693993751;
   ri = 2*pi*sd;
   bh = ri/fn;
   difference()
   {
      for(z=[360/fn:360/fn:360]) 
      {
         rotate([0,0,z+(360/fn)/2]) 
            translate([(sd+1)/2,0,0]) 
               rotate([90,0,0]) 
                  cylinder(h=bh+ad,d=sd+ad,center=true,$fn=fn);
      }
      translate([(sd+1)/2,0,0]) 
         cube([sd+1+ad,(sd+1+ad)*2,sd+1+ad],center=true);
   }
}
//---------------------------------------------------------|