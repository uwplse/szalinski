/* 
erstellt von Thomas Reincke, https://blog.5zu6.de

Nutzungsrechte und Haftungsausschluß

Die Dateien veröffentliche ich unter CC BY-SA 3.0 DE (Namensnennung – Weitergabe unter gleichen Bedingungen 3.0 Deutschland).

Darüber hinaus würde ich mich freuen, wenn bei der Verwendung in Modellen auf meine Urheberschaft hingewiesen würde. Ebenso würde ich mich über Kommentare mit Erfahrungsberichten oder Fotos über der Verwendung und Verfeinerung freuen.

Ich gebe keine Garantien hinsichtlich des Werks und übernimmt keinerlei Haftung für irgendwelche Nutzungen des Werks, soweit das gesetzlich möglich ist.

Vor der Fertigung oder Bestellung größerer Mengen empfehle ich den Probedruck eines einzelnen Exemplar und dessen sorgfältige Kontrolle.

Weitere Hinweise unter 
https://blog.5zu6.de/
*/

/* ********** */

// parametrisierbarer Technik-Rahmen

RahmenBreite    = 3;
RahmenLaenge    = 6;
QuerBohrungen   = 3; // <= RahmenBreite
LaengsBohrungen = 1; // <= InnenLaenge

InnenBreite     = 2; // <= RahmenBreite-1
InnenLaenge     = 2; // <= ObenAbstand-1 

ObenAbstand     = 5; // >= InnenLaenge+2 <= RahmenLaenge
ObenBreite      = 3; // >= RahmenBreite
ObenHoehe       = .5; // 0 - 0.5 oder 1


// Kalibrierung
SteinBreite   = 8.00;
SteinHoehe    = 9.60;
Luecke        = 0.10;
Luecken       = 2*Luecke;

AchsLaenge    = 4.90;//4.85;

FaseD         = 6.20; // Durchmesser der Bohrung um Technik-Loch
FaseT         = 0.85; // Tiefe der Fase

pi = 3.1415926536;
$fn = 36;


bre = RahmenBreite * SteinBreite - Luecken;
lae = RahmenLaenge * SteinBreite - Luecken;
hoe = SteinBreite  - Luecken;
il  = InnenLaenge  * SteinBreite + Luecken;
ib  = InnenBreite  * SteinBreite + Luecken;
oa  = ObenAbstand  * SteinBreite;
oh  = ObenHoehe    * SteinBreite;

module DrawGrundkoerper() {
  union() {
    // unten rund
    hull() {
      translate([-(RahmenBreite-1)*SteinBreite/2, -lae/2, 0])
      rotate([270,0,0])
      cylinder(d=SteinBreite-Luecken, h=lae);
    
      translate([(RahmenBreite-1)*SteinBreite/2, -lae/2, 0])
      rotate([270,0,0])
      cylinder(d=SteinBreite-Luecken, h=lae);
    };
    // unten Kasten
    translate([-bre/2, -(RahmenLaenge/2-.5)*SteinBreite, -(SteinBreite-Luecken)/2])
    cube([bre,(RahmenLaenge-1)*SteinBreite-Luecken,SteinBreite-Luecken ]);
    
    if (ObenBreite > 0) {
    // Aufsatz vorne
    hull() {
      translate([-(ObenBreite-1)*SteinBreite/2, -(ObenAbstand-1)*SteinBreite/2, 0])
      cylinder(d=SteinBreite - Luecken, h=(ObenHoehe+.5)*SteinBreite-Luecke);
    
      translate([(ObenBreite-1)*SteinBreite/2, -(ObenAbstand-1)*SteinBreite/2, 0])
      cylinder(d=SteinBreite - Luecken, h=(ObenHoehe+.5)*SteinBreite-Luecke);
    };  
  
    // Aufsatz hinten
    hull() {
      translate([-(ObenBreite-1)*SteinBreite/2, (ObenAbstand-1)*SteinBreite/2, 0])
      cylinder(d=SteinBreite - Luecken, h=(ObenHoehe+.5)*SteinBreite-Luecke);
    
      translate([(ObenBreite-1)*SteinBreite/2, (ObenAbstand-1)*SteinBreite/2, 0])
      cylinder(d=SteinBreite - Luecken, h=(ObenHoehe+.5)*SteinBreite-Luecke);
    }; 
  };
  };  
};

module DiffInnen() {
  translate([-ib/2, -il/2, -SteinBreite/2])
  cube([ib, il, SteinBreite]);
};

module DrawAbrundung() {
  difference() {
    hull() 
    {
      translate([0,0,SteinBreite/2-Luecken])
        cylinder(d=SteinBreite-Luecken, h=Luecke);
      translate([0,0,-SteinBreite/2+Luecke])
        cylinder(d=SteinBreite-Luecken, h=Luecke);
      translate([0,-SteinBreite/2+Luecken,0])
      rotate([90,0,0])
      cylinder(d=SteinBreite-Luecken, h=Luecke);
      translate([0,SteinBreite/2-Luecke,0])
      rotate([90,0,0])
      cylinder(d=SteinBreite-Luecken, h=Luecke);

      
      translate([-SteinBreite/2+Luecke,0,0])  rotate([0,90,0])
      cylinder(d=SteinBreite-Luecken, h=Luecke);

      translate([SteinBreite/2-Luecken,0,0])  rotate([0,90,0])
      cylinder(d=SteinBreite-Luecken, h=Luecke);
    };
  };  
};

module DrawAbrundungen() {
  translate([-(RahmenBreite-1)*SteinBreite/2,-(RahmenLaenge-1)*SteinBreite/2,0]) DrawAbrundung();

  translate([(RahmenBreite-1)*SteinBreite/2,-(RahmenLaenge-1)*SteinBreite/2,0]) rotate([0,0,90]) DrawAbrundung();

  translate([-(RahmenBreite-1)*SteinBreite/2,(RahmenLaenge-1)*SteinBreite/2,0]) rotate([0,0,270]) DrawAbrundung();

  translate([(RahmenBreite-1)*SteinBreite/2,(RahmenLaenge-1)*SteinBreite/2,0]) rotate([0,0,180]) DrawAbrundung();
};

module DiffGrundbohrungenX() {
  for(xx=[0:LaengsBohrungen-1]) {
    translate([-RahmenBreite*SteinBreite/2,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
    rotate([0,90,0])
    cylinder(d=AchsLaenge, h=RahmenBreite*SteinBreite);
  
    translate([-RahmenBreite*SteinBreite/2,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
    rotate([0,90,0])
    cylinder(d=FaseD, h=FaseT);
  
    translate([-(RahmenBreite-1)*SteinBreite/2-FaseT,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
    rotate([0,90,0])
    cylinder(d=FaseD, h=2*FaseT);
  
    translate([-(RahmenBreite-2)*SteinBreite/2-FaseT,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
    rotate([0,90,0])
    cylinder(d=FaseD, h=FaseT);
  
    translate([RahmenBreite*SteinBreite/2-FaseT,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
    rotate([0,90,0])
    cylinder(d=FaseD, h=FaseT);
  
    translate([(RahmenBreite-1)*SteinBreite/2-FaseT,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
    rotate([0,90,0])
    cylinder(d=FaseD, h=2*FaseT);
  
    translate([(RahmenBreite-2)*SteinBreite/2,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
    rotate([0,90,0])
    cylinder(d=FaseD, h=FaseT);
    
    if ((RahmenBreite-InnenBreite) > 2) {
      translate([InnenBreite*SteinBreite/2,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
      rotate([0,90,0])
      cylinder(d=FaseD, h=FaseT);       
  
      translate([-InnenBreite*SteinBreite/2-FaseT,(-LaengsBohrungen/2+0.5+xx)*SteinBreite,0])
      rotate([0,90,0])
      cylinder(d=FaseD, h=FaseT);
    };  
  };
};  

module DiffGrundbohrungenY() {
  difference() { 
    for(yy=[0:QuerBohrungen-1]) {
      translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite,-RahmenLaenge*SteinBreite/2,0])
      rotate([270,0,0]) 
      cylinder(d=AchsLaenge, h=RahmenLaenge*SteinBreite);

      translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite,-RahmenLaenge*SteinBreite/2,0]) 
      rotate([270,0,0]) 
      cylinder(d=FaseD, h=FaseT);

      translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite,-(RahmenLaenge-1)*SteinBreite/2-FaseT,0]) 
      rotate([270,0,0]) 
      cylinder(d=FaseD, h=FaseT);
      
      translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite,-(RahmenLaenge-2)*SteinBreite/2-FaseT,0]) 
      rotate([270,0,0]) 
      cylinder(d=FaseD, h=FaseT);


      translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite,RahmenLaenge*SteinBreite/2-FaseT,0])
      rotate([270,0,0])
    cylinder(d=FaseD, h=FaseT);
      
      translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite,(RahmenLaenge-1)*SteinBreite/2,0])
      rotate([270,0,0])
    cylinder(d=FaseD, h=FaseT);

      translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite,(RahmenLaenge-2)*SteinBreite/2,0])
      rotate([270,0,0])
    cylinder(d=FaseD, h=FaseT);

      if ((RahmenLaenge-InnenLaenge) > 2) {
        translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite, InnenLaenge*SteinBreite/2,0])
        rotate([270,0,0])
        cylinder(d=FaseD, h=FaseT);
        
        translate([(-QuerBohrungen/2+0.5+yy)*SteinBreite, -InnenLaenge*SteinBreite/2-FaseT,0])
        rotate([270,0,0])
        cylinder(d=FaseD, h=FaseT);        
      };   
    };
    if ((InnenLaenge > 0) && (InnenBreite > 0)) {
      translate([-bre/2,-il/2,-SteinHoehe/2]) cube([bre,il,SteinHoehe]);
    };
  };
};  


module DiffGrundbohrungenZ() {
  for(zz=[0:ObenBreite-1]) {  
    translate([-(ObenBreite/2-.5-zz)*SteinBreite, -(ObenAbstand-1)*SteinBreite/2, SteinBreite/2]) cylinder(d=AchsLaenge, h=SteinBreite);

    translate([-(ObenBreite/2-.5-zz)*SteinBreite, -(ObenAbstand-1)*SteinBreite/2, (ObenHoehe+.5)*SteinBreite-Luecke-FaseT]) cylinder(d=FaseD, h=FaseT);
    
    translate([-(ObenBreite/2-.5-zz)*SteinBreite, -(ObenAbstand-1)*SteinBreite/2, SteinBreite/2]) cylinder(d=FaseD, h=FaseT);
  };
  
  for(zz=[0:ObenBreite-1]) {  
    translate([-(ObenBreite/2-.5-zz)*SteinBreite, (ObenAbstand-1)*SteinBreite/2, SteinBreite/2])
    cylinder(d=AchsLaenge, h=SteinBreite);

    translate([-(ObenBreite/2-.5-zz)*SteinBreite, (ObenAbstand-1)*SteinBreite/2, (ObenHoehe+.5)*SteinBreite-Luecke-FaseT]) cylinder(d=FaseD, h=FaseT);
    
    translate([-(ObenBreite/2-.5-zz)*SteinBreite, (ObenAbstand-1)*SteinBreite/2, SteinBreite/2]) cylinder(d=FaseD, h=FaseT);
  };
};  


module Rahmen() {
  difference() {
    union() {
      DrawGrundkoerper(); 
      DrawAbrundungen();  
    }; 
    if ((InnenLaenge > 0) && (InnenBreite > 0)) { DiffInnen(); };
    DiffGrundbohrungenX();
    if (QuerBohrungen > 0) DiffGrundbohrungenY(); 
    if (ObenBreite > 0) DiffGrundbohrungenZ();    
  }; 
};

Rahmen();