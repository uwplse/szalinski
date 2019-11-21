
//Resolution of curves
$fn=36;
SCALE_X=1;
SCALE_Y=1;
//Left or right version   0=print right side sole    1=print left side sole
LEFT=0;
//The solid part on the bottom
Flat_sole_thickness=2;
//Height of the sole including knobs (you can cut off part of the knob)
Complete_sole_thickness=10;
//Size of the single knob
Knobs_radius=5;
Knobs_vertical_offset=0;
//Segments     3=triangles  4=square  5=pentagon    36 and up for sphere
Knobs_shape=36;  

 //Start point of bezier curve section 1 - end point of section 8
punto1=[0,0]; 
punto2=[34,3];
punto3=[51,50];
//Start point for bezier curve section 2 - end point of section 1
punto4=[26,78];    
punto5=[8,98];
punto6=[1,130];
//Start point for bezier curve section 3 - end point of section 2
punto7=[23,150];    
punto8=[55,173];
punto9=[52,190];
//Start point for bezier curve section 4 - end point of section 3
punto10=[54,205];   
punto11=[55,220];
punto12=[54,255];
//Start point for bezier curve section 5 - end point of section 4
punto13=[40,257];   
punto14=[30,260];
punto15=[-10,255];
//Start point for bezier curve section 6 - end point of section 5
punto16=[-30,236];  
punto17=[-38,226];
punto18=[-65,195];
//Start point for bezier curve section 7 - end point of section 6
punto19=[-41,141];  
punto20=[-37,124];
punto21=[-27,95];
//Start point for bezier curve section 8 - end point of section 7
punto22=[-34,74];
punto23=[-42,36];
punto24=[-23,0];

Bezier_curve_resolution=0.01;
Show_points=0;


//----------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------Functions-------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------

function curva_bezier_3(punto1,punto2,punto3,punto4)=
    [for(a=[0:Bezier_curve_resolution:1+Bezier_curve_resolution])
        punto1*pow(1-a,3)+3*punto2*a*pow(1-a,2)+3*punto3*pow(a,2)*(1-a)+punto4*pow(a,3)];

module line(punto1,punto2,width)
    {        
         hull()
            {
            translate(punto1)
                square(width);
            translate(punto2)
                square(width);
            }
    }

module line1(punto1,punto2,width)
    {        
         hull()
            {
            translate(punto1)
                square(width);
            translate(punto2)
                square(width);
            }
    }

module points(punto1,punto2,punto3,punto4)
    {        
            {
            translate(punto1)
                circle(r=3);
            translate(punto2)
                circle(r=2);
            translate(punto3)
                circle(r=2);
            translate(punto4)
                circle(r=3);
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
scale([SCALE_X,SCALE_Y,1])
union()
   {
   hull()
      {
      color("green")track(curva_bezier_3(punto1,punto2,punto3,punto4),1,0.1);
      color("grey")track(curva_bezier_3(punto22,punto23,punto24,punto1),1,0.1);
      }
   difference()
      {
      hull()
         {
         color("blue")track(curva_bezier_3(punto4,punto5,punto6,punto7),1,0.1);
         color("yellow")track(curva_bezier_3(punto19,punto20,punto21,punto22),1,0.1);
         }
      
      union()
         {
         
         hull()
            {
            translate([0,0,0])
            color("blue")track(curva_bezier_3(punto4,punto5,punto6,punto7),1,0.1);
            }
         
         hull()
            {
            translate([0,0,0])
            color("yellow")track(curva_bezier_3(punto19,punto20,punto21,punto22),1,0.1);
            }
         }
      }
   hull()
      {
      color("red")track(curva_bezier_3(punto7,punto8,punto9,punto10),1,0.1);
      color("pink")track(curva_bezier_3(punto10,punto11,punto12,punto13),1,0.1);
      color("purple")track(curva_bezier_3(punto13,punto14,punto15,punto16),1,0.1);
      color("orange")track(curva_bezier_3(punto16,punto17,punto18,punto19),1,0.1);
      }
   }
}

module Soletta_b(width)
{
scale([SCALE_X,SCALE_Y,1])
union()
   {
   color("green")track(curva_bezier_3(punto1,punto2,punto3,punto4),1,width);
   color("blue")track(curva_bezier_3(punto4,punto5,punto6,punto7),1,width);
   color("red")track(curva_bezier_3(punto7,punto8,punto9,punto10),1,width);
   color("pink")track(curva_bezier_3(punto10,punto11,punto12,punto13),1,width);
   color("purple")track(curva_bezier_3(punto13,punto14,punto15,punto16),1,width);
   color("orange")track(curva_bezier_3(punto16,punto17,punto18,punto19),1,width);
   color("yellow")track(curva_bezier_3(punto19,punto20,punto21,punto22),1,width);
   color("grey")track(curva_bezier_3(punto22,punto23,punto24,punto1),1,width);
   }
}




//----------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------Code------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------

if(Show_points==0 && LEFT==0)
   {
   linear_extrude(Flat_sole_thickness) Soletta();

   intersection()
      {
      linear_extrude(Complete_sole_thickness) Soletta();
      translate([0,0,Knobs_vertical_offset])
      union()
      {
      for(a=[-100:Knobs_radius*2:100])
      for(b=[0:Knobs_radius*2:400])
      translate([a,b,0])
      sphere(Knobs_radius,$fn=Knobs_shape);
      }
      }
   }

if(Show_points==0 && LEFT==1)
mirror()
   {
   
   linear_extrude(Flat_sole_thickness) Soletta(0.1);

   intersection()
      {
      linear_extrude(Complete_sole_thickness) Soletta(0.1);
      translate([0,0,Knobs_vertical_offset])
      union()
      {
      for(a=[-100:Knobs_radius*2:100])
      for(b=[0:Knobs_radius*2:400])
      translate([a,b,0])
      sphere(Knobs_radius,$fn=Knobs_shape);
      }
      }
   }


if(Show_points==1)
{
   Soletta_b(2);
  color("Black")
      {
      line1(punto1,punto2,0.5);
      line1(punto2,punto3,0.5);
      line1(punto3,punto4,0.5);
      line1(punto4,punto5,0.5);
      line1(punto5,punto6,0.5);
      line1(punto6,punto7,0.5);
      line1(punto7,punto8,0.5);
      line1(punto8,punto9,0.5);
      line1(punto9,punto10,0.5);
      line1(punto10,punto11,0.5);
      line1(punto11,punto12,0.5);
      line1(punto12,punto13,0.5);
      line1(punto13,punto14,0.5);
      line1(punto14,punto15,0.5);
      line1(punto15,punto16,0.5);
      line1(punto16,punto17,0.5);
      line1(punto17,punto18,0.5);
      line1(punto18,punto19,0.5);
      line1(punto19,punto20,0.5);
      line1(punto20,punto21,0.5);
      line1(punto21,punto22,0.5);
      line1(punto22,punto23,0.5);
      line1(punto23,punto24,0.5);
      line1(punto24,punto1,0.5);

      points(punto1,punto2,punto3,punto4);
      points(punto4,punto5,punto6,punto7);
      points(punto7,punto8,punto9,punto10);
      points(punto10,punto11,punto12,punto13);
      points(punto13,punto14,punto15,punto16);
      points(punto16,punto17,punto18,punto19);
      points(punto19,punto20,punto21,punto22);
      points(punto22,punto23,punto24,punto1);
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