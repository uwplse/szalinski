//Konfiguration
//Radius
    r = 31;
//Höhe des Kuchens
    h = 22;
//Anzahl der Stücke (gerade Zahl)
    n = 6;
    
module Schnitt (b = 0.4, l = 2*r+2)
    translate([0, 0, 0])
    for (i = [0:n-1]) {
        rotate(i*360/n)
        square([b, l], true);
    }

module Kuchen ()
    linear_extrude(height = h)
    difference(){
        circle(r, true);
        Schnitt();   
}

Kuchen ();