// 0 : 3D, 1 : sheet to cut in MDF 6mm, 2 : print twice
vue=0;
$fn=100;
module roulement_608(){
    difference(){
        cylinder(d=22,h=7);
        cylinder(d=8,h=7);
    }
}
module cone3D_printed(){
 difference(){
     cylinder(d1=60,d2=20,h=22);
     translate([0,0,-5]) cylinder(h=40,d=10);
     translate([0,0,-1]) cylinder(h=8,d=22);
     translate([0,0,-1]) cylinder(h=12,d=20);
 }
 }

module pion(){
    square([3,18]);
}

module cote1(){
difference(){
      translate([45.6,0]) circle(d=182,$fn=3);
      translate([0,-50]) square([10,6]);
      translate([0,44]) square([10,6]);
      translate([118,-12]) square([25,25]);
      translate([118,0]) circle(d=8);
      translate([121,0]) circle(d=10);
      translate([110,-3]) square([3,6]);
      translate([45.6,0]) circle(d=54);
}
}
module cote2(){
    difference(){
       square([180,20]);
       translate([164,0]) square([6,10]);
       translate([10,0]) square([6,10]);
       // a virer dans le  cas general
       //translate([139,10]) square([6,10]);
       //translate([35,10]) square([6,10]); 
    }
}
module support(){
    difference(){
       circle(d=20);
       circle(d=8);
       translate([-10,0]) square(20);
       translate([3,-8]) rotate([0,0,90]) square([3,6]);
    } 
    
}

  module bloqueur(){
  difference(){
    
     circle(d=20)  ;
     circle(d=7.9)  ;
    translate([-0.75,3]) square([1.5,13]);  
      
    translate([2.5,5.4]) square([1.5,2.5]); 
    translate([-3.5,5.4]) square([1.5,2.5]);   
  }
}  

module bloqueur_3D(){
    color("red") rotate([0,-90,0]) linear_extrude(6) bloqueur();
}
module cote1_3D(){
    color("blue") rotate([0,-90,0]) linear_extrude(6) cote1();
}
module cote2_3D(){
    color("red")  rotate([-90,0,0]) linear_extrude(6) cote2();
}
module support_3D(){
     rotate([90,0,90]) linear_extrude(6) support();
}
module pion_3D(){
    color("pink") rotate([0,-90,90]) linear_extrude(6) pion();
}


if (vue==0) {
    translate([-16,44,20]) cote2_3D();
    translate([-16,-50,20]) cote2_3D();
    cote1_3D();
    translate([154,0,0]) cote1_3D();
    translate([-12,0,118]) support_3D();
    translate([0,0,118]) support_3D();
    translate([6,3,110]) pion_3D();
    translate([154,0,118]) support_3D();
    translate([142,0,118]) support_3D();
    translate([160,3,110]) pion_3D();
    translate([-20,0,118]) rotate([0,90,0]) color("gray") cylinder(d=8,190);
    translate([30,0,118]) rotate([0,90,0])  color("lightgray") roulement_608();
    translate([30,0,118]) rotate([0,90,0]) cone3D_printed();
     translate([120,0,118]) rotate([0,90,180]) cone3D_printed();
     translate([113,0,118]) rotate([0,90,0])  color("lightgray") roulement_608();
     translate([-12,0,118]) bloqueur_3D();
     translate([30,0,118]) bloqueur_3D();
     translate([126,0,118]) bloqueur_3D();
     translate([166,0,118]) bloqueur_3D();
    }
if (vue==1)
   {
    translate([0,80]) cote1();
    translate([120,190]) rotate([0,0,180]) cote1();  
    translate([130,185]) rotate([0,0,-90]) cote2();  
    translate([160,185]) rotate([0,0,-90]) cote2();
    translate([50,70]) support();   
    translate([31,80]) support();    
    translate([51,81]) support();   
    translate([57,92]) support();    
    translate([55,180]) pion();   
    translate([60,180]) pion();
    translate([36,91]) bloqueur();   
    translate([73,176]) bloqueur(); 
    translate([71,204]) bloqueur();   
    translate([88,190]) bloqueur();    
   }
 if (vue==2)  
 { cone3D_printed(); }
