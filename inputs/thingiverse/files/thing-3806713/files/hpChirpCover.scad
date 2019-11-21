DoIt=3; // 0=Deckel und Boden zusammen, 1=Deckel, 2=Boden, 3=Deckel und Boden getrennt
RDA=2.0; // Rundung Aussen
YA=23.0; // Y Aussen
XA=55.0; // X Aussen
XAU=5.0; // X Aussen Unten
ZA=17.3; // Z Aussen
WDY=4.3; // Wanddicke Y
WDZ=1.7; // Wanddicke Z
Clip=true; // Halteclip ja/nein
RDI=RDA-0.5; // Rundung Innen
YI=YA-WDY*2; // Y Innen
XI=XA+RDA;  // X Innen
ZI=ZA-WDZ*2; // Z Innen
ZP=2.0; // Dicke Platine
YP=16.5; // Breite Platine
ZB=4.5; // Batterie
XB=17.0; // Batterie
YB=20.5; // Batterie
XL=9.0;
D1L=2.5; // Lautsprecher
D2L=7.0;
D3L=9.0;
D4L=11.0;
XS=4.0; // Schalter
D1S=2.5;
D2S=5.0;
D3S=6.0;
D4S=8.0;

$fn=120;

module Deckel() 
{
   difference() 
    {
    union()
        {
            hull()
            {
                translate([-XA/2+RDA,-YA/2+RDA,-ZA/2+RDA]) sphere(RDA);            
                translate([XA/2-RDA,-YA/2+RDA,-ZA/2+RDA]) sphere(RDA);            
                translate([-XA/2+RDA,+YA/2-RDA,-ZA/2+RDA]) sphere(RDA);            
                translate([XA/2-RDA,+YA/2-RDA,-ZA/2+RDA]) sphere(RDA);            
                 translate([-XA/2+RDA,-YA/2+RDA,+ZA/2-RDA]) sphere(RDA);            
                translate([XA/2-RDA,-YA/2+RDA,+ZA/2-RDA]) sphere(RDA);            
                translate([-XA/2+RDA,+YA/2-RDA,+ZA/2-RDA]) sphere(RDA);            
                translate([XA/2-RDA,+YA/2-RDA,+ZA/2-RDA]) sphere(RDA);            
                translate([XA/2-RDA+10,+YA/2-RDA,-ZA/2+RDA]) sphere(RDA);            
                 translate([XA/2-RDA+10,-YA/2+RDA,-ZA/2+RDA]) sphere(RDA);            
            }
             translate([+XI/2-RDI-2-XL,0,ZI/2+0.5]) cylinder(h=3,d1=D4L,d2=D3L,center=false); // Summer, Lautsprecher
             translate([+XI/2-RDI-2-XS,0,-ZA/2-2.0]) cylinder(h=3,d1=D3S,d2=D4S,center=false); // Schalter
             translate([+XI/2-RDI-2-XS,0,-ZA/2-2.0]) cylinder(h=3,d1=D1S,d2=D2S,center=false); // Schalter
      }   
        union()
        {
            minkowski()
            {
                union()
                {
                    translate([-XI/2+RDI-2,-YI/2+RDI,-ZI/2+RDI]) cube([XI-RDI*2,YI-RDI*2,ZI-RDI*2]); 
                }
                sphere(r=RDI);
            }
            translate([-XI/2+RDI-2,-YP/2,-ZP]) cube([XI-RDI*2,YP,ZP]);  // Leiterplattenfuehrung
            translate([-XI/2+RDI-2-XB,-YB/2,0]) cube([XI-RDI*2,YB,ZB]);  // Batterieueberstand
            translate([+XI/2-RDI-2-XL,0,ZI/2-RDI]) cylinder(h=4,d=D1L,center=false);  // Lautsprecher
            translate([+XI/2-RDI-2-XL,0,ZI/2+0.5]) cylinder(h=4,d1=D1L,d2=D2L,center=false);  // Lautsprecher
            translate([+XI/2-RDI-2-XS,0,-ZA/2-4]) cylinder(h=10,d=D1S,center=false);  // Schalter
            translate([+XI/2-RDI-2-XS,0,-ZA/2+1.0]) cylinder(h=2,d=D2S,center=false);  // Schalter
            translate([+XI/2-RDI-2-XS,0,-ZA/2-3.0]) cylinder(h=2,d2=D1S,d1=D2S,center=false); // Schalter
            translate([-XI/2,-YA,-ZA]) cube([RDA+1,YA*2,ZA*2]);  // Unten ohne Rundung
            if (Clip) {translate([-XI/2+11,0,0]) cube([3.2,5.5,ZA*2],center=true); }  // ggf Loch fuer Clip
        }
   } 
}

module Boden()
{
    difference() 
    {
        union()
        {
            hull()
            {
                translate([0,-YA/2+RDA,-ZA/2+RDA]) rotate([0,90,0]) cylinder(h=XAU,r=RDA,center=false);            
                translate([0,+YA/2-RDA,-ZA/2+RDA]) rotate([0,90,0]) cylinder(h=XAU,r=RDA,center=false);         
                translate([0,-YA/2+RDA,+ZA/2-RDA]) rotate([0,90,0]) cylinder(h=XAU,r=RDA,center=false);         
                translate([0,-YA/2+RDA,+ZA/2-RDA]) rotate([0,90,0]) cylinder(h=XAU,r=RDA,center=false);        
                translate([0,+YA/2-RDA,+ZA/2-RDA]) rotate([0,90,0]) cylinder(h=XAU,r=RDA,center=false);            
                translate([-15,+YA/2-RDA,-1]) rotate([0,90,0]) cylinder(h=1,r=RDA,center=false);        
                 translate([-15,-YA/2+RDA,-1]) rotate([0,90,0]) cylinder(h=1,r=RDA,center=false);        
           }
            minkowski()
            {
                 translate([0,-YI/2+RDI,-ZI/2+RDI]) cube([15,YI-RDI*2,ZI-RDI*2]); 
                 sphere(r=RDI);
            }
            if (Clip) {translate([XAU/2+10,0,0]) cube([3.0,5.0,ZA-1],center=true);}  
        }   
        union()
        {
            translate([15,-YA,-ZA]) cube([RDI+1,YA*2,ZA*2]);  
            translate([-XI/2+RDI-2,-YP/2,-ZP]) cube([XI-RDI*2,YP,ZP]);  // Leiterplattenfuehrung
            translate([8,-YI/2,-ZI/2]) cube([8,RDI,RDI]);         
            translate([8,+YI/2-RDI,-ZI/2]) cube([8,RDI,RDI]);         
            translate([8,-YI/2,ZI/2-RDI]) cube([8,RDI,RDI]);         
            translate([8,+YI/2-RDI,ZI/2-RDI]) cube([8,RDI,RDI]);  
            if (Clip)
            {
                translate([XAU/2+8.6,0,+ZA/2+2.9]) rotate([0,20,0]) cube([3.0,10.0,ZA/2],center=true);  
                translate([XAU/2+11.4,0,+ZA/2+2.9]) rotate([0,-20,0]) cube([3.0,10.0,ZA/2],center=true); 
                rotate([180,0,0]) translate([XAU/2+8.6,0,+ZA/2+2.9]) rotate([0,20,0]) cube([3.0,10.0,ZA/2],center=true);  
                rotate([180,0,0]) translate([XAU/2+11.4,0,+ZA/2+2.9]) rotate([0,-20,0]) cube([3.0,10.0,ZA/2],center=true);
            }  
            minkowski()
            {
                 translate([0,-YI/2+RDI,-ZI/2+RDI]) cube([15,YI-RDI*2,ZI-RDI*2]); 
                 sphere(r=RDI-1);
            }
        }
     }
}

module DeckelBoden()
{
color("lightblue",1) Deckel();
translate([-30,0,0]) color("lightgreen",1) Boden();
}

module DeckelBodenA()
{
color("lightblue",1) Deckel();
translate([-45,0,0]) color("lightgreen",1) Boden();
}

if (DoIt==0) {DeckelBoden();} 
else if (DoIt==1) {rotate([0,-90,0]) Deckel();} 
else if (DoIt==2) {rotate([0,-90,0]) Boden();}
else {DeckelBodenA();}

    
