 //Resolution of curves
$fn=36;  

//0=Render    1=Show hand points    2=Show webbing points    3=Show finger_bridges position    4=Render only finger bridges for print test
Edit_mode=0;
//0=Right hand paddle    1=Left hand paddle
LEFT=1;

/* [Paddle parameters] */
Hand_thickness=2;
Webbing_type=1;      //0=Round paddle     1=Webbed hand
Webbing_thickness=0.5;
Webbing_redimensioning=99;
Webbing_X_offset=0;
Webbing_Y_offset=0;


/* [Fixed  points] */
//V points
V0=[12,0]; 
V1=[33,90];    
V2=[10,128];    
V3=[-12,130];   
V4=[-33,115];   
V5=[-52,0];  
//Tips points
T1=[85,125]; 
T2=[34,200];    
T3=[0,215];    
T4=[-24,195];   
T5=[-59,170];   

/* [Control points] */

//Hand control points
CT01=[148,192];
CT02=[49,289];
CT03=[1,299];
CT04=[-26,266];
CT05=[-83,266];

//Webbing 0 control points
CTW0_1=[320,200];
CTW0_2=[-220,340];

//Webbing 1 control points
CTW1_1=[50,130];
CTW1_2=[15,170];
CTW1_3=[-13,160];
CTW1_4=[-40,140];

/* [Fingers rings] */
Finger_band_width=5;
Finger_band_thickness=2;

FBP_1=[57,93];  //Finger band position
FBR_1=-45;     //Finger band rotation
FBD_1=24;      //Finger_band_diameter

FBP_2=[28,160];
FBR_2=-8;
FBD_2=19;

FBP_3=[-0.5,165];
FBR_3=0;
FBD_3=19;

FBP_4=[-23,155];
FBR_4=5;
FBD_4=17;

FBP_5=[-52,130];
FBR_5=15;
FBD_5=15;

Wrist_cut_width=1;
Wrist_cut_length=10;


//----------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------Functions-------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------

function curva_bezier_3(P01,CT01,P02,CT02)=
    [for(a=[0:0.05:1+0.05])
        P01*pow(1-a,3)+3*CT01*a*pow(1-a,2)+3*P02*pow(a,2)*(1-a)+CT02*pow(a,3)];

function curva_bezier_2(P01,CT01,P02)=
    [for(a=[0:0.05:1+0.05])
         pow(1-a,2)*P01+2*a*(1-a)*CT01+pow(a,2)*P02];

module Finger_bridge(FP,FBR,Finger_radius)
   {
   difference()
      {
      union()
         {
         translate(FP)
            translate([0,0,Finger_radius*0.8-1])
               rotate([90,0,FBR])
                  scale([0.5,1,1])
                     cylinder(r=Finger_radius*0.8+Finger_band_thickness,h=Finger_band_width,center=true);
         }
      translate(FP)
         translate([0,0,Finger_radius*0.8-1])
            rotate([90,0,FBR])
               scale([0.5,1,1])
                  cylinder(r=Finger_radius*0.8,h=Finger_band_width+1,center=true);
      }
   }


module line(P01,CT01,width)
   {        
   hull()
      {
      translate(P01)
          circle(width);
      translate(CT01)
          circle(width);
         circle(r=1);
      }
   }

module line1(P01,CT01,width)
   {        
      color("Black")
         linear_extrude(2)
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
         translate([0,0,Hand_thickness/2])
            circle(r=Hand_thickness/2);
         translate(V1)
         translate([0,0,Hand_thickness/2])
            circle(r=Hand_thickness/2);
         translate(V2)
         translate([0,0,Hand_thickness/2])
            circle(r=Hand_thickness/2);
         translate(V3)
         translate([0,0,Hand_thickness/2])
            circle(r=Hand_thickness/2);
         translate(V4)
         translate([0,0,Hand_thickness/2])
            circle(r=Hand_thickness/2);
         translate(V5)
         translate([0,0,Hand_thickness/2])
            circle(r=Hand_thickness/2);
         }
      }
   }

module Webbing(width)
   {
   if(Webbing_type==0)
      hull()
         {
         translate([0,0,Webbing_thickness/2])
          track(curva_bezier_3(V0,CTW0_1,CTW0_2,V5),1,width);
         }

   if(Webbing_type==1)
      translate([0,0,Webbing_thickness/2])
         {
            {
            track(curva_bezier_2(T1+[-1,-1],CTW1_1,T2),1,width);
            track(curva_bezier_2(T2,CTW1_2,T3),1,width);
            track(curva_bezier_2(T3,CTW1_3,T4),1,width);
            track(curva_bezier_2(T4,CTW1_4,T5+[1,-1]),1,width);
            track(curva_bezier_2(V0,V3,V5),1,width);
            }
      }
   }

module Webbing_b(width)
   {
   if(Webbing_type==0)
      translate([0,0,Webbing_thickness/2])
         track(curva_bezier_3(V0,CTW0_1,CTW0_2,V5),1,width);
   
   if(Webbing_type==1)
      translate([0,0,Webbing_thickness/2])
         union()
            {
            track(curva_bezier_2(T1,CTW1_1,T2),1,width);
            track(curva_bezier_2(T2,CTW1_2,T3),1,width);
            track(curva_bezier_2(T3,CTW1_3,T4),1,width);
            track(curva_bezier_2(T4,CTW1_4,T5),1,width);
            }
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

module Finger_bands()
   {
   Finger_bridge(FBP_1,FBR_1,FBD_1);
   Finger_bridge(FBP_2,FBR_2,FBD_2);
   Finger_bridge(FBP_3,FBR_3,FBD_3);
   Finger_bridge(FBP_4,FBR_4,FBD_4);
   Finger_bridge(FBP_5,FBR_5,FBD_5);
   }


//----------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------Code------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------

   {
   if(Edit_mode==0 && LEFT==1)
      difference()
         {
         union()
            {
            color("Green")linear_extrude(Hand_thickness) Paddle(0.1);
            a=(1/100)*Webbing_redimensioning;
            b=(1/100)*Webbing_redimensioning;
            translate([Webbing_X_offset,Webbing_Y_offset,0])
               scale([a,b,1])
                  linear_extrude(Webbing_thickness)
                     Webbing(1);

            Finger_bands();
            }
         hull()
            {
            translate(V0+[-5,5])
               cylinder(r=Wrist_cut_width,h=10,center=true);
            translate(V0+[-5,5])
               translate([0,Wrist_cut_length,0])
                  cylinder(r=Wrist_cut_width,h=10,center=true);

            }
         hull()
            {
            translate(V5+[5,5])
               cylinder(r=Wrist_cut_width,h=10,center=true);
            translate(V5+[5,5])
               translate([0,Wrist_cut_length,0])
                  cylinder(r=Wrist_cut_width,h=10,center=true);
            }
         translate([0,0,-5])
            cube([500,500,10],center=true);

         }

if(Edit_mode==0 && LEFT==0)
   mirror()
      difference()
         {
         union()
            {
            color("Green")linear_extrude(Hand_thickness) Paddle(0.1);
            a=(1/100)*Webbing_redimensioning;
            b=(1/100)*Webbing_redimensioning;
            translate([Webbing_X_offset,Webbing_Y_offset,0])
            scale([a,b,1])
               linear_extrude(Webbing_thickness)
               Webbing(1);

            Finger_bands();
            }   
         translate(V0+[-5,5])
            cylinder(r=0.9,h=10,center=true);
         translate(V5+[5,5])
            cylinder(r=0.9,h=10,center=true);
         translate([0,0,-5])
            cube([500,500,10],center=true);
         }


if(Edit_mode==1 || Edit_mode==2 || Edit_mode==3)
   {
   color("Yellow")
   Paddle_b(1);
   
   if(Edit_mode==2) 
      Webbing_b(1);
  
   if(Edit_mode==1)
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

      points(V0,T1,V1);
      points(V1,T2,V2);
      points(V2,T3,V3);
      points(V3,T4,V4);
      points(V4,T5,V5);

      }

      if(Webbing_type==0)
      if(Edit_mode==2)
         {
         line1(V0,CTW0_1,2);
         line1(CTW0_1,CTW0_2,0.5);
         line1(CTW0_2,V5,0.5);
         points(V0,CTW0_1,CTW0_2);
         points(CTW0_1,CTW0_2,V5);
         }

      if(Webbing_type==1)
         if(Edit_mode==2 || Edit_mode==4)
         {
         line1(T1,CTW1_1,0.5);
         line1(CTW1_1,T2,0.5);
         line1(T2,CTW1_2,0.5);
         line1(CTW1_2,T3,0.5);
         line1(T3,CTW1_3,0.5);
         line1(CTW1_3,T4,0.5);
         line1(T4,CTW1_4,0.5);
         line1(CTW1_4,T5,0.5);

         points(T1,CTW1_1,T2);
         points(T2,CTW1_2,T3);
         points(T3,CTW1_3,T4);
         points(T4,CTW1_4,T5);
         
         }

if(Edit_mode==1)
    color("Black")
      {
       translate (V0)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V0"),size=4,halign="center",valign="top");
       translate (V0)
         translate([0,-10,0])
         linear_extrude(1)
          text(str(V0),size=4,halign="center",valign="top");

        translate (V1)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V1"),size=4,halign="center",valign="top");
        translate (V1)
         translate([0,-10,0])
         linear_extrude(1)
          text(str(V1),size=4,halign="center",valign="top");

        translate (V2)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V2"),size=4,halign="center",valign="top");
        translate (V2)
         translate([0,-10,0])
         linear_extrude(1)
          text(str(V2),size=4,halign="center",valign="top");

        translate (V3)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V3"),size=4,halign="center",valign="top");
         translate (V3)
         translate([0,-10,0])
         linear_extrude(1)
          text(str(V3),size=4,halign="center",valign="top");

        translate (V4)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V4"),size=4,halign="center",valign="top");
        translate (V4)
         translate([0,-10,0])
         linear_extrude(1)
          text(str(V4),size=4,halign="center",valign="top");

        translate (V5)
         translate([0,-5,0])
         linear_extrude(1)
          text(str("V5"),size=4,halign="center",valign="top");
         translate (V5)
         translate([0,-10,0])
         linear_extrude(1)
          text(str(V5),size=4,halign="center",valign="top");

        translate (T1)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T1"),size=4,halign="center",valign="bottom");
         translate (T1)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T1),size=4,halign="center",valign="bottom");

        translate (T2)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T2"),size=4,halign="center",valign="bottom");
        translate (T2)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T2),size=4,halign="center",valign="bottom");

        translate (T3)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T3"),size=4,halign="center",valign="bottom");
         translate (T3)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T3),size=4,halign="center",valign="bottom");

        translate (T4)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T4"),size=4,halign="center",valign="bottom");
        translate (T4)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T4),size=4,halign="center",valign="bottom");

        translate (T5)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T5"),size=4,halign="center",valign="bottom");
        translate (T5)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T5),size=4,halign="center",valign="bottom");

         translate (CT01)
         translate([0,11,0])
          linear_extrude(1)
           text(str("CT01"),size=4,halign="center",valign="bottom");
         translate (CT01)
         translate([0,5,0])
          linear_extrude(1)
           text(str(CT01),size=4,halign="center",valign="bottom");

         translate (CT02)
         translate([0,11,0])
          linear_extrude(1)
           text(str("CT02"),size=4,halign="center",valign="bottom");
         translate (CT02)
         translate([0,5,0])
          linear_extrude(1)
           text(str(CT02),size=4,halign="center",valign="bottom");

         translate (CT03)
         translate([0,11,0])
          linear_extrude(1)
           text(str("CT03"),size=4,halign="center",valign="bottom");
         translate (CT03)
         translate([0,5,0])
          linear_extrude(1)
           text(str(CT03),size=4,halign="center",valign="bottom");

         translate (CT04)
         translate([0,11,0])
          linear_extrude(1)
           text(str("CT04"),size=4,halign="center",valign="bottom");
         translate (CT04)
         translate([0,5,0])
          linear_extrude(1)
           text(str(CT04),size=4,halign="center",valign="bottom");

         translate (CT05)
         translate([0,11,0])
          linear_extrude(1)
           text(str("CT05"),size=4,halign="center",valign="bottom");
         translate (CT05)
         translate([0,5,0])
          linear_extrude(1)
           text(str(CT05),size=4,halign="center",valign="bottom");

      }

if(Edit_mode==2)
    color("Black")
      {
          translate (T1)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T1"),size=4,halign="center",valign="bottom");
         translate (T1)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T1),size=4,halign="center",valign="bottom");

        translate (T2)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T2"),size=4,halign="center",valign="bottom");
        translate (T2)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T2),size=4,halign="center",valign="bottom");

        translate (T3)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T3"),size=4,halign="center",valign="bottom");
         translate (T3)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T3),size=4,halign="center",valign="bottom");

        translate (T4)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T4"),size=4,halign="center",valign="bottom");
        translate (T4)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T4),size=4,halign="center",valign="bottom");

        translate (T5)
         translate([0,+11,0])
         linear_extrude(1)
          text(str("T5"),size=4,halign="center",valign="bottom");
        translate (T5)
         translate([0,+5,0])
         linear_extrude(1)
          text(str(T5),size=4,halign="center",valign="bottom");

         if(Webbing_type==0)
            {
            translate (CTW0_1)
            translate([0,11,0])
             linear_extrude(1)
              text(str("CTW0_1"),size=4,halign="center",valign="bottom");
            translate (CTW0_1)
            translate([0,5,0])
             linear_extrude(1)
              text(str(CTW0_1),size=4,halign="center",valign="bottom");

            translate (CTW0_2)
            translate([0,11,0])
             linear_extrude(1)
              text(str("CTW02"),size=4,halign="center",valign="bottom");
            translate (CTW0_2)
            translate([0,5,0])
             linear_extrude(1)
              text(str(CTW0_2),size=4,halign="center",valign="bottom");
            }

         if(Webbing_type==1)
            {
            translate (CTW1_1)
            translate([0,-7,0])
             linear_extrude(1)
              text(str("CTW1_1"),size=4,halign="center",valign="bottom");
            translate (CTW1_1)
            translate([0,-12,0])
             linear_extrude(1)
              text(str(CTW1_1),size=4,halign="center",valign="bottom");

            translate (CTW1_2)
            translate([0,-7,0])
             linear_extrude(1)
              text(str("CTW1_2"),size=4,halign="center",valign="bottom");
            translate (CTW1_2)
            translate([0,-12,0])
             linear_extrude(1)
              text(str(CTW1_2),size=4,halign="center",valign="bottom");

            translate (CTW1_3)
            translate([0,-7,0])
             linear_extrude(1)
              text(str("CTW1_3"),size=4,halign="center",valign="bottom");
            translate (CTW1_3)
            translate([0,-12,0])
             linear_extrude(1)
              text(str(CTW1_3),size=4,halign="center",valign="bottom");

            translate (CTW1_4)
            translate([0,-7,0])
             linear_extrude(1)
              text(str("CTW1_4"),size=4,halign="center",valign="bottom");
            translate (CTW1_4)
            translate([0,-12,0])
             linear_extrude(1)
              text(str(CTW1_4),size=4,halign="center",valign="bottom");
            }
      }

if(Edit_mode==3)
    color("Black")
      {
          translate (FBP_1)
         translate([0,-10,0])
         linear_extrude(1)
          text(str("FBR_1 [",FBR_1,"]"),size=3,halign="center",valign="bottom");
         translate (FBP_1)
         translate([0,-16,0])
         linear_extrude(1)
          text(str("FBP_1 ",FBP_1),size=3,halign="center",valign="bottom");

        translate (FBP_2)
         translate([0,-10,0])
         linear_extrude(1)
          text(str("FBR_2 [",FBR_2,"]"),size=3,halign="center",valign="bottom");
        translate (FBP_2)
         translate([0,-16,0])
         linear_extrude(1)
          text(str("FBP_2 ",FBP_2),size=3,halign="center",valign="bottom");

        translate (FBP_3)
         translate([0,-10,0])
         linear_extrude(1)
          text(str("FBR_3 [",FBR_3,"]"),size=3,halign="center",valign="bottom");
         translate (FBP_3)
         translate([0,-16,0])
         linear_extrude(1)
          text(str("FBP_3 ",FBP_3),size=3,halign="center",valign="bottom");

        translate (FBP_4)
         translate([0,-10,0])
         linear_extrude(1)
          text(str("FBR_4 [",FBR_4,"]"),size=3,halign="center",valign="bottom");
        translate (FBP_4)
         translate([0,-16,0])
         linear_extrude(1)
          text(str("FBP_4 ",FBP_4),size=3,halign="center",valign="bottom");

        translate (FBP_5)
         translate([0,-10,0])
         linear_extrude(1)
          text(str("FBR_5 [",FBR_5,"]"),size=3,halign="center",valign="bottom");
        translate (FBP_5)
         translate([0,-16,0])
         linear_extrude(1)
          text(str("FBP_5 ",FBP_5),size=3,halign="center",valign="bottom");

      }
   }
}

if(Edit_mode==3)
   %difference()
      {
      Finger_bands();

      translate([0,0,-5])
         cube([500,500,10],center=true);
      }

if(Edit_mode==4)
   difference()
      {
      Finger_bands();

      translate([0,0,-5])
         cube([500,500,10],center=true);
      }
