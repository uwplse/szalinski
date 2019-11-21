$fn=36;

Edit_mode=0;  //0=Render   1=edit mode
Show_openings=0;     //side cuts
Show_cut_level=1;    //cut between top and bottom part level
Cut_level=6;
Tolerance=0.2;
Section=3;     //1=Top     2=Bottom    3=Top and bottom

/*[Box parameters]*/
Battery_charger_width=65;
Battery_charger_length=125;
Battery_charger_heigth=45;
Battery_charger_wall_thickness=2;
Battery_charger_position_X=0;
Battery_charger_position_Y=-13;
Battery_charger_position_Z=2;
Screw_fitting_diameter=8;
Screw_holes_diameter=2.5;
Screw_recess_depth=2.5;
Border_fillet=1;

/*[Potentiometer parameters]*/
//Common
Potentiometer_shaft_diameter=6.25;
Potentiometer_shaft_heigth=14;
Potentiometer_body_diameter=22;
Potentiometer_body_heigth=18;
Potentiometer_thread_diameter=10;
Potentiometer_thread_heigth=10;

//Pot 1
Potentiometer_1_position_X=15;
Potentiometer_1_position_Y=35;
Potentiometer_1_position_Z=5.5;
Potentiometer_1_rotation_X=0;
Potentiometer_1_rotation_Y=0;
Potentiometer_1_rotation_Z=0;

//Pot2
Potentiometer_2_position_X=-15;
Potentiometer_2_position_Y=35;
Potentiometer_2_position_Z=5.5;
Potentiometer_2_rotation_X=0;
Potentiometer_2_rotation_Y=0;
Potentiometer_2_rotation_Z=0;

/*[Battery holder parameters]*/
Battery_holder_number=2;
Battery_holder_width=17;
Battery_holder_length=57;
Battery_holder_position_X=0;
Battery_holder_position_Y=-43;
Battery_holder_position_Z=20;
Battery_holder_rotation=0;

/*[Gauge parameters]*/
Gauge_width=26;
Gauge_length=46;
Gauge_heigth=18;
Gauge_position_X=0;
Gauge_position_Y=5;
Gauge_position_Z=22;
Gauge_rotation=90;

/*[Voltage regulator parameters]*/
Voltage_regulator_width=26;
Voltage_regulator_length=51;
Voltage_regulator_heigth=18;
Voltage_regulator_position_X=0;
Voltage_regulator_position_Y=30;
Voltage_regulator_position_Z=-8;
Voltage_regulator_rotation=90;

/*[Power supply parameters]*/
Power_supply_width=39;
Power_supply_length=78;
Power_supply_heigth=23;
Power_supply_position_X=0;
Power_supply_position_Y=-30;
Power_supply_position_Z=-5.5;
Power_supply_rotation=0;

Openings=25;
Opening_width=2;
Opening_length=90;
Opening_heigth=30;
Openings_interspace=2;
Openings_rotation_X=0;
Openings_rotation_Z=0;
Openings_position_X=0;
Openings_position_Y=-61;
Openings_position_Z=5;

module Potentiometer()
                     {
                        translate([0,0,0])
                        cylinder(r=Potentiometer_body_diameter/2,h=Potentiometer_body_heigth);
                       translate([0,0,0])
                        cylinder(r=Potentiometer_thread_diameter/2,h=Potentiometer_body_heigth+Potentiometer_thread_heigth);

                       translate([0,0,Potentiometer_body_heigth+2+Battery_charger_wall_thickness])
                        cylinder(r=Potentiometer_thread_diameter/2+3,h=1);
                       translate([0,0,Potentiometer_body_heigth+2])
                        cylinder(r=Potentiometer_thread_diameter/2+3,h=1);

                       translate([0,0,0])
                        cylinder(r=Potentiometer_shaft_diameter/2,h=Potentiometer_body_heigth+Potentiometer_thread_heigth+Potentiometer_shaft_heigth);
                     }

module Potentiometer1()
                     {
                        translate([0,0,0])
                        cylinder(r=Potentiometer_body_diameter/2,h=Potentiometer_body_heigth);
                       translate([0,0,0])
                        cylinder(r=Potentiometer_thread_diameter/2,h=Potentiometer_body_heigth+Potentiometer_thread_heigth);

                       translate([0,0,0])
                        cylinder(r=Potentiometer_shaft_diameter/2,h=Potentiometer_body_heigth+Potentiometer_thread_heigth+Potentiometer_shaft_heigth);
                     }


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------


if(Edit_mode==1)
difference()
   {
   union()
      {
         translate([Battery_charger_position_X,Battery_charger_position_Y,Battery_charger_position_Z])
      %hull()
         {
         translate([Battery_charger_width/2,Battery_charger_length/2,Battery_charger_heigth/2])
            sphere(r=Border_fillet,$fn=4);
         translate([Battery_charger_width/2,Battery_charger_length/2,-Battery_charger_heigth/2])
            sphere(r=0.1);
         translate([Battery_charger_width/2,-Battery_charger_length/2,Battery_charger_heigth/2])
            sphere(r=Border_fillet,$fn=4);
         translate([Battery_charger_width/2,-Battery_charger_length/2,-Battery_charger_heigth/2])
            sphere(r=0.1);
         translate([-Battery_charger_width/2,Battery_charger_length/2,Battery_charger_heigth/2])
            sphere(r=Border_fillet,$fn=4);
         translate([-Battery_charger_width/2,Battery_charger_length/2,-Battery_charger_heigth/2])
            sphere(r=0.1);
         translate([-Battery_charger_width/2,-Battery_charger_length/2,Battery_charger_heigth/2])
            sphere(r=Border_fillet,$fn=4);
         translate([-Battery_charger_width/2,-Battery_charger_length/2,-Battery_charger_heigth/2])
            sphere(r=0.1);
         }
         color("Red")
         translate([Power_supply_position_X,Power_supply_position_Y,Power_supply_position_Z])
            rotate([0,0,Power_supply_rotation])
            cube([Power_supply_width,Power_supply_length,Power_supply_heigth],center=true);
         
         color("Orange")
         translate([Voltage_regulator_position_X,Voltage_regulator_position_Y,Voltage_regulator_position_Z])
            rotate([0,0,Voltage_regulator_rotation])
            cube([Voltage_regulator_width,Voltage_regulator_length,Voltage_regulator_heigth],center=true);
      
         color("Green")
         translate([Gauge_position_X,Gauge_position_Y,Gauge_position_Z])
            rotate([0,0,Gauge_rotation])
            cube([Gauge_width,Gauge_length,Gauge_heigth],center=true);

         color("blue")
            translate([Battery_holder_position_X,Battery_holder_position_Y,Battery_holder_position_Z])
            translate([-(Battery_holder_number-1)/2*(Battery_holder_width+2),0,0])
            rotate([0,0,Battery_holder_rotation])
            for(a=[0:1:Battery_holder_number-1])
            hull()
               {
                  translate([(Battery_holder_width+2)*a,0,0])
                  rotate([90,0,0])
                     cylinder(r=Battery_holder_width/2,h=Battery_holder_length,center=true);
                  translate([(Battery_holder_width+2)*a,0,-Battery_holder_width/2])
                  rotate([0,0,0])
                     cube([Battery_holder_width,Battery_holder_length,1],center=true);

               }

               color("Violet")
                  {
                  translate([Potentiometer_1_position_X,Potentiometer_1_position_Y,Potentiometer_1_position_Z])
                     rotate([Potentiometer_1_rotation_X,Potentiometer_1_rotation_Y,Potentiometer_1_rotation_Z])
                        Potentiometer();
                  translate([Potentiometer_2_position_X,Potentiometer_2_position_Y,Potentiometer_2_position_Z])
                     rotate([Potentiometer_2_rotation_X,Potentiometer_2_rotation_Y,Potentiometer_2_rotation_Z])
                        Potentiometer();
                  }
         
               color("brown")
                  {
                  
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);

                  }

               color("Black")
                  {
                  
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2-Border_fillet])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2-Border_fillet])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2-Border_fillet])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2-Border_fillet])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z-Border_fillet/2])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z-Border_fillet/2])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  }


      if(Show_openings==1)
      color("Grey")
      translate([Openings_position_X,Openings_position_Y,Openings_position_Z])
      for(a=[0:1:Openings-1])
         {
         translate([0,(Openings_interspace+Opening_width)*a,0])
            rotate([Openings_rotation_X,0,Openings_rotation_Z])
            cube([Opening_length,Opening_width,Opening_heigth],center=true);
         }

         if(Show_cut_level==1)
        %color("White")
         translate([0,0,-Battery_charger_heigth/2+Cut_level+Battery_charger_position_Z-0.2])
         rotate([Openings_rotation_X,Openings_rotation_Y,Openings_rotation_Z])
         cube([300,300,0.1],center=true);


      }


   }

if(Edit_mode==0)

difference(4)
{
union(3)
   {
difference(2)
   {
   union(1)
      {
         translate([Battery_charger_position_X,Battery_charger_position_Y,Battery_charger_position_Z])
      hull()
         {
         translate([Battery_charger_width/2,Battery_charger_length/2,Battery_charger_heigth/2])
            sphere(r=Border_fillet);
         translate([Battery_charger_width/2,Battery_charger_length/2,-Battery_charger_heigth/2])
            sphere(r=0.1);
         translate([Battery_charger_width/2,-Battery_charger_length/2,Battery_charger_heigth/2])
            sphere(r=Border_fillet);
         translate([Battery_charger_width/2,-Battery_charger_length/2,-Battery_charger_heigth/2])
            sphere(r=0.1);
         translate([-Battery_charger_width/2,Battery_charger_length/2,Battery_charger_heigth/2])
            sphere(r=Border_fillet);
         translate([-Battery_charger_width/2,Battery_charger_length/2,-Battery_charger_heigth/2])
            sphere(r=0.1);
         translate([-Battery_charger_width/2,-Battery_charger_length/2,Battery_charger_heigth/2])
            sphere(r=Border_fillet);
         translate([-Battery_charger_width/2,-Battery_charger_length/2,-Battery_charger_heigth/2])
            sphere(r=0.1);
         }       

      }  //fine Union(1)

      translate([Battery_charger_position_X,Battery_charger_position_Y,Battery_charger_position_Z])
      hull()
         {
         translate([Battery_charger_width/2-Battery_charger_wall_thickness,Battery_charger_length/2-Battery_charger_wall_thickness,Battery_charger_heigth/2-Battery_charger_wall_thickness])
            sphere(r=Border_fillet);
         translate([Battery_charger_width/2-Battery_charger_wall_thickness,Battery_charger_length/2-Battery_charger_wall_thickness,-Battery_charger_heigth/2+Battery_charger_wall_thickness])
            sphere(r=0.1);
         translate([Battery_charger_width/2-Battery_charger_wall_thickness,-Battery_charger_length/2+Battery_charger_wall_thickness,Battery_charger_heigth/2-Battery_charger_wall_thickness])
            sphere(r=Border_fillet);
         translate([Battery_charger_width/2-Battery_charger_wall_thickness,-Battery_charger_length/2+Battery_charger_wall_thickness,-Battery_charger_heigth/2+Battery_charger_wall_thickness])
            sphere(r=0.1);
         translate([-Battery_charger_width/2+Battery_charger_wall_thickness,Battery_charger_length/2-Battery_charger_wall_thickness,Battery_charger_heigth/2-Battery_charger_wall_thickness])
            sphere(r=Border_fillet);
         translate([-Battery_charger_width/2+Battery_charger_wall_thickness,Battery_charger_length/2-Battery_charger_wall_thickness,-Battery_charger_heigth/2+Battery_charger_wall_thickness])
            sphere(r=0.1);
         translate([-Battery_charger_width/2+Battery_charger_wall_thickness,-Battery_charger_length/2+Battery_charger_wall_thickness,Battery_charger_heigth/2-Battery_charger_wall_thickness])
            sphere(r=Border_fillet);
         translate([-Battery_charger_width/2+Battery_charger_wall_thickness,-Battery_charger_length/2+Battery_charger_wall_thickness,-Battery_charger_heigth/2+Battery_charger_wall_thickness])
            sphere(r=0.1);
         }

            color("Violet")
               {
                  translate([Potentiometer_1_position_X,Potentiometer_1_position_Y,Potentiometer_1_position_Z])
                     rotate([Potentiometer_1_rotation_X,Potentiometer_1_rotation_Y,Potentiometer_1_rotation_Z])
                        Potentiometer1();
                  translate([Potentiometer_2_position_X,Potentiometer_2_position_Y,Potentiometer_2_position_Z])
                     rotate([Potentiometer_2_rotation_X,Potentiometer_2_rotation_Y,Potentiometer_2_rotation_Z])
                        Potentiometer1();
               }

      
         color("Green")
         translate([Gauge_position_X,Gauge_position_Y,Gauge_position_Z])
            rotate([0,0,Gauge_rotation])
            cube([Gauge_width,Gauge_length,Gauge_heigth],center=true);


      color("Grey")
      translate([Openings_position_X,Openings_position_Y,Openings_position_Z])
      for(a=[0:1:Openings-1])
         {
         translate([0,(Openings_interspace+Opening_width)*a,0])
            rotate([Openings_rotation_X,0,Openings_rotation_Z])
            cube([Opening_length,Opening_width,Opening_heigth],center=true);
         }
   }    //fine Difference(2)

         //
         color("blue")
            translate([Battery_holder_position_X,Battery_holder_position_Y,Battery_holder_position_Z])
            translate([-(Battery_holder_number-1)/2*(Battery_holder_width+2),0,0])
            rotate([0,0,Battery_holder_rotation])
            for(a=[0:1:Battery_holder_number-1])
            hull()
               {
                  translate([(Battery_holder_width+2)*a,0,0])
                  rotate([0,0,0])
                     cube([Battery_holder_width+4,Battery_holder_length+4,Battery_holder_width+4],center=true);
               }

               color("brown")
                  {
                  
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z+Border_fillet/2])
                     cylinder(r=Screw_fitting_diameter/2,h=Battery_charger_heigth,center=true);
                  }

}        //fine Union(3)

         color("blue")
            translate([Battery_holder_position_X,Battery_holder_position_Y,Battery_holder_position_Z])
            translate([-(Battery_holder_number-1)/2*(Battery_holder_width+2),0,0])
            rotate([0,0,Battery_holder_rotation])
            for(a=[0:1:Battery_holder_number-1])
            hull()
               {
                  translate([(Battery_holder_width+2)*a,0,0])
                  rotate([0,0,0])
                     cube([Battery_holder_width+Tolerance,Battery_holder_length+Tolerance,Battery_holder_width+Tolerance],center=true);
               }

         color("blue")
            translate([Battery_holder_position_X,Battery_holder_position_Y,Battery_holder_position_Z-Battery_holder_width/2])
            translate([-(Battery_holder_number-1)/2*(Battery_holder_width+2),0,0])
            rotate([0,0,Battery_holder_rotation])
            for(a=[0:1:Battery_holder_number-1])
            hull()
               {
                  translate([(Battery_holder_width+2)*a,0,0])
                  rotate([0,0,0])
                     cube([Battery_holder_width,Battery_holder_length,1],center=true);
                 translate([(Battery_holder_width+2)*a,0,-5])
                  rotate([0,0,0])
                     cube([Battery_holder_width-10,Battery_holder_length-10,1],center=true);

               }

               color("Black")
                  {
                  
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2-Border_fillet])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2-Border_fillet])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2-Border_fillet])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Border_fillet/2-Border_fillet])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z-Border_fillet/2])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z-Border_fillet/2])
                     cylinder(r=Screw_holes_diameter/2,h=Battery_charger_heigth,center=true);
                  }

               translate([0,0,Battery_charger_position_Z-Battery_charger_heigth/2-Battery_charger_wall_thickness+Screw_recess_depth])
               color("Purple")
                  {
                  
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Battery_charger_wall_thickness/2-Border_fillet-2.6+Screw_recess_depth/2])
                     cylinder(r=Screw_holes_diameter,h=Screw_holes_diameter*2,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Battery_charger_wall_thickness/2-Border_fillet-2.6+Screw_recess_depth/2])
                     cylinder(r=Screw_holes_diameter,h=Screw_holes_diameter*2,center=true);
                  translate([-Battery_charger_width/2-Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_length/2+Battery_charger_position_Y-Screw_fitting_diameter/2,Battery_charger_position_Z+Battery_charger_wall_thickness/2-Border_fillet-2.6+Screw_recess_depth/2])
                     cylinder(r=Screw_holes_diameter,h=Screw_holes_diameter*2,center=true);
                  translate([-Battery_charger_width/2-Battery_charger_position_X+Screw_fitting_diameter/2,-Battery_charger_length/2+Battery_charger_position_Y+Screw_fitting_diameter/2,Battery_charger_position_Z+Battery_charger_wall_thickness/2-Border_fillet-2.6+Screw_recess_depth/2])
                     cylinder(r=Screw_holes_diameter,h=Screw_holes_diameter*2,center=true);
                  translate([-Battery_charger_width/2+Battery_charger_position_X+Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z+Battery_charger_wall_thickness/2-Border_fillet-2.6+Screw_recess_depth/2])
                     cylinder(r=Screw_holes_diameter,h=Screw_holes_diameter*2,center=true);
                  translate([Battery_charger_width/2+Battery_charger_position_X-Screw_fitting_diameter/2,Battery_charger_position_Y,Battery_charger_position_Z+Battery_charger_wall_thickness/2-Border_fillet-2.6+Screw_recess_depth/2])
                     cylinder(r=Screw_holes_diameter,h=Screw_holes_diameter*2,center=true);
                  }



translate([-150,-150,Battery_charger_heigth/2+Battery_charger_position_Z+Border_fillet])
cube([300,300,300]);

      if(Section==2)
      translate([-Battery_charger_width+Battery_charger_position_X,-Battery_charger_length+Battery_charger_position_Y,-Battery_charger_heigth/2-Battery_charger_wall_thickness/2+Battery_charger_position_Z+Border_fillet/4+Cut_level])
      cube([Battery_charger_width*2,Battery_charger_length*2,Battery_charger_heigth+Border_fillet]);

      if(Section==1)
         translate([-Battery_charger_width+Battery_charger_position_X,-Battery_charger_length+Battery_charger_position_Y,-Battery_charger_heigth/2-Battery_charger_wall_thickness/2+Battery_charger_position_Z+Border_fillet/4+Cut_level-Battery_charger_heigth-Border_fillet])
      cube([Battery_charger_width*2,Battery_charger_length*2,Battery_charger_heigth+Border_fillet]);




//Sezione

*translate([0,-150,0])
cube([300,300,300]);
}     //fine Difference(4)
