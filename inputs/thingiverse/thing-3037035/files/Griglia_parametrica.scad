//Grate type   0=round     1=rectangular
Grate_type=0;
//Grate length
Dimension_x=63;
//Grate width
Dimension_y=60;
//Grate thicknesstranslate([0,50,0])
Dimension_z=2;
//Grate radius if type=0
Radius=50;
//Width of each strand of the grid
Strand_width=1;
//Number of stands (based on Dimension_x measure)
Strand_number_x=15;
//Scale
Scale=1;
//Center hole (0 to disable) - No scaling
Center_hole_diameter=10;

//--------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------


step=(Dimension_x)/Strand_number_x;
$fn=36;


difference()
   {
   scale([Scale,1,1])
   union()
   {
   intersection()
      {  
      union()
         {
         if(Grate_type==0)
            {
            for(a=[0:step:Radius*3])
            translate([-Radius*1.5+a-Strand_width/1.5,0,0])
               cube([Strand_width,Radius*3,Dimension_z],center=true);
            for(a=[0:step:Radius*3])
            translate([0,-Radius*1.5+a-Strand_width/1.5,0])
               cube([Radius*3,Strand_width,Dimension_z],center=true);
            }
         if(Grate_type==1)
            {
            for(a=[0:step:Dimension_x])
            translate([-Dimension_x/2+a,0,0])
               cube([Strand_width,Dimension_y,Dimension_z],center=true);
            for(a=[0:step:Dimension_y])
            translate([0,-Dimension_y/2+a+Strand_width/2,0])
               cube([Dimension_x,Strand_width,Dimension_z],center=true);
            }
         }

      if(Grate_type==0)
         {
         cylinder(r=Radius,h=Dimension_z,center=true);
         }

      if(Grate_type==1)
         {
              cube([Dimension_x,Dimension_y,Dimension_z],center=true);
         }
      }
      if(Grate_type==0)
      difference()
         {
              cylinder(r=Radius,h=Dimension_z,center=true);
               cylinder(r=Radius-Strand_width,h=Dimension_z+2,center=true);
         }

      if(Grate_type==1)
      difference()
         {
              cube([Dimension_x,Dimension_y,Dimension_z],center=true);
               cube([Dimension_x-Strand_width*2,Dimension_y-Strand_width*2,Dimension_z+2],center=true);
         }

   }
   cylinder(r=Center_hole_diameter,h=Dimension_z+2,center=true);

   }
   if(Center_hole_diameter!=0)
   difference()
      {
           cylinder(r=Center_hole_diameter+Strand_width,h=Dimension_z,center=true);
            cylinder(r=Center_hole_diameter,h=Dimension_z+2,center=true);
      }