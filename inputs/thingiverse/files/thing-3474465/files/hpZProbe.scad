XPlatteH=80;
XPlatteB=62;
XPlatteD=4;

StiftL=10;
StiftDA=3;
StiftDI=0;
StiftS=0;

LagerBockX=30;
LagerBockY=34;

ProbeBaseX=50;
ProbeBaseY=60;
ProbeBaseZ=4;
RD=4;

SG90X=12;
SG90Y=6;
SG90Z=15;

ObenZ=20;
ObenRD=2;
ObenX1=25;
ObenX2=12;
ObenY1=27;
ObenY2=40;
ObenOptoY=11;

StabDicke=2.0;
StabHoehe=10.0;
StabBreite1=14.0;
StabBreite2=7.6;
StabLaenge1=110;
StabLaenge2=50;
StabLichte=0.2;

$fn = 120;

module Haube()
{
    Lichte=2;
    difference()
    {  
        union()
        {
             color( "LightBlue", 1.0)             
            hull()
             {
                translate([-ObenX1/2+ObenRD-Lichte,ObenOptoY-ObenRD,ObenRD+Lichte])  sphere(ObenRD);     
                translate([ObenX1/2-ObenRD+Lichte,ObenOptoY-ObenRD,ObenRD+Lichte])  sphere(ObenRD);
                translate([-ObenX1/2+ObenRD-Lichte,-ObenY1+ObenOptoY-ObenRD,ObenRD+Lichte]) sphere(ObenRD);
                translate([ObenX1/2-ObenRD+Lichte,-ObenY1+ObenOptoY-ObenRD,ObenRD+Lichte]) sphere(ObenRD); 

                translate([-ObenX1/2+ObenRD-Lichte,ObenOptoY-ObenRD,ObenZ-ObenRD+Lichte])  sphere(ObenRD);     
                translate([ObenX1/2-ObenRD+Lichte,ObenOptoY-ObenRD,ObenZ-ObenRD+Lichte])  sphere(ObenRD);
                translate([-ObenX1/2+ObenRD-Lichte,-ObenY1+ObenOptoY-ObenRD,ObenZ-ObenRD+Lichte]) sphere(ObenRD);
                translate([ObenX1/2-ObenRD+Lichte,-ObenY1+ObenOptoY-ObenRD,ObenZ-ObenRD+Lichte]) sphere(ObenRD); 
             }   
        }
        union()
        {
            color( "red", 1.0 )             
            hull()
             {
                translate([-ObenX1/2+ObenRD,ObenOptoY-ObenRD-Lichte,ObenRD+Lichte*2])  sphere(ObenRD);     
                translate([ObenX1/2-ObenRD,ObenOptoY-ObenRD-Lichte,ObenRD+Lichte*2])  sphere(ObenRD);
                translate([-ObenX1/2+ObenRD,-ObenY1+ObenOptoY-ObenRD-Lichte,ObenRD+Lichte*2]) sphere(ObenRD);
                translate([ObenX1/2-ObenRD,-ObenY1+ObenOptoY-ObenRD-Lichte,ObenRD+Lichte*2]) sphere(ObenRD); 

                translate([-ObenX1/2+ObenRD,ObenOptoY-ObenRD-Lichte,ObenZ-ObenRD])  sphere(ObenRD);     
                translate([ObenX1/2-ObenRD,ObenOptoY-ObenRD-Lichte,ObenZ-ObenRD])  sphere(ObenRD);
                translate([-ObenX1/2+ObenRD,-ObenY1+ObenOptoY-ObenRD-Lichte,ObenZ-ObenRD]) sphere(ObenRD);
                translate([ObenX1/2-ObenRD,-ObenY1+ObenOptoY-ObenRD-Lichte,ObenZ-ObenRD]) sphere(ObenRD); 
             }   
             color( "red", 1.0 ) translate([0,-12,ObenZ+1]) rotate([0,0,0]) cube([ObenX1+10,ObenOptoY*2,6],center=true);  
             color( "red", 1.0 ) translate([0,-12,4]) rotate([0,0,0]) cube([ObenX1,ObenOptoY*2,6],center=true);  
             color( "red", 1.0 ) translate([-ObenX1/2-5,-12,2]) rotate([0,0,0]) cube([10,ObenOptoY*2,10],center=true);  
             color( "red", 1.0 ) translate([ObenX1/2+5,-12,2]) rotate([0,0,0]) cube([10,ObenOptoY*2,10],center=true);  
        }
    }
}    
    

module Stab()
{
    difference()
    {  
        union()
        {
            translate([-StabBreite2/2,0,0]) cube([StabBreite2,StabLaenge1,StabDicke],center=false);  
            translate([-StabBreite1/2,3,0]) cube([StabBreite1,20,StabDicke],center=false);  
            translate([-StabDicke/2,0,0]) cube([StabDicke,StabLaenge1,StabHoehe],center=false);  
      }
        union()
        {
            translate([-StabBreite1/2,7,4]) cube([StabBreite1,10,10],center=false);  
            translate([-StabBreite1/2,44,3]) cube([StabBreite1,10,10],center=false);  
            translate([-20,StabLaenge1+8.5,0]) rotate([0,0,45]) cube([40,40,40],center=true);  
            translate([20,StabLaenge1+8.5,0]) rotate([0,0,-45]) cube([40,40,40],center=true);  
            translate([0,StabLaenge1+7.5,-20]) rotate([45,0,0]) cube([40,40,40],center=true);  
            translate([0,StabLaenge1+9.5,20]) rotate([-45,0,0]) cube([40,40,40],center=true);  
             translate([5,StabLaenge1/2-1,StabHoehe+2.5]) rotate([0,45,0]) cube([10,StabLaenge1+2,10],center=true);  
            translate([-5,StabLaenge1/2-1,StabHoehe+2.5]) rotate([0,-45,0]) cube([10,StabLaenge1+2,10],center=true);  
              translate([10,StabLaenge1/2+24,2]) rotate([0,45,0]) cube([10,StabLaenge1+2,10],center=true);  
              translate([-10,StabLaenge1/2+24,2]) rotate([0,-45,0]) cube([10,StabLaenge1+2,10],center=true);  
              translate([10,0,2]) rotate([0,45,0]) cube([10,6,10],center=true);  
              translate([-10,0,2]) rotate([0,-45,0]) cube([10,6,10],center=true);  
              translate([13,StabLaenge1/2,2]) rotate([0,45,0]) cube([10,StabLaenge1+2,10],center=true);  
              translate([-13,StabLaenge1/2,2]) rotate([0,-45,0]) cube([10,StabLaenge1+2,10],center=true);  
        }
    }
}

module Oben(Ausschnitte=true,Lichte=0)
{
  //   translate([-4,5.5,4]) color( "LightBlue", 1.0 )  rotate([0,0,0])  import ("optical_endstop.stl", convexity = 5);
    color( "Yellow", 1.0) 
    difference()
    {  
        union()
        {  
             hull()
             {
                translate([-ObenX1/2+ObenRD-Lichte,ObenOptoY-ObenRD,ObenRD])  sphere(ObenRD);     
                translate([ObenX1/2-ObenRD+Lichte,ObenOptoY-ObenRD,ObenRD])  sphere(ObenRD);
                translate([-ObenX1/2+ObenRD,-ObenY1+ObenOptoY-ObenRD,ObenRD]) sphere(ObenRD);
                translate([ObenX1/2-ObenRD,-ObenY1+ObenOptoY-ObenRD,ObenRD]) sphere(ObenRD); 
                translate([-ObenX2/2+ObenRD,-ObenY1+ObenOptoY-5-ObenRD,ObenRD]) sphere(ObenRD); 
                translate([ObenX2/2-ObenRD,-ObenY1+ObenOptoY-5-ObenRD,ObenRD]) sphere(ObenRD);    

                translate([-ObenX1/2+ObenRD-Lichte,ObenOptoY-ObenRD,ObenZ-ObenRD])  sphere(ObenRD);     
                translate([ObenX1/2-ObenRD+Lichte,ObenOptoY-ObenRD,ObenZ-ObenRD])  sphere(ObenRD);
                translate([-ObenX1/2+ObenRD-Lichte,-ObenY1+ObenOptoY-ObenRD,ObenZ-ObenRD]) sphere(ObenRD);
                translate([ObenX1/2-ObenRD+Lichte,-ObenY1+ObenOptoY-ObenRD,ObenZ-ObenRD]) sphere(ObenRD); 
                translate([-ObenX2/2+ObenRD-Lichte,-ObenY1+ObenOptoY-5-ObenRD,ObenZ-ObenRD]) sphere(ObenRD); 
                translate([ObenX2/2-ObenRD+Lichte,-ObenY1+ObenOptoY-5-ObenRD,ObenZ-ObenRD]) sphere(ObenRD);    
             }   
              hull()
             {
                translate([-ObenX2/2+ObenRD-Lichte,-ObenY1+ObenOptoY-5,ObenRD]) sphere(ObenRD);     
                translate([ObenX2/2-ObenRD+Lichte,-ObenY1+ObenOptoY-5,ObenRD]) sphere(ObenRD);    
                translate([-ObenX2/2+ObenRD-Lichte,-ObenY1+ObenOptoY-ObenY2,ObenRD]) sphere(ObenRD);    
                translate([ObenX2/2-ObenRD+Lichte,-ObenY1+ObenOptoY-ObenY2,ObenRD]) sphere(ObenRD);     

                translate([-ObenX2/2+ObenRD-Lichte,-ObenY1+ObenOptoY-5,ObenZ-ObenRD]) sphere(ObenRD);     
                translate([ObenX2/2-ObenRD+Lichte,-ObenY1+ObenOptoY-5,ObenZ-ObenRD]) sphere(ObenRD);    
                translate([-ObenX2/2+ObenRD-Lichte,-ObenY1+ObenOptoY-ObenY2,ObenZ-ObenRD]) sphere(ObenRD);    
                translate([ObenX2/2-ObenRD+Lichte,-ObenY1+ObenOptoY-ObenY2,ObenZ-ObenRD]) sphere(ObenRD);     
             }   
     }
        union()
        {  
            if (Ausschnitte)
            {
                translate([-ObenX1/2,0,4]) cube([ObenX1,ObenOptoY,ObenZ-4],center=false);  
                translate([-ObenX1/2+6,0,2]) cube([ObenX1-12,ObenOptoY,ObenZ-2],center=false);  
 
                 translate([9,ObenOptoY/2,0]) cylinder(d=3.5,h=ProbeBaseZ,center=false); 
                 translate([-9,ObenOptoY/2,0]) cylinder(d=3.5,h=ProbeBaseZ,center=false); 

                translate([-StabDicke/2-StabLichte,-ObenY1-ObenY2-10,10-0.2]) cube([StabDicke+StabLichte*2,StabLaenge1,StabHoehe+StabLichte*2],center=false);  
                translate([-StabBreite1/2-StabLichte,-ObenY1+ObenOptoY-4,10+StabHoehe-StabDicke-StabLichte*2]) cube([StabBreite1+StabLichte*2,StabLaenge2,StabDicke+StabLichte*2],center=false);  
                translate([-StabBreite2/2-StabLichte,-ObenY1-ObenY2-10,10+StabHoehe-StabDicke-StabLichte*2]) cube([StabBreite2+StabLichte*2,StabLaenge1,StabDicke+StabLichte*2],center=false);  
        translate([-ObenX2/2+ObenRD,-ObenY1-ObenOptoY-13,ObenZ-8])   cube([27,29-SG90Y,6],center=false);       
            }
        }
    }
            translate([ObenX2/2-ObenRD,-ObenY1-ObenOptoY-6,ObenZ-8])   cube([2,1,6],center=false);       
            translate([ObenX2/2-ObenRD,-ObenY1-ObenOptoY+2,ObenZ-8])   cube([2,1,6],center=false);       

}

module ProbeBasis()
{
    translate([17,-30,-37.3])  color( "LightBlue", 1.0 )  rotate([90,0,90])  import ("servo_9g_DIY.stl", convexity = 5);
    difference()
    {  
        union()
        {  
                color( "LightGreen",1.3)
                hull()
                {
                    translate([ProbeBaseX/2-RD,ProbeBaseY/2-RD,-ProbeBaseZ]) cylinder(r=RD,h=ProbeBaseZ,center=false);
                    translate([ProbeBaseX/2-RD,-ProbeBaseY/2+RD,-ProbeBaseZ]) cylinder(r=RD,h=ProbeBaseZ,center=false);
                    translate([-ProbeBaseX/2+RD,-ProbeBaseY/2+RD,-ProbeBaseZ]) cylinder(r=RD,h=ProbeBaseZ,center=false);
                    translate([-ProbeBaseX/2+RD,ProbeBaseY/2-RD,-ProbeBaseZ]) cylinder(r=RD,h=ProbeBaseZ,center=false);
                    translate([-LagerBockX/2+RD-5,-ProbeBaseY/2+RD-6,-ProbeBaseZ]) cylinder(r=RD,h=ProbeBaseZ,center=false);
                    translate([LagerBockX/2-RD+5,-ProbeBaseY/2+RD-6,-ProbeBaseZ]) cylinder(r=RD,h=ProbeBaseZ,center=false);
                }
 
                color( "LightGreen",1) translate([ProbeBaseX/2-8-SG90X,-ProbeBaseY/2-SG90Y,-ProbeBaseZ-SG90Z])   cube([SG90X,SG90Y,SG90Z],center=false);       
               color( "LightGreen",1) translate([ProbeBaseX/2-8-SG90X,-ProbeBaseY/2+29-SG90Y,-ProbeBaseZ-SG90Z])   cube([SG90X,SG90Y,SG90Z],center=false);       
       }
        union()
        {
            hull()
            {
                translate([ProbeBaseX/2-5,ProbeBaseY/2-5,-ProbeBaseZ-1]) cylinder(d=4,h=ProbeBaseZ+2,center=false);
                translate([ProbeBaseX/2-5,-ProbeBaseY/2+5,-ProbeBaseZ-1]) cylinder(d=4,h=ProbeBaseZ+2,center=false);
           }
            hull()
            {
                translate([-ProbeBaseX/2+5,ProbeBaseY/2-5,-ProbeBaseZ-1]) cylinder(d=4,h=ProbeBaseZ+2,center=false);
                translate([-ProbeBaseX/2+5,-ProbeBaseY/2+5,-ProbeBaseZ-1]) cylinder(d=4,h=ProbeBaseZ+2,center=false);
           }
          translate([ProbeBaseX/2-8-SG90X/2,-ProbeBaseY/2-SG90Y/2,-ProbeBaseZ-SG90Z])   cylinder(d=1.8,h=SG90Z,center=false);  
          translate([ProbeBaseX/2-8-SG90X/2,-ProbeBaseY/2+29-SG90Y/2,-ProbeBaseZ-SG90Z])   cylinder(d=1.8,h=SG90Z,center=false);       
          translate([ProbeBaseX/2-9-SG90X-14,-ProbeBaseY/2,-ProbeBaseZ-1])   cube([27,29-SG90Y,ProbeBaseZ-1],center=false);       
          translate([ObenX2/2-7,-9,-ProbeBaseZ-1])   cube([ObenX2/2,10,ProbeBaseZ-1],center=false);       
           translate([ObenX2/2,-15,-ProbeBaseZ-15])  rotate([0,0,45])  cube([ObenX2/2,10,ProbeBaseZ+13],center=false);       
           
          translate([-4,21,-22]) Oben(Ausschnitte=false,Lichte=0.2);  
         
        }
    }
}

module Stift(XPos=0,YPos=0,ZPos=0)
{
    difference()
    {  
       union()
       { 
             translate([XPos,YPos,ZPos])   cylinder(h=StiftL,d=StiftDA,center=false);     
       }
       union()
       {
              translate([XPos,YPos,ZPos])   cylinder(h=StiftL,d=StiftDI,center=false);     
              translate([XPos-StiftS/2,YPos-StiftDA,ZPos])   cube([StiftS,StiftDA*2,StiftL],center=false);       
      }
   } 
}

module LagerBock(XPos=0,YPos=0,ZPos=0,Auswahl="Alle")
{
    translate([XPos-LagerBockX/2,YPos-LagerBockY/2,ZPos]) cube([LagerBockX,LagerBockY,1],center=false);  
    if (Auswahl=="Oben") {} else
    {
        Stift(XPos=XPos-LagerBockX/2+6,YPos=YPos-LagerBockY/2+4.5,ZPos=ZPos);    
        Stift(XPos=XPos+LagerBockX/2-6,YPos=YPos-LagerBockY/2+4.5,ZPos=ZPos);
    }    
    if (Auswahl=="Unten") {} else
    {
        Stift(XPos=XPos-LagerBockX/2+6,YPos=YPos+LagerBockY/2-4.5,ZPos=ZPos);    
        Stift(XPos=XPos+LagerBockX/2-6,YPos=YPos+LagerBockY/2-4.5,ZPos=ZPos);    
    }
}

module XPlatte()
{
    difference()
    {  
        union()
        {  
            hull()
            {
                     translate([-XPlatteB/2,XPlatteH/2,XPlatteD/2]) cube([1,1,XPlatteD],center=true);  
                     translate([XPlatteB/2,XPlatteH/2,XPlatteD/2]) cube([1,1,XPlatteD],center=true);  
                     translate([-XPlatteB/2,-20,XPlatteD/2]) cube([1,1,XPlatteD],center=true);  
                     translate([-LagerBockX/2,-LagerBockY-7,XPlatteD/2]) cube([1,1,XPlatteD],center=true);  
                    translate([LagerBockX/2,-LagerBockY-7,XPlatteD/2]) cube([1,1,XPlatteD],center=true);  
                     translate([XPlatteB/2,-20,XPlatteD/2]) cube([1,1,XPlatteD],center=true);  
            }
            translate([-XPlatteB/2-0.5,XPlatteH/2-7-5,XPlatteD]) cube([XPlatteB+1,7+5+0.5,5],center=false);  
            translate([-LagerBockX/2-0.5,-XPlatteH/2-1.5,XPlatteD]) cube([LagerBockX+1,7+6,5],center=false);  
            translate([-XPlatteB/2-0.5,-20,XPlatteD]) cube([XPlatteB+1,40,5],center=false);  
            LagerBock(XPos=-LagerBockX/2-1,YPos=LagerBockY/2+6,ZPos=XPlatteD-1,Auswahl="Oben");
            LagerBock(XPos=LagerBockX/2+1,YPos=LagerBockY/2+6,ZPos=XPlatteD-1,Auswahl="Oben");
            LagerBock(XPos=0,YPos=-LagerBockY/2-6,ZPos=XPlatteD-1,Auswahl="Unten");
        }
       union()
       {
           hull()
           {
            translate([-LagerBockX+3,3,0])   cylinder(h=20,d=4,center=true);     
            translate([-LagerBockX+6,3,0])   cylinder(h=20,d=4,center=true);   
          }
           hull()
           {
            translate([-LagerBockX+3,3,0])   cylinder(h=3,d1=7,d2=4,center=true);     
            translate([-LagerBockX+6,3,0])   cylinder(h=3,d1=7,d2=4,,center=true);   
          }
           hull()
            {
            translate([LagerBockX-3,3,0])   cylinder(h=20,d=4,center=true);     
            translate([LagerBockX-6,3,0])   cylinder(h=20,d=4,center=true);     
            }
           hull()
            {
            translate([LagerBockX-3,3,0])   cylinder(h=3,d1=7,d2=4,center=true);        
            translate([LagerBockX-6,3,0])  cylinder(h=3,d1=7,d2=4,center=true);        
            }
            translate([-XPlatteB/2-0.5,XPlatteH/2-7-5,XPlatteD]) rotate([45,0,0]) cube([XPlatteB+1,7+0.5,5],center=false);  
            translate([-LagerBockX/2-0.5,-XPlatteH/2+7+5,XPlatteD]) rotate([45,0,0]) cube([LagerBockX+1,5,8],center=false);  
            translate([-XPlatteB/2-0.5,-20,XPlatteD]) rotate([45,0,0]) cube([XPlatteB+1,7.5,7.5],center=false);  
            translate([-XPlatteB/2-0.5,20,XPlatteD]) rotate([45,0,0]) cube([XPlatteB+1,7.5,7.5],center=false);  
           
            translate([ProbeBaseX/2-5,ProbeBaseY/2-20,-ProbeBaseZ]) cylinder(d=4,h=20,center=false);
            translate([ProbeBaseX/2-5,-ProbeBaseY/2+20,-ProbeBaseZ]) cylinder(d=4,h=20,center=false);
            translate([ProbeBaseX/2-5,ProbeBaseY/2-20,3]) cylinder(d=6.7,h=20,center=false,$fn=6);
            translate([ProbeBaseX/2-5,-ProbeBaseY/2+20,3]) cylinder(d=6.7,h=20,center=false,$fn=6);

            translate([-ProbeBaseX/2+5,ProbeBaseY/2-20,-ProbeBaseZ]) cylinder(d=4,h=20,center=false);
            translate([-ProbeBaseX/2+5,-ProbeBaseY/2+20,-ProbeBaseZ]) cylinder(d=4,h=20,center=false);
            translate([-ProbeBaseX/2+5,ProbeBaseY/2-20,3]) cylinder(d=6.7,h=20,center=false,$fn=6);
            translate([-ProbeBaseX/2+5,-ProbeBaseY/2+20,3]) cylinder(d=6.7,h=20,center=false,$fn=6);
          }
   }
}

module Alle()
{
    rotate([0,180,0])
    union()
   {
        ProbeBasis();    
        translate([-4,31,-2.5]) rotate([0,180,180]) color( "Gray",1.0 ) Stab();
        translate([-4,21,-22]) Oben();
        color( "Silver",1.0 ) XPlatte();
   }
}

Alle();
//XPlatte();
//ProbeBasis();
//Oben();
//Stab();
//Haube();

//rotate([0,180,0]) ProbeBasis(); // Nur fuer STL
//rotate([-90,0,0]) Haube();  // Nur fuer STL

