//DATI

xrb=65;
yrb=54;
zrb=30;
x3d=66.48;
y3d=113.60;
z3d=50;
xal=38.30;
yal=199;
zal=98;


//MODULI

module Alimentatore(){
  cube([xal,yal,zal], center=true);  
                     }
module schedaDRAG(){
  cube([x3d,y3d,z3d], center=true);  
                    }  
                    
module raspy(){
  cube([xrb,yrb,zrb], center=true);  
               }    

module foro(){
  cylinder(h=30,r=1.6,$fn=100, center=true);  
               }                                   
               


//MODELLO
union(){
difference(){
translate([0,0,-(zal/2+5)])cylinder(h=30,r1=100,r2=50,$fn=100);
    Alimentatore();
translate([xal/2+40,0,-10])rotate([0,90,0])schedaDRAG();
translate([-(xal/2+40),0,-10])rotate([0,90,0])schedaDRAG();
    hull(){
    translate([0,yal/2-15,0])cylinder(h=200, r=1.8, $fn=100, center=true);
    translate([-15,yal/2-15,0])cylinder(h=200, r=1.8, $fn=100, center=true);
        }
    hull(){    
    translate([0,yal/2-15,-(zal/2+6)])cylinder(h=10, r=7, $fn=100, center=true);
    translate([-15,yal/2-15,-(zal/2+6)])cylinder(h=10, r=7, $fn=100, center=true);
        }
}
difference(){
translate([xal/2+12.5,0,10])rotate([0,0,0])cube([5,y3d,z3d+60], center=true);
        hull(){
        translate([xal/2+10,y3d/2-4,30])rotate([0,90,0])foro();
        translate([xal/2+10,y3d/2-8,30])rotate([0,90,0])foro();
}
        hull(){
        translate([xal/2+10,-(y3d/2-4),30])rotate([0,90,0])foro();
        translate([xal/2+10,-(y3d/2-8),30])rotate([0,90,0])foro();
        }
        hull(){
        translate([xal/2+10,y3d/2-5,60])rotate([0,90,0])foro();
        translate([xal/2+10,-(y3d/2-5),60])rotate([0,90,0])foro();
               }
        hull(){
        translate([xal/2+10,-(y3d/2-4),30-47.5])rotate([0,90,0])foro();
        translate([xal/2+10,-(y3d/2-8),30-47.5])rotate([0,90,0])foro();
        }
        hull(){
        translate([xal/2+10,y3d/2-4,30-47.5])rotate([0,90,0])foro();
        translate([xal/2+10,y3d/2-8,30-47.5])rotate([0,90,0])foro();
        }        
               
         }
}
difference(){
translate([-(xal/2+12.5),0,10])rotate([0,0,0])cube([5,y3d,z3d+60], center=true);

     hull(){
        translate([-(xal/2+21),yrb/2-5,2])rotate([0,90,0])foro();
        translate([-(xal/2+21),yrb/2-10,2])rotate([0,90,0])foro();
           }
           
     hull(){
        translate([-(xal/2+21),-(yrb/2-5),2])rotate([0,90,0])foro();
        translate([-(xal/2+21),-(yrb/2-10),2])rotate([0,90,0])foro();
        }
        
        hull(){
        translate([-(xal/2+10),y3d/2-5,60])rotate([0,90,0])foro();
        translate([-(xal/2+10),-(y3d/2-5),60])rotate([0,90,0])foro();
               }
       //FORI NEW        
      hull(){
        #translate([-(xal/2+21),20+xrb/2-3,20])rotate([0,90,0])foro();
        #translate([-(xal/2+21),20+xrb/2-10,20])rotate([0,90,0])foro();
           }
           
     hull(){
        #translate([-(xal/2+21),-(xrb/2-3)+20,20])rotate([0,90,0])foro();
        #translate([-(xal/2+21),-(xrb/2-10)+20,20])rotate([0,90,0])foro();
        }
}
