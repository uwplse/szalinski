$fn=50;

AnzX=1; // Anzahl Spalten - Number of columns
AnzY=1; // Anzahl Zeilen - Number of lines

KL=100; // Kanallaenge - Channel length
KH=12; // Kanalhoehe  - Channel height
PB=20; // Profilbreite - Profile width
RD=6; // Rundung - Rounding
Nut=6; // Nut-Weite - Slot width
ND=3; // Nut-Dicke - Groove thickness
WS=1.2; //Wandstaerke - 

module DoIt()
{
    S=Nut+1.0;
    difference()
    {  
        union()
        {
            translate([PB/2-RD-WS/2,RD+WS/2,0]) cylinder(h=KL,d=RD*2+WS,center=false);
            translate([-PB/2+RD+WS/2,RD+WS/2,0]) cylinder(h=KL,d=RD*2+WS,center=false);
        }
        union()
        { 
            translate([PB/2-RD-WS/2,RD+WS/2,-1]) cylinder(h=KL+2,d=RD*2-WS,center=false);
            translate([-PB/2+RD+WS/2,RD+WS/2,-1]) cylinder(h=KL+2,d=RD*2-WS,center=false);
            translate([-PB/2+RD+WS/2,WS,-1]) cube([PB-RD*2-WS,RD,KL+2],center=false); 
            translate([-PB/2,WS+RD,-1]) cube([PB,RD,KL+2],center=false); 
        }
    }
    hull()
    {
        translate([-PB/2+RD+WS/2,WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([PB/2-RD-WS/2,WS/2,0]) cylinder(h=KL,d=WS,center=false);  
    }           
    hull()
    {
        translate([-PB/2+WS/2,RD+WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([-PB/2+WS/2,KH-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
    }           
    hull()
    {
        translate([PB/2-WS/2,RD+WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([PB/2-WS/2,KH-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
    } 
    hull()
    {
        translate([-PB/2+WS/2,KH-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([-S/2+WS/2,KH-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
    }           
    hull()
    {
        translate([PB/2-WS/2,KH-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([S/2-WS/2,KH-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
    } 
    hull()
    {
        translate([-S/2+WS/2,KH-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([-S/2+WS/2,KH+ND-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
    }           
    hull()
    {
        translate([S/2-WS/2,KH-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([S/2-WS/2,KH+ND-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
    } 
    hull()
    {
        translate([-S/2+WS/2,KH+ND-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([-Nut+WS,KH+ND-WS/2+0.5,0]) cylinder(h=KL,d=WS,center=false);  
    }           
    hull()
    {
        translate([S/2-WS/2,KH+ND-WS/2,0]) cylinder(h=KL,d=WS,center=false);  
        translate([Nut-WS,KH+ND-WS/2+0.5,0]) cylinder(h=KL,d=WS,center=false);  
    } 
}

for (i=[0:AnzX-1]) for (k=[0:AnzY-1]) translate([i*35,k*35-9,0]) DoIt(); 

