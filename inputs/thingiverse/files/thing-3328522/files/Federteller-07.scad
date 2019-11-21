
// Hight Cone; Hoehe des Kegels
h=6;
// Outer radius of cone, Aeusserer Kegelradius
R1=9.0;
// Radius piston rod; Radius der Kolbenstange
r=1.75;
// Radius blindhole for rod end; Radius des Sackloches fuer Kugelgelenkschaft
g=3.1;
// Depth of blindhole fpr rod end; Tiefe des Sackloches fuer Kugelgelenkschaft
d=4.9;
// Hight of springholder; Hoehe des Halterings
h1=2.8;
// Outer radius springholder; Aussenradius des Halterings
k=7.6;
// Inner radius springholder; Innenradius des Halterings
j=6.4;
// Number of Fragments; Grad der "Kantigkeit"
x=90;
// Cut - off the top, Schneidet die Kegelspitze ab
z=1.4;

difference(){
    union(){
                                cylinder(h,g,R1, center, $fn=x ); //grosser, aeusserer Kegel
       translate([0,0,h])       cylinder(h1,k,k+0.2,center, $fn=x); //Haltering fuer Feder
            }
            
            //Ab hier wird subtrahiert
hull(){ translate([-0.2,0,-1])     cylinder(h+99,r,r,center, $fn=x); //Schlitz fuer Kolbenstange
        translate([15,0,-1])     cylinder(h+2,r,r,center, $fn=x);
}
translate([0,0,-1])     cylinder(d+1,g,g,center, $fn=x); //Aussparung fuer Augenschraube
  translate([0,0,h])     cylinder(h1+0.02,j,j+0.4,center, $fn=x); //Aussparung fuer Daempferkoerper
  translate([0,0,0])     cylinder(z,R1,R1,center, $fn=x); //Spitze abschneiden
}

