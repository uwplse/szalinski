
 //Resolution of curves
$fn=36;  

//This is just to adapt the view of Thingiverse customizer, remember to put it to 0,0,0 when doing the final rendering of the object (70,0,30 should get Thingiverse customizer's to show a top view)
Rotation=[0,0,0];
//Edit mode, show start, end and control points for the curves   0=render    1=Edit mode
Edit_mode=0;
//Show laces fixing points in edit mode
Show_laces=0;
//Show defined contour points position
Show_points=1;
//Show defined control points position
Show_control_lines=1;
//Show coordinates of selected points
Show_coordinates=1;

Bezier_curve_resolution=0.05;

/* [Sole parameters] */
//Thickness of the sole
Sole_thickness=6;
//Left or right version   0=print right side sole    1=print left side sole
LEFT=1;
//Width of solid border around the perimeter
Solid_border_width=6;

/* [Sole pattern parameters] */

Pattern_size_top=7;
Pattern_spacing_top=14;
Pattern_shape_top=6;
Pattern_rotation_top=0;
Pattern_indentation_top=0.5;

Pattern_size_bottom=9;
Pattern_spacing_bottom=14;
Pattern_shape_bottom=3;
Pattern_rotation_bottom=-30;
Pattern_indentation_bottom=0.5;

/* [Contour fixed point] */
P01=[0,0]; 
P02=[25,75];    
P03=[25,150];    
P04=[56,205];   
P05=[0,252];   
P06=[-50,205];  
P07=[-43,150];  
P08=[-33,75];

P1=[0,0,0]; 
P2=[25,75,0];    
P3=[25,150,0];    
P4=[56,205,0];   
P5=[0,252,0];   
P6=[-50,205,0];  
P7=[-43,150,0];  
P8=[-33,75,0];

/* [Control points] */
CT01=[57,8];
CT02=[-3,129];
CT03=[52,170];
CT04=[62,272];
CT05=[-38,242];
CT06=[-57,185];
CT07=[-26,105];
CT08=[-46,-7];

/* [Laces] */
//Enable laces fixing points
Laces=1;
Laces_hole_radius=1;
Extra_height_laces_area=3;
Lace_1=1;
Rotation_lace_1=26;
Lace_2=0;
Rotation_lace_2=-50;
Lace_3=1;
Rotation_lace_3=-6;
Lace_4=1;
Rotation_lace_4=-17;
Lace_5=0;
Rotation_lace_5=21;
Lace_6=1;
Rotation_lace_6=-10;


k1=[Solid_border_width,Solid_border_width];
k2=[Solid_border_width,0];
k3=[0,Solid_border_width];
k4=[Solid_border_width,-Solid_border_width];
k5=[-Solid_border_width,Solid_border_width];

//----------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------Functions-------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------

function curva_bezier_3(P01,CT01,P02,CT02)=
    [for(a=[0:Bezier_curve_resolution:1+Bezier_curve_resolution])
        P01*pow(1-a,3)+3*CT01*a*pow(1-a,2)+3*P02*pow(a,2)*(1-a)+CT02*pow(a,3)];

function curva_bezier_2(P01,CT01,P02)=
    [for(a=[0-Bezier_curve_resolution:Bezier_curve_resolution:1+Bezier_curve_resolution])
         pow(1-a,2)*P01+2*a*(1-a)*CT01+pow(a,2)*P02];

function curva_bezier_2_custom(P01,CT01,P02,a)=
         pow(1-a,2)*P01+2*a*(1-a)*CT01+pow(a,2)*P02;


module line(L1,L2,width,P0)
    {        
         hull()
            {
            translate(L1)
                circle(width);
            translate(L2)
                circle(width);
            translate(P0)
                circle(width);
            }
    }

module line1(L1,L2,width,P0)
    {        
         hull()
            {
            translate(L1)
                circle(width,center=true);
            translate(L2)
                circle(width,center=true);
            }
    }

module line2(L1,L2,width,P0)
    {        
         hull()
            {
            translate(L1)
                sphere(width,center=true);
            translate(L2)
                sphere(width,center=true);
            }
    }



module points(P01,CT01,P02,CT02)
    {       
            
            {  
            color("black")
            translate(P01)
                circle(r=3,center=true);
            color("Violet")
            translate(CT01)
                circle(r=2,center=true);
            color("black")
            translate(P02)
                circle(r=3,center=true);
            }
    }
    
module points_1(P1,P2,P3)
   {        
      {
      translate(P1)
      translate([0,0,0])
         rotate([0,0,Rotation_lace_1])
            scale([1,3,1])
               cylinder(r=3,h=1);
      translate(P1)
         linear_extrude(1)
            text(str("  ",P1),size=6);
      translate(P2)
         rotate([0,0,Rotation_lace_2])
            scale([1,3,1])
               cylinder(r=3,h=1);
      translate(P2)
         linear_extrude(1)
            text(str("  ",P2),size=6);
      translate(P3)
         rotate([0,0,Rotation_lace_3])
            scale([1,3,1])
               cylinder(r=3,h=1);
      translate(P3)
         linear_extrude(1)
            text(str("  ",P3),size=6);
      }
   }


module lace()
   {
   difference()
       {
       union()
           {
           hull()
               {
               translate([0,5,0])
               cylinder(r=Laces_hole_radius+2,h=Sole_thickness+Extra_height_laces_area);
               translate([0,-5,0])
                   cylinder(r=Laces_hole_radius+2,h=Sole_thickness+Extra_height_laces_area);
               }
           }
         union()
         {
         translate([0,5,-1])
            cylinder(r=Laces_hole_radius,h=Sole_thickness+6);
         translate([0,-5,-1])
            cylinder(r=Laces_hole_radius,h=Sole_thickness+6);
         }
       *translate([-25,-25,-50])
       cube([50,50,50]);
       }
   }


module lace_holes()
   {
         union()
         {
         translate([0,5,-1])
         cylinder(r=1,h=Sole_thickness+Extra_height_laces_area+2);
         translate([0,-5,-1])
            cylinder(r=1,h=Sole_thickness+Extra_height_laces_area+2);
         }
   }


module track(points,index,width,P0)
{
    if(index<len(points))
        {
        line(points[index-1],points[index],width,P0);
        track(points,index+1,width,P0);
        }
}

module track_1(points,index,width)
{
    if(index<len(points))
        {
        line1(points[index-1],points[index],width);
        track_1(points,index+1,width);
        }
}

module track_2(points,index,width)
{
    if(index<len(points))
        {
        line2(points[index-1],points[index],width);
        track_2(points,index+1,width);
        }
}


module Soletta(width)
{
union()
   {
      width=1;
      color("green")track(curva_bezier_2(P01,CT01,P02),1,width,P08);
      color("blue")track(curva_bezier_2(P02,CT02,P03),1,width,P07);
      color("red")track(curva_bezier_2(P03,CT03,P04),1,width,P06);
      color("pink")track(curva_bezier_2(P04,CT04,P05),1,width,P05);
      color("purple")track(curva_bezier_2(P05,CT05,P06),1,width,P04);
      color("orange")track(curva_bezier_2(P06,CT06,P07),1,width,P03);
      color("yellow")track(curva_bezier_2(P07,CT07,P08),1,width,P02);
      color("grey")track(curva_bezier_2(P08,CT08,P01),1,width,P01);
      
   }
}

module Soletta_interna(width)
{
union()
   {
      width=0.25;
      color("black")track(curva_bezier_2(P01+k3,CT01-k4,P02-k2),1,width,P08+k2);
      color("black")track(curva_bezier_2(P02-k2,CT02-k2,P03-k2),1,width,P07+k2);
      color("black")track(curva_bezier_2(P03-k2,CT03-k2,P04-k2),1,width,P06+k2);
      color("black")track(curva_bezier_2(P04-k2,CT04-k1,P05-k3),1,width,P05-k3);
      color("black")track(curva_bezier_2(P05-k3,CT05+k4,P06+k2),1,width,P04-k2);
      color("black")track(curva_bezier_2(P06+k2,CT06+k2,P07+k2),1,width,P03-k2);
      color("black")track(curva_bezier_2(P07+k2,CT07+k2,P08+k2),1,width,P02-k2);
      color("black")track(curva_bezier_2(P08+k2,CT08+k1,P01+k3),1,width,P01+k3);
      
   }
}

module Soletta_interna_b(width)
{
union()
   {
      width=0.25;
      color("black")track_1(curva_bezier_2(P01+k3,CT01-k4,P02-k2),1,width,P08);
      color("black")track_1(curva_bezier_2(P02-k2,CT02-k2,P03-k2),1,width,P07);
      color("black")track_1(curva_bezier_2(P03-k2,CT03-k2,P04-k2),1,width,P06);
      color("black")track_1(curva_bezier_2(P04-k2,CT04-k1,P05-k3),1,width,P05);
      color("black")track_1(curva_bezier_2(P05-k3,CT05+k4,P06+k2),1,width,P04);
      color("black")track_1(curva_bezier_2(P06+k2,CT06+k2,P07+k2),1,width,P03);
      color("black")track_1(curva_bezier_2(P07+k2,CT07+k2,P08+k2),1,width,P02);
      color("black")track_1(curva_bezier_2(P08+k2,CT08+k1,P01+k3),1,width,P01);
      
   }
}

module Soletta_b(width)
{
union()
   {
   width=0.25;
   color("green")track_1(curva_bezier_2(P01,CT01,P02),1,width);
   color("green")track_1(curva_bezier_2(P02,CT02,P03),1,width);
   color("green")track_1(curva_bezier_2(P03,CT03,P04),1,width);
   color("green")track_1(curva_bezier_2(P04,CT04,P05),1,width);
   color("green")track_1(curva_bezier_2(P05,CT05,P06),1,width);
   color("green")track_1(curva_bezier_2(P06,CT06,P07),1,width);
   color("green")track_1(curva_bezier_2(P07,CT07,P08),1,width);
   color("green")track_1(curva_bezier_2(P08,CT08,P01),1,width);
   }
}

module Strings(width)
{
union()
   {

   CT01Sa=[40,110,72];
   CT01Sb=[-60,215,32];

   CT02Sa=[-50,110,78];
   CT02Sb=[60,220,25];

   CT03Sa=[-60,210,30];
   CT03Sb=[70,210,40];

   CT04Sa=[60,0,60];
   CT04Sb=[-60,0,60];
   
   width=1.75/2;
   
   *color("red")
   translate(CT04Sa)
   sphere(r=3);
   *color("violet")
   translate(CT04Sb)
   sphere(r=3);

   color("red")track_2(curva_bezier_3(P2+[-5,0,0],CT01Sa,CT01Sb,P6+[0,-7,0]),1,width);
   color("red")track_2(curva_bezier_3(P8+[2,0,0],CT02Sa,CT02Sb,P4+[1,-8,0]),1,width);
   color("red")track_2(curva_bezier_3(P6+[0,5,0],CT03Sa,CT03Sb,P4+[0,5,0]),1,width);
   color("red")track_2(curva_bezier_3(P2+[0,0,5],CT04Sa,CT04Sb,P8+[0,0,5]),1,width);

   }
}


//----------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------Code------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------
rotate(Rotation)
{
if(Edit_mode==0 && LEFT==1)
union()
   {
   difference()
      {
      union()
         {
         linear_extrude(Sole_thickness) Soletta(0.1);

         if(Lace_1==1)
            translate(P02)
             rotate([0,0,Rotation_lace_1])
              lace();
         if(Lace_2==1)
            translate(P03)
             rotate([0,0,Rotation_lace_2])
              lace();
         if(Lace_3==1)
            translate(P04)
             rotate([0,0,Rotation_lace_3])
              lace();
         if(Lace_4==1)
            translate(P06)
             rotate([0,0,Rotation_lace_4])
              lace();
         if(Lace_5==1)
            translate(P07)
             rotate([0,0,Rotation_lace_5])
              lace();
         if(Lace_6==1)
            translate(P08)
             rotate([0,0,Rotation_lace_6])
              lace();
         }

      translate([0,0,Sole_thickness-Pattern_indentation_top])
         intersection()
            {
            linear_extrude(Sole_thickness*2) Soletta_interna();

            for(b=[0:Pattern_spacing_top:300])
               for(a=[0:Pattern_spacing_top:150])
                  {
                  translate([-70+a,b,-1])
                   rotate([0,0,Pattern_rotation_top])
                    cylinder(r=Pattern_size_top, $fn=Pattern_shape_top,h=Sole_thickness*2);
                  }
            }
         
      translate([0,0,-Sole_thickness*2+Pattern_indentation_bottom+1])
         intersection()
            {
            linear_extrude(Sole_thickness*2) Soletta_interna();

            for(b=[0:Pattern_spacing_bottom:400])
               for(a=[0:Pattern_spacing_bottom:200])
                  {
                  translate([-100+a,b,-1])
                  rotate([0,0,Pattern_rotation_bottom])
                  cylinder(r=Pattern_size_bottom, $fn=Pattern_shape_bottom,h=Sole_thickness*2);
                  }
            }


         if(Lace_1==1)
         translate(P02)
         rotate([0,0,Rotation_lace_1])
         lace_holes();
         if(Lace_2==1)
         translate(P03)
         rotate([0,0,Rotation_lace_2])
         lace_holes();
         if(Lace_3==1)
         translate(P04)
         rotate([0,0,Rotation_lace_3])
         lace_holes();
         if(Lace_4==1)
         translate(P06)
         rotate([0,0,Rotation_lace_4])
         lace_holes();
         if(Lace_5==1)
         translate(P07)
         rotate([0,0,Rotation_lace_5])
         lace_holes();
         if(Lace_6==1)
         translate(P08)
         rotate([0,0,Rotation_lace_6])
         lace_holes();


      }
   }  

if(Edit_mode==0 && LEFT==0)
mirror()
    union()
        {
        difference()
            {
            union()
               {
               linear_extrude(Sole_thickness) Soletta(0.1);
         if(Lace_1==1)
                  translate(P02)
                     rotate([0,0,Rotation_lace_1])
                        lace();
         if(Lace_2==1)
                  translate(P03)
                     rotate([0,0,Rotation_lace_2])
                        lace();
         if(Lace_3==1)
                  translate(P04)
                     rotate([0,0,Rotation_lace_3])
                        lace();
         if(Lace_4==1)
                  translate(P06)
                     rotate([0,0,Rotation_lace_4])
                        lace();
         if(Lace_5==1)
                  translate(P07)
                     rotate([0,0,Rotation_lace_5])
                        lace();
         if(Lace_6==1)
                  translate(P08)
                     rotate([0,0,Rotation_lace_6])
                        lace();

               }

            translate([0,0,Sole_thickness-Pattern_indentation_top])
               union()
                  {
                  intersection()
                    {
                     linear_extrude(Sole_thickness*2) Soletta_interna();

                    for(b=[0:Pattern_spacing_top:400])
                        for(a=[0:Pattern_spacing_top:200])
                            {
                            translate([-100+a,b,-1])
                              rotate([0,0,Pattern_rotation_top])
                             cylinder(r=Pattern_size_top, $fn=Pattern_shape_top,h=Sole_thickness*2);
                            }
                     }
                  }

            translate([0,0,-Sole_thickness*2+Pattern_indentation_bottom+1])
            union()
                {
                intersection()
                    {
                     linear_extrude(Sole_thickness*2) Soletta_interna();

                    for(b=[0:Pattern_spacing_bottom:400])
                        for(a=[0:Pattern_spacing_bottom:200])
                            {
                            translate([-100+a,b,-1])
                              rotate([0,0,Pattern_rotation_bottom])
                             cylinder(r=Pattern_size_bottom, $fn=Pattern_shape_bottom,h=Sole_thickness*2);
                            }
                    }
                }

         if(Lace_1==1)
            translate(P02)
            rotate([0,0,Rotation_lace_1])
            lace_holes();
         if(Lace_2==1)
        translate(P03)
            rotate([0,0,Rotation_lace_2])
            lace_holes();
         if(Lace_3==1)
        translate(P04)
            rotate([0,0,Rotation_lace_3])
            lace_holes();
         if(Lace_4==1)
        translate(P06)
            rotate([0,0,Rotation_lace_4])
            lace_holes();
         if(Lace_5==1)
        translate(P07)
            rotate([0,0,Rotation_lace_5])
            lace_holes();
         if(Lace_6==1)
        translate(P08)
            rotate([0,0,Rotation_lace_6])
            lace_holes();
            }
        }    


if(Edit_mode==1)
{
   Soletta_b(2);
Soletta_interna_b(5);
  
      {
     if(Show_control_lines==1)
         {
      line1(P01,CT01,0.5);
      line1(CT01,P02,0.5);
      line1(P02,CT02,0.5);
      line1(CT02,P03,0.5);
      line1(P03,CT03,0.5);
      line1(CT03,P04,0.5);
      line1(P04,CT04,0.5);
      line1(CT04,P05,0.5);
      line1(P05,CT05,0.5);
      line1(CT05,P06,0.5);
      line1(P06,CT06,0.5);
      line1(CT06,P07,0.5);
      line1(P07,CT07,0.5);
      line1(CT07,P08,0.5);
      line1(P08,CT08,0.5);
      line1(CT08,P01,0.5);

//Levels
        line1(P02,P08,0.5);
        line1(P03,P07,0.5);
        line1(P04,P06,0.5);
        }

if(Show_points==1)
   {
      points(P01,CT01,P02);
      points(P02,CT02,P03);
      points(P03,CT03,P04);
      points(P04,CT04,P05);
      points(P05,CT05,P06);
      points(P06,CT06,P07);
      points(P07,CT07,P08);
      points(P08,CT08,P01);
    }  
              if(Show_laces==1)
            {
         if(Lace_1==1)
            translate(P02)
            rotate([0,0,Rotation_lace_1])
            lace();
         if(Lace_2==1)
        translate(P03)
            rotate([0,0,Rotation_lace_2])
            lace();
         if(Lace_3==1)
        translate(P04)
            rotate([0,0,Rotation_lace_3])
            lace();
         if(Lace_4==1)
        translate(P06)
            rotate([0,0,Rotation_lace_4])
            lace();
         if(Lace_5==1)
        translate(P07)
            rotate([0,0,Rotation_lace_5])
            lace();
         if(Lace_6==1)
        translate(P08)
            rotate([0,0,Rotation_lace_6])
            lace(); 
            }


if(Show_points==1 && Show_coordinates==1)
    color("Black")
{
        
       translate (P01)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("P01 ",P01),size=6,halign="center",valign="top");
        translate (P02)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("P02 ",P02),size=6,halign="center",valign="top");
        translate (P03)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("P03 ",P03),size=6,halign="center",valign="top");
        translate (P04)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("P04 ",P04),size=6,halign="center",valign="top");
        translate (P05)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("P05 ",P05),size=6,halign="center",valign="top");
        translate (P06)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("P06 ",P06),size=6,halign="center",valign="top");
        translate (P07)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("P07 ",P07),size=6,halign="center",valign="top");
        translate (P08)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("P08 ",P08),size=6,halign="center",valign="top");
         }
  color("Violet")
{
         translate (CT01)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("CT01 ",CT01),size=6,halign="center",valign="top");
        translate (CT02)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("CT02 ",CT02),size=6,halign="center",valign="top");
        translate (CT03)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("CT03 ",CT03),size=6,halign="center",valign="top");
        translate (CT04)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("CT04 ",CT04),size=6,halign="center",valign="top");
        translate (CT05)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("CT05 ",CT05),size=6,halign="center",valign="top");
        translate (CT06)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("CT06 ",CT06),size=6,halign="center",valign="top");
        translate (CT07)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("CT07 ",CT07),size=6,halign="center",valign="top");
        translate (CT08)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("CT08 ",CT08),size=6,halign="center",valign="top");
         }
      }
}
}

*Strings(3);