$fn=50;
//Zauberstab für Calliope mini (magic wand)
//by Olaf.Zelesnik@CJD-BS.de
difference(){
hull(){
cylinder(2,d=5,center);
translate([27,50,0]) cylinder(2,d=2,center);
translate([-27,50,0]) cylinder(2,d=2,center);
}
hull(){
translate([0,7,-0.1])cylinder(2.2,d=5,center);
translate([21,47,-0.1]) cylinder(2.2,d=2,center);
translate([-21,47,-0.1]) cylinder(2.2,d=2,center);
}}

cylinder(4.5,d=5,center);
translate([0,0,3.5]) cylinder(2,d=7,center);

translate([26.8,50,0]) cylinder(5,d=2.12,center);
translate([26.8,50,4.8]) cylinder(0.8,d=2.65,center);

translate([-26.8,50,0]) cylinder(5,d=2.12,center);
translate([-26.8,50,4.8]) cylinder(0.8,d=2.65,center);


//Steg
translate([0,-50.5,2.5])cube([5,100,5], center=true);
translate([0,-50.0,0.5])cube([6,102,1], center=true);
translate([0,-99.85,3])cube([28,1.7,4], center=true);
translate([0,-98.5,2.5])cube([12,2,5], center=true);
// translate([0,-42,3.4])cube([1.5,27.5,4], center=true);
// translate([0,-70,3.4])cube([1.5,26,4], center=true);
// translate([0,-13,3.4])cube([1.5,28,4], center=true);

rotate(a=-90, v=[0,0,1]) translate ([15,-2,4.4])linear_extrude(height=1.1) text("CALLIOPE mini     CJD BS", size=4);

//Baterienhalter
translate([0,-62,0]){
    difference(){    
        difference(){
        difference(){
            difference(){
                difference(){
                translate([0,-70,9])cube([29,66,18], center=true);
                translate([0,-70,0.6])cube([18,54,5], center=true);
            }
                translate([0,-70,12])cube([25.5,62.5,18], center=true);
            }
           translate([0,-68,12])cube([21,65.5,18], center=true); 
        }}
    // Höhenreduzierung
    translate([0,-70,20])cube([30,70,20], center=true);
}}

