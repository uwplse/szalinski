$fn=50;

DM=60; //Durchmesser Verteilerdose
radius=10; //"Biegeradius" der Klammer
laschenlaenge=30; //Laenge der Laschen
laschendicke=1.2; //Dicke der Laschen

translate([0,0,0])cylinder(r=DM/2+15,h=0.8);
translate([0,0,0])cylinder(r=2.5,h=2.8);
translate([0,0,2.8])cylinder(r1=2.5,r2=3,h=0.6);
translate([0,0,3.4])cylinder(r1=2.9,r2=2.9,h=0.6);

translate([0,DM,0]){
  klammerseite();
  mirror()klammerseite();
}
  
module klammerseite(){
  difference(){
    union(){
      translate([0,0,0])cube([DM/2-radius,laschendicke,10]);
      translate([0,laschendicke,0])cube([DM/2-radius,1,1]);
      translate([0,laschendicke,10-1])rotate([0,90,0])cylinder(r=laschendicke-0.2,h=DM/2-radius);
        difference(){
          translate([DM/2-radius,radius,0])cylinder(r=radius,h=10);
          translate([DM/2-radius,radius,-0.1])cylinder(r=radius-laschendicke,h=10.2);
          translate([DM/2-2*radius,laschendicke,-0.1])cube([radius,radius*2,10.2]);
          translate([DM/2-radius-0.1,radius,-0.1])cube([radius+2,radius+2,10.2]);
        }
        translate([DM/2-laschendicke,radius,0])cube([laschendicke,laschenlaenge,10]);
        translate([DM/2,radius+laschenlaenge,0])rotate([0,0,-140])cube([laschendicke,10,10]);
    }
    translate([-0.1,-0.1,2.5])cube([2.8,laschendicke+0.2,5]);
    translate([-0.1,-0.1,6.8])cube([9,laschendicke+0.2,0.7]);
  }
}