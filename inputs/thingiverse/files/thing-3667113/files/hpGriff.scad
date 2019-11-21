Laenge=100.0; // Laenge des Griffs - Length of the handle
Hoehe=28.0; // Hoehe des Griffs - Height of the handle
Breite=12.0; // Breite des Griffbogens - width of the grip arch
Tiefe=8.0; // Dicke des Griffbogens - Thickness of the grip arch
Radius=24.0; // Radius des Griffbogens - Radius of the handle arc
RD=3.0; // Kantenrundung - Edge rounding
BohrD=3.5; // Durchmesser der Befestigungsloecher - Diameter of mounting holes
BohrT=10.0; // Bohrtiefe der Befestigungsloecher - Drilling depth of the mounting holes

$fn=120;

module Bogen()
{
    intersection()
    {
       difference()
        {
            cylinder(r=Radius-RD,h=Tiefe-RD*2);        
            translate([0,0,0])  cylinder(r=Radius-Breite+RD,h=Tiefe-RD*2);
        }
       translate([-Radius,-Radius,0]) cube([Radius,Radius,Tiefe]); 
    }
}

module DoIt()
{
    difference()
    {
        minkowski()
        {
            union()
            {
                translate([-Laenge/2-(Breite-RD*2)/2,-(Tiefe-RD*2)/2,0]) cube([Breite-RD*2,Tiefe-RD*2,Hoehe-Radius]); 
                translate([Laenge/2-(Breite-RD*2)/2,-(Tiefe-RD*2)/2,0]) cube([Breite-RD*2,Tiefe-RD*2,Hoehe-Radius]); 
                
                color("lightblue") translate([-Laenge/2-Breite/2+Radius,-(Tiefe-RD*2)/2,Hoehe-Breite+RD]) cube([Laenge+Breite-Radius*2,Tiefe-RD*2,Breite-RD*2]); 
                translate([-Laenge/2-Breite/2+Radius,-(Tiefe-RD*2)/2,Hoehe-Radius]) rotate([-90,0,0]) Bogen();
                translate([Laenge/2+Breite/2-Radius,(Tiefe-RD*2)/2,Hoehe-Radius]) rotate([-90,0,-180]) Bogen();
            }
            sphere(r=RD);
        }
        translate([-Laenge,-Tiefe,-RD*2]) color("red") cube([Laenge*2,Tiefe*2,RD*2],center=false); 
        translate([-Laenge/2,0,-RD]) color("red") cylinder(d=BohrD,h=BohrT+RD);   
        translate([Laenge/2,0,-RD]) color("red") cylinder(d=BohrD,h=BohrT+RD);   
   }
}

DoIt();

 
  