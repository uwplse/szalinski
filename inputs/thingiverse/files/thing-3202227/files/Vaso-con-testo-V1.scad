
Vase_radius_1=33;
Vase_height=100;
Vase_wall_thickness=3;
Vase_bottom_thickness=3;
Twist=0;
scala=5;
Text_radius=32.75;
Text=" A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ";
Font="Corbel";
Font_size=5;
K_incline=0.3; //Inclines the text downward, do not set lower than 0.25

$fn=72;

step=360/len(Text);

difference()
   {
   union()
      {
      for(a=[0:step:360])
          {
              linear_extrude(height=Vase_height,twist=Twist,scale=scala)

              rotate([0,0,-a])
                  translate([0,Text_radius+Font_size,0])
                      rotate([0,0,180])
                      text(Text[a/step],font=Font,halign="center",size=Font_size);
          }
      difference()
         {
         cylinder(r1=Vase_radius_1,r2=Vase_radius_1*scala,h=Vase_height);

         translate([0,0,Vase_bottom_thickness])
            cylinder(r1=Vase_radius_1-Vase_wall_thickness,r2=Vase_radius_1*scala-Vase_wall_thickness-((1/K_incline)*1.5),h=Vase_height-Vase_bottom_thickness+1);
         }
      }

   color("blue")
      difference()
         {
         cylinder(r=Vase_radius_1*scala*2,h=Vase_height+0.1);

         translate([0,0,Vase_bottom_thickness-2.5])
            cylinder(r1=Vase_radius_1*scala*K_incline,r2=Vase_radius_1*scala,h=Vase_height+5);
         }
   }
