$fn=36;
Render=3;      //0=stick   1=holder   2=stand     3=all
Arm_length=300;
Arm_width=7;
Core_wire_diameter=1.5;
Phone_thickness=12;
Phone_width=64;
Phone_slide_length=60;
Holder_walls_thickness=2;  //Actually the thickness will be half this value
Stand_length=170;
Stand_width=120;
Stand_fingers_width=11;
Stand_fingers_tips=1;      //0=disable    1=enable
Stand_fingers_tip_diameter=12;
Magnets=1;    //0=None     1=Round      2=Square
Magnet_length=15.2;     //Consider tolerance min 0.2mm for all magnet dimensions
Magnet_width=5.2;
Magnet_heigth=5.2;   //Valid for round magnets too
Magnet_diameter=8.2;  //Ignored if magnets are not round
Section=0;

module ARM(L,W,R)
{
difference()
    {
    union()
        {
        hull()
            {
            translate([-L/2,0,0])
                cube([W,W,W],center=true);
            translate([L/2,0,0])
                cube([W,W,W],center=true);
            }
        }
        translate([0,W/5,W/5])
        hull()
            {
            translate([-L,0,0])
                sphere(r=R/2);
            translate([L,0,0])
                sphere(r=R/2);
            }

        translate([0,-W/5,W/5])
        hull()
            {
            translate([-L,0,0])
                sphere(r=R/2);

            translate([L,0,0])
                sphere(r=R/2);
            }

        translate([0,W/5,-W/5])
        hull()
            {
            translate([-L,0,0])
                sphere(r=R/2);

            translate([L,0,0])
                sphere(r=R/2);
            }

        translate([0,-W/5,-W/5])
        hull()
            {
            translate([-L,0,0])
                sphere(r=R/2);

            translate([L,0,0])
                sphere(r=R/2);
            }
    }
}

module ARM1(L,W,R)
   {
   hull()
      {
      translate([L*5,0,0])
          cube([W,W,W],center=true);
      translate([0,0,0])
          cube([W,W,W],center=true);
    }
}

module Holder(L,W,T)
{
difference()
    {
    union()
        {
        hull()
            {
            translate([0-T,W/2-T,0])
                sphere(r=T);
            translate([-L+T,W/2-T,0])
                sphere(r=T);
            translate([0-T,-W/2+T,0])
                sphere(r=T);
            translate([-L+T,-W/2+T,0])
                sphere(r=T);
            }
        }
        translate([-L*1.5,-W,-W*2])
            cube([L*2,W*2,W*2]);
    }
}

module Phone(L1,W1,T1)
{
difference()
    {
    union()
        {
        hull()
            {
            translate([0-T1,W1/2-T1,0])
                sphere(r=T);
            translate([-L1+T1,W1/2-T1,0])
                sphere(r=T1);
            translate([0-T1,-W1/2+T1,0])
                sphere(r=T);
            translate([-L1+T1,-W1/2+T1,0])
                sphere(r=T1);
            }
        }
        translate([-L1,-W1,-W1*2])
            cube([L1*2,W1*2,W1*2]);
    }
}

module Stand(SL,SW,FW)
   {
    union()
        {
        hull()
            {
            translate([SL/4-FW,0,0])
                sphere(r=FW/1.25);
            translate([SL/2-FW/2,0,0])
                sphere(r=FW/2);
            }

        hull()
            {
            translate([SL/4-FW,0,0])
                sphere(r=FW/1.25);
            translate([-SL/2+FW/2,0,0])
                sphere(r=FW/2);
            }

        hull()
            {
            translate([SL/4-FW,0,0])
                sphere(r=FW/1.25);
            translate([-SL/2/1.5+FW/2,SW/2,0])
                sphere(r=FW/2);
            }

        hull()
            {
            translate([SL/4-FW,0,0])
                sphere(r=FW/1.25);
            translate([-SL/2/1.5+FW/2,-SW/2,0])
                sphere(r=FW/2);
            }
            translate([SL/4-FW,0,0])
            cylinder(r=FW/1.25,h=Arm_width*3);

            translate([SL/4-FW,0,Arm_width*3])
            sphere(r=FW/1.25);

        }
   }


//-------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------CODE----------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------

difference()
{
union()
   {

if(Render==0 || Render==3)
   translate([Stand_length/4-Stand_fingers_width,0,Arm_length/2+3])
      rotate([0,90,0])
      ARM(Arm_length,Arm_width,Core_wire_diameter);



if(Render==1 || Render==3)
translate([Stand_length/4-Stand_fingers_width-Phone_thickness/2,0,Arm_length+Phone_slide_length/2-15])
rotate([0,90,0])
difference()
    {
    union()
        {
         translate([0,0,0])
         Holder(Phone_slide_length+Holder_walls_thickness*2,Phone_width+Holder_walls_thickness*2,Phone_thickness+Holder_walls_thickness*2);

         translate([0,0,0])
            scale([2,1,1.25])
            sphere(r=Phone_thickness+Holder_walls_thickness/2);
        }

         translate([-5,0,Holder_walls_thickness])
         Holder(Phone_slide_length*2+Holder_walls_thickness*2,Phone_width,Phone_thickness);

      translate([0,0,Arm_width/2+Holder_walls_thickness*1.25])
        ARM1(30,Arm_width+0.25,0.01);

      translate([0,0,-50])
        cube([100,100,100],center=true);

      translate([-20,0,0])
      hull()
            {
            translate([-Phone_slide_length*4,Phone_width/3,Phone_thickness*4])
                sphere(r=4);
            translate([-Phone_slide_length*4,-Phone_width/3,Phone_thickness*4])
                sphere(r=4);
            translate([-Phone_slide_length*4,Phone_width/3,-Phone_thickness*4])
                sphere(r=4);
            translate([-Phone_slide_length*4,-Phone_width/3,-Phone_thickness*4])
                sphere(r=4);

            translate([0,-Phone_width/3,Phone_thickness*4])
                sphere(r=4);
            translate([0,Phone_width/3,-Phone_thickness*4])
                sphere(r=4);
            translate([0,Phone_width/3,Phone_thickness*4])
                sphere(r=4);
            translate([0,-Phone_width/3,-Phone_thickness*4])
                sphere(r=4);
            }
    }


if(Render==2 || Render==3)
difference()
   {
   union()
      {
      translate([0,0,0])
         Stand(Stand_length,Stand_width,Stand_fingers_width);

      if(Stand_fingers_tips==1)
         {
         translate([Stand_length/2-Stand_fingers_width/2,0,0])
            sphere(r=Stand_fingers_tip_diameter);

         translate([-Stand_length/2+Stand_fingers_width/2,0,0])
            sphere(r=Stand_fingers_tip_diameter);

         translate([-Stand_length/2/1.5+Stand_fingers_width/2,Stand_width/2,0])
            sphere(r=Stand_fingers_tip_diameter);

         translate([-Stand_length/2/1.5+Stand_fingers_width/2,-Stand_width/2,0])
            sphere(r=Stand_fingers_tip_diameter);
         }
      }

  if(Magnets==1 || Magnets==2)
      translate([0,0,0.5])
      {
      if(Magnets==1)
         {
         translate([Stand_length/2-Stand_fingers_width/2,0,0])
         cylinder(r=Magnet_diameter/2,h=Magnet_heigth);

         translate([-Stand_length/2+Stand_fingers_width/2,0,0])
         cylinder(r=Magnet_diameter/2,h=Magnet_heigth);

         translate([-Stand_length/2/1.5+Stand_fingers_width/2,Stand_width/2,0])
         cylinder(r=Magnet_diameter/2,h=Magnet_heigth);

         translate([-Stand_length/2/1.5+Stand_fingers_width/2,-Stand_width/2,0])
         cylinder(r=Magnet_diameter/2,h=Magnet_heigth);


         }

      if(Magnets==2)
         translate([0,0,Magnet_heigth/2])
         {
         translate([Stand_length/2-Stand_fingers_width/2,0,0])
         cube([Magnet_length,Magnet_width,Magnet_heigth],center=true);

         translate([-Stand_length/2+Stand_fingers_width/2,0,0])
         cube([Magnet_length,Magnet_width,Magnet_heigth],center=true);

         translate([-Stand_length/2/1.5+Stand_fingers_width/2,Stand_width/2,0])
         cube([Magnet_length,Magnet_width,Magnet_heigth],center=true);

         translate([-Stand_length/2/1.5+Stand_fingers_width/2,-Stand_width/2,0])
         cube([Magnet_length,Magnet_width,Magnet_heigth],center=true);

         }

      }

   translate([Stand_length/4-Stand_fingers_width,0,5])
      rotate([0,-90,0])
      ARM1(30,Arm_width+0.5,0.01);

        translate([-Stand_length,-Stand_width,-Stand_fingers_width*8])
            cube([Stand_length*2,Stand_width*2,Stand_fingers_width*8]);

        hull()
            {
            translate([Stand_length/2-Stand_fingers_width/2,0,Stand_fingers_width/4])
                cube(Core_wire_diameter/2);
            translate([-Stand_length/2+Stand_fingers_width/2,0,Stand_fingers_width/4])
                cube(Core_wire_diameter,center=true);
            }

        hull()
            {
            translate([Stand_length/4-Stand_fingers_width,0,Stand_fingers_width/4])
                cube(Core_wire_diameter/2);
            translate([-Stand_length/2/1.5+Stand_fingers_width/2,Stand_width/2,Stand_fingers_width/4])
                cube(Core_wire_diameter,center=true);
            }

        hull()
            {
            translate([Stand_length/4-Stand_fingers_width,0,Stand_fingers_width/4])
                cube(Core_wire_diameter/2);
            translate([-Stand_length/2/1.5+Stand_fingers_width/2,-Stand_width/2,Stand_fingers_width/4])
                cube(Core_wire_diameter,center=true);
            }

   }





}

if(Section==1)
translate([-500,0,0])
cube([1000,1000,1000]);

}