
// Welche Ansicht ?
part = "Vorschau"; //[Vorschau:Einzelteile,Druck:Teil zum Export -> STL]

// Schraubentoleranz 0.1 - 1.5mm
toleranz=1;//[1:15:]

// Länge des Distanzbolzen
laenge=19;//[11.0:50.0]

/* [Hidden] */
$fn=180;
Zusatz=toleranz/10;




module ring()
{
    difference()
    {
         cylinder(h=3,d=7.112,$fn=180);
         translate([0.767,0,-0.01]) cylinder(h=3.02,d=5,$fn=180);
    }
}

module M5()
{
    difference()
            {
                cylinder(h=4,d=8.63+Zusatz,$fn=6);
                translate([0,0,-0.01]) cylinder(h=4.02,d=5,$fn=180);
            }
}

module exccentricM5()
{
    union()
    {
    difference()
            {
                cylinder(h=6.35,d=9.3+Zusatz,$fn=6);
                translate([0.767,0,-0.01]) cylinder(h=6.37,d=5,$fn=180);
            }
            translate([0,0,6.35]) ring();
    }
}


module toprint()
{
difference()
{
    cylinder(h=laenge,d=15);
    translate([0,0,-0.01]) cylinder(h=laenge+0.02,d=5.3);   // Schraubenkanal
    translate([0,0,laenge-3.999]) M5(); // m5 Mutter
    if (part == "Vorschau")
{
    #rotate([180,0,180]) translate ([-0.767,0,-6.3499]) exccentricM5();
}
else if (part == "Druck")
{
    rotate([180,0,180]) translate ([-0.767,0,-6.3499]) exccentricM5();
}    

    
    
}
}

module preview()
{
     toprint();
    
     translate([20,0,0]) M5();
     translate([40,0,0]) exccentricM5();
     translate([60,0,0]) translate([0,0,-0.01]) cylinder(h=laenge+0.02,d=5.3);
    

}


if (part == "Vorschau")
{
 preview();
}
else if (part == "Druck")
{
    toprint();
}