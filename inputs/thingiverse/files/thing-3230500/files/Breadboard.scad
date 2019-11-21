$fn=36;

//Big breadboard measures are 160x55mm
//Small one 84x55mm

Breadboard_size_X=84;      
Breadboard_size_Y=55;
Breadboard_size_Z=8.5;
Power_sockets_groups=5;
Power_sockets_distance_Y=23;
Connections_sockets_columns=30;
Connections_sockets_distance_Y=9.5;
Hollow=1;

module Sockets ()
   {
   translate([-0.5,-2.54-0.5-2.54*2,0])
   for(a=[1:1:5])
      {
      translate([0,a*2.54,1])
         cube([1,1,Breadboard_size_Z]);
      translate([0.5,a*2.54+0.5,Breadboard_size_Z-0.99])
         linear_extrude(height=1,scale=2)
            square([1,1],center=true);
      }
   }

//-------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------

difference()
   {
   union()
      {
      translate([0,0,Breadboard_size_Z/2])
       cube([Breadboard_size_X,Breadboard_size_Y,Breadboard_size_Z],center=true);
      }

//Connections sockets

   translate([0,Connections_sockets_distance_Y,0])
      for(b=[0:1:Connections_sockets_columns-1])
         {
         translate([b*2.54,0,0])
            translate([-(Connections_sockets_columns-1)*2.54/2,0,0])
               Sockets();
         translate([b*2.54,2.54*3,0])
            translate([-(Connections_sockets_columns-1)*2.54/2,0,Breadboard_size_Z])
               linear_extrude(1,center=true)
                  rotate([0,0,90])
                     text(str(b+1),size=2,valign="center",halign="center");
         if(b<5)
         translate([-2.54,b*2.54-2.54*2,0])
            translate([-(Connections_sockets_columns-1)*2.54/2,0,Breadboard_size_Z])
               linear_extrude(1,center=true)
                  rotate([0,0,90])
                     text(chr(b+97),size=2,valign="center",halign="center");
         }
   translate([0,-Connections_sockets_distance_Y,0])
      for(b=[0:1:Connections_sockets_columns-1])
         {
         translate([b*2.54,0,0])
            translate([-(Connections_sockets_columns-1)*2.54/2,0,0])
               Sockets();
         translate([b*2.54,-2.54*3,0])
            translate([-(Connections_sockets_columns-1)*2.54/2,0,Breadboard_size_Z])
               linear_extrude(1,center=true)
                  rotate([0,0,90])
                     text(str(b+1),size=2,valign="center",halign="center");
         if(b<5)
         translate([-2.54,b*2.54-2.54*2,0])
            translate([-(Connections_sockets_columns-1)*2.54/2,0,Breadboard_size_Z])
               linear_extrude(1,center=true)
                  rotate([0,0,90])
                     text(chr(b+97),size=2,valign="center",halign="center");


         }

//Power sockets

   translate([-Breadboard_size_X/2,Power_sockets_distance_Y,0])
      {
      translate([0,1.252,0])
      for(b=[1:1:Power_sockets_groups])
         {
         translate([b*((Breadboard_size_X/(Power_sockets_groups+1))),0,0])
            rotate([0,0,90])
            Sockets();
         }
      translate([0,-1.252,0])
      for(b=[1:1:Power_sockets_groups])
         {
         translate([b*((Breadboard_size_X/(Power_sockets_groups+1))),0,0])
            rotate([0,0,90])
            Sockets();
         }

      translate([2.54*2,1.252,Breadboard_size_Z])
         linear_extrude(1,center=true)
            rotate([0,0,90])
               text("+",size=2,valign="center",halign="center");
      translate([2.54*2,-1.252,Breadboard_size_Z])
         linear_extrude(1,center=true)
            rotate([0,0,90])
               text("-",size=2,valign="center",halign="center");
      translate([Breadboard_size_X-2.54*2,1.252,Breadboard_size_Z])
         linear_extrude(1,center=true)
            rotate([0,0,90])
               text("+",size=2,valign="center",halign="center");
      translate([Breadboard_size_X-2.54*2,-1.252,Breadboard_size_Z])
         linear_extrude(1,center=true)
            rotate([0,0,90])
               text("-",size=2,valign="center",halign="center");
     
      }

translate([-Breadboard_size_X/2,-Power_sockets_distance_Y,0])
      {
      translate([0,1.252,0])
      for(b=[1:1:Power_sockets_groups])
         {
         translate([b*((Breadboard_size_X/(Power_sockets_groups+1))),0,0])
            rotate([0,0,90])
            Sockets();
         }
      translate([0,-1.252,0])
      for(b=[1:1:Power_sockets_groups])
         {
         translate([b*((Breadboard_size_X/(Power_sockets_groups+1))),0,0])
            rotate([0,0,90])
            Sockets();

      translate([2.54*2,2.54,Breadboard_size_Z])
         linear_extrude(1,center=true)
            rotate([0,0,90])
               text("+",size=2,valign="center",halign="center");
      translate([2.54*2,0,Breadboard_size_Z])
         linear_extrude(1,center=true)
            rotate([0,0,90])
               text("-",size=2,valign="center",halign="center");
      translate([Breadboard_size_X-2.54*2,2.54,Breadboard_size_Z])
         linear_extrude(1,center=true)
            rotate([0,0,90])
               text("+",size=2,valign="center",halign="center");
      translate([Breadboard_size_X-2.54*2,0,Breadboard_size_Z])
         linear_extrude(1,center=true)
            rotate([0,0,90])
               text("-",size=2,valign="center",halign="center");
         }
      }
      

   
   translate([0,0,Breadboard_size_Z])
      cube([Breadboard_size_X+10,2,4],center=true);

   if(Hollow==1)
   translate([0,0,1])
      cube([Breadboard_size_X-3,Breadboard_size_Y-3,Breadboard_size_Z],center=true);

   }