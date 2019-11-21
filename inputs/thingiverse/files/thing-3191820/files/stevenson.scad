// 42x23x150


height=120;
radius=30.2;
radius2=50;

t=0.4;

support_t=0.4;
support_t2=1.2;
pillar_t=2.4;
cyl_t=1.2;
cyl_t2=2.4;

module shield()
{
   union()
   {
      if (1) // blinds
         rotate_extrude($fn=180)
            rotate([0,0,90])
            union()
         {
            for (i=[0:10:height])
            {
               translate([-i,radius,0]) rotate(45) translate([-0.8,0]) square([0.8,20]);
            }

            translate([-1.6,0])
               square([1.6,radius]);
         }

      if (1)
         intersection()
         {
            difference()
            {
               union()
               {
                  //               for (a=[0:360/5:360-1])
                  //                  rotate([0,0,a])
                  //                     translate([-0.5,radius2-12,-height-21])
                  //                     cube([1,4,height+20]);
                  if (1) // pillars
                  for (a=[0:360/5:360-1])
                     rotate([0,0,a])
                     {
                        translate([-pillar_t/2,0,-height-15])
                           cube([pillar_t,radius2-12,height+15]);
                     }
                  if (1) // support
                  for (a=[0:360/50:360-1])
                     rotate([0,0,a])
                        translate([-support_t/2,radius2-20,-height-6])
                        cube([support_t,2,height+5]);

                  if (1) // strong support 
                     {
                  for (a=[21.6:360/5:360-1])
                     rotate([0,0,a])
                        translate([-support_t2/2,radius2-20,-height-6])
                        cube([support_t2,2,height+5]);
                  for (a=[-21.6:360/5:360-1])
                     rotate([0,0,a])
                        translate([-support_t2/2,radius2-20,-height-6])
                        cube([support_t2,2,height+5]);
                  }

                  if (0)
                     for (i=[20,40,100,150])
                        translate([0,0,-i]) cube([100,100,0.1],center=true);
               }

               // holes in support
               if (1)
                     for (a=[0:360/5:360-1])
                        rotate([0,0,a])
                           {
                              for (dh=[-20/2:7:height+40])
                        {
                           translate([0,9,-dh-1])
                              rotate([0,90,0])
                              cylinder(r=3,h=pillar_t+2,center=true,$fn=6);
                           translate([0,27,-dh-1])
                              rotate([0,90,0])
                              cylinder(r=3,h=pillar_t+2,center=true,$fn=6);
                           translate([0,34,-dh-6-7*2])
                              rotate([0,90,0])
                              cylinder(r=3,h=pillar_t+2,center=true,$fn=6);
                        }
                              for (dh=[-20/2+2.5:6:height+40])
                           translate([0,20.2,-dh-1])
                              rotate([0,90,0])
                              cylinder(r=2.5,h=pillar_t+2,center=true,$fn=6);
                              }
               if (1) // middle cylinder
               translate([0,0,-15])
                  cylinder(h=20,r=5.3,center=true);
            }
            // cut box around for testing
            if (0) translate([0,0,0]) cube([43+5,25+5,150+5],center=true);
            translate([0,0,-40-height-0.5]) cylinder(r1=radius+40+height,r2=radius,40+height,$fn=60);

         }
   }
}

module casing()
{
   h=150;
   d=25;
   w=43;
   t=0.1;
   t2=t*2;
   translate([0,0,-h/2-10])
   {
      union()
      {
         translate([0,0,0]) cube([w+t2,d+t2,h],center=true);
         translate([0,0,h/2-10-55])
            cube([w-2,d+t2+2,30],center=true);
      }
   }
}

module box(pos,size) { translate(pos) cube(size); }

// 35mm more
module flerp(type=2)
{
   flerpd=31.5;
   difference()
   {
      union()
      {
         if (type==1)
            difference()
            {
               translate([0,0,-height-15-35-20])
                  cylinder(h=55,r=35,$fn=180);
            
               translate([0,0,-height-15-35-1-20])
                  cylinder(h=80+2,r=35-0.8,$fn=180);
            }
         difference()
         {
            union()
            {
               translate([0,0,-height-15-35-20])
                  cylinder(h=75,r=flerpd,$fn=180);

               if (type==1)
                  for (a=[0:360/5:360-1])
                     rotate([0,0,a])
                     {
                        translate([-0.8,0,-height-15-35-20])
                           cube([0.8,34.5,55]);
                     }

               if (type==2)
                  rotate_extrude($fn=180)
                     rotate([0,0,90])
                     union()
                     for (i=[height+10:10:height+50])
                     {
                        translate([-i,radius,0]) rotate(45) translate([-0.8,-5,0]) square([0.8,20+5]);
                     }

               intersection()
               {
                  box([-15-cyl_t2,1,-height-15-35-20],[30+cyl_t2*2,39,25]); // arm cable tie frame
                  translate([0,0,-height-15-35-15-5]) cylinder(h=25,r1=50,r2=25);
                  translate([0,0,-height-15-35-15-18]) cylinder(h=45,r2=60,r1=30);
               }
   
            }

            translate([0,0,-height-15-35-1+1.99])
               cylinder(h=80+2,r=flerpd-cyl_t,$fn=180);
            translate([0,0,-height-15-35-1-20])
               cylinder(h=80+2,r=flerpd-cyl_t2,$fn=180);
            translate([0,0,-height-15-35-1-2])
               cylinder(h=4,r2=flerpd-cyl_t,r1=flerpd-cyl_t2,$fn=180);

            box([-40,-4,-height-15-35-2-15],[80,8,4]); // cutout for cable tie
            box([-20,26,-height-15-35-2-15],[40,7,4]); // cutout for cable tie
         }

         
      }
         

      box([-15,0,-height-15-35-50],[30,50,50]);

//      if (type==2)
//      for (a=[0:360/5:360-1])
//         rotate([0,0,a])
//         {
//            translate([-0.8,0,-height-15])
//               cube([1.6,radius2-12,height+15]);
//         }
   }


   if (0) // connecting pieces (check look)
   rotate_extrude($fn=100)
      rotate([0,0,90])
      union()
      for (i=[height-10:10:height])
      {
         translate([-i,radius,0]) rotate(45) translate([-0.8,0]) square([0.8,20]);
      }
   
}

rotate([0,180,0])
{
flerp();
// casing();

if (1)
difference()
{
   shield();
   casing();
   // cut top
   // translate([0,0,100-1]) cube([100,100,200],center=true);
}

}
