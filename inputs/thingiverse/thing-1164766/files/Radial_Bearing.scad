/*---------------------------------------------------------\
|     From: Ekobots Innovation Ltda - www.ekobots.com.br   |
|       by: Juan Sirgado y Antico - www.jsya.com.br        |
|----------------------------------------------------------|
|          Program Radial Bearing - 2015/11/29             |
|               All rights reserved 2015                   |
|---------------------------------------------------------*/

/* [ Global ] */

/* [ Bearing (Cup/Cone)] */

// Bearing external diameter in millimeters.
bearing_diameter = 50;
// Bearing internal diameter(central hole) in millimeters.
bearing_hole = 20;
// Bearing height in millimeters.
bearing_height = 15;
// bearing rings thickness in millimeters.
bearing_thickness = 4.5;

/* [ Roller ] */

// sphere diameter;
sphere_diameter = 10; 
// number of spheres;
number_spheres = 6;

/* [ Cage ] */

//Type of cage: 0-No Cage; 1-One Cage; 2-Two Half Cages;3-Full Cage;
cage_type = 1; // [0,1,2,3]

/* [ Parts ] */

//Bearing parts to render: 1-Cup; 2-Cone; 3-Cage; 4-Roller; 5-Roller set; 6-Full;
part_render = 6; // [1,2,3,4,5,6]

/* [ Hidden ] */

be = bearing_diameter;  // bearing external diameter
bi = bearing_hole;      // bearing internal diameter 
bh = bearing_height;    // bearing height
bt = bearing_thickness; // bearing rings thickness
sd = sphere_diameter;   // sphere diameter;
ns = number_spheres;    // number of spheres;
gr = cage_type;   // type of cage(0-No cage, 1-One cage, 2-Two cages, 3-Full cage)
pr = part_render; // part to render(1-Cup, 2-Cone 3-Cage, 4-Roller, 5-Roller set, 6=Full) 
ac = 0.25;  // adjust value for object cut;
ad = sd/10; // adjust value for sphere house cut;
fn = 120;   // number of faces for objects;
//---------------------------------------------------------|
radial_bearing_parts();
//---------------------------------------------------------|
module radial_bearing_parts()
{
   if(pr==1)
     radial_external_ring();
   if(pr==2)
     radial_internal_ring();
   if(pr==3&&gr!=0)
     radial_cage();
   if(pr==4)
     radial_roller();
   if(pr==5)
     radial_rollers();
   if(pr==6)
     radial_bearing();
}
//---------------------------------------------------------|
module radial_bearing()
{
   radial_external_ring();
   radial_internal_ring();
   radial_rollers();
   if((gr==1)||(gr==3))
   {
      radial_cage();
   }
   else if(gr==2)  
   {
      for(r=[0,180])
         rotate([r,0,0])
            radial_cage();
   }
}
//---------------------------------------------------------|
module radial_external_ring()
{
   // cup render
   difference()
   {
      translate([0,0,0])
         cylinder(h=bh,d=be,center=true,$fn=fn);
      translate([0,0,0])
         cylinder(h=bh+ac,d=(be-(bt*2)),center=true,$fn=fn);
      translate([0,0,0])
         radial_channel();
   }
}
//---------------------------------------------------------|
module radial_internal_ring()
{
   // cone render
   difference()
   {
      translate([0,0,0])
         cylinder(h=bh,d=bi+(bt*2),center=true,$fn=fn);
      translate([0,0,0])
         cylinder(h=bh+ac,d=bi,center=true,$fn=fn);
      translate([0,0,0])
         radial_channel();
   }
}
//---------------------------------------------------------|
module radial_rollers()
{
   // roller render
   ri = 360/ns;  // rotation incremente;
   for(r=[ri:ri:361])
      rotate([0,0,r])
         translate([(be+bi)/4,0,0])
            radial_roller();
}
//---------------------------------------------------------|
module radial_roller()
{
   // individual roller 
   translate([0,0,0])
      sphere(d=sd,center=true,$fn=fn);
}
//---------------------------------------------------------|
module radial_cage()
{
   // cage render
   rd = 360/ns;               // rotation degrees;
   rt = (be-bi)/2-(2*bt)-2;   // ring thickness
   re = (be+bi+sd)/2;         // ring external diamater
   ri = (be+bi-sd)/2;         // ring internal diamater
   cp = gr==2?-sd/2:-sd/1.25; // cut position
   rp = gr==1?cp/4:0;         // ring position
   difference()
   {
      union()
      {
         difference()
         {
            translate([0,0,rp])
               cylinder(h=sd/4,d=re,center=true,$fn=fn);
            translate([0,0,rp])
               cylinder(h=sd/4+ac,d=ri,center=true,$fn=fn);
         }
         intersection()
         {
            difference()
            {
               translate([0,0,0])
                  cylinder(h=bh-1,d=re,center=true,$fn=fn);
               translate([0,0,0])
                  cylinder(h=bh-1+ac,d=ri,center=true,$fn=fn);
            }
            for(r=[rd:rd:361])
               rotate([0,0,r])
                  translate([(be+bi)/4,0,0])
                     rotate([0,90,0])
                        cylinder(h=sd,d=sd*1.3,center=true,$fn=fn);
         }
      }
      if(gr!=3)      
         translate([0,0,cp])
            cylinder(h=sd,d=be+ac,center=true,$fn=fn);
      for(r=[rd:rd:361])
         rotate([0,0,r])
            translate([(be+bi)/4,0,0])
               sphere(d=sd+(ad),center=true,$fn=fn);
      for(r=[rd:rd:361])
         rotate([0,0,r+(rd/2)])
            translate([(be+bi)/4,0,0])
                cylinder(h=bh,d=sd/6,center=true,$fn=fn);
   }
}
//---------------------------------------------------------|
module radial_channel()
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