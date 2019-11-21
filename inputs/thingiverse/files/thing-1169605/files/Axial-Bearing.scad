/*---------------------------------------------------------\
|     From: Ekobots Innovation Ltda - www.ekobots.com.br   |
|       by: Juan Sirgado y Antico - www.jsya.com.br        |
|----------------------------------------------------------|
|           Program Axial Bearing - 2015/12/01             |
|               All rights reserved 2015                   |
|---------------------------------------------------------*/

/* [ Global ] */

/* [ Bearing (Plate/Cover)] */

// Bearing external diameter in millimeters.
bearing_diameter = 40;
// Bearing internal top diameter in millimeters.
bearing_hole_top = 20;
// Bearing internal bottom diameter in millimeters.
bearing_hole_bottom = 8;
// Bearing height in millimeters.
bearing_height = 15;
// Bearing plates thickness in millimeters.
bearing_thickness = 5;

/* [ Roller ] */

// Sphere diameter.
sphere_diameter = 7; 
// Number of spheres.
number_spheres = 6;

/* [ Cage ] */

// Type of cage: 0-No Cage; 1-Cutted cage; 2-Full Cage;
cage_type = 1; // [0,1,2]

/* [ Parts ] */

// Part to render: 1-Cover; 2-Plate; 3-Cage; 4-Roller; 5-Roller set 6-Cage and Rollers 7-Full;
part_render = 7; // [1,2,3,4,5,6,7]

/* [ Hidden ] */

be = bearing_diameter;    // bearing external diameter
bi = bearing_hole_top;    // bearing internal diameter 
bb = bearing_hole_bottom; // bearing internal diameter 
bh = bearing_height;      // bearing height
bt = bearing_thickness;   // bearing plates thickness
sd = sphere_diameter;     // sphere diameter;
ns = number_spheres;      // number of spheres;
gr = cage_type;   // type of cage
                  // (0=No cage, 1=Cutted cage,  2=Full cage)
pr = part_render; // part to render
                  // (1=Cover, 2=Plate, 3=Cage, 4=Roller, 5=Roller set, 6=Cage and Rollers, 7=Full) 
ac = 0.25;  // adjust value for object cut;
ad = sd/10; // adjust value for sphere house cut;
fn = 120;   // number of faces for objects;
//---------------------------------------------------------|
axial_bearing_parts();
//---------------------------------------------------------|
module axial_bearing_parts()
{
   if(pr==1)
     axial_ring_top();
   if(pr==2)
     axial_ring_bottom();
   if(pr==3&&gr!=0)
     axial_cage();
   if(pr==4)
     axial_roller();
   if(pr==5)
     axial_rollers();
   if(pr==6)
   {
     axial_cage();
     axial_rollers();
   }
   if(pr==7)
     axial_bearing();
}
//---------------------------------------------------------|
module axial_bearing()
{
   rotate([180,0,0])
      axial_ring_top();
   axial_ring_bottom();
   axial_rollers();
   if(gr!=0)
   {
      axial_cage();
   }
}
//---------------------------------------------------------|
module axial_ring_top()
{
   rp = (bh-bt)/-2; // ring position
   // cover render
   difference()
   {
      translate([0,0,rp])
         cylinder(h=bt,d=be,center=true,$fn=fn);
      translate([0,0,rp])
         cylinder(h=bt+ac,d=bi,center=true,$fn=fn);
      translate([0,0,0])
         axial_channel();
   }
}
//---------------------------------------------------------|
module axial_ring_bottom()
{
   rp = (bh-bt)/-2; // ring position
   // plate render
   difference()
   {
      translate([0,0,rp])
         cylinder(h=bt,d=be,center=true,$fn=fn);
      translate([0,0,rp])
         cylinder(h=bt+ac,d=bb,center=true,$fn=fn);
      translate([0,0,0])
         axial_channel();
   }
}
//---------------------------------------------------------|
module axial_rollers()
{
   // roller render
   ri = 360/ns;  // rotation incremente;
   for(r=[ri:ri:361])
      rotate([0,0,r])
         translate([(be+bi)/4,0,0])
            axial_roller();
}
//---------------------------------------------------------|
module axial_roller()
{
   // individual roller 
   translate([0,0,0])
      sphere(d=sd,center=true,$fn=fn);
}
//---------------------------------------------------------|
module axial_cage()
{
   // cage render
   rd = 360/ns;               // rotation degrees;
   rt = sd/2;                 // ring thickness
   re = (be+bi+sd)/2;         // ring external diamater
   ri = (be+bi-sd)/2;         // ring internal diamater
   rp = (be+bi)/4;            // ring position
   difference()
   {
      union()
      {
         difference()
         {
            translate([0,0,0])
               cylinder(h=rt,d=(rp*2)+(sd/4),center=true,$fn=fn);
            translate([0,0,0])
               cylinder(h=rt+ac,d=(rp*2)-(sd/4),center=true,$fn=fn);
         }
         for(r=[rd:rd:361])
            rotate([0,0,r])
               translate([rp,0,0])
                  cylinder(h=rt,d=sd*1.25,center=true,$fn=fn);
      }
      for(r=[rd:rd:361])
         rotate([0,0,r])
            translate([rp,0,0])
               sphere(d=sd+(ad),center=true,$fn=fn);
      for(r=[rd:rd:361])
         rotate([0,0,r+(rd/2)])
            translate([rp,0,0])
               rotate([0,90,0])
                  cylinder(h=sd,d=sd/6,center=true,$fn=fn);
      if(gr==1)
         for(r=[rd:rd:361])
            rotate([0,0,r])
               translate([rp-(sd/2),0,0])
                   cube([sd/2,1,rt+ac],center=true);
   }
}
//---------------------------------------------------------|
module axial_channel()
{
   pi = 3.1415926535897932384626433832795028841971693993751;
   ri = 360/fn;     // rotation incremente;
   ch = (be*pi)/fn; // cylinder height;
   for(r=[ri:ri:361])
      rotate([0,0,r])
         translate([(be+bi)/4,0,0])
            rotate([90,0,0])
               cylinder(h=ch,d=sd+ac,center=true,$fn=fn);
}
//---------------------------------------------------------|