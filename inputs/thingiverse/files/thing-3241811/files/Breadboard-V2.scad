$fn=36;

//Big breadboard measures are 160x55mm
//Small one 84x55mm

Breadboard_size_X=165;      
Breadboard_size_Y=55;
Breadboard_size_Z=8.5;
Step_sockets=2.54;
Power_sockets_distance_Y=23;
Connections_sockets_columns=60;
Connections_sockets_distance_Y=Step_sockets*3;
Text_font_size=2;
Sockets_hole_size=1;


module Sockets ()
   {
      color("LightGrey")
      translate([0,0,Breadboard_size_Z/2])
         cube([Sockets_hole_size,Sockets_hole_size,Breadboard_size_Z],center=true);
      translate([0,0,Breadboard_size_Z-0.99])
         linear_extrude(height=1,scale=2)
            square([Sockets_hole_size,Sockets_hole_size],center=true);
   }

module Sockets_back_opening ()
   {
      translate([0,0,Breadboard_size_Z/2-2])
         cube([2.1,2.1,Breadboard_size_Z],center=true);
   }

module abcde(b)
   {
   linear_extrude(1,center=true)
      rotate([0,0,90])
         text(chr(b+97),size=Text_font_size,halign="center");
   }

module plus()
   {
   linear_extrude(1,center=true)
      rotate([0,0,90])
         text("+",size=Text_font_size,valign="center",halign="center");
   }
module minus()
   {
   linear_extrude(1,center=true)
      rotate([0,0,90])
         text("-",size=Text_font_size,valign="center",halign="center");
   }

module Power_sockets()
   {
      translate([Step_sockets/2,Step_sockets/2,0])
      for(b=[0:1:Connections_sockets_columns-1])
         {
         if(b!=5 && b!=11 && b!=17 && b!=23 && b!=29 && b!=35 && b!=41 && b!=47 && b!=53 && b!=59 && b!=65 && b!=71)
            translate([-(Connections_sockets_columns-1)*Step_sockets/2+b*Step_sockets,0,0])
               {
               Sockets();

               translate([0,-Step_sockets,0])
                  Sockets();
               }

         if(b==0 || b==6 || b==12 || b==18 || b==24 || b==30 || b==36 || b==42 || b==48 || b==54 || b==60 || b==66)
            translate([-(Connections_sockets_columns-1)*Step_sockets/2+b*Step_sockets,0,0])
            {
            hull()
               {
                  Sockets_back_opening();

               translate([Step_sockets*4,0,0])
                  Sockets_back_opening();
               }
            
            translate([0,-Step_sockets,0])
               hull()
                  {
                  Sockets_back_opening();

                  translate([Step_sockets*4,0,0])
                     Sockets_back_opening();
                  }
            }
         if(b<Connections_sockets_columns-6)
            if(b==3 || b==9 || b==15 || b==21 || b==27 || b==33 || b==39 || b==45 || b==51 || b==57 || b==63 || b==69)
               translate([-(Connections_sockets_columns-1)*Step_sockets/2+b*Step_sockets,0,0])
               {
               translate([0,-Step_sockets,-5])
                  hull()
                     {
                     Sockets_back_opening();

                     translate([Step_sockets*7,0,0])
                        Sockets_back_opening();
                  }

               translate([0,0,-5])
                  hull()
                     {
                     Sockets_back_opening();

                     translate([Step_sockets*7,0,0])
                        Sockets_back_opening();
                     }
               }
         }

         translate([-(Connections_sockets_columns-1)*Step_sockets/2-Step_sockets,0,Breadboard_size_Z])
            {
            translate([0,Step_sockets/2,0])
               plus();

            translate([0,-Step_sockets/2,0])
               minus();
            }

         translate([(Connections_sockets_columns-1)*Step_sockets/2+Step_sockets,0,Breadboard_size_Z])
            {
            translate([0,Step_sockets/2,0])
               plus();

            translate([0,-Step_sockets/2,0])
               minus();
            }
      }


module Connections_sockets(Side)
   {
   for(b=[0:1:Connections_sockets_columns-1])
         {
         translate([b*Step_sockets-(Connections_sockets_columns-1)*Step_sockets/2,0,0])
            {
            translate([0,Step_sockets*2,0])
               Sockets();
            translate([0,Step_sockets,0])
               Sockets();
            translate([0,0,0])
               Sockets();
            translate([0,-Step_sockets,0])
               Sockets();
            translate([0,-Step_sockets*2,0])
               Sockets();
            }

         translate([b*Step_sockets-(Connections_sockets_columns-1)*Step_sockets/2,0,0])
            hull()
               {
               translate([0,Step_sockets*2,0])
                  Sockets_back_opening();
               translate([0,-Step_sockets*2,0])
                  Sockets_back_opening();
               }

      if(Side==0)
         translate([-((Connections_sockets_columns-1)*Step_sockets/2)+b*Step_sockets,Step_sockets*3.5,Breadboard_size_Z])
            linear_extrude(1,center=true)
               rotate([0,0,90])
                  text(str(b+1),size=Text_font_size,valign="center",halign="center");
      if(Side==1)
            translate([-((Connections_sockets_columns-1)*Step_sockets/2)+b*Step_sockets,-Step_sockets*3.5,Breadboard_size_Z])
               linear_extrude(1,center=true)
                  rotate([0,0,90])
                     text(str(b+1),size=Text_font_size,valign="center",halign="center");


         if(b<5 && Side==0)
            translate([0,b*Step_sockets-Step_sockets*2,Breadboard_size_Z])
               {
               translate([(Connections_sockets_columns-1)*Step_sockets/2+Step_sockets*1.5,0,0])
                     abcde(b+5);

               translate([-(Connections_sockets_columns-1)*Step_sockets/2-Step_sockets,0,0])
                  abcde(b+5);
               }

         if(b<5 && Side==1)
            translate([0,b*Step_sockets-Step_sockets*2,Breadboard_size_Z])
               {
               translate([(Connections_sockets_columns-1)*Step_sockets/2+Step_sockets*1.5,0,0])
                     abcde(b);

               translate([-(Connections_sockets_columns-1)*Step_sockets/2-Step_sockets,0,0])
                  abcde(b);
               }
         }
   }

//-------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------

difference()
   {
   union()
      {
      color("LightGrey")
      translate([0,0,Breadboard_size_Z/2])
       cube([Breadboard_size_X,Breadboard_size_Y,Breadboard_size_Z],center=true);
      }

//Connections sockets
  color("grey")
   translate([0,Connections_sockets_distance_Y,0])
      Connections_sockets(0);
  color("grey") 
   translate([0,-Connections_sockets_distance_Y,0])
      Connections_sockets(1);
   

//Power sockets
color("grey")
   translate([0,Power_sockets_distance_Y,0])
      Power_sockets();
color("grey")
   translate([0,-Power_sockets_distance_Y,0])
      Power_sockets();

//Middle cut 
color("grey")     
   translate([0,0,Breadboard_size_Z])
      cube([Breadboard_size_X+10,1,4],center=true);

   }