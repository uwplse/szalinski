 //Resolution of curves
$fn=36;  

//This is just to adapt the view of Thingiverse customizer, remember to put it to 0,0,0 when doing the final rendering of the object (70,0,30 should get Thingiverse customizer's to show a top view)
Rotation=[0,0,0];

//Edit mode, show start, end and control points for the curves   0=render    1=Show hand profile points      2=Show pad profile points       3=Show all
Edit_mode=0;

Bezier_curve_resolution=0.005;

/* [Paddle parameters] */
//Thickness of the Paddle
Paddle_thickness=2;
//Thickness of webbing
Webbing_thickness=1;

//Left or right version   0=print right side Paddle    1=print left side Paddle
LEFT=1;
//You can reduce or increase paddla size, keeping hand part unchanged
Webbing_size=100;
Webbing_X_offset=0;
Webbing_Y_offset=0;

/* [Digit V fixed point] */
V0=[28,0]; 
V1=[43,72];    
V2=[18,120];    
V3=[-7,118];   
V4=[-27,102];   
V5=[-28,0];  
center=[0,100];

/* [Digit tip fixed point] */
T1=[110,104]; 
T2=[38,192];    
T3=[0,205];    
T4=[-28,187];   
T5=[-64,153];   

/* [Control points] */

//Hand control points
CT01=[185,162];
CT02=[48,283];
CT03=[-6,289];
CT04=[-40,263];
CT05=[-103,239];

//Webbing control points
CTW0_0=[20,-10];
CTW0_1=[295,180];
CTW0_2=[-200,340];
CTW0_3=[-25,-10];

/* [Straps fixing points] */
X_size_cut_1=1;
Y_size_cut_1=1;
Rotation_cut_1=0;
X_position_cut_1=25;
Y_position_cut_1=-10;
X_size_cut_2=1;
Y_size_cut_2=1;
Rotation_cut_2=0;
X_position_cut_2=-25;
Y_position_cut_2=-10;
X_size_cut_3=1;
Y_size_cut_3=1;
Rotation_cut_3=0;
X_position_cut_3=45;
Y_position_cut_3=150;
X_size_cut_4=1;
Y_size_cut_4=1;
Rotation_cut_4=0;
X_position_cut_4=54;
Y_position_cut_4=150;
X_size_cut_5=1;
Y_size_cut_5=1;
Rotation_cut_5=0;
X_position_cut_5=-33;
Y_position_cut_5=150;
X_size_cut_6=1;
Y_size_cut_6=1;
Rotation_cut_6=0;
X_position_cut_6=-41;
Y_position_cut_6=150;
X_size_cut_7=0;
Y_size_cut_7=0;
Rotation_cut_7=0;
X_position_cut_7=0;
Y_position_cut_7=0;
X_size_cut_8=0;
Y_size_cut_8=0;
Rotation_cut_8=0;
X_position_cut_8=0;
Y_position_cut_8=0;


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
                circle(width);
            translate(CT01)
                circle(width);
            }
    }

module line1(P01,CT01,width)
    {        
        color("Black")
         hull()
            {
            translate(P01)
                circle(width/2);
            translate(CT01)
                circle(width/2);
            }
    }

module points(P01,CT01,P02)
    {       
            color("Lightgreen")
            {
            translate(P01)
                cylinder(r=2.5,h=2);
            translate(CT01)
                cylinder(r=1.5,h=2);
            translate(P02)
                cylinder(r=2.5,h=2);
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

module track_b(points,index,width)
{
    if(index<len(points))
        {
        line(points[index-1],points[index],width);
        line(points[index-1],center,width);
        track(points,index+1,width);
        }
}

module Paddle(width)
   {
   union()
      {
      hull()
         {
         color("green")track(curva_bezier_2(V0,CT01,V1),1,width);
         }
      hull()
         {
         color("blue")track(curva_bezier_2(V1,CT02,V2),1,width);
         }
      hull()
         {
         color("red")track(curva_bezier_2(V2,CT03,V3),1,width);
         }
      hull()
         {
         color("pink")track(curva_bezier_2(V3,CT04,V4),1,width);
         }
      hull()
         {
         color("purple")track(curva_bezier_2(V4,CT05,V5),1,width);
         }

      hull()
         {
         translate(V0)
         translate([0,0,Paddle_thickness/2])
            circle(r=Paddle_thickness/2);
         translate(V1)
         translate([0,0,Paddle_thickness/2])
            circle(r=Paddle_thickness/2);
         translate(V2)
         translate([0,0,Paddle_thickness/2])
            circle(r=Paddle_thickness/2);
         translate(V3)
         translate([0,0,Paddle_thickness/2])
            circle(r=Paddle_thickness/2);
         translate(V4)
         translate([0,0,Paddle_thickness/2])
            circle(r=Paddle_thickness/2);
         translate(V5)
         translate([0,0,Paddle_thickness/2])
            circle(r=Paddle_thickness/2);
         }

      }
   }

module Webbing(width)
   {
   union()
      {
      hull()
         {
         translate([0,0,Webbing_thickness/2])
         track(curva_bezier_3(CTW0_0,CTW0_1,CTW0_2,CTW0_3),1,width);
         }
      }
   }

module Webbing_b(width)
   {
      translate([0,0,Webbing_thickness/2])
         track(curva_bezier_3(CTW0_0,CTW0_1,CTW0_2,CTW0_3),1,width);
   }

module Paddle_b(width)
{
union()
   {
   color("green")track(curva_bezier_2(V0,CT01,V1),1,width);
   color("blue")track(curva_bezier_2(V1,CT02,V2),1,width);
   color("red")track(curva_bezier_2(V2,CT03,V3),1,width);
   color("pink")track(curva_bezier_2(V3,CT04,V4),1,width);
   color("purple")track(curva_bezier_2(V4,CT05,V5),1,width);
   }
}

//----------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------Code------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------
rotate(Rotation)
   {
   if(Edit_mode==0 && LEFT==1)
      difference()
         {
         union()
            {
            color("Green")linear_extrude(Paddle_thickness) Paddle(0.1);
            
            a=(1/100)*Webbing_size;
            b=(1/100)*Webbing_size;
            translate([Webbing_X_offset,Webbing_Y_offset,0])
            scale([a,b,1])
               linear_extrude(Webbing_thickness)
               Webbing(1);
            } 
         translate([X_position_cut_1,Y_position_cut_1,0])
         rotate([0,0,Rotation_cut_1])
         cube([X_size_cut_1,Y_size_cut_1,Paddle_thickness*3],center=true);
         translate([X_position_cut_2,Y_position_cut_2,0])
         rotate([0,0,Rotation_cut_2])
         cube([X_size_cut_2,Y_size_cut_2,Paddle_thickness*3],center=true);
         translate([X_position_cut_3,Y_position_cut_3,0])
         rotate([0,0,Rotation_cut_3])
         cube([X_size_cut_3,Y_size_cut_3,Paddle_thickness*3],center=true);
         translate([X_position_cut_4,Y_position_cut_4,0])
         rotate([0,0,Rotation_cut_4])
         cube([X_size_cut_4,Y_size_cut_4,Paddle_thickness*3],center=true);
         translate([X_position_cut_5,Y_position_cut_5,0])
         rotate([0,0,Rotation_cut_5])
         cube([X_size_cut_5,Y_size_cut_5,Paddle_thickness*3],center=true);
         translate([X_position_cut_6,Y_position_cut_6,0])
         rotate([0,0,Rotation_cut_6])
         cube([X_size_cut_6,Y_size_cut_6,Paddle_thickness*3],center=true);
         translate([X_position_cut_7,Y_position_cut_7,0])
         rotate([0,0,Rotation_cut_7])
         cube([X_size_cut_7,Y_size_cut_7,Paddle_thickness*3],center=true);
         translate([X_position_cut_8,Y_position_cut_8,0])
         rotate([0,0,Rotation_cut_8])
         cube([X_size_cut_8,Y_size_cut_8,Paddle_thickness*3],center=true);


         }


if(Edit_mode==0 && LEFT==0)
   mirror()
      union()
         {
         color("Green")linear_extrude(Paddle_thickness) Paddle(0.1);
         a=(1/100)*Webbing_size;
         b=(1/100)*Webbing_size;
         translate([Webbing_X_offset,Webbing_Y_offset,0])
         scale([a,b,1])
            linear_extrude(Webbing_thickness)
            Webbing(1);
         }   


if(Edit_mode==1 || Edit_mode==2 || Edit_mode==3)
{
   Paddle_b(2);
   Webbing_b(1);
  
      if(Edit_mode==1 || Edit_mode==3)
      {
      line1(V0,CT01,0.5);
      line1(CT01,V1,0.5);
      line1(V1,CT02,0.5);
      line1(CT02,V2,0.5);
      line1(V2,CT03,0.5);
      line1(CT03,V3,0.5);
      line1(V3,CT04,0.5);
      line1(CT04,V4,0.5);
      line1(V4,CT05,0.5);
      line1(CT05,V5,0.5);

      points(V0,CT01,V1);
      points(V1,CT02,V2);
      points(V2,CT03,V3);
      points(V3,CT04,V4);
      points(V4,CT05,V5);
      }

      points(V0,T1,V1);
      points(V1,T2,V2);
      points(V2,T3,V3);
      points(V3,T4,V4);
      points(V4,T5,V5);



   if(Edit_mode==2 || Edit_mode==3)
      {

      
      line1(CTW0_0,CTW0_1,0.5);
      line1(CTW0_1,CTW0_2,0.5);
      line1(CTW0_2,CTW0_3,0.5);
      points(CTW0_0,CTW0_1,CTW0_2);
      points(CTW0_1,CTW0_2,CTW0_3);
       }  


if(Edit_mode==1 || Edit_mode==3)
    color("Black")
{
       translate (V0)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V0 ",V0),size=4,halign="center",valign="top");
        translate (V1)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V1 ",V1),size=4,halign="center",valign="top");
        translate (V2)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V2 ",V2),size=4,halign="center",valign="top");
        translate (V3)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V3 ",V3),size=4,halign="center",valign="top");
        translate (V4)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V4 ",V4),size=4,halign="center",valign="top");
        translate (V5)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V5 ",V5),size=4,halign="center",valign="top");

        translate (T1)
         translate([0,+5,0])
         linear_extrude(1)
          text(str("T1 ",T1),size=4,halign="center",valign="bottom");
        translate (T2)
         translate([0,+5,0])
         linear_extrude(1)
          text(str("T2 ",T2),size=4,halign="center",valign="bottom");
        translate (T3)
         translate([0,+5,0])
         linear_extrude(1)
          text(str("T3 ",T3),size=4,halign="center",valign="bottom");
        translate (T4)
         translate([0,+5,0])
         linear_extrude(1)
          text(str("T4 ",T4),size=4,halign="center",valign="bottom");
        translate (T5)
         translate([0,+5,0])
         linear_extrude(1)
          text(str("T5 ",T5),size=4,halign="center",valign="bottom");

         translate (CT01)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CT01 ",CT01),size=4);
         translate (CT02)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CT02 ",CT02),size=4);
         translate (CT03)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CT03 ",CT03),size=4);
         translate (CT04)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CT04 ",CT04),size=4);
         translate (CT05)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CT05 ",CT05),size=4);
}

if(Edit_mode==2 || Edit_mode==3)
    color("Black")
         {
         translate (CTW0_0)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CTW0_0 ",CTW0_0),size=4);
         translate (CTW0_1)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CTW0_1 ",CTW0_1),size=4);
         translate (CTW0_2)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CTW0_2 ",CTW0_2),size=4);
         translate (CTW0_3)
         translate([5,5,0])
          linear_extrude(1)
           text(str("CTW0_3 ",CTW0_3),size=4);
         }
   }

}

