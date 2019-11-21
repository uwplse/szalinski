
 //Resolution of curves
$fn=36;  

//This is just to adapt the view of Thingiverse customizer, remember to put it to 0,0,0 when doing the final rendering of the object (70,0,30 should get Thingiverse customizer's to show a top view)
Rotation=[0,0,0];

//Edit mode, show start, end and control points for the curves   0=render    1=Show tangent points      2=Show control points       3=Show tangent and control points
Edit_mode=0;

Bezier_curve_resolution=0.01;

/* [Sole parameters] */
//Thickness of the sole
//Left or right version   0=print right side sole    1=print left side sole
LEFT=0;
Sole_thickness=2;
/* [Drain holes insert positioning] */
Holes_size=3;
Holes_shape=6;
Rotation_pattern=0;
//   0=One side only indentation(adjust position with Z_offset_holes_1)   1=Top side and bottom side indentation
Pattern_type=0;
X_offset_holes=1.75;
Y_offset_holes=4.5;
Z_offset_holes_1=1.5;
Z_offset_holes_2=-2.5;
X_scale=0.85;
Y_scale=0.96;

/* [Contour fixed point] */
P01=[0,0]; 
P02=[25,75];    
P03=[23,150];    
P04=[54,205];   
P05=[0,252];   
P06=[-47,205];  
P07=[-43,150];  
P08=[-33,75];

/* [Control points] */
CT01=[55,19];
CT02=[-8,120];
CT03=[53,170];
CT04=[62,272];
CT05=[-38,242];
CT06=[-54,185];
CT07=[-28,105];
CT08=[-40,-5];

/* [Laces] */
Laces=1;
X_position_lace_1=20;
Y_position_lace_1=215;
Rotation_lace_1=0;
X_position_lace_2=32.5;
Y_position_lace_2=53;
Rotation_lace_2=20;
X_position_lace_3=-32.5;
Y_position_lace_3=53;
Rotation_lace_3=-3;


//----------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------Functions-------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------

function curva_bezier_3(P01,CT01,P02,CT02)=
    [for(a=[0:Bezier_curve_resolution:1+Bezier_curve_resolution])
        P01*pow(1-a,3)+3*CT01*a*pow(1-a,2)+3*P02*pow(a,2)*(1-a)+CT02*pow(a,3)];

function curva_bezier_2(P01,CT01,P02)=
    [for(a=[0:Bezier_curve_resolution:1+Bezier_curve_resolution])
         pow(1-a,2)*P01+2*a*(1-a)*CT01+pow(a,2)*P02];

module line(P01,CT01,width)
    {        
         hull()
            {
            translate(P01)
                square(width);
            translate(CT01)
                square(width);
            }
    }

module line1(P01,CT01,width)
    {        
        color("Black")
         hull()
            {
            translate(P01)
                square(width);
            translate(CT01)
                square(width);
            }
    }

module points(P01,CT01,P02,CT02)
    {       
            color("black")
            {
            translate(P01)
                circle(r=3);
            translate(CT01)
                circle(r=2);
            translate(P02)
                circle(r=3);
            }
    }
    
module points_1(P1,P2,P3)
   {        
      color("red")
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
                        cylinder(r=5,h=Sole_thickness);
                        translate([0,10,0])
                            cylinder(r=5,h=Sole_thickness);
                        }
                    translate([0,5,5])
                        rotate([0,90,0])
                        scale([1,0.5,0.75])
                        rotate_extrude()
                            translate([10,0,0])
                                circle(3);
                    translate([0,0,0])
                        cylinder(r1=4,r2=1,h=Sole_thickness+3);
                    translate([0,10,0])
                        cylinder(r1=4,r2=1,h=Sole_thickness+3);
                    }
                translate([-25,-25,-50])
                cube([50,50,50]);
                }

}
module track(points,index,width)
{
    if(index<len(points))
        {
        line(points[index-1],points[index],width);
        track(points,index+1,width);
        }
}

module Soletta(width)
{
union()
   {
   hull()
      {
      color("green")track(curva_bezier_2(P01,CT01,P02),1,0.1);
      color("grey")track(curva_bezier_2(P08,CT08,P01),1,0.1);
      }
   difference()
      {
      hull()
         {
         color("blue")track(curva_bezier_2(P02,CT02,P03),1,0.1);
         color("yellow")track(curva_bezier_2(P07,CT07,P08),1,0.1);
         }
      
      union()
         {
         
         hull()
            {
            translate([0,0,0])
            color("blue")track(curva_bezier_2(P02,CT02,P03),1,0.1);
            }
         
         hull()
            {
            translate([0,0,0])
            color("yellow")track(curva_bezier_2(P07,CT07,P08),1,0.1);
            }
         }
      }
   hull()
      {
      color("red")track(curva_bezier_2(P03,CT03,P04),1,0.1);
      color("pink")track(curva_bezier_2(P04,CT04,P05),1,0.1);
      color("purple")track(curva_bezier_2(P05,CT05,P06),1,0.1);
      color("orange")track(curva_bezier_2(P06,CT06,P07),1,0.1);
      }
   }
}

module Soletta_b(width)
{
union()
   {
   color("green")track(curva_bezier_2(P01,CT01,P02),1,width);
   color("blue")track(curva_bezier_2(P02,CT02,P03),1,width);
   color("red")track(curva_bezier_2(P03,CT03,P04),1,width);
   color("pink")track(curva_bezier_2(P04,CT04,P05),1,width);
   color("purple")track(curva_bezier_2(P05,CT05,P06),1,width);
   color("orange")track(curva_bezier_2(P06,CT06,P07),1,width);
   color("yellow")track(curva_bezier_2(P07,CT07,P08),1,width);
   color("grey")track(curva_bezier_2(P08,CT08,P01),1,width);
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
   
            linear_extrude(Sole_thickness) Soletta(0.1);

          

   translate([0,0,Z_offset_holes_1])
            union()
                {
                intersection()
                    {
                    translate([-X_offset_holes,Y_offset_holes,0])
                    scale([X_scale,Y_scale,4])
                    linear_extrude(Sole_thickness) Soletta();

                    for(b=[0:8:400])
                        for(a=[0:8:200])
                            {
                            translate([-100+a,b,-1])
                             cylinder(r=Holes_size, $fn=Holes_shape,h=Sole_thickness*2);
                            }
                    }
                }

            translate([0,0,Z_offset_holes_2])
            union()
                {
                intersection()
                    {
                    translate([-X_offset_holes,Y_offset_holes,0])
                    scale([X_scale,Y_scale,4])
                    linear_extrude(Sole_thickness) Soletta();

                    for(b=[0:8:400])
                        for(a=[0:8:200])
                            {
                            translate([-100+a,b,-1])
                             cylinder(r=Holes_size, $fn=Holes_shape,h=Sole_thickness*2);
                            }
                    }
                }



            }

        if(Laces==1)
            {
            translate([X_position_lace_1,Y_position_lace_1,0])
            rotate([0,0,Rotation_lace_1])
            lace();

        translate([X_position_lace_2,Y_position_lace_2,0])
            rotate([0,0,Rotation_lace_2])
            lace();

        translate([X_position_lace_3,Y_position_lace_3,0])
            rotate([0,0,Rotation_lace_3])
            lace();
            }
        }  

if(Edit_mode==0 && LEFT==0)
mirror()
    union()
        {
        difference()
            {
   
            linear_extrude(Sole_thickness) Soletta(0.1);

            translate([0,0,Z_offset_holes_1])
            union()
                {
                intersection()
                    {
                    translate([-X_offset_holes,Y_offset_holes,0])
                    scale([X_scale,Y_scale,4])
                    linear_extrude(Sole_thickness) Soletta();

                    for(b=[0:8:400])
                        for(a=[0:8:200])
                            {
                            translate([-100+a,b,-1])
                             cylinder(r=Holes_size, $fn=Holes_shape,h=Sole_thickness*2);
                            }
                    }
                }

            translate([0,0,Z_offset_holes_2])
            union()
                {
                intersection()
                    {
                    translate([-X_offset_holes,Y_offset_holes,0])
                    scale([X_scale,Y_scale,4])
                    linear_extrude(Sole_thickness) Soletta();

                    for(b=[0:8:400])
                        for(a=[0:8:200])
                            {
                            translate([-100+a,b,-1])
                             cylinder(r=Holes_size, $fn=Holes_shape,h=Sole_thickness*2);
                            }
                    }
                }

            }

        if(Laces==1)
            {
            translate([X_position_lace_1,Y_position_lace_1,0])
            rotate([0,0,Rotation_lace_1])
            lace();

        translate([X_position_lace_2,Y_position_lace_2,0])
            rotate([0,0,Rotation_lace_2])
            lace();

        translate([X_position_lace_3,Y_position_lace_3,0])
            rotate([0,0,Rotation_lace_3])
            lace();
            }
        }    


if(Edit_mode==1 || Edit_mode==2 || Edit_mode==3)
{
   Soletta_b(2);
  
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
        

      points(P01,CT01,P02);
      points(P02,CT02,P03);
      points(P03,CT03,P04);
      points(P04,CT04,P05);
      points(P05,CT05,P06);
      points(P06,CT06,P07);
      points(P07,CT07,P08);
      points(P08,CT08,P01);
      
      points_1(concat(X_position_lace_1,Y_position_lace_1),concat(X_position_lace_2,Y_position_lace_2),concat(X_position_lace_3,Y_position_lace_3));

if(Edit_mode==1 || Edit_mode==3)
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

if(Edit_mode==2 || Edit_mode==3)
    color("Black")
{
        translate (CT01)
         linear_extrude(1)
          text(str("CT01 ",CT01),size=6);
        translate (CT02)
         linear_extrude(1)
          text(str("CT02 ",CT02),size=6);
        translate (CT03)
         linear_extrude(1)
          text(str("CT03 ",CT03),size=6);
        translate (CT04)
         linear_extrude(1)
          text(str("CT04 ",CT04),size=6);
        translate (CT05)
         linear_extrude(1)
          text(str("CT05 ",CT05),size=6);
        translate (CT06)
         linear_extrude(1)
          text(str("CT06 ",CT06),size=6);
        translate (CT07)
         linear_extrude(1)
          text(str("CT07 ",CT07),size=6);
        translate (CT08)
         linear_extrude(1)
          text(str("CT08 ",CT08),size=6);
}
 

      }}

*color("black")
   {
   translate([0,0,0])
   cylinder(r=1.5,h=1);
   translate([23,14,0])
   cylinder(r=1.5,h=1);
   translate([36,40,0])
   cylinder(r=1.5,h=1);
   translate([30,67,0])
   cylinder(r=1.5,h=1);
   translate([22,82,0])
   cylinder(r=1.5,h=1);
   translate([13,98,0])
   cylinder(r=1.5,h=1);
   translate([10,115,0])
   cylinder(r=1.5,h=1);
   translate([14,139,0])
   cylinder(r=1.5,h=1);
   translate([30,155,0])
   cylinder(r=1.5,h=1);
   translate([40,166,0])
   cylinder(r=1.5,h=1);
   translate([50,183,0])
   cylinder(r=1.5,h=1);
   translate([54,210,0])
   cylinder(r=1.5,h=1);
   translate([52,240,0])
   cylinder(r=1.5,h=1);
   translate([46,252,0])
   cylinder(r=1.5,h=1);
   translate([30,257,0])
   cylinder(r=1.5,h=1);
   translate([4,253,0])
   cylinder(r=1.5,h=1);
   translate([-20,243,0])
   cylinder(r=1.5,h=1);
   translate([-36,229,0])
   cylinder(r=1.5,h=1);
   translate([-46,206,0])
   cylinder(r=1.5,h=1);
   translate([-49,176,0])
   cylinder(r=1.5,h=1);
   translate([-42,146,0])
   cylinder(r=1.5,h=1);
   translate([-36,123,0])
   cylinder(r=1.5,h=1);
   translate([-30,95,0])
   cylinder(r=1.5,h=1);
   translate([-32,73,0])
   cylinder(r=1.5,h=1);
   translate([-32,48,0])
   cylinder(r=1.5,h=1);
   translate([-28,24,0])
   cylinder(r=1.5,h=1);
   translate([-18,10,0])
   cylinder(r=1.5,h=1);
   }

}

