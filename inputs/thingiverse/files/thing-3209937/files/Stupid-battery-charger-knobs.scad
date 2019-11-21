$fn=36;

Knob_diameter=20;
Knob_heigth=15;
Knob_neck_diameter=15;
Knob_neck_heigth=4;
Knob_style=1;           //[0,1]
Knob_grips_number=2;
Knob_hole_diameter=6.6;
Knob_hole_heigth=15;    //the diameter is based on potentiometer shaft parameters



module Knob(Kd,Kh,Knd,Knh,T,Khd,Khh)
   {
   rotate([0,180,0])
   difference()
      {
      union()
         {
         cylinder(d=Kd,h=Kh,$fn=Knob_grips_number);
         
         if(Knob_style==1)
            rotate([0,0,360/Knob_grips_number/2])
               cylinder(d=Kd,h=Kh,$fn=Knob_grips_number);
         
         cylinder(d=Knd,h=Kh+Knh);
         }
      translate([0,0,-0.5])
      linear_extrude(height=2)
         text(str(T),valign="center",halign="center",size=Knd/2,font="Arial:style=Bold");

      translate([0,0,Kh+Knh-Khh+1])
         cylinder(d=Khd,h=Khh+1);
      }
   }

//--------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------------

translate([Knob_diameter,0,0])
rotate([0,0,0])
Knob(Knob_diameter,Knob_heigth,Knob_neck_diameter,Knob_neck_heigth,"V",Knob_hole_diameter,Knob_hole_heigth);
translate([-Knob_diameter,0,0])
rotate([0,0,0])
Knob(Knob_diameter,Knob_heigth,Knob_neck_diameter,Knob_neck_heigth,"A",Knob_hole_diameter,Knob_hole_heigth);
