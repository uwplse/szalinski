$fn=100;

// Nennweite 1
nw1=150; 

// Nennweite 2
nw2=100;

// Drucktoleranz
tol=1;

// Länge des Randes
rand=25;

// Verlängerung wegen Zusammenstossen
ausgleich=3;

// Winkel des Anschlusstücks 
winkel=45; //[10:90]

// Materialstärke
staerke=2.08;

// Wulststärke
wulst=5;

// Wulsthöhe
wulsth=10;

// Unten als Flansch
flansch=true;

h1=nw2/sin(winkel);
h2=h1*cos(winkel);

difference() {
    union() {
            translate([0,0,-rand]) cylinder(d=nw1-tol,h=h1+2*rand+ausgleich);
        hull() {
            translate([0,0,0]) cylinder(d=nw1-tol,h=h1);
            translate([0,(-nw1+tol)/2,0]) rotate([winkel,0,0]) translate([0,nw2/2,0]) cylinder(d=nw2-tol,h=1);
        }
         
        translate([0,(-nw1+tol)/2,0]) rotate([winkel,0,0]) translate([0,nw2/2,0]) 
       {   cylinder(d=nw2-tol,h=h2+rand+ausgleich);
           translate([0,0,h2-wulsth/2+ausgleich]) rotate_extrude() translate([nw2/2,0,0])  polygon( points=[[0,0],[wulst/2,wulsth/2],[0,wulsth]] );
       }
       if (!flansch) translate([0,0,-wulsth/2]) rotate_extrude() translate([nw1/2,0,0]) polygon( points=[[0,0],[wulst/2,wulsth/2],[0,wulsth]] );
       else { 
           translate([0,0,-rand]) cylinder(d=nw1+3*staerke,h=rand-staerke);
           translate([0,0,-staerke]) cylinder(d1=nw1+3*staerke,d2=nw1-tol,h=2*staerke);
       }
           
       translate([0,0,h1-wulsth/2+ausgleich]) rotate_extrude() translate([nw1/2,0,0]) polygon( points=[[0,0],[wulst/2,wulsth/2],[0,wulsth]] );
    }
    translate([0,0,-rand]) cylinder(d=nw1-tol-2*staerke,h=h1+2*rand+ausgleich);
        translate([0,-nw1/2,0]) rotate([winkel,0,0]) translate([0,nw2/2,0])        cylinder(d=nw2-tol-2*staerke,h=h2+rand+ausgleich);
    hull() {
        translate([0,0,0]) cylinder(d=nw1-tol-2*staerke,h=h1);
        translate([0,-nw1/2,0]) rotate([winkel,0,0]) translate([0,nw2/2,0])        cylinder(d=nw2-tol-2*staerke,h=1);
    }

    if (flansch) {
        translate([0,0,-rand]) cylinder(d=nw1+tol,h=rand-staerke);
        translate([0,0,-staerke]) cylinder(d1=nw1+tol,d2=nw1+tol-2*staerke,h=2*staerke);
    }

}



