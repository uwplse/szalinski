$fn=36;

Tool_or_Nut=3;      //Rendering    1=Tool   2=Nut      3=Assembly both
Adjustment_nut_diameter=18;
Adjustment_nut_heigth=7;
Adjustment_nut_shape=3;
Adjustment_nut_double_shape=1;
Tool_handle_length=100;
Tool_heigth=5;
Tolerance=0.25;
Screw_hole_diameter=3;
Screw_nut_size=7;
Screw_nut_heigth=3;

if(Tool_or_Nut==1 || Tool_or_Nut==3)
translate([0,0,-15])
difference()
   {
   hull()
      {
        cylinder(r=Adjustment_nut_diameter/2+4,h=Tool_heigth);
        translate([Tool_handle_length,0,0])
            cylinder(r=5,h=Tool_heigth);
      }
        translate([0,0,-Tolerance])
            cylinder(r=Adjustment_nut_diameter/2+Tolerance,h=Adjustment_nut_heigth+Tolerance*2,$fn=Adjustment_nut_shape);
        if(Adjustment_nut_double_shape==1)
            translate([0,0,-Tolerance])
                rotate([0,0,360/Adjustment_nut_shape/2])
                    cylinder(r=Adjustment_nut_diameter/2+Tolerance,h=Adjustment_nut_heigth+Tolerance*2,$fn=Adjustment_nut_shape);
        translate([0,0,-Tolerance])
            cylinder(r=Adjustment_nut_diameter/2-3+Tolerance,h=Adjustment_nut_heigth+1+Tolerance*2);
    }

if(Tool_or_Nut==2 || Tool_or_Nut==3)
difference()
   {
   union()
      {
        cylinder(r=Adjustment_nut_diameter/2,h=Adjustment_nut_heigth,$fn=Adjustment_nut_shape);
        if(Adjustment_nut_double_shape==1)
            rotate([0,0,360/Adjustment_nut_shape/2])
                cylinder(r=Adjustment_nut_diameter/2,h=Adjustment_nut_heigth,$fn=Adjustment_nut_shape);
        cylinder(r=Adjustment_nut_diameter/2-3,h=Adjustment_nut_heigth+1);
      }

     translate([0,0,-1])
        cylinder(r=Screw_hole_diameter/2,h=Adjustment_nut_heigth*2);


     translate([0,0,-1])
        cylinder(r=Screw_nut_size/2*1.2,h=Screw_nut_heigth+1,$fn=6);


   }